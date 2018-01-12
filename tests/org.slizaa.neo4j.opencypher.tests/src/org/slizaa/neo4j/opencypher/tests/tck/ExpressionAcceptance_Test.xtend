package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class ExpressionAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: IN should work with nested list subscripting
    */
    @Test
    def void testExpressionAcceptance_01() {
        test('''
        WITH [[1, 2, 3]] AS list
        RETURN 3 IN list[0] AS r
        ''')
    }

    /*
    Scenario: IN should work with nested literal list subscripting
    */
    @Test
    def void testExpressionAcceptance_02() {
        test('''
        RETURN 3 IN [[1, 2, 3]][0] AS r
        ''')
    }

    /*
    Scenario: IN should work with list slices
    */
    @Test
    def void testExpressionAcceptance_03() {
        test('''
        WITH [1, 2, 3] AS list
        RETURN 3 IN list[0..1] AS r
        ''')
    }

    /*
    Scenario: IN should work with literal list slices
    */
    @Test
    def void testExpressionAcceptance_04() {
        test('''
        RETURN 3 IN [1, 2, 3][0..1] AS r
        ''')
    }

    /*
    Scenario: Execute n[0]
    */
    @Test
    def void testExpressionAcceptance_05() {
        test('''
        RETURN [1, 2, 3][0] AS value
        ''')
    }

    /*
    Scenario: Execute n['name'] in read queries
    And having executed:
      """
      CREATE ({name: 'Apa'})
      """
    */
    @Test
    def void testExpressionAcceptance_06() {
        test('''
        MATCH (n {name: 'Apa'})
        RETURN n['nam' + 'e'] AS value
        ''')
    }

    /*
    Scenario: Execute n['name'] in update queries
    */
    @Test
    def void testExpressionAcceptance_07() {
        test('''
        CREATE (n {name: 'Apa'})
        RETURN n['nam' + 'e'] AS value
        ''')
    }

    /*
    Scenario: Use dynamic property lookup based on parameters when there is no type information
    And parameters are:
      | expr | {name: 'Apa'} |
      | idx  | 'name'        |
    */
    @Test
    def void testExpressionAcceptance_08() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[idx] AS value
        ''')
    }

    /*
    Scenario: Use dynamic property lookup based on parameters when there is lhs type information
    And parameters are:
      | idx | 'name' |
    */
    @Test
    def void testExpressionAcceptance_09() {
        test('''
        CREATE (n {name: 'Apa'})
        RETURN n[$idx] AS value
        ''')
    }

    /*
    Scenario: Use dynamic property lookup based on parameters when there is rhs type information
    And parameters are:
      | expr | {name: 'Apa'} |
      | idx  | 'name'        |
    */
    @Test
    def void testExpressionAcceptance_10() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[toString(idx)] AS value
        ''')
    }

    /*
    Scenario: Use collection lookup based on parameters when there is no type information
    And parameters are:
      | expr | ['Apa'] |
      | idx  | 0       |
    */
    @Test
    def void testExpressionAcceptance_11() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[idx] AS value
        ''')
    }

    /*
    Scenario: Use collection lookup based on parameters when there is lhs type information
    And parameters are:
      | idx | 0 |
    */
    @Test
    def void testExpressionAcceptance_12() {
        test('''
        WITH ['Apa'] AS expr
        RETURN expr[$idx] AS value
        ''')
    }

    /*
    Scenario: Use collection lookup based on parameters when there is rhs type information
    And parameters are:
      | expr | ['Apa'] |
      | idx  | 0       |
    */
    @Test
    def void testExpressionAcceptance_13() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[toInteger(idx)] AS value
        ''')
    }

    /*
    Scenario: Fail at runtime when attempting to index with an Int into a Map
    And parameters are:
      | expr | {name: 'Apa'} |
      | idx  | 0             |
    */
    @Test
    def void testExpressionAcceptance_14() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[idx]
        ''')
    }

    /*
    Scenario: Fail at runtime when trying to index into a map with a non-string
    And parameters are:
      | expr | {name: 'Apa'} |
      | idx  | 12.3          |
    */
    @Test
    def void testExpressionAcceptance_15() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[idx]
        ''')
    }

    /*
    Scenario: Fail at runtime when attempting to index with a String into a Collection
    And parameters are:
      | expr | ['Apa'] |
      | idx  | 'name'  |
    */
    @Test
    def void testExpressionAcceptance_16() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[idx]
        ''')
    }

    /*
    Scenario: Fail at runtime when trying to index into a list with a list
    And parameters are:
      | expr | ['Apa'] |
      | idx  | ['Apa'] |
    */
    @Test
    def void testExpressionAcceptance_17() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[idx]
        ''')
    }

    /*
    Scenario: Fail at runtime when trying to index something which is not a map or collection
    And parameters are:
      | expr | 100 |
      | idx  | 0   |
    */
    @Test
    def void testExpressionAcceptance_18() {
        test('''
        WITH $expr AS expr, $idx AS idx
        RETURN expr[idx]
        ''')
    }

}
