package org.slizaa.neo4j.opencypher.ui.custom.editor;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.widgets.ToolBar;
import org.eclipse.swt.widgets.ToolItem;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorSite;
import org.eclipse.ui.PartInitException;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.editor.XtextEditor;
import org.eclipse.xtext.util.concurrent.IUnitOfWork;
import org.slizaa.neo4j.opencypher.openCypher.Cypher;
import org.slizaa.neo4j.opencypher.ui.custom.internal.CustomOpenCypherActivator;
import org.slizaa.neo4j.opencypher.ui.custom.spi.IGraphDatabaseClientAdapter;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public class OpenCypherEditor extends XtextEditor {

  /** - */
  private Text                        _activeDatabaseLabel;

  /** - */
  private IGraphDatabaseClientAdapter _adapter;

  /** - */
  private Text                        _limit;

  private ToolItem                    _executeAction;

  /**
   * <p>
   * </p>
   *
   * @param adapter
   */
  public void setGraphDatabaseClientAdapter(IGraphDatabaseClientAdapter adapter) {
    _adapter = adapter;
    if (_adapter != null) {
      _activeDatabaseLabel.setText(_adapter.getName());
    } else {
      _activeDatabaseLabel.setText("");
    }
  }

  @Override
  public void init(IEditorSite site, IEditorInput input) throws PartInitException {
    super.init(site, input);
  }

  @Override
  public void dispose() {
    CustomOpenCypherActivator.getCustomOpenCypherActivator().unregisterEditor(this);
    super.dispose();
  }

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

    CustomOpenCypherActivator.getCustomOpenCypherActivator().registerEditor(this);
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
    // gridLayout.marginWidth = 15;
    //// gridLayout.marginHeight = 3;
    //// gridLayout.horizontalSpacing = 10;
    gridLayout.makeColumnsEqualWidth = false;
    composite.setLayout(gridLayout);
    composite.setLayoutData(new GridData(SWT.LEFT, SWT.CENTER, true, false));

    //
    Label label = new Label(composite, SWT.NO_BACKGROUND);
    label.setText("Query against:");
    label.setAlignment(SWT.RIGHT);
    label.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, true, true));

    //
    _activeDatabaseLabel = new Text(composite, SWT.NONE);
    _activeDatabaseLabel.setEditable(false);
    _activeDatabaseLabel.setBackground(CustomOpenCypherActivator.getCustomOpenCypherActivator().getLightGray());
    GridData gridData = new GridData(30 * 10, SWT.DEFAULT);
    _activeDatabaseLabel.setLayoutData(gridData);

    //
    label = new Label(composite, SWT.NO_BACKGROUND);
    label.setText("Default Limit:");
    label.setAlignment(SWT.RIGHT);
    label.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, true, true));

    _limit = new Text(composite, SWT.NONE);
    _limit.setBackground(CustomOpenCypherActivator.getCustomOpenCypherActivator().getLightGray());
    _limit.setTextLimit(5);
    _limit.setText("25");
    _limit.addListener(SWT.Verify, e -> {
      String string = e.text;
      char[] chars = new char[string.length()];
      string.getChars(0, chars.length, chars, 0);
      for (int i = 0; i < chars.length; i++) {
        if (!('0' <= chars[i] && chars[i] <= '9')) {
          e.doit = false;
          return;
        }
      }
    });
    gridData = new GridData(5 * 10, SWT.DEFAULT);
    _limit.setLayoutData(gridData);

    //
    ToolBar toolBar = new ToolBar(composite, SWT.FLAT);
    toolBar.setLayoutData(new GridData(SWT.LEFT, SWT.CENTER, true, true));
    _executeAction = new ToolItem(toolBar, SWT.PUSH);
    _executeAction.setImage(OpenCypherUiImages.EXECUTE_QUERY.getImage());
    _executeAction.addSelectionListener(new SelectionListener() {

      @Override
      public void widgetSelected(SelectionEvent e) {
        OpenCypherEditor.this.getDocument().readOnly(new IUnitOfWork<Void, XtextResource>() {

          @Override
          public java.lang.Void exec(XtextResource state) throws Exception {

            //
            Cypher query = (Cypher) state.getContents().get(0);

            if (_adapter != null) {
              int limit = _limit.getText() != null && !_limit.getText().trim().isEmpty()
                  ? Integer.parseInt(_limit.getText()) : -1;

              _executeAction.setEnabled(false);
              final Future<?> future = _adapter.executeCypherQuery(query, state.getSerializer(), limit);
              new Thread(() -> {
                try {
                  while (!(future.isDone() || future.isCancelled())) {
                    Thread.sleep(500);
                  }
                } catch (Exception e) {
                  e.printStackTrace();
                } finally {
                  Display.getDefault().syncExec(() -> _executeAction.setEnabled(true));
                }
              }).start();
            }

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
