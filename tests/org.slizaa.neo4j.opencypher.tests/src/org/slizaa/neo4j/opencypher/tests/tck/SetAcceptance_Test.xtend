package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class SetAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Setting a node property to null removes the existing property
    Given an empty graph
    And having executed:
      """
      CREATE (:A {property1: 23, property2: 46})
      """
    */
    @Test
    def void testSetAcceptance_01() {
        test('''
        MATCH (n:A)
        SET n.property1 = null
        RETURN n
        ''')
    }

    /*
    Scenario: Setting a relationship property to null removes the existing property
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:REL {property1: 12, property2: 24}]->()
      """
    */
    @Test
    def void testSetAcceptance_02() {
        test('''
        MATCH ()-[r]->()
        SET r.property1 = null
        RETURN r
        ''')
    }

    /*
    Scenario: Set a property
    Given any graph
    And having executed:
      """
      CREATE (:A {name: 'Andres'})
      """
    */
    @Test
    def void testSetAcceptance_03() {
        test('''
        MATCH (n:A)
        WHERE n.name = 'Andres'
        SET n.name = 'Michael'
        RETURN n
        ''')
    }

    /*
    Scenario: Set a property to an expression
    Given an empty graph
    And having executed:
      """
      CREATE (:A {name: 'Andres'})
      """
    */
    @Test
    def void testSetAcceptance_04() {
        test('''
        MATCH (n:A)
        WHERE n.name = 'Andres'
        SET n.name = n.name + ' was here'
        RETURN n
        ''')
    }

    /*
    Scenario: Set a property by selecting the node using a simple expression
    Given an empty graph
    And having executed:
      """
      CREATE (:A)
      """
    */
    @Test
    def void testSetAcceptance_05() {
        test('''
        MATCH (n:A)
        SET (n).name = 'neo4j'
        RETURN n
        ''')
    }

    /*
    Scenario: Set a property by selecting the relationship using a simple expression
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:REL]->()
      """
    */
    @Test
    def void testSetAcceptance_06() {
        test('''
        MATCH ()-[r:REL]->()
        SET (r).name = 'neo4j'
        RETURN r
        ''')
    }

    /*
    Scenario: Setting a property to null removes the property
    Given an empty graph
    And having executed:
      """
      CREATE (:A {name: 'Michael', age: 35})
      """
    */
    @Test
    def void testSetAcceptance_07() {
        test('''
        MATCH (n)
        WHERE n.name = 'Michael'
        SET n.name = null
        RETURN n
        ''')
    }

    /*
    Scenario: Add a label to a node
    Given an empty graph
    And having executed:
      """
      CREATE (:A)
      """
    */
    @Test
    def void testSetAcceptance_08() {
        test('''
        MATCH (n:A)
        SET n:Foo
        RETURN n
        ''')
    }

    /*
    Scenario: Adding a list property
    Given an empty graph
    And having executed:
      """
      CREATE (:A)
      """
    */
    @Test
    def void testSetAcceptance_09() {
        test('''
        MATCH (n:A)
        SET n.x = [1, 2, 3]
        RETURN [i IN n.x | i / 2.0] AS x
        ''')
    }

    /*
    Scenario: Concatenate elements onto a list property
    Given any graph
    */
    @Test
    def void testSetAcceptance_10() {
        test('''
        CREATE (a {foo: [1, 2, 3]})
        SET a.foo = a.foo + [4, 5]
        RETURN a.foo
        ''')
    }

    /*
    Scenario: Concatenate elements in reverse onto a list property
    Given any graph
    */
    @Test
    def void testSetAcceptance_11() {
        test('''
        CREATE (a {foo: [3, 4, 5]})
        SET a.foo = [1, 2] + a.foo
        RETURN a.foo
        ''')
    }

    /*
    Scenario: Overwrite values when using +=
    Given an empty graph
    And having executed:
      """
      CREATE (:X {foo: 'A', bar: 'B'})
      """
    */
    @Test
    def void testSetAcceptance_12() {
        test('''
        MATCH (n:X {foo: 'A'})
        SET n += {bar: 'C'}
        RETURN n
        ''')
    }

    /*
    Scenario: Retain old values when using +=
    Given an empty graph
    And having executed:
      """
      CREATE (:X {foo: 'A'})
      """
    */
    @Test
    def void testSetAcceptance_13() {
        test('''
        MATCH (n:X {foo: 'A'})
        SET n += {bar: 'B'}
        RETURN n
        ''')
    }

    /*
    Scenario: Explicit null values in a map remove old values
    Given an empty graph
    And having executed:
      """
      CREATE (:X {foo: 'A', bar: 'B'})
      """
    */
    @Test
    def void testSetAcceptance_14() {
        test('''
        MATCH (n:X {foo: 'A'})
        SET n += {foo: null}
        RETURN n
        ''')
    }

    /*
    Scenario: Non-existent values in a property map are removed with SET =
    Given an empty graph
    And having executed:
      """
      CREATE (:X {foo: 'A', bar: 'B'})
      """
    */
    @Test
    def void testSetAcceptance_15() {
        test('''
        MATCH (n:X {foo: 'A'})
        SET n = {foo: 'B', baz: 'C'}
        RETURN n
        ''')
    }

}
