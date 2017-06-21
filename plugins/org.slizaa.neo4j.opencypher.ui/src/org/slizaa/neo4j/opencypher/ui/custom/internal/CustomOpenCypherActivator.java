package org.slizaa.neo4j.opencypher.ui.custom.internal;

import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.widgets.Display;
import org.osgi.framework.BundleContext;
import org.osgi.util.tracker.ServiceTracker;
import org.slizaa.neo4j.opencypher.dbadapter.IGraphDatabaseClientAdapter;
import org.slizaa.neo4j.opencypher.ui.internal.OpencypherActivator;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public class CustomOpenCypherActivator extends OpencypherActivator {

  /** - */
  private static CustomOpenCypherActivator                                         _instance;

  /** - */
  private Color                                                                    _lightGray;

  /** - */
  private ServiceTracker<IGraphDatabaseClientAdapter, IGraphDatabaseClientAdapter> _currentGraphDatabaseClientAdapterTracker;

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public IGraphDatabaseClientAdapter getCurrentGraphDatabaseClientAdapter() {
    return _currentGraphDatabaseClientAdapterTracker.getService();
  }

  /**
   * {@inheritDoc}
   */
  @Override
  public void start(BundleContext context) throws Exception {
    super.start(context);
    _instance = this;

    _currentGraphDatabaseClientAdapterTracker = new ServiceTracker<>(context, IGraphDatabaseClientAdapter.class, null);
    _currentGraphDatabaseClientAdapterTracker.open();
  }

  /**
   * {@inheritDoc}
   */
  @Override
  public void stop(BundleContext context) throws Exception {
    if (_lightGray != null) {
      _lightGray.dispose();
    }
    _currentGraphDatabaseClientAdapterTracker.close();
    _instance = null;

    super.stop(context);
  }

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public Color getLightGray() {
    if (_lightGray == null) {
      _lightGray = new Color(Display.getCurrent(), 240, 240, 240);
    }
    return _lightGray;
  }

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public static CustomOpenCypherActivator getCustomOpenCypherActivator() {
    return _instance;
  }
}
