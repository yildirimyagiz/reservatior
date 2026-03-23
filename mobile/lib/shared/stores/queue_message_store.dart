
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class QueueMessageStore extends ModelStreamStore<String, QueueMessage> {

  static QueueMessageStore? _instance;

  static QueueMessageStore get instance {
    _instance ??= QueueMessageStore();
    return _instance!;
  }

  QueueMessageStore() : super(QueueMessage.fromJson) {
    if (_instance != null) {
        throw Exception(
            'QueueMessageStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending QueueMessageStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use QueueMessageStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getQueueMessageId(QueueMessage queueMessage) => queueMessage.id;

	String? getQueueMessageOrgId(QueueMessage queueMessage) => queueMessage.orgId;

	String? getQueueMessageMessageId(QueueMessage queueMessage) => queueMessage.messageId;

	String? getQueueMessageQueueName(QueueMessage queueMessage) => queueMessage.queueName;

	String? getQueueMessageExchangeName(QueueMessage queueMessage) => queueMessage.exchangeName;

	String? getQueueMessageRoutingKey(QueueMessage queueMessage) => queueMessage.routingKey;

	String? getQueueMessageMessageType(QueueMessage queueMessage) => queueMessage.messageType;

	dynamic? getQueueMessagePayload(QueueMessage queueMessage) => queueMessage.payload;

	String? getQueueMessageStatus(QueueMessage queueMessage) => queueMessage.status;

	int? getQueueMessagePriority(QueueMessage queueMessage) => queueMessage.priority;

	int? getQueueMessageRetryCount(QueueMessage queueMessage) => queueMessage.retryCount;

	int? getQueueMessageMaxRetries(QueueMessage queueMessage) => queueMessage.maxRetries;

	DateTime? getQueueMessageNextRetryAt(QueueMessage queueMessage) => queueMessage.nextRetryAt;

	DateTime? getQueueMessageProcessedAt(QueueMessage queueMessage) => queueMessage.processedAt;

	DateTime? getQueueMessageCompletedAt(QueueMessage queueMessage) => queueMessage.completedAt;

	DateTime? getQueueMessageFailedAt(QueueMessage queueMessage) => queueMessage.failedAt;

	String? getQueueMessageErrorMessage(QueueMessage queueMessage) => queueMessage.errorMessage;

	DateTime? getQueueMessageCreatedAt(QueueMessage queueMessage) => queueMessage.createdAt;

	DateTime? getQueueMessageUpdatedAt(QueueMessage queueMessage) => queueMessage.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
QueueMessage? getByMessageId(
    String messageId,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getIncluding(getQueueMessageMessageId, messageId, modelFilter: modelFilter, includes: includes);

  
List<QueueMessage> getByOrgId(
    String orgId,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByQueueName(
    String queueName,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageQueueName, queueName, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByExchangeName(
    String exchangeName,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageExchangeName, exchangeName, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByRoutingKey(
    String routingKey,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageRoutingKey, routingKey, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByMessageType(
    String messageType,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageMessageType, messageType, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByPayload(
    dynamic payload,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessagePayload, payload, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByStatus(
    String status,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageStatus, status, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByPriority(
    int priority,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessagePriority, priority, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByRetryCount(
    int retryCount,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageRetryCount, retryCount, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByMaxRetries(
    int maxRetries,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageMaxRetries, maxRetries, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByNextRetryAt(
    DateTime nextRetryAt,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageNextRetryAt, nextRetryAt, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByProcessedAt(
    DateTime processedAt,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageProcessedAt, processedAt, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByCompletedAt(
    DateTime completedAt,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageCompletedAt, completedAt, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByFailedAt(
    DateTime failedAt,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageFailedAt, failedAt, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByErrorMessage(
    String errorMessage,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageErrorMessage, errorMessage, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<QueueMessage> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}
    ) =>
    getManyIncluding(getQueueMessageUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    QueueMessage queueMessage, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (queueMessage.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(queueMessage.orgId!, includes: includes);
        queueMessage.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<QueueMessage>> getAll$({bool useCache = true, ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: QueueMessageEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<QueueMessage?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getQueueMessageId,
        value: id,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<QueueMessage?> getByMessageId$(
        String messageId,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getQueueMessageMessageId,
        value: messageId,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getByMessageId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<QueueMessage>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueMessageOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByQueueName$(
        String queueName,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueMessageQueueName,
        value: queueName,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByQueueName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByExchangeName$(
        String exchangeName,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueMessageExchangeName,
        value: exchangeName,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByExchangeName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByRoutingKey$(
        String routingKey,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueMessageRoutingKey,
        value: routingKey,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByRoutingKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByMessageType$(
        String messageType,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueMessageMessageType,
        value: messageType,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByMessageType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByPayload$(
        dynamic payload,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getQueueMessagePayload,
        value: payload,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByPayload,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueMessageStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByPriority$(
        int priority,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getQueueMessagePriority,
        value: priority,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByPriority,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByRetryCount$(
        int retryCount,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getQueueMessageRetryCount,
        value: retryCount,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByRetryCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByMaxRetries$(
        int maxRetries,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getQueueMessageMaxRetries,
        value: maxRetries,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByMaxRetries,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByNextRetryAt$(
        DateTime nextRetryAt,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQueueMessageNextRetryAt,
        value: nextRetryAt,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByNextRetryAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByProcessedAt$(
        DateTime processedAt,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQueueMessageProcessedAt,
        value: processedAt,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByProcessedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByCompletedAt$(
        DateTime completedAt,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQueueMessageCompletedAt,
        value: completedAt,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByCompletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByFailedAt$(
        DateTime failedAt,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQueueMessageFailedAt,
        value: failedAt,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByFailedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByErrorMessage$(
        String errorMessage,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQueueMessageErrorMessage,
        value: errorMessage,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByErrorMessage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQueueMessageCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<QueueMessage>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<QueueMessage>? modelFilter,
        List<QueueMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQueueMessageUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: QueueMessageEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    QueueMessage queueMessage, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (queueMessage.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            queueMessage.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            queueMessage.org = org;
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
QueueMessage recursiveUpsert(QueueMessage queueMessage, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'QueueMessage'} 
        : const {};
    if (queueMessage.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        queueMessage.org = OrganizationStore.instance.recursiveUpsert(queueMessage.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(queueMessage);
}

  List<QueueMessage> recursiveListUpsert(List<QueueMessage> queueMessages, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedQueueMessages = <QueueMessage>[];
    for (var queueMessage in queueMessages) {
        updatedQueueMessages.add(recursiveUpsert(queueMessage, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedQueueMessages;
}

//   @override
//   QueueMessage upsert(QueueMessage item) {
//     return recursiveUpsert(item);
//   }

}


class QueueMessageInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      QueueMessageInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (queueMessage) => QueueMessageStore.instance
            .getOrg$(queueMessage, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (queueMessage) => QueueMessageStore.instance
            .getOrg(queueMessage, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum QueueMessageEndpoints implements Endpoint {

    getAll('/queueMessage', HttpMethod.post, List<QueueMessage>),
	getById('/queueMessage/byId/:id', HttpMethod.post, QueueMessage),
	getManyByOrgId('/queueMessage/byOrgId/:orgId', HttpMethod.post, List<QueueMessage>),
	getByMessageId('/queueMessage/byMessageId/:messageId', HttpMethod.post, QueueMessage),
	getManyByQueueName('/queueMessage/byQueueName/:queueName', HttpMethod.post, List<QueueMessage>),
	getManyByExchangeName('/queueMessage/byExchangeName/:exchangeName', HttpMethod.post, List<QueueMessage>),
	getManyByRoutingKey('/queueMessage/byRoutingKey/:routingKey', HttpMethod.post, List<QueueMessage>),
	getManyByMessageType('/queueMessage/byMessageType/:messageType', HttpMethod.post, List<QueueMessage>),
	getManyByPayload('/queueMessage/byPayload/:payload', HttpMethod.post, List<QueueMessage>),
	getManyByStatus('/queueMessage/byStatus/:status', HttpMethod.post, List<QueueMessage>),
	getManyByPriority('/queueMessage/byPriority/:priority', HttpMethod.post, List<QueueMessage>),
	getManyByRetryCount('/queueMessage/byRetryCount/:retryCount', HttpMethod.post, List<QueueMessage>),
	getManyByMaxRetries('/queueMessage/byMaxRetries/:maxRetries', HttpMethod.post, List<QueueMessage>),
	getManyByNextRetryAt('/queueMessage/byNextRetryAt/:nextRetryAt', HttpMethod.post, List<QueueMessage>),
	getManyByProcessedAt('/queueMessage/byProcessedAt/:processedAt', HttpMethod.post, List<QueueMessage>),
	getManyByCompletedAt('/queueMessage/byCompletedAt/:completedAt', HttpMethod.post, List<QueueMessage>),
	getManyByFailedAt('/queueMessage/byFailedAt/:failedAt', HttpMethod.post, List<QueueMessage>),
	getManyByErrorMessage('/queueMessage/byErrorMessage/:errorMessage', HttpMethod.post, List<QueueMessage>),
	getManyByCreatedAt('/queueMessage/byCreatedAt/:createdAt', HttpMethod.post, List<QueueMessage>),
	getManyByUpdatedAt('/queueMessage/byUpdatedAt/:updatedAt', HttpMethod.post, List<QueueMessage>);

    const QueueMessageEndpoints(this.path, this.method, this.responseType);

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
