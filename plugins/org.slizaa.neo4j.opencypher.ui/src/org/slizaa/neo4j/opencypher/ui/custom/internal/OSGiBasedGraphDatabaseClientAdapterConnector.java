package org.slizaa.neo4j.opencypher.ui.custom.internal;

import static com.google.common.base.Preconditions.checkNotNull;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;
import org.slizaa.neo4j.opencypher.spi.IGraphDatabaseClientAdapter;
import org.slizaa.neo4j.opencypher.spi.IGraphDatabaseClientAdapterConsumer;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public class OSGiBasedGraphDatabaseClientAdapterConnector {

  /** - */
  private ServiceTracker<IGraphDatabaseClientAdapter, IGraphDatabaseClientAdapter> _graphDatabaseClientAdapterServiceTracker;

  /** - */
  private List<IGraphDatabaseClientAdapterConsumer>                                _graphDatabaseClientAdapterConsumers;

  /**
   * <p>
   * Creates a new instance of type {@link OSGiBasedGraphDatabaseClientAdapterConnector}.
   * </p>
   */
  public OSGiBasedGraphDatabaseClientAdapterConnector(BundleContext context) {

    //
    _graphDatabaseClientAdapterConsumers = new CopyOnWriteArrayList<>();

    //
    _graphDatabaseClientAdapterServiceTracker = new ServiceTracker<IGraphDatabaseClientAdapter, IGraphDatabaseClientAdapter>(
        checkNotNull(context), IGraphDatabaseClientAdapter.class, null) {

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
  }

  /**
   * <p>
   * </p>
   */
  public void initialize() {
    _graphDatabaseClientAdapterServiceTracker.open();
  }

  /**
   * <p>
   * </p>
   *
   * @throws Exception
   */
  public void dispose() throws Exception {
    _graphDatabaseClientAdapterServiceTracker.close();
  }

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public IGraphDatabaseClientAdapter getCurrentGraphDatabaseClientAdapter() {
    return _graphDatabaseClientAdapterServiceTracker.getService();
  }

  /**
   * <p>
   * </p>
   *
   * @param openCypherEditor
   */
  public void registerConsumer(IGraphDatabaseClientAdapterConsumer consumer) {

    //
    checkNotNull(consumer);

    //
    IGraphDatabaseClientAdapter adapter = _graphDatabaseClientAdapterServiceTracker.getService();
    if (adapter != null) {
      consumer.setGraphDatabaseClientAdapter(adapter);
    }

    //
    _graphDatabaseClientAdapterConsumers.add(consumer);
  }

  /**
   * <p>
   * </p>
   *
   * @param consumer
   */
  public void unregisterConsumer(IGraphDatabaseClientAdapterConsumer consumer) {
    _graphDatabaseClientAdapterConsumers.remove(consumer);
  }
}
