package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class OptionalMatchAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Return null when no matches due to inline label predicate
    */
    @Test
    def void testOptionalMatchAcceptance_01() {
        test('''
        MATCH (n:Single)
        OPTIONAL MATCH (n)-[r]-(m:NonExistent)
        RETURN r
        ''')
    }

    /*
    Scenario: Return null when no matches due to label predicate in WHERE
    */
    @Test
    def void testOptionalMatchAcceptance_02() {
        test('''
        MATCH (n:Single)
        OPTIONAL MATCH (n)-[r]-(m)
        WHERE m:NonExistent
        RETURN r
        ''')
    }

    /*
    Scenario: Respect predicates on the OPTIONAL MATCH
    */
    @Test
    def void testOptionalMatchAcceptance_03() {
        test('''
        MATCH (n:Single)
        OPTIONAL MATCH (n)-[r]-(m)
        WHERE m.prop = 42
        RETURN m
        ''')
    }

    /*
    Scenario: Returning label predicate on null node
    */
    @Test
    def void testOptionalMatchAcceptance_04() {
        test('''
        MATCH (n:Single)
        OPTIONAL MATCH (n)-[r:TYPE]-(m)
        RETURN m:TYPE
        ''')
    }

    /*
    Scenario: MATCH after OPTIONAL MATCH
    */
    @Test
    def void testOptionalMatchAcceptance_05() {
        test('''
        MATCH (a:Single)
        OPTIONAL MATCH (a)-->(b:NonExistent)
        OPTIONAL MATCH (a)-->(c:NonExistent)
        WITH coalesce(b, c) AS x
        MATCH (x)-->(d)
        RETURN d
        ''')
    }

    /*
    Scenario: WITH after OPTIONAL MATCH
    */
    @Test
    def void testOptionalMatchAcceptance_06() {
        test('''
        OPTIONAL MATCH (a:A)
        WITH a AS a
        MATCH (b:B)
        RETURN a, b
        ''')
    }

    /*
    Scenario: Named paths in optional matches
    */
    @Test
    def void testOptionalMatchAcceptance_07() {
        test('''
        MATCH (a:A)
        OPTIONAL MATCH p = (a)-[:X]->(b)
        RETURN p
        ''')
    }

    /*
    Scenario: OPTIONAL MATCH and bound nodes
    */
    @Test
    def void testOptionalMatchAcceptance_08() {
        test('''
        MATCH (a:A), (b:C)
        OPTIONAL MATCH (x)-->(b)
        RETURN x
        ''')
    }

    /*
    Scenario: OPTIONAL MATCH with labels on the optional end node
    And having executed:
      """
      CREATE (:X), (x:X), (y1:Y), (y2:Y:Z)
      CREATE (x)-[:REL]->(y1),
             (x)-[:REL]->(y2)
      """
    */
    @Test
    def void testOptionalMatchAcceptance_09() {
        test('''
        MATCH (a:X)
        OPTIONAL MATCH (a)-->(b:Y)
        RETURN b
        ''')
    }

    /*
    Scenario: Named paths inside optional matches with node predicates
    */
    @Test
    def void testOptionalMatchAcceptance_10() {
        test('''
        MATCH (a:A), (b:B)
        OPTIONAL MATCH p = (a)-[:X]->(b)
        RETURN p
        ''')
    }

    /*
    Scenario: Variable length optional relationships
    */
    @Test
    def void testOptionalMatchAcceptance_11() {
        test('''
        MATCH (a:Single)
        OPTIONAL MATCH (a)-[*]->(b)
        RETURN b
        ''')
    }

    /*
    Scenario: Variable length optional relationships with length predicates
    */
    @Test
    def void testOptionalMatchAcceptance_12() {
        test('''
        MATCH (a:Single)
        OPTIONAL MATCH (a)-[*3..]-(b)
        RETURN b
        ''')
    }

    /*
    Scenario: Optionally matching self-loops
    */
    @Test
    def void testOptionalMatchAcceptance_13() {
        test('''
        MATCH (a:B)
        OPTIONAL MATCH (a)-[r]-(a)
        RETURN r
        ''')
    }

    /*
    Scenario: Optionally matching self-loops without matches
    */
    @Test
    def void testOptionalMatchAcceptance_14() {
        test('''
        MATCH (a)
        WHERE NOT (a:B)
        OPTIONAL MATCH (a)-[r]->(a)
        RETURN r
        ''')
    }

    /*
    Scenario: Variable length optional relationships with bound nodes
    */
    @Test
    def void testOptionalMatchAcceptance_15() {
        test('''
        MATCH (a:Single), (x:C)
        OPTIONAL MATCH (a)-[*]->(x)
        RETURN x
        ''')
    }

    /*
    Scenario: Variable length optional relationships with bound nodes, no matches
    */
    @Test
    def void testOptionalMatchAcceptance_16() {
        test('''
        MATCH (a:A), (b:B)
        OPTIONAL MATCH p = (a)-[*]->(b)
        RETURN p
        ''')
    }

    /*
    Scenario: Longer pattern with bound nodes
    */
    @Test
    def void testOptionalMatchAcceptance_17() {
        test('''
        MATCH (a:Single), (c:C)
        OPTIONAL MATCH (a)-->(b)-->(c)
        RETURN b
        ''')
    }

    /*
    Scenario: Longer pattern with bound nodes without matches
    */
    @Test
    def void testOptionalMatchAcceptance_18() {
        test('''
        MATCH (a:A), (c:C)
        OPTIONAL MATCH (a)-->(b)-->(c)
        RETURN b
        ''')
    }

    /*
    Scenario: Handling correlated optional matches; first does not match implies second does not match
    */
    @Test
    def void testOptionalMatchAcceptance_19() {
        test('''
        MATCH (a:A), (b:B)
        OPTIONAL MATCH (a)-->(x)
        OPTIONAL MATCH (x)-[r]->(b)
        RETURN x, r
        ''')
    }

    /*
    Scenario: Handling optional matches between optionally matched entities
    */
    @Test
    def void testOptionalMatchAcceptance_20() {
        test('''
        OPTIONAL MATCH (a:NotThere)
        WITH a
        MATCH (b:B)
        WITH a, b
        OPTIONAL MATCH (b)-[r:NOR_THIS]->(a)
        RETURN a, b, r
        ''')
    }

    /*
    Scenario: Handling optional matches between nulls
    */
    @Test
    def void testOptionalMatchAcceptance_21() {
        test('''
        OPTIONAL MATCH (a:NotThere)
        OPTIONAL MATCH (b:NotThere)
        WITH a, b
        OPTIONAL MATCH (b)-[r:NOR_THIS]->(a)
        RETURN a, b, r
        ''')
    }

    /*
    Scenario: OPTIONAL MATCH and `collect()`
    And having executed:
      """
      CREATE (:DoesExist {property: 42})
      CREATE (:DoesExist {property: 43})
      CREATE (:DoesExist {property: 44})
      """
    */
    @Test
    def void testOptionalMatchAcceptance_22() {
        test('''
        OPTIONAL MATCH (f:DoesExist)
        OPTIONAL MATCH (n:DoesNotExist)
        RETURN collect(DISTINCT n.property) AS a, collect(DISTINCT f.property) AS b
        ''')
    }

}
