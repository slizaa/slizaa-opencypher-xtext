package org.slizaa.neo4j.opencypher.conversion

import com.google.common.collect.ImmutableSet
import com.google.inject.Singleton
import java.util.Set
import java.util.regex.Pattern

@Singleton
class OpenCypherIDEscapeHelper {

	static val UNESCAPED_ID_PATTERN = Pattern.compile('[a-zA-Z_][a-zA-Z0-9_]*')
	static val char ESCAPE_CHAR = '`'
	static val Set<Character> FORBIDDEN_CHARACTERS = #{0 as char, ESCAPE_CHAR}

	def toValue(String string) {
		if (string === null) {
			null
		} else if (string.charAt(0) == ESCAPE_CHAR) {
			val length = string.length
			string.substring(1, length - 1)
		} else {
			string
		}
	}

	def mustEscape(String value) {
		!UNESCAPED_ID_PATTERN.matcher(value).matches
	}

	def toEscapedString(String value) {
		if (mustEscape(value)) {
			ESCAPE_CHAR + value + ESCAPE_CHAR
		} else {
			value
		}
	}

	def collectInvalidCharacters(String value) {
		val invalidCharactersFound = ImmutableSet.builder
		val length = value.length
		for (var int i = 0; i < length; i++) {
			val character = value.charAt(i)
			if (FORBIDDEN_CHARACTERS.contains(character)) {
				invalidCharactersFound.add(character)
			}
		}
		val invalidChars = invalidCharactersFound.build
		// org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter<T>#createTokenContentMismatchException requires `null` for valid strings.
		if (invalidChars.empty) {
			null
		} else {
			invalidChars
		}
	}

}
