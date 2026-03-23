
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MLSExternalListingStore extends ModelStreamStore<String, MLSExternalListing> {

  static MLSExternalListingStore? _instance;

  static MLSExternalListingStore get instance {
    _instance ??= MLSExternalListingStore();
    return _instance!;
  }

  MLSExternalListingStore() : super(MLSExternalListing.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MLSExternalListingStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MLSExternalListingStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MLSExternalListingStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMLSExternalListingId(MLSExternalListing mLSExternalListing) => mLSExternalListing.id;

	String? getMLSExternalListingOrgId(MLSExternalListing mLSExternalListing) => mLSExternalListing.orgId;

	String? getMLSExternalListingConnectionId(MLSExternalListing mLSExternalListing) => mLSExternalListing.connectionId;

	String? getMLSExternalListingExternalId(MLSExternalListing mLSExternalListing) => mLSExternalListing.externalId;

	String? getMLSExternalListingExternalUrl(MLSExternalListing mLSExternalListing) => mLSExternalListing.externalUrl;

	dynamic? getMLSExternalListingRaw(MLSExternalListing mLSExternalListing) => mLSExternalListing.raw;

	String? getMLSExternalListingMappedListingId(MLSExternalListing mLSExternalListing) => mLSExternalListing.mappedListingId;

	String? getMLSExternalListingStatus(MLSExternalListing mLSExternalListing) => mLSExternalListing.status;

	DateTime? getMLSExternalListingLastSeenAt(MLSExternalListing mLSExternalListing) => mLSExternalListing.lastSeenAt;

	DateTime? getMLSExternalListingCreatedAt(MLSExternalListing mLSExternalListing) => mLSExternalListing.createdAt;

	DateTime? getMLSExternalListingUpdatedAt(MLSExternalListing mLSExternalListing) => mLSExternalListing.updatedAt;

	DateTime? getMLSExternalListingDeletedAt(MLSExternalListing mLSExternalListing) => mLSExternalListing.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MLSExternalListing> getByOrgId(
    String orgId,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByConnectionId(
    String connectionId,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingConnectionId, connectionId, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByExternalId(
    String externalId,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingExternalId, externalId, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByExternalUrl(
    String externalUrl,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingExternalUrl, externalUrl, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByRaw(
    dynamic raw,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingRaw, raw, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByMappedListingId(
    String mappedListingId,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingMappedListingId, mappedListingId, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByStatus(
    String status,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingStatus, status, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByLastSeenAt(
    DateTime lastSeenAt,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingLastSeenAt, lastSeenAt, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<MLSExternalListing> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}
    ) =>
    getManyIncluding(getMLSExternalListingDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  MLSConnection? getConnection(
    MLSExternalListing mLSExternalListing, {ModelFilter? modelFilter, List<MLSConnectionInclude>? includes}) {
    if (mLSExternalListing.connectionId == null) {
        return null;
    } else {
        final connection = MLSConnectionStore.instance.getById(mLSExternalListing.connectionId!, includes: includes);
        mLSExternalListing.connection = connection;
        // setIncludedReferences(connection, includes: includes);
        return connection;
    }
}

	Organization? getOrg(
    MLSExternalListing mLSExternalListing, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mLSExternalListing.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mLSExternalListing.orgId!, includes: includes);
        mLSExternalListing.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MLSExternalListing>> getAll$({bool useCache = true, ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MLSExternalListingEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MLSExternalListing?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMLSExternalListingId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MLSExternalListing>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSExternalListingOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByConnectionId$(
        String connectionId,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSExternalListingConnectionId,
        value: connectionId,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByConnectionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByExternalId$(
        String externalId,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSExternalListingExternalId,
        value: externalId,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByExternalId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByExternalUrl$(
        String externalUrl,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSExternalListingExternalUrl,
        value: externalUrl,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByExternalUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByRaw$(
        dynamic raw,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMLSExternalListingRaw,
        value: raw,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByRaw,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByMappedListingId$(
        String mappedListingId,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSExternalListingMappedListingId,
        value: mappedListingId,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByMappedListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSExternalListingStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByLastSeenAt$(
        DateTime lastSeenAt,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSExternalListingLastSeenAt,
        value: lastSeenAt,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByLastSeenAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSExternalListingCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSExternalListingUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSExternalListing>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<MLSExternalListing>? modelFilter,
        List<MLSExternalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSExternalListingDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MLSExternalListingEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<MLSConnection?> getConnection$(
    MLSExternalListing mLSExternalListing, {bool useCache = true, ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}) {
    if (mLSExternalListing.connectionId == null) {
        return Stream.value(null);
    } else {
        return MLSConnectionStore.instance.getById$(
            mLSExternalListing.connectionId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((connection) {
            mLSExternalListing.connection = connection;
        });
    }
}

	Stream<Organization?> getOrg$(
    MLSExternalListing mLSExternalListing, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mLSExternalListing.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mLSExternalListing.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mLSExternalListing.org = org;
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
MLSExternalListing recursiveUpsert(MLSExternalListing mLSExternalListing, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MLSExternalListing'} 
        : const {};
    if (mLSExternalListing.connection != null && (!preventCircularSerialization || !upsertedTypes.contains('MLSConnection'))) {
        mLSExternalListing.connection = MLSConnectionStore.instance.recursiveUpsert(mLSExternalListing.connection!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mLSExternalListing.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mLSExternalListing.org = OrganizationStore.instance.recursiveUpsert(mLSExternalListing.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mLSExternalListing);
}

  List<MLSExternalListing> recursiveListUpsert(List<MLSExternalListing> mLSExternalListings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMLSExternalListings = <MLSExternalListing>[];
    for (var mLSExternalListing in mLSExternalListings) {
        updatedMLSExternalListings.add(recursiveUpsert(mLSExternalListing, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMLSExternalListings;
}

//   @override
//   MLSExternalListing upsert(MLSExternalListing item) {
//     return recursiveUpsert(item);
//   }

}


class MLSExternalListingInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MLSExternalListingInclude.connection({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MLSConnection>? modelFilter,
    List<MLSConnectionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mLSExternalListing) => MLSExternalListingStore.instance
            .getConnection$(mLSExternalListing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mLSExternalListing) => MLSExternalListingStore.instance
            .getConnection(mLSExternalListing, modelFilter: modelFilter, includes: includes);
      }
}

	MLSExternalListingInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mLSExternalListing) => MLSExternalListingStore.instance
            .getOrg$(mLSExternalListing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mLSExternalListing) => MLSExternalListingStore.instance
            .getOrg(mLSExternalListing, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MLSExternalListingEndpoints implements Endpoint {

    getAll('/mLSExternalListing', HttpMethod.post, List<MLSExternalListing>),
	getById('/mLSExternalListing/byId/:id', HttpMethod.post, MLSExternalListing),
	getManyByOrgId('/mLSExternalListing/byOrgId/:orgId', HttpMethod.post, List<MLSExternalListing>),
	getManyByConnectionId('/mLSExternalListing/byConnectionId/:connectionId', HttpMethod.post, List<MLSExternalListing>),
	getManyByExternalId('/mLSExternalListing/byExternalId/:externalId', HttpMethod.post, List<MLSExternalListing>),
	getManyByExternalUrl('/mLSExternalListing/byExternalUrl/:externalUrl', HttpMethod.post, List<MLSExternalListing>),
	getManyByRaw('/mLSExternalListing/byRaw/:raw', HttpMethod.post, List<MLSExternalListing>),
	getManyByMappedListingId('/mLSExternalListing/byMappedListingId/:mappedListingId', HttpMethod.post, List<MLSExternalListing>),
	getManyByStatus('/mLSExternalListing/byStatus/:status', HttpMethod.post, List<MLSExternalListing>),
	getManyByLastSeenAt('/mLSExternalListing/byLastSeenAt/:lastSeenAt', HttpMethod.post, List<MLSExternalListing>),
	getManyByCreatedAt('/mLSExternalListing/byCreatedAt/:createdAt', HttpMethod.post, List<MLSExternalListing>),
	getManyByUpdatedAt('/mLSExternalListing/byUpdatedAt/:updatedAt', HttpMethod.post, List<MLSExternalListing>),
	getManyByDeletedAt('/mLSExternalListing/byDeletedAt/:deletedAt', HttpMethod.post, List<MLSExternalListing>);

    const MLSExternalListingEndpoints(this.path, this.method, this.responseType);

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
