package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class CreateAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Create a single node with multiple labels
    Given any graph
    */
    @Test
    def void testCreateAcceptance_01() {
        test('''
        CREATE (:A:B:C:D)
        ''')
    }

    /*
    Scenario: Combine MATCH and CREATE
    Given an empty graph
    And having executed:
      """
      CREATE (), ()
      """
    */
    @Test
    def void testCreateAcceptance_02() {
        test('''
        MATCH ()
        CREATE ()
        ''')
    }

    /*
    Scenario: Combine MATCH, WITH and CREATE
    Given an empty graph
    And having executed:
      """
      CREATE (), ()
      """
    */
    @Test
    def void testCreateAcceptance_03() {
        test('''
        MATCH ()
        CREATE ()
        WITH *
        MATCH ()
        CREATE ()
        ''')
    }

    /*
    Scenario: Newly-created nodes not visible to preceding MATCH
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testCreateAcceptance_04() {
        test('''
        MATCH ()
        CREATE ()
        ''')
    }

    /*
    Scenario: Create a single node with properties
    Given any graph
    */
    @Test
    def void testCreateAcceptance_05() {
        test('''
        CREATE (n {prop: 'foo'})
        RETURN n.prop AS p
        ''')
    }

    /*
    Scenario: Creating a node with null properties should not return those properties
    Given any graph
    */
    @Test
    def void testCreateAcceptance_06() {
        test('''
        CREATE (n {id: 12, property: null})
        RETURN n.id AS id
        ''')
    }

    /*
    Scenario: Creating a relationship with null properties should not return those properties
    Given any graph
    */
    @Test
    def void testCreateAcceptance_07() {
        test('''
        CREATE ()-[r:X {id: 12, property: null}]->()
        RETURN r.id
        ''')
    }

    /*
    Scenario: Create a simple pattern
    Given any graph
    */
    @Test
    def void testCreateAcceptance_08() {
        test('''
        CREATE ()-[:R]->()
        ''')
    }

    /*
    Scenario: Create a self loop
    Given any graph
    */
    @Test
    def void testCreateAcceptance_09() {
        test('''
        CREATE (root:R)-[:LINK]->(root)
        ''')
    }

    /*
    Scenario: Create a self loop using MATCH
    Given an empty graph
    And having executed:
      """
      CREATE (:R)
      """
    */
    @Test
    def void testCreateAcceptance_10() {
        test('''
        MATCH (root:R)
        CREATE (root)-[:LINK]->(root)
        ''')
    }

    /*
    Scenario: Create nodes and relationships
    Given any graph
    */
    @Test
    def void testCreateAcceptance_11() {
        test('''
        CREATE (a), (b),
        (a)-[:R]->(b)
        ''')
    }

    /*
    Scenario: Create a relationship with a property
    Given any graph
    */
    @Test
    def void testCreateAcceptance_12() {
        test('''
        CREATE ()-[:R {prop: 42}]->()
        ''')
    }

    /*
    Scenario: Create a relationship with the correct direction
    Given an empty graph
    And having executed:
      """
      CREATE (:X)
      CREATE (:Y)
      """
    */
    @Test
    def void testCreateAcceptance_13() {
        test('''
        MATCH (x:X), (y:Y)
        CREATE (x)<-[:TYPE]-(y)
        ''')
    }

    /*
    Scenario: Create a relationship and an end node from a matched starting node
    Given an empty graph
    And having executed:
      """
      CREATE (:Begin)
      """
    */
    @Test
    def void testCreateAcceptance_14() {
        test('''
        MATCH (x:Begin)
        CREATE (x)-[:TYPE]->(:End)
        ''')
    }

    /*
    Scenario: Create a single node after a WITH
    Given an empty graph
    And having executed:
      """
      CREATE (), ()
      """
    */
    @Test
    def void testCreateAcceptance_15() {
        test('''
        MATCH ()
        CREATE ()
        WITH *
        CREATE ()
        ''')
    }

    /*
    Scenario: Create a relationship with a reversed direction
    Given an empty graph
    */
    @Test
    def void testCreateAcceptance_16() {
        test('''
        CREATE (:A)<-[:R]-(:B)
        ''')
    }

    /*
    Scenario: Create a pattern with multiple hops
    Given an empty graph
    */
    @Test
    def void testCreateAcceptance_17() {
        test('''
        CREATE (:A)-[:R]->(:B)-[:R]->(:C)
        ''')
    }

    /*
    Scenario: Create a pattern with multiple hops in the reverse direction
    Given any graph
    */
    @Test
    def void testCreateAcceptance_18() {
        test('''
        CREATE (:A)<-[:R]-(:B)<-[:R]-(:C)
        ''')
    }

    /*
    Scenario: Create a pattern with multiple hops in varying directions
    Given any graph
    */
    @Test
    def void testCreateAcceptance_19() {
        test('''
        CREATE (:A)-[:R]->(:B)<-[:R]-(:C)
        ''')
    }

    /*
    Scenario: Create a pattern with multiple hops with multiple types and varying directions
    Given any graph
    */
    @Test
    def void testCreateAcceptance_20() {
        test('''
        CREATE ()-[:R1]->()<-[:R2]-()-[:R3]->()
        ''')
    }

    /*
    Scenario: Nodes are not created when aliases are applied to variable names
    Given an empty graph
    And having executed:
      """
      CREATE ({foo: 1})
      """
    */
    @Test
    def void testCreateAcceptance_21() {
        test('''
        MATCH (n)
        MATCH (m)
        WITH n AS a, m AS b
        CREATE (a)-[:T]->(b)
        RETURN a, b
        ''')
    }

    /*
    Scenario: Only a single node is created when an alias is applied to a variable name
    Given an empty graph
    And having executed:
      """
      CREATE (:X)
      """
    */
    @Test
    def void testCreateAcceptance_22() {
        test('''
        MATCH (n)
        WITH n AS a
        CREATE (a)-[:T]->()
        RETURN a
        ''')
    }

    /*
    Scenario: Nodes are not created when aliases are applied to variable names multiple times
    Given an empty graph
    And having executed:
      """
      CREATE ({foo: 'A'})
      """
    */
    @Test
    def void testCreateAcceptance_23() {
        test('''
        MATCH (n)
        MATCH (m)
        WITH n AS a, m AS b
        CREATE (a)-[:T]->(b)
        WITH a AS x, b AS y
        CREATE (x)-[:T]->(y)
        RETURN x, y
        ''')
    }

    /*
    Scenario: Only a single node is created when an alias is applied to a variable name multiple times
    Given an empty graph
    And having executed:
      """
      CREATE ({foo: 5})
      """
    */
    @Test
    def void testCreateAcceptance_24() {
        test('''
        MATCH (n)
        WITH n AS a
        CREATE (a)-[:T]->()
        WITH a AS x
        CREATE (x)-[:T]->()
        RETURN x
        ''')
    }

    /*
    Scenario: A bound node should be recognized after projection with WITH + WITH
    Given any graph
    */
    @Test
    def void testCreateAcceptance_25() {
        test('''
        CREATE (a)
        WITH a
        WITH *
        CREATE (b)
        CREATE (a)<-[:T]-(b)
        ''')
    }

    /*
    Scenario: A bound node should be recognized after projection with WITH + UNWIND
    Given any graph
    */
    @Test
    def void testCreateAcceptance_26() {
        test('''
        CREATE (a)
        WITH a
        UNWIND [0] AS i
        CREATE (b)
        CREATE (a)<-[:T]-(b)
        ''')
    }

    /*
    Scenario: A bound node should be recognized after projection with WITH + MERGE node
    Given an empty graph
    */
    @Test
    def void testCreateAcceptance_27() {
        test('''
        CREATE (a)
        WITH a
        MERGE ()
        CREATE (b)
        CREATE (a)<-[:T]-(b)
        ''')
    }

    /*
    Scenario: A bound node should be recognized after projection with WITH + MERGE pattern
    Given an empty graph
    */
    @Test
    def void testCreateAcceptance_28() {
        test('''
        CREATE (a)
        WITH a
        MERGE (x)
        MERGE (y)
        MERGE (x)-[:T]->(y)
        CREATE (b)
        CREATE (a)<-[:T]-(b)
        ''')
    }

    /*
    Scenario: Creating a pattern with multiple hops and changing directions
    Given an empty graph
    */
    @Test
    def void testCreateAcceptance_29() {
        test('''
        CREATE (:A)<-[:R1]-(:B)-[:R2]->(:C)
        ''')
    }

}
