
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ExportJobStore extends ModelStreamStore<String, ExportJob> {

  static ExportJobStore? _instance;

  static ExportJobStore get instance {
    _instance ??= ExportJobStore();
    return _instance!;
  }

  ExportJobStore() : super(ExportJob.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ExportJobStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ExportJobStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ExportJobStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getExportJobId(ExportJob exportJob) => exportJob.id;

	String? getExportJobOrgId(ExportJob exportJob) => exportJob.orgId;

	ExportType? getExportJobType(ExportJob exportJob) => exportJob.type;

	ExportStatus? getExportJobStatus(ExportJob exportJob) => exportJob.status;

	dynamic? getExportJobParams(ExportJob exportJob) => exportJob.params;

	DateTime? getExportJobStartedAt(ExportJob exportJob) => exportJob.startedAt;

	DateTime? getExportJobFinishedAt(ExportJob exportJob) => exportJob.finishedAt;

	String? getExportJobError(ExportJob exportJob) => exportJob.error;

	String? getExportJobCreatedBy(ExportJob exportJob) => exportJob.createdBy;

	DateTime? getExportJobCreatedAt(ExportJob exportJob) => exportJob.createdAt;

	DateTime? getExportJobUpdatedAt(ExportJob exportJob) => exportJob.updatedAt;

	DateTime? getExportJobDeletedAt(ExportJob exportJob) => exportJob.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ExportJob> getByOrgId(
    String orgId,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByType(
    ExportType type,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobType, type, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByStatus(
    ExportStatus status,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobStatus, status, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByParams(
    dynamic params,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobParams, params, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByStartedAt(
    DateTime startedAt,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobStartedAt, startedAt, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByFinishedAt(
    DateTime finishedAt,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobFinishedAt, finishedAt, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByError(
    String error,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobError, error, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByCreatedBy(
    String createdBy,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ExportJob> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}
    ) =>
    getManyIncluding(getExportJobDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    ExportJob exportJob, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (exportJob.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(exportJob.orgId!, includes: includes);
        exportJob.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<ExportFile> getFiles(
    ExportJob exportJob, {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}) {
    final files = ExportFileStore.instance.getByExportJobId(exportJob.$uid!, modelFilter: modelFilter, includes: includes);
    exportJob.files = files;
    // setIncludedReferencesForList(files, includes: includes);
    return files;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ExportJob>> getAll$({bool useCache = true, ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ExportJobEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ExportJob?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getExportJobId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ExportJob>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExportJobOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByType$(
        ExportType type,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<ExportType>(
        getPropVal: getExportJobType,
        value: type,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByStatus$(
        ExportStatus status,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<ExportStatus>(
        getPropVal: getExportJobStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByParams$(
        dynamic params,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getExportJobParams,
        value: params,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByParams,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByStartedAt$(
        DateTime startedAt,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExportJobStartedAt,
        value: startedAt,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByStartedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByFinishedAt$(
        DateTime finishedAt,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExportJobFinishedAt,
        value: finishedAt,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByFinishedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByError$(
        String error,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExportJobError,
        value: error,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExportJobCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExportJobCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExportJobUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportJob>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ExportJob>? modelFilter,
        List<ExportJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExportJobDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ExportJobEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    ExportJob exportJob, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (exportJob.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            exportJob.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            exportJob.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<ExportFile>> getFiles$(
    ExportJob exportJob, {bool useCache = true, ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}) {
    return ExportFileStore.instance.getByExportJobId$(
        exportJob.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((files) {
        exportJob.files = files;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
ExportJob recursiveUpsert(ExportJob exportJob, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ExportJob'} 
        : const {};
    if (exportJob.files != null && (!preventCircularSerialization || !upsertedTypes.contains('ExportFile'))) {
        exportJob.files = ExportFileStore.instance.recursiveListUpsert(exportJob.files!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (exportJob.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        exportJob.org = OrganizationStore.instance.recursiveUpsert(exportJob.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(exportJob);
}

  List<ExportJob> recursiveListUpsert(List<ExportJob> exportJobs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedExportJobs = <ExportJob>[];
    for (var exportJob in exportJobs) {
        updatedExportJobs.add(recursiveUpsert(exportJob, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedExportJobs;
}

//   @override
//   ExportJob upsert(ExportJob item) {
//     return recursiveUpsert(item);
//   }

}


class ExportJobInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ExportJobInclude.files({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExportFile>? modelFilter,
    List<ExportFileInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (exportJob) => ExportJobStore.instance
            .getFiles$(exportJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (exportJob) => ExportJobStore.instance
            .getFiles(exportJob, modelFilter: modelFilter, includes: includes);
      }
}

	ExportJobInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (exportJob) => ExportJobStore.instance
            .getOrg$(exportJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (exportJob) => ExportJobStore.instance
            .getOrg(exportJob, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ExportJobEndpoints implements Endpoint {

    getAll('/exportJob', HttpMethod.post, List<ExportJob>),
	getById('/exportJob/byId/:id', HttpMethod.post, ExportJob),
	getManyByOrgId('/exportJob/byOrgId/:orgId', HttpMethod.post, List<ExportJob>),
	getManyByType('/exportJob/byType/:type', HttpMethod.post, List<ExportJob>),
	getManyByStatus('/exportJob/byStatus/:status', HttpMethod.post, List<ExportJob>),
	getManyByParams('/exportJob/byParams/:params', HttpMethod.post, List<ExportJob>),
	getManyByStartedAt('/exportJob/byStartedAt/:startedAt', HttpMethod.post, List<ExportJob>),
	getManyByFinishedAt('/exportJob/byFinishedAt/:finishedAt', HttpMethod.post, List<ExportJob>),
	getManyByError('/exportJob/byError/:error', HttpMethod.post, List<ExportJob>),
	getManyByCreatedBy('/exportJob/byCreatedBy/:createdBy', HttpMethod.post, List<ExportJob>),
	getManyByCreatedAt('/exportJob/byCreatedAt/:createdAt', HttpMethod.post, List<ExportJob>),
	getManyByUpdatedAt('/exportJob/byUpdatedAt/:updatedAt', HttpMethod.post, List<ExportJob>),
	getManyByDeletedAt('/exportJob/byDeletedAt/:deletedAt', HttpMethod.post, List<ExportJob>);

    const ExportJobEndpoints(this.path, this.method, this.responseType);

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
