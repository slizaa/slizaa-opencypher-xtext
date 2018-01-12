package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class Create_Test extends AbstractCypherTest {
    
    /*
    Scenario: Creating a node
    Given any graph
    */
    @Test
    def void testCreate_01() {
        test('''
        CREATE ()
        ''')
    }

    /*
    Scenario: Creating two nodes
    Given any graph
    */
    @Test
    def void testCreate_02() {
        test('''
        CREATE (), ()
        ''')
    }

    /*
    Scenario: Creating two nodes and a relationship
    Given any graph
    */
    @Test
    def void testCreate_03() {
        test('''
        CREATE ()-[:TYPE]->()
        ''')
    }

    /*
    Scenario: Creating a node with a label
    Given any graph
    */
    @Test
    def void testCreate_04() {
        test('''
        CREATE (:Label)
        ''')
    }

    /*
    Scenario: Creating a node with a property
    Given any graph
    */
    @Test
    def void testCreate_05() {
        test('''
        CREATE ({created: true})
        ''')
    }

}
