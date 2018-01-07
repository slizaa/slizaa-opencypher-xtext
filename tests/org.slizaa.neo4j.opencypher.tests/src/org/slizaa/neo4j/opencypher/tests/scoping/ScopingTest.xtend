package org.slizaa.neo4j.opencypher.tests.scoping

import com.google.inject.Inject
import org.eclipse.xtext.scoping.IScopeProvider
import org.junit.Test
import org.slizaa.neo4j.opencypher.openCypher.SingleQuery
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

/**
 * see https://github.com/slizaa/slizaa-opencypher-xtext/issues/7
 * see https://de.slideshare.net/meysholdt/testdriven-development-of-xtext-dsls
 */
class ScopingTest extends AbstractCypherTest {

	@Inject
	private IScopeProvider scopeProvider;

	@Test
	def void scopeTest() {

		// parse the cypher statement
		val cypherQuery = test('''
			WITH 'dummy' AS x
			MATCH (p:Person)-[:LIVES]->(c:City)
			WITH p as p, count(c) AS cities, x
			MATCH (p:Person)-[:VISITED]->(c:Country)
			WITH p, cities, count(c) AS countries, x
			RETURN *
		''');

		val singleQuery = cypherQuery.statement as SingleQuery;
		println(singleQuery.clauses.size())
		println(singleQuery.clauses.get(0))
		println(singleQuery.clauses.get(1))
		println(singleQuery.clauses.get(2))
		println(singleQuery.clauses.get(3))
		println(singleQuery.clauses.get(4))
		println(singleQuery.clauses.get(5))

		//    Person peter = model.getPersons().get(0);
		//    EReference reference = TestDemoPackage.eINSTANCE.getPerson_Knows();
		//    IScope scope = this.scopeProvider.getScope(peter, reference);
		//    List<String> actualList = Lists.newArrayList();
		//    for (IEObjectDescription desc : scope.getAllElements()) {
		//      actualList.add(desc.getName().toString());
		//    }
		//    String actual = Joiner.on(", ").join(actualList);
		//    Assert.assertEquals("Peter, Frank", actual);
	}

}
