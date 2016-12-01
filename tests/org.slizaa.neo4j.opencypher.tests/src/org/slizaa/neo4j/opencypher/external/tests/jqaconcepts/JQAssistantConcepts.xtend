package org.slizaa.neo4j.opencypher.external.tests.jqaconcepts

import org.junit.Test
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

class JQAssistantConcepts extends AbstractCypherTest {

	@Test
	def void example_01() {
		test('''
MATCH
  ()-[r:RESOLVES_TO]->()
RETURN
  count(r) as ResolvedElements
''');
	}

	@Test
	def void example_02() {
		test('''
MATCH
  (a:Annotation)-[:OF_TYPE]->(:Type)-[:RESOLVES_TO]->(t:Type)
MERGE
  (a)-[:OF_TYPE{resolved:true}]->(t)
RETURN
  count(t) as ResolvedAnnotationTypes
''');
	}

	@Test
	def void example_03() {
		test('''
MATCH
  (t:Type)-[:DEPENDS_ON]->(t1:Type)-[:RESOLVES_TO]->(t2:Type)
MERGE
  (t)-[:DEPENDS_ON{resolved:true}]->(t2)
RETURN
  count(t) as ResolvedDependencies
''');
	}

	@Test
	def void example_04() {
		test('''
MATCH
  (t:Type)-[:EXTENDS]->(t1:Type)-[:RESOLVES_TO]->(t2:Type)
MERGE
  (t)-[:EXTENDS{resolved:true}]->(t2)
RETURN
  count(t) as ResolvedSuperClass
''');
	}

	@Test
	def void example_05() {
		test('''
MATCH
  (f:Field)-[:OF_TYPE]->(:Type)-[:RESOLVES_TO]->(t:Type)
MERGE
  (f)-[:OF_TYPE{resolved:true}]->(t)
RETURN
  count(t) as ResolvedFieldTypes
''');
	}

	@Test
	def void example_06() {
		test('''
MATCH
  (t:Type)-[:IMPLEMENTS]->(t1:Type)-[:RESOLVES_TO]->(t2:Type)
MERGE
  (t)-[:IMPLEMENTS{resolved:true}]->(t2)
RETURN
  count(t1) as ResolvedInterfaces
''');
	}

	@Test
	def void example_07() {
		test('''
MATCH
  (m:Method)-[i:INVOKES]->(m1:Method)-[:RESOLVES_TO]->(m2:Method)
MERGE
  (m)-[:INVOKES{lineNumber:i.lineNumber,resolved:true}]->(m2)
RETURN
  count(i) as ResolvedInvocations
''');
	}

	@Test
	def void example_08() {
		test('''
MATCH
  (t1:Type)-[:RESOLVES_TO]->(t2:Type),
  (t1)-[:DECLARES]->(m1),
  (t2)-[:DECLARES]->(m2)
WHERE
  (m1:Field or m1:Method)
  and m1.signature = m2.signature
MERGE
  (m1)-[:RESOLVES_TO{resolved:true}]->(m2)
RETURN
  count(m1) as ResolvedMembers
''');
	}

	@Test
	def void example_09() {
		test('''
MATCH
  (m:Parameter)-[:OF_TYPE]->(:Type)-[:RESOLVES_TO]->(t:Type)
MERGE
  (m)-[:OF_TYPE{resolved:true}]->(t)
RETURN
  count(t) as ResolvedParameterTypes
''');
	}

	@Test
	def void example_10() {
		test('''
MATCH
  (m:Method)-[r:READS]->(f1:Field)-[:RESOLVES_TO]->(f2:Field)
MERGE
  (m)-[:READS{lineNumber:r.lineNumber,resolved:true}]->(f2)
RETURN
  count(r) as ResolvedReads
''');
	}

	@Test
	def void example_11() {
		test('''
MATCH
  (m:Method)-[:RETURNS]->(:Type)-[:RESOLVES_TO]->(t:Type)
MERGE
  (m)-[:RETURNS{resolved:true}]->(t)
RETURN
  count(t) as ResolvedReturnTypes
''');
	}

