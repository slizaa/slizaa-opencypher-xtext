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
class ScopeTest_1 extends AbstractScopeTest {

	@Test
	def void scopeTest() {

		// parse the cypher statement
		val cypherQuery = test('''
			MATCH (p1:Person)-[:LIVES_IN]->(c:City)                 // decl: 0,1
			WHERE p1.name = 'Alice'                                 // ref: 0
			WITH p1 AS p, c.language AS lang, c.name AS name        // decl: 2,3,4 - ref: 1,2,3
			RETURN p, lang, name                                    // ref: 4,5,6
			UNION
			MATCH (p)-[:VISITED]->(c:Country)                       // decl: 5,6
			WHERE p.age > 25                                        // ref: 7
			UNWIND p.languages AS lang                              // decl: 7 - ref: 8
			RETURN p, lang, c.name AS name                          // decl: 8 - ref: 9,10,11
		''');

		// get all variable declarations and references
		val variableDeclarations = EcoreUtil2.getAllContentsOfType(cypherQuery, VariableDeclaration)
		val variableReferences = EcoreUtil2.getAllContentsOfType(cypherQuery, VariableRef)

		// simple setup test 
		Assert.assertEquals(variableDeclarations.size, 9)
		Assert.assertEquals(variableReferences.size, 12)

		// assert the scope
		variableReferences.get(0).assertScope(variableDeclarations.elements(0, 1))

		variableReferences.get(1).assertScope(variableDeclarations.elements(0, 1))
		variableReferences.get(2).assertScope(variableDeclarations.elements(0, 1))
		variableReferences.get(3).assertScope(variableDeclarations.elements(0, 1))

		variableReferences.get(4).assertScope(variableDeclarations.elements(0, 1, 2, 3, 4))
		variableReferences.get(5).assertScope(variableDeclarations.elements(0, 1, 2, 3, 4))
		variableReferences.get(6).assertScope(variableDeclarations.elements(0, 1, 2, 3, 4))

		variableReferences.get(7).assertScope(variableDeclarations.elements(5, 6))

		variableReferences.get(8).assertScope(variableDeclarations.elements(5, 6))

		variableReferences.get(9).assertScope(variableDeclarations.elements(5, 6, 7))
		variableReferences.get(10).assertScope(variableDeclarations.elements(5, 6, 7))
		variableReferences.get(11).assertScope(variableDeclarations.elements(5, 6, 7))
	}
}
