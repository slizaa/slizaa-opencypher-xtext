/*
 * generated by Xtext 2.10.0
 */
package org.slizaa.neo4j.opencypher.scoping

import java.util.ArrayList
import java.util.List
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.xtext.scoping.Scopes
import org.slizaa.neo4j.opencypher.openCypher.All
import org.slizaa.neo4j.opencypher.openCypher.Any
import org.slizaa.neo4j.opencypher.openCypher.BulkImportQuery
import org.slizaa.neo4j.opencypher.openCypher.Clause
import org.slizaa.neo4j.opencypher.openCypher.Command
import org.slizaa.neo4j.opencypher.openCypher.Expression
import org.slizaa.neo4j.opencypher.openCypher.Extract
import org.slizaa.neo4j.opencypher.openCypher.Filter
import org.slizaa.neo4j.opencypher.openCypher.Foreach
import org.slizaa.neo4j.opencypher.openCypher.ListComprehension
import org.slizaa.neo4j.opencypher.openCypher.Match
import org.slizaa.neo4j.opencypher.openCypher.None
import org.slizaa.neo4j.opencypher.openCypher.OpenCypherPackage
import org.slizaa.neo4j.opencypher.openCypher.Order
import org.slizaa.neo4j.opencypher.openCypher.Reduce
import org.slizaa.neo4j.opencypher.openCypher.RegularQuery
import org.slizaa.neo4j.opencypher.openCypher.Return
import org.slizaa.neo4j.opencypher.openCypher.Single
import org.slizaa.neo4j.opencypher.openCypher.SingleQuery
import org.slizaa.neo4j.opencypher.openCypher.Statement
import org.slizaa.neo4j.opencypher.openCypher.Unwind
import org.slizaa.neo4j.opencypher.openCypher.VariableDeclaration
import org.slizaa.neo4j.opencypher.openCypher.VariableRef
import org.slizaa.neo4j.opencypher.openCypher.Where
import org.slizaa.neo4j.opencypher.openCypher.With
import org.slizaa.neo4j.opencypher.openCypher.PatternComprehension
import org.slizaa.neo4j.opencypher.openCypher.MergeAction

/**
 * Scope provider for the openCypher grammar. There are multiple ways to declare a variable in openCypher.
 * 
 * <ol>
 * <li>{@link Clause}s: {@link OpenCypherScopeProvider#extractDeclarationsFromClauses(EObject)}</li>
 * <li>{@link Expression}s: {@link OpenCypherScopeProvider#extractDeclarationsFromExpression(EObject)}</li>
 * <li>{@link Foreach}: {@link OpenCypherScopeProvider#extractDeclarationsFromForeach(EObject)}</li> 
 * </ol>
 */
class OpenCypherScopeProvider extends AbstractOpenCypherScopeProvider {

	override getScope(EObject context, EReference reference) {
		if (context instanceof VariableRef && reference === OpenCypherPackage.eINSTANCE.variableRef_VariableRef) {
			val elementsFromStatement = context.extractDeclarationsFromClauses
			val elementsFromExpression = context.extractDeclarationsFromExpression
			val elementsFromForeach = context.extractDeclarationsFromForeach

			return Scopes.scopeFor(elementsFromExpression + elementsFromForeach + elementsFromStatement)
		}

		return super.getScope(context, reference)
	}

