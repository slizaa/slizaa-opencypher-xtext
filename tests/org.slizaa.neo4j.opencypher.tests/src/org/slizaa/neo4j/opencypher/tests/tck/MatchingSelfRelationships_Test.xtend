package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class MatchingSelfRelationships_Test extends AbstractCypherTest {
    
    /*
    Scenario: Undirected match in self-relationship graph
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_01() {
        test('''
        MATCH (a)-[r]-(b)
        RETURN a, r, b
        ''')
    }

    /*
    Scenario: Undirected match in self-relationship graph, count
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_02() {
        test('''
        MATCH ()--()
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Undirected match of self-relationship in self-relationship graph
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_03() {
        test('''
        MATCH (n)-[r]-(n)
        RETURN n, r
        ''')
    }

    /*
    Scenario: Undirected match of self-relationship in self-relationship graph, count
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_04() {
        test('''
        MATCH (n)--(n)
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Undirected match on simple relationship graph
    Given an empty graph
    And having executed:
      """
      CREATE (:A)-[:LOOP]->(:B)
      """
    */
    @Test
    def void testMatchingSelfRelationships_05() {
        test('''
        MATCH (a)-[r]-(b)
        RETURN a, r, b
        ''')
    }

    /*
    Scenario: Undirected match on simple relationship graph, count
    Given an empty graph
    And having executed:
      """
      CREATE (:A)-[:LOOP]->(:B)
      """
    */
    @Test
    def void testMatchingSelfRelationships_06() {
        test('''
        MATCH ()--()
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Directed match on self-relationship graph
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_07() {
        test('''
        MATCH (a)-[r]->(b)
        RETURN a, r, b
        ''')
    }

    /*
    Scenario: Directed match on self-relationship graph, count
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_08() {
        test('''
        MATCH ()-->()
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Directed match of self-relationship on self-relationship graph
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_09() {
        test('''
        MATCH (n)-[r]->(n)
        RETURN n, r
        ''')
    }

    /*
    Scenario: Directed match of self-relationship on self-relationship graph, count
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_10() {
        test('''
        MATCH (n)-->(n)
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Counting undirected self-relationships in self-relationship graph
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_11() {
        test('''
        MATCH (n)-[r]-(n)
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Counting distinct undirected self-relationships in self-relationship graph
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a)
      """
    */
    @Test
    def void testMatchingSelfRelationships_12() {
        test('''
        MATCH (n)-[r]-(n)
        RETURN count(DISTINCT r)
        ''')
    }

    /*
    Scenario: Directed match of a simple relationship
    Given an empty graph
    And having executed:
      """
      CREATE (:A)-[:LOOP]->(:B)
      """
    */
    @Test
    def void testMatchingSelfRelationships_13() {
        test('''
        MATCH (a)-[r]->(b)
        RETURN a, r, b
        ''')
    }

    /*
    Scenario: Directed match of a simple relationship, count
    Given an empty graph
    And having executed:
      """
      CREATE (:A)-[:LOOP]->(:B)
      """
    */
    @Test
    def void testMatchingSelfRelationships_14() {
        test('''
        MATCH ()-->()
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Counting directed self-relationships
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)-[:LOOP]->(a),
             ()-[:T]->()
      """
    */
    @Test
    def void testMatchingSelfRelationships_15() {
        test('''
        MATCH (n)-[r]->(n)
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Mixing directed and undirected pattern parts with self-relationship, simple
    Given an empty graph
    And having executed:
      """
      CREATE (:A)-[:T1]->(l:Looper),
             (l)-[:LOOP]->(l),
             (l)-[:T2]->(:B)
      """
    */
    @Test
    def void testMatchingSelfRelationships_16() {
        test('''
        MATCH (x:A)-[r1]->(y)-[r2]-(z)
        RETURN x, r1, y, r2, z
        ''')
    }

    /*
    Scenario: Mixing directed and undirected pattern parts with self-relationship, count
    Given an empty graph
    And having executed:
      """
      CREATE (:A)-[:T1]->(l:Looper),
             (l)-[:LOOP]->(l),
             (l)-[:T2]->(:B)
      """
    */
    @Test
    def void testMatchingSelfRelationships_17() {
        test('''
        MATCH (:A)-->()--()
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Mixing directed and undirected pattern parts with self-relationship, undirected
    Given an empty graph
    And having executed:
      """
      CREATE (:A)-[:T1]->(l:Looper),
             (l)-[:LOOP]->(l),
             (l)-[:T2]->(:B)
      """
    */
    @Test
    def void testMatchingSelfRelationships_18() {
        test('''
        MATCH (x)-[r1]-(y)-[r2]-(z)
        RETURN x, r1, y, r2, z
        ''')
    }

    /*
    Scenario: Mixing directed and undirected pattern parts with self-relationship, undirected count
    Given an empty graph
    And having executed:
      """
      CREATE (:A)-[:T1]->(l:Looper),
             (l)-[:LOOP]->(l),
             (l)-[:T2]->(:B)
      """
    */
    @Test
    def void testMatchingSelfRelationships_19() {
        test('''
        MATCH ()-[]-()-[]-()
        RETURN count(*)
        ''')
    }

}
