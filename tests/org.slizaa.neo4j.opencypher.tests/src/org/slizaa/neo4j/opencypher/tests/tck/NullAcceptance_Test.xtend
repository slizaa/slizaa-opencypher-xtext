package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class NullAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Ignore null when setting property
    Given an empty graph
    */
    @Test
    def void testNullAcceptance_01() {
        test('''
        OPTIONAL MATCH (a:DoesNotExist)
        SET a.prop = 42
        RETURN a
        ''')
    }

    /*
    Scenario: Ignore null when removing property
    Given an empty graph
    */
    @Test
    def void testNullAcceptance_02() {
        test('''
        OPTIONAL MATCH (a:DoesNotExist)
        REMOVE a.prop
        RETURN a
        ''')
    }

    /*
    Scenario: Ignore null when setting properties using an appending map
    Given an empty graph
    */
    @Test
    def void testNullAcceptance_03() {
        test('''
        OPTIONAL MATCH (a:DoesNotExist)
        SET a += {prop: 42}
        RETURN a
        ''')
    }

    /*
    Scenario: Ignore null when setting properties using an overriding map
    Given an empty graph
    */
    @Test
    def void testNullAcceptance_04() {
        test('''
        OPTIONAL MATCH (a:DoesNotExist)
        SET a = {prop: 42}
        RETURN a
        ''')
    }

    /*
    Scenario: Ignore null when setting label
    Given an empty graph
    */
    @Test
    def void testNullAcceptance_05() {
        test('''
        OPTIONAL MATCH (a:DoesNotExist)
        SET a:L
        RETURN a
        ''')
    }

    /*
    Scenario: Ignore null when removing label
    Given an empty graph
    */
    @Test
    def void testNullAcceptance_06() {
        test('''
        OPTIONAL MATCH (a:DoesNotExist)
        REMOVE a:L
        RETURN a
        ''')
    }

    /*
    Scenario: Ignore null when deleting node
    Given an empty graph
    */
    @Test
    def void testNullAcceptance_07() {
        test('''
        OPTIONAL MATCH (a:DoesNotExist)
        DELETE a
        RETURN a
        ''')
    }

    /*
    Scenario: Ignore null when deleting relationship
    Given an empty graph
    */
    @Test
    def void testNullAcceptance_08() {
        test('''
        OPTIONAL MATCH ()-[r:DoesNotExist]-()
        DELETE r
        RETURN r
        ''')
    }

}