	/**
	 * (1) The following {@link Clause}s introduce new {@link VariableDeclaration}s:
	 * 
	 * <ul>
	 * <li>{@link Match}: this clause can introduce new variables for nodes/relationships,
	 * e.g. {@code MATCH (p:Person)-[l:LIVES_IN]->(c:City), (p)-[:VISITED]->(:Monument)}.
	 * Note that only the first occurrence counts as declaration, the rest are references.</li>
	 * <li>{@link Unwind}: this clause specifies an (obligatory) alias for the unwound collection elements,
	 * e.g. {@code UNWIND xs AS x}</li>
	 * <li>{@link With}: this clause passes through some variables and (optionally) assigns aliases, 
	 * e.g. {@code WITH p AS p2, p.name AS name, p.age*2 AS a2}</li>
	 * <li>{@link Return}: for introducing variables, this clause behaves as WITH clause, 
	 * e.g. {@code RETURN p AS p2, p.name AS name, p.age*2 AS a2}</li>
	 * </ul>
	 *  
	 * The basic approach for scoping these is relatively straightforward: for a {@link VariableRef},
	 * the corresponding {@link VariableDeclaration} is the one first found when traversing
	 * the clauses of the {@link SingleQuery} (i.e. a {@code [MATCH [WHERE]|WITH [WHERE]|UNWIND]* RETURN}) 
	 * that contains the clause that contains the reference. For example, the following query has 
	 * two single queries in lines 1-4 and 6-9.
	 * 
	 * <pre>
	 * 1 MATCH (p1:Person)-[:LIVES_IN]->(c:City)
	 * 2 WHERE p1.name = 'Alice'
	 * 3 WITH p1 AS p, c.language AS lang, c.name AS name
	 * 4 RETURN p, lang, name
	 * 5 UNION
	 * 6 MATCH (p)-[:VISITED]->(c:Country)
	 * 7 WHERE p.age > 25
	 * 8 UNWIND p.languages AS lang
	 * 9 RETURN p, lang, c.name AS name
	 * </pre>
	 * 
	 * Note that the {@code ORDER BY} clause needs special treatment. This clause always follows either 
	 * a {@code WITH} or a {@code RETURN} clause and its scope includes both
	 * 
	 * <ul>
	 * <li>variables of the scope before {@code WITH}/{@code RETURN} clause and</li>
	 * <li>the variables introduced in the {@code WITH}/{@code RETURN} clause.</li>
	 * </ul>
	 * 
	 * This example demonstrates this query:
	 * 
	 * <pre>
	 * 1 MATCH (p:Person)-[l:LIVES_IN]->(c:City)
	 * 2 RETURN p, c.name AS cityName
	 * 3 ORDER BY l.since, cityName
	 * </pre>
	 */
	protected def Iterable<VariableDeclaration> extractDeclarationsFromClauses(EObject context) {
		// get the outermost Statement container
		val statement = EcoreUtil2.getAllContainers(context).filter(Statement).last
		return extractDeclarationsFromStatement(statement, context)
	}

	protected def dispatch Iterable<VariableDeclaration> extractDeclarationsFromStatement(RegularQuery regularQuery,
		EObject context) {
		val contextClause = EcoreUtil2.getContainerOfType(context, Clause)
		val clauses = EcoreUtil2.getContainerOfType(contextClause, SingleQuery).clauses
		return extractDeclarationsFromClauseList(clauses, contextClause, context)
	}

	protected def dispatch Iterable<VariableDeclaration> extractDeclarationsFromStatement(
		BulkImportQuery bulkImportQuery, EObject context) {
		val contextClause = EcoreUtil2.getContainerOfType(context, Clause)
		return extractDeclarationsFromClauseList(bulkImportQuery.loadCSVQuery.clauses, contextClause, context)
	}

	protected def dispatch Iterable<VariableDeclaration> extractDeclarationsFromStatement(Command command,
		EObject context) {
		val elements = EcoreUtil2.getAllContentsOfType(command, VariableDeclaration)
		return elements
	}

	protected def Iterable<VariableDeclaration> extractDeclarationsFromClauseList(EList<Clause> clauses,
		Clause contextClause, EObject context) {
		val List<VariableDeclaration> elements = new ArrayList
		val mergeAction = EcoreUtil2.getContainerOfType(context, MergeAction)
		val currentClause = if (mergeAction !== null) {
			EcoreUtil2.getContainerOfType(mergeAction, Clause)
		} else {
			contextClause
		}
		val offset = if (contextClause instanceof Unwind) {
				-1
			} else if (currentClause instanceof With || currentClause instanceof Return) {
				val order = EcoreUtil2.getContainerOfType(context, Order)
				val where = EcoreUtil2.getContainerOfType(context, Where)
				if (order !== null || where !== null) {
					// (1) if the context is an ORDER BY clause, start from the current clause,
					// as ORDER BY is tied to a WITH/RETURN clause and it can use VariableDeclarations 
					// introduced by the current WITH/RETURN clause
					// (2) if the context is a WHERE clause, start from the current clause,
					// as WHERE is tied to a MATCH/WITH clause
					0
				} else {
					// If the context is not an ORDER BY clause and not a WHERE clause,
					// start from the previous clause. This guarantees that for return items
					// like the ones in 'WITH x AS y, y AS z', the scope provider does not return
					// VariableDeclaration `y` (in `x AS y`) when looking for a resolution of
					// VariableReference `y` (in `y AS z`)
					-1
				}
			} else {
				0
			}
		val startClauseIndex = clauses.indexOf(currentClause) + offset

		for (var i = startClauseIndex; i >= 0; i--) {
			val clause = clauses.get(i)
			val declarations = EcoreUtil2.getAllContentsOfType(clause, VariableDeclaration)
			elements += declarations.filter[!elements.map[name].contains(name)]
		}
		return elements
	}

