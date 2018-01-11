package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class Comparability_Test extends AbstractCypherTest {
    
    /*
    Scenario: Comparing strings and integers using > in an AND'd predicate
    Given an empty graph
    And having executed:
      """
      CREATE (root:Root)-[:T]->(:Child {id: 0}),
             (root)-[:T]->(:Child {id: 'xx'}),
             (root)-[:T]->(:Child)
      """
    */
    @Test
    def void testComparability_01() {
        test('''
        MATCH (:Root)-->(i:Child)
        WHERE exists(i.id) AND i.id > 'x'
        RETURN i.id
        ''')
    }

    /*
    Scenario: Comparing strings and integers using > in a OR'd predicate
    Given an empty graph
    And having executed:
      """
      CREATE (root:Root)-[:T]->(:Child {id: 0}),
             (root)-[:T]->(:Child {id: 'xx'}),
             (root)-[:T]->(:Child)
      """
    */
    @Test
    def void testComparability_02() {
        test('''
        MATCH (:Root)-->(i:Child)
        WHERE NOT exists(i.id) OR i.id > 'x'
        RETURN i.id
        ''')
    }

}
