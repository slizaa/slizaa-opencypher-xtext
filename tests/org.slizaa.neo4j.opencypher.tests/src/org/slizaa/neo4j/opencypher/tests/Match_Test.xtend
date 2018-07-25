package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

class Match_Test extends AbstractCypherTest{

	@Test
	def void optionalMatch() {
		test('''
			OPTIONAL MATCH () RETURN 1
		''');
	}

	@Test
	def void emptyMatch() {
		test('''
			MATCH () RETURN 1
		''');
	}

	@Test
	def void simpleNodeWithVariable() {
		test('''
			MATCH (a) RETURN a
		''');
	}

	@Test
	def void simpleNodeWithOneLabel() {
		test('''
			MATCH (:TEST) RETURN 1
		''');
	}

	@Test
	def void simpleNodeWithVariableOneLabel() {
		test('''
			MATCH (a:Test) RETURN 1
		''');
	}

	@Test
	def void simpleNodeWithTwoLabels() {
		test('''
			MATCH (:Test:Test2) RETURN 1
		''');
	}

	@Test
	def void simpleNodeWithVariableAndTwoLabels() {
		test('''
			MATCH (a:Test:Test2) RETURN 1
		''');
	}

	@Test
	def void nodeChain() {
		test('''
			MATCH (a)-->(b)-->(c)-->(e), p=(v)-->(c) RETURN 1
		''');
	}

	@Test
	def void relationshipDetails_Range_Wildcard() {
		test('''
			MATCH ()-[*]->() RETURN 1
		''');
	}


	@Test
	def void relationshipDetails_Range_LowerUpper() {
		test('''
			MATCH ()-[*2..3]->() RETURN 1
		''');
	}
	
	@Test
	def void relationshipDetails_Range_NoLower() {
		test('''
			MATCH ()-[*..3]->() RETURN 1
		''');
	}
	
	@Test
	def void relationshipDetails_Range_NoUpper() {
		test('''
			MATCH ()-[*2..]->() RETURN 1
		''');
	}
	
	@Test
	def void relationshipDetails_Range_NoUpperAndNoLower() {
		test('''
			MATCH ()-[*..]->() RETURN 1
		''');
	}

	@Test
	def void relationshipDetails_1() {
		test('''
			MATCH (a)-[a?:test|fest*2..3]->(b),  path = shortestPath((p1)-[:KNOWS*]-(p2)) RETURN 1
		''');
	}

	@Test
	def void relationshipDetails_2() {
		test('''
			MATCH (a)-[*2..2]->(b) RETURN 1
		''');
	}

	@Test
	def void where_1() {
		test('''
			MATCH (a)-[*2..2]->(b) where a=2.1 RETURN 1
		''');
	}

	@Test
	def void relationshipDetails_3() {
		test('''
			MATCH (a)-[*]->(b) RETURN 1
		''');
	}

	@Test
	def void relationshipDetails_4() {
		test('''
			MATCH (a)-[a?:test|fest*2..3]->(b) RETURN 1
		''');
	}

	@Test
	def void simple_7() {
		test('''
			MATCH (matchedNode:Type:FILE)-[a?:DEPENDS_ON|:LOVES]-(other:FILE) where matchedNode='HONZIPONZIE' RETURN 1
		''');
	}
}
