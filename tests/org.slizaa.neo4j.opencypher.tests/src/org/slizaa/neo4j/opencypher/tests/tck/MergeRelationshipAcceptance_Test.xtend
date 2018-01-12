package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class MergeRelationshipAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Creating a relationship
    Given an empty graph
    And having executed:
      """
      CREATE (:A), (:B)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_01() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE]->(b)
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Matching a relationship
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      CREATE (a)-[:TYPE]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_02() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE]->(b)
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Matching two relationships
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      CREATE (a)-[:TYPE]->(b)
      CREATE (a)-[:TYPE]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_03() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE]->(b)
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Filtering relationships
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      CREATE (a)-[:TYPE {name: 'r1'}]->(b)
      CREATE (a)-[:TYPE {name: 'r2'}]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_04() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE {name: 'r2'}]->(b)
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Creating relationship when all matches filtered out
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      CREATE (a)-[:TYPE {name: 'r1'}]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_05() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE {name: 'r2'}]->(b)
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Matching incoming relationship
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      CREATE (b)-[:TYPE]->(a)
      CREATE (a)-[:TYPE]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_06() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)<-[r:TYPE]-(b)
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Creating relationship with property
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_07() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE {name: 'Lola'}]->(b)
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Using ON CREATE on a node
    Given an empty graph
    And having executed:
      """
      CREATE (:A), (:B)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_08() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[:KNOWS]->(b)
        ON CREATE SET b.created = 1
        ''')
    }

    /*
    Scenario: Using ON CREATE on a relationship
    Given an empty graph
    And having executed:
      """
      CREATE (:A), (:B)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_09() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE]->(b)
        ON CREATE SET r.name = 'Lola'
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Using ON MATCH on created node
    Given an empty graph
    And having executed:
      """
      CREATE (:A), (:B)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_10() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[:KNOWS]->(b)
        ON MATCH SET b.created = 1
        ''')
    }

    /*
    Scenario: Using ON MATCH on created relationship
    Given an empty graph
    And having executed:
      """
      CREATE (:A), (:B)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_11() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:KNOWS]->(b)
        ON MATCH SET r.created = 1
        ''')
    }

    /*
    Scenario: Using ON MATCH on a relationship
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      CREATE (a)-[:TYPE]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_12() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE]->(b)
        ON MATCH SET r.name = 'Lola'
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Using ON CREATE and ON MATCH
    Given an empty graph
    And having executed:
      """
      CREATE (a:A {id: 1}), (b:B {id: 2})
      CREATE (a)-[:TYPE]->(b)
      CREATE (:A {id: 3}), (:B {id: 4})
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_13() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:TYPE]->(b)
        ON CREATE SET r.name = 'Lola'
        ON MATCH SET r.name = 'RUN'
        RETURN count(r)
        ''')
    }

    /*
    Scenario: Creating relationship using merged nodes
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_14() {
        test('''
        MERGE (a:A)
        MERGE (b:B)
        MERGE (a)-[:FOO]->(b)
        ''')
    }

    /*
    Scenario: Mixing MERGE with CREATE
    Given an empty graph
    */
    @Test
    def void testMergeRelationshipAcceptance_15() {
        test('''
        CREATE (a:A), (b:B)
        MERGE (a)-[:KNOWS]->(b)
        CREATE (b)-[:KNOWS]->(c:C)
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Introduce named paths 1
    Given an empty graph
    */
    @Test
    def void testMergeRelationshipAcceptance_16() {
        test('''
        MERGE (a {x: 1})
        MERGE (b {x: 2})
        MERGE p = (a)-[:R]->(b)
        RETURN p
        ''')
    }

    /*
    Scenario: Introduce named paths 2
    Given an empty graph
    */
    @Test
    def void testMergeRelationshipAcceptance_17() {
        test('''
        MERGE p = (a {x: 1})
        RETURN p
        ''')
    }

    /*
    Scenario: Use outgoing direction when unspecified
    Given an empty graph
    */
    @Test
    def void testMergeRelationshipAcceptance_18() {
        test('''
        CREATE (a {id: 2}), (b {id: 1})
        MERGE (a)-[r:KNOWS]-(b)
        RETURN startNode(r).id AS s, endNode(r).id AS e
        ''')
    }

    /*
    Scenario: Match outgoing relationship when direction unspecified
    Given an empty graph
    And having executed:
      """
      CREATE (a {id: 1}), (b {id: 2})
      CREATE (a)-[:KNOWS]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_19() {
        test('''
        MATCH (a {id: 2}), (b {id: 1})
        MERGE (a)-[r:KNOWS]-(b)
        RETURN r
        ''')
    }

    /*
    Scenario: Match both incoming and outgoing relationships when direction unspecified
    Given an empty graph
    And having executed:
      """
      CREATE (a {id: 2}), (b {id: 1}), (c {id: 1}), (d {id: 2})
      CREATE (a)-[:KNOWS {name: 'ab'}]->(b)
      CREATE (c)-[:KNOWS {name: 'cd'}]->(d)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_20() {
        test('''
        MATCH (a {id: 2})--(b {id: 1})
        MERGE (a)-[r:KNOWS]-(b)
        RETURN r
        ''')
    }

    /*
    Scenario: Using list properties via variable
    Given an empty graph
    */
    @Test
    def void testMergeRelationshipAcceptance_21() {
        test('''
        CREATE (a:Foo), (b:Bar)
        WITH a, b
        UNWIND ['a,b', 'a,b'] AS str
        WITH a, b, split(str, ',') AS roles
        MERGE (a)-[r:FB {foobar: roles}]->(b)
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Matching using list property
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      CREATE (a)-[:T {prop: [42, 43]}]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_22() {
        test('''
        MATCH (a:A), (b:B)
        MERGE (a)-[r:T {prop: [42, 43]}]->(b)
        RETURN count(*)
        ''')
    }

    /*
    Scenario: Using bound variables from other updating clause
    Given an empty graph
    */
    @Test
    def void testMergeRelationshipAcceptance_23() {
        test('''
        CREATE (a), (b)
        MERGE (a)-[:X]->(b)
        RETURN count(a)
        ''')
    }

    /*
    Scenario: UNWIND with multiple merges
    Given an empty graph
    */
    @Test
    def void testMergeRelationshipAcceptance_24() {
        test('''
        UNWIND ['Keanu Reeves', 'Hugo Weaving', 'Carrie-Anne Moss', 'Laurence Fishburne'] AS actor
        MERGE (m:Movie {name: 'The Matrix'})
        MERGE (p:Person {name: actor})
        MERGE (p)-[:ACTED_IN]->(m)
        ''')
    }

    /*
    Scenario: Do not match on deleted entities
    Given an empty graph
    And having executed:
      """
      CREATE (a:A)
      CREATE (b1:B {value: 0}), (b2:B {value: 1})
      CREATE (c1:C), (c2:C)
      CREATE (a)-[:REL]->(b1),
             (a)-[:REL]->(b2),
             (b1)-[:REL]->(c1),
             (b2)-[:REL]->(c2)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_25() {
        test('''
        MATCH (a:A)-[ab]->(b:B)-[bc]->(c:C)
        DELETE ab, bc, b, c
        MERGE (newB:B {value: 1})
        MERGE (a)-[:REL]->(newB)
        MERGE (newC:C)
        MERGE (newB)-[:REL]->(newC)
        ''')
    }

    /*
    Scenario: Do not match on deleted relationships
    Given an empty graph
    And having executed:
      """
      CREATE (a:A), (b:B)
      CREATE (a)-[:T {name: 'rel1'}]->(b),
             (a)-[:T {name: 'rel2'}]->(b)
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_26() {
        test('''
        MATCH (a)-[t:T]->(b)
        DELETE t
        MERGE (a)-[t2:T {name: 'rel3'}]->(b)
        RETURN t2.name
        ''')
    }

    /*
    Scenario: Aliasing of existing nodes 1
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 0})
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_27() {
        test('''
        MATCH (n)
        MATCH (m)
        WITH n AS a, m AS b
        MERGE (a)-[r:T]->(b)
        RETURN a.id AS a, b.id AS b
        ''')
    }

    /*
    Scenario: Aliasing of existing nodes 2
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 0})
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_28() {
        test('''
        MATCH (n)
        WITH n AS a, n AS b
        MERGE (a)-[r:T]->(b)
        RETURN a.id AS a
        ''')
    }

    /*
    Scenario: Double aliasing of existing nodes 1
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 0})
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_29() {
        test('''
        MATCH (n)
        MATCH (m)
        WITH n AS a, m AS b
        MERGE (a)-[:T]->(b)
        WITH a AS x, b AS y
        MERGE (a)
        MERGE (b)
        MERGE (a)-[:T]->(b)
        RETURN x.id AS x, y.id AS y
        ''')
    }

    /*
    Scenario: Double aliasing of existing nodes 2
    Given an empty graph
    And having executed:
      """
      CREATE ({id: 0})
      """
    */
    @Test
    def void testMergeRelationshipAcceptance_30() {
        test('''
        MATCH (n)
        WITH n AS a
        MERGE (c)
        MERGE (a)-[:T]->(c)
        WITH a AS x
        MERGE (c)
        MERGE (x)-[:T]->(c)
        RETURN x.id AS x
        ''')
    }

}
