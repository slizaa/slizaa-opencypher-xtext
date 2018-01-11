package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class MergeNodeAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Merge node when no nodes exist
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_01() {
        test('''
        MERGE (a)
        RETURN count(*) AS n
        ''')
    }

    /*
    Scenario: Merge node with label
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_02() {
        test('''
        MERGE (a:Label)
        RETURN labels(a)
        ''')
    }

    /*
    Scenario: Merge node with label add label on create
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_03() {
        test('''
        MERGE (a:Label)
        ON CREATE SET a:Foo
        RETURN labels(a)
        ''')
    }

    /*
    Scenario: Merge node with label add property on create
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_04() {
        test('''
        MERGE (a:Label)
        ON CREATE SET a.prop = 42
        RETURN a.prop
        ''')
    }

    /*
    Scenario: Merge node with label when it exists
    Given an empty graph
    And having executed:
      """
      CREATE (:Label {id: 1})
      """
    */
    @Test
    def void testMergeNodeAcceptance_05() {
        test('''
        MERGE (a:Label)
        RETURN a.id
        ''')
    }

    /*
    Scenario: Merge node should create when it doesn't match, properties
    Given an empty graph
    And having executed:
      """
      CREATE ({prop: 42})
      """
    */
    @Test
    def void testMergeNodeAcceptance_06() {
        test('''
        MERGE (a {prop: 43})
        RETURN a.prop
        ''')
    }

    /*
    Scenario: Merge node should create when it doesn't match, properties and label
    Given an empty graph
    And having executed:
      """
      CREATE (:Label {prop: 42})
      """
    */
    @Test
    def void testMergeNodeAcceptance_07() {
        test('''
        MERGE (a:Label {prop: 43})
        RETURN a.prop
        ''')
    }

    /*
    Scenario: Merge node with prop and label
    Given an empty graph
    And having executed:
      """
      CREATE (:Label {prop: 42})
      """
    */
    @Test
    def void testMergeNodeAcceptance_08() {
        test('''
        MERGE (a:Label {prop: 42})
        RETURN a.prop
        ''')
    }

    /*
    Scenario: Merge node with label add label on match when it exists
    Given an empty graph
    And having executed:
      """
      CREATE (:Label)
      """
    */
    @Test
    def void testMergeNodeAcceptance_09() {
        test('''
        MERGE (a:Label)
        ON MATCH SET a:Foo
        RETURN labels(a)
        ''')
    }

    /*
    Scenario: Merge node with label add property on update when it exists
    Given an empty graph
    And having executed:
      """
      CREATE (:Label)
      """
    */
    @Test
    def void testMergeNodeAcceptance_10() {
        test('''
        MERGE (a:Label)
        ON CREATE SET a.prop = 42
        RETURN a.prop
        ''')
    }

    /*
    Scenario: Merge node and set property on match
    Given an empty graph
    And having executed:
      """
      CREATE (:Label)
      """
    */
    @Test
    def void testMergeNodeAcceptance_11() {
        test('''
        MERGE (a:Label)
        ON MATCH SET a.prop = 42
        RETURN a.prop
        ''')
    }

    /*
    Scenario: Should work when finding multiple elements
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_12() {
        test('''
        CREATE (:X)
        CREATE (:X)
        MERGE (:X)
        ''')
    }

    /*
    Scenario: Should handle argument properly
    Given an empty graph
    And having executed:
      """
      CREATE ({x: 42}),
        ({x: 'not42'})
      """
    */
    @Test
    def void testMergeNodeAcceptance_13() {
        test('''
        WITH 42 AS x
        MERGE (c:N {x: x})
        ''')
    }

    /*
    Scenario: Should handle arguments properly with only write clauses
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_14() {
        test('''
        CREATE (a {p: 1})
        MERGE ({v: a.p})
        ''')
    }

    /*
    Scenario: Should be able to merge using property from match
    Given an empty graph
    And having executed:
      """
      CREATE (:Person {name: 'A', bornIn: 'New York'})
      CREATE (:Person {name: 'B', bornIn: 'Ohio'})
      CREATE (:Person {name: 'C', bornIn: 'New Jersey'})
      CREATE (:Person {name: 'D', bornIn: 'New York'})
      CREATE (:Person {name: 'E', bornIn: 'Ohio'})
      CREATE (:Person {name: 'F', bornIn: 'New Jersey'})
      """
    */
    @Test
    def void testMergeNodeAcceptance_15() {
        test('''
        MATCH (person:Person)
        MERGE (city:City {name: person.bornIn})
        ''')
    }

    /*
    Scenario: Should be able to use properties from match in ON CREATE
    Given an empty graph
    And having executed:
      """
      CREATE (:Person {bornIn: 'New York'}),
        (:Person {bornIn: 'Ohio'})
      """
    */
    @Test
    def void testMergeNodeAcceptance_16() {
        test('''
        MATCH (person:Person)
        MERGE (city:City)
        ON CREATE SET city.name = person.bornIn
        RETURN person.bornIn
        ''')
    }

    /*
    Scenario: Should be able to use properties from match in ON MATCH
    Given an empty graph
    And having executed:
      """
      CREATE (:Person {bornIn: 'New York'}),
        (:Person {bornIn: 'Ohio'})
      """
    */
    @Test
    def void testMergeNodeAcceptance_17() {
        test('''
        MATCH (person:Person)
        MERGE (city:City)
        ON MATCH SET city.name = person.bornIn
        RETURN person.bornIn
        ''')
    }

    /*
    Scenario: Should be able to use properties from match in ON MATCH and ON CREATE
    Given an empty graph
    And having executed:
      """
      CREATE (:Person {bornIn: 'New York'}),
        (:Person {bornIn: 'Ohio'})
      """
    */
    @Test
    def void testMergeNodeAcceptance_18() {
        test('''
        MATCH (person:Person)
        MERGE (city:City)
        ON MATCH SET city.name = person.bornIn
        ON CREATE SET city.name = person.bornIn
        RETURN person.bornIn
        ''')
    }

    /*
    Scenario: Should be able to set labels on match
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testMergeNodeAcceptance_19() {
        test('''
        MERGE (a)
        ON MATCH SET a:L
        ''')
    }

    /*
    Scenario: Should be able to set labels on match and on create
    Given an empty graph
    And having executed:
      """
      CREATE (), ()
      """
    */
    @Test
    def void testMergeNodeAcceptance_20() {
        test('''
        MATCH ()
        MERGE (a:L)
        ON MATCH SET a:M1
        ON CREATE SET a:M2
        ''')
    }

    /*
    Scenario: Should support updates while merging
    Given an empty graph
    And having executed:
      """
      UNWIND [0, 1, 2] AS x
      UNWIND [0, 1, 2] AS y
      CREATE ({x: x, y: y})
      """
    */
    @Test
    def void testMergeNodeAcceptance_21() {
        test('''
        MATCH (foo)
        WITH foo.x AS x, foo.y AS y
        MERGE (:N {x: x, y: y + 1})
        MERGE (:N {x: x, y: y})
        MERGE (:N {x: x + 1, y: y})
        RETURN x, y
        ''')
    }

    /*
    Scenario: Merge must properly handle multiple labels
    Given an empty graph
    And having executed:
      """
      CREATE (:L:A {prop: 42})
      """
    */
    @Test
    def void testMergeNodeAcceptance_22() {
        test('''
        MERGE (test:L:B {prop: 42})
        RETURN labels(test) AS labels
        ''')
    }

    /*
    Scenario: Merge followed by multiple creates
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_23() {
        test('''
        MERGE (t:T {id: 42})
        CREATE (f:R)
        CREATE (t)-[:REL]->(f)
        ''')
    }

    /*
    Scenario: Unwind combined with merge
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_24() {
        test('''
        UNWIND [1, 2, 3, 4] AS int
        MERGE (n {id: int})
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Merges should not be able to match on deleted nodes
    Given an empty graph
    And having executed:
      """
      CREATE (:A {value: 1}),
        (:A {value: 2})
      """
    */
    @Test
    def void testMergeNodeAcceptance_25() {
        test('''
        MATCH (a:A)
        DELETE a
        MERGE (a2:A)
        RETURN a2.value
        ''')
    }

    /*
    Scenario: ON CREATE on created nodes
    Given an empty graph
    */
    @Test
    def void testMergeNodeAcceptance_26() {
        test('''
        MERGE (b)
        ON CREATE SET b.created = 1
        ''')
    }

}
