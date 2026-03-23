
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIModelStore extends ModelStreamStore<String, AIModel> {

  static AIModelStore? _instance;

  static AIModelStore get instance {
    _instance ??= AIModelStore();
    return _instance!;
  }

  AIModelStore() : super(AIModel.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIModelStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIModelStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIModelStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIModelId(AIModel aIModel) => aIModel.id;

	String? getAIModelOrgId(AIModel aIModel) => aIModel.orgId;

	String? getAIModelModelName(AIModel aIModel) => aIModel.modelName;

	String? getAIModelModelVersion(AIModel aIModel) => aIModel.modelVersion;

	String? getAIModelModelType(AIModel aIModel) => aIModel.modelType;

	String? getAIModelProvider(AIModel aIModel) => aIModel.provider;

	String? getAIModelEndpointUrl(AIModel aIModel) => aIModel.endpointUrl;

	String? getAIModelApiKey(AIModel aIModel) => aIModel.apiKey;

	String? getAIModelStatus(AIModel aIModel) => aIModel.status;

	double? getAIModelAccuracy(AIModel aIModel) => aIModel.accuracy;

	DateTime? getAIModelLastTrainedAt(AIModel aIModel) => aIModel.lastTrainedAt;

	dynamic? getAIModelConfig(AIModel aIModel) => aIModel.config;

	dynamic? getAIModelMetadata(AIModel aIModel) => aIModel.metadata;

	DateTime? getAIModelCreatedAt(AIModel aIModel) => aIModel.createdAt;

	DateTime? getAIModelUpdatedAt(AIModel aIModel) => aIModel.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIModel> getByOrgId(
    String orgId,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByModelName(
    String modelName,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelModelName, modelName, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByModelVersion(
    String modelVersion,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelModelVersion, modelVersion, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByModelType(
    String modelType,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelModelType, modelType, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByProvider(
    String provider,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelProvider, provider, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByEndpointUrl(
    String endpointUrl,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelEndpointUrl, endpointUrl, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByApiKey(
    String apiKey,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelApiKey, apiKey, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByStatus(
    String status,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByAccuracy(
    double accuracy,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelAccuracy, accuracy, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByLastTrainedAt(
    DateTime lastTrainedAt,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelLastTrainedAt, lastTrainedAt, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByConfig(
    dynamic config,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelConfig, config, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByMetadata(
    dynamic metadata,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelMetadata, metadata, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AIModel> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}
    ) =>
    getManyIncluding(getAIModelUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIModel aIModel, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIModel.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIModel.orgId!, includes: includes);
        aIModel.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<AIModelDeployment> getDeployments(
    AIModel aIModel, {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}) {
    final deployments = AIModelDeploymentStore.instance.getByModelId(aIModel.$uid!, modelFilter: modelFilter, includes: includes);
    aIModel.deployments = deployments;
    // setIncludedReferencesForList(deployments, includes: includes);
    return deployments;
}

	List<AIPrediction> getPredictions(
    AIModel aIModel, {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}) {
    final predictions = AIPredictionStore.instance.getByModelId(aIModel.$uid!, modelFilter: modelFilter, includes: includes);
    aIModel.predictions = predictions;
    // setIncludedReferencesForList(predictions, includes: includes);
    return predictions;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIModel>> getAll$({bool useCache = true, ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIModelEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIModel?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIModelId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIModel>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByModelName$(
        String modelName,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelModelName,
        value: modelName,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByModelName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByModelVersion$(
        String modelVersion,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelModelVersion,
        value: modelVersion,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByModelVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByModelType$(
        String modelType,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelModelType,
        value: modelType,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByModelType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByProvider$(
        String provider,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelProvider,
        value: provider,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByEndpointUrl$(
        String endpointUrl,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelEndpointUrl,
        value: endpointUrl,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByEndpointUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByApiKey$(
        String apiKey,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelApiKey,
        value: apiKey,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByApiKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByAccuracy$(
        double accuracy,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIModelAccuracy,
        value: accuracy,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByAccuracy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByLastTrainedAt$(
        DateTime lastTrainedAt,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIModelLastTrainedAt,
        value: lastTrainedAt,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByLastTrainedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByConfig$(
        dynamic config,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIModelConfig,
        value: config,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByMetadata$(
        dynamic metadata,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIModelMetadata,
        value: metadata,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIModelCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModel>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AIModel>? modelFilter,
        List<AIModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIModelUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AIModelEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIModel aIModel, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIModel.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIModel.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIModel.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AIModelDeployment>> getDeployments$(
    AIModel aIModel, {bool useCache = true, ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}) {
    return AIModelDeploymentStore.instance.getByModelId$(
        aIModel.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((deployments) {
        aIModel.deployments = deployments;
    });

}

	Stream<List<AIPrediction>> getPredictions$(
    AIModel aIModel, {bool useCache = true, ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}) {
    return AIPredictionStore.instance.getByModelId$(
        aIModel.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((predictions) {
        aIModel.predictions = predictions;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AIModel recursiveUpsert(AIModel aIModel, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIModel'} 
        : const {};
    if (aIModel.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIModel.org = OrganizationStore.instance.recursiveUpsert(aIModel.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIModel.deployments != null && (!preventCircularSerialization || !upsertedTypes.contains('AIModelDeployment'))) {
        aIModel.deployments = AIModelDeploymentStore.instance.recursiveListUpsert(aIModel.deployments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIModel.predictions != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPrediction'))) {
        aIModel.predictions = AIPredictionStore.instance.recursiveListUpsert(aIModel.predictions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIModel);
}

  List<AIModel> recursiveListUpsert(List<AIModel> aIModels, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIModels = <AIModel>[];
    for (var aIModel in aIModels) {
        updatedAIModels.add(recursiveUpsert(aIModel, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIModels;
}

//   @override
//   AIModel upsert(AIModel item) {
//     return recursiveUpsert(item);
//   }

}


class AIModelInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIModelInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIModel) => AIModelStore.instance
            .getOrg$(aIModel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIModel) => AIModelStore.instance
            .getOrg(aIModel, modelFilter: modelFilter, includes: includes);
      }
}

	AIModelInclude.deployments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIModelDeployment>? modelFilter,
    List<AIModelDeploymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIModel) => AIModelStore.instance
            .getDeployments$(aIModel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIModel) => AIModelStore.instance
            .getDeployments(aIModel, modelFilter: modelFilter, includes: includes);
      }
}

	AIModelInclude.predictions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPrediction>? modelFilter,
    List<AIPredictionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIModel) => AIModelStore.instance
            .getPredictions$(aIModel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIModel) => AIModelStore.instance
            .getPredictions(aIModel, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIModelEndpoints implements Endpoint {

    getAll('/aIModel', HttpMethod.post, List<AIModel>),
	getById('/aIModel/byId/:id', HttpMethod.post, AIModel),
	getManyByOrgId('/aIModel/byOrgId/:orgId', HttpMethod.post, List<AIModel>),
	getManyByModelName('/aIModel/byModelName/:modelName', HttpMethod.post, List<AIModel>),
	getManyByModelVersion('/aIModel/byModelVersion/:modelVersion', HttpMethod.post, List<AIModel>),
	getManyByModelType('/aIModel/byModelType/:modelType', HttpMethod.post, List<AIModel>),
	getManyByProvider('/aIModel/byProvider/:provider', HttpMethod.post, List<AIModel>),
	getManyByEndpointUrl('/aIModel/byEndpointUrl/:endpointUrl', HttpMethod.post, List<AIModel>),
	getManyByApiKey('/aIModel/byApiKey/:apiKey', HttpMethod.post, List<AIModel>),
	getManyByStatus('/aIModel/byStatus/:status', HttpMethod.post, List<AIModel>),
	getManyByAccuracy('/aIModel/byAccuracy/:accuracy', HttpMethod.post, List<AIModel>),
	getManyByLastTrainedAt('/aIModel/byLastTrainedAt/:lastTrainedAt', HttpMethod.post, List<AIModel>),
	getManyByConfig('/aIModel/byConfig/:config', HttpMethod.post, List<AIModel>),
	getManyByMetadata('/aIModel/byMetadata/:metadata', HttpMethod.post, List<AIModel>),
	getManyByCreatedAt('/aIModel/byCreatedAt/:createdAt', HttpMethod.post, List<AIModel>),
	getManyByUpdatedAt('/aIModel/byUpdatedAt/:updatedAt', HttpMethod.post, List<AIModel>);

    const AIModelEndpoints(this.path, this.method, this.responseType);

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
