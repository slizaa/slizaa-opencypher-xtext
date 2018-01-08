package org.slizaa.neo4j.opencypher.conversion

import com.google.inject.Inject
import org.eclipse.xtext.common.services.DefaultTerminalConverters
import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.conversion.ValueConverter

class OpenCypherValueConverterService extends DefaultTerminalConverters {

	@Inject
	SYMBOLIC_NAME_XValueConverter symbolNameXValueConverter

	@ValueConverter(rule="SYMBOLIC_NAME_X")
	def IValueConverter<String> SYMBOLIC_NAME_X() {
		symbolNameXValueConverter
	}

}
