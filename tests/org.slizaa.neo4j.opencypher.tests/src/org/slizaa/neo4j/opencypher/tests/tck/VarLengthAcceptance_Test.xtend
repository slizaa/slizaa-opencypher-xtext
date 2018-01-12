package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class VarLengthAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Handling unbounded variable length match
    */
    @Test
    def void testVarLengthAcceptance_01() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling explicitly unbounded variable length match
    */
    @Test
    def void testVarLengthAcceptance_02() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*..]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling single bounded variable length match 1
    */
    @Test
    def void testVarLengthAcceptance_03() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*0]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling single bounded variable length match 2
    */
    @Test
    def void testVarLengthAcceptance_04() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*1]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling single bounded variable length match 3
    */
    @Test
    def void testVarLengthAcceptance_05() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*2]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling upper and lower bounded variable length match 1
    */
    @Test
    def void testVarLengthAcceptance_06() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*0..2]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling upper and lower bounded variable length match 2
    */
    @Test
    def void testVarLengthAcceptance_07() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*1..2]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling symmetrically bounded variable length match, bounds are zero
    */
    @Test
    def void testVarLengthAcceptance_08() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*0..0]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling symmetrically bounded variable length match, bounds are one
    */
    @Test
    def void testVarLengthAcceptance_09() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*1..1]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling symmetrically bounded variable length match, bounds are two
    */
    @Test
    def void testVarLengthAcceptance_10() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*2..2]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling upper and lower bounded variable length match, empty interval 1
    */
    @Test
    def void testVarLengthAcceptance_11() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*2..1]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling upper and lower bounded variable length match, empty interval 2
    */
    @Test
    def void testVarLengthAcceptance_12() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*1..0]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling upper bounded variable length match, empty interval
    */
    @Test
    def void testVarLengthAcceptance_13() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*..0]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling upper bounded variable length match 1
    */
    @Test
    def void testVarLengthAcceptance_14() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*..1]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling upper bounded variable length match 2
    */
    @Test
    def void testVarLengthAcceptance_15() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*..2]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling lower bounded variable length match 1
    */
    @Test
    def void testVarLengthAcceptance_16() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*0..]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling lower bounded variable length match 2
    */
    @Test
    def void testVarLengthAcceptance_17() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*1..]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling lower bounded variable length match 3
    */
    @Test
    def void testVarLengthAcceptance_18() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*2..]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling a variable length relationship and a standard relationship in chain, zero length 1
    */
    @Test
    def void testVarLengthAcceptance_19() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*0]->()-[:LIKES]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling a variable length relationship and a standard relationship in chain, zero length 2
    */
    @Test
    def void testVarLengthAcceptance_20() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES]->()-[:LIKES*0]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling a variable length relationship and a standard relationship in chain, single length 1
    */
    @Test
    def void testVarLengthAcceptance_21() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*1]->()-[:LIKES]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling a variable length relationship and a standard relationship in chain, single length 2
    */
    @Test
    def void testVarLengthAcceptance_22() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES]->()-[:LIKES*1]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling a variable length relationship and a standard relationship in chain, longer 1
    */
    @Test
    def void testVarLengthAcceptance_23() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES*2]->()-[:LIKES]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling a variable length relationship and a standard relationship in chain, longer 2
    */
    @Test
    def void testVarLengthAcceptance_24() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES]->()-[:LIKES*2]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling a variable length relationship and a standard relationship in chain, longer 3
    And having executed:
      """
      MATCH (d:D)
      CREATE (e1:E {name: d.name + '0'}),
             (e2:E {name: d.name + '1'})
      CREATE (d)-[:LIKES]->(e1),
             (d)-[:LIKES]->(e2)
      """
    */
    @Test
    def void testVarLengthAcceptance_25() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES]->()-[:LIKES*3]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling mixed relationship patterns and directions 1
    And having executed:
      """
      MATCH (a:A)-[r]->(b)
      DELETE r
      CREATE (b)-[:LIKES]->(a)
      """
    And having executed:
      """
      MATCH (d:D)
      CREATE (e1:E {name: d.name + '0'}),
             (e2:E {name: d.name + '1'})
      CREATE (d)-[:LIKES]->(e1),
             (d)-[:LIKES]->(e2)
      """
    */
    @Test
    def void testVarLengthAcceptance_26() {
        test('''
        MATCH (a:A)
        MATCH (a)<-[:LIKES]-()-[:LIKES*3]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling mixed relationship patterns and directions 2
    # This gets hard to follow for a human mind. The answer is named graphs, but it's not crucial to fix.
    And having executed:
      """
      MATCH (a)-[r]->(b)
      WHERE NOT a:A
      DELETE r
      CREATE (b)-[:LIKES]->(a)
      """
    And having executed:
      """
      MATCH (d:D)
      CREATE (e1:E {name: d.name + '0'}),
             (e2:E {name: d.name + '1'})
      CREATE (d)-[:LIKES]->(e1),
             (d)-[:LIKES]->(e2)
      """
    */
    @Test
    def void testVarLengthAcceptance_27() {
        test('''
        MATCH (a:A)
        MATCH (a)-[:LIKES]->()<-[:LIKES*3]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling mixed relationship patterns 1
    And having executed:
      """
      MATCH (d:D)
      CREATE (e1:E {name: d.name + '0'}),
             (e2:E {name: d.name + '1'})
      CREATE (d)-[:LIKES]->(e1),
             (d)-[:LIKES]->(e2)
      """
    */
    @Test
    def void testVarLengthAcceptance_28() {
        test('''
        MATCH (a:A)
        MATCH (p)-[:LIKES*1]->()-[:LIKES]->()-[r:LIKES*2]->(c)
        RETURN c.name
        ''')
    }

    /*
    Scenario: Handling mixed relationship patterns 2
    And having executed:
      """
      MATCH (d:D)
      CREATE (e1:E {name: d.name + '0'}),
             (e2:E {name: d.name + '1'})
      CREATE (d)-[:LIKES]->(e1),
             (d)-[:LIKES]->(e2)
      """
    */
    @Test
    def void testVarLengthAcceptance_29() {
        test('''
        MATCH (a:A)
        MATCH (p)-[:LIKES]->()-[:LIKES*2]->()-[r:LIKES]->(c)
        RETURN c.name
        ''')
    }

}
