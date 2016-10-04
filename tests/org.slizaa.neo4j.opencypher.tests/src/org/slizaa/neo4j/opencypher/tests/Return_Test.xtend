package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

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
}
