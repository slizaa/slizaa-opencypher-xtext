package org.slizaa.neo4j.opencypher.conversion

import com.google.common.base.Joiner
import com.google.inject.Inject
import java.util.Set
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractValueConverter
import org.eclipse.xtext.nodemodel.INode

class SYMBOLIC_NAME_XValueConverter extends AbstractValueConverter<String> {

	@Inject
	OpenCypherIDEscapeHelper helper

	override toString(String value) throws ValueConverterException {
		val invalidChars = helper.collectInvalidCharacters(value)
		if (invalidChars === null) {
			helper.toEscapedString(value)
		} else {
			throw new ValueConverterException(getInvalidCharactersMessage(value, invalidChars), null, null)
		}
	}

	// Copied from org.eclipse.xtext.conversion.impl.AbstractIDValueConverter#getInvalidCharactersMessage
	protected def getInvalidCharactersMessage(String value, Set<Character> invalidChars) {
		val chars = Joiner.on(", ").join(invalidChars.map[from|"'" + from + "' (0x" + Integer.toHexString(from) + ")"])
		"ID '" + value + "' contains invalid characters: " + chars
	}

	override toValue(String string, INode node) throws ValueConverterException {
		helper.toValue(string)
	}

}
