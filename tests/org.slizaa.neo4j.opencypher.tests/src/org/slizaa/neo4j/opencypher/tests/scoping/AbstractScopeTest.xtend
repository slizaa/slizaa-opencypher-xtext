package org.slizaa.neo4j.opencypher.tests.scoping

import com.google.inject.Inject
import java.util.List
import org.eclipse.xtext.scoping.IScopeProvider
import org.junit.Assert
import org.slizaa.neo4j.opencypher.openCypher.OpenCypherPackage
import org.slizaa.neo4j.opencypher.openCypher.VariableDeclaration
import org.slizaa.neo4j.opencypher.openCypher.VariableRef
import org.slizaa.neo4j.opencypher.tests.AbstractCypherTest

/**
 * see https://de.slideshare.net/meysholdt/testdriven-development-of-xtext-dsls
 */
abstract class AbstractScopeTest extends AbstractCypherTest {

	@Inject
	private IScopeProvider scopeProvider;

	def assertScope(VariableRef variableReference, VariableDeclaration... expectedVariableDeclarations) {

		// get all variable declarations 'in scope'
		val scopedVariableDeclarationDescriptions = scopeProvider.getScope(variableReference,
			OpenCypherPackage.eINSTANCE.variableRef_VariableRef).allElements

		// map from descriptions to VariableDeclarations
		val scopedVariableDeclarations = scopedVariableDeclarationDescriptions.map [d|
			d.EObjectOrProxy as VariableDeclaration
		].toList

		//
		val message = String.format("Expected: %s,\n but was: %s.", expectedVariableDeclarations.map[e|e.name].toList,
			scopedVariableDeclarations.map[e|e.name].toList)

		// assert that the list of visible variable declarations contains all expected declarations...
		Assert.assertEquals(message, expectedVariableDeclarations.size, scopedVariableDeclarations.size)
		Assert.assertTrue(message, expectedVariableDeclarations.containsAll(scopedVariableDeclarations))
		Assert.assertTrue(message, scopedVariableDeclarations.containsAll(expectedVariableDeclarations))
	}

	/**
	 * Helper method that returns a sub list that contains just the elements with the specified IDs.
	 */
	def elements(List<VariableDeclaration> expectedVariableDeclarations, int... elementIds) {
		return expectedVariableDeclarations.filter[e|elementIds.contains(expectedVariableDeclarations.indexOf(e))].
			toList
	}
}
