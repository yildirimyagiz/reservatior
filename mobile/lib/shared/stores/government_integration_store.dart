
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class GovernmentIntegrationStore extends ModelStreamStore<String, GovernmentIntegration> {

  static GovernmentIntegrationStore? _instance;

  static GovernmentIntegrationStore get instance {
    _instance ??= GovernmentIntegrationStore();
    return _instance!;
  }

  GovernmentIntegrationStore() : super(GovernmentIntegration.fromJson) {
    if (_instance != null) {
        throw Exception(
            'GovernmentIntegrationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending GovernmentIntegrationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use GovernmentIntegrationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getGovernmentIntegrationId(GovernmentIntegration governmentIntegration) => governmentIntegration.id;

	String? getGovernmentIntegrationOrgId(GovernmentIntegration governmentIntegration) => governmentIntegration.orgId;

	String? getGovernmentIntegrationUserId(GovernmentIntegration governmentIntegration) => governmentIntegration.userId;

	Region? getGovernmentIntegrationRegion(GovernmentIntegration governmentIntegration) => governmentIntegration.region;

	String? getGovernmentIntegrationName(GovernmentIntegration governmentIntegration) => governmentIntegration.name;

	String? getGovernmentIntegrationBaseUrl(GovernmentIntegration governmentIntegration) => governmentIntegration.baseUrl;

	bool? getGovernmentIntegrationIsEnabled(GovernmentIntegration governmentIntegration) => governmentIntegration.isEnabled;

	String? getGovernmentIntegrationApiKeyCiphertext(GovernmentIntegration governmentIntegration) => governmentIntegration.apiKeyCiphertext;

	String? getGovernmentIntegrationApiSecretCiphertext(GovernmentIntegration governmentIntegration) => governmentIntegration.apiSecretCiphertext;

	String? getGovernmentIntegrationTokenCiphertext(GovernmentIntegration governmentIntegration) => governmentIntegration.tokenCiphertext;

	List<String>? getGovernmentIntegrationScopes(GovernmentIntegration governmentIntegration) => governmentIntegration.scopes;

	DateTime? getGovernmentIntegrationLastSyncAt(GovernmentIntegration governmentIntegration) => governmentIntegration.lastSyncAt;

	SyncStatus? getGovernmentIntegrationStatus(GovernmentIntegration governmentIntegration) => governmentIntegration.status;

	String? getGovernmentIntegrationLastError(GovernmentIntegration governmentIntegration) => governmentIntegration.lastError;

	String? getGovernmentIntegrationCreatedBy(GovernmentIntegration governmentIntegration) => governmentIntegration.createdBy;

	DateTime? getGovernmentIntegrationCreatedAt(GovernmentIntegration governmentIntegration) => governmentIntegration.createdAt;

	DateTime? getGovernmentIntegrationUpdatedAt(GovernmentIntegration governmentIntegration) => governmentIntegration.updatedAt;

	DateTime? getGovernmentIntegrationDeletedAt(GovernmentIntegration governmentIntegration) => governmentIntegration.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<GovernmentIntegration> getByOrgId(
    String orgId,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByUserId(
    String userId,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByRegion(
    Region region,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationRegion, region, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByName(
    String name,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationName, name, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByBaseUrl(
    String baseUrl,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationBaseUrl, baseUrl, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByIsEnabled(
    bool isEnabled,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationIsEnabled, isEnabled, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByApiKeyCiphertext(
    String apiKeyCiphertext,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationApiKeyCiphertext, apiKeyCiphertext, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByApiSecretCiphertext(
    String apiSecretCiphertext,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationApiSecretCiphertext, apiSecretCiphertext, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByTokenCiphertext(
    String tokenCiphertext,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationTokenCiphertext, tokenCiphertext, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByScopes(
    String scopes,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationScopes, scopes, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByLastSyncAt(
    DateTime lastSyncAt,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationLastSyncAt, lastSyncAt, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByStatus(
    SyncStatus status,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationStatus, status, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByLastError(
    String lastError,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationLastError, lastError, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByCreatedBy(
    String createdBy,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<GovernmentIntegration> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getGovernmentIntegrationDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    GovernmentIntegration governmentIntegration, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (governmentIntegration.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(governmentIntegration.orgId!, includes: includes);
        governmentIntegration.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    GovernmentIntegration governmentIntegration, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (governmentIntegration.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(governmentIntegration.userId!, includes: includes);
        governmentIntegration.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<GovernmentIntegration>> getAll$({bool useCache = true, ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: GovernmentIntegrationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<GovernmentIntegration?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<GovernmentIntegration>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByRegion$(
        Region region,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<Region>(
        getPropVal: getGovernmentIntegrationRegion,
        value: region,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByRegion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationName,
        value: name,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByBaseUrl$(
        String baseUrl,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationBaseUrl,
        value: baseUrl,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByBaseUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByIsEnabled$(
        bool isEnabled,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getGovernmentIntegrationIsEnabled,
        value: isEnabled,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByIsEnabled,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByApiKeyCiphertext$(
        String apiKeyCiphertext,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationApiKeyCiphertext,
        value: apiKeyCiphertext,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByApiKeyCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByApiSecretCiphertext$(
        String apiSecretCiphertext,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationApiSecretCiphertext,
        value: apiSecretCiphertext,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByApiSecretCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByTokenCiphertext$(
        String tokenCiphertext,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationTokenCiphertext,
        value: tokenCiphertext,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByTokenCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByScopes$(
        String scopes,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationScopes,
        value: scopes,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByScopes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByLastSyncAt$(
        DateTime lastSyncAt,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGovernmentIntegrationLastSyncAt,
        value: lastSyncAt,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByLastSyncAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByStatus$(
        SyncStatus status,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<SyncStatus>(
        getPropVal: getGovernmentIntegrationStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByLastError$(
        String lastError,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationLastError,
        value: lastError,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByLastError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGovernmentIntegrationCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGovernmentIntegrationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGovernmentIntegrationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GovernmentIntegration>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<GovernmentIntegration>? modelFilter,
        List<GovernmentIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGovernmentIntegrationDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: GovernmentIntegrationEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    GovernmentIntegration governmentIntegration, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (governmentIntegration.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            governmentIntegration.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            governmentIntegration.org = org;
        });
    }
}

	Stream<User?> getUser$(
    GovernmentIntegration governmentIntegration, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (governmentIntegration.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            governmentIntegration.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            governmentIntegration.user = user;
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
GovernmentIntegration recursiveUpsert(GovernmentIntegration governmentIntegration, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'GovernmentIntegration'} 
        : const {};
    if (governmentIntegration.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        governmentIntegration.org = OrganizationStore.instance.recursiveUpsert(governmentIntegration.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (governmentIntegration.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        governmentIntegration.user = UserStore.instance.recursiveUpsert(governmentIntegration.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(governmentIntegration);
}

  List<GovernmentIntegration> recursiveListUpsert(List<GovernmentIntegration> governmentIntegrations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedGovernmentIntegrations = <GovernmentIntegration>[];
    for (var governmentIntegration in governmentIntegrations) {
        updatedGovernmentIntegrations.add(recursiveUpsert(governmentIntegration, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedGovernmentIntegrations;
}

//   @override
//   GovernmentIntegration upsert(GovernmentIntegration item) {
//     return recursiveUpsert(item);
//   }

}


class GovernmentIntegrationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      GovernmentIntegrationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (governmentIntegration) => GovernmentIntegrationStore.instance
            .getOrg$(governmentIntegration, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (governmentIntegration) => GovernmentIntegrationStore.instance
            .getOrg(governmentIntegration, modelFilter: modelFilter, includes: includes);
      }
}

	GovernmentIntegrationInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (governmentIntegration) => GovernmentIntegrationStore.instance
            .getUser$(governmentIntegration, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (governmentIntegration) => GovernmentIntegrationStore.instance
            .getUser(governmentIntegration, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum GovernmentIntegrationEndpoints implements Endpoint {

    getAll('/governmentIntegration', HttpMethod.post, List<GovernmentIntegration>),
	getById('/governmentIntegration/byId/:id', HttpMethod.post, GovernmentIntegration),
	getManyByOrgId('/governmentIntegration/byOrgId/:orgId', HttpMethod.post, List<GovernmentIntegration>),
	getManyByUserId('/governmentIntegration/byUserId/:userId', HttpMethod.post, List<GovernmentIntegration>),
	getManyByRegion('/governmentIntegration/byRegion/:region', HttpMethod.post, List<GovernmentIntegration>),
	getManyByName('/governmentIntegration/byName/:name', HttpMethod.post, List<GovernmentIntegration>),
	getManyByBaseUrl('/governmentIntegration/byBaseUrl/:baseUrl', HttpMethod.post, List<GovernmentIntegration>),
	getManyByIsEnabled('/governmentIntegration/byIsEnabled/:isEnabled', HttpMethod.post, List<GovernmentIntegration>),
	getManyByApiKeyCiphertext('/governmentIntegration/byApiKeyCiphertext/:apiKeyCiphertext', HttpMethod.post, List<GovernmentIntegration>),
	getManyByApiSecretCiphertext('/governmentIntegration/byApiSecretCiphertext/:apiSecretCiphertext', HttpMethod.post, List<GovernmentIntegration>),
	getManyByTokenCiphertext('/governmentIntegration/byTokenCiphertext/:tokenCiphertext', HttpMethod.post, List<GovernmentIntegration>),
	getManyByScopes('/governmentIntegration/byScopes/:scopes', HttpMethod.post, List<GovernmentIntegration>),
	getManyByLastSyncAt('/governmentIntegration/byLastSyncAt/:lastSyncAt', HttpMethod.post, List<GovernmentIntegration>),
	getManyByStatus('/governmentIntegration/byStatus/:status', HttpMethod.post, List<GovernmentIntegration>),
	getManyByLastError('/governmentIntegration/byLastError/:lastError', HttpMethod.post, List<GovernmentIntegration>),
	getManyByCreatedBy('/governmentIntegration/byCreatedBy/:createdBy', HttpMethod.post, List<GovernmentIntegration>),
	getManyByCreatedAt('/governmentIntegration/byCreatedAt/:createdAt', HttpMethod.post, List<GovernmentIntegration>),
	getManyByUpdatedAt('/governmentIntegration/byUpdatedAt/:updatedAt', HttpMethod.post, List<GovernmentIntegration>),
	getManyByDeletedAt('/governmentIntegration/byDeletedAt/:deletedAt', HttpMethod.post, List<GovernmentIntegration>);

    const GovernmentIntegrationEndpoints(this.path, this.method, this.responseType);

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
