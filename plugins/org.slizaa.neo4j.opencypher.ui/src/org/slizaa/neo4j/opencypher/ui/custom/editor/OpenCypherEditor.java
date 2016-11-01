package org.slizaa.neo4j.opencypher.ui.custom.editor;

import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CCombo;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.widgets.ToolBar;
import org.eclipse.swt.widgets.ToolItem;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.editor.XtextEditor;
import org.eclipse.xtext.util.concurrent.IUnitOfWork;
import org.slizaa.neo4j.opencypher.openCypher.Cypher;
import org.slizaa.neo4j.opencypher.ui.custom.internal.CustomOpenCypherActivator;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public class OpenCypherEditor extends XtextEditor {

  /**
   * {@inheritDoc}
   */
  public void createPartControl(Composite parent) {

    Composite interceptor = new Composite(parent, SWT.NONE);
    interceptor.setLayout(new GridLayout(1, false));

    createQueryComposite(interceptor);

    Composite panel = new Composite(interceptor, SWT.NONE);
    panel.setLayout(new FillLayout());
    panel.setLayoutData(new GridData(GridData.FILL, GridData.FILL, true, true));

    super.createPartControl(panel);
  }
  
  /**
   * <p>
   * </p>
   *
   * @param parent
   */
  private void createQueryComposite(Composite parent) {

    //
    Composite composite = new Composite(parent, SWT.NONE);
    GridLayout gridLayout = new GridLayout();
    gridLayout.numColumns = 5;
//    gridLayout.marginWidth = 15;
////    gridLayout.marginHeight = 3;
////    gridLayout.horizontalSpacing = 10;
    gridLayout.makeColumnsEqualWidth = false;
    composite.setLayout(gridLayout);
    composite.setLayoutData(new GridData(SWT.LEFT, SWT.CENTER, true, false));

    //
    Label label = new Label(composite, SWT.NO_BACKGROUND);
    label.setText("Query against:");
    label.setAlignment(SWT.RIGHT);
    label.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, true, true));

    //
    CCombo combo = new CCombo(composite, SWT.READ_ONLY | SWT.FLAT );
    combo.setBackground(CustomOpenCypherActivator.getCustomOpenCypherActivator().getLightGray());
    combo.setLayoutData(new GridData(SWT.LEFT, SWT.CENTER, true, true));
    combo.add("http://localhost:7474");
    combo.add("http://schnurz:7474");
    combo.setText("http://schnurz:7474");
    
    //
    label = new Label(composite, SWT.NO_BACKGROUND);
    label.setText("Limit:");
    label.setAlignment(SWT.RIGHT);
    label.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, true, true));
    
    //
    Text text = new Text(composite, SWT.NONE);
    text.setBackground(CustomOpenCypherActivator.getCustomOpenCypherActivator().getLightGray());
    text.setTextLimit(5);
    text.setText("25");
    text.addListener (SWT.Verify, e -> {
      String string = e.text;
      char [] chars = new char [string.length ()];
      string.getChars (0, chars.length, chars, 0);
      for (int i=0; i<chars.length; i++) {
        if (!('0' <= chars [i] && chars [i] <= '9')) {
          e.doit = false;
          return;
        }
      }
    });
    GridData gridData = new GridData(5 * 10, SWT.DEFAULT);
    text.setLayoutData(gridData);
    
    //
    ToolBar toolBar = new ToolBar(composite, SWT.FLAT);
    toolBar.setLayoutData(new GridData(SWT.LEFT, SWT.CENTER, true, true));
    ToolItem item = new ToolItem(toolBar, SWT.PUSH);
    item.setImage(OpenCypherUiImages.EXECUTE_QUERY.getImage());
    item.addSelectionListener(new SelectionListener() {
      
      @Override
      public void widgetSelected(SelectionEvent e) {
        OpenCypherEditor.this.getDocument().readOnly(new IUnitOfWork<Void, XtextResource>() {

          @Override
          public java.lang.Void exec(XtextResource state) throws Exception {
            Cypher cypher = (Cypher)state.getContents().get(0);
            state.getSerializer().serialize(cypher);
            System.out.println(state.getSerializer().serialize(cypher));
            return null;
          }
          
        });
      }
      
      @Override
      public void widgetDefaultSelected(SelectionEvent e) {
        // 
      }
    });
    
  }
}
