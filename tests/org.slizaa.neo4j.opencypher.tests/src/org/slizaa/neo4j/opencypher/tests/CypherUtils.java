package org.slizaa.neo4j.opencypher.tests;

import static com.google.common.base.Preconditions.checkNotNull;

import java.util.List;

import org.eclipse.xtext.EcoreUtil2;
import org.slizaa.neo4j.opencypher.openCypher.Cypher;
import org.slizaa.neo4j.opencypher.openCypher.FunctionInvocation;
import org.slizaa.neo4j.opencypher.openCypher.ReturnItem;

public class CypherUtils {

  /**
   * <p>
   * </p>
   *
   * @param cypher
   * @return
   */
  public static boolean returnItemsContainOnlyIds(Cypher cypher) {

    //
    List<ReturnItem> returnItems = EcoreUtil2.eAllOfType(checkNotNull(cypher), ReturnItem.class);

    //
    return returnItems != null && !returnItems.isEmpty() && returnItems.stream().allMatch(item -> {
      return item.getExpression() instanceof FunctionInvocation
          && "id".equals(((FunctionInvocation) item.getExpression()).getFunctionName());
    });
  }
}
