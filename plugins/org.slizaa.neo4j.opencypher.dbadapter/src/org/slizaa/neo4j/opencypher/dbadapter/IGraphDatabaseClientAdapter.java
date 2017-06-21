package org.slizaa.neo4j.opencypher.dbadapter;

import java.util.List;
import java.util.concurrent.Future;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public interface IGraphDatabaseClientAdapter {

  /**
   * <p>
   * </p>
   *
   * @return
   */
  String getName();

  /**
   * <p>
   * </p>
   *
   * @return
   */
  boolean isAvailable();

  /**
   * <p>
   * </p>
   *
   * @param cypher
   * @return
   */
  Future<?> executeCypherQuery(String cypherquery, IQueryResultConsumer queryResultConsumer);

  /**
   * <p>
   * </p>
   *
   * @return
   */
  List<String> getNodeLabels();

  /**
   * <p>
   * </p>
   *
   * @return
   */
  List<String> getRelationhipTypes();

  /**
   * <p>
   * </p>
   *
   * @return
   */
  List<String> getPropertyKeys();
}
