
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class UserActivityLogStore extends ModelStreamStore<String, UserActivityLog> {

  static UserActivityLogStore? _instance;

  static UserActivityLogStore get instance {
    _instance ??= UserActivityLogStore();
    return _instance!;
  }

  UserActivityLogStore() : super(UserActivityLog.fromJson) {
    if (_instance != null) {
        throw Exception(
            'UserActivityLogStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending UserActivityLogStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use UserActivityLogStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getUserActivityLogId(UserActivityLog userActivityLog) => userActivityLog.id;

	String? getUserActivityLogUserId(UserActivityLog userActivityLog) => userActivityLog.userId;

	String? getUserActivityLogOrgId(UserActivityLog userActivityLog) => userActivityLog.orgId;

	String? getUserActivityLogAction(UserActivityLog userActivityLog) => userActivityLog.action;

	String? getUserActivityLogEntityType(UserActivityLog userActivityLog) => userActivityLog.entityType;

	String? getUserActivityLogEntityId(UserActivityLog userActivityLog) => userActivityLog.entityId;

	dynamic? getUserActivityLogMetadata(UserActivityLog userActivityLog) => userActivityLog.metadata;

	String? getUserActivityLogIpAddress(UserActivityLog userActivityLog) => userActivityLog.ipAddress;

	String? getUserActivityLogUserAgent(UserActivityLog userActivityLog) => userActivityLog.userAgent;

	DateTime? getUserActivityLogCreatedAt(UserActivityLog userActivityLog) => userActivityLog.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<UserActivityLog> getByUserId(
    String userId,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<UserActivityLog> getByOrgId(
    String orgId,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<UserActivityLog> getByAction(
    String action,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogAction, action, modelFilter: modelFilter, includes: includes);

	
List<UserActivityLog> getByEntityType(
    String entityType,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogEntityType, entityType, modelFilter: modelFilter, includes: includes);

	
List<UserActivityLog> getByEntityId(
    String entityId,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogEntityId, entityId, modelFilter: modelFilter, includes: includes);

	
List<UserActivityLog> getByMetadata(
    dynamic metadata,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogMetadata, metadata, modelFilter: modelFilter, includes: includes);

	
List<UserActivityLog> getByIpAddress(
    String ipAddress,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogIpAddress, ipAddress, modelFilter: modelFilter, includes: includes);

	
List<UserActivityLog> getByUserAgent(
    String userAgent,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogUserAgent, userAgent, modelFilter: modelFilter, includes: includes);

	
List<UserActivityLog> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}
    ) =>
    getManyIncluding(getUserActivityLogCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    UserActivityLog userActivityLog, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (userActivityLog.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(userActivityLog.orgId!, includes: includes);
        userActivityLog.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    UserActivityLog userActivityLog, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (userActivityLog.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(userActivityLog.userId!, includes: includes);
        userActivityLog.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<UserActivityLog>> getAll$({bool useCache = true, ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: UserActivityLogEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<UserActivityLog?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getUserActivityLogId,
        value: id,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<UserActivityLog>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserActivityLogUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserActivityLog>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserActivityLogOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserActivityLog>> getByAction$(
        String action,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserActivityLogAction,
        value: action,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByAction,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserActivityLog>> getByEntityType$(
        String entityType,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserActivityLogEntityType,
        value: entityType,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByEntityType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserActivityLog>> getByEntityId$(
        String entityId,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserActivityLogEntityId,
        value: entityId,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByEntityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserActivityLog>> getByMetadata$(
        dynamic metadata,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getUserActivityLogMetadata,
        value: metadata,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserActivityLog>> getByIpAddress$(
        String ipAddress,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserActivityLogIpAddress,
        value: ipAddress,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByIpAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserActivityLog>> getByUserAgent$(
        String userAgent,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserActivityLogUserAgent,
        value: userAgent,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByUserAgent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserActivityLog>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<UserActivityLog>? modelFilter,
        List<UserActivityLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserActivityLogCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: UserActivityLogEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    UserActivityLog userActivityLog, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (userActivityLog.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            userActivityLog.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            userActivityLog.org = org;
        });
    }
}

	Stream<User?> getUser$(
    UserActivityLog userActivityLog, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (userActivityLog.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            userActivityLog.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            userActivityLog.user = user;
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
UserActivityLog recursiveUpsert(UserActivityLog userActivityLog, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'UserActivityLog'} 
        : const {};
    if (userActivityLog.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        userActivityLog.org = OrganizationStore.instance.recursiveUpsert(userActivityLog.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (userActivityLog.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        userActivityLog.user = UserStore.instance.recursiveUpsert(userActivityLog.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(userActivityLog);
}

  List<UserActivityLog> recursiveListUpsert(List<UserActivityLog> userActivityLogs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedUserActivityLogs = <UserActivityLog>[];
    for (var userActivityLog in userActivityLogs) {
        updatedUserActivityLogs.add(recursiveUpsert(userActivityLog, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedUserActivityLogs;
}

//   @override
//   UserActivityLog upsert(UserActivityLog item) {
//     return recursiveUpsert(item);
//   }

}


class UserActivityLogInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      UserActivityLogInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (userActivityLog) => UserActivityLogStore.instance
            .getOrg$(userActivityLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (userActivityLog) => UserActivityLogStore.instance
            .getOrg(userActivityLog, modelFilter: modelFilter, includes: includes);
      }
}

	UserActivityLogInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (userActivityLog) => UserActivityLogStore.instance
            .getUser$(userActivityLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (userActivityLog) => UserActivityLogStore.instance
            .getUser(userActivityLog, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum UserActivityLogEndpoints implements Endpoint {

    getAll('/userActivityLog', HttpMethod.post, List<UserActivityLog>),
	getById('/userActivityLog/byId/:id', HttpMethod.post, UserActivityLog),
	getManyByUserId('/userActivityLog/byUserId/:userId', HttpMethod.post, List<UserActivityLog>),
	getManyByOrgId('/userActivityLog/byOrgId/:orgId', HttpMethod.post, List<UserActivityLog>),
	getManyByAction('/userActivityLog/byAction/:action', HttpMethod.post, List<UserActivityLog>),
	getManyByEntityType('/userActivityLog/byEntityType/:entityType', HttpMethod.post, List<UserActivityLog>),
	getManyByEntityId('/userActivityLog/byEntityId/:entityId', HttpMethod.post, List<UserActivityLog>),
	getManyByMetadata('/userActivityLog/byMetadata/:metadata', HttpMethod.post, List<UserActivityLog>),
	getManyByIpAddress('/userActivityLog/byIpAddress/:ipAddress', HttpMethod.post, List<UserActivityLog>),
	getManyByUserAgent('/userActivityLog/byUserAgent/:userAgent', HttpMethod.post, List<UserActivityLog>),
	getManyByCreatedAt('/userActivityLog/byCreatedAt/:createdAt', HttpMethod.post, List<UserActivityLog>);

    const UserActivityLogEndpoints(this.path, this.method, this.responseType);

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
