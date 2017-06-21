package org.slizaa.neo4j.opencypher.dbadapter;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public interface IQueryResultConsumerAware {

  /**
   * <p>
   * </p>
   *
   * @param consumer
   */
  void addQueryResultConsumer(IQueryResultConsumer consumer);

  /**
   * <p>
   * </p>
   *
   * @param consumer
   */
  void removeQueryResultConsumer(IQueryResultConsumer consumer);
}
