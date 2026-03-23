
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIValuationModelStore extends ModelStreamStore<String, AIValuationModel> {

  static AIValuationModelStore? _instance;

  static AIValuationModelStore get instance {
    _instance ??= AIValuationModelStore();
    return _instance!;
  }

  AIValuationModelStore() : super(AIValuationModel.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIValuationModelStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIValuationModelStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIValuationModelStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIValuationModelId(AIValuationModel aIValuationModel) => aIValuationModel.id;

	String? getAIValuationModelOrgId(AIValuationModel aIValuationModel) => aIValuationModel.orgId;

	String? getAIValuationModelModelName(AIValuationModel aIValuationModel) => aIValuationModel.modelName;

	String? getAIValuationModelModelVersion(AIValuationModel aIValuationModel) => aIValuationModel.modelVersion;

	double? getAIValuationModelAccuracy(AIValuationModel aIValuationModel) => aIValuationModel.accuracy;

	DateTime? getAIValuationModelLastTrainedAt(AIValuationModel aIValuationModel) => aIValuationModel.lastTrainedAt;

	dynamic? getAIValuationModelFeatures(AIValuationModel aIValuationModel) => aIValuationModel.features;

	dynamic? getAIValuationModelHyperparameters(AIValuationModel aIValuationModel) => aIValuationModel.hyperparameters;

	dynamic? getAIValuationModelTrainingMetrics(AIValuationModel aIValuationModel) => aIValuationModel.trainingMetrics;

	bool? getAIValuationModelIsActive(AIValuationModel aIValuationModel) => aIValuationModel.isActive;

	DateTime? getAIValuationModelCreatedAt(AIValuationModel aIValuationModel) => aIValuationModel.createdAt;

	DateTime? getAIValuationModelUpdatedAt(AIValuationModel aIValuationModel) => aIValuationModel.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIValuationModel> getByOrgId(
    String orgId,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByModelName(
    String modelName,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelModelName, modelName, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByModelVersion(
    String modelVersion,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelModelVersion, modelVersion, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByAccuracy(
    double accuracy,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelAccuracy, accuracy, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByLastTrainedAt(
    DateTime lastTrainedAt,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelLastTrainedAt, lastTrainedAt, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByFeatures(
    dynamic features,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelFeatures, features, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByHyperparameters(
    dynamic hyperparameters,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelHyperparameters, hyperparameters, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByTrainingMetrics(
    dynamic trainingMetrics,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelTrainingMetrics, trainingMetrics, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByIsActive(
    bool isActive,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AIValuationModel> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}
    ) =>
    getManyIncluding(getAIValuationModelUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIValuationModel aIValuationModel, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIValuationModel.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIValuationModel.orgId!, includes: includes);
        aIValuationModel.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<AIPropertyValuation> getValuations(
    AIValuationModel aIValuationModel, {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}) {
    final valuations = AIPropertyValuationStore.instance.getByModelId(aIValuationModel.$uid!, modelFilter: modelFilter, includes: includes);
    aIValuationModel.valuations = valuations;
    // setIncludedReferencesForList(valuations, includes: includes);
    return valuations;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIValuationModel>> getAll$({bool useCache = true, ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIValuationModelEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIValuationModel?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIValuationModelId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIValuationModel>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIValuationModelOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByModelName$(
        String modelName,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIValuationModelModelName,
        value: modelName,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByModelName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByModelVersion$(
        String modelVersion,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIValuationModelModelVersion,
        value: modelVersion,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByModelVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByAccuracy$(
        double accuracy,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIValuationModelAccuracy,
        value: accuracy,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByAccuracy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByLastTrainedAt$(
        DateTime lastTrainedAt,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIValuationModelLastTrainedAt,
        value: lastTrainedAt,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByLastTrainedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByFeatures$(
        dynamic features,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIValuationModelFeatures,
        value: features,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByHyperparameters$(
        dynamic hyperparameters,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIValuationModelHyperparameters,
        value: hyperparameters,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByHyperparameters,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByTrainingMetrics$(
        dynamic trainingMetrics,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIValuationModelTrainingMetrics,
        value: trainingMetrics,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByTrainingMetrics,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAIValuationModelIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIValuationModelCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIValuationModel>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AIValuationModel>? modelFilter,
        List<AIValuationModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIValuationModelUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AIValuationModelEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIValuationModel aIValuationModel, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIValuationModel.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIValuationModel.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIValuationModel.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AIPropertyValuation>> getValuations$(
    AIValuationModel aIValuationModel, {bool useCache = true, ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}) {
    return AIPropertyValuationStore.instance.getByModelId$(
        aIValuationModel.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((valuations) {
        aIValuationModel.valuations = valuations;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AIValuationModel recursiveUpsert(AIValuationModel aIValuationModel, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIValuationModel'} 
        : const {};
    if (aIValuationModel.valuations != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPropertyValuation'))) {
        aIValuationModel.valuations = AIPropertyValuationStore.instance.recursiveListUpsert(aIValuationModel.valuations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIValuationModel.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIValuationModel.org = OrganizationStore.instance.recursiveUpsert(aIValuationModel.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIValuationModel);
}

  List<AIValuationModel> recursiveListUpsert(List<AIValuationModel> aIValuationModels, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIValuationModels = <AIValuationModel>[];
    for (var aIValuationModel in aIValuationModels) {
        updatedAIValuationModels.add(recursiveUpsert(aIValuationModel, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIValuationModels;
}

//   @override
//   AIValuationModel upsert(AIValuationModel item) {
//     return recursiveUpsert(item);
//   }

}


class AIValuationModelInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIValuationModelInclude.valuations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPropertyValuation>? modelFilter,
    List<AIPropertyValuationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIValuationModel) => AIValuationModelStore.instance
            .getValuations$(aIValuationModel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIValuationModel) => AIValuationModelStore.instance
            .getValuations(aIValuationModel, modelFilter: modelFilter, includes: includes);
      }
}

	AIValuationModelInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIValuationModel) => AIValuationModelStore.instance
            .getOrg$(aIValuationModel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIValuationModel) => AIValuationModelStore.instance
            .getOrg(aIValuationModel, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIValuationModelEndpoints implements Endpoint {

    getAll('/aIValuationModel', HttpMethod.post, List<AIValuationModel>),
	getById('/aIValuationModel/byId/:id', HttpMethod.post, AIValuationModel),
	getManyByOrgId('/aIValuationModel/byOrgId/:orgId', HttpMethod.post, List<AIValuationModel>),
	getManyByModelName('/aIValuationModel/byModelName/:modelName', HttpMethod.post, List<AIValuationModel>),
	getManyByModelVersion('/aIValuationModel/byModelVersion/:modelVersion', HttpMethod.post, List<AIValuationModel>),
	getManyByAccuracy('/aIValuationModel/byAccuracy/:accuracy', HttpMethod.post, List<AIValuationModel>),
	getManyByLastTrainedAt('/aIValuationModel/byLastTrainedAt/:lastTrainedAt', HttpMethod.post, List<AIValuationModel>),
	getManyByFeatures('/aIValuationModel/byFeatures/:features', HttpMethod.post, List<AIValuationModel>),
	getManyByHyperparameters('/aIValuationModel/byHyperparameters/:hyperparameters', HttpMethod.post, List<AIValuationModel>),
	getManyByTrainingMetrics('/aIValuationModel/byTrainingMetrics/:trainingMetrics', HttpMethod.post, List<AIValuationModel>),
	getManyByIsActive('/aIValuationModel/byIsActive/:isActive', HttpMethod.post, List<AIValuationModel>),
	getManyByCreatedAt('/aIValuationModel/byCreatedAt/:createdAt', HttpMethod.post, List<AIValuationModel>),
	getManyByUpdatedAt('/aIValuationModel/byUpdatedAt/:updatedAt', HttpMethod.post, List<AIValuationModel>);

    const AIValuationModelEndpoints(this.path, this.method, this.responseType);

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
