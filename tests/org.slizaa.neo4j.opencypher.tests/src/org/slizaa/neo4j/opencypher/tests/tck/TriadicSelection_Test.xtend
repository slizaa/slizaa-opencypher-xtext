package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class TriadicSelection_Test extends AbstractCypherTest {
    
    /*
    Scenario: Handling triadic friend of a friend
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_01() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_02() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend with different relationship type
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_03() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c)
        OPTIONAL MATCH (a)-[r:FOLLOWS]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend with superset of relationship type
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_04() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c)
        OPTIONAL MATCH (a)-[r]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend with implicit subset of relationship type
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_05() {
        test('''
        MATCH (a:A)-->(b)-->(c)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend with explicit subset of relationship type
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_06() {
        test('''
        MATCH (a:A)-[:KNOWS|FOLLOWS]->(b)-->(c)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend with same labels
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_07() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b:X)-->(c:X)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend with different labels
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_08() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b:X)-->(c:Y)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend with implicit subset of labels
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_09() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c:X)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is not a friend with implicit superset of labels
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_10() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b:X)-->(c)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_11() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend with different relationship type
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_12() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c)
        OPTIONAL MATCH (a)-[r:FOLLOWS]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend with superset of relationship type
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_13() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c)
        OPTIONAL MATCH (a)-[r]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend with implicit subset of relationship type
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_14() {
        test('''
        MATCH (a:A)-->(b)-->(c)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend with explicit subset of relationship type
    Given the binary-tree-1 graph
    */
    @Test
    def void testTriadicSelection_15() {
        test('''
        MATCH (a:A)-[:KNOWS|FOLLOWS]->(b)-->(c)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend with same labels
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_16() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b:X)-->(c:X)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend with different labels
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_17() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b:X)-->(c:Y)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend with implicit subset of labels
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_18() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b)-->(c:X)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling triadic friend of a friend that is a friend with implicit superset of labels
    Given the binary-tree-2 graph
    */
    @Test
    def void testTriadicSelection_19() {
        test('''
        MATCH (a:A)-[:KNOWS]->(b:X)-->(c)
        OPTIONAL MATCH (a)-[r:KNOWS]->(c)
        WITH c WHERE r IS NOT NULL
        RETURN c.name
        ''')
    }

}
