
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ApiTokenStore extends ModelStreamStore<String, ApiToken> {

  static ApiTokenStore? _instance;

  static ApiTokenStore get instance {
    _instance ??= ApiTokenStore();
    return _instance!;
  }

  ApiTokenStore() : super(ApiToken.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ApiTokenStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ApiTokenStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ApiTokenStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getApiTokenId(ApiToken apiToken) => apiToken.id;

	String? getApiTokenUserId(ApiToken apiToken) => apiToken.userId;

	String? getApiTokenName(ApiToken apiToken) => apiToken.name;

	String? getApiTokenTokenHash(ApiToken apiToken) => apiToken.tokenHash;

	List<String>? getApiTokenScopes(ApiToken apiToken) => apiToken.scopes;

	DateTime? getApiTokenLastUsedAt(ApiToken apiToken) => apiToken.lastUsedAt;

	DateTime? getApiTokenCreatedAt(ApiToken apiToken) => apiToken.createdAt;

	DateTime? getApiTokenUpdatedAt(ApiToken apiToken) => apiToken.updatedAt;

	DateTime? getApiTokenDeletedAt(ApiToken apiToken) => apiToken.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
ApiToken? getByTokenHash(
    String tokenHash,
    {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}
    ) =>
    getIncluding(getApiTokenTokenHash, tokenHash, modelFilter: modelFilter, includes: includes);

  
List<ApiToken> getByUserId(
    String userId,
    {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}
    ) =>
    getManyIncluding(getApiTokenUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<ApiToken> getByName(
    String name,
    {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}
    ) =>
    getManyIncluding(getApiTokenName, name, modelFilter: modelFilter, includes: includes);

	
List<ApiToken> getByScopes(
    String scopes,
    {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}
    ) =>
    getManyIncluding(getApiTokenScopes, scopes, modelFilter: modelFilter, includes: includes);

	
List<ApiToken> getByLastUsedAt(
    DateTime lastUsedAt,
    {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}
    ) =>
    getManyIncluding(getApiTokenLastUsedAt, lastUsedAt, modelFilter: modelFilter, includes: includes);

	
List<ApiToken> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}
    ) =>
    getManyIncluding(getApiTokenCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ApiToken> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}
    ) =>
    getManyIncluding(getApiTokenUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ApiToken> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}
    ) =>
    getManyIncluding(getApiTokenDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getUser(
    ApiToken apiToken, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (apiToken.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(apiToken.userId!, includes: includes);
        apiToken.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ApiToken>> getAll$({bool useCache = true, ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ApiTokenEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ApiToken?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getApiTokenId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<ApiToken?> getByTokenHash$(
        String tokenHash,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getApiTokenTokenHash,
        value: tokenHash,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getByTokenHash,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ApiToken>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiTokenUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiToken>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiTokenName,
        value: name,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiToken>> getByScopes$(
        String scopes,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiTokenScopes,
        value: scopes,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getManyByScopes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiToken>> getByLastUsedAt$(
        DateTime lastUsedAt,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiTokenLastUsedAt,
        value: lastUsedAt,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getManyByLastUsedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiToken>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiTokenCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiToken>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiTokenUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiToken>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ApiToken>? modelFilter,
        List<ApiTokenInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiTokenDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ApiTokenEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getUser$(
    ApiToken apiToken, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (apiToken.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            apiToken.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            apiToken.user = user;
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
ApiToken recursiveUpsert(ApiToken apiToken, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ApiToken'} 
        : const {};
    if (apiToken.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        apiToken.user = UserStore.instance.recursiveUpsert(apiToken.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(apiToken);
}

  List<ApiToken> recursiveListUpsert(List<ApiToken> apiTokens, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedApiTokens = <ApiToken>[];
    for (var apiToken in apiTokens) {
        updatedApiTokens.add(recursiveUpsert(apiToken, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedApiTokens;
}

//   @override
//   ApiToken upsert(ApiToken item) {
//     return recursiveUpsert(item);
//   }

}


class ApiTokenInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ApiTokenInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (apiToken) => ApiTokenStore.instance
            .getUser$(apiToken, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (apiToken) => ApiTokenStore.instance
            .getUser(apiToken, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ApiTokenEndpoints implements Endpoint {

    getAll('/apiToken', HttpMethod.post, List<ApiToken>),
	getById('/apiToken/byId/:id', HttpMethod.post, ApiToken),
	getManyByUserId('/apiToken/byUserId/:userId', HttpMethod.post, List<ApiToken>),
	getManyByName('/apiToken/byName/:name', HttpMethod.post, List<ApiToken>),
	getByTokenHash('/apiToken/byTokenHash/:tokenHash', HttpMethod.post, ApiToken),
	getManyByScopes('/apiToken/byScopes/:scopes', HttpMethod.post, List<ApiToken>),
	getManyByLastUsedAt('/apiToken/byLastUsedAt/:lastUsedAt', HttpMethod.post, List<ApiToken>),
	getManyByCreatedAt('/apiToken/byCreatedAt/:createdAt', HttpMethod.post, List<ApiToken>),
	getManyByUpdatedAt('/apiToken/byUpdatedAt/:updatedAt', HttpMethod.post, List<ApiToken>),
	getManyByDeletedAt('/apiToken/byDeletedAt/:deletedAt', HttpMethod.post, List<ApiToken>);

    const ApiTokenEndpoints(this.path, this.method, this.responseType);

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