	@Test
	def void example_12() {
		test('''

MATCH
  (m:Method)-[:THROWS]->(:Type)-[:RESOLVES_TO]->(t:Type)
MERGE
  (m)-[:THROWS{resolved:true}]->(t)
RETURN
  count(t) as ResolvedExceptionTypes
''');
	}

	@Test
	def void example_13() {
		test('''
MATCH
  (a1:Artifact)-[:REQUIRES]->(t1:Type)
WITH
  a1, t1, t1.fqn as fqn
MATCH
  (a2:Artifact)-[:CONTAINS]->(t2:Type)
WHERE
  t2.fqn=t1.fqn
MERGE
  (t1)-[:RESOLVES_TO]->(t2)
RETURN
  count(t1) as ResolvedTypes
''');
	}

	@Test
	def void example_14() {
		test('''
MATCH
  (v:Value)-[:IS]->(e)-[:RESOLVES_TO]->(e2)
MERGE
  (v)-[:IS{resolved:true}]->(e2)
RETURN
  count(v) as ResolvedValueTypes
''');
	}

	@Test
	def void example_15() {
		test('''
MATCH
  (m:Method)-[w:WRITES]->(f1:Field)-[:RESOLVES_TO]->(f2:Field)
MERGE
  (m)-[:WRITES{lineNumber:w.lineNumber,resolved:true}]->(f2)
RETURN
  count(w) as ResolvedWrites
''');
	}

	@Test
	def void example_16() {
		test('''
MATCH
  (a1:Artifact)-[:CONTAINS]->(:Type)-[:DEPENDS_ON]->(type:Type)
WITH
  a1,type.fqn as fqn
MATCH
  (a2:Artifact)-[:CONTAINS]->(t2:Type)
WHERE
  a1 <> a2
  and t2.fqn = fqn
MERGE
  (a1)-[d:DEPENDS_ON]->(a2)
SET
  d.used=true
RETURN
  a1 AS Artifact, COLLECT(DISTINCT a2.fqn) AS Dependencies
''');
	}

	@Test
	def void example_17() {
		test('''

MATCH
    (p1:Package)-[:CONTAINS]->(t1:Type)-[:DEPENDS_ON]->(t2:Type)<-[:CONTAINS]-(p2:Package)
WHERE
    p1<>p2
CREATE UNIQUE
    (p1)-[:DEPENDS_ON]->(p2)
RETURN
    p1 AS package, COUNT(DISTINCT p2) AS PackageDependencies
''');
	}

	@Test
	def void example_18() {
		test('''
MATCH
  (innerType:Inner:Type)
WHERE
  innerType.name =~ '.*\\$[0-9]*'
SET
  innerType:Anonymous
RETURN
  innerType AS AnonymousInnerType
''');
	}

	@Test
	def void example_19() {
		test('''
MATCH
  (e)-[:ANNOTATED_BY]->()-[:OF_TYPE]->(dt:Type)
WHERE
  dt.fqn='java.lang.Deprecated'
SET
  e:Deprecated
RETURN
  e AS DeprecatedElement
''');
	}

	@Test
	def void example_20() {
		test('''
MATCH
  (throwable)-[:EXTENDS*]->(t:Type)
WHERE
  t.fqn = 'java.lang.Error'
SET
  throwable:Error
RETURN
  throwable AS Error
''');
	}

	@Test
	def void example_21() {
		test('''
MATCH
  (exception)-[:EXTENDS*]->(t:Type)
WHERE
  t.fqn = 'java.lang.Exception'
SET
  exception:Exception
RETURN
  exception AS Exception
''');
	}

	@Test
	def void example_22() {
		test('''
MATCH
  (:Type)-[:DECLARES]->(innerType:Type)
SET
  innerType:Inner
RETURN
  innerType AS InnerType
''');
	}

	@Test
	def void example_23() {
		test('''
MATCH
  (method:Method)-[invocation:INVOKES]->(invokedMethod:Method),
  (overridingMethod:Method)-[:OVERRIDES]->(invokedMethod)
CREATE UNIQUE
  (method)-[r:INVOKES{lineNumber:invocation.lineNumber}]->(overridingMethod)
RETURN count(r) AS OverridingInvocations
''');
	}

