
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIPredictionStore extends ModelStreamStore<String, AIPrediction> {

  static AIPredictionStore? _instance;

  static AIPredictionStore get instance {
    _instance ??= AIPredictionStore();
    return _instance!;
  }

  AIPredictionStore() : super(AIPrediction.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIPredictionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIPredictionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIPredictionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIPredictionId(AIPrediction aIPrediction) => aIPrediction.id;

	String? getAIPredictionOrgId(AIPrediction aIPrediction) => aIPrediction.orgId;

	String? getAIPredictionModelId(AIPrediction aIPrediction) => aIPrediction.modelId;

	String? getAIPredictionRequestId(AIPrediction aIPrediction) => aIPrediction.requestId;

	String? getAIPredictionBatchId(AIPrediction aIPrediction) => aIPrediction.batchId;

	String? getAIPredictionModelType(AIPrediction aIPrediction) => aIPrediction.modelType;

	dynamic? getAIPredictionInputData(AIPrediction aIPrediction) => aIPrediction.inputData;

	dynamic? getAIPredictionOutputData(AIPrediction aIPrediction) => aIPrediction.outputData;

	dynamic? getAIPredictionResult(AIPrediction aIPrediction) => aIPrediction.result;

	double? getAIPredictionConfidence(AIPrediction aIPrediction) => aIPrediction.confidence;

	int? getAIPredictionProcessingTimeMs(AIPrediction aIPrediction) => aIPrediction.processingTimeMs;

	int? getAIPredictionProcessingTime(AIPrediction aIPrediction) => aIPrediction.processingTime;

	String? getAIPredictionStatus(AIPrediction aIPrediction) => aIPrediction.status;

	bool? getAIPredictionSuccess(AIPrediction aIPrediction) => aIPrediction.success;

	String? getAIPredictionErrorMessage(AIPrediction aIPrediction) => aIPrediction.errorMessage;

	String? getAIPredictionUserId(AIPrediction aIPrediction) => aIPrediction.userId;

	String? getAIPredictionPropertyId(AIPrediction aIPrediction) => aIPrediction.propertyId;

	dynamic? getAIPredictionMetadata(AIPrediction aIPrediction) => aIPrediction.metadata;

	DateTime? getAIPredictionCreatedAt(AIPrediction aIPrediction) => aIPrediction.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIPrediction> getByOrgId(
    String orgId,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByModelId(
    String modelId,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionModelId, modelId, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByRequestId(
    String requestId,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionRequestId, requestId, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByBatchId(
    String batchId,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionBatchId, batchId, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByModelType(
    String modelType,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionModelType, modelType, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByInputData(
    dynamic inputData,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionInputData, inputData, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByOutputData(
    dynamic outputData,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionOutputData, outputData, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByResult(
    dynamic result,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionResult, result, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByConfidence(
    double confidence,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByProcessingTimeMs(
    int processingTimeMs,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionProcessingTimeMs, processingTimeMs, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByProcessingTime(
    int processingTime,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionProcessingTime, processingTime, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByStatus(
    String status,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getBySuccess(
    bool success,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionSuccess, success, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByErrorMessage(
    String errorMessage,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionErrorMessage, errorMessage, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByUserId(
    String userId,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByPropertyId(
    String propertyId,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByMetadata(
    dynamic metadata,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionMetadata, metadata, modelFilter: modelFilter, includes: includes);

	
List<AIPrediction> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  AIModel? getModel(
    AIPrediction aIPrediction, {ModelFilter? modelFilter, List<AIModelInclude>? includes}) {
    if (aIPrediction.modelId == null) {
        return null;
    } else {
        final model = AIModelStore.instance.getById(aIPrediction.modelId!, includes: includes);
        aIPrediction.model = model;
        // setIncludedReferences(model, includes: includes);
        return model;
    }
}

	Organization? getOrg(
    AIPrediction aIPrediction, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPrediction.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIPrediction.orgId!, includes: includes);
        aIPrediction.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIPrediction>> getAll$({bool useCache = true, ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIPredictionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIPrediction?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIPredictionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIPrediction>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByModelId$(
        String modelId,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionModelId,
        value: modelId,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByModelId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByRequestId$(
        String requestId,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionRequestId,
        value: requestId,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByRequestId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByBatchId$(
        String batchId,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionBatchId,
        value: batchId,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByBatchId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByModelType$(
        String modelType,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionModelType,
        value: modelType,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByModelType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByInputData$(
        dynamic inputData,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPredictionInputData,
        value: inputData,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByInputData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByOutputData$(
        dynamic outputData,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPredictionOutputData,
        value: outputData,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByOutputData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByResult$(
        dynamic result,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPredictionResult,
        value: result,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByResult,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPredictionConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByProcessingTimeMs$(
        int processingTimeMs,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAIPredictionProcessingTimeMs,
        value: processingTimeMs,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByProcessingTimeMs,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByProcessingTime$(
        int processingTime,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAIPredictionProcessingTime,
        value: processingTime,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByProcessingTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getBySuccess$(
        bool success,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAIPredictionSuccess,
        value: success,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyBySuccess,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByErrorMessage$(
        String errorMessage,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionErrorMessage,
        value: errorMessage,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByErrorMessage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictionPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByMetadata$(
        dynamic metadata,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPredictionMetadata,
        value: metadata,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPrediction>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIPrediction>? modelFilter,
        List<AIPredictionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPredictionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIPredictionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<AIModel?> getModel$(
    AIPrediction aIPrediction, {bool useCache = true, ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}) {
    if (aIPrediction.modelId == null) {
        return Stream.value(null);
    } else {
        return AIModelStore.instance.getById$(
            aIPrediction.modelId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((model) {
            aIPrediction.model = model;
        });
    }
}

	Stream<Organization?> getOrg$(
    AIPrediction aIPrediction, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPrediction.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIPrediction.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIPrediction.org = org;
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
AIPrediction recursiveUpsert(AIPrediction aIPrediction, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIPrediction'} 
        : const {};
    if (aIPrediction.model != null && (!preventCircularSerialization || !upsertedTypes.contains('AIModel'))) {
        aIPrediction.model = AIModelStore.instance.recursiveUpsert(aIPrediction.model!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIPrediction.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIPrediction.org = OrganizationStore.instance.recursiveUpsert(aIPrediction.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIPrediction);
}

  List<AIPrediction> recursiveListUpsert(List<AIPrediction> aIPredictions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIPredictions = <AIPrediction>[];
    for (var aIPrediction in aIPredictions) {
        updatedAIPredictions.add(recursiveUpsert(aIPrediction, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIPredictions;
}

//   @override
//   AIPrediction upsert(AIPrediction item) {
//     return recursiveUpsert(item);
//   }

}


class AIPredictionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIPredictionInclude.model({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIModel>? modelFilter,
    List<AIModelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPrediction) => AIPredictionStore.instance
            .getModel$(aIPrediction, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPrediction) => AIPredictionStore.instance
            .getModel(aIPrediction, modelFilter: modelFilter, includes: includes);
      }
}

	AIPredictionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPrediction) => AIPredictionStore.instance
            .getOrg$(aIPrediction, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPrediction) => AIPredictionStore.instance
            .getOrg(aIPrediction, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIPredictionEndpoints implements Endpoint {

    getAll('/aIPrediction', HttpMethod.post, List<AIPrediction>),
	getById('/aIPrediction/byId/:id', HttpMethod.post, AIPrediction),
	getManyByOrgId('/aIPrediction/byOrgId/:orgId', HttpMethod.post, List<AIPrediction>),
	getManyByModelId('/aIPrediction/byModelId/:modelId', HttpMethod.post, List<AIPrediction>),
	getManyByRequestId('/aIPrediction/byRequestId/:requestId', HttpMethod.post, List<AIPrediction>),
	getManyByBatchId('/aIPrediction/byBatchId/:batchId', HttpMethod.post, List<AIPrediction>),
	getManyByModelType('/aIPrediction/byModelType/:modelType', HttpMethod.post, List<AIPrediction>),
	getManyByInputData('/aIPrediction/byInputData/:inputData', HttpMethod.post, List<AIPrediction>),
	getManyByOutputData('/aIPrediction/byOutputData/:outputData', HttpMethod.post, List<AIPrediction>),
	getManyByResult('/aIPrediction/byResult/:result', HttpMethod.post, List<AIPrediction>),
	getManyByConfidence('/aIPrediction/byConfidence/:confidence', HttpMethod.post, List<AIPrediction>),
	getManyByProcessingTimeMs('/aIPrediction/byProcessingTimeMs/:processingTimeMs', HttpMethod.post, List<AIPrediction>),
	getManyByProcessingTime('/aIPrediction/byProcessingTime/:processingTime', HttpMethod.post, List<AIPrediction>),
	getManyByStatus('/aIPrediction/byStatus/:status', HttpMethod.post, List<AIPrediction>),
	getManyBySuccess('/aIPrediction/bySuccess/:success', HttpMethod.post, List<AIPrediction>),
	getManyByErrorMessage('/aIPrediction/byErrorMessage/:errorMessage', HttpMethod.post, List<AIPrediction>),
	getManyByUserId('/aIPrediction/byUserId/:userId', HttpMethod.post, List<AIPrediction>),
	getManyByPropertyId('/aIPrediction/byPropertyId/:propertyId', HttpMethod.post, List<AIPrediction>),
	getManyByMetadata('/aIPrediction/byMetadata/:metadata', HttpMethod.post, List<AIPrediction>),
	getManyByCreatedAt('/aIPrediction/byCreatedAt/:createdAt', HttpMethod.post, List<AIPrediction>);

    const AIPredictionEndpoints(this.path, this.method, this.responseType);

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
