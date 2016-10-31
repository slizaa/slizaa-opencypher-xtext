package org.slizaa.neo4j.opencypher.ui.custom.spi;

import java.util.List;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public interface IGraphDatabaseClientProvider {

  /**
   * <p>
   * </p>
   *
   * @return
   */
  List<IGraphDatabaseClientAdapter> getGraphDatabaseAdapters();

  /**
   * <p>
   * </p>
   *
   * @return
   */
  IGraphDatabaseClientAdapter getDefaultGraphDatabaseAdapter();

  /**
   * <p>
   * </p>
   *
   * @param name
   * @return
   */
  IGraphDatabaseClientAdapter getGraphDatabaseAdapter(String name);
}
