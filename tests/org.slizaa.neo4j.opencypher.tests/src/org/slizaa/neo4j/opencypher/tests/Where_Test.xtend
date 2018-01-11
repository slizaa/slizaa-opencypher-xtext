package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

class Where_Test extends AbstractCypherTest {

	@Test
	def void whereAlias() {
		test('''
			MATCH (p:Person)-->(c:Car)
			WITH p, count(c) AS carNumber
			WHERE carNumber > 1
			RETURN p
		''');
	}
}
