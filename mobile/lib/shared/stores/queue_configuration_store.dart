
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class QueueConfigurationStore extends ModelStreamStore<String, QueueConfiguration> {

  static QueueConfigurationStore? _instance;

  static QueueConfigurationStore get instance {
    _instance ??= QueueConfigurationStore();
    return _instance!;
  }

  QueueConfigurationStore() : super(QueueConfiguration.fromJson) {
    if (_instance != null) {
        throw Exception(
            'QueueConfigurationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending QueueConfigurationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use QueueConfigurationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getQueueConfigurationId(QueueConfiguration queueConfiguration) => queueConfiguration.id;

	String? getQueueConfigurationOrgId(QueueConfiguration queueConfiguration) => queueConfiguration.orgId;

	String? getQueueConfigurationQueueName(QueueConfiguration queueConfiguration) => queueConfiguration.queueName;

	String? getQueueConfigurationExchangeName(QueueConfiguration queueConfiguration) => queueConfiguration.exchangeName;

	String? getQueueConfigurationRoutingKey(QueueConfiguration queueConfiguration) => queueConfiguration.routingKey;

	String? getQueueConfigurationMessageType(QueueConfiguration queueConfiguration) => queueConfiguration.messageType;

	String? getQueueConfigurationHandlerClass(QueueConfiguration queueConfiguration) => queueConfiguration.handlerClass;

	int? getQueueConfigurationMaxConcurrency(QueueConfiguration queueConfiguration) => queueConfiguration.maxConcurrency;

	dynamic? getQueueConfigurationRetryPolicy(QueueConfiguration queueConfiguration) => queueConfiguration.retryPolicy;

	String? getQueueConfigurationDeadLetterQueue(QueueConfiguration queueConfiguration) => queueConfiguration.deadLetterQueue;

	bool? getQueueConfigurationIsActive(QueueConfiguration queueConfiguration) => queueConfiguration.isActive;

	DateTime? getQueueConfigurationCreatedAt(QueueConfiguration queueConfiguration) => queueConfiguration.createdAt;

	DateTime? getQueueConfigurationUpdatedAt(QueueConfiguration queueConfiguration) => queueConfiguration.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
QueueConfiguration? getByQueueName(
    String queueName,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getIncluding(getQueueConfigurationQueueName, queueName, modelFilter: modelFilter, includes: includes);

  
List<QueueConfiguration> getByOrgId(
    String orgId,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByExchangeName(
    String exchangeName,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationExchangeName, exchangeName, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByRoutingKey(
    String routingKey,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationRoutingKey, routingKey, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByMessageType(
    String messageType,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationMessageType, messageType, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByHandlerClass(
    String handlerClass,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationHandlerClass, handlerClass, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByMaxConcurrency(
    int maxConcurrency,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationMaxConcurrency, maxConcurrency, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByRetryPolicy(
    dynamic retryPolicy,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationRetryPolicy, retryPolicy, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByDeadLetterQueue(
    String deadLetterQueue,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationDeadLetterQueue, deadLetterQueue, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByIsActive(
    bool isActive,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<QueueConfiguration> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getQueueConfigurationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    QueueConfiguration queueConfiguration, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (queueConfiguration.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(queueConfiguration.orgId!, includes: includes);
        queueConfiguration.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<QueueConfiguration>> getAll$({bool useCache = true, ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: QueueConfigurationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<QueueConfiguration?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getQueueConfigurationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<QueueConfiguration?> getByQueueName$(
        String queueName,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getQueueConfigurationQueueName,
        value: queueName,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getByQueueName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<QueueConfiguration>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueConfigurationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByExchangeName$(
        String exchangeName,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueConfigurationExchangeName,
        value: exchangeName,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByExchangeName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByRoutingKey$(
        String routingKey,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueConfigurationRoutingKey,
        value: routingKey,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByRoutingKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByMessageType$(
        String messageType,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueConfigurationMessageType,
        value: messageType,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByMessageType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByHandlerClass$(
        String handlerClass,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueConfigurationHandlerClass,
        value: handlerClass,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByHandlerClass,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByMaxConcurrency$(
        int maxConcurrency,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getQueueConfigurationMaxConcurrency,
        value: maxConcurrency,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByMaxConcurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByRetryPolicy$(
        dynamic retryPolicy,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getQueueConfigurationRetryPolicy,
        value: retryPolicy,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByRetryPolicy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByDeadLetterQueue$(
        String deadLetterQueue,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueConfigurationDeadLetterQueue,
        value: deadLetterQueue,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByDeadLetterQueue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getQueueConfigurationIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQueueConfigurationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueConfiguration>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<QueueConfiguration>? modelFilter,
        List<QueueConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQueueConfigurationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: QueueConfigurationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    QueueConfiguration queueConfiguration, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (queueConfiguration.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            queueConfiguration.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            queueConfiguration.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
QueueConfiguration recursiveUpsert(QueueConfiguration queueConfiguration, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'QueueConfiguration'} 
        : const {};
    if (queueConfiguration.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        queueConfiguration.org = OrganizationStore.instance.recursiveUpsert(queueConfiguration.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(queueConfiguration);
}

  List<QueueConfiguration> recursiveListUpsert(List<QueueConfiguration> queueConfigurations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedQueueConfigurations = <QueueConfiguration>[];
    for (var queueConfiguration in queueConfigurations) {
        updatedQueueConfigurations.add(recursiveUpsert(queueConfiguration, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedQueueConfigurations;
}

//   @override
//   QueueConfiguration upsert(QueueConfiguration item) {
//     return recursiveUpsert(item);
//   }

}


class QueueConfigurationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      QueueConfigurationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (queueConfiguration) => QueueConfigurationStore.instance
            .getOrg$(queueConfiguration, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (queueConfiguration) => QueueConfigurationStore.instance
            .getOrg(queueConfiguration, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum QueueConfigurationEndpoints implements Endpoint {

    getAll('/queueConfiguration', HttpMethod.post, List<QueueConfiguration>),
	getById('/queueConfiguration/byId/:id', HttpMethod.post, QueueConfiguration),
	getManyByOrgId('/queueConfiguration/byOrgId/:orgId', HttpMethod.post, List<QueueConfiguration>),
	getByQueueName('/queueConfiguration/byQueueName/:queueName', HttpMethod.post, QueueConfiguration),
	getManyByExchangeName('/queueConfiguration/byExchangeName/:exchangeName', HttpMethod.post, List<QueueConfiguration>),
	getManyByRoutingKey('/queueConfiguration/byRoutingKey/:routingKey', HttpMethod.post, List<QueueConfiguration>),
	getManyByMessageType('/queueConfiguration/byMessageType/:messageType', HttpMethod.post, List<QueueConfiguration>),
	getManyByHandlerClass('/queueConfiguration/byHandlerClass/:handlerClass', HttpMethod.post, List<QueueConfiguration>),
	getManyByMaxConcurrency('/queueConfiguration/byMaxConcurrency/:maxConcurrency', HttpMethod.post, List<QueueConfiguration>),
	getManyByRetryPolicy('/queueConfiguration/byRetryPolicy/:retryPolicy', HttpMethod.post, List<QueueConfiguration>),
	getManyByDeadLetterQueue('/queueConfiguration/byDeadLetterQueue/:deadLetterQueue', HttpMethod.post, List<QueueConfiguration>),
	getManyByIsActive('/queueConfiguration/byIsActive/:isActive', HttpMethod.post, List<QueueConfiguration>),
	getManyByCreatedAt('/queueConfiguration/byCreatedAt/:createdAt', HttpMethod.post, List<QueueConfiguration>),
	getManyByUpdatedAt('/queueConfiguration/byUpdatedAt/:updatedAt', HttpMethod.post, List<QueueConfiguration>);

    const QueueConfigurationEndpoints(this.path, this.method, this.responseType);

    @override
  final String path;

  @override
  final HttpMethod method;

  final Type responseType;

  static String withPathParameter(String path, dynamic param) {
    final regex = RegExp(r':([a-zA-Z]+)');
    return path.replaceFirst(regex, param.toString());
  }
}
