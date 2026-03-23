
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class DocumentAnalysisStore extends ModelStreamStore<String, DocumentAnalysis> {

  static DocumentAnalysisStore? _instance;

  static DocumentAnalysisStore get instance {
    _instance ??= DocumentAnalysisStore();
    return _instance!;
  }

  DocumentAnalysisStore() : super(DocumentAnalysis.fromJson) {
    if (_instance != null) {
        throw Exception(
            'DocumentAnalysisStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending DocumentAnalysisStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use DocumentAnalysisStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getDocumentAnalysisId(DocumentAnalysis documentAnalysis) => documentAnalysis.id;

	String? getDocumentAnalysisDocumentId(DocumentAnalysis documentAnalysis) => documentAnalysis.documentId;

	String? getDocumentAnalysisJobId(DocumentAnalysis documentAnalysis) => documentAnalysis.jobId;

	String? getDocumentAnalysisOrgId(DocumentAnalysis documentAnalysis) => documentAnalysis.orgId;

	String? getDocumentAnalysisExtractedText(DocumentAnalysis documentAnalysis) => documentAnalysis.extractedText;

	dynamic? getDocumentAnalysisMetadata(DocumentAnalysis documentAnalysis) => documentAnalysis.metadata;

	dynamic? getDocumentAnalysisClassification(DocumentAnalysis documentAnalysis) => documentAnalysis.classification;

	double? getDocumentAnalysisConfidence(DocumentAnalysis documentAnalysis) => documentAnalysis.confidence;

	int? getDocumentAnalysisProcessingTime(DocumentAnalysis documentAnalysis) => documentAnalysis.processingTime;

	DateTime? getDocumentAnalysisCreatedAt(DocumentAnalysis documentAnalysis) => documentAnalysis.createdAt;

	DateTime? getDocumentAnalysisUpdatedAt(DocumentAnalysis documentAnalysis) => documentAnalysis.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<DocumentAnalysis> getByDocumentId(
    String documentId,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisDocumentId, documentId, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByJobId(
    String jobId,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisJobId, jobId, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByOrgId(
    String orgId,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByExtractedText(
    String extractedText,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisExtractedText, extractedText, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByMetadata(
    dynamic metadata,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisMetadata, metadata, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByClassification(
    dynamic classification,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisClassification, classification, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByConfidence(
    double confidence,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByProcessingTime(
    int processingTime,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisProcessingTime, processingTime, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<DocumentAnalysis> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Document? getDocument(
    DocumentAnalysis documentAnalysis, {ModelFilter? modelFilter, List<DocumentInclude>? includes}) {
    if (documentAnalysis.documentId == null) {
        return null;
    } else {
        final document = DocumentStore.instance.getById(documentAnalysis.documentId!, includes: includes);
        documentAnalysis.document = document;
        // setIncludedReferences(document, includes: includes);
        return document;
    }
}

	AnalysisJob? getJob(
    DocumentAnalysis documentAnalysis, {ModelFilter? modelFilter, List<AnalysisJobInclude>? includes}) {
    if (documentAnalysis.jobId == null) {
        return null;
    } else {
        final job = AnalysisJobStore.instance.getById(documentAnalysis.jobId!, includes: includes);
        documentAnalysis.job = job;
        // setIncludedReferences(job, includes: includes);
        return job;
    }
}

	Organization? getOrg(
    DocumentAnalysis documentAnalysis, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (documentAnalysis.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(documentAnalysis.orgId!, includes: includes);
        documentAnalysis.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<DocumentAnalysis>> getAll$({bool useCache = true, ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: DocumentAnalysisEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<DocumentAnalysis?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDocumentAnalysisId,
        value: id,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<DocumentAnalysis>> getByDocumentId$(
        String documentId,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentAnalysisDocumentId,
        value: documentId,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByDocumentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByJobId$(
        String jobId,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentAnalysisJobId,
        value: jobId,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByJobId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentAnalysisOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByExtractedText$(
        String extractedText,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentAnalysisExtractedText,
        value: extractedText,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByExtractedText,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByMetadata$(
        dynamic metadata,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDocumentAnalysisMetadata,
        value: metadata,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByClassification$(
        dynamic classification,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDocumentAnalysisClassification,
        value: classification,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByClassification,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDocumentAnalysisConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByProcessingTime$(
        int processingTime,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getDocumentAnalysisProcessingTime,
        value: processingTime,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByProcessingTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentAnalysisCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentAnalysis>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<DocumentAnalysis>? modelFilter,
        List<DocumentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentAnalysisUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: DocumentAnalysisEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Document?> getDocument$(
    DocumentAnalysis documentAnalysis, {bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    if (documentAnalysis.documentId == null) {
        return Stream.value(null);
    } else {
        return DocumentStore.instance.getById$(
            documentAnalysis.documentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((document) {
            documentAnalysis.document = document;
        });
    }
}

	Stream<AnalysisJob?> getJob$(
    DocumentAnalysis documentAnalysis, {bool useCache = true, ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}) {
    if (documentAnalysis.jobId == null) {
        return Stream.value(null);
    } else {
        return AnalysisJobStore.instance.getById$(
            documentAnalysis.jobId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((job) {
            documentAnalysis.job = job;
        });
    }
}

	Stream<Organization?> getOrg$(
    DocumentAnalysis documentAnalysis, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (documentAnalysis.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            documentAnalysis.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            documentAnalysis.org = org;
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
DocumentAnalysis recursiveUpsert(DocumentAnalysis documentAnalysis, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'DocumentAnalysis'} 
        : const {};
    if (documentAnalysis.document != null && (!preventCircularSerialization || !upsertedTypes.contains('Document'))) {
        documentAnalysis.document = DocumentStore.instance.recursiveUpsert(documentAnalysis.document!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (documentAnalysis.job != null && (!preventCircularSerialization || !upsertedTypes.contains('AnalysisJob'))) {
        documentAnalysis.job = AnalysisJobStore.instance.recursiveUpsert(documentAnalysis.job!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (documentAnalysis.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        documentAnalysis.org = OrganizationStore.instance.recursiveUpsert(documentAnalysis.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(documentAnalysis);
}

  List<DocumentAnalysis> recursiveListUpsert(List<DocumentAnalysis> documentAnalysiss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedDocumentAnalysiss = <DocumentAnalysis>[];
    for (var documentAnalysis in documentAnalysiss) {
        updatedDocumentAnalysiss.add(recursiveUpsert(documentAnalysis, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedDocumentAnalysiss;
}

//   @override
//   DocumentAnalysis upsert(DocumentAnalysis item) {
//     return recursiveUpsert(item);
//   }

}


class DocumentAnalysisInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      DocumentAnalysisInclude.document({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Document>? modelFilter,
    List<DocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (documentAnalysis) => DocumentAnalysisStore.instance
            .getDocument$(documentAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (documentAnalysis) => DocumentAnalysisStore.instance
            .getDocument(documentAnalysis, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentAnalysisInclude.job({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AnalysisJob>? modelFilter,
    List<AnalysisJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (documentAnalysis) => DocumentAnalysisStore.instance
            .getJob$(documentAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (documentAnalysis) => DocumentAnalysisStore.instance
            .getJob(documentAnalysis, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentAnalysisInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (documentAnalysis) => DocumentAnalysisStore.instance
            .getOrg$(documentAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (documentAnalysis) => DocumentAnalysisStore.instance
            .getOrg(documentAnalysis, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum DocumentAnalysisEndpoints implements Endpoint {

    getAll('/documentAnalysis', HttpMethod.post, List<DocumentAnalysis>),
	getById('/documentAnalysis/byId/:id', HttpMethod.post, DocumentAnalysis),
	getManyByDocumentId('/documentAnalysis/byDocumentId/:documentId', HttpMethod.post, List<DocumentAnalysis>),
	getManyByJobId('/documentAnalysis/byJobId/:jobId', HttpMethod.post, List<DocumentAnalysis>),
	getManyByOrgId('/documentAnalysis/byOrgId/:orgId', HttpMethod.post, List<DocumentAnalysis>),
	getManyByExtractedText('/documentAnalysis/byExtractedText/:extractedText', HttpMethod.post, List<DocumentAnalysis>),
	getManyByMetadata('/documentAnalysis/byMetadata/:metadata', HttpMethod.post, List<DocumentAnalysis>),
	getManyByClassification('/documentAnalysis/byClassification/:classification', HttpMethod.post, List<DocumentAnalysis>),
	getManyByConfidence('/documentAnalysis/byConfidence/:confidence', HttpMethod.post, List<DocumentAnalysis>),
	getManyByProcessingTime('/documentAnalysis/byProcessingTime/:processingTime', HttpMethod.post, List<DocumentAnalysis>),
	getManyByCreatedAt('/documentAnalysis/byCreatedAt/:createdAt', HttpMethod.post, List<DocumentAnalysis>),
	getManyByUpdatedAt('/documentAnalysis/byUpdatedAt/:updatedAt', HttpMethod.post, List<DocumentAnalysis>);

    const DocumentAnalysisEndpoints(this.path, this.method, this.responseType);

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
