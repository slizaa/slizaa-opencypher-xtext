package org.slizaa.neo4j.opencypher.spi;

import java.util.List;
import java.util.concurrent.Future;

import org.eclipse.xtext.serializer.ISerializer;
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
  Future<?> executeCypherQuery(Cypher cypher, ISerializer serializer);
  
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
