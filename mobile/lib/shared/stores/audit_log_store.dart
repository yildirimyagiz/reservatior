
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AuditLogStore extends ModelStreamStore<String, AuditLog> {

  static AuditLogStore? _instance;

  static AuditLogStore get instance {
    _instance ??= AuditLogStore();
    return _instance!;
  }

  AuditLogStore() : super(AuditLog.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AuditLogStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AuditLogStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AuditLogStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAuditLogId(AuditLog auditLog) => auditLog.id;

	String? getAuditLogOrgId(AuditLog auditLog) => auditLog.orgId;

	String? getAuditLogUserId(AuditLog auditLog) => auditLog.userId;

	String? getAuditLogAction(AuditLog auditLog) => auditLog.action;

	String? getAuditLogEntityType(AuditLog auditLog) => auditLog.entityType;

	String? getAuditLogEntityId(AuditLog auditLog) => auditLog.entityId;

	dynamic? getAuditLogOldValues(AuditLog auditLog) => auditLog.oldValues;

	dynamic? getAuditLogNewValues(AuditLog auditLog) => auditLog.newValues;

	dynamic? getAuditLogChanges(AuditLog auditLog) => auditLog.changes;

	String? getAuditLogIpAddress(AuditLog auditLog) => auditLog.ipAddress;

	String? getAuditLogUserAgent(AuditLog auditLog) => auditLog.userAgent;

	String? getAuditLogSessionId(AuditLog auditLog) => auditLog.sessionId;

	DateTime? getAuditLogCreatedAt(AuditLog auditLog) => auditLog.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AuditLog> getByOrgId(
    String orgId,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByUserId(
    String userId,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByAction(
    String action,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogAction, action, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByEntityType(
    String entityType,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogEntityType, entityType, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByEntityId(
    String entityId,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogEntityId, entityId, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByOldValues(
    dynamic oldValues,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogOldValues, oldValues, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByNewValues(
    dynamic newValues,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogNewValues, newValues, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByChanges(
    dynamic changes,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogChanges, changes, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByIpAddress(
    String ipAddress,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogIpAddress, ipAddress, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByUserAgent(
    String userAgent,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogUserAgent, userAgent, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getBySessionId(
    String sessionId,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogSessionId, sessionId, modelFilter: modelFilter, includes: includes);

	
List<AuditLog> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}
    ) =>
    getManyIncluding(getAuditLogCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AuditLog auditLog, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (auditLog.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(auditLog.orgId!, includes: includes);
        auditLog.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    AuditLog auditLog, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (auditLog.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(auditLog.userId!, includes: includes);
        auditLog.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AuditLog>> getAll$({bool useCache = true, ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AuditLogEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AuditLog?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAuditLogId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AuditLog>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAuditLogOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAuditLogUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByAction$(
        String action,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAuditLogAction,
        value: action,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByAction,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByEntityType$(
        String entityType,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAuditLogEntityType,
        value: entityType,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByEntityType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByEntityId$(
        String entityId,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAuditLogEntityId,
        value: entityId,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByEntityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByOldValues$(
        dynamic oldValues,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAuditLogOldValues,
        value: oldValues,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByOldValues,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByNewValues$(
        dynamic newValues,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAuditLogNewValues,
        value: newValues,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByNewValues,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByChanges$(
        dynamic changes,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAuditLogChanges,
        value: changes,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByChanges,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByIpAddress$(
        String ipAddress,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAuditLogIpAddress,
        value: ipAddress,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByIpAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByUserAgent$(
        String userAgent,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAuditLogUserAgent,
        value: userAgent,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByUserAgent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getBySessionId$(
        String sessionId,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAuditLogSessionId,
        value: sessionId,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyBySessionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AuditLog>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AuditLog>? modelFilter,
        List<AuditLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAuditLogCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AuditLogEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AuditLog auditLog, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (auditLog.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            auditLog.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            auditLog.org = org;
        });
    }
}

	Stream<User?> getUser$(
    AuditLog auditLog, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (auditLog.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            auditLog.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            auditLog.user = user;
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
AuditLog recursiveUpsert(AuditLog auditLog, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AuditLog'} 
        : const {};
    if (auditLog.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        auditLog.org = OrganizationStore.instance.recursiveUpsert(auditLog.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (auditLog.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        auditLog.user = UserStore.instance.recursiveUpsert(auditLog.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(auditLog);
}

  List<AuditLog> recursiveListUpsert(List<AuditLog> auditLogs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAuditLogs = <AuditLog>[];
    for (var auditLog in auditLogs) {
        updatedAuditLogs.add(recursiveUpsert(auditLog, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAuditLogs;
}

//   @override
//   AuditLog upsert(AuditLog item) {
//     return recursiveUpsert(item);
//   }

}


class AuditLogInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AuditLogInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (auditLog) => AuditLogStore.instance
            .getOrg$(auditLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (auditLog) => AuditLogStore.instance
            .getOrg(auditLog, modelFilter: modelFilter, includes: includes);
      }
}

	AuditLogInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (auditLog) => AuditLogStore.instance
            .getUser$(auditLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (auditLog) => AuditLogStore.instance
            .getUser(auditLog, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AuditLogEndpoints implements Endpoint {

    getAll('/auditLog', HttpMethod.post, List<AuditLog>),
	getById('/auditLog/byId/:id', HttpMethod.post, AuditLog),
	getManyByOrgId('/auditLog/byOrgId/:orgId', HttpMethod.post, List<AuditLog>),
	getManyByUserId('/auditLog/byUserId/:userId', HttpMethod.post, List<AuditLog>),
	getManyByAction('/auditLog/byAction/:action', HttpMethod.post, List<AuditLog>),
	getManyByEntityType('/auditLog/byEntityType/:entityType', HttpMethod.post, List<AuditLog>),
	getManyByEntityId('/auditLog/byEntityId/:entityId', HttpMethod.post, List<AuditLog>),
	getManyByOldValues('/auditLog/byOldValues/:oldValues', HttpMethod.post, List<AuditLog>),
	getManyByNewValues('/auditLog/byNewValues/:newValues', HttpMethod.post, List<AuditLog>),
	getManyByChanges('/auditLog/byChanges/:changes', HttpMethod.post, List<AuditLog>),
	getManyByIpAddress('/auditLog/byIpAddress/:ipAddress', HttpMethod.post, List<AuditLog>),
	getManyByUserAgent('/auditLog/byUserAgent/:userAgent', HttpMethod.post, List<AuditLog>),
	getManyBySessionId('/auditLog/bySessionId/:sessionId', HttpMethod.post, List<AuditLog>),
	getManyByCreatedAt('/auditLog/byCreatedAt/:createdAt', HttpMethod.post, List<AuditLog>);

    const AuditLogEndpoints(this.path, this.method, this.responseType);

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
