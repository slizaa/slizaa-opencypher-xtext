package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class TypeConversionFunctions_Test extends AbstractCypherTest {
    
    /*
    Scenario: `toBoolean()` on valid literal string
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_01() {
        test('''
        RETURN toBoolean('true') AS b
        ''')
    }

    /*
    Scenario: `toBoolean()` on booleans
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_02() {
        test('''
        UNWIND [true, false] AS b
        RETURN toBoolean(b) AS b
        ''')
    }

    /*
    Scenario: `toBoolean()` on variables with valid string values
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_03() {
        test('''
        UNWIND ['true', 'false'] AS s
        RETURN toBoolean(s) AS b
        ''')
    }

    /*
    Scenario: `toBoolean()` on invalid strings
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_04() {
        test('''
        UNWIND [null, '', ' tru ', 'f alse'] AS things
        RETURN toBoolean(things) AS b
        ''')
    }

    /*
    Scenario: `toInteger()`
    Given an empty graph
    And having executed:
      """
      CREATE (:Person {age: '42'})
      """
    */
    @Test
    def void testTypeConversionFunctions_05() {
        test('''
        MATCH (p:Person { age: '42' })
        WITH *
        MATCH (n)
        RETURN toInteger(n.age) AS age
        ''')
    }

    /*
    Scenario: `toInteger()` on float
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_06() {
        test('''
        WITH 82.9 AS weight
        RETURN toInteger(weight)
        ''')
    }

    /*
    Scenario: `toInteger()` returning null on non-numerical string
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_07() {
        test('''
        WITH 'foo' AS foo_string, '' AS empty_string
        RETURN toInteger(foo_string) AS foo, toInteger(empty_string) AS empty
        ''')
    }

    /*
    Scenario: `toInteger()` handling mixed number types
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_08() {
        test('''
        WITH [2, 2.9] AS numbers
        RETURN [n IN numbers | toInteger(n)] AS int_numbers
        ''')
    }

    /*
    Scenario: `toInteger()` handling Any type
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_09() {
        test('''
        WITH [2, 2.9, '1.7'] AS things
        RETURN [n IN things | toInteger(n)] AS int_numbers
        ''')
    }

    /*
    Scenario: `toInteger()` on a list of strings
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_10() {
        test('''
        WITH ['2', '2.9', 'foo'] AS numbers
        RETURN [n IN numbers | toInteger(n)] AS int_numbers
        ''')
    }

    /*
    Scenario: `toInteger()` on a complex-typed expression
    Given any graph
    And parameters are:
      | param | 1 |
    */
    @Test
    def void testTypeConversionFunctions_11() {
        test('''
        RETURN toInteger(1 - $param) AS result
        ''')
    }

    /*
    Scenario: `toFloat()`
    Given an empty graph
    And having executed:
      """
      CREATE (:Movie {rating: 4})
      """
    */
    @Test
    def void testTypeConversionFunctions_12() {
        test('''
        MATCH (m:Movie { rating: 4 })
        WITH *
        MATCH (n)
        RETURN toFloat(n.rating) AS float
        ''')
    }

    /*
    Scenario: `toFloat()` on mixed number types
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_13() {
        test('''
        WITH [3.4, 3] AS numbers
        RETURN [n IN numbers | toFloat(n)] AS float_numbers
        ''')
    }

    /*
    Scenario: `toFloat()` returning null on non-numerical string
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_14() {
        test('''
        WITH 'foo' AS foo_string, '' AS empty_string
        RETURN toFloat(foo_string) AS foo, toFloat(empty_string) AS empty
        ''')
    }

    /*
    Scenario: `toFloat()` handling Any type
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_15() {
        test('''
        WITH [3.4, 3, '5'] AS numbers
        RETURN [n IN numbers | toFloat(n)] AS float_numbers
        ''')
    }

    /*
    Scenario: `toFloat()` on a list of strings
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_16() {
        test('''
        WITH ['1', '2', 'foo'] AS numbers
        RETURN [n IN numbers | toFloat(n)] AS float_numbers
        ''')
    }

    /*
    Scenario: `toString()`
    Given an empty graph
    And having executed:
      """
      CREATE (:Movie {rating: 4})
      """
    */
    @Test
    def void testTypeConversionFunctions_17() {
        test('''
        MATCH (m:Movie { rating: 4 })
        WITH *
        MATCH (n)
        RETURN toString(n.rating)
        ''')
    }

    /*
    Scenario: `toString()` handling boolean properties
    Given an empty graph
    And having executed:
      """
      CREATE (:Movie {watched: true})
      """
    */
    @Test
    def void testTypeConversionFunctions_18() {
        test('''
        MATCH (m:Movie)
        RETURN toString(m.watched)
        ''')
    }

    /*
    Scenario: `toString()` handling inlined boolean
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_19() {
        test('''
        RETURN toString(1 < 0) AS bool
        ''')
    }

    /*
    Scenario: `toString()` handling boolean literal
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_20() {
        test('''
        RETURN toString(true) AS bool
        ''')
    }

    /*
    Scenario: `toString()` should work on Any type
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_21() {
        test('''
        RETURN [x IN [1, 2.3, true, 'apa'] | toString(x) ] AS list
        ''')
    }

    /*
    Scenario: `toString()` on a list of integers
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_22() {
        test('''
        WITH [1, 2, 3] AS numbers
        RETURN [n IN numbers | toString(n)] AS string_numbers
        ''')
    }

    /*
    Scenario: `toString()` should accept potentially correct types 1
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_23() {
        test('''
        UNWIND ['male', 'female', null] AS gen
        RETURN coalesce(toString(gen), 'x') AS result
        ''')
    }

    /*
    Scenario: `toString()` should accept potentially correct types 2
    Given any graph
    */
    @Test
    def void testTypeConversionFunctions_24() {
        test('''
        UNWIND ['male', 'female', null] AS gen
        RETURN toString(coalesce(gen, 'x')) AS result
        ''')
    }

}
