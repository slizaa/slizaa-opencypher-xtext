package org.slizaa.neo4j.opencypher.tests.expression

import java.util.List
import org.eclipse.xtext.EcoreUtil2
import org.junit.Test
import org.slizaa.neo4j.opencypher.openCypher.Cypher
import org.slizaa.neo4j.opencypher.openCypher.Return
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class Expression_Expression3_Test extends AbstractCypherTest {

	@Test
	def void index_1() {
		val Cypher cypher = test('''
			MATCH (startDate)<-[:NEXT*0..]-(day) 
			RETURN range(0,10)[3]
		''');

		val List<Return> returns = EcoreUtil2.getAllContentsOfType(cypher, Return);
		for (ret : returns) {
			println(ret)
			println(EcoreUtil2.getRootContainer(ret))
			println(EcoreUtil2.getNextSibling(ret));
		}
	}
	
		@Test
	def void index_2() {
		val Cypher cypher = test('''
			MATCH (startDate)<-[:NEXT*0..]-(day)
			where startDate.time > 10 
			return startDate
		''');

		val List<Return> returns = EcoreUtil2.getAllContentsOfType(cypher, Return);
		for (ret : returns) {
			println(ret)
			println(EcoreUtil2.getRootContainer(ret))
//			 println(EcoreUtil2.getPreviousSibling());
		}
	}

}
