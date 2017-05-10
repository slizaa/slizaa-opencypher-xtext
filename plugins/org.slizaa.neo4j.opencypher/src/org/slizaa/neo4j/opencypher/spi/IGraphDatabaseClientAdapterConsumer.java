package org.slizaa.neo4j.opencypher.spi;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public interface IGraphDatabaseClientAdapterConsumer {

  /**
   * <p>
   * </p>
   *
   * @param adapter
   */
  void setGraphDatabaseClientAdapter(IGraphDatabaseClientAdapter adapter);
}