	/**
	 * (2) {@link Expression} operating on lists introduce new {@link VariableDeclaration}s.
	 * 
	 * <ul>
	 * <li>{@link ListComprehension}: {@code [variable IN list (WHERE predicate)? | expression]}</li>
	 * <li>{@link PatternComprehension}: {@code [(pathVariable = )? pattern (WHERE predicate)? | expression]}
	 * (variables can be declared in the pattern)</li>
	 * <li>{@link Extract} function: {@code extract(variable IN list | expression)}</li>
	 * <li>{@link Filter} function: {@code filter(variable IN list WHERE predicate)}</li>
	 * <li>{@link All} function: {@code all(variable IN list WHERE predicate)}</li>
	 * <li>{@link Any} function: {@code any(variable IN list WHERE predicate)}</li>
	 * <li>{@link None} function: {@code none(variable IN list WHERE predicate)}</li>
	 * <li>{@link Single} function: {@code single(variable IN list WHERE predicate)}</li>
	 * <li>{@link Reduce} function: {@code reduce(accumulator = initial, variable IN list | expression)}
	 * (declares the variable that iterates throught the list and also the accumulator)</li>
	 * </ul>
	 */
	protected def Iterable<VariableDeclaration> extractDeclarationsFromExpression(EObject context) {
		val expression = EcoreUtil2.getContainerOfType(context.eContainer, Expression)
		if (expression === null) {
			return #[]
		}

		val declarations = expression.extractDeclarationsFromSingleExpression

		val outerExpressions = EcoreUtil2.getAllContainers(expression).filter(Expression)
		val outerDeclarations = outerExpressions.map[extractDeclarationsFromSingleExpression].flatten

		return declarations + outerDeclarations
	}

	protected def Iterable<VariableDeclaration> extractDeclarationsFromSingleExpression(Expression expression) {
		val filterExpression = extractFilterExpression(expression)

		if (filterExpression !== null) {
			#[filterExpression.idInColl.variable]
		} else if (expression instanceof Reduce) {
			#[expression.accumulator, expression.idInColl.variable]
		} else if (expression instanceof PatternComprehension) {
			val pathVariable = if (expression.pathVariable === null) #[] else #[expression.pathVariable]
			val patternVariables = EcoreUtil2.getAllContentsOfType(expression.pattern, VariableDeclaration)
			pathVariable + patternVariables
		} else {
			#[]
		}
	}

	protected def dispatch extractFilterExpression(ListComprehension e) { e.filterExpression }

	protected def dispatch extractFilterExpression(Extract e) { e.filterExpression }

	protected def dispatch extractFilterExpression(Filter e) { e.filterExpression }

	protected def dispatch extractFilterExpression(All e) { e.filterExpression }

	protected def dispatch extractFilterExpression(Any e) { e.filterExpression }

	protected def dispatch extractFilterExpression(None e) { e.filterExpression }

	protected def dispatch extractFilterExpression(Single e) { e.filterExpression }

	protected def dispatch extractFilterExpression(Expression e) { null }

	/**
	 * (3) The {@link Foreach} clause iterates through a list and performs data manipulation operations:
	 * {@code FOREACH (variable IN list | clauses}
	 * 
	 * Note that {@code Foreach} can contain multiple {@link Clause}s and can also be nested, e.g.
	 * {@code FOREACH (v1 IN list1 | FOREACH (v2 IN list2 | SET v1.x = v1.x + [v2.y]))}
	 */
	protected def Iterable<VariableDeclaration> extractDeclarationsFromForeach(EObject context) {
		val foreach = EcoreUtil2.getContainerOfType(context, Foreach)
		if (foreach === null) {
			return #[]
		}
		val clauses = EcoreUtil2.getContainerOfType(context, SingleQuery).clauses
		val declarationsFromClauses = extractDeclarationsFromClauseList(clauses, foreach, context)

		return #[foreach.variable] + extractDeclarationsFromForeach(context.eContainer) + declarationsFromClauses
	}

}