	@Test
	def void example_24() {
		test('''
MATCH
  (type:Type:File)
SET
  type.javaVersion=
  CASE type.byteCodeVersion
    WHEN 52 THEN 'Java 8'
    WHEN 51 THEN 'Java 7'
    WHEN 50 THEN 'Java 6'
    WHEN 49 THEN 'Java 5'
    WHEN 48 THEN 'Java 1.4'
    WHEN 47 THEN 'Java 1.3'
    WHEN 46 THEN 'Java 1.2'
    WHEN 45 THEN 'Java 1.1/1.0'
  END
RETURN
  count(type) as Types
''');
	}

	@Test
	def void example_25() {
		test('''
MATCH
  (type:Type)-[:DECLARES]->(method:Method),
  (type)-[:DECLARES]->(otherMethod:Method)
WHERE
  method <> otherMethod
  AND method.name = otherMethod.name
  AND method.signature <> otherMethod.signature
CREATE UNIQUE
    (method)-[:OVERLOADS]->(otherMethod)
RETURN method AS OverloadedMethod, type AS DeclaringType
''');
	}

	@Test
	def void example_26() {
		test('''
MATCH
  (type:Type)-[:DECLARES]->(method:Method),
  (superType:Type)-[:DECLARES]->(otherMethod:Method),
  (superType)-[:ASSIGNABLE_FROM]->(type)
WHERE
  method.name = otherMethod.name
  AND method.signature = otherMethod.signature
  AND method.visibility <> 'private'
CREATE UNIQUE
  (method)-[:OVERRIDES]->(otherMethod)
RETURN method AS OverriddenMethod, type AS DeclaringType, superType AS SuperType
''');
	}

	@Test
	def void example_27() {
		test('''
MATCH
  (runtimeException)-[:EXTENDS*]->(t:Type)
WHERE
  t.fqn = 'java.lang.RuntimeException'
SET
  runtimeException:RuntimeException
RETURN
  runtimeException AS RuntimeException
''');
	}

	@Test
	def void example_28() {
		test('''
MATCH
  (throwable)-[:EXTENDS*]->(t:Type)
WHERE
  t.fqn = 'java.lang.Throwable'
SET
  throwable:Throwable
RETURN
  throwable AS Throwable
''');
	}

	@Test
	def void example_29() {
		test('''
MATCH
  (type:Type)
CREATE UNIQUE
  (type)-[:ASSIGNABLE_FROM]->(type)
WITH
  type
MATCH
  (type)-[:IMPLEMENTS|EXTENDS*]->(superType:Type)
CREATE UNIQUE
  (superType)-[:ASSIGNABLE_FROM]->(type)
RETURN type AS AssignableType, superType AS AssignableFrom
''');
	}

	@Test
	def void example_30() {
		test('''
MATCH
  (c:Class:Test:Junit3)-[:DECLARES]->(m:Method)
WHERE
  m.signature = 'void setUp()'
SET
  m:SetUp:Junit3
RETURN
  m AS SetUpMethod, c AS TestClass
''');
	}

	@Test
	def void example_31() {
		test('''
MATCH
  (c:Class:Test:Junit3)-[:DECLARES]->(m:Method)
WHERE
  m.signature = 'void tearDown()'
SET
  m:TearDown:Junit3
RETURN
  m AS TearDownMethod, c AS TestClass
''');
	}

	@Test
	def void example_32() {
		test('''
MATCH
  (c:Type:Class)-[:EXTENDS*]->(testCaseType:Type)
WHERE
  testCaseType.fqn = 'junit.framework.TestCase'
SET
  c:Test:Junit3
RETURN
  c AS TestClass
''');
	}

	@Test
	def void example_33() {
		test('''
MATCH
  (c:Class:Test:Junit3)-[:DECLARES]->(m:Method)
WHERE
  m.signature =~ 'void test.*\\(.*\\)'
SET
  m:Test:Junit3
RETURN
  m AS Test, c AS TestClass
''');
	}

