package org.slizaa.neo4j.opencypher.ui.custom.editor;

import org.eclipse.swt.widgets.Composite;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.editor.XtextEditor;
import org.eclipse.xtext.util.concurrent.IUnitOfWork;
import org.slizaa.neo4j.opencypher.dbadapter.CypherNormalizer;
import org.slizaa.neo4j.opencypher.openCypher.Cypher;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public class OpenCypherEditor extends XtextEditor {

  // /** - */
  // private DbAdapterQueryPanel _panel;
  //
  // /**
  // * {@inheritDoc}
  // */
  // public void createPartControl(Composite parent) {
  //
  // //
  // _panel = new DbAdapterQueryPanel(parent, () -> {
  // return OpenCypherEditor.this.getDocument().readOnly(new IUnitOfWork<String, XtextResource>() {
  // public String exec(XtextResource state) throws Exception {
  // Cypher query = (Cypher) state.getContents().get(0);
  // return CypherNormalizer.normalize(state.getSerializer().serialize(query));
  // }
  // });
  // });
  //
  // //
  // super.createPartControl(_panel.getEditorArea());
  //
  // //
  // _panel.registerGraphDatabaseClientAdapterAwareOSGiService();
  // }
  //
  // @Override
  // public void dispose() {
  //
  // //
  // _panel.unregisterGraphDatabaseClientAdapterAwareOSGiService();
  //
  // super.dispose();
  // }

}
