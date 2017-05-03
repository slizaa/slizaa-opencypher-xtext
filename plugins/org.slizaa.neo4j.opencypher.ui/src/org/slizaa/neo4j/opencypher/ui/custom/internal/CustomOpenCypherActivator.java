package org.slizaa.neo4j.opencypher.ui.custom.internal;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.widgets.Display;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;
import org.slizaa.neo4j.opencypher.ui.custom.editor.OpenCypherEditor;
import org.slizaa.neo4j.opencypher.ui.custom.spi.IGraphDatabaseClientAdapter;
import org.slizaa.neo4j.opencypher.ui.custom.spi.IGraphDatabaseClientAdapterConsumer;
import org.slizaa.neo4j.opencypher.ui.internal.OpencypherActivator;

public class CustomOpenCypherActivator extends OpencypherActivator {

  private static CustomOpenCypherActivator                                         _instance;

  /** - */
  private Color                                                                    _lightGray;

  /** - */
  private ServiceTracker<IGraphDatabaseClientAdapter, IGraphDatabaseClientAdapter> _serviceTracker;

  /** - */
  private List<IGraphDatabaseClientAdapterConsumer>                                _graphDatabaseClientAdapterConsumers;

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public IGraphDatabaseClientAdapter getGraphDatabaseClientAdapter() {
    return _serviceTracker.getService();
  }

  /**
   * <p>
   * </p>
   *
   * @param openCypherEditor
   */
  public void registerEditor(OpenCypherEditor openCypherEditor) {
    IGraphDatabaseClientAdapter adapter = _serviceTracker.getService();
    if (adapter != null) {
      openCypherEditor.setGraphDatabaseClientAdapter(adapter);
    }
    _graphDatabaseClientAdapterConsumers.add(openCypherEditor);
  }

  /**
   * <p>
   * </p>
   *
   * @param openCypherEditor
   */
  public void unregisterEditor(OpenCypherEditor openCypherEditor) {
    _graphDatabaseClientAdapterConsumers.remove(openCypherEditor);
  }

  @Override
  public void start(BundleContext context) throws Exception {
    super.start(context);
    _instance = this;
    _lightGray = new Color(Display.getCurrent(), 240, 240, 240);

    //
    _graphDatabaseClientAdapterConsumers = new CopyOnWriteArrayList<>();

    //
    _serviceTracker = new ServiceTracker<IGraphDatabaseClientAdapter, IGraphDatabaseClientAdapter>(
        FrameworkUtil.getBundle(OpenCypherEditor.class).getBundleContext(), IGraphDatabaseClientAdapter.class, null) {

      @Override
      public IGraphDatabaseClientAdapter addingService(ServiceReference<IGraphDatabaseClientAdapter> reference) {
        IGraphDatabaseClientAdapter adapter = super.addingService(reference);
        for (IGraphDatabaseClientAdapterConsumer openCypherEditor : _graphDatabaseClientAdapterConsumers) {
          openCypherEditor.setGraphDatabaseClientAdapter(adapter);
        }
        return adapter;
      }

      @Override
      public void removedService(ServiceReference<IGraphDatabaseClientAdapter> reference,
          IGraphDatabaseClientAdapter service) {
        super.removedService(reference, service);
        for (IGraphDatabaseClientAdapterConsumer openCypherEditor : _graphDatabaseClientAdapterConsumers) {
          openCypherEditor.setGraphDatabaseClientAdapter(null);
        }
      }
    };
    _serviceTracker.open();
  }

  @Override
  public void stop(BundleContext context) throws Exception {
    _lightGray.dispose();
    _instance = null;

    _serviceTracker.close();

    super.stop(context);
  }

  public Color getLightGray() {
    return _lightGray;
  }

  public static CustomOpenCypherActivator getCustomOpenCypherActivator() {
    return _instance;
  }
}
