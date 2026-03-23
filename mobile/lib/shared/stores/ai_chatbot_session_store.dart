
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIChatbotSessionStore extends ModelStreamStore<String, AIChatbotSession> {

  static AIChatbotSessionStore? _instance;

  static AIChatbotSessionStore get instance {
    _instance ??= AIChatbotSessionStore();
    return _instance!;
  }

  AIChatbotSessionStore() : super(AIChatbotSession.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIChatbotSessionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIChatbotSessionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIChatbotSessionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIChatbotSessionId(AIChatbotSession aIChatbotSession) => aIChatbotSession.id;

	String? getAIChatbotSessionOrgId(AIChatbotSession aIChatbotSession) => aIChatbotSession.orgId;

	String? getAIChatbotSessionUserId(AIChatbotSession aIChatbotSession) => aIChatbotSession.userId;

	String? getAIChatbotSessionContactId(AIChatbotSession aIChatbotSession) => aIChatbotSession.contactId;

	String? getAIChatbotSessionSessionId(AIChatbotSession aIChatbotSession) => aIChatbotSession.sessionId;

	dynamic? getAIChatbotSessionConversationHistory(AIChatbotSession aIChatbotSession) => aIChatbotSession.conversationHistory;

	String? getAIChatbotSessionIntent(AIChatbotSession aIChatbotSession) => aIChatbotSession.intent;

	double? getAIChatbotSessionConfidence(AIChatbotSession aIChatbotSession) => aIChatbotSession.confidence;

	String? getAIChatbotSessionStatus(AIChatbotSession aIChatbotSession) => aIChatbotSession.status;

	String? getAIChatbotSessionTransferredTo(AIChatbotSession aIChatbotSession) => aIChatbotSession.transferredTo;

	DateTime? getAIChatbotSessionStartedAt(AIChatbotSession aIChatbotSession) => aIChatbotSession.startedAt;

	DateTime? getAIChatbotSessionLastActivityAt(AIChatbotSession aIChatbotSession) => aIChatbotSession.lastActivityAt;

	DateTime? getAIChatbotSessionEndedAt(AIChatbotSession aIChatbotSession) => aIChatbotSession.endedAt;

	int? getAIChatbotSessionSatisfaction(AIChatbotSession aIChatbotSession) => aIChatbotSession.satisfaction;

	DateTime? getAIChatbotSessionCreatedAt(AIChatbotSession aIChatbotSession) => aIChatbotSession.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
AIChatbotSession? getBySessionId(
    String sessionId,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getIncluding(getAIChatbotSessionSessionId, sessionId, modelFilter: modelFilter, includes: includes);

  
List<AIChatbotSession> getByOrgId(
    String orgId,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByUserId(
    String userId,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByContactId(
    String contactId,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByConversationHistory(
    dynamic conversationHistory,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionConversationHistory, conversationHistory, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByIntent(
    String intent,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionIntent, intent, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByConfidence(
    double confidence,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByStatus(
    String status,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByTransferredTo(
    String transferredTo,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionTransferredTo, transferredTo, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByStartedAt(
    DateTime startedAt,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionStartedAt, startedAt, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByLastActivityAt(
    DateTime lastActivityAt,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionLastActivityAt, lastActivityAt, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByEndedAt(
    DateTime endedAt,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionEndedAt, endedAt, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getBySatisfaction(
    int satisfaction,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionSatisfaction, satisfaction, modelFilter: modelFilter, includes: includes);

	
List<AIChatbotSession> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}
    ) =>
    getManyIncluding(getAIChatbotSessionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIChatbotSession aIChatbotSession, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIChatbotSession.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIChatbotSession.orgId!, includes: includes);
        aIChatbotSession.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<AIChatMessage> getMessages(
    AIChatbotSession aIChatbotSession, {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    final messages = AIChatMessageStore.instance.getBySessionId(aIChatbotSession.$uid!, modelFilter: modelFilter, includes: includes);
    aIChatbotSession.messages = messages;
    // setIncludedReferencesForList(messages, includes: includes);
    return messages;
}

	List<AIChatHandoff> getHandoffs(
    AIChatbotSession aIChatbotSession, {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}) {
    final handoffs = AIChatHandoffStore.instance.getBySessionId(aIChatbotSession.$uid!, modelFilter: modelFilter, includes: includes);
    aIChatbotSession.handoffs = handoffs;
    // setIncludedReferencesForList(handoffs, includes: includes);
    return handoffs;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIChatbotSession>> getAll$({bool useCache = true, ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIChatbotSessionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIChatbotSession?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIChatbotSessionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<AIChatbotSession?> getBySessionId$(
        String sessionId,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIChatbotSessionSessionId,
        value: sessionId,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getBySessionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIChatbotSession>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatbotSessionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatbotSessionUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatbotSessionContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByConversationHistory$(
        dynamic conversationHistory,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIChatbotSessionConversationHistory,
        value: conversationHistory,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByConversationHistory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByIntent$(
        String intent,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatbotSessionIntent,
        value: intent,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByIntent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIChatbotSessionConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatbotSessionStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByTransferredTo$(
        String transferredTo,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatbotSessionTransferredTo,
        value: transferredTo,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByTransferredTo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByStartedAt$(
        DateTime startedAt,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIChatbotSessionStartedAt,
        value: startedAt,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByStartedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByLastActivityAt$(
        DateTime lastActivityAt,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIChatbotSessionLastActivityAt,
        value: lastActivityAt,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByLastActivityAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByEndedAt$(
        DateTime endedAt,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIChatbotSessionEndedAt,
        value: endedAt,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByEndedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getBySatisfaction$(
        int satisfaction,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAIChatbotSessionSatisfaction,
        value: satisfaction,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyBySatisfaction,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatbotSession>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIChatbotSession>? modelFilter,
        List<AIChatbotSessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIChatbotSessionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIChatbotSessionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIChatbotSession aIChatbotSession, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIChatbotSession.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIChatbotSession.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIChatbotSession.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AIChatMessage>> getMessages$(
    AIChatbotSession aIChatbotSession, {bool useCache = true, ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    return AIChatMessageStore.instance.getBySessionId$(
        aIChatbotSession.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((messages) {
        aIChatbotSession.messages = messages;
    });

}

	Stream<List<AIChatHandoff>> getHandoffs$(
    AIChatbotSession aIChatbotSession, {bool useCache = true, ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}) {
    return AIChatHandoffStore.instance.getBySessionId$(
        aIChatbotSession.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((handoffs) {
        aIChatbotSession.handoffs = handoffs;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AIChatbotSession recursiveUpsert(AIChatbotSession aIChatbotSession, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIChatbotSession'} 
        : const {};
    if (aIChatbotSession.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIChatbotSession.org = OrganizationStore.instance.recursiveUpsert(aIChatbotSession.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIChatbotSession.messages != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatMessage'))) {
        aIChatbotSession.messages = AIChatMessageStore.instance.recursiveListUpsert(aIChatbotSession.messages!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIChatbotSession.handoffs != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatHandoff'))) {
        aIChatbotSession.handoffs = AIChatHandoffStore.instance.recursiveListUpsert(aIChatbotSession.handoffs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIChatbotSession);
}

  List<AIChatbotSession> recursiveListUpsert(List<AIChatbotSession> aIChatbotSessions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIChatbotSessions = <AIChatbotSession>[];
    for (var aIChatbotSession in aIChatbotSessions) {
        updatedAIChatbotSessions.add(recursiveUpsert(aIChatbotSession, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIChatbotSessions;
}

//   @override
//   AIChatbotSession upsert(AIChatbotSession item) {
//     return recursiveUpsert(item);
//   }

}


class AIChatbotSessionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIChatbotSessionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatbotSession) => AIChatbotSessionStore.instance
            .getOrg$(aIChatbotSession, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatbotSession) => AIChatbotSessionStore.instance
            .getOrg(aIChatbotSession, modelFilter: modelFilter, includes: includes);
      }
}

	AIChatbotSessionInclude.messages({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatMessage>? modelFilter,
    List<AIChatMessageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatbotSession) => AIChatbotSessionStore.instance
            .getMessages$(aIChatbotSession, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatbotSession) => AIChatbotSessionStore.instance
            .getMessages(aIChatbotSession, modelFilter: modelFilter, includes: includes);
      }
}

	AIChatbotSessionInclude.handoffs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatHandoff>? modelFilter,
    List<AIChatHandoffInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatbotSession) => AIChatbotSessionStore.instance
            .getHandoffs$(aIChatbotSession, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatbotSession) => AIChatbotSessionStore.instance
            .getHandoffs(aIChatbotSession, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIChatbotSessionEndpoints implements Endpoint {

    getAll('/aIChatbotSession', HttpMethod.post, List<AIChatbotSession>),
	getById('/aIChatbotSession/byId/:id', HttpMethod.post, AIChatbotSession),
	getManyByOrgId('/aIChatbotSession/byOrgId/:orgId', HttpMethod.post, List<AIChatbotSession>),
	getManyByUserId('/aIChatbotSession/byUserId/:userId', HttpMethod.post, List<AIChatbotSession>),
	getManyByContactId('/aIChatbotSession/byContactId/:contactId', HttpMethod.post, List<AIChatbotSession>),
	getBySessionId('/aIChatbotSession/bySessionId/:sessionId', HttpMethod.post, AIChatbotSession),
	getManyByConversationHistory('/aIChatbotSession/byConversationHistory/:conversationHistory', HttpMethod.post, List<AIChatbotSession>),
	getManyByIntent('/aIChatbotSession/byIntent/:intent', HttpMethod.post, List<AIChatbotSession>),
	getManyByConfidence('/aIChatbotSession/byConfidence/:confidence', HttpMethod.post, List<AIChatbotSession>),
	getManyByStatus('/aIChatbotSession/byStatus/:status', HttpMethod.post, List<AIChatbotSession>),
	getManyByTransferredTo('/aIChatbotSession/byTransferredTo/:transferredTo', HttpMethod.post, List<AIChatbotSession>),
	getManyByStartedAt('/aIChatbotSession/byStartedAt/:startedAt', HttpMethod.post, List<AIChatbotSession>),
	getManyByLastActivityAt('/aIChatbotSession/byLastActivityAt/:lastActivityAt', HttpMethod.post, List<AIChatbotSession>),
	getManyByEndedAt('/aIChatbotSession/byEndedAt/:endedAt', HttpMethod.post, List<AIChatbotSession>),
	getManyBySatisfaction('/aIChatbotSession/bySatisfaction/:satisfaction', HttpMethod.post, List<AIChatbotSession>),
	getManyByCreatedAt('/aIChatbotSession/byCreatedAt/:createdAt', HttpMethod.post, List<AIChatbotSession>);

    const AIChatbotSessionEndpoints(this.path, this.method, this.responseType);

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
