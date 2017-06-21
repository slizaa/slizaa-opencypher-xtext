package org.slizaa.neo4j.opencypher.dbadapter.osgi;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;
import org.osgi.service.component.annotations.ReferencePolicyOption;
import org.slizaa.neo4j.opencypher.dbadapter.IGraphDatabaseClientAdapter;
import org.slizaa.neo4j.opencypher.dbadapter.IGraphDatabaseClientAdapterAware;
import org.slizaa.neo4j.opencypher.dbadapter.IQueryResultConsumer;
import org.slizaa.neo4j.opencypher.dbadapter.IQueryResultConsumerAware;

@Component
public class DbAdapterConnectorComponent {

  /** - */
  private IGraphDatabaseClientAdapter            _currentGraphDatabaseClientAdapter;

  /** - */
  private List<IGraphDatabaseClientAdapterAware> _databaseClientAdapterAwares = new CopyOnWriteArrayList<>();

  /** - */
  private List<IQueryResultConsumer>             _queryResultConsumers        = new CopyOnWriteArrayList<>();

  /** - */
  private List<IQueryResultConsumerAware>        _queryResultConsumerAwares   = new CopyOnWriteArrayList<>();

  /**
   * <p>
   * </p>
   */
  @Reference(cardinality = ReferenceCardinality.MULTIPLE, policy = ReferencePolicy.DYNAMIC)
  public void addGraphDatabaseClientAdapterConsumer(IGraphDatabaseClientAdapterAware consumer) {

    //
    if (_currentGraphDatabaseClientAdapter != null) {
      consumer.setGraphDatabaseClientAdapter(_currentGraphDatabaseClientAdapter);
    }

    //
    _databaseClientAdapterAwares.add(consumer);
  }

  /**
   * <p>
   * </p>
   */
  public void removeGraphDatabaseClientAdapterConsumer(IGraphDatabaseClientAdapterAware consumer) {

    //
    _databaseClientAdapterAwares.remove(consumer);

    //
    consumer.setGraphDatabaseClientAdapter(null);
  }

  /**
   * <p>
   * </p>
   *
   * @param clientAdapter
   */
  @Reference(cardinality = ReferenceCardinality.OPTIONAL, policy = ReferencePolicy.DYNAMIC, policyOption = ReferencePolicyOption.GREEDY)
  public void setGraphDatabaseClientAdapter(IGraphDatabaseClientAdapter clientAdapter) {

    //
    _currentGraphDatabaseClientAdapter = clientAdapter;

    //
    for (IGraphDatabaseClientAdapterAware consumer : _databaseClientAdapterAwares) {
      consumer.setGraphDatabaseClientAdapter(clientAdapter);
    }
  }

  /**
   * <p>
   * </p>
   *
   * @param clientAdapter
   */
  public void unsetGraphDatabaseClientAdapter(IGraphDatabaseClientAdapter clientAdapter) {

    //
    _currentGraphDatabaseClientAdapter = null;

    //
    for (IGraphDatabaseClientAdapterAware consumer : _databaseClientAdapterAwares) {
      consumer.setGraphDatabaseClientAdapter(null);
    }
  }

  @Reference(cardinality = ReferenceCardinality.MULTIPLE, policy = ReferencePolicy.DYNAMIC)
  public void addQueryResultConsumerAware(IQueryResultConsumerAware consumerAware) {

    //
    for (IQueryResultConsumer resultConsumer : _queryResultConsumers) {
      consumerAware.addQueryResultConsumer(resultConsumer);
    }

    //
    _queryResultConsumerAwares.add(consumerAware);
  }

  /**
   * <p>
   * </p>
   */
  public void removeQueryResultConsumerAware(IQueryResultConsumerAware consumerAware) {

    //
    _databaseClientAdapterAwares.remove(consumerAware);

    //
    for (IQueryResultConsumer resultConsumer : _queryResultConsumers) {
      consumerAware.removeQueryResultConsumer(resultConsumer);
    }
  }

  @Reference(cardinality = ReferenceCardinality.MULTIPLE, policy = ReferencePolicy.DYNAMIC)
  public void addQueryResultConsumer(IQueryResultConsumer queryResultConsumer) {

    //
    for (IQueryResultConsumerAware aware : _queryResultConsumerAwares) {
      aware.addQueryResultConsumer(queryResultConsumer);
    }

    //
    _queryResultConsumers.add(queryResultConsumer);
  }

  /**
   * <p>
   * </p>
   */
  public void removeQueryResultConsumer(IQueryResultConsumer queryResultConsumer) {

    //
    _queryResultConsumers.remove(queryResultConsumer);

    //
    for (IQueryResultConsumerAware aware : _queryResultConsumerAwares) {
      aware.removeQueryResultConsumer(queryResultConsumer);
    }
  }
}
