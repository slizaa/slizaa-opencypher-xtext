package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class PathEquality_Test extends AbstractCypherTest {
    
    /*
    Scenario: Direction of traversed relationship is not significant for path equality, simple
    Given an empty graph
    And having executed:
      """
      CREATE (n:A)-[:LOOP]->(n)
      """
    */
    @Test
    def void testPathEquality_01() {
        test('''
        MATCH p1 = (:A)-->()
        MATCH p2 = (:A)<--()
        RETURN p1 = p2
        ''')
    }

}
