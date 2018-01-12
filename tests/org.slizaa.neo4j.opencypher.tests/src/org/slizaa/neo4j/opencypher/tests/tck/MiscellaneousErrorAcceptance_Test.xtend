package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class MiscellaneousErrorAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Failing on merging relationship with null property
    */
    @Test
    def void testMiscellaneousErrorAcceptance_01() {
        test('''
        CREATE (a), (b)
        MERGE (a)-[r:X {p: null}]->(b)
        ''')
    }

    /*
    Scenario: Failing on merging node with null property
    */
    @Test
    def void testMiscellaneousErrorAcceptance_02() {
        test('''
        MERGE ({p: null})
        ''')
    }

    /*
    Scenario: Failing when setting a list of maps as a property
    */
    @Test
    def void testMiscellaneousErrorAcceptance_03() {
        test('''
        CREATE (a)
        SET a.foo = [{x: 1}]
        ''')
    }

}
