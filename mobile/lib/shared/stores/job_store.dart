
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class JobStore extends ModelStreamStore<String, Job> {

  static JobStore? _instance;

  static JobStore get instance {
    _instance ??= JobStore();
    return _instance!;
  }

  JobStore() : super(Job.fromJson) {
    if (_instance != null) {
        throw Exception(
            'JobStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending JobStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use JobStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getJobId(Job job) => job.id;

	String? getJobOrgId(Job job) => job.orgId;

	String? getJobType(Job job) => job.type;

	dynamic? getJobPayload(Job job) => job.payload;

	ExportStatus? getJobStatus(Job job) => job.status;

	DateTime? getJobRunAt(Job job) => job.runAt;

	int? getJobAttempts(Job job) => job.attempts;

	String? getJobLastError(Job job) => job.lastError;

	DateTime? getJobLockedAt(Job job) => job.lockedAt;

	String? getJobLockedBy(Job job) => job.lockedBy;

	DateTime? getJobCreatedAt(Job job) => job.createdAt;

	DateTime? getJobUpdatedAt(Job job) => job.updatedAt;

	DateTime? getJobDeletedAt(Job job) => job.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Job> getByOrgId(
    String orgId,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Job> getByType(
    String type,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobType, type, modelFilter: modelFilter, includes: includes);

	
List<Job> getByPayload(
    dynamic payload,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobPayload, payload, modelFilter: modelFilter, includes: includes);

	
List<Job> getByStatus(
    ExportStatus status,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Job> getByRunAt(
    DateTime runAt,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobRunAt, runAt, modelFilter: modelFilter, includes: includes);

	
List<Job> getByAttempts(
    int attempts,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobAttempts, attempts, modelFilter: modelFilter, includes: includes);

	
List<Job> getByLastError(
    String lastError,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobLastError, lastError, modelFilter: modelFilter, includes: includes);

	
List<Job> getByLockedAt(
    DateTime lockedAt,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobLockedAt, lockedAt, modelFilter: modelFilter, includes: includes);

	
List<Job> getByLockedBy(
    String lockedBy,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobLockedBy, lockedBy, modelFilter: modelFilter, includes: includes);

	
List<Job> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Job> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Job> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Job>? modelFilter, List<JobInclude>? includes}
    ) =>
    getManyIncluding(getJobDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Job>> getAll$({bool useCache = true, ModelFilter<Job>? modelFilter, List<JobInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: JobEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Job?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getJobId,
        value: id,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Job>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getJobOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getJobType,
        value: type,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByPayload$(
        dynamic payload,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getJobPayload,
        value: payload,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByPayload,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByStatus$(
        ExportStatus status,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<ExportStatus>(
        getPropVal: getJobStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByRunAt$(
        DateTime runAt,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getJobRunAt,
        value: runAt,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByRunAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByAttempts$(
        int attempts,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getJobAttempts,
        value: attempts,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByAttempts,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByLastError$(
        String lastError,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getJobLastError,
        value: lastError,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByLastError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByLockedAt$(
        DateTime lockedAt,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getJobLockedAt,
        value: lockedAt,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByLockedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByLockedBy$(
        String lockedBy,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getJobLockedBy,
        value: lockedBy,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByLockedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getJobCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getJobUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Job>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Job>? modelFilter,
        List<JobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getJobDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: JobEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Job recursiveUpsert(Job job, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Job'} 
        : const {};
    
    return super.upsert(job);
}

  List<Job> recursiveListUpsert(List<Job> jobs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedJobs = <Job>[];
    for (var job in jobs) {
        updatedJobs.add(recursiveUpsert(job, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedJobs;
}

//   @override
//   Job upsert(Job item) {
//     return recursiveUpsert(item);
//   }

}


class JobInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      JobInclude.empty({this.useCache = true, this.useAsync = true});
  }


enum JobEndpoints implements Endpoint {

    getAll('/job', HttpMethod.post, List<Job>),
	getById('/job/byId/:id', HttpMethod.post, Job),
	getManyByOrgId('/job/byOrgId/:orgId', HttpMethod.post, List<Job>),
	getManyByType('/job/byType/:type', HttpMethod.post, List<Job>),
	getManyByPayload('/job/byPayload/:payload', HttpMethod.post, List<Job>),
	getManyByStatus('/job/byStatus/:status', HttpMethod.post, List<Job>),
	getManyByRunAt('/job/byRunAt/:runAt', HttpMethod.post, List<Job>),
	getManyByAttempts('/job/byAttempts/:attempts', HttpMethod.post, List<Job>),
	getManyByLastError('/job/byLastError/:lastError', HttpMethod.post, List<Job>),
	getManyByLockedAt('/job/byLockedAt/:lockedAt', HttpMethod.post, List<Job>),
	getManyByLockedBy('/job/byLockedBy/:lockedBy', HttpMethod.post, List<Job>),
	getManyByCreatedAt('/job/byCreatedAt/:createdAt', HttpMethod.post, List<Job>),
	getManyByUpdatedAt('/job/byUpdatedAt/:updatedAt', HttpMethod.post, List<Job>),
	getManyByDeletedAt('/job/byDeletedAt/:deletedAt', HttpMethod.post, List<Job>);

    const JobEndpoints(this.path, this.method, this.responseType);

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
