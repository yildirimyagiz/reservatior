
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MLConfigurationStore extends ModelStreamStore<String, MLConfiguration> {

  static MLConfigurationStore? _instance;

  static MLConfigurationStore get instance {
    _instance ??= MLConfigurationStore();
    return _instance!;
  }

  MLConfigurationStore() : super(MLConfiguration.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MLConfigurationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MLConfigurationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MLConfigurationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMLConfigurationId(MLConfiguration mLConfiguration) => mLConfiguration.id;

	bool? getMLConfigurationEnableAutoTagging(MLConfiguration mLConfiguration) => mLConfiguration.enableAutoTagging;

	double? getMLConfigurationQualityThreshold(MLConfiguration mLConfiguration) => mLConfiguration.qualityThreshold;

	bool? getMLConfigurationEnableMLFeatures(MLConfiguration mLConfiguration) => mLConfiguration.enableMLFeatures;

	int? getMLConfigurationMaxTagsPerImage(MLConfiguration mLConfiguration) => mLConfiguration.maxTagsPerImage;

	String? getMLConfigurationAnalysisMode(MLConfiguration mLConfiguration) => mLConfiguration.analysisMode;

	List<String>? getMLConfigurationAllowedModels(MLConfiguration mLConfiguration) => mLConfiguration.allowedModels;

	dynamic? getMLConfigurationCustomSettings(MLConfiguration mLConfiguration) => mLConfiguration.customSettings;

	String? getMLConfigurationUpdatedBy(MLConfiguration mLConfiguration) => mLConfiguration.updatedBy;

	int? getMLConfigurationVersion(MLConfiguration mLConfiguration) => mLConfiguration.version;

	DateTime? getMLConfigurationCreatedAt(MLConfiguration mLConfiguration) => mLConfiguration.createdAt;

	DateTime? getMLConfigurationUpdatedAt(MLConfiguration mLConfiguration) => mLConfiguration.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MLConfiguration> getByEnableAutoTagging(
    bool enableAutoTagging,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationEnableAutoTagging, enableAutoTagging, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByQualityThreshold(
    double qualityThreshold,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationQualityThreshold, qualityThreshold, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByEnableMLFeatures(
    bool enableMLFeatures,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationEnableMLFeatures, enableMLFeatures, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByMaxTagsPerImage(
    int maxTagsPerImage,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationMaxTagsPerImage, maxTagsPerImage, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByAnalysisMode(
    String analysisMode,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationAnalysisMode, analysisMode, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByAllowedModels(
    String allowedModels,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationAllowedModels, allowedModels, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByCustomSettings(
    dynamic customSettings,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationCustomSettings, customSettings, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByUpdatedBy(
    String updatedBy,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationUpdatedBy, updatedBy, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByVersion(
    int version,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationVersion, version, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MLConfiguration> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getMLConfigurationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MLConfiguration>> getAll$({bool useCache = true, ModelFilter<MLConfiguration>? modelFilter, List<MLConfigurationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MLConfigurationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MLConfiguration?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMLConfigurationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MLConfiguration>> getByEnableAutoTagging$(
        bool enableAutoTagging,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMLConfigurationEnableAutoTagging,
        value: enableAutoTagging,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByEnableAutoTagging,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByQualityThreshold$(
        double qualityThreshold,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMLConfigurationQualityThreshold,
        value: qualityThreshold,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByQualityThreshold,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByEnableMLFeatures$(
        bool enableMLFeatures,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMLConfigurationEnableMLFeatures,
        value: enableMLFeatures,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByEnableMLFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByMaxTagsPerImage$(
        int maxTagsPerImage,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMLConfigurationMaxTagsPerImage,
        value: maxTagsPerImage,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByMaxTagsPerImage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByAnalysisMode$(
        String analysisMode,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLConfigurationAnalysisMode,
        value: analysisMode,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByAnalysisMode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByAllowedModels$(
        String allowedModels,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLConfigurationAllowedModels,
        value: allowedModels,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByAllowedModels,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByCustomSettings$(
        dynamic customSettings,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMLConfigurationCustomSettings,
        value: customSettings,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByCustomSettings,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByUpdatedBy$(
        String updatedBy,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMLConfigurationUpdatedBy,
        value: updatedBy,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByUpdatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByVersion$(
        int version,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMLConfigurationVersion,
        value: version,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLConfigurationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MLConfiguration>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MLConfiguration>? modelFilter,
        List<MLConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMLConfigurationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MLConfigurationEndpoints.getManyByUpdatedAt,
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
MLConfiguration recursiveUpsert(MLConfiguration mLConfiguration, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MLConfiguration'} 
        : const {};
    
    return super.upsert(mLConfiguration);
}

  List<MLConfiguration> recursiveListUpsert(List<MLConfiguration> mLConfigurations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMLConfigurations = <MLConfiguration>[];
    for (var mLConfiguration in mLConfigurations) {
        updatedMLConfigurations.add(recursiveUpsert(mLConfiguration, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMLConfigurations;
}

//   @override
//   MLConfiguration upsert(MLConfiguration item) {
//     return recursiveUpsert(item);
//   }

}


class MLConfigurationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MLConfigurationInclude.empty({this.useCache = true, this.useAsync = true});
  }


enum MLConfigurationEndpoints implements Endpoint {

    getAll('/mLConfiguration', HttpMethod.post, List<MLConfiguration>),
	getById('/mLConfiguration/byId/:id', HttpMethod.post, MLConfiguration),
	getManyByEnableAutoTagging('/mLConfiguration/byEnableAutoTagging/:enableAutoTagging', HttpMethod.post, List<MLConfiguration>),
	getManyByQualityThreshold('/mLConfiguration/byQualityThreshold/:qualityThreshold', HttpMethod.post, List<MLConfiguration>),
	getManyByEnableMLFeatures('/mLConfiguration/byEnableMLFeatures/:enableMLFeatures', HttpMethod.post, List<MLConfiguration>),
	getManyByMaxTagsPerImage('/mLConfiguration/byMaxTagsPerImage/:maxTagsPerImage', HttpMethod.post, List<MLConfiguration>),
	getManyByAnalysisMode('/mLConfiguration/byAnalysisMode/:analysisMode', HttpMethod.post, List<MLConfiguration>),
	getManyByAllowedModels('/mLConfiguration/byAllowedModels/:allowedModels', HttpMethod.post, List<MLConfiguration>),
	getManyByCustomSettings('/mLConfiguration/byCustomSettings/:customSettings', HttpMethod.post, List<MLConfiguration>),
	getManyByUpdatedBy('/mLConfiguration/byUpdatedBy/:updatedBy', HttpMethod.post, List<MLConfiguration>),
	getManyByVersion('/mLConfiguration/byVersion/:version', HttpMethod.post, List<MLConfiguration>),
	getManyByCreatedAt('/mLConfiguration/byCreatedAt/:createdAt', HttpMethod.post, List<MLConfiguration>),
	getManyByUpdatedAt('/mLConfiguration/byUpdatedAt/:updatedAt', HttpMethod.post, List<MLConfiguration>);

    const MLConfigurationEndpoints(this.path, this.method, this.responseType);

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
