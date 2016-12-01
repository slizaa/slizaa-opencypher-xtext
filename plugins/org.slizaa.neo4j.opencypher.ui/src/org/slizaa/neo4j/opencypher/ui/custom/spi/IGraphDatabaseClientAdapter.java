package org.slizaa.neo4j.opencypher.ui.custom.spi;

import java.util.List;

import org.slizaa.neo4j.opencypher.openCypher.Cypher;

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
  void executeCypherQuery(String cypher);
  
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
