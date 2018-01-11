package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

class PatternComprehension_Test extends AbstractCypherTest {

	@Test
	def void patternComprehensionTest() {
		test('''
			MATCH (a:Person { name: 'Charlie Sheen' })
			RETURN [(a)-->(b) WHERE b:Movie | b.year] AS years
		''');
	}

}
