package org.slizaa.neo4j.opencypher.dbadapter;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public interface IGraphDatabaseClientAdapterAware {

  /**
   * <p>
   * </p>
   *
   * @param adapter
   */
  void setGraphDatabaseClientAdapter(IGraphDatabaseClientAdapter adapter);
}
