package org.slizaa.neo4j.opencypher.spi;

import java.util.List;

/**
 * <p>
 * </p>
 *
 * @author Gerd W&uuml;therich (gerd@gerd-wuetherich.de)
 */
public interface IGraphMetaDataProvider {

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
  List<String> getRelationshipTypes();

  /**
   * <p>
   * </p>
   *
   * @return
   */
  List<String> getPropertyKeys();
}
