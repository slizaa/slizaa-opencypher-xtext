package org.slizaa.neo4j.opencypher.ui.custom.editor;

import static com.google.common.base.Preconditions.checkNotNull;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.Future;
import java.util.function.Supplier;

import org.eclipse.jface.layout.GridLayoutFactory;
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
import org.osgi.framework.FrameworkUtil;
import org.osgi.framework.ServiceRegistration;
import org.slizaa.neo4j.opencypher.dbadapter.IGraphDatabaseClientAdapter;
import org.slizaa.neo4j.opencypher.dbadapter.IGraphDatabaseClientAdapterAware;
import org.slizaa.neo4j.opencypher.dbadapter.IQueryResultConsumer;
import org.slizaa.neo4j.opencypher.dbadapter.IQueryResultConsumerAware;
import org.slizaa.neo4j.opencypher.ui.custom.internal.CustomOpenCypherActivator;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public class DbAdapterQueryPanel extends Composite
    implements IGraphDatabaseClientAdapterAware, IQueryResultConsumerAware {

  /** - */
  private Text                        _activeDatabaseLabel;

  /** - */
  private IGraphDatabaseClientAdapter _adapter;

  /** - */
  private List<IQueryResultConsumer>  _queryResultConsumers;

  /** - */
  private ToolItem                    _executeAction;

  /** - */
  private Composite                   _panel;

  /** - */
  private ServiceRegistration<?>      _serviceRegistration;

  /**
   * <p>
   * Creates a new instance of type {@link DbAdapterQueryPanel}.
   * </p>
   *
   * @param parent
   * @param cypherQuerySupplier
   */
  public DbAdapterQueryPanel(Composite parent, Supplier<String> cypherQuerySupplier) {
    super(parent, SWT.NONE);

    //
    checkNotNull(cypherQuerySupplier);

    this.setLayout(GridLayoutFactory.fillDefaults().equalWidth(false).numColumns(1).margins(0, 0).create());

    _queryResultConsumers = new CopyOnWriteArrayList<>();

    createQueryComposite(this, cypherQuerySupplier);

    _panel = new Composite(this, SWT.NONE);
    _panel.setLayout(new FillLayout());
    _panel.setLayoutData(new GridData(GridData.FILL, GridData.FILL, true, true));
  }

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public Composite getEditorArea() {
    return _panel;
  }

  /**
   * <p>
   * </p>
   *
   * @param adapter
   */
  @Override
  public void setGraphDatabaseClientAdapter(IGraphDatabaseClientAdapter adapter) {

    //
    if (isDisposed()) {
      return;
    }

    _adapter = adapter;
    if (_adapter != null) {
      _activeDatabaseLabel.setText(_adapter.getName());
      _executeAction.setEnabled(true);
    } else {
      _activeDatabaseLabel.setText("");
      _executeAction.setEnabled(false);
    }
  }

  @Override
  public void addQueryResultConsumer(IQueryResultConsumer consumer) {
    System.out.println("ADDED " + consumer);
    _queryResultConsumers.add(consumer);
  }

  @Override
  public void removeQueryResultConsumer(IQueryResultConsumer consumer) {
    System.out.println("REMOVED " + consumer);
    _queryResultConsumers.remove(consumer);
  }

  /**
   * <p>
   * </p>
   */
  public void registerGraphDatabaseClientAdapterAwareOSGiService() {

    // register as OSGi service
    try {
      _serviceRegistration = FrameworkUtil.getBundle(OpenCypherEditor.class).getBundleContext().registerService(
          new String[] { IGraphDatabaseClientAdapterAware.class.getName(), IQueryResultConsumerAware.class.getName() },
          this, null);
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  /**
   * <p>
   * </p>
   */
  public void unregisterGraphDatabaseClientAdapterAwareOSGiService() {

    if (_serviceRegistration != null) {
      // deregister as OSGi service
      _serviceRegistration.unregister();
    }
  }

  /**
   * <p>
   * </p>
   *
   * @param parent
   */
  private void createQueryComposite(Composite parent, Supplier<String> cypherQuerySupplier) {

    //
    Composite composite = new Composite(parent, SWT.NONE);
    GridLayout gridLayout = new GridLayout();
    gridLayout.numColumns = 5;
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
    ToolBar toolBar = new ToolBar(composite, SWT.FLAT);
    toolBar.setLayoutData(new GridData(SWT.LEFT, SWT.CENTER, true, true));
    _executeAction = new ToolItem(toolBar, SWT.PUSH);
    _executeAction.setEnabled(false);
    _executeAction.setImage(OpenCypherUiImages.EXECUTE_QUERY.getImage());
    _executeAction.addSelectionListener(new SelectionListener() {
      @Override
      public void widgetSelected(SelectionEvent e) {

        String cypherString = cypherQuerySupplier.get();

        if (_queryResultConsumers.size() == 0) {
          return;
        }

        if (_adapter != null) {
          _executeAction.setEnabled(false);
          try {

            // TODO

            final Future<?> future = _adapter.executeCypherQuery(cypherString, _queryResultConsumers.get(0));
            new Thread(() -> {
              try {
                while (!(future.isDone() || future.isCancelled())) {
                  Thread.sleep(500);
                }
              } catch (Exception exception) {
                exception.printStackTrace();
              } finally {
                Display.getDefault().syncExec(() -> _executeAction.setEnabled(true));
              }
            }).start();

          } catch (Exception exception) {
            _executeAction.setEnabled(true);
          }
        }

      }

      @Override
      public void widgetDefaultSelected(SelectionEvent e) {
        //
      }
    });
  }
}
