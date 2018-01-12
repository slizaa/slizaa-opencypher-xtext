package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class StartingPointAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Find all nodes
    Given an empty graph
    And having executed:
      """
      CREATE ({name: 'a'}),
             ({name: 'b'}),
             ({name: 'c'})
      """
    */
    @Test
    def void testStartingPointAcceptance_01() {
        test('''
        MATCH (n)
        RETURN n
        ''')
    }

    /*
    Scenario: Find labelled nodes
    Given an empty graph
    And having executed:
      """
      CREATE ({name: 'a'}),
             (:Person),
             (:Animal),
             (:Animal)
      """
    */
    @Test
    def void testStartingPointAcceptance_02() {
        test('''
        MATCH (n:Animal)
        RETURN n
        ''')
    }

    /*
    Scenario: Find nodes by property
    Given an empty graph
    And having executed:
      """
      CREATE ({prop: 1}),
             ({prop: 2})
      """
    */
    @Test
    def void testStartingPointAcceptance_03() {
        test('''
        MATCH (n)
        WHERE n.prop = 2
        RETURN n
        ''')
    }

}
