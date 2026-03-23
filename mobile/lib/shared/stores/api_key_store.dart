
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ApiKeyStore extends ModelStreamStore<String, ApiKey> {

  static ApiKeyStore? _instance;

  static ApiKeyStore get instance {
    _instance ??= ApiKeyStore();
    return _instance!;
  }

  ApiKeyStore() : super(ApiKey.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ApiKeyStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ApiKeyStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ApiKeyStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getApiKeyId(ApiKey apiKey) => apiKey.id;

	String? getApiKeyUserId(ApiKey apiKey) => apiKey.userId;

	String? getApiKeyOrgId(ApiKey apiKey) => apiKey.orgId;

	String? getApiKeyName(ApiKey apiKey) => apiKey.name;

	String? getApiKeyKeyHash(ApiKey apiKey) => apiKey.keyHash;

	List<String>? getApiKeyScopes(ApiKey apiKey) => apiKey.scopes;

	DateTime? getApiKeyLastUsedAt(ApiKey apiKey) => apiKey.lastUsedAt;

	DateTime? getApiKeyExpiresAt(ApiKey apiKey) => apiKey.expiresAt;

	DateTime? getApiKeyCreatedAt(ApiKey apiKey) => apiKey.createdAt;

	DateTime? getApiKeyUpdatedAt(ApiKey apiKey) => apiKey.updatedAt;

	DateTime? getApiKeyDeletedAt(ApiKey apiKey) => apiKey.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
ApiKey? getByKeyHash(
    String keyHash,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getIncluding(getApiKeyKeyHash, keyHash, modelFilter: modelFilter, includes: includes);

  
List<ApiKey> getByUserId(
    String userId,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<ApiKey> getByOrgId(
    String orgId,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ApiKey> getByName(
    String name,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyName, name, modelFilter: modelFilter, includes: includes);

	
List<ApiKey> getByScopes(
    String scopes,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyScopes, scopes, modelFilter: modelFilter, includes: includes);

	
List<ApiKey> getByLastUsedAt(
    DateTime lastUsedAt,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyLastUsedAt, lastUsedAt, modelFilter: modelFilter, includes: includes);

	
List<ApiKey> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<ApiKey> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ApiKey> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ApiKey> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}
    ) =>
    getManyIncluding(getApiKeyDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    ApiKey apiKey, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (apiKey.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(apiKey.orgId!, includes: includes);
        apiKey.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    ApiKey apiKey, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (apiKey.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(apiKey.userId!, includes: includes);
        apiKey.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ApiKey>> getAll$({bool useCache = true, ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ApiKeyEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ApiKey?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getApiKeyId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<ApiKey?> getByKeyHash$(
        String keyHash,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getApiKeyKeyHash,
        value: keyHash,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getByKeyHash,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ApiKey>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiKeyUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiKey>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiKeyOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiKey>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiKeyName,
        value: name,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiKey>> getByScopes$(
        String scopes,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiKeyScopes,
        value: scopes,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByScopes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiKey>> getByLastUsedAt$(
        DateTime lastUsedAt,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiKeyLastUsedAt,
        value: lastUsedAt,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByLastUsedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiKey>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiKeyExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiKey>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiKeyCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiKey>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiKeyUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiKey>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ApiKey>? modelFilter,
        List<ApiKeyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiKeyDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ApiKeyEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    ApiKey apiKey, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (apiKey.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            apiKey.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            apiKey.org = org;
        });
    }
}

	Stream<User?> getUser$(
    ApiKey apiKey, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (apiKey.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            apiKey.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            apiKey.user = user;
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
ApiKey recursiveUpsert(ApiKey apiKey, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ApiKey'} 
        : const {};
    if (apiKey.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        apiKey.org = OrganizationStore.instance.recursiveUpsert(apiKey.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (apiKey.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        apiKey.user = UserStore.instance.recursiveUpsert(apiKey.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(apiKey);
}

  List<ApiKey> recursiveListUpsert(List<ApiKey> apiKeys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedApiKeys = <ApiKey>[];
    for (var apiKey in apiKeys) {
        updatedApiKeys.add(recursiveUpsert(apiKey, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedApiKeys;
}

//   @override
//   ApiKey upsert(ApiKey item) {
//     return recursiveUpsert(item);
//   }

}


class ApiKeyInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ApiKeyInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (apiKey) => ApiKeyStore.instance
            .getOrg$(apiKey, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (apiKey) => ApiKeyStore.instance
            .getOrg(apiKey, modelFilter: modelFilter, includes: includes);
      }
}

	ApiKeyInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (apiKey) => ApiKeyStore.instance
            .getUser$(apiKey, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (apiKey) => ApiKeyStore.instance
            .getUser(apiKey, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ApiKeyEndpoints implements Endpoint {

    getAll('/apiKey', HttpMethod.post, List<ApiKey>),
	getById('/apiKey/byId/:id', HttpMethod.post, ApiKey),
	getManyByUserId('/apiKey/byUserId/:userId', HttpMethod.post, List<ApiKey>),
	getManyByOrgId('/apiKey/byOrgId/:orgId', HttpMethod.post, List<ApiKey>),
	getManyByName('/apiKey/byName/:name', HttpMethod.post, List<ApiKey>),
	getByKeyHash('/apiKey/byKeyHash/:keyHash', HttpMethod.post, ApiKey),
	getManyByScopes('/apiKey/byScopes/:scopes', HttpMethod.post, List<ApiKey>),
	getManyByLastUsedAt('/apiKey/byLastUsedAt/:lastUsedAt', HttpMethod.post, List<ApiKey>),
	getManyByExpiresAt('/apiKey/byExpiresAt/:expiresAt', HttpMethod.post, List<ApiKey>),
	getManyByCreatedAt('/apiKey/byCreatedAt/:createdAt', HttpMethod.post, List<ApiKey>),
	getManyByUpdatedAt('/apiKey/byUpdatedAt/:updatedAt', HttpMethod.post, List<ApiKey>),
	getManyByDeletedAt('/apiKey/byDeletedAt/:deletedAt', HttpMethod.post, List<ApiKey>);

    const ApiKeyEndpoints(this.path, this.method, this.responseType);

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