	@Test
	def void example_34() {
		test('''
MATCH
  (c:Type:Class)-[:DECLARES]->(m:Method),
  (m:Method)-[:ANNOTATED_BY]->()-[:OF_TYPE]->(a:Type)
WHERE
  a.fqn='org.junit.AfterClass'
SET
  m:Junit4:AfterClass
RETURN
  m AS AfterClassMethod, c AS TestClass
''');
	}

	@Test
	def void example_35() {
		test('''
MATCH
  (c:Type:Class)-[:DECLARES]->(m:Method),
  (m:Method)-[:ANNOTATED_BY]->()-[:OF_TYPE]->(a:Type)
WHERE
  a.fqn='org.junit.After'
SET
  m:Junit4:After
RETURN
  m AS AfterMethod, c AS TestClass
''');
	}

	@Test
	def void example_36() {
		test('''
MATCH
  (assertType:Type)-[:DECLARES]->(assertMethod)
WHERE
  assertType.fqn = 'org.junit.Assert'
  and assertMethod.signature =~ 'void assert.*'
SET
  assertMethod:Junit4:Assert
RETURN
  assertMethod
''');
	}

	@Test
	def void example_37() {
		test('''
MATCH
  (c:Type:Class)-[:DECLARES]->(m:Method),
  (m:Method)-[:ANNOTATED_BY]->()-[:OF_TYPE]->(a:Type)
WHERE
  a.fqn='org.junit.BeforeClass'
SET
  m:Junit4:BeforeClass
RETURN
  m AS BeforeClassMethod, c AS TestClass
''');
	}

	@Test
	def void example_38() {
		test('''
MATCH
  (c:Type:Class)-[:DECLARES]->(m:Method),
  (m:Method)-[:ANNOTATED_BY]->()-[:OF_TYPE]->(a:Type)
WHERE
  a.fqn='org.junit.Before'
SET
  m:Junit4:Before
RETURN
  m AS BeforeMethod, c AS TestClass
''');
	}

	@Test
	def void example_39() {
		test('''
MATCH
  (e)-[:ANNOTATED_BY]->()-[:OF_TYPE]->(a:Type)
WHERE
  a.fqn='org.junit.Ignore'
SET
  e:Junit4:Ignore
RETURN
  e AS IgnoredElement
''');
	}

	@Test
	def void example_40() {
		test('''
MATCH
  (suite:Type)-[:ANNOTATED_BY]->(suiteClasses)-[:OF_TYPE]->(suiteClassesType:Type)
WHERE
  suiteClassesType.fqn = 'org.junit.runners.Suite$SuiteClasses'
SET
  suite:Junit4:Suite
WITH
  suite, suiteClasses
MATCH
  (suiteClasses)-[:HAS]->(:Array:Value)-[:CONTAINS]->(Class:Value)-[:IS]->(testClass:Type)
CREATE UNIQUE
  (suite)-[c:CONTAINS_TESTCLASS]->(testClass)
RETURN
  suite, collect(testClass)
''');
	}

	@Test
	def void example_41() {
		test('''
MATCH
  (testcase:TestCase)
WITH
  testcase
MATCH
  (testclass:Type)-[:DECLARES]->(testmethod:Method)
WHERE
  testclass.fqn = testcase.className
  and testmethod.name = testcase.name
CREATE UNIQUE
  (testcase)-[:IMPLEMENTED_BY]->(testmethod)
RETURN
  testcase AS TestCase
''');
	}

	@Test
	def void example_42() {
		test('''
MATCH
  (c:Type:Class)-[:DECLARES]->(m:Method:Junit4:Test)
SET
  c:Test:Junit4
RETURN
  c AS TestClass, COLLECT(m) AS TestMethods
''');
	}

	@Test
	def void example_43() {
		test('''
MATCH
  (c:Type:Class)-[:DECLARES]->(m:Method:Junit4:Test)
RETURN
  c AS TestClass, COLLECT(m) AS TestMethods
''');
	}

	@Test
	def void example_44() {
		test('''
MATCH
  (m:Method)-[:ANNOTATED_BY]-()-[:OF_TYPE]->(a:Type)
WHERE
  a.fqn='org.junit.Test'
SET
  m:Test:Junit4
RETURN
  m AS Test
''');
	}

