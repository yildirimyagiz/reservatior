
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MLSSyncJobStore extends ModelStreamStore<String, MLSSyncJob> {

  static MLSSyncJobStore? _instance;

  static MLSSyncJobStore get instance {
    _instance ??= MLSSyncJobStore();
    return _instance!;
  }

  MLSSyncJobStore() : super(MLSSyncJob.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MLSSyncJobStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MLSSyncJobStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MLSSyncJobStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMLSSyncJobId(MLSSyncJob mLSSyncJob) => mLSSyncJob.id;

	String? getMLSSyncJobOrgId(MLSSyncJob mLSSyncJob) => mLSSyncJob.orgId;

	String? getMLSSyncJobConnectionId(MLSSyncJob mLSSyncJob) => mLSSyncJob.connectionId;

	SyncStatus? getMLSSyncJobStatus(MLSSyncJob mLSSyncJob) => mLSSyncJob.status;

	DateTime? getMLSSyncJobStartedAt(MLSSyncJob mLSSyncJob) => mLSSyncJob.startedAt;

	DateTime? getMLSSyncJobFinishedAt(MLSSyncJob mLSSyncJob) => mLSSyncJob.finishedAt;

	String? getMLSSyncJobError(MLSSyncJob mLSSyncJob) => mLSSyncJob.error;

	dynamic? getMLSSyncJobStats(MLSSyncJob mLSSyncJob) => mLSSyncJob.stats;

	DateTime? getMLSSyncJobCreatedAt(MLSSyncJob mLSSyncJob) => mLSSyncJob.createdAt;

	DateTime? getMLSSyncJobUpdatedAt(MLSSyncJob mLSSyncJob) => mLSSyncJob.updatedAt;

	DateTime? getMLSSyncJobDeletedAt(MLSSyncJob mLSSyncJob) => mLSSyncJob.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MLSSyncJob> getByOrgId(
    String orgId,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByConnectionId(
    String connectionId,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobConnectionId, connectionId, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByStatus(
    SyncStatus status,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobStatus, status, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByStartedAt(
    DateTime startedAt,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobStartedAt, startedAt, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByFinishedAt(
    DateTime finishedAt,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobFinishedAt, finishedAt, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByError(
    String error,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobError, error, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByStats(
    dynamic stats,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobStats, stats, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<MLSSyncJob> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getMLSSyncJobDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  MLSConnection? getConnection(
    MLSSyncJob mLSSyncJob, {ModelFilter? modelFilter, List<MLSConnectionInclude>? includes}) {
    if (mLSSyncJob.connectionId == null) {
        return null;
    } else {
        final connection = MLSConnectionStore.instance.getById(mLSSyncJob.connectionId!, includes: includes);
        mLSSyncJob.connection = connection;
        // setIncludedReferences(connection, includes: includes);
        return connection;
    }
}

	Organization? getOrg(
    MLSSyncJob mLSSyncJob, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mLSSyncJob.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mLSSyncJob.orgId!, includes: includes);
        mLSSyncJob.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MLSSyncJob>> getAll$({bool useCache = true, ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MLSSyncJobEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MLSSyncJob?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMLSSyncJobId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MLSSyncJob>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSSyncJobOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByConnectionId$(
        String connectionId,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSSyncJobConnectionId,
        value: connectionId,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByConnectionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByStatus$(
        SyncStatus status,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<SyncStatus>(
        getPropVal: getMLSSyncJobStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByStartedAt$(
        DateTime startedAt,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSSyncJobStartedAt,
        value: startedAt,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByStartedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByFinishedAt$(
        DateTime finishedAt,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSSyncJobFinishedAt,
        value: finishedAt,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByFinishedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByError$(
        String error,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLSSyncJobError,
        value: error,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByStats$(
        dynamic stats,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMLSSyncJobStats,
        value: stats,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByStats,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSSyncJobCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSSyncJobUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLSSyncJob>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<MLSSyncJob>? modelFilter,
        List<MLSSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLSSyncJobDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MLSSyncJobEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<MLSConnection?> getConnection$(
    MLSSyncJob mLSSyncJob, {bool useCache = true, ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}) {
    if (mLSSyncJob.connectionId == null) {
        return Stream.value(null);
    } else {
        return MLSConnectionStore.instance.getById$(
            mLSSyncJob.connectionId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((connection) {
            mLSSyncJob.connection = connection;
        });
    }
}

	Stream<Organization?> getOrg$(
    MLSSyncJob mLSSyncJob, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mLSSyncJob.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mLSSyncJob.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mLSSyncJob.org = org;
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
MLSSyncJob recursiveUpsert(MLSSyncJob mLSSyncJob, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MLSSyncJob'} 
        : const {};
    if (mLSSyncJob.connection != null && (!preventCircularSerialization || !upsertedTypes.contains('MLSConnection'))) {
        mLSSyncJob.connection = MLSConnectionStore.instance.recursiveUpsert(mLSSyncJob.connection!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mLSSyncJob.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mLSSyncJob.org = OrganizationStore.instance.recursiveUpsert(mLSSyncJob.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mLSSyncJob);
}

  List<MLSSyncJob> recursiveListUpsert(List<MLSSyncJob> mLSSyncJobs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMLSSyncJobs = <MLSSyncJob>[];
    for (var mLSSyncJob in mLSSyncJobs) {
        updatedMLSSyncJobs.add(recursiveUpsert(mLSSyncJob, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMLSSyncJobs;
}

//   @override
//   MLSSyncJob upsert(MLSSyncJob item) {
//     return recursiveUpsert(item);
//   }

}


class MLSSyncJobInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MLSSyncJobInclude.connection({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MLSConnection>? modelFilter,
    List<MLSConnectionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mLSSyncJob) => MLSSyncJobStore.instance
            .getConnection$(mLSSyncJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mLSSyncJob) => MLSSyncJobStore.instance
            .getConnection(mLSSyncJob, modelFilter: modelFilter, includes: includes);
      }
}

	MLSSyncJobInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mLSSyncJob) => MLSSyncJobStore.instance
            .getOrg$(mLSSyncJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mLSSyncJob) => MLSSyncJobStore.instance
            .getOrg(mLSSyncJob, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MLSSyncJobEndpoints implements Endpoint {

    getAll('/mLSSyncJob', HttpMethod.post, List<MLSSyncJob>),
	getById('/mLSSyncJob/byId/:id', HttpMethod.post, MLSSyncJob),
	getManyByOrgId('/mLSSyncJob/byOrgId/:orgId', HttpMethod.post, List<MLSSyncJob>),
	getManyByConnectionId('/mLSSyncJob/byConnectionId/:connectionId', HttpMethod.post, List<MLSSyncJob>),
	getManyByStatus('/mLSSyncJob/byStatus/:status', HttpMethod.post, List<MLSSyncJob>),
	getManyByStartedAt('/mLSSyncJob/byStartedAt/:startedAt', HttpMethod.post, List<MLSSyncJob>),
	getManyByFinishedAt('/mLSSyncJob/byFinishedAt/:finishedAt', HttpMethod.post, List<MLSSyncJob>),
	getManyByError('/mLSSyncJob/byError/:error', HttpMethod.post, List<MLSSyncJob>),
	getManyByStats('/mLSSyncJob/byStats/:stats', HttpMethod.post, List<MLSSyncJob>),
	getManyByCreatedAt('/mLSSyncJob/byCreatedAt/:createdAt', HttpMethod.post, List<MLSSyncJob>),
	getManyByUpdatedAt('/mLSSyncJob/byUpdatedAt/:updatedAt', HttpMethod.post, List<MLSSyncJob>),
	getManyByDeletedAt('/mLSSyncJob/byDeletedAt/:deletedAt', HttpMethod.post, List<MLSSyncJob>);

    const MLSSyncJobEndpoints(this.path, this.method, this.responseType);

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
