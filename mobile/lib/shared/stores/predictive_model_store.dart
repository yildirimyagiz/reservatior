
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PredictiveModelStore extends ModelStreamStore<String, PredictiveModel> {

  static PredictiveModelStore? _instance;

  static PredictiveModelStore get instance {
    _instance ??= PredictiveModelStore();
    return _instance!;
  }

  PredictiveModelStore() : super(PredictiveModel.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PredictiveModelStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PredictiveModelStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PredictiveModelStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPredictiveModelId(PredictiveModel predictiveModel) => predictiveModel.id;

	String? getPredictiveModelOrgId(PredictiveModel predictiveModel) => predictiveModel.orgId;

	ModelType? getPredictiveModelModelType(PredictiveModel predictiveModel) => predictiveModel.modelType;

	dynamic? getPredictiveModelTrainingData(PredictiveModel predictiveModel) => predictiveModel.trainingData;

	dynamic? getPredictiveModelParameters(PredictiveModel predictiveModel) => predictiveModel.parameters;

	double? getPredictiveModelAccuracy(PredictiveModel predictiveModel) => predictiveModel.accuracy;

	DateTime? getPredictiveModelLastTrained(PredictiveModel predictiveModel) => predictiveModel.lastTrained;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PredictiveModel> getByOrgId(
    String orgId,
    {ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}
    ) =>
    getManyIncluding(getPredictiveModelOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PredictiveModel> getByModelType(
    ModelType modelType,
    {ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}
    ) =>
    getManyIncluding(getPredictiveModelModelType, modelType, modelFilter: modelFilter, includes: includes);

	
List<PredictiveModel> getByTrainingData(
    dynamic trainingData,
    {ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}
    ) =>
    getManyIncluding(getPredictiveModelTrainingData, trainingData, modelFilter: modelFilter, includes: includes);

	
List<PredictiveModel> getByParameters(
    dynamic parameters,
    {ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}
    ) =>
    getManyIncluding(getPredictiveModelParameters, parameters, modelFilter: modelFilter, includes: includes);

	
List<PredictiveModel> getByAccuracy(
    double accuracy,
    {ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}
    ) =>
    getManyIncluding(getPredictiveModelAccuracy, accuracy, modelFilter: modelFilter, includes: includes);

	
List<PredictiveModel> getByLastTrained(
    DateTime lastTrained,
    {ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}
    ) =>
    getManyIncluding(getPredictiveModelLastTrained, lastTrained, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    PredictiveModel predictiveModel, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (predictiveModel.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(predictiveModel.orgId!, includes: includes);
        predictiveModel.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PredictiveModel>> getAll$({bool useCache = true, ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PredictiveModelEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PredictiveModel?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PredictiveModel>? modelFilter,
        List<PredictiveModelInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPredictiveModelId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PredictiveModelEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PredictiveModel>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PredictiveModel>? modelFilter,
        List<PredictiveModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPredictiveModelOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PredictiveModelEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PredictiveModel>> getByModelType$(
        ModelType modelType,
        {bool useCache = true,
        ModelFilter<PredictiveModel>? modelFilter,
        List<PredictiveModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<ModelType>(
        getPropVal: getPredictiveModelModelType,
        value: modelType,
        modelFilter: modelFilter,
        endpoint: PredictiveModelEndpoints.getManyByModelType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PredictiveModel>> getByTrainingData$(
        dynamic trainingData,
        {bool useCache = true,
        ModelFilter<PredictiveModel>? modelFilter,
        List<PredictiveModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPredictiveModelTrainingData,
        value: trainingData,
        modelFilter: modelFilter,
        endpoint: PredictiveModelEndpoints.getManyByTrainingData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PredictiveModel>> getByParameters$(
        dynamic parameters,
        {bool useCache = true,
        ModelFilter<PredictiveModel>? modelFilter,
        List<PredictiveModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPredictiveModelParameters,
        value: parameters,
        modelFilter: modelFilter,
        endpoint: PredictiveModelEndpoints.getManyByParameters,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PredictiveModel>> getByAccuracy$(
        double accuracy,
        {bool useCache = true,
        ModelFilter<PredictiveModel>? modelFilter,
        List<PredictiveModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPredictiveModelAccuracy,
        value: accuracy,
        modelFilter: modelFilter,
        endpoint: PredictiveModelEndpoints.getManyByAccuracy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PredictiveModel>> getByLastTrained$(
        DateTime lastTrained,
        {bool useCache = true,
        ModelFilter<PredictiveModel>? modelFilter,
        List<PredictiveModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPredictiveModelLastTrained,
        value: lastTrained,
        modelFilter: modelFilter,
        endpoint: PredictiveModelEndpoints.getManyByLastTrained,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    PredictiveModel predictiveModel, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (predictiveModel.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            predictiveModel.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            predictiveModel.org = org;
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
PredictiveModel recursiveUpsert(PredictiveModel predictiveModel, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PredictiveModel'} 
        : const {};
    if (predictiveModel.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        predictiveModel.org = OrganizationStore.instance.recursiveUpsert(predictiveModel.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(predictiveModel);
}

  List<PredictiveModel> recursiveListUpsert(List<PredictiveModel> predictiveModels, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPredictiveModels = <PredictiveModel>[];
    for (var predictiveModel in predictiveModels) {
        updatedPredictiveModels.add(recursiveUpsert(predictiveModel, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPredictiveModels;
}

//   @override
//   PredictiveModel upsert(PredictiveModel item) {
//     return recursiveUpsert(item);
//   }

}


class PredictiveModelInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PredictiveModelInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (predictiveModel) => PredictiveModelStore.instance
            .getOrg$(predictiveModel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (predictiveModel) => PredictiveModelStore.instance
            .getOrg(predictiveModel, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PredictiveModelEndpoints implements Endpoint {

    getAll('/predictiveModel', HttpMethod.post, List<PredictiveModel>),
	getById('/predictiveModel/byId/:id', HttpMethod.post, PredictiveModel),
	getManyByOrgId('/predictiveModel/byOrgId/:orgId', HttpMethod.post, List<PredictiveModel>),
	getManyByModelType('/predictiveModel/byModelType/:modelType', HttpMethod.post, List<PredictiveModel>),
	getManyByTrainingData('/predictiveModel/byTrainingData/:trainingData', HttpMethod.post, List<PredictiveModel>),
	getManyByParameters('/predictiveModel/byParameters/:parameters', HttpMethod.post, List<PredictiveModel>),
	getManyByAccuracy('/predictiveModel/byAccuracy/:accuracy', HttpMethod.post, List<PredictiveModel>),
	getManyByLastTrained('/predictiveModel/byLastTrained/:lastTrained', HttpMethod.post, List<PredictiveModel>);

    const PredictiveModelEndpoints(this.path, this.method, this.responseType);

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
