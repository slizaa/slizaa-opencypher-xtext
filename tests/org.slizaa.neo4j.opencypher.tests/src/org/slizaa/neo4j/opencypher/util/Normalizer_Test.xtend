package org.slizaa.neo4j.opencypher.util

import org.junit.Test
import org.junit.Assert

class Normalizer_Test {

//	@Test
//	def void comment_1() {
//
//		val String result = CypherNormalizer.normalize('''
//			MATCH (n)-[]->(r)
//			DELETE n, r
//		''');
//
//		Assert.assertEquals('''MATCH (n)-[]->(r) DELETE n, r'''.toString, result);
//	}
//
//	@Test
//	def void comment_2() {
//
//		val String result = CypherNormalizer.normalize('''
//			// delete some nodes
//			MATCH (n)-[]->(r)
//			DELETE n, r
//		''');
//
//		Assert.assertEquals('''MATCH (n)-[]->(r) DELETE n, r'''.toString, result);
//	}
//
//	@Test
//	def void comment_3() {
//
//		val String result = CypherNormalizer.normalize('''
//			/* delete some nodes */
//			MATCH (n)-[]->(r)
//			DELETE n, r
//		''');
//
//		Assert.assertEquals('''MATCH (n)-[]->(r) DELETE n, r'''.toString, result);
//	}
//
//	@Test
//	def void comment_4() {
//
//		val String result = CypherNormalizer.normalize('''
//			/* match and... */
//			MATCH (n)-[]->(r)
//			/* delete some nodes */
//			DELETE n, r
//		''');
//
//		Assert.assertEquals('''MATCH (n)-[]->(r) DELETE n, r'''.toString, result);
//	}
//
//	@Test
//	def void comment_5() {
//
//		val String result = CypherNormalizer.normalize('''
//			/* delete some nodes */
//			MATCH (n)-[]->(r) // match 
//			DELETE n, r // delete
//		''');
//
//		Assert.assertEquals('''MATCH (n)-[]->(r) DELETE n, r'''.toString, result);
//	}
}
