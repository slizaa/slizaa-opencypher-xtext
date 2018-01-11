package org.slizaa.neo4j.opencypher.tests.scoping

import org.eclipse.xtext.EcoreUtil2
import org.junit.Assert
import org.junit.Test
import org.slizaa.neo4j.opencypher.openCypher.VariableDeclaration
import org.slizaa.neo4j.opencypher.openCypher.VariableRef

/**
 * see https://github.com/slizaa/slizaa-opencypher-xtext/issues/7
 * see https://de.slideshare.net/meysholdt/testdriven-development-of-xtext-dsls
 */
class ScopeTest_2 extends AbstractScopeTest {

	@Test
	def void scopeTest() {

		// parse the cypher statement
		val cypherQuery = test('''
			WITH 'dummy' AS x                             // decl: 0
			MATCH (p:Person)-[:LIVES]->(c:City)           // decl: 1,2
			WITH p as p, count(c) AS cities, x            // decl: 3,4 - ref: 0,1,2
			MATCH (p:Person)-[:VISITED]->(c:Country)      // decl: 5,6
			WITH p, cities, count(c) AS countries, x      // decl: 7 - ref: 3,4,5,6
			RETURN *                                      //
		''');

		// get all variable declarations and references
		val variableDeclarations = EcoreUtil2.getAllContentsOfType(cypherQuery, VariableDeclaration)
		val variableReferences = EcoreUtil2.getAllContentsOfType(cypherQuery, VariableRef)

		// simple setup test 
		Assert.assertEquals(8, variableDeclarations.size)
		Assert.assertEquals(7, variableReferences.size)

		// assert the scope
		variableReferences.get(0).assertScope(variableDeclarations.elements(0, 1, 2))
		variableReferences.get(1).assertScope(variableDeclarations.elements(0, 1, 2))
		variableReferences.get(2).assertScope(variableDeclarations.elements(0, 1, 2))
		variableReferences.get(3).assertScope(variableDeclarations.elements(5, 6, 4, 0))
		variableReferences.get(4).assertScope(variableDeclarations.elements(5, 6, 4, 0))
		variableReferences.get(5).assertScope(variableDeclarations.elements(5, 6, 4, 0))
		variableReferences.get(6).assertScope(variableDeclarations.elements(5, 6, 4, 0))
	}
}
