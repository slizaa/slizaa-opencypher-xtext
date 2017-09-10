package org.slizaa.neo4j.opencypher.ui.internal;

import org.eclipse.swt.graphics.Color;
import org.osgi.framework.BundleContext;
import org.osgi.util.tracker.ServiceTracker;
import org.slizaa.neo4j.opencypher.spi.IGraphMetaDataProvider;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public class CustomOpenCypherActivator extends OpencypherActivator {

  /** - */
  private static CustomOpenCypherActivator                               _instance;

  /** - */
  private Color                                                          _lightGray;

  /** - */
  private ServiceTracker<IGraphMetaDataProvider, IGraphMetaDataProvider> _currentGraphMetaDataProviderTracker;

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public IGraphMetaDataProvider getCurrentGraphMetaDataProvider() {
    return _currentGraphMetaDataProviderTracker.getService();
  }

  /**
   * {@inheritDoc}
   */
  @Override
  public void start(BundleContext context) throws Exception {
    super.start(context);
    _instance = this;

    _currentGraphMetaDataProviderTracker = new ServiceTracker<>(context, IGraphMetaDataProvider.class, null);
    _currentGraphMetaDataProviderTracker.open();
  }

  /**
   * {@inheritDoc}
   */
  @Override
  public void stop(BundleContext context) throws Exception {
    if (_lightGray != null) {
      _lightGray.dispose();
    }
    _currentGraphMetaDataProviderTracker.close();
    _instance = null;

    super.stop(context);
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
