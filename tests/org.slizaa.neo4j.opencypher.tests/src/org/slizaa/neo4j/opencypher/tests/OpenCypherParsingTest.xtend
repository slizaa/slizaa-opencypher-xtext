package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

class OpenCypherParsingTest extends AbstractCypherTest {

//	@Test
//	def void simple() {
//		test('''
//			MATCH (matchedNode:Person)
//			 { a:"hurz", b:"zokkel"}
//			 { a:"hurz" }
//			 { }
//		 ''')
//	}

	@Test
	def void simpleNode() {
		test('''
			MATCH ()
		''')
	}

	@Test
	def void simpleNodeWithVariable() {
		test('''
			MATCH (a)
		''')
	}

	@Test
	def void simpleNodeWithOneLabel() {
		test('''
			MATCH (:TEST)
		''')
	}

	@Test
	def void simpleNodeWithVariableOneLabel() {
		test('''
			MATCH (a:Test)
		''')
	}

	@Test
	def void simpleNodeWithTwoLabels() {
		test('''
			MATCH (:Test:Test2)
		''')
	}

	@Test
	def void simpleNodeWithVariableAndTwoLabels() {
		test('''
			MATCH (a:Test:Test2)
		''')
	}

	@Test
	def void nodeChain() {
		test('''
			MATCH (a)-->(b)-->(c)-->(e), p=(v)-->(c)
		''')
	}

	@Test
	def void relationshipDetails_1() {
		test('''
			MATCH (a)-[a?:test|fest*2..3]->(b),  path = shortestPath((p1)-[:KNOWS*]-(p2))
		''')
	}

	@Test
	def void relationshipDetails_2() {
		test('''
			MATCH (a)-[*2..]->(b)
		''')
	}

	@Test
	def void relationshipDetails_3() {
		test('''
			MATCH (a)-[*]->(b)
		''')
	}

	@Test
	def void relationshipDetails_4() {
		test('''
			MATCH (a)-[a?:test|fest*2..3]->(b)
		''')
	}
}
