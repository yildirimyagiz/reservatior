
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MLModelStore extends ModelStreamStore<String, MLModel> {

  static MLModelStore? _instance;

  static MLModelStore get instance {
    _instance ??= MLModelStore();
    return _instance!;
  }

  MLModelStore() : super(MLModel.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MLModelStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MLModelStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MLModelStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMLModelId(MLModel mLModel) => mLModel.id;

	String? getMLModelModelName(MLModel mLModel) => mLModel.modelName;

	String? getMLModelModelType(MLModel mLModel) => mLModel.modelType;

	String? getMLModelVersion(MLModel mLModel) => mLModel.version;

	double? getMLModelAccuracy(MLModel mLModel) => mLModel.accuracy;

	dynamic? getMLModelTrainingData(MLModel mLModel) => mLModel.trainingData;

	String? getMLModelModelPath(MLModel mLModel) => mLModel.modelPath;

	bool? getMLModelIsActive(MLModel mLModel) => mLModel.isActive;

	DateTime? getMLModelCreatedAt(MLModel mLModel) => mLModel.createdAt;

	DateTime? getMLModelUpdatedAt(MLModel mLModel) => mLModel.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MLModel> getByModelName(
    String modelName,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelModelName, modelName, modelFilter: modelFilter, includes: includes);

	
List<MLModel> getByModelType(
    String modelType,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelModelType, modelType, modelFilter: modelFilter, includes: includes);

	
List<MLModel> getByVersion(
    String version,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelVersion, version, modelFilter: modelFilter, includes: includes);

	
List<MLModel> getByAccuracy(
    double accuracy,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelAccuracy, accuracy, modelFilter: modelFilter, includes: includes);

	
List<MLModel> getByTrainingData(
    dynamic trainingData,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelTrainingData, trainingData, modelFilter: modelFilter, includes: includes);

	
List<MLModel> getByModelPath(
    String modelPath,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelModelPath, modelPath, modelFilter: modelFilter, includes: includes);

	
List<MLModel> getByIsActive(
    bool isActive,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<MLModel> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MLModel> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}
    ) =>
    getManyIncluding(getMLModelUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MLModel>> getAll$({bool useCache = true, ModelFilter<MLModel>? modelFilter, List<MLModelInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MLModelEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MLModel?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMLModelId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MLModel>> getByModelName$(
        String modelName,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLModelModelName,
        value: modelName,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByModelName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLModel>> getByModelType$(
        String modelType,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLModelModelType,
        value: modelType,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByModelType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLModel>> getByVersion$(
        String version,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLModelVersion,
        value: version,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLModel>> getByAccuracy$(
        double accuracy,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMLModelAccuracy,
        value: accuracy,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByAccuracy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLModel>> getByTrainingData$(
        dynamic trainingData,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMLModelTrainingData,
        value: trainingData,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByTrainingData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLModel>> getByModelPath$(
        String modelPath,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLModelModelPath,
        value: modelPath,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByModelPath,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLModel>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMLModelIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLModel>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLModelCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLModel>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MLModel>? modelFilter,
        List<MLModelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLModelUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MLModelEndpoints.getManyByUpdatedAt,
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
MLModel recursiveUpsert(MLModel mLModel, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MLModel'} 
        : const {};
    
    return super.upsert(mLModel);
}

  List<MLModel> recursiveListUpsert(List<MLModel> mLModels, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMLModels = <MLModel>[];
    for (var mLModel in mLModels) {
        updatedMLModels.add(recursiveUpsert(mLModel, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMLModels;
}

//   @override
//   MLModel upsert(MLModel item) {
//     return recursiveUpsert(item);
//   }

}


class MLModelInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MLModelInclude.empty({this.useCache = true, this.useAsync = true});
  }


enum MLModelEndpoints implements Endpoint {

    getAll('/mLModel', HttpMethod.post, List<MLModel>),
	getById('/mLModel/byId/:id', HttpMethod.post, MLModel),
	getManyByModelName('/mLModel/byModelName/:modelName', HttpMethod.post, List<MLModel>),
	getManyByModelType('/mLModel/byModelType/:modelType', HttpMethod.post, List<MLModel>),
	getManyByVersion('/mLModel/byVersion/:version', HttpMethod.post, List<MLModel>),
	getManyByAccuracy('/mLModel/byAccuracy/:accuracy', HttpMethod.post, List<MLModel>),
	getManyByTrainingData('/mLModel/byTrainingData/:trainingData', HttpMethod.post, List<MLModel>),
	getManyByModelPath('/mLModel/byModelPath/:modelPath', HttpMethod.post, List<MLModel>),
	getManyByIsActive('/mLModel/byIsActive/:isActive', HttpMethod.post, List<MLModel>),
	getManyByCreatedAt('/mLModel/byCreatedAt/:createdAt', HttpMethod.post, List<MLModel>),
	getManyByUpdatedAt('/mLModel/byUpdatedAt/:updatedAt', HttpMethod.post, List<MLModel>);

    const MLModelEndpoints(this.path, this.method, this.responseType);

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
