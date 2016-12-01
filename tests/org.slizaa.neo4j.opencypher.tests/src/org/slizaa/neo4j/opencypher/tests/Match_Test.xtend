package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

class Match_Test extends AbstractCypherTest{

	@Test
	def void optionalMatch() {
		test('''
			OPTIONAL MATCH ()
		''');
	}

	@Test
	def void emptyMatch() {
		test('''
			MATCH ()
		''');
	}

	@Test
	def void simpleNodeWithVariable() {
		test('''
			MATCH (a)
		''');
	}

	@Test
	def void simpleNodeWithOneLabel() {
		test('''
			MATCH (:TEST)
		''');
	}

	@Test
	def void simpleNodeWithVariableOneLabel() {
		test('''
			MATCH (a:Test)
		''');
	}

	@Test
	def void simpleNodeWithTwoLabels() {
		test('''
			MATCH (:Test:Test2)
		''');
	}

	@Test
	def void simpleNodeWithVariableAndTwoLabels() {
		test('''
			MATCH (a:Test:Test2)
		''');
	}

	@Test
	def void nodeChain() {
		test('''
			MATCH (a)-->(b)-->(c)-->(e), p=(v)-->(c)
		''');
	}

	@Test
	def void relationshipDetails_Range_Wildcard() {
		test('''
			MATCH ()-[*]->()
		''');
	}


	@Test
	def void relationshipDetails_Range_LowerUpper() {
		test('''
			MATCH ()-[*2..3]->()
		''');
	}
	
	@Test
	def void relationshipDetails_Range_NoLower() {
		test('''
			MATCH ()-[*..3]->()
		''');
	}
	
	@Test
	def void relationshipDetails_Range_NoUpper() {
		test('''
			MATCH ()-[*2..]->()
		''');
	}
	
	@Test
	def void relationshipDetails_Range_NoUpperAndNoLower() {
		test('''
			MATCH ()-[*..]->()
		''');
	}

	@Test
	def void relationshipDetails_1() {
		test('''
			MATCH (a)-[a?:test|fest*2..3]->(b),  path = shortestPath((p1)-[:KNOWS*]-(p2))
		''');
	}

	@Test
	def void relationshipDetails_2() {
		test('''
			MATCH (a)-[*2..2]->(b)
		''');
	}

	@Test
	def void where_1() {
		test('''
			MATCH (a)-[*2..2]->(b) where a=2.1
		''');
	}

	@Test
	def void relationshipDetails_3() {
		test('''
			MATCH (a)-[*]->(b)
		''');
	}

	@Test
	def void relationshipDetails_4() {
		test('''
			MATCH (a)-[a?:test|fest*2..3]->(b)
		''');
	}

	@Test
	def void simple_7() {
		test('''
			MATCH (matchedNode:Type:FILE)-[a?:DEPENDS_ON|:LOVES]-(other:FILE) where matchedNode='HONZIPONZIE'
		''');
	}
}
