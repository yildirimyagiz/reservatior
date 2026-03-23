
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIInvestmentAnalysisStore extends ModelStreamStore<String, AIInvestmentAnalysis> {

  static AIInvestmentAnalysisStore? _instance;

  static AIInvestmentAnalysisStore get instance {
    _instance ??= AIInvestmentAnalysisStore();
    return _instance!;
  }

  AIInvestmentAnalysisStore() : super(AIInvestmentAnalysis.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIInvestmentAnalysisStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIInvestmentAnalysisStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIInvestmentAnalysisStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIInvestmentAnalysisId(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.id;

	String? getAIInvestmentAnalysisOrgId(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.orgId;

	String? getAIInvestmentAnalysisPropertyId(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.propertyId;

	String? getAIInvestmentAnalysisAnalysisType(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.analysisType;

	String? getAIInvestmentAnalysisTimeHorizon(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.timeHorizon;

	dynamic? getAIInvestmentAnalysisProjectedReturns(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.projectedReturns;

	dynamic? getAIInvestmentAnalysisCashFlowProjection(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.cashFlowProjection;

	dynamic? getAIInvestmentAnalysisRiskMetrics(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.riskMetrics;

	dynamic? getAIInvestmentAnalysisKeyAssumptions(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.keyAssumptions;

	dynamic? getAIInvestmentAnalysisSensitivityAnalysis(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.sensitivityAnalysis;

	double? getAIInvestmentAnalysisConfidence(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.confidence;

	DateTime? getAIInvestmentAnalysisGeneratedAt(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.generatedAt;

	DateTime? getAIInvestmentAnalysisCreatedAt(AIInvestmentAnalysis aIInvestmentAnalysis) => aIInvestmentAnalysis.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIInvestmentAnalysis> getByOrgId(
    String orgId,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByPropertyId(
    String propertyId,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByAnalysisType(
    String analysisType,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisAnalysisType, analysisType, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByTimeHorizon(
    String timeHorizon,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisTimeHorizon, timeHorizon, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByProjectedReturns(
    dynamic projectedReturns,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisProjectedReturns, projectedReturns, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByCashFlowProjection(
    dynamic cashFlowProjection,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisCashFlowProjection, cashFlowProjection, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByRiskMetrics(
    dynamic riskMetrics,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisRiskMetrics, riskMetrics, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByKeyAssumptions(
    dynamic keyAssumptions,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisKeyAssumptions, keyAssumptions, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getBySensitivityAnalysis(
    dynamic sensitivityAnalysis,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisSensitivityAnalysis, sensitivityAnalysis, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByConfidence(
    double confidence,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByGeneratedAt(
    DateTime generatedAt,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisGeneratedAt, generatedAt, modelFilter: modelFilter, includes: includes);

	
List<AIInvestmentAnalysis> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIInvestmentAnalysisCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIInvestmentAnalysis aIInvestmentAnalysis, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIInvestmentAnalysis.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIInvestmentAnalysis.orgId!, includes: includes);
        aIInvestmentAnalysis.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    AIInvestmentAnalysis aIInvestmentAnalysis, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (aIInvestmentAnalysis.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(aIInvestmentAnalysis.propertyId!, includes: includes);
        aIInvestmentAnalysis.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIInvestmentAnalysis>> getAll$({bool useCache = true, ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIInvestmentAnalysisEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIInvestmentAnalysis?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIInvestmentAnalysisId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIInvestmentAnalysis>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIInvestmentAnalysisOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIInvestmentAnalysisPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByAnalysisType$(
        String analysisType,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIInvestmentAnalysisAnalysisType,
        value: analysisType,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByAnalysisType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByTimeHorizon$(
        String timeHorizon,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIInvestmentAnalysisTimeHorizon,
        value: timeHorizon,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByTimeHorizon,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByProjectedReturns$(
        dynamic projectedReturns,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIInvestmentAnalysisProjectedReturns,
        value: projectedReturns,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByProjectedReturns,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByCashFlowProjection$(
        dynamic cashFlowProjection,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIInvestmentAnalysisCashFlowProjection,
        value: cashFlowProjection,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByCashFlowProjection,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByRiskMetrics$(
        dynamic riskMetrics,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIInvestmentAnalysisRiskMetrics,
        value: riskMetrics,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByRiskMetrics,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByKeyAssumptions$(
        dynamic keyAssumptions,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIInvestmentAnalysisKeyAssumptions,
        value: keyAssumptions,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByKeyAssumptions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getBySensitivityAnalysis$(
        dynamic sensitivityAnalysis,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIInvestmentAnalysisSensitivityAnalysis,
        value: sensitivityAnalysis,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyBySensitivityAnalysis,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIInvestmentAnalysisConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByGeneratedAt$(
        DateTime generatedAt,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIInvestmentAnalysisGeneratedAt,
        value: generatedAt,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByGeneratedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIInvestmentAnalysis>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIInvestmentAnalysis>? modelFilter,
        List<AIInvestmentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIInvestmentAnalysisCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIInvestmentAnalysisEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIInvestmentAnalysis aIInvestmentAnalysis, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIInvestmentAnalysis.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIInvestmentAnalysis.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIInvestmentAnalysis.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    AIInvestmentAnalysis aIInvestmentAnalysis, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (aIInvestmentAnalysis.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            aIInvestmentAnalysis.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            aIInvestmentAnalysis.property = property;
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
AIInvestmentAnalysis recursiveUpsert(AIInvestmentAnalysis aIInvestmentAnalysis, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIInvestmentAnalysis'} 
        : const {};
    if (aIInvestmentAnalysis.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIInvestmentAnalysis.org = OrganizationStore.instance.recursiveUpsert(aIInvestmentAnalysis.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIInvestmentAnalysis.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        aIInvestmentAnalysis.property = PropertyStore.instance.recursiveUpsert(aIInvestmentAnalysis.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIInvestmentAnalysis);
}

  List<AIInvestmentAnalysis> recursiveListUpsert(List<AIInvestmentAnalysis> aIInvestmentAnalysiss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIInvestmentAnalysiss = <AIInvestmentAnalysis>[];
    for (var aIInvestmentAnalysis in aIInvestmentAnalysiss) {
        updatedAIInvestmentAnalysiss.add(recursiveUpsert(aIInvestmentAnalysis, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIInvestmentAnalysiss;
}

//   @override
//   AIInvestmentAnalysis upsert(AIInvestmentAnalysis item) {
//     return recursiveUpsert(item);
//   }

}


class AIInvestmentAnalysisInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIInvestmentAnalysisInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIInvestmentAnalysis) => AIInvestmentAnalysisStore.instance
            .getOrg$(aIInvestmentAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIInvestmentAnalysis) => AIInvestmentAnalysisStore.instance
            .getOrg(aIInvestmentAnalysis, modelFilter: modelFilter, includes: includes);
      }
}

	AIInvestmentAnalysisInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIInvestmentAnalysis) => AIInvestmentAnalysisStore.instance
            .getProperty$(aIInvestmentAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIInvestmentAnalysis) => AIInvestmentAnalysisStore.instance
            .getProperty(aIInvestmentAnalysis, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIInvestmentAnalysisEndpoints implements Endpoint {

    getAll('/aIInvestmentAnalysis', HttpMethod.post, List<AIInvestmentAnalysis>),
	getById('/aIInvestmentAnalysis/byId/:id', HttpMethod.post, AIInvestmentAnalysis),
	getManyByOrgId('/aIInvestmentAnalysis/byOrgId/:orgId', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByPropertyId('/aIInvestmentAnalysis/byPropertyId/:propertyId', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByAnalysisType('/aIInvestmentAnalysis/byAnalysisType/:analysisType', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByTimeHorizon('/aIInvestmentAnalysis/byTimeHorizon/:timeHorizon', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByProjectedReturns('/aIInvestmentAnalysis/byProjectedReturns/:projectedReturns', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByCashFlowProjection('/aIInvestmentAnalysis/byCashFlowProjection/:cashFlowProjection', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByRiskMetrics('/aIInvestmentAnalysis/byRiskMetrics/:riskMetrics', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByKeyAssumptions('/aIInvestmentAnalysis/byKeyAssumptions/:keyAssumptions', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyBySensitivityAnalysis('/aIInvestmentAnalysis/bySensitivityAnalysis/:sensitivityAnalysis', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByConfidence('/aIInvestmentAnalysis/byConfidence/:confidence', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByGeneratedAt('/aIInvestmentAnalysis/byGeneratedAt/:generatedAt', HttpMethod.post, List<AIInvestmentAnalysis>),
	getManyByCreatedAt('/aIInvestmentAnalysis/byCreatedAt/:createdAt', HttpMethod.post, List<AIInvestmentAnalysis>);

    const AIInvestmentAnalysisEndpoints(this.path, this.method, this.responseType);

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
