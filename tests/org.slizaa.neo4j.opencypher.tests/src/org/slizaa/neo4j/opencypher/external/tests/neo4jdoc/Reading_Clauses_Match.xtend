package org.slizaa.neo4j.opencypher.external.tests.neo4jdoc

import org.junit.Ignore
import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class Reading_Clauses_Match extends AbstractCypherTest {

  @Test
  def void example_GetAllNodes() {
		test('''
			MATCH (n)
			RETURN n
		''');
  }

  @Test
  def void example_GetAllNodesWithALabel() {
		test('''
			MATCH (movie:Movie)
			RETURN movie
		''');
  }

  @Test
  def void example_RelatedNodes() {
		test('''
			MATCH (director { name:'Oliver Stone' })--(movie)
			RETURN movie.title
		''');
  }

  @Test
  def void example_MatchWithLabels() {
		test('''
			MATCH (charlie:Person { name:'Charlie Sheen' })--(movie:Movie)
			RETURN movie
		''');
  }
  
    @Test
    def void example_outgoingRelationships() {
  		test('''
  			MATCH (martin { name:'Martin Sheen' })-->(movie)
  			RETURN movie.title
  		''');
    }

  @Test
  def void example_DirectedRelationshipsAndIdentifier() {
		test('''
			MATCH (martin { name:'Martin Sheen' })-[r]->(movie)
			RETURN r
		''');
  }

  @Test
  def void example_MatchByRelationshipType() {
		test('''
			MATCH (wallstreet { title:'Wall Street' })<-[:ACTED_IN]-(actor)
			RETURN actor
		''');
  }

  @Test
  def void example_MatchByMultipleRelationshipTypes() {
		test('''
			MATCH (wallstreet { title:'Wall Street' })<-[:ACTED_IN|:DIRECTED]-(person)
			RETURN person
		''');
  }

  @Test
  def void example_MatchByRelationshipTypeAndUseAnIdentifier() {
		test('''
			MATCH (wallstreet { title:'Wall Street' })<-[r:ACTED_IN]-(actor)
			RETURN r
		''');
  }

  @Test
  @Ignore
  def void example_RelationshipTypesWithUncommonCharacters() {
		test('''
			MATCH (n { name:'Rob Reiner' })-[r:`TYPE THAT HAS SPACE IN IT`]->()
			RETURN r
		''');
  }

  @Test
  def void example_MultipleRelationships() {
		test('''
			MATCH (charlie { name:'Charlie Sheen' })-[:ACTED_IN]->(movie)<-[:DIRECTED]-(director)
			RETURN charlie,movie,director
		''');
  }

  @Test
  def void example_VariableLengthRelationships() {
		test('''
			MATCH (martin { name:'Martin Sheen' })-[:ACTED_IN*1..2]-(x)
			RETURN x
		''');
  }

  @Test
  @Ignore
  def void example_RelationshipIdentifierInVariableLengthRelationships() {
		test('''
			MATCH (actor { name:'Charlie Sheen' })-[r:ACTED_IN*2]-(co_actor)
			RETURN r
		''');
  }

/* TODO: Match with properties on a variable length path */

	@Test
	def void example_SingleShortestPath() {
		test('''
			MATCH (martin:Person { name:'Martin Sheen' }),(oliver:Person { name:'Oliver Stone' }), p = shortestPath((martin)-[*..15]-(oliver))
			RETURN p
		''');
	}
}
