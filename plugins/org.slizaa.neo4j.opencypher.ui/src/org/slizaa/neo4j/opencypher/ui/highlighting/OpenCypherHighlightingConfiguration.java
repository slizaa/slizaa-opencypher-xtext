package org.slizaa.neo4j.opencypher.ui.highlighting;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.RGB;
import org.eclipse.xtext.ide.editor.syntaxcoloring.HighlightingStyles;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfiguration;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfigurationAcceptor;
import org.eclipse.xtext.ui.editor.utils.TextStyle;

public class OpenCypherHighlightingConfiguration implements IHighlightingConfiguration {
	
	public static final String KEYWORD_ID = HighlightingStyles.KEYWORD_ID;
	
	 public static final String VARIABLE_ID = "variable";
	 
   public static final String VARIABLE_REF_ID = "variableRef";

	public static final String PUNCTUATION_ID = HighlightingStyles.PUNCTUATION_ID;

	public static final String COMMENT_ID = HighlightingStyles.COMMENT_ID;

	public static final String STRING_ID = HighlightingStyles.STRING_ID;

	public static final String NUMBER_ID = HighlightingStyles.NUMBER_ID;

	public static final String DEFAULT_ID = HighlightingStyles.DEFAULT_ID;

	public static final String INVALID_TOKEN_ID = HighlightingStyles.INVALID_TOKEN_ID;

	public static final String TASK_ID = HighlightingStyles.TASK_ID;

	@Override
	public void configure(IHighlightingConfigurationAcceptor acceptor) {
	  acceptor.acceptDefaultHighlighting(VARIABLE_ID, "Variable", variableTextStyle());
	   acceptor.acceptDefaultHighlighting(VARIABLE_REF_ID, "Variable Reference", variableReferenceTextStyle());
		acceptor.acceptDefaultHighlighting(KEYWORD_ID, "Keyword", keywordTextStyle());
		acceptor.acceptDefaultHighlighting(PUNCTUATION_ID, "Punctuation character", punctuationTextStyle());
		acceptor.acceptDefaultHighlighting(COMMENT_ID, "Comment", commentTextStyle());
		acceptor.acceptDefaultHighlighting(TASK_ID, "Task Tag", taskTextStyle());
		acceptor.acceptDefaultHighlighting(STRING_ID, "String", stringTextStyle());
		acceptor.acceptDefaultHighlighting(NUMBER_ID, "Number", numberTextStyle());
		acceptor.acceptDefaultHighlighting(DEFAULT_ID, "Default", defaultTextStyle());
		acceptor.acceptDefaultHighlighting(INVALID_TOKEN_ID, "Invalid Symbol", errorTextStyle());
	}
	
	private TextStyle variableReferenceTextStyle() {
    TextStyle textStyle = new TextStyle();
    textStyle.setColor(new RGB(63, 127, 95));
    return textStyle;
  }

  private TextStyle variableTextStyle() {
    TextStyle textStyle = new TextStyle();
    textStyle.setColor(new RGB(63, 127, 95));
    return textStyle;
  }

  public TextStyle defaultTextStyle() {
		TextStyle textStyle = new TextStyle();
		return textStyle;
	}
	
	public TextStyle errorTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		return textStyle;
	}
	
	public TextStyle numberTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(125, 125, 125));
		return textStyle;
	}

	public TextStyle stringTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(42, 0, 255));
		return textStyle;
	}

	public TextStyle commentTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(63, 127, 95));
		return textStyle;
	}
	
	/**
	 * @since 2.6
	 */
	public TextStyle taskTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(127, 159, 191));
		textStyle.setStyle(SWT.BOLD);
		return textStyle;
	}

	public TextStyle keywordTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(127, 0, 85));
		textStyle.setStyle(SWT.BOLD);
		return textStyle;
	}

	public TextStyle punctuationTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		return textStyle;
	}

}
