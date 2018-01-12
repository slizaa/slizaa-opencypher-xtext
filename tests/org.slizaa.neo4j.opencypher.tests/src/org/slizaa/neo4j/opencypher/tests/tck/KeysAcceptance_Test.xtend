package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class KeysAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Using `keys()` on a single node, non-empty result
    Given an empty graph
    And having executed:
      """
      CREATE ({name: 'Andres', surname: 'Lopez'})
      """
    */
    @Test
    def void testKeysAcceptance_01() {
        test('''
        MATCH (n)
        UNWIND keys(n) AS x
        RETURN DISTINCT x AS theProps
        ''')
    }

    /*
    Scenario: Using `keys()` on multiple nodes, non-empty result
    Given an empty graph
    And having executed:
      """
      CREATE ({name: 'Andres', surname: 'Lopez'}),
             ({otherName: 'Andres', otherSurname: 'Lopez'})
      """
    */
    @Test
    def void testKeysAcceptance_02() {
        test('''
        MATCH (n)
        UNWIND keys(n) AS x
        RETURN DISTINCT x AS theProps
        ''')
    }

    /*
    Scenario: Using `keys()` on a single node, empty result
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testKeysAcceptance_03() {
        test('''
        MATCH (n)
        UNWIND keys(n) AS x
        RETURN DISTINCT x AS theProps
        ''')
    }

    /*
    Scenario: Using `keys()` on an optionally matched node
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testKeysAcceptance_04() {
        test('''
        OPTIONAL MATCH (n)
        UNWIND keys(n) AS x
        RETURN DISTINCT x AS theProps
        ''')
    }

    /*
    Scenario: Using `keys()` on a relationship, non-empty result
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:KNOWS {level: 'bad', year: '2015'}]->()
      """
    */
    @Test
    def void testKeysAcceptance_05() {
        test('''
        MATCH ()-[r:KNOWS]-()
        UNWIND keys(r) AS x
        RETURN DISTINCT x AS theProps
        ''')
    }

    /*
    Scenario: Using `keys()` on a relationship, empty result
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:KNOWS]->()
      """
    */
    @Test
    def void testKeysAcceptance_06() {
        test('''
        MATCH ()-[r:KNOWS]-()
        UNWIND keys(r) AS x
        RETURN DISTINCT x AS theProps
        ''')
    }

    /*
    Scenario: Using `keys()` on an optionally matched relationship
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:KNOWS]->()
      """
    */
    @Test
    def void testKeysAcceptance_07() {
        test('''
        OPTIONAL MATCH ()-[r:KNOWS]-()
        UNWIND keys(r) AS x
        RETURN DISTINCT x AS theProps
        ''')
    }

    /*
    Scenario: Using `keys()` on a literal map
    Given any graph
    */
    @Test
    def void testKeysAcceptance_08() {
        test('''
        RETURN keys({name: 'Alice', age: 38, address: {city: 'London', residential: true}}) AS k
        ''')
    }

    /*
    Scenario: Using `keys()` on a parameter map
    Given any graph
    And parameters are:
      | param | {name: 'Alice', age: 38, address: {city: 'London', residential: true}} |
    */
    @Test
    def void testKeysAcceptance_09() {
        test('''
        RETURN keys($param) AS k
        ''')
    }

}
