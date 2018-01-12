package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class TernaryLogicAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: The inverse of a null is a null
    */
    @Test
    def void testTernaryLogicAcceptance_01() {
        test('''
        RETURN NOT null AS value
        ''')
    }

    /*
    Scenario: A literal null IS null
    */
    @Test
    def void testTernaryLogicAcceptance_02() {
        test('''
        RETURN null IS NULL AS value
        ''')
    }

    /*
    Scenario: A literal null is not IS NOT null
    */
    @Test
    def void testTernaryLogicAcceptance_03() {
        test('''
        RETURN null IS NOT NULL AS value
        ''')
    }

    /*
    Scenario: It is unknown - i.e. null - if a null is equal to a null
    */
    @Test
    def void testTernaryLogicAcceptance_04() {
        test('''
        RETURN null = null AS value
        ''')
    }

    /*
    Scenario: It is unknown - i.e. null - if a null is not equal to a null
    */
    @Test
    def void testTernaryLogicAcceptance_05() {
        test('''
        RETURN null <> null AS value
        ''')
    }

}
