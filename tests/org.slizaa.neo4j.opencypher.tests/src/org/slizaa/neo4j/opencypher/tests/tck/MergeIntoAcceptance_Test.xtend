package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class MergeIntoAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Updating one property with ON CREATE
    */
    @Test
    def void testMergeIntoAcceptance_01() {
        test('''
        MATCH (a {name: 'A'}), (b {name: 'B'})
        MERGE (a)-[r:TYPE]->(b)
        ON CREATE SET r.name = 'foo'
        ''')
    }

    /*
    Scenario: Null-setting one property with ON CREATE
    */
    @Test
    def void testMergeIntoAcceptance_02() {
        test('''
        MATCH (a {name: 'A'}), (b {name: 'B'})
        MERGE (a)-[r:TYPE]->(b)
        ON CREATE SET r.name = null
        ''')
    }

    /*
    Scenario: Copying properties from node with ON CREATE
    */
    @Test
    def void testMergeIntoAcceptance_03() {
        test('''
        MATCH (a {name: 'A'}), (b {name: 'B'})
        MERGE (a)-[r:TYPE]->(b)
        ON CREATE SET r = a
        ''')
    }

    /*
    Scenario: Copying properties from node with ON MATCH
    And having executed:
      """
      MATCH (a:A), (b:B)
      CREATE (a)-[:TYPE {foo: 'bar'}]->(b)
      """
    */
    @Test
    def void testMergeIntoAcceptance_04() {
        test('''
        MATCH (a {name: 'A'}), (b {name: 'B'})
        MERGE (a)-[r:TYPE]->(b)
        ON MATCH SET r = a
        ''')
    }

    /*
    Scenario: Copying properties from literal map with ON CREATE
    */
    @Test
    def void testMergeIntoAcceptance_05() {
        test('''
        MATCH (a {name: 'A'}), (b {name: 'B'})
        MERGE (a)-[r:TYPE]->(b)
        ON CREATE SET r += {foo: 'bar', bar: 'baz'}
        ''')
    }

    /*
    Scenario: Copying properties from literal map with ON MATCH
    And having executed:
      """
      MATCH (a:A), (b:B)
      CREATE (a)-[:TYPE {foo: 'bar'}]->(b)
      """
    */
    @Test
    def void testMergeIntoAcceptance_06() {
        test('''
        MATCH (a {name: 'A'}), (b {name: 'B'})
        MERGE (a)-[r:TYPE]->(b)
        ON MATCH SET r += {foo: 'baz', bar: 'baz'}
        ''')
    }

}
