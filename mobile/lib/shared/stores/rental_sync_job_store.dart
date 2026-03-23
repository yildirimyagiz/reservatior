
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class RentalSyncJobStore extends ModelStreamStore<String, RentalSyncJob> {

  static RentalSyncJobStore? _instance;

  static RentalSyncJobStore get instance {
    _instance ??= RentalSyncJobStore();
    return _instance!;
  }

  RentalSyncJobStore() : super(RentalSyncJob.fromJson) {
    if (_instance != null) {
        throw Exception(
            'RentalSyncJobStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending RentalSyncJobStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use RentalSyncJobStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getRentalSyncJobId(RentalSyncJob rentalSyncJob) => rentalSyncJob.id;

	String? getRentalSyncJobOrgId(RentalSyncJob rentalSyncJob) => rentalSyncJob.orgId;

	String? getRentalSyncJobIntegrationId(RentalSyncJob rentalSyncJob) => rentalSyncJob.integrationId;

	RentalPlatform? getRentalSyncJobPlatform(RentalSyncJob rentalSyncJob) => rentalSyncJob.platform;

	SyncStatus? getRentalSyncJobStatus(RentalSyncJob rentalSyncJob) => rentalSyncJob.status;

	String? getRentalSyncJobJobType(RentalSyncJob rentalSyncJob) => rentalSyncJob.jobType;

	SyncDirection? getRentalSyncJobDirection(RentalSyncJob rentalSyncJob) => rentalSyncJob.direction;

	DateTime? getRentalSyncJobStartedAt(RentalSyncJob rentalSyncJob) => rentalSyncJob.startedAt;

	DateTime? getRentalSyncJobFinishedAt(RentalSyncJob rentalSyncJob) => rentalSyncJob.finishedAt;

	String? getRentalSyncJobError(RentalSyncJob rentalSyncJob) => rentalSyncJob.error;

	dynamic? getRentalSyncJobStats(RentalSyncJob rentalSyncJob) => rentalSyncJob.stats;

	String? getRentalSyncJobCreatedBy(RentalSyncJob rentalSyncJob) => rentalSyncJob.createdBy;

	DateTime? getRentalSyncJobCreatedAt(RentalSyncJob rentalSyncJob) => rentalSyncJob.createdAt;

	DateTime? getRentalSyncJobUpdatedAt(RentalSyncJob rentalSyncJob) => rentalSyncJob.updatedAt;

	DateTime? getRentalSyncJobDeletedAt(RentalSyncJob rentalSyncJob) => rentalSyncJob.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<RentalSyncJob> getByOrgId(
    String orgId,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByIntegrationId(
    String integrationId,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobIntegrationId, integrationId, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByPlatform(
    RentalPlatform platform,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobPlatform, platform, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByStatus(
    SyncStatus status,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobStatus, status, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByJobType(
    String jobType,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobJobType, jobType, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByDirection(
    SyncDirection direction,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobDirection, direction, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByStartedAt(
    DateTime startedAt,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobStartedAt, startedAt, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByFinishedAt(
    DateTime finishedAt,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobFinishedAt, finishedAt, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByError(
    String error,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobError, error, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByStats(
    dynamic stats,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobStats, stats, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByCreatedBy(
    String createdBy,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<RentalSyncJob> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}
    ) =>
    getManyIncluding(getRentalSyncJobDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  ApiIntegration? getIntegration(
    RentalSyncJob rentalSyncJob, {ModelFilter? modelFilter, List<ApiIntegrationInclude>? includes}) {
    if (rentalSyncJob.integrationId == null) {
        return null;
    } else {
        final integration = ApiIntegrationStore.instance.getById(rentalSyncJob.integrationId!, includes: includes);
        rentalSyncJob.integration = integration;
        // setIncludedReferences(integration, includes: includes);
        return integration;
    }
}

	Organization? getOrg(
    RentalSyncJob rentalSyncJob, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (rentalSyncJob.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(rentalSyncJob.orgId!, includes: includes);
        rentalSyncJob.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<RentalSyncJob>> getAll$({bool useCache = true, ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: RentalSyncJobEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<RentalSyncJob?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getRentalSyncJobId,
        value: id,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<RentalSyncJob>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentalSyncJobOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByIntegrationId$(
        String integrationId,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentalSyncJobIntegrationId,
        value: integrationId,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByIntegrationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByPlatform$(
        RentalPlatform platform,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<RentalPlatform>(
        getPropVal: getRentalSyncJobPlatform,
        value: platform,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByPlatform,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByStatus$(
        SyncStatus status,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<SyncStatus>(
        getPropVal: getRentalSyncJobStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByJobType$(
        String jobType,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentalSyncJobJobType,
        value: jobType,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByJobType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByDirection$(
        SyncDirection direction,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<SyncDirection>(
        getPropVal: getRentalSyncJobDirection,
        value: direction,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByDirection,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByStartedAt$(
        DateTime startedAt,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentalSyncJobStartedAt,
        value: startedAt,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByStartedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByFinishedAt$(
        DateTime finishedAt,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentalSyncJobFinishedAt,
        value: finishedAt,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByFinishedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByError$(
        String error,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentalSyncJobError,
        value: error,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByStats$(
        dynamic stats,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getRentalSyncJobStats,
        value: stats,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByStats,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentalSyncJobCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentalSyncJobCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentalSyncJobUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentalSyncJob>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<RentalSyncJob>? modelFilter,
        List<RentalSyncJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentalSyncJobDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: RentalSyncJobEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<ApiIntegration?> getIntegration$(
    RentalSyncJob rentalSyncJob, {bool useCache = true, ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}) {
    if (rentalSyncJob.integrationId == null) {
        return Stream.value(null);
    } else {
        return ApiIntegrationStore.instance.getById$(
            rentalSyncJob.integrationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((integration) {
            rentalSyncJob.integration = integration;
        });
    }
}

	Stream<Organization?> getOrg$(
    RentalSyncJob rentalSyncJob, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (rentalSyncJob.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            rentalSyncJob.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            rentalSyncJob.org = org;
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
RentalSyncJob recursiveUpsert(RentalSyncJob rentalSyncJob, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'RentalSyncJob'} 
        : const {};
    if (rentalSyncJob.integration != null && (!preventCircularSerialization || !upsertedTypes.contains('ApiIntegration'))) {
        rentalSyncJob.integration = ApiIntegrationStore.instance.recursiveUpsert(rentalSyncJob.integration!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (rentalSyncJob.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        rentalSyncJob.org = OrganizationStore.instance.recursiveUpsert(rentalSyncJob.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(rentalSyncJob);
}

  List<RentalSyncJob> recursiveListUpsert(List<RentalSyncJob> rentalSyncJobs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedRentalSyncJobs = <RentalSyncJob>[];
    for (var rentalSyncJob in rentalSyncJobs) {
        updatedRentalSyncJobs.add(recursiveUpsert(rentalSyncJob, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedRentalSyncJobs;
}

//   @override
//   RentalSyncJob upsert(RentalSyncJob item) {
//     return recursiveUpsert(item);
//   }

}


class RentalSyncJobInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      RentalSyncJobInclude.integration({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ApiIntegration>? modelFilter,
    List<ApiIntegrationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rentalSyncJob) => RentalSyncJobStore.instance
            .getIntegration$(rentalSyncJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rentalSyncJob) => RentalSyncJobStore.instance
            .getIntegration(rentalSyncJob, modelFilter: modelFilter, includes: includes);
      }
}

	RentalSyncJobInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rentalSyncJob) => RentalSyncJobStore.instance
            .getOrg$(rentalSyncJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rentalSyncJob) => RentalSyncJobStore.instance
            .getOrg(rentalSyncJob, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum RentalSyncJobEndpoints implements Endpoint {

    getAll('/rentalSyncJob', HttpMethod.post, List<RentalSyncJob>),
	getById('/rentalSyncJob/byId/:id', HttpMethod.post, RentalSyncJob),
	getManyByOrgId('/rentalSyncJob/byOrgId/:orgId', HttpMethod.post, List<RentalSyncJob>),
	getManyByIntegrationId('/rentalSyncJob/byIntegrationId/:integrationId', HttpMethod.post, List<RentalSyncJob>),
	getManyByPlatform('/rentalSyncJob/byPlatform/:platform', HttpMethod.post, List<RentalSyncJob>),
	getManyByStatus('/rentalSyncJob/byStatus/:status', HttpMethod.post, List<RentalSyncJob>),
	getManyByJobType('/rentalSyncJob/byJobType/:jobType', HttpMethod.post, List<RentalSyncJob>),
	getManyByDirection('/rentalSyncJob/byDirection/:direction', HttpMethod.post, List<RentalSyncJob>),
	getManyByStartedAt('/rentalSyncJob/byStartedAt/:startedAt', HttpMethod.post, List<RentalSyncJob>),
	getManyByFinishedAt('/rentalSyncJob/byFinishedAt/:finishedAt', HttpMethod.post, List<RentalSyncJob>),
	getManyByError('/rentalSyncJob/byError/:error', HttpMethod.post, List<RentalSyncJob>),
	getManyByStats('/rentalSyncJob/byStats/:stats', HttpMethod.post, List<RentalSyncJob>),
	getManyByCreatedBy('/rentalSyncJob/byCreatedBy/:createdBy', HttpMethod.post, List<RentalSyncJob>),
	getManyByCreatedAt('/rentalSyncJob/byCreatedAt/:createdAt', HttpMethod.post, List<RentalSyncJob>),
	getManyByUpdatedAt('/rentalSyncJob/byUpdatedAt/:updatedAt', HttpMethod.post, List<RentalSyncJob>),
	getManyByDeletedAt('/rentalSyncJob/byDeletedAt/:deletedAt', HttpMethod.post, List<RentalSyncJob>);

    const RentalSyncJobEndpoints(this.path, this.method, this.responseType);

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
