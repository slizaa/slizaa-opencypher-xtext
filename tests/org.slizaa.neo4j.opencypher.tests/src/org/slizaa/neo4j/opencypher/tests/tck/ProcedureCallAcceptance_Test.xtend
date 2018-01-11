package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class ProcedureCallAcceptance_Test extends AbstractCypherTest {
    
    /*
    Scenario: Standalone call to procedure that takes no arguments
    And there exists a procedure test.labels() :: (label :: STRING?):
      | label |
      | 'A'   |
      | 'B'   |
      | 'C'   |
    */
    @Test
    def void testProcedureCallAcceptance_01() {
        test('''
        CALL test.labels()
        ''')
    }

    /*
    Scenario: In-query call to procedure that takes no arguments
    And there exists a procedure test.labels() :: (label :: STRING?):
      | label |
      | 'A'   |
      | 'B'   |
      | 'C'   |
    */
    @Test
    def void testProcedureCallAcceptance_02() {
        test('''
        CALL test.labels() YIELD label
        RETURN label
        ''')
    }

    /*
    Scenario: Calling the same procedure twice using the same outputs in each call
    And there exists a procedure test.labels() :: (label :: STRING?):
      | label |
      | 'A'   |
      | 'B'   |
      | 'C'   |
    */
    @Test
    def void testProcedureCallAcceptance_03() {
        test('''
        CALL test.labels() YIELD label
        WITH count(*) AS c
        CALL test.labels() YIELD label
        RETURN *
        ''')
    }

    /*
    Scenario: Standalone call to VOID procedure that takes no arguments
    And there exists a procedure test.doNothing() :: VOID:
      |
    */
    @Test
    def void testProcedureCallAcceptance_04() {
        test('''
        CALL test.doNothing()
        ''')
    }

    /*
    Scenario: In-query call to VOID procedure that takes no arguments
    And there exists a procedure test.doNothing() :: VOID:
      |
    */
    @Test
    def void testProcedureCallAcceptance_05() {
        test('''
        MATCH (n)
        CALL test.doNothing()
        RETURN n
        ''')
    }

    /*
    Scenario: In-query call to VOID procedure does not consume rows
    And there exists a procedure test.doNothing() :: VOID:
      |
    And having executed:
      """
      CREATE (:A {name: 'a'})
      CREATE (:B {name: 'b'})
      CREATE (:C {name: 'c'})
      """
    */
    @Test
    def void testProcedureCallAcceptance_06() {
        test('''
        MATCH (n)
        CALL test.doNothing()
        RETURN n.name AS `name`
        ''')
    }

    /*
    Scenario: Standalone call to VOID procedure that takes no arguments, called with implicit arguments
    And there exists a procedure test.doNothing() :: VOID:
      |
    */
    @Test
    def void testProcedureCallAcceptance_07() {
        test('''
        CALL test.doNothing
        ''')
    }

    /*
    Scenario: In-query call to procedure that takes no arguments and yields no results
    And there exists a procedure test.doNothing() :: ():
      |
    */
    @Test
    def void testProcedureCallAcceptance_08() {
        test('''
        CALL test.doNothing() YIELD - RETURN 1
        ''')
    }

    /*
    Scenario: Standalone call to procedure that takes no arguments and yields no results
    And there exists a procedure test.doNothing() :: ():
      |
    */
    @Test
    def void testProcedureCallAcceptance_09() {
        test('''
        CALL test.doNothing()
        ''')
    }

    /*
    Scenario: Standalone call to procedure that takes no arguments and yields no results, called with implicit arguments
    And there exists a procedure test.doNothing() :: ():
      |
    */
    @Test
    def void testProcedureCallAcceptance_10() {
        test('''
        CALL test.doNothing
        ''')
    }

    /*
    Scenario: In-query call to procedure with explicit arguments
    And there exists a procedure test.my.proc(name :: STRING?, id :: INTEGER?) :: (city :: STRING?, country_code :: INTEGER?):
      | name     | id | city      | country_code |
      | 'Andres' | 1  | 'Malmö'   | 46           |
      | 'Tobias' | 1  | 'Malmö'   | 46           |
      | 'Mats'   | 1  | 'Malmö'   | 46           |
      | 'Stefan' | 1  | 'Berlin'  | 49           |
      | 'Stefan' | 2  | 'München' | 49           |
      | 'Petra'  | 1  | 'London'  | 44           |
    */
    @Test
    def void testProcedureCallAcceptance_11() {
        test('''
        CALL test.my.proc('Stefan', 1) YIELD city, country_code
        RETURN city, country_code
        ''')
    }

    /*
    Scenario: In-query call to procedure with explicit arguments that drops all result fields
    And there exists a procedure test.my.proc(name :: STRING?, id :: INTEGER?) :: (city :: STRING?, country_code :: INTEGER?):
      | name     | id | city      | country_code |
      | 'Andres' | 1  | 'Malmö'   | 46           |
      | 'Tobias' | 1  | 'Malmö'   | 46           |
      | 'Mats'   | 1  | 'Malmö'   | 46           |
      | 'Stefan' | 1  | 'Berlin'  | 49           |
      | 'Stefan' | 2  | 'München' | 49           |
      | 'Petra'  | 1  | 'London'  | 44           |
    */
    @Test
    def void testProcedureCallAcceptance_12() {
        test('''
        WITH 'Stefan' AS name, 1 AS id
        CALL test.my.proc(name, id) YIELD -
        RETURN name, id, count(*) AS count
        ''')
    }

    /*
    Scenario: Standalone call to procedure with explicit arguments
    And there exists a procedure test.my.proc(name :: STRING?, id :: INTEGER?) :: (city :: STRING?, country_code :: INTEGER?):
      | name     | id | city      | country_code |
      | 'Andres' | 1  | 'Malmö'   | 46           |
      | 'Tobias' | 1  | 'Malmö'   | 46           |
      | 'Mats'   | 1  | 'Malmö'   | 46           |
      | 'Stefan' | 1  | 'Berlin'  | 49           |
      | 'Stefan' | 2  | 'München' | 49           |
      | 'Petra'  | 1  | 'London'  | 44           |
    */
    @Test
    def void testProcedureCallAcceptance_13() {
        test('''
        CALL test.my.proc('Stefan', 1)
        ''')
    }

    /*
    Scenario: Standalone call to procedure with implicit arguments
    And there exists a procedure test.my.proc(name :: STRING?, id :: INTEGER?) :: (city :: STRING?, country_code :: INTEGER?):
      | name     | id | city      | country_code |
      | 'Andres' | 1  | 'Malmö'   | 46           |
      | 'Tobias' | 1  | 'Malmö'   | 46           |
      | 'Mats'   | 1  | 'Malmö'   | 46           |
      | 'Stefan' | 1  | 'Berlin'  | 49           |
      | 'Stefan' | 2  | 'München' | 49           |
      | 'Petra'  | 1  | 'London'  | 44           |
    And parameters are:
      | name | 'Stefan' |
      | id   | 1        |
    */
    @Test
    def void testProcedureCallAcceptance_14() {
        test('''
        CALL test.my.proc
        ''')
    }

    /*
    Scenario: Standalone call to procedure with argument of type NUMBER accepts value of type INTEGER
    And there exists a procedure test.my.proc(in :: NUMBER?) :: (out :: STRING?):
      | in   | out           |
      | 42   | 'wisdom'      |
      | 42.3 | 'about right' |
    */
    @Test
    def void testProcedureCallAcceptance_15() {
        test('''
        CALL test.my.proc(42)
        ''')
    }

    /*
    Scenario: In-query call to procedure with argument of type NUMBER accepts value of type INTEGER
    And there exists a procedure test.my.proc(in :: NUMBER?) :: (out :: STRING?):
      | in   | out           |
      | 42   | 'wisdom'      |
      | 42.3 | 'about right' |
    */
    @Test
    def void testProcedureCallAcceptance_16() {
        test('''
        CALL test.my.proc(42) YIELD out
        RETURN out
        ''')
    }

    /*
    Scenario: Standalone call to procedure with argument of type NUMBER accepts value of type FLOAT
    And there exists a procedure test.my.proc(in :: NUMBER?) :: (out :: STRING?):
      | in   | out           |
      | 42   | 'wisdom'      |
      | 42.3 | 'about right' |
    */
    @Test
    def void testProcedureCallAcceptance_17() {
        test('''
        CALL test.my.proc(42.3)
        ''')
    }

    /*
    Scenario: In-query call to procedure with argument of type NUMBER accepts value of type FLOAT
    And there exists a procedure test.my.proc(in :: NUMBER?) :: (out :: STRING?):
      | in   | out           |
      | 42   | 'wisdom'      |
      | 42.3 | 'about right' |
    */
    @Test
    def void testProcedureCallAcceptance_18() {
        test('''
        CALL test.my.proc(42.3) YIELD out
        RETURN out
        ''')
    }

    /*
    Scenario: Standalone call to procedure with argument of type FLOAT accepts value of type INTEGER
    And there exists a procedure test.my.proc(in :: FLOAT?) :: (out :: STRING?):
      | in   | out            |
      | 42.0 | 'close enough' |
    */
    @Test
    def void testProcedureCallAcceptance_19() {
        test('''
        CALL test.my.proc(42)
        ''')
    }

    /*
    Scenario: In-query call to procedure with argument of type FLOAT accepts value of type INTEGER
    And there exists a procedure test.my.proc(in :: FLOAT?) :: (out :: STRING?):
      | in   | out            |
      | 42.0 | 'close enough' |
    */
    @Test
    def void testProcedureCallAcceptance_20() {
        test('''
        CALL test.my.proc(42) YIELD out
        RETURN out
        ''')
    }

    /*
    Scenario: Standalone call to procedure with argument of type INTEGER accepts value of type FLOAT
    And there exists a procedure test.my.proc(in :: INTEGER?) :: (out :: STRING?):
      | in | out            |
      | 42 | 'close enough' |
    */
    @Test
    def void testProcedureCallAcceptance_21() {
        test('''
        CALL test.my.proc(42.0)
        ''')
    }

    /*
    Scenario: In-query call to procedure with argument of type INTEGER accepts value of type FLOAT
    And there exists a procedure test.my.proc(in :: INTEGER?) :: (out :: STRING?):
      | in | out            |
      | 42 | 'close enough' |
    */
    @Test
    def void testProcedureCallAcceptance_22() {
        test('''
        CALL test.my.proc(42.0) YIELD out
        RETURN out
        ''')
    }

    /*
    Scenario: Standalone call to procedure with null argument
    And there exists a procedure test.my.proc(in :: INTEGER?) :: (out :: STRING?):
      | in   | out   |
      | null | 'nix' |
    */
    @Test
    def void testProcedureCallAcceptance_23() {
        test('''
        CALL test.my.proc(null)
        ''')
    }

    /*
    Scenario: In-query call to procedure with null argument
    And there exists a procedure test.my.proc(in :: INTEGER?) :: (out :: STRING?):
      | in   | out   |
      | null | 'nix' |
    */
    @Test
    def void testProcedureCallAcceptance_24() {
        test('''
        CALL test.my.proc(null) YIELD out
        RETURN out
        ''')
    }

    /*
    Scenario: Standalone call to procedure should fail if implicit argument is missing
    And there exists a procedure test.my.proc(name :: STRING?, in :: INTEGER?) :: (out :: INTEGER?):
      | name | in | out |
    And parameters are:
      | name | 'Stefan' |
    */
    @Test
    def void testProcedureCallAcceptance_25() {
        test('''
        CALL test.my.proc
        ''')
    }

    /*
    Scenario: Standalone call to unknown procedure should fail
    */
    @Test
    def void testProcedureCallAcceptance_26() {
        test('''
        CALL test.my.proc
        ''')
    }

    /*
    Scenario: In-query call to unknown procedure should fail
    */
    @Test
    def void testProcedureCallAcceptance_27() {
        test('''
        CALL test.my.proc() YIELD out
        RETURN out
        ''')
    }

}
