package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class LargeIntegerEquality_Test extends AbstractCypherTest {
    
    /*
    Scenario: Does not lose precision
    */
    @Test
    def void testLargeIntegerEquality_01() {
        test('''
        MATCH (p:Label)
        RETURN p.id
        ''')
    }

    /*
    Scenario: Handling inlined equality of large integer
    */
    @Test
    def void testLargeIntegerEquality_02() {
        test('''
        MATCH (p:Label {id: 4611686018427387905})
        RETURN p.id
        ''')
    }

    /*
    Scenario: Handling explicit equality of large integer
    */
    @Test
    def void testLargeIntegerEquality_03() {
        test('''
        MATCH (p:Label)
        WHERE p.id = 4611686018427387905
        RETURN p.id
        ''')
    }

    /*
    Scenario: Handling inlined equality of large integer, non-equal values
    */
    @Test
    def void testLargeIntegerEquality_04() {
        test('''
        MATCH (p:Label {id : 4611686018427387900})
        RETURN p.id
        ''')
    }

    /*
    Scenario: Handling explicit equality of large integer, non-equal values
    */
    @Test
    def void testLargeIntegerEquality_05() {
        test('''
        MATCH (p:Label)
        WHERE p.id = 4611686018427387900
        RETURN p.id
        ''')
    }

}
