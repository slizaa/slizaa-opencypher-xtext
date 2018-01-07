package org.slizaa.neo4j.opencypher.tests

import org.junit.Test

class ForEach_Test extends AbstractCypherTest {

	@Test
	def void forEach() {
		test('''
			MATCH p=()
			FOREACH (n IN nodes(p)| SET n.marked = TRUE )
		''');
	}
}
