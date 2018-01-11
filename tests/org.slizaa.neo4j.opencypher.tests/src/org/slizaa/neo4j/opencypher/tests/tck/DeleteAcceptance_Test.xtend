package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class DeleteAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Delete nodes
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testDeleteAcceptance_01() {
        test('''
        MATCH (n)
        DELETE n
        ''')
    }

    /*
    Scenario: Detach delete node
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testDeleteAcceptance_02() {
        test('''
        MATCH (n)
        DETACH DELETE n
        ''')
    }

    /*
    Scenario: Delete relationships
    Given an empty graph
    And having executed:
      """
      UNWIND range(0, 2) AS i
      CREATE ()-[:R]->()
      """
    */
    @Test
    def void testDeleteAcceptance_03() {
        test('''
        MATCH ()-[r]-()
        DELETE r
        ''')
    }

    /*
    Scenario: Deleting connected nodes
    Given an empty graph
    And having executed:
      """
      CREATE (x:X)
      CREATE (x)-[:R]->()
      CREATE (x)-[:R]->()
      CREATE (x)-[:R]->()
      """
    */
    @Test
    def void testDeleteAcceptance_04() {
        test('''
        MATCH (n:X)
        DELETE n
        ''')
    }

    /*
    Scenario: Detach deleting connected nodes and relationships
    Given an empty graph
    And having executed:
      """
      CREATE (x:X)
      CREATE (x)-[:R]->()
      CREATE (x)-[:R]->()
      CREATE (x)-[:R]->()
      """
    */
    @Test
    def void testDeleteAcceptance_05() {
        test('''
        MATCH (n:X)
        DETACH DELETE n
        ''')
    }

    /*
    Scenario: Detach deleting paths
    Given an empty graph
    And having executed:
      """
      CREATE (x:X), (n1), (n2), (n3)
      CREATE (x)-[:R]->(n1)
      CREATE (n1)-[:R]->(n2)
      CREATE (n2)-[:R]->(n3)
      """
    */
    @Test
    def void testDeleteAcceptance_06() {
        test('''
        MATCH p = (:X)-->()-->()-->()
        DETACH DELETE p
        ''')
    }

    /*
    Scenario: Undirected expand followed by delete and count
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:R]->()
      """
    */
    @Test
    def void testDeleteAcceptance_07() {
        test('''
        MATCH (a)-[r]-(b)
        DELETE r, a, b
        RETURN count(*) AS c
        ''')
    }

    /*
    Scenario: Undirected variable length expand followed by delete and count
    Given an empty graph
    And having executed:
      """
      CREATE (n1), (n2), (n3)
      CREATE (n1)-[:R]->(n2)
      CREATE (n2)-[:R]->(n3)
      """
    */
    @Test
    def void testDeleteAcceptance_08() {
        test('''
        MATCH (a)-[*]-(b)
        DETACH DELETE a, b
        RETURN count(*) AS c
        ''')
    }

    /*
    Scenario: Create and delete in same query
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testDeleteAcceptance_09() {
        test('''
        MATCH ()
        CREATE (n)
        DELETE n
        ''')
    }

    /*
    Scenario: Delete optionally matched relationship
    Given an empty graph
    And having executed:
      """
      CREATE ()
      """
    */
    @Test
    def void testDeleteAcceptance_10() {
        test('''
        MATCH (n)
        OPTIONAL MATCH (n)-[r]-()
        DELETE n, r
        ''')
    }

    /*
    Scenario: Delete on null node
    Given an empty graph
    */
    @Test
    def void testDeleteAcceptance_11() {
        test('''
        OPTIONAL MATCH (n)
        DELETE n
        ''')
    }

    /*
    Scenario: Detach delete on null node
    Given an empty graph
    */
    @Test
    def void testDeleteAcceptance_12() {
        test('''
        OPTIONAL MATCH (n)
        DETACH DELETE n
        ''')
    }

    /*
    Scenario: Delete on null path
    Given an empty graph
    */
    @Test
    def void testDeleteAcceptance_13() {
        test('''
        OPTIONAL MATCH p = ()-->()
        DETACH DELETE p
        ''')
    }

    /*
    Scenario: Delete node from a list
    Given an empty graph
    And having executed:
      """
      CREATE (u:User)
      CREATE (u)-[:FRIEND]->()
      CREATE (u)-[:FRIEND]->()
      CREATE (u)-[:FRIEND]->()
      CREATE (u)-[:FRIEND]->()
      """
    And parameters are:
      | friendIndex | 1 |
    */
    @Test
    def void testDeleteAcceptance_14() {
        test('''
        MATCH (:User)-[:FRIEND]->(n)
        WITH collect(n) AS friends
        DETACH DELETE friends[$friendIndex]
        ''')
    }

    /*
    Scenario: Delete relationship from a list
    Given an empty graph
    And having executed:
      """
      CREATE (u:User)
      CREATE (u)-[:FRIEND]->()
      CREATE (u)-[:FRIEND]->()
      CREATE (u)-[:FRIEND]->()
      CREATE (u)-[:FRIEND]->()
      """
    And parameters are:
      | friendIndex | 1 |
    */
    @Test
    def void testDeleteAcceptance_15() {
        test('''
        MATCH (:User)-[r:FRIEND]->()
        WITH collect(r) AS friendships
        DETACH DELETE friendships[$friendIndex]
        ''')
    }

    /*
    Scenario: Delete nodes from a map
    Given an empty graph
    And having executed:
      """
      CREATE (:User), (:User)
      """
    */
    @Test
    def void testDeleteAcceptance_16() {
        test('''
        MATCH (u:User)
        WITH {key: u} AS nodes
        DELETE nodes.key
        ''')
    }

    /*
    Scenario: Delete relationships from a map
    Given an empty graph
    And having executed:
      """
      CREATE (a:User), (b:User)
      CREATE (a)-[:R]->(b)
      CREATE (b)-[:R]->(a)
      """
    */
    @Test
    def void testDeleteAcceptance_17() {
        test('''
        MATCH (:User)-[r]->(:User)
        WITH {key: r} AS rels
        DELETE rels.key
        ''')
    }

    /*
    Scenario: Detach delete nodes from nested map/list
    Given an empty graph
    And having executed:
      """
      CREATE (a:User), (b:User)
      CREATE (a)-[:R]->(b)
      CREATE (b)-[:R]->(a)
      """
    */
    @Test
    def void testDeleteAcceptance_18() {
        test('''
        MATCH (u:User)
        WITH {key: collect(u)} AS nodeMap
        DETACH DELETE nodeMap.key[0]
        ''')
    }

    /*
    Scenario: Delete relationships from nested map/list
    Given an empty graph
    And having executed:
      """
      CREATE (a:User), (b:User)
      CREATE (a)-[:R]->(b)
      CREATE (b)-[:R]->(a)
      """
    */
    @Test
    def void testDeleteAcceptance_19() {
        test('''
        MATCH (:User)-[r]->(:User)
        WITH {key: {key: collect(r)}} AS rels
        DELETE rels.key.key[0]
        ''')
    }

    /*
    Scenario: Delete paths from nested map/list
    Given an empty graph
    And having executed:
      """
      CREATE (a:User), (b:User)
      CREATE (a)-[:R]->(b)
      CREATE (b)-[:R]->(a)
      """
    */
    @Test
    def void testDeleteAcceptance_20() {
        test('''
        MATCH p = (:User)-[r]->(:User)
        WITH {key: collect(p)} AS pathColls
        DELETE pathColls.key[0], pathColls.key[1]
        ''')
    }

    /*
    Scenario: Delete relationship with bidirectional matching
    Given an empty graph
    And having executed:
      """
      CREATE ()-[:T {id: 42}]->()
      """
    */
    @Test
    def void testDeleteAcceptance_21() {
        test('''
        MATCH p = ()-[r:T]-()
        WHERE r.id = 42
        DELETE r
        ''')
    }

}
