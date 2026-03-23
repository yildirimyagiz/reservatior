
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AITenantScreeningStore extends ModelStreamStore<String, AITenantScreening> {

  static AITenantScreeningStore? _instance;

  static AITenantScreeningStore get instance {
    _instance ??= AITenantScreeningStore();
    return _instance!;
  }

  AITenantScreeningStore() : super(AITenantScreening.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AITenantScreeningStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AITenantScreeningStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AITenantScreeningStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAITenantScreeningId(AITenantScreening aITenantScreening) => aITenantScreening.id;

	String? getAITenantScreeningOrgId(AITenantScreening aITenantScreening) => aITenantScreening.orgId;

	String? getAITenantScreeningApplicationId(AITenantScreening aITenantScreening) => aITenantScreening.applicationId;

	double? getAITenantScreeningOverallScore(AITenantScreening aITenantScreening) => aITenantScreening.overallScore;

	String? getAITenantScreeningRiskAssessment(AITenantScreening aITenantScreening) => aITenantScreening.riskAssessment;

	double? getAITenantScreeningCreditScore(AITenantScreening aITenantScreening) => aITenantScreening.creditScore;

	double? getAITenantScreeningIncomeStability(AITenantScreening aITenantScreening) => aITenantScreening.incomeStability;

	double? getAITenantScreeningRentalHistory(AITenantScreening aITenantScreening) => aITenantScreening.rentalHistory;

	double? getAITenantScreeningBackgroundCheck(AITenantScreening aITenantScreening) => aITenantScreening.backgroundCheck;

	dynamic? getAITenantScreeningRiskFactors(AITenantScreening aITenantScreening) => aITenantScreening.riskFactors;

	dynamic? getAITenantScreeningRecommendations(AITenantScreening aITenantScreening) => aITenantScreening.recommendations;

	DateTime? getAITenantScreeningScreenedAt(AITenantScreening aITenantScreening) => aITenantScreening.screenedAt;

	String? getAITenantScreeningReviewedBy(AITenantScreening aITenantScreening) => aITenantScreening.reviewedBy;

	String? getAITenantScreeningFinalDecision(AITenantScreening aITenantScreening) => aITenantScreening.finalDecision;

	DateTime? getAITenantScreeningCreatedAt(AITenantScreening aITenantScreening) => aITenantScreening.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AITenantScreening> getByOrgId(
    String orgId,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByApplicationId(
    String applicationId,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningApplicationId, applicationId, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByOverallScore(
    double overallScore,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningOverallScore, overallScore, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByRiskAssessment(
    String riskAssessment,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningRiskAssessment, riskAssessment, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByCreditScore(
    double creditScore,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningCreditScore, creditScore, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByIncomeStability(
    double incomeStability,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningIncomeStability, incomeStability, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByRentalHistory(
    double rentalHistory,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningRentalHistory, rentalHistory, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByBackgroundCheck(
    double backgroundCheck,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningBackgroundCheck, backgroundCheck, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByRiskFactors(
    dynamic riskFactors,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningRiskFactors, riskFactors, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByRecommendations(
    dynamic recommendations,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningRecommendations, recommendations, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByScreenedAt(
    DateTime screenedAt,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningScreenedAt, screenedAt, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByReviewedBy(
    String reviewedBy,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningReviewedBy, reviewedBy, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByFinalDecision(
    String finalDecision,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningFinalDecision, finalDecision, modelFilter: modelFilter, includes: includes);

	
List<AITenantScreening> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}
    ) =>
    getManyIncluding(getAITenantScreeningCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AITenantScreening aITenantScreening, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aITenantScreening.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aITenantScreening.orgId!, includes: includes);
        aITenantScreening.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AITenantScreening>> getAll$({bool useCache = true, ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AITenantScreeningEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AITenantScreening?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAITenantScreeningId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AITenantScreening>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAITenantScreeningOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByApplicationId$(
        String applicationId,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAITenantScreeningApplicationId,
        value: applicationId,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByApplicationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByOverallScore$(
        double overallScore,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAITenantScreeningOverallScore,
        value: overallScore,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByOverallScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByRiskAssessment$(
        String riskAssessment,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAITenantScreeningRiskAssessment,
        value: riskAssessment,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByRiskAssessment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByCreditScore$(
        double creditScore,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAITenantScreeningCreditScore,
        value: creditScore,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByCreditScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByIncomeStability$(
        double incomeStability,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAITenantScreeningIncomeStability,
        value: incomeStability,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByIncomeStability,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByRentalHistory$(
        double rentalHistory,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAITenantScreeningRentalHistory,
        value: rentalHistory,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByRentalHistory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByBackgroundCheck$(
        double backgroundCheck,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAITenantScreeningBackgroundCheck,
        value: backgroundCheck,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByBackgroundCheck,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByRiskFactors$(
        dynamic riskFactors,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAITenantScreeningRiskFactors,
        value: riskFactors,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByRiskFactors,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByRecommendations$(
        dynamic recommendations,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAITenantScreeningRecommendations,
        value: recommendations,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByRecommendations,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByScreenedAt$(
        DateTime screenedAt,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAITenantScreeningScreenedAt,
        value: screenedAt,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByScreenedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByReviewedBy$(
        String reviewedBy,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAITenantScreeningReviewedBy,
        value: reviewedBy,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByReviewedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByFinalDecision$(
        String finalDecision,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAITenantScreeningFinalDecision,
        value: finalDecision,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByFinalDecision,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AITenantScreening>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AITenantScreening>? modelFilter,
        List<AITenantScreeningInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAITenantScreeningCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AITenantScreeningEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AITenantScreening aITenantScreening, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aITenantScreening.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aITenantScreening.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aITenantScreening.org = org;
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
AITenantScreening recursiveUpsert(AITenantScreening aITenantScreening, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AITenantScreening'} 
        : const {};
    if (aITenantScreening.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aITenantScreening.org = OrganizationStore.instance.recursiveUpsert(aITenantScreening.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aITenantScreening);
}

  List<AITenantScreening> recursiveListUpsert(List<AITenantScreening> aITenantScreenings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAITenantScreenings = <AITenantScreening>[];
    for (var aITenantScreening in aITenantScreenings) {
        updatedAITenantScreenings.add(recursiveUpsert(aITenantScreening, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAITenantScreenings;
}

//   @override
//   AITenantScreening upsert(AITenantScreening item) {
//     return recursiveUpsert(item);
//   }

}


class AITenantScreeningInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AITenantScreeningInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aITenantScreening) => AITenantScreeningStore.instance
            .getOrg$(aITenantScreening, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aITenantScreening) => AITenantScreeningStore.instance
            .getOrg(aITenantScreening, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AITenantScreeningEndpoints implements Endpoint {

    getAll('/aITenantScreening', HttpMethod.post, List<AITenantScreening>),
	getById('/aITenantScreening/byId/:id', HttpMethod.post, AITenantScreening),
	getManyByOrgId('/aITenantScreening/byOrgId/:orgId', HttpMethod.post, List<AITenantScreening>),
	getManyByApplicationId('/aITenantScreening/byApplicationId/:applicationId', HttpMethod.post, List<AITenantScreening>),
	getManyByOverallScore('/aITenantScreening/byOverallScore/:overallScore', HttpMethod.post, List<AITenantScreening>),
	getManyByRiskAssessment('/aITenantScreening/byRiskAssessment/:riskAssessment', HttpMethod.post, List<AITenantScreening>),
	getManyByCreditScore('/aITenantScreening/byCreditScore/:creditScore', HttpMethod.post, List<AITenantScreening>),
	getManyByIncomeStability('/aITenantScreening/byIncomeStability/:incomeStability', HttpMethod.post, List<AITenantScreening>),
	getManyByRentalHistory('/aITenantScreening/byRentalHistory/:rentalHistory', HttpMethod.post, List<AITenantScreening>),
	getManyByBackgroundCheck('/aITenantScreening/byBackgroundCheck/:backgroundCheck', HttpMethod.post, List<AITenantScreening>),
	getManyByRiskFactors('/aITenantScreening/byRiskFactors/:riskFactors', HttpMethod.post, List<AITenantScreening>),
	getManyByRecommendations('/aITenantScreening/byRecommendations/:recommendations', HttpMethod.post, List<AITenantScreening>),
	getManyByScreenedAt('/aITenantScreening/byScreenedAt/:screenedAt', HttpMethod.post, List<AITenantScreening>),
	getManyByReviewedBy('/aITenantScreening/byReviewedBy/:reviewedBy', HttpMethod.post, List<AITenantScreening>),
	getManyByFinalDecision('/aITenantScreening/byFinalDecision/:finalDecision', HttpMethod.post, List<AITenantScreening>),
	getManyByCreatedAt('/aITenantScreening/byCreatedAt/:createdAt', HttpMethod.post, List<AITenantScreening>);

    const AITenantScreeningEndpoints(this.path, this.method, this.responseType);

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
