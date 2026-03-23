
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ScrapingJobStore extends ModelStreamStore<String, ScrapingJob> {

  static ScrapingJobStore? _instance;

  static ScrapingJobStore get instance {
    _instance ??= ScrapingJobStore();
    return _instance!;
  }

  ScrapingJobStore() : super(ScrapingJob.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ScrapingJobStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ScrapingJobStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ScrapingJobStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getScrapingJobId(ScrapingJob scrapingJob) => scrapingJob.id;

	String? getScrapingJobJobType(ScrapingJob scrapingJob) => scrapingJob.jobType;

	String? getScrapingJobStatus(ScrapingJob scrapingJob) => scrapingJob.status;

	DateTime? getScrapingJobStartTime(ScrapingJob scrapingJob) => scrapingJob.startTime;

	DateTime? getScrapingJobEndTime(ScrapingJob scrapingJob) => scrapingJob.endTime;

	int? getScrapingJobProjectsScraped(ScrapingJob scrapingJob) => scrapingJob.projectsScraped;

	List<String>? getScrapingJobErrors(ScrapingJob scrapingJob) => scrapingJob.errors;

	dynamic? getScrapingJobConfiguration(ScrapingJob scrapingJob) => scrapingJob.configuration;

	DateTime? getScrapingJobCreatedAt(ScrapingJob scrapingJob) => scrapingJob.createdAt;

	DateTime? getScrapingJobUpdatedAt(ScrapingJob scrapingJob) => scrapingJob.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ScrapingJob> getByJobType(
    String jobType,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobJobType, jobType, modelFilter: modelFilter, includes: includes);

	
List<ScrapingJob> getByStatus(
    String status,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobStatus, status, modelFilter: modelFilter, includes: includes);

	
List<ScrapingJob> getByStartTime(
    DateTime startTime,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobStartTime, startTime, modelFilter: modelFilter, includes: includes);

	
List<ScrapingJob> getByEndTime(
    DateTime endTime,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobEndTime, endTime, modelFilter: modelFilter, includes: includes);

	
List<ScrapingJob> getByProjectsScraped(
    int projectsScraped,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobProjectsScraped, projectsScraped, modelFilter: modelFilter, includes: includes);

	
List<ScrapingJob> getByErrors(
    String errors,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobErrors, errors, modelFilter: modelFilter, includes: includes);

	
List<ScrapingJob> getByConfiguration(
    dynamic configuration,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobConfiguration, configuration, modelFilter: modelFilter, includes: includes);

	
List<ScrapingJob> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ScrapingJob> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}
    ) =>
    getManyIncluding(getScrapingJobUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ScrapingJob>> getAll$({bool useCache = true, ModelFilter<ScrapingJob>? modelFilter, List<ScrapingJobInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ScrapingJobEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ScrapingJob?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getScrapingJobId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ScrapingJob>> getByJobType$(
        String jobType,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getScrapingJobJobType,
        value: jobType,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByJobType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ScrapingJob>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getScrapingJobStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ScrapingJob>> getByStartTime$(
        DateTime startTime,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getScrapingJobStartTime,
        value: startTime,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByStartTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ScrapingJob>> getByEndTime$(
        DateTime endTime,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getScrapingJobEndTime,
        value: endTime,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByEndTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ScrapingJob>> getByProjectsScraped$(
        int projectsScraped,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getScrapingJobProjectsScraped,
        value: projectsScraped,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByProjectsScraped,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ScrapingJob>> getByErrors$(
        String errors,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getScrapingJobErrors,
        value: errors,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByErrors,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ScrapingJob>> getByConfiguration$(
        dynamic configuration,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getScrapingJobConfiguration,
        value: configuration,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByConfiguration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ScrapingJob>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getScrapingJobCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ScrapingJob>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ScrapingJob>? modelFilter,
        List<ScrapingJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getScrapingJobUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ScrapingJobEndpoints.getManyByUpdatedAt,
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
ScrapingJob recursiveUpsert(ScrapingJob scrapingJob, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ScrapingJob'} 
        : const {};
    
    return super.upsert(scrapingJob);
}

  List<ScrapingJob> recursiveListUpsert(List<ScrapingJob> scrapingJobs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedScrapingJobs = <ScrapingJob>[];
    for (var scrapingJob in scrapingJobs) {
        updatedScrapingJobs.add(recursiveUpsert(scrapingJob, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedScrapingJobs;
}

//   @override
//   ScrapingJob upsert(ScrapingJob item) {
//     return recursiveUpsert(item);
//   }

}


class ScrapingJobInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ScrapingJobInclude.empty({this.useCache = true, this.useAsync = true});
  }


enum ScrapingJobEndpoints implements Endpoint {

    getAll('/scrapingJob', HttpMethod.post, List<ScrapingJob>),
	getById('/scrapingJob/byId/:id', HttpMethod.post, ScrapingJob),
	getManyByJobType('/scrapingJob/byJobType/:jobType', HttpMethod.post, List<ScrapingJob>),
	getManyByStatus('/scrapingJob/byStatus/:status', HttpMethod.post, List<ScrapingJob>),
	getManyByStartTime('/scrapingJob/byStartTime/:startTime', HttpMethod.post, List<ScrapingJob>),
	getManyByEndTime('/scrapingJob/byEndTime/:endTime', HttpMethod.post, List<ScrapingJob>),
	getManyByProjectsScraped('/scrapingJob/byProjectsScraped/:projectsScraped', HttpMethod.post, List<ScrapingJob>),
	getManyByErrors('/scrapingJob/byErrors/:errors', HttpMethod.post, List<ScrapingJob>),
	getManyByConfiguration('/scrapingJob/byConfiguration/:configuration', HttpMethod.post, List<ScrapingJob>),
	getManyByCreatedAt('/scrapingJob/byCreatedAt/:createdAt', HttpMethod.post, List<ScrapingJob>),
	getManyByUpdatedAt('/scrapingJob/byUpdatedAt/:updatedAt', HttpMethod.post, List<ScrapingJob>);

    const ScrapingJobEndpoints(this.path, this.method, this.responseType);

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
