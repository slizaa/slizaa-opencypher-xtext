#!/usr/bin/env python3

import glob

import os
import re
from collections import defaultdict

import sys

def indent(lines):
    padding = '        '
    return ('\n' + padding).join(lines.split('\n'))

filenames = sorted(glob.glob('*.feature'))
for filename in filenames:
    filename_without_extension = os.path.splitext(filename)[0]
    test_file = open("/tmp/x/%s_Test.xtend" % filename_without_extension, "w")

    test_header = """package org.slizaa.neo4j.opencypher.tests.tck

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class %s_Test extends AbstractCypherTest {
    """ % filename_without_extension

    test_file.write(test_header)

    with open(filename, 'r') as file:
        content = file.read()

    indentation_pattern = re.compile('^\s*', re.MULTILINE)
    query_pattern = re.compile('(Scenario: .*?)When executing query:$\s*"""(.*?)\s*"""$\s*Then (.*?)$', re.MULTILINE | re.DOTALL)
    matches = re.findall(query_pattern, content)

    i = 0
    for match in matches:
        scenario = match[0]
        query = indentation_pattern.sub("", match[1])
        then = match[2]
        if "SyntaxError" in then:
            continue

        i += 1
        test_name = "%s_%02d" % (filename_without_extension, i)
        scenario_name = "%s: %s" % (filename, scenario.splitlines()[0])

        test_case = """
    /*
    %s*/
    @Test
    def void test%s() {
        test('''
        %s
        ''')
    }
""" % (scenario, test_name, indent(query))
        test_file.write(test_case)

    test_footer = """
}
"""
    test_file.write(test_footer)
    test_file.close()
