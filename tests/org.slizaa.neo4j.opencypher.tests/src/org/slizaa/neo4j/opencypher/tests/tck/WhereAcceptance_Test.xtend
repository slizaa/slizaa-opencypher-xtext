package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class WhereAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: NOT and false
    Given an empty graph
    And having executed:
      """
      CREATE ({name: 'a'})
      """
    */
    @Test
    def void testWhereAcceptance_01() {
        test('''
        MATCH (n)
        WHERE NOT(n.name = 'apa' AND false)
        RETURN n
        ''')
    }

}
