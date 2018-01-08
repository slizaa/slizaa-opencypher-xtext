package org.slizaa.neo4j.opencypher.conversion

import com.google.inject.Inject
import org.eclipse.xtext.conversion.impl.IgnoreCaseIDValueConverter
import org.eclipse.xtext.nodemodel.INode

class OpenCypherIDValueConverter extends IgnoreCaseIDValueConverter {

	@Inject
	OpenCypherIDEscapeHelper helper

	override toValue(String string, INode node) {
		helper.toValue(string)
	}

	override protected assertValidValue(String value) {
		// In Neo4j Cypher (as of 3.3.1) `` (empty string) is a valid ID.
		// Omit call to super.assertValidValue, which would throw a ValueConverterException on empty values.
	}

	override protected mustEscape(String value) {
		helper.mustEscape(value)
	}

	override protected toEscapedString(String value) {
		helper.toEscapedString(value)
	}

	override protected collectInvalidCharacters(String value) {
		helper.collectInvalidCharacters(value)
	}

}
