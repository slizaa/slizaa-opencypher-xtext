package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class LabelsAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Adding a single label
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testLabelsAcceptance_01() {
        test('''
        MATCH (n)
        SET n:Foo
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Ignore space before colon
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testLabelsAcceptance_02() {
        test('''
        MATCH (n)
        SET n :Foo
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Adding multiple labels
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testLabelsAcceptance_03() {
        test('''
        MATCH (n)
        SET n:Foo:Bar
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Ignoring intermediate whitespace 1
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testLabelsAcceptance_04() {
        test('''
        MATCH (n)
        SET n :Foo :Bar
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Ignoring intermediate whitespace 2
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testLabelsAcceptance_05() {
        test('''
        MATCH (n)
        SET n :Foo:Bar
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Creating node without label
    */
    @Test
    def void testLabelsAcceptance_06() {
        test('''
        CREATE (node)
        RETURN labels(node)
        ''')
    }

    /*
    Scenario: Creating node with two labels
    */
    @Test
    def void testLabelsAcceptance_07() {
        test('''
        CREATE (node:Foo:Bar {name: 'Mattias'})
        RETURN labels(node)
        ''')
    }

    /*
    Scenario: Ignore space when creating node with labels
    */
    @Test
    def void testLabelsAcceptance_08() {
        test('''
        CREATE (node :Foo:Bar)
        RETURN labels(node)
        ''')
    }

    /*
    Scenario: Create node with label in pattern
    */
    @Test
    def void testLabelsAcceptance_09() {
        test('''
        CREATE (n:Person)-[:OWNS]->(:Dog)
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Using `labels()` in return clauses
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testLabelsAcceptance_10() {
        test('''
        MATCH (n)
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Removing a label
    And having executed:
      """
      CREATE (:Foo:Bar)
      """
    */
    @Test
    def void testLabelsAcceptance_11() {
        test('''
        MATCH (n)
        REMOVE n:Foo
        RETURN labels(n)
        ''')
    }

    /*
    Scenario: Removing a non-existent label
    And having executed:
      """
      CREATE (:Foo)
      """
    */
    @Test
    def void testLabelsAcceptance_12() {
        test('''
        MATCH (n)
        REMOVE n:Bar
        RETURN labels(n)
        ''')
    }

}
