
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MLSConnectionStore extends ModelStreamStore<String, MLSConnection> {

  static MLSConnectionStore? _instance;

  static MLSConnectionStore get instance {
    _instance ??= MLSConnectionStore();
    return _instance!;
  }

  MLSConnectionStore() : super(MLSConnection.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MLSConnectionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MLSConnectionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MLSConnectionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMLSConnectionId(MLSConnection mLSConnection) => mLSConnection.id;

	String? getMLSConnectionOrgId(MLSConnection mLSConnection) => mLSConnection.orgId;

	MLSProviderKey? getMLSConnectionProvider(MLSConnection mLSConnection) => mLSConnection.provider;

	String? getMLSConnectionName(MLSConnection mLSConnection) => mLSConnection.name;

	String? getMLSConnectionBaseUrl(MLSConnection mLSConnection) => mLSConnection.baseUrl;

	bool? getMLSConnectionIsEnabled(MLSConnection mLSConnection) => mLSConnection.isEnabled;

	String? getMLSConnectionUsernameCiphertext(MLSConnection mLSConnection) => mLSConnection.usernameCiphertext;

	String? getMLSConnectionPasswordCiphertext(MLSConnection mLSConnection) => mLSConnection.passwordCiphertext;

	String? getMLSConnectionApiKeyCiphertext(MLSConnection mLSConnection) => mLSConnection.apiKeyCiphertext;

	String? getMLSConnectionTokenCiphertext(MLSConnection mLSConnection) => mLSConnection.tokenCiphertext;

	Region? getMLSConnectionRegion(MLSConnection mLSConnection) => mLSConnection.region;

	dynamic? getMLSConnectionConfig(MLSConnection mLSConnection) => mLSConnection.config;

	DateTime? getMLSConnectionLastSyncAt(MLSConnection mLSConnection) => mLSConnection.lastSyncAt;

	SyncStatus? getMLSConnectionStatus(MLSConnection mLSConnection) => mLSConnection.status;

	String? getMLSConnectionLastError(MLSConnection mLSConnection) => mLSConnection.lastError;

	String? getMLSConnectionCreatedBy(MLSConnection mLSConnection) => mLSConnection.createdBy;

	DateTime? getMLSConnectionCreatedAt(MLSConnection mLSConnection) => mLSConnection.createdAt;

	DateTime? getMLSConnectionUpdatedAt(MLSConnection mLSConnection) => mLSConnection.updatedAt;

	DateTime? getMLSConnectionDeletedAt(MLSConnection mLSConnection) => mLSConnection.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MLSConnection> getByOrgId(
    String orgId,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByProvider(
    MLSProviderKey provider,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionProvider, provider, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByName(
    String name,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionName, name, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByBaseUrl(
    String baseUrl,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionBaseUrl, baseUrl, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByIsEnabled(
    bool isEnabled,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionIsEnabled, isEnabled, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByUsernameCiphertext(
    String usernameCiphertext,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionUsernameCiphertext, usernameCiphertext, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByPasswordCiphertext(
    String passwordCiphertext,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionPasswordCiphertext, passwordCiphertext, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByApiKeyCiphertext(
    String apiKeyCiphertext,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionApiKeyCiphertext, apiKeyCiphertext, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByTokenCiphertext(
    String tokenCiphertext,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionTokenCiphertext, tokenCiphertext, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByRegion(
    Region region,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionRegion, region, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByConfig(
    dynamic config,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionConfig, config, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByLastSyncAt(
    DateTime lastSyncAt,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionLastSyncAt, lastSyncAt, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByStatus(
    SyncStatus status,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionStatus, status, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByLastError(
    String lastError,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionLastError, lastError, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByCreatedBy(
    String createdBy,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<MLSConnection> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}
    ) =>
    getManyIncluding(getMLSConnectionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    MLSConnection mLSConnection, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mLSConnection.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mLSConnection.orgId!, includes: includes);
        mLSConnection.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<MLSExternalListing> getExternalListings(
    MLSConnection mLSConnection, {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}) {
    final externalListings = MLSExternalListingStore.instance.getByConnectionId(mLSConnection.$uid!, modelFilter: modelFilter, includes: includes);
    mLSConnection.externalListings = externalListings;
    // setIncludedReferencesForList(externalListings, includes: includes);
    return externalListings;
}

	List<MLSSyncJob> getSyncJobs(
    MLSConnection mLSConnection, {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}) {
    final syncJobs = MLSSyncJobStore.instance.getByConnectionId(mLSConnection.$uid!, modelFilter: modelFilter, includes: includes);
    mLSConnection.syncJobs = syncJobs;
    // setIncludedReferencesForList(syncJobs, includes: includes);
    return syncJobs;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MLSConnection>> getAll$({bool useCache = true, ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MLSConnectionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MLSConnection?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMLSConnectionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MLSConnection>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByProvider$(
        MLSProviderKey provider,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<MLSProviderKey>(
        getPropVal: getMLSConnectionProvider,
        value: provider,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionName,
        value: name,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByBaseUrl$(
        String baseUrl,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionBaseUrl,
        value: baseUrl,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByBaseUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByIsEnabled$(
        bool isEnabled,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMLSConnectionIsEnabled,
        value: isEnabled,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByIsEnabled,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByUsernameCiphertext$(
        String usernameCiphertext,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionUsernameCiphertext,
        value: usernameCiphertext,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByUsernameCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByPasswordCiphertext$(
        String passwordCiphertext,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionPasswordCiphertext,
        value: passwordCiphertext,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByPasswordCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByApiKeyCiphertext$(
        String apiKeyCiphertext,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionApiKeyCiphertext,
        value: apiKeyCiphertext,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByApiKeyCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByTokenCiphertext$(
        String tokenCiphertext,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionTokenCiphertext,
        value: tokenCiphertext,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByTokenCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByRegion$(
        Region region,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<Region>(
        getPropVal: getMLSConnectionRegion,
        value: region,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByRegion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByConfig$(
        dynamic config,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMLSConnectionConfig,
        value: config,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByLastSyncAt$(
        DateTime lastSyncAt,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSConnectionLastSyncAt,
        value: lastSyncAt,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByLastSyncAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByStatus$(
        SyncStatus status,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<SyncStatus>(
        getPropVal: getMLSConnectionStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByLastError$(
        String lastError,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionLastError,
        value: lastError,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByLastError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSConnectionCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSConnectionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSConnectionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSConnection>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<MLSConnection>? modelFilter,
        List<MLSConnectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSConnectionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MLSConnectionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    MLSConnection mLSConnection, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mLSConnection.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mLSConnection.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mLSConnection.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<MLSExternalListing>> getExternalListings$(
    MLSConnection mLSConnection, {bool useCache = true, ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}) {
    return MLSExternalListingStore.instance.getByConnectionId$(
        mLSConnection.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((externalListings) {
        mLSConnection.externalListings = externalListings;
    });

}

	Stream<List<MLSSyncJob>> getSyncJobs$(
    MLSConnection mLSConnection, {bool useCache = true, ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}) {
    return MLSSyncJobStore.instance.getByConnectionId$(
        mLSConnection.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((syncJobs) {
        mLSConnection.syncJobs = syncJobs;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
MLSConnection recursiveUpsert(MLSConnection mLSConnection, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MLSConnection'} 
        : const {};
    if (mLSConnection.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mLSConnection.org = OrganizationStore.instance.recursiveUpsert(mLSConnection.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mLSConnection.externalListings != null && (!preventCircularSerialization || !upsertedTypes.contains('MLSExternalListing'))) {
        mLSConnection.externalListings = MLSExternalListingStore.instance.recursiveListUpsert(mLSConnection.externalListings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mLSConnection.syncJobs != null && (!preventCircularSerialization || !upsertedTypes.contains('MLSSyncJob'))) {
        mLSConnection.syncJobs = MLSSyncJobStore.instance.recursiveListUpsert(mLSConnection.syncJobs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mLSConnection);
}

  List<MLSConnection> recursiveListUpsert(List<MLSConnection> mLSConnections, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMLSConnections = <MLSConnection>[];
    for (var mLSConnection in mLSConnections) {
        updatedMLSConnections.add(recursiveUpsert(mLSConnection, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMLSConnections;
}

//   @override
//   MLSConnection upsert(MLSConnection item) {
//     return recursiveUpsert(item);
//   }

}


class MLSConnectionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MLSConnectionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mLSConnection) => MLSConnectionStore.instance
            .getOrg$(mLSConnection, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mLSConnection) => MLSConnectionStore.instance
            .getOrg(mLSConnection, modelFilter: modelFilter, includes: includes);
      }
}

	MLSConnectionInclude.externalListings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MLSExternalListing>? modelFilter,
    List<MLSExternalListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mLSConnection) => MLSConnectionStore.instance
            .getExternalListings$(mLSConnection, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mLSConnection) => MLSConnectionStore.instance
            .getExternalListings(mLSConnection, modelFilter: modelFilter, includes: includes);
      }
}

	MLSConnectionInclude.syncJobs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MLSSyncJob>? modelFilter,
    List<MLSSyncJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mLSConnection) => MLSConnectionStore.instance
            .getSyncJobs$(mLSConnection, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mLSConnection) => MLSConnectionStore.instance
            .getSyncJobs(mLSConnection, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MLSConnectionEndpoints implements Endpoint {

    getAll('/mLSConnection', HttpMethod.post, List<MLSConnection>),
	getById('/mLSConnection/byId/:id', HttpMethod.post, MLSConnection),
	getManyByOrgId('/mLSConnection/byOrgId/:orgId', HttpMethod.post, List<MLSConnection>),
	getManyByProvider('/mLSConnection/byProvider/:provider', HttpMethod.post, List<MLSConnection>),
	getManyByName('/mLSConnection/byName/:name', HttpMethod.post, List<MLSConnection>),
	getManyByBaseUrl('/mLSConnection/byBaseUrl/:baseUrl', HttpMethod.post, List<MLSConnection>),
	getManyByIsEnabled('/mLSConnection/byIsEnabled/:isEnabled', HttpMethod.post, List<MLSConnection>),
	getManyByUsernameCiphertext('/mLSConnection/byUsernameCiphertext/:usernameCiphertext', HttpMethod.post, List<MLSConnection>),
	getManyByPasswordCiphertext('/mLSConnection/byPasswordCiphertext/:passwordCiphertext', HttpMethod.post, List<MLSConnection>),
	getManyByApiKeyCiphertext('/mLSConnection/byApiKeyCiphertext/:apiKeyCiphertext', HttpMethod.post, List<MLSConnection>),
	getManyByTokenCiphertext('/mLSConnection/byTokenCiphertext/:tokenCiphertext', HttpMethod.post, List<MLSConnection>),
	getManyByRegion('/mLSConnection/byRegion/:region', HttpMethod.post, List<MLSConnection>),
	getManyByConfig('/mLSConnection/byConfig/:config', HttpMethod.post, List<MLSConnection>),
	getManyByLastSyncAt('/mLSConnection/byLastSyncAt/:lastSyncAt', HttpMethod.post, List<MLSConnection>),
	getManyByStatus('/mLSConnection/byStatus/:status', HttpMethod.post, List<MLSConnection>),
	getManyByLastError('/mLSConnection/byLastError/:lastError', HttpMethod.post, List<MLSConnection>),
	getManyByCreatedBy('/mLSConnection/byCreatedBy/:createdBy', HttpMethod.post, List<MLSConnection>),
	getManyByCreatedAt('/mLSConnection/byCreatedAt/:createdAt', HttpMethod.post, List<MLSConnection>),
	getManyByUpdatedAt('/mLSConnection/byUpdatedAt/:updatedAt', HttpMethod.post, List<MLSConnection>),
	getManyByDeletedAt('/mLSConnection/byDeletedAt/:deletedAt', HttpMethod.post, List<MLSConnection>);

    const MLSConnectionEndpoints(this.path, this.method, this.responseType);

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
