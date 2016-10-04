package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

class Delete_Test extends AbstractCypherTest{

	@Test
	def void delete() {
		test('''
			MATCH (n)-[]->(r)
			DELETE n, r
		''');
	}

	@Test
	def void detachDelete() {
		test('''
			MATCH (n)-[]->(r)
			DETACH DELETE n, r
		''');
	}

	@Test
	def void matchDetachDelete() {
		test('''
			MATCH (n) DETACH DELETE n
		''');
	}
}
