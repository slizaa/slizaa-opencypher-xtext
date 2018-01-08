package org.slizaa.neo4j.opencypher.tests

import org.junit.Test
import org.slizaa.neo4j.opencypher.openCypher.Cypher
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.emf.ecore.util.EcoreUtil
import java.util.Collections
import org.slizaa.neo4j.opencypher.openCypher.ReturnItems
import org.slizaa.neo4j.opencypher.openCypher.ReturnItem
import java.util.List
import org.slizaa.neo4j.opencypher.openCypher.FunctionInvocation
import static com.google.common.base.Preconditions.checkNotNull
import junit.framework.Assert

class Backtick_Test extends AbstractCypherTest {

	@Test
	def void backtick_1() {
		test('''
			MATCH (`person_a`:Person {test:'Jim'})-[:KNOWS]->(`person_b`)-[:KNOWS]->(`person_c`),
			(`person_a`)-[:KNOWS]->(`person_c`)
			RETURN `person_a`, `person_c`
		''');
	}

	@Test
	def void backtick_2() {
		test('''
			MATCH (`person_a`:Person {test:'Jim'})-[:KNOWS]->(`person_b`)-[:KNOWS]->(`person_c`),
			(`person_a`)-[:KNOWS]->(`person_c`)
			RETURN person_a, person_c
		''');
	}

	@Test
	def void backtick_3() {
		test('''
			MATCH (`person a`:Person {test:'Jim'})-[:KNOWS]->(`person b`)-[:KNOWS]->(`person c`),
			(`person a`)-[:KNOWS]->(`person c`)
			RETURN `person a`, `person c`
		''');
	}

}
