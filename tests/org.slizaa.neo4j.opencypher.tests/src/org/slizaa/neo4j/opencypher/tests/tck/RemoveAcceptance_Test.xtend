package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class RemoveAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Should ignore nulls
    Given an empty graph
    And having executed:
      """
      CREATE ({prop: 42})
      """
    */
    @Test
    def void testRemoveAcceptance_01() {
        test('''
        MATCH (n)
        OPTIONAL MATCH (n)-[r]->()
        REMOVE r.prop
        RETURN n
        ''')
    }

    /*
    Scenario: Remove a single label
    Given an empty graph
    And having executed:
      """
      CREATE (:L {prop: 42})
      """
    */
    @Test
    def void testRemoveAcceptance_02() {
        test('''
        MATCH (n)
        REMOVE n:L
        RETURN n.prop
        ''')
    }

    /*
    Scenario: Remove multiple labels
    Given an empty graph
    And having executed:
      """
      CREATE (:L1:L2:L3 {prop: 42})
      """
    */
    @Test
    def void testRemoveAcceptance_03() {
        test('''
        MATCH (n)
        REMOVE n:L1:L3
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Remove a single node property
    Given an empty graph
    And having executed:
      """
      CREATE (:L {prop: 42})
      """
    */
    @Test
    def void testRemoveAcceptance_04() {
        test('''
        MATCH (n)
        REMOVE n.prop
        RETURN exists(n.prop) AS still_there
        ''')
    }

    /*
    Scenario: Remove multiple node properties
    Given an empty graph
    And having executed:
      """
      CREATE (:L {prop: 42, a: 'a', b: 'B'})
      """
    */
    @Test
    def void testRemoveAcceptance_05() {
        test('''
        MATCH (n)
        REMOVE n.prop, n.a
        RETURN size(keys(n)) AS props
        ''')
    }

    /*
    Scenario: Remove a single relationship property
    Given an empty graph
    And having executed:
      """
      CREATE (a), (b), (a)-[:X {prop: 42}]->(b)
      """
    */
    @Test
    def void testRemoveAcceptance_06() {
        test('''
        MATCH ()-[r]->()
        REMOVE r.prop
        RETURN exists(r.prop) AS still_there
        ''')
    }

    /*
    Scenario: Remove multiple relationship properties
    Given an empty graph
    And having executed:
      """
      CREATE (a), (b), (a)-[:X {prop: 42, a: 'a', b: 'B'}]->(b)
      """
    */
    @Test
    def void testRemoveAcceptance_07() {
        test('''
        MATCH ()-[r]->()
        REMOVE r.prop, r.a
        RETURN size(keys(r)) AS props
        ''')
    }

    /*
    Scenario: Remove a missing property should be a valid operation
    Given an empty graph
    And having executed:
      """
      CREATE (), (), ()
      """
    */
    @Test
    def void testRemoveAcceptance_08() {
        test('''
        MATCH (n)
        REMOVE n.prop
        RETURN sum(size(keys(n))) AS totalNumberOfProps
        ''')
    }

}
