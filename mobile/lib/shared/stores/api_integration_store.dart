
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ApiIntegrationStore extends ModelStreamStore<String, ApiIntegration> {

  static ApiIntegrationStore? _instance;

  static ApiIntegrationStore get instance {
    _instance ??= ApiIntegrationStore();
    return _instance!;
  }

  ApiIntegrationStore() : super(ApiIntegration.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ApiIntegrationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ApiIntegrationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ApiIntegrationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getApiIntegrationId(ApiIntegration apiIntegration) => apiIntegration.id;

	String? getApiIntegrationOrgId(ApiIntegration apiIntegration) => apiIntegration.orgId;

	RentalPlatform? getApiIntegrationPlatform(ApiIntegration apiIntegration) => apiIntegration.platform;

	String? getApiIntegrationName(ApiIntegration apiIntegration) => apiIntegration.name;

	bool? getApiIntegrationIsEnabled(ApiIntegration apiIntegration) => apiIntegration.isEnabled;

	String? getApiIntegrationApiKey(ApiIntegration apiIntegration) => apiIntegration.apiKey;

	String? getApiIntegrationApiSecret(ApiIntegration apiIntegration) => apiIntegration.apiSecret;

	String? getApiIntegrationAccessToken(ApiIntegration apiIntegration) => apiIntegration.accessToken;

	String? getApiIntegrationRefreshToken(ApiIntegration apiIntegration) => apiIntegration.refreshToken;

	DateTime? getApiIntegrationTokenExpiry(ApiIntegration apiIntegration) => apiIntegration.tokenExpiry;

	String? getApiIntegrationBaseUrl(ApiIntegration apiIntegration) => apiIntegration.baseUrl;

	dynamic? getApiIntegrationConfig(ApiIntegration apiIntegration) => apiIntegration.config;

	int? getApiIntegrationRateLimit(ApiIntegration apiIntegration) => apiIntegration.rateLimit;

	SyncDirection? getApiIntegrationSyncDirection(ApiIntegration apiIntegration) => apiIntegration.syncDirection;

	bool? getApiIntegrationAutoSync(ApiIntegration apiIntegration) => apiIntegration.autoSync;

	int? getApiIntegrationSyncInterval(ApiIntegration apiIntegration) => apiIntegration.syncInterval;

	DateTime? getApiIntegrationLastSyncAt(ApiIntegration apiIntegration) => apiIntegration.lastSyncAt;

	SyncStatus? getApiIntegrationLastSyncStatus(ApiIntegration apiIntegration) => apiIntegration.lastSyncStatus;

	String? getApiIntegrationLastError(ApiIntegration apiIntegration) => apiIntegration.lastError;

	String? getApiIntegrationCreatedBy(ApiIntegration apiIntegration) => apiIntegration.createdBy;

	DateTime? getApiIntegrationCreatedAt(ApiIntegration apiIntegration) => apiIntegration.createdAt;

	DateTime? getApiIntegrationUpdatedAt(ApiIntegration apiIntegration) => apiIntegration.updatedAt;

	DateTime? getApiIntegrationDeletedAt(ApiIntegration apiIntegration) => apiIntegration.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ApiIntegration> getByOrgId(
    String orgId,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByPlatform(
    RentalPlatform platform,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationPlatform, platform, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByName(
    String name,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationName, name, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByIsEnabled(
    bool isEnabled,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationIsEnabled, isEnabled, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByApiKey(
    String apiKey,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationApiKey, apiKey, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByApiSecret(
    String apiSecret,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationApiSecret, apiSecret, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByAccessToken(
    String accessToken,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationAccessToken, accessToken, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByRefreshToken(
    String refreshToken,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationRefreshToken, refreshToken, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByTokenExpiry(
    DateTime tokenExpiry,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationTokenExpiry, tokenExpiry, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByBaseUrl(
    String baseUrl,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationBaseUrl, baseUrl, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByConfig(
    dynamic config,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationConfig, config, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByRateLimit(
    int rateLimit,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationRateLimit, rateLimit, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getBySyncDirection(
    SyncDirection syncDirection,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationSyncDirection, syncDirection, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByAutoSync(
    bool autoSync,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationAutoSync, autoSync, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getBySyncInterval(
    int syncInterval,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationSyncInterval, syncInterval, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByLastSyncAt(
    DateTime lastSyncAt,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationLastSyncAt, lastSyncAt, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByLastSyncStatus(
    SyncStatus lastSyncStatus,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationLastSyncStatus, lastSyncStatus, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByLastError(
    String lastError,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationLastError, lastError, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByCreatedBy(
    String createdBy,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ApiIntegration> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}
    ) =>
    getManyIncluding(getApiIntegrationDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    ApiIntegration apiIntegration, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (apiIntegration.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(apiIntegration.orgId!, includes: includes);
        apiIntegration.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<ExternalRentalListing> getExternalListings(
    ApiIntegration apiIntegration, {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}) {
    final externalListings = ExternalRentalListingStore.instance.getByIntegrationId(apiIntegration.$uid!, modelFilter: modelFilter, includes: includes);
    apiIntegration.externalListings = externalListings;
    // setIncludedReferencesForList(externalListings, includes: includes);
    return externalListings;
}

	List<RentalSyncJob> getSyncJobs(
    ApiIntegration apiIntegration, {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}) {
    final syncJobs = RentalSyncJobStore.instance.getByIntegrationId(apiIntegration.$uid!, modelFilter: modelFilter, includes: includes);
    apiIntegration.syncJobs = syncJobs;
    // setIncludedReferencesForList(syncJobs, includes: includes);
    return syncJobs;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ApiIntegration>> getAll$({bool useCache = true, ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ApiIntegrationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ApiIntegration?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getApiIntegrationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ApiIntegration>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByPlatform$(
        RentalPlatform platform,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<RentalPlatform>(
        getPropVal: getApiIntegrationPlatform,
        value: platform,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByPlatform,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationName,
        value: name,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByIsEnabled$(
        bool isEnabled,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getApiIntegrationIsEnabled,
        value: isEnabled,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByIsEnabled,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByApiKey$(
        String apiKey,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationApiKey,
        value: apiKey,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByApiKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByApiSecret$(
        String apiSecret,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationApiSecret,
        value: apiSecret,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByApiSecret,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByAccessToken$(
        String accessToken,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationAccessToken,
        value: accessToken,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByAccessToken,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByRefreshToken$(
        String refreshToken,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationRefreshToken,
        value: refreshToken,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByRefreshToken,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByTokenExpiry$(
        DateTime tokenExpiry,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiIntegrationTokenExpiry,
        value: tokenExpiry,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByTokenExpiry,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByBaseUrl$(
        String baseUrl,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationBaseUrl,
        value: baseUrl,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByBaseUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByConfig$(
        dynamic config,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getApiIntegrationConfig,
        value: config,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByRateLimit$(
        int rateLimit,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getApiIntegrationRateLimit,
        value: rateLimit,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByRateLimit,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getBySyncDirection$(
        SyncDirection syncDirection,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<SyncDirection>(
        getPropVal: getApiIntegrationSyncDirection,
        value: syncDirection,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyBySyncDirection,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByAutoSync$(
        bool autoSync,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getApiIntegrationAutoSync,
        value: autoSync,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByAutoSync,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getBySyncInterval$(
        int syncInterval,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getApiIntegrationSyncInterval,
        value: syncInterval,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyBySyncInterval,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByLastSyncAt$(
        DateTime lastSyncAt,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiIntegrationLastSyncAt,
        value: lastSyncAt,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByLastSyncAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByLastSyncStatus$(
        SyncStatus lastSyncStatus,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<SyncStatus>(
        getPropVal: getApiIntegrationLastSyncStatus,
        value: lastSyncStatus,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByLastSyncStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByLastError$(
        String lastError,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationLastError,
        value: lastError,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByLastError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getApiIntegrationCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiIntegrationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiIntegrationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ApiIntegration>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ApiIntegration>? modelFilter,
        List<ApiIntegrationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getApiIntegrationDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ApiIntegrationEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    ApiIntegration apiIntegration, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (apiIntegration.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            apiIntegration.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            apiIntegration.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<ExternalRentalListing>> getExternalListings$(
    ApiIntegration apiIntegration, {bool useCache = true, ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}) {
    return ExternalRentalListingStore.instance.getByIntegrationId$(
        apiIntegration.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((externalListings) {
        apiIntegration.externalListings = externalListings;
    });

}

	Stream<List<RentalSyncJob>> getSyncJobs$(
    ApiIntegration apiIntegration, {bool useCache = true, ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}) {
    return RentalSyncJobStore.instance.getByIntegrationId$(
        apiIntegration.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((syncJobs) {
        apiIntegration.syncJobs = syncJobs;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
ApiIntegration recursiveUpsert(ApiIntegration apiIntegration, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ApiIntegration'} 
        : const {};
    if (apiIntegration.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        apiIntegration.org = OrganizationStore.instance.recursiveUpsert(apiIntegration.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (apiIntegration.externalListings != null && (!preventCircularSerialization || !upsertedTypes.contains('ExternalRentalListing'))) {
        apiIntegration.externalListings = ExternalRentalListingStore.instance.recursiveListUpsert(apiIntegration.externalListings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (apiIntegration.syncJobs != null && (!preventCircularSerialization || !upsertedTypes.contains('RentalSyncJob'))) {
        apiIntegration.syncJobs = RentalSyncJobStore.instance.recursiveListUpsert(apiIntegration.syncJobs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(apiIntegration);
}

  List<ApiIntegration> recursiveListUpsert(List<ApiIntegration> apiIntegrations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedApiIntegrations = <ApiIntegration>[];
    for (var apiIntegration in apiIntegrations) {
        updatedApiIntegrations.add(recursiveUpsert(apiIntegration, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedApiIntegrations;
}

//   @override
//   ApiIntegration upsert(ApiIntegration item) {
//     return recursiveUpsert(item);
//   }

}


class ApiIntegrationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ApiIntegrationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (apiIntegration) => ApiIntegrationStore.instance
            .getOrg$(apiIntegration, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (apiIntegration) => ApiIntegrationStore.instance
            .getOrg(apiIntegration, modelFilter: modelFilter, includes: includes);
      }
}

	ApiIntegrationInclude.externalListings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExternalRentalListing>? modelFilter,
    List<ExternalRentalListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (apiIntegration) => ApiIntegrationStore.instance
            .getExternalListings$(apiIntegration, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (apiIntegration) => ApiIntegrationStore.instance
            .getExternalListings(apiIntegration, modelFilter: modelFilter, includes: includes);
      }
}

	ApiIntegrationInclude.syncJobs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RentalSyncJob>? modelFilter,
    List<RentalSyncJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (apiIntegration) => ApiIntegrationStore.instance
            .getSyncJobs$(apiIntegration, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (apiIntegration) => ApiIntegrationStore.instance
            .getSyncJobs(apiIntegration, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ApiIntegrationEndpoints implements Endpoint {

    getAll('/apiIntegration', HttpMethod.post, List<ApiIntegration>),
	getById('/apiIntegration/byId/:id', HttpMethod.post, ApiIntegration),
	getManyByOrgId('/apiIntegration/byOrgId/:orgId', HttpMethod.post, List<ApiIntegration>),
	getManyByPlatform('/apiIntegration/byPlatform/:platform', HttpMethod.post, List<ApiIntegration>),
	getManyByName('/apiIntegration/byName/:name', HttpMethod.post, List<ApiIntegration>),
	getManyByIsEnabled('/apiIntegration/byIsEnabled/:isEnabled', HttpMethod.post, List<ApiIntegration>),
	getManyByApiKey('/apiIntegration/byApiKey/:apiKey', HttpMethod.post, List<ApiIntegration>),
	getManyByApiSecret('/apiIntegration/byApiSecret/:apiSecret', HttpMethod.post, List<ApiIntegration>),
	getManyByAccessToken('/apiIntegration/byAccessToken/:accessToken', HttpMethod.post, List<ApiIntegration>),
	getManyByRefreshToken('/apiIntegration/byRefreshToken/:refreshToken', HttpMethod.post, List<ApiIntegration>),
	getManyByTokenExpiry('/apiIntegration/byTokenExpiry/:tokenExpiry', HttpMethod.post, List<ApiIntegration>),
	getManyByBaseUrl('/apiIntegration/byBaseUrl/:baseUrl', HttpMethod.post, List<ApiIntegration>),
	getManyByConfig('/apiIntegration/byConfig/:config', HttpMethod.post, List<ApiIntegration>),
	getManyByRateLimit('/apiIntegration/byRateLimit/:rateLimit', HttpMethod.post, List<ApiIntegration>),
	getManyBySyncDirection('/apiIntegration/bySyncDirection/:syncDirection', HttpMethod.post, List<ApiIntegration>),
	getManyByAutoSync('/apiIntegration/byAutoSync/:autoSync', HttpMethod.post, List<ApiIntegration>),
	getManyBySyncInterval('/apiIntegration/bySyncInterval/:syncInterval', HttpMethod.post, List<ApiIntegration>),
	getManyByLastSyncAt('/apiIntegration/byLastSyncAt/:lastSyncAt', HttpMethod.post, List<ApiIntegration>),
	getManyByLastSyncStatus('/apiIntegration/byLastSyncStatus/:lastSyncStatus', HttpMethod.post, List<ApiIntegration>),
	getManyByLastError('/apiIntegration/byLastError/:lastError', HttpMethod.post, List<ApiIntegration>),
	getManyByCreatedBy('/apiIntegration/byCreatedBy/:createdBy', HttpMethod.post, List<ApiIntegration>),
	getManyByCreatedAt('/apiIntegration/byCreatedAt/:createdAt', HttpMethod.post, List<ApiIntegration>),
	getManyByUpdatedAt('/apiIntegration/byUpdatedAt/:updatedAt', HttpMethod.post, List<ApiIntegration>),
	getManyByDeletedAt('/apiIntegration/byDeletedAt/:deletedAt', HttpMethod.post, List<ApiIntegration>);

    const ApiIntegrationEndpoints(this.path, this.method, this.responseType);

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
