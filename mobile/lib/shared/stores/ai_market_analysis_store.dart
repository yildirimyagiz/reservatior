
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIMarketAnalysisStore extends ModelStreamStore<String, AIMarketAnalysis> {

  static AIMarketAnalysisStore? _instance;

  static AIMarketAnalysisStore get instance {
    _instance ??= AIMarketAnalysisStore();
    return _instance!;
  }

  AIMarketAnalysisStore() : super(AIMarketAnalysis.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIMarketAnalysisStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIMarketAnalysisStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIMarketAnalysisStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIMarketAnalysisId(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.id;

	String? getAIMarketAnalysisOrgId(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.orgId;

	String? getAIMarketAnalysisAnalysisType(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.analysisType;

	String? getAIMarketAnalysisLocation(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.location;

	String? getAIMarketAnalysisAnalysisPeriod(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.analysisPeriod;

	dynamic? getAIMarketAnalysisDataPoints(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.dataPoints;

	dynamic? getAIMarketAnalysisPredictions(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.predictions;

	dynamic? getAIMarketAnalysisInsights(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.insights;

	double? getAIMarketAnalysisConfidence(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.confidence;

	DateTime? getAIMarketAnalysisGeneratedAt(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.generatedAt;

	String? getAIMarketAnalysisStatus(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.status;

	DateTime? getAIMarketAnalysisCreatedAt(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.createdAt;

	DateTime? getAIMarketAnalysisUpdatedAt(AIMarketAnalysis aIMarketAnalysis) => aIMarketAnalysis.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIMarketAnalysis> getByOrgId(
    String orgId,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByAnalysisType(
    String analysisType,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisAnalysisType, analysisType, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByLocation(
    String location,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisLocation, location, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByAnalysisPeriod(
    String analysisPeriod,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisAnalysisPeriod, analysisPeriod, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByDataPoints(
    dynamic dataPoints,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisDataPoints, dataPoints, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByPredictions(
    dynamic predictions,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisPredictions, predictions, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByInsights(
    dynamic insights,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisInsights, insights, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByConfidence(
    double confidence,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByGeneratedAt(
    DateTime generatedAt,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisGeneratedAt, generatedAt, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByStatus(
    String status,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AIMarketAnalysis> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIMarketAnalysisUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIMarketAnalysis aIMarketAnalysis, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIMarketAnalysis.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIMarketAnalysis.orgId!, includes: includes);
        aIMarketAnalysis.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIMarketAnalysis>> getAll$({bool useCache = true, ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIMarketAnalysisEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIMarketAnalysis?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIMarketAnalysisId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIMarketAnalysis>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIMarketAnalysisOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByAnalysisType$(
        String analysisType,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIMarketAnalysisAnalysisType,
        value: analysisType,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByAnalysisType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByLocation$(
        String location,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIMarketAnalysisLocation,
        value: location,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByLocation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByAnalysisPeriod$(
        String analysisPeriod,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIMarketAnalysisAnalysisPeriod,
        value: analysisPeriod,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByAnalysisPeriod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByDataPoints$(
        dynamic dataPoints,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIMarketAnalysisDataPoints,
        value: dataPoints,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByDataPoints,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByPredictions$(
        dynamic predictions,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIMarketAnalysisPredictions,
        value: predictions,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByPredictions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByInsights$(
        dynamic insights,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIMarketAnalysisInsights,
        value: insights,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByInsights,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIMarketAnalysisConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByGeneratedAt$(
        DateTime generatedAt,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIMarketAnalysisGeneratedAt,
        value: generatedAt,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByGeneratedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIMarketAnalysisStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIMarketAnalysisCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIMarketAnalysis>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AIMarketAnalysis>? modelFilter,
        List<AIMarketAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIMarketAnalysisUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AIMarketAnalysisEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIMarketAnalysis aIMarketAnalysis, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIMarketAnalysis.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIMarketAnalysis.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIMarketAnalysis.org = org;
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
AIMarketAnalysis recursiveUpsert(AIMarketAnalysis aIMarketAnalysis, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIMarketAnalysis'} 
        : const {};
    if (aIMarketAnalysis.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIMarketAnalysis.org = OrganizationStore.instance.recursiveUpsert(aIMarketAnalysis.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIMarketAnalysis);
}

  List<AIMarketAnalysis> recursiveListUpsert(List<AIMarketAnalysis> aIMarketAnalysiss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIMarketAnalysiss = <AIMarketAnalysis>[];
    for (var aIMarketAnalysis in aIMarketAnalysiss) {
        updatedAIMarketAnalysiss.add(recursiveUpsert(aIMarketAnalysis, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIMarketAnalysiss;
}

//   @override
//   AIMarketAnalysis upsert(AIMarketAnalysis item) {
//     return recursiveUpsert(item);
//   }

}


class AIMarketAnalysisInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIMarketAnalysisInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIMarketAnalysis) => AIMarketAnalysisStore.instance
            .getOrg$(aIMarketAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIMarketAnalysis) => AIMarketAnalysisStore.instance
            .getOrg(aIMarketAnalysis, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIMarketAnalysisEndpoints implements Endpoint {

    getAll('/aIMarketAnalysis', HttpMethod.post, List<AIMarketAnalysis>),
	getById('/aIMarketAnalysis/byId/:id', HttpMethod.post, AIMarketAnalysis),
	getManyByOrgId('/aIMarketAnalysis/byOrgId/:orgId', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByAnalysisType('/aIMarketAnalysis/byAnalysisType/:analysisType', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByLocation('/aIMarketAnalysis/byLocation/:location', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByAnalysisPeriod('/aIMarketAnalysis/byAnalysisPeriod/:analysisPeriod', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByDataPoints('/aIMarketAnalysis/byDataPoints/:dataPoints', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByPredictions('/aIMarketAnalysis/byPredictions/:predictions', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByInsights('/aIMarketAnalysis/byInsights/:insights', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByConfidence('/aIMarketAnalysis/byConfidence/:confidence', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByGeneratedAt('/aIMarketAnalysis/byGeneratedAt/:generatedAt', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByStatus('/aIMarketAnalysis/byStatus/:status', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByCreatedAt('/aIMarketAnalysis/byCreatedAt/:createdAt', HttpMethod.post, List<AIMarketAnalysis>),
	getManyByUpdatedAt('/aIMarketAnalysis/byUpdatedAt/:updatedAt', HttpMethod.post, List<AIMarketAnalysis>);

    const AIMarketAnalysisEndpoints(this.path, this.method, this.responseType);

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
