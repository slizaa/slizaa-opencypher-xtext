package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class ColumnNameAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Keeping used expression 1
    */
    @Test
    def void testColumnNameAcceptance_01() {
        test('''
        MATCH (n)
        RETURN cOuNt( * )
        ''')
    }

    /*
    Scenario: Keeping used expression 2
    */
    @Test
    def void testColumnNameAcceptance_02() {
        test('''
        MATCH p = (n)-->(b)
        RETURN nOdEs( p )
        ''')
    }

    /*
    Scenario: Keeping used expression 3
    */
    @Test
    def void testColumnNameAcceptance_03() {
        test('''
        MATCH p = (n)-->(b)
        RETURN coUnt( dIstInct p )
        ''')
    }

    /*
    Scenario: Keeping used expression 4
    */
    @Test
    def void testColumnNameAcceptance_04() {
        test('''
        MATCH p = (n)-->(b)
        RETURN aVg(    n.aGe     )
        ''')
    }

}
