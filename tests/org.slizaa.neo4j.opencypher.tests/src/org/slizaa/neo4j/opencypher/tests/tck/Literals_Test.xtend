package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class Literals_Test extends AbstractCypherTest {
    
    /*
    Scenario: Return an integer
    */
    @Test
    def void testLiterals_01() {
        test('''
        RETURN 1 AS literal
        ''')
    }

    /*
    Scenario: Return a float
    */
    @Test
    def void testLiterals_02() {
        test('''
        RETURN 1.0 AS literal
        ''')
    }

    /*
    Scenario: Return a float in exponent form
    */
    @Test
    def void testLiterals_03() {
        test('''
        RETURN -1e-9 AS literal
        ''')
    }

    /*
    Scenario: Return a boolean
    */
    @Test
    def void testLiterals_04() {
        test('''
        RETURN true AS literal
        ''')
    }

    /*
    Scenario: Return a single-quoted string
    */
    @Test
    def void testLiterals_05() {
        test('''
        RETURN '' AS literal
        ''')
    }

    /*
    Scenario: Return a double-quoted string
    */
    @Test
    def void testLiterals_06() {
        test('''
        RETURN "" AS literal
        ''')
    }

    /*
    Scenario: Return null
    */
    @Test
    def void testLiterals_07() {
        test('''
        RETURN null AS literal
        ''')
    }

    /*
    Scenario: Return an empty list
    */
    @Test
    def void testLiterals_08() {
        test('''
        RETURN [] AS literal
        ''')
    }

    /*
    Scenario: Return a nonempty list
    */
    @Test
    def void testLiterals_09() {
        test('''
        RETURN [0, 1, 2] AS literal
        ''')
    }

    /*
    Scenario: Return an empty map
    */
    @Test
    def void testLiterals_10() {
        test('''
        RETURN {} AS literal
        ''')
    }

    /*
    Scenario: Return a nonempty map
    */
    @Test
    def void testLiterals_11() {
        test('''
        RETURN {k1: 0, k2: 'string'} AS literal
        ''')
    }

}
