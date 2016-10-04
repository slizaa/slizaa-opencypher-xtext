package org.slizaa.neo4j.opencypher.tests.expression

import org.eclipse.xtext.EcoreUtil2
import org.junit.Test
import org.slizaa.neo4j.opencypher.openCypher.BoolConstant
import org.slizaa.neo4j.opencypher.openCypher.Cypher
import org.slizaa.neo4j.opencypher.openCypher.Expression
import org.slizaa.neo4j.opencypher.openCypher.ExpressionOr
import org.slizaa.neo4j.opencypher.openCypher.ExpressionXor
import org.slizaa.neo4j.opencypher.openCypher.NumberConstant
import org.slizaa.neo4j.opencypher.openCypher.ParenthesizedExpression
import org.slizaa.neo4j.opencypher.openCypher.Where
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

import static org.junit.Assert.*

class Expression_Test extends AbstractCypherTest {

	@Test
	def void expression_OR() {
		val Cypher cypher = test('''
			START n=Node(2) where 1 OR false OR false OR false;
		''');
		assertEquals("(((1 OR false) OR false) OR false)", strRep(cypher));
	}

	@Test
	def void expression_XOR_1() {
		val Cypher cypher = test('''
			START n=Node(2) where 1 XOR false XOR false XOR false;
		''');
		assertEquals("(((1 XOR false) XOR false) XOR false)", strRep(cypher));
	}

	@Test
	def void expression_XOR_2() {
		val Cypher cypher = test('''
			START n=Node(2) where 1 XOR false OR false XOR false;
		''');
		assertEquals("((1 XOR false) OR (false XOR false))", strRep(cypher));
	}

	@Test
	def void expression_XOR_3() {
		val Cypher cypher = test('''
			START n=Node(2) where 1 XOR (false OR false) XOR false;
		''');

		assertEquals("((1 XOR (false OR false)) XOR false)", strRep(cypher));
	}

	def String strRep(Cypher cypher) {
		val Expression exp = EcoreUtil2.eAllOfType(cypher, Where).get(0).expression;
		exp.stringRepr
	}

	def String stringRepr(Expression e) {
		switch (e) {
			ExpressionOr: '''(«e.left.stringRepr» OR «e.right.stringRepr»)'''
			ExpressionXor: '''(«e.left.stringRepr» XOR «e.right.stringRepr»)'''
			ParenthesizedExpression: '''«e.expression.stringRepr»'''
			BoolConstant: '''«e.value»'''
			NumberConstant: '''«e.value»'''
		}.toString
	}
}
