package org.slizaa.neo4j.opencypher.ui.custom.internal;

import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.widgets.Display;
import org.osgi.framework.BundleContext;
import org.slizaa.neo4j.opencypher.spi.IGraphDatabaseClientAdapter;
import org.slizaa.neo4j.opencypher.ui.custom.editor.OpenCypherEditor;
import org.slizaa.neo4j.opencypher.ui.internal.OpencypherActivator;

public class CustomOpenCypherActivator extends OpencypherActivator {

  private static CustomOpenCypherActivator             _instance;

  /** - */
  private Color                                        _lightGray;

  /** - */
  private OSGiBasedGraphDatabaseClientAdapterConnector _connector;

  /**
   * <p>
   * </p>
   *
   * @return
   */
  public IGraphDatabaseClientAdapter getGraphDatabaseClientAdapter() {
    return _connector.getCurrentGraphDatabaseClientAdapter();
  }

  /**
   * <p>
   * </p>
   *
   * @param openCypherEditor
   */
  public void registerEditor(OpenCypherEditor openCypherEditor) {
    _connector.registerConsumer(openCypherEditor);
  }

  /**
   * <p>
   * </p>
   *
   * @param openCypherEditor
   */
  public void unregisterEditor(OpenCypherEditor openCypherEditor) {
    _connector.unregisterConsumer(openCypherEditor);
  }

  @Override
  public void start(BundleContext context) throws Exception {
    super.start(context);
    _instance = this;
    _lightGray = new Color(Display.getCurrent(), 240, 240, 240);

    //
    _connector = new OSGiBasedGraphDatabaseClientAdapterConnector(context);
    _connector.initialize();
  }

  @Override
  public void stop(BundleContext context) throws Exception {
    _lightGray.dispose();
    _instance = null;

    _connector.dispose();

    super.stop(context);
  }

  public Color getLightGray() {
    return _lightGray;
  }

  public static CustomOpenCypherActivator getCustomOpenCypherActivator() {
    return _instance;
  }
}
