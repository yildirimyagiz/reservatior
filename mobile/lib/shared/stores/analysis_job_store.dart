
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AnalysisJobStore extends ModelStreamStore<String, AnalysisJob> {

  static AnalysisJobStore? _instance;

  static AnalysisJobStore get instance {
    _instance ??= AnalysisJobStore();
    return _instance!;
  }

  AnalysisJobStore() : super(AnalysisJob.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AnalysisJobStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AnalysisJobStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AnalysisJobStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAnalysisJobId(AnalysisJob analysisJob) => analysisJob.id;

	String? getAnalysisJobDocumentId(AnalysisJob analysisJob) => analysisJob.documentId;

	String? getAnalysisJobOrgId(AnalysisJob analysisJob) => analysisJob.orgId;

	String? getAnalysisJobStatus(AnalysisJob analysisJob) => analysisJob.status;

	String? getAnalysisJobType(AnalysisJob analysisJob) => analysisJob.type;

	String? getAnalysisJobPriority(AnalysisJob analysisJob) => analysisJob.priority;

	DateTime? getAnalysisJobStartedAt(AnalysisJob analysisJob) => analysisJob.startedAt;

	DateTime? getAnalysisJobCompletedAt(AnalysisJob analysisJob) => analysisJob.completedAt;

	int? getAnalysisJobProcessingTime(AnalysisJob analysisJob) => analysisJob.processingTime;

	String? getAnalysisJobErrorMessage(AnalysisJob analysisJob) => analysisJob.errorMessage;

	dynamic? getAnalysisJobParameters(AnalysisJob analysisJob) => analysisJob.parameters;

	DateTime? getAnalysisJobCreatedAt(AnalysisJob analysisJob) => analysisJob.createdAt;

	DateTime? getAnalysisJobUpdatedAt(AnalysisJob analysisJob) => analysisJob.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AnalysisJob> getByDocumentId(
    String documentId,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobDocumentId, documentId, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByOrgId(
    String orgId,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByStatus(
    String status,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByType(
    String type,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobType, type, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByPriority(
    String priority,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobPriority, priority, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByStartedAt(
    DateTime startedAt,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobStartedAt, startedAt, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByCompletedAt(
    DateTime completedAt,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobCompletedAt, completedAt, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByProcessingTime(
    int processingTime,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobProcessingTime, processingTime, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByErrorMessage(
    String errorMessage,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobErrorMessage, errorMessage, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByParameters(
    dynamic parameters,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobParameters, parameters, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AnalysisJob> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}
    ) =>
    getManyIncluding(getAnalysisJobUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Document? getDocument(
    AnalysisJob analysisJob, {ModelFilter? modelFilter, List<DocumentInclude>? includes}) {
    if (analysisJob.documentId == null) {
        return null;
    } else {
        final document = DocumentStore.instance.getById(analysisJob.documentId!, includes: includes);
        analysisJob.document = document;
        // setIncludedReferences(document, includes: includes);
        return document;
    }
}

	Organization? getOrg(
    AnalysisJob analysisJob, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (analysisJob.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(analysisJob.orgId!, includes: includes);
        analysisJob.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<DocumentAnalysis> getAnalyses(
    AnalysisJob analysisJob, {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}) {
    final analyses = DocumentAnalysisStore.instance.getByJobId(analysisJob.$uid!, modelFilter: modelFilter, includes: includes);
    analysisJob.analyses = analyses;
    // setIncludedReferencesForList(analyses, includes: includes);
    return analyses;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AnalysisJob>> getAll$({bool useCache = true, ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AnalysisJobEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AnalysisJob?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAnalysisJobId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AnalysisJob>> getByDocumentId$(
        String documentId,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalysisJobDocumentId,
        value: documentId,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByDocumentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalysisJobOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalysisJobStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalysisJobType,
        value: type,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByPriority$(
        String priority,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalysisJobPriority,
        value: priority,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByPriority,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByStartedAt$(
        DateTime startedAt,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAnalysisJobStartedAt,
        value: startedAt,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByStartedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByCompletedAt$(
        DateTime completedAt,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAnalysisJobCompletedAt,
        value: completedAt,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByCompletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByProcessingTime$(
        int processingTime,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAnalysisJobProcessingTime,
        value: processingTime,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByProcessingTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByErrorMessage$(
        String errorMessage,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalysisJobErrorMessage,
        value: errorMessage,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByErrorMessage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByParameters$(
        dynamic parameters,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAnalysisJobParameters,
        value: parameters,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByParameters,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAnalysisJobCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AnalysisJob>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AnalysisJob>? modelFilter,
        List<AnalysisJobInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAnalysisJobUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AnalysisJobEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Document?> getDocument$(
    AnalysisJob analysisJob, {bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    if (analysisJob.documentId == null) {
        return Stream.value(null);
    } else {
        return DocumentStore.instance.getById$(
            analysisJob.documentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((document) {
            analysisJob.document = document;
        });
    }
}

	Stream<Organization?> getOrg$(
    AnalysisJob analysisJob, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (analysisJob.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            analysisJob.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            analysisJob.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<DocumentAnalysis>> getAnalyses$(
    AnalysisJob analysisJob, {bool useCache = true, ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}) {
    return DocumentAnalysisStore.instance.getByJobId$(
        analysisJob.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analyses) {
        analysisJob.analyses = analyses;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AnalysisJob recursiveUpsert(AnalysisJob analysisJob, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AnalysisJob'} 
        : const {};
    if (analysisJob.document != null && (!preventCircularSerialization || !upsertedTypes.contains('Document'))) {
        analysisJob.document = DocumentStore.instance.recursiveUpsert(analysisJob.document!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (analysisJob.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        analysisJob.org = OrganizationStore.instance.recursiveUpsert(analysisJob.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (analysisJob.analyses != null && (!preventCircularSerialization || !upsertedTypes.contains('DocumentAnalysis'))) {
        analysisJob.analyses = DocumentAnalysisStore.instance.recursiveListUpsert(analysisJob.analyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(analysisJob);
}

  List<AnalysisJob> recursiveListUpsert(List<AnalysisJob> analysisJobs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAnalysisJobs = <AnalysisJob>[];
    for (var analysisJob in analysisJobs) {
        updatedAnalysisJobs.add(recursiveUpsert(analysisJob, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAnalysisJobs;
}

//   @override
//   AnalysisJob upsert(AnalysisJob item) {
//     return recursiveUpsert(item);
//   }

}


class AnalysisJobInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AnalysisJobInclude.document({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Document>? modelFilter,
    List<DocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analysisJob) => AnalysisJobStore.instance
            .getDocument$(analysisJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analysisJob) => AnalysisJobStore.instance
            .getDocument(analysisJob, modelFilter: modelFilter, includes: includes);
      }
}

	AnalysisJobInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analysisJob) => AnalysisJobStore.instance
            .getOrg$(analysisJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analysisJob) => AnalysisJobStore.instance
            .getOrg(analysisJob, modelFilter: modelFilter, includes: includes);
      }
}

	AnalysisJobInclude.analyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DocumentAnalysis>? modelFilter,
    List<DocumentAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analysisJob) => AnalysisJobStore.instance
            .getAnalyses$(analysisJob, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analysisJob) => AnalysisJobStore.instance
            .getAnalyses(analysisJob, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AnalysisJobEndpoints implements Endpoint {

    getAll('/analysisJob', HttpMethod.post, List<AnalysisJob>),
	getById('/analysisJob/byId/:id', HttpMethod.post, AnalysisJob),
	getManyByDocumentId('/analysisJob/byDocumentId/:documentId', HttpMethod.post, List<AnalysisJob>),
	getManyByOrgId('/analysisJob/byOrgId/:orgId', HttpMethod.post, List<AnalysisJob>),
	getManyByStatus('/analysisJob/byStatus/:status', HttpMethod.post, List<AnalysisJob>),
	getManyByType('/analysisJob/byType/:type', HttpMethod.post, List<AnalysisJob>),
	getManyByPriority('/analysisJob/byPriority/:priority', HttpMethod.post, List<AnalysisJob>),
	getManyByStartedAt('/analysisJob/byStartedAt/:startedAt', HttpMethod.post, List<AnalysisJob>),
	getManyByCompletedAt('/analysisJob/byCompletedAt/:completedAt', HttpMethod.post, List<AnalysisJob>),
	getManyByProcessingTime('/analysisJob/byProcessingTime/:processingTime', HttpMethod.post, List<AnalysisJob>),
	getManyByErrorMessage('/analysisJob/byErrorMessage/:errorMessage', HttpMethod.post, List<AnalysisJob>),
	getManyByParameters('/analysisJob/byParameters/:parameters', HttpMethod.post, List<AnalysisJob>),
	getManyByCreatedAt('/analysisJob/byCreatedAt/:createdAt', HttpMethod.post, List<AnalysisJob>),
	getManyByUpdatedAt('/analysisJob/byUpdatedAt/:updatedAt', HttpMethod.post, List<AnalysisJob>);

    const AnalysisJobEndpoints(this.path, this.method, this.responseType);

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
