package org.slizaa.neo4j.opencypher.tests

import org.junit.Test
import org.slizaa.neo4j.opencypher.openCypher.Cypher
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.emf.ecore.util.EcoreUtil
import java.util.Collections
import org.slizaa.neo4j.opencypher.openCypher.ReturnItems
import org.slizaa.neo4j.opencypher.openCypher.ReturnItem
import java.util.List
import org.slizaa.neo4j.opencypher.openCypher.FunctionInvocation
import static com.google.common.base.Preconditions.checkNotNull
import junit.framework.Assert

class Return_Test extends AbstractCypherTest {

	@Test
	def void return_1() {
		test('''
			MATCH () RETURN *
		''');
	}

	@Test
	def void return_2() {
		test('''
			MATCH (a) RETURN a
		''');
	}

	@Test
	def void return_3() {
		test('''
			MATCH (a) RETURN a.name
		''');
	}

	@Test
	def void return_4() {
		test('''
			MATCH (a) RETURN count(a)
		''');
	}

	@Test
	def void return_5() {
		test('''
			MATCH (a) RETURN count(*)
		''');
	}

	@Test
	def void return_6() {

//		Return (return: RETURN, distinct: true)
//            ReturnBody 
//                ReturnItems (all: null)
//                    ReturnItem 
//                        FunctionInvocation (operator: null) (distinct: false)
//                            FunctionName (name: id)
//                            VariableRef (operator: null) ->Variable (name: a)
//                    ReturnItem 
//                        VariableRef (operator: null) ->Variable (name: a)
//                    ReturnItem 
//                        ExpressionNodeLabelsAndPropertyLookup (operator: null)
//                            VariableRef (operator: null) ->Variable (name: a)
//                            PropertyLookup (propertyKeyName: fqn, propertyOperator: null)
		var Cypher cypher = test('''
			MATCH (a:Artifact)-[:CONTAINS]->(p:Package)
			WHERE p.fqn CONTAINS 'licensing'
			RETURN DISTINCT id(a)
		''');

		Assert.assertTrue(CypherUtils.returnItemsContainOnlyIds(cypher));
	}
}