	@Test
	def void example_45() {
		test('''
MATCH
    (t:Type:File)-[:DECLARES]->(f:Field)
RETURN
    t.fqn as Type, COUNT(f) as FieldCount
ORDER BY
    FieldCount DESC
LIMIT 10
''');
	}

	@Test
	def void example_46() {
		test('''
MATCH
    (t:Type:File)-[:DECLARES]->(m:Method)
RETURN
    t.fqn as Type, COUNT(m) as MethodCount
ORDER BY
    MethodCount DESC
LIMIT 10
''');
	}

	@Test
	def void example_47() {
		test('''
MATCH
    (t:Type:File)<-[:DEPENDS_ON]-(dependent:Type)
RETURN
    t.fqn as Type, COUNT(dependent) as Dependents
ORDER BY
    Dependents DESC
LIMIT 10
''');
	}

	@Test
	def void example_48() {
		test('''
MATCH
    (t:Type:File)-[:DEPENDS_ON]->(dependency:Type)
RETURN
    t.fqn as Type, COUNT(dependency) as Dependencies
ORDER BY
    Dependencies DESC
LIMIT 10
''');
	}

	@Test
	def void example_49() {
		test('''
MATCH
    (a:Artifact:File)-[:CONTAINS]->(t:Type:File)
RETURN
    a.fqn as Artifact, COUNT(t) as Types
ORDER BY
    Types DESC
LIMIT 10
''');
	}

	@Test
	def void example_50() {
		test('''
MATCH
    (p:Package:File)-[:CONTAINS]->(t:Type:File)
RETURN
    p.fqn as Package, COUNT(t) as Types
ORDER BY
    Types DESC
LIMIT 10
''');
	}

	@Test
	def void example_51() {
		test('''
MATCH
    (a1:Artifact)-[:DEPENDS_ON]->(a2:Artifact),
    path=shortestPath((a2)-[:DEPENDS_ON*]->(a1))
WHERE
    a1<>a2
RETURN
    a1 AS Artifact, EXTRACT(a IN nodes(path) | a.fqn) AS Cycle
ORDER BY
    Artifact.fqn
''');
	}

	@Test
	def void example_52() {
		test('''
MATCH
    (p1:Package)-[:DEPENDS_ON]->(p2:Package),
    path=shortestPath((p2)-[:DEPENDS_ON*]->(p1))
WHERE
    p1<>p2
RETURN
    p1 AS Package, EXTRACT(p IN nodes(path) | p.fqn) AS Cycle
ORDER BY
    Package.fqn
''');
	}

	@Test
	def void example_53() {
		test('''
MATCH
  (testType:Type)-[:DECLARES]->(testMethod:Method),
  (testMethod)-[invocation:INVOKES]->(assertMethod:Assert:Method)
WHERE
  NOT assertMethod.signature =~ 'void assert.*\\(java.lang.String,.*\\)'
RETURN
  invocation AS Invocation,
  testType AS DeclaringType,
  testMethod AS Method
''');
	}

	@Test
	def void example_54() {
		test('''
MATCH
  (e)-[:ANNOTATED_BY]->(ignore:Annotation)-[:OF_TYPE]->(ignoreType:Type)
WHERE
  ignoreType.fqn= 'org.junit.Ignore'
  AND NOT (ignore)-[:HAS]->(:Value{name:'value'})
RETURN
  e AS IgnoreWithoutMessage
''');
	}

	@Test
	def void example_55() {
		test('''
MATCH
  (testType:Type)-[:DECLARES]->(testMethod:Test:Method)
WHERE
  NOT (testMethod)-[:INVOKES*..3]->(:Method:Assert)
RETURN
  testType AS DeclaringType,
  testMethod AS Method
''');
	}

	@Test
	def void example_56() {
		test('''
match
  (parent:Maven:Project)-[:HAS_MODULE]->(module:Maven:Project)
where
  not (module)-[:HAS_PARENT]->(parent)
return
  module as InvalidModule
  ''');
	}

}
