package org.slizaa.neo4j.opencypher.dbadapter;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public interface IQueryResultConsumer {

  /**
   * <p>
   * </p>
   *
   * @param cypherQuery
   * @return
   */
  boolean canConsume(String cypherQuery);

  /**
   * <p>
   * </p>
   *
   * @param cypherQuery
   */
  void handleQueryStarted(String cypherQuery);

  /**
   * <p>
   * </p>
   *
   * @param cypherQuery
   * @param result
   */
  void handleQueryResultReceived(String cypherQuery, Object result);
}
