
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIFraudDetectionStore extends ModelStreamStore<String, AIFraudDetection> {

  static AIFraudDetectionStore? _instance;

  static AIFraudDetectionStore get instance {
    _instance ??= AIFraudDetectionStore();
    return _instance!;
  }

  AIFraudDetectionStore() : super(AIFraudDetection.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIFraudDetectionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIFraudDetectionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIFraudDetectionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIFraudDetectionId(AIFraudDetection aIFraudDetection) => aIFraudDetection.id;

	String? getAIFraudDetectionOrgId(AIFraudDetection aIFraudDetection) => aIFraudDetection.orgId;

	String? getAIFraudDetectionEntityType(AIFraudDetection aIFraudDetection) => aIFraudDetection.entityType;

	String? getAIFraudDetectionEntityId(AIFraudDetection aIFraudDetection) => aIFraudDetection.entityId;

	double? getAIFraudDetectionRiskScore(AIFraudDetection aIFraudDetection) => aIFraudDetection.riskScore;

	dynamic? getAIFraudDetectionRiskFactors(AIFraudDetection aIFraudDetection) => aIFraudDetection.riskFactors;

	String? getAIFraudDetectionRiskCategory(AIFraudDetection aIFraudDetection) => aIFraudDetection.riskCategory;

	dynamic? getAIFraudDetectionRecommendedActions(AIFraudDetection aIFraudDetection) => aIFraudDetection.recommendedActions;

	DateTime? getAIFraudDetectionDetectedAt(AIFraudDetection aIFraudDetection) => aIFraudDetection.detectedAt;

	DateTime? getAIFraudDetectionReviewedAt(AIFraudDetection aIFraudDetection) => aIFraudDetection.reviewedAt;

	String? getAIFraudDetectionReviewedBy(AIFraudDetection aIFraudDetection) => aIFraudDetection.reviewedBy;

	String? getAIFraudDetectionResolution(AIFraudDetection aIFraudDetection) => aIFraudDetection.resolution;

	DateTime? getAIFraudDetectionCreatedAt(AIFraudDetection aIFraudDetection) => aIFraudDetection.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIFraudDetection> getByOrgId(
    String orgId,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByEntityType(
    String entityType,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionEntityType, entityType, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByEntityId(
    String entityId,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionEntityId, entityId, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByRiskScore(
    double riskScore,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionRiskScore, riskScore, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByRiskFactors(
    dynamic riskFactors,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionRiskFactors, riskFactors, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByRiskCategory(
    String riskCategory,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionRiskCategory, riskCategory, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByRecommendedActions(
    dynamic recommendedActions,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionRecommendedActions, recommendedActions, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByDetectedAt(
    DateTime detectedAt,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionDetectedAt, detectedAt, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByReviewedAt(
    DateTime reviewedAt,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionReviewedAt, reviewedAt, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByReviewedBy(
    String reviewedBy,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionReviewedBy, reviewedBy, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByResolution(
    String resolution,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionResolution, resolution, modelFilter: modelFilter, includes: includes);

	
List<AIFraudDetection> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}
    ) =>
    getManyIncluding(getAIFraudDetectionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIFraudDetection aIFraudDetection, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIFraudDetection.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIFraudDetection.orgId!, includes: includes);
        aIFraudDetection.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIFraudDetection>> getAll$({bool useCache = true, ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIFraudDetectionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIFraudDetection?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIFraudDetectionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIFraudDetection>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIFraudDetectionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByEntityType$(
        String entityType,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIFraudDetectionEntityType,
        value: entityType,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByEntityType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByEntityId$(
        String entityId,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIFraudDetectionEntityId,
        value: entityId,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByEntityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByRiskScore$(
        double riskScore,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIFraudDetectionRiskScore,
        value: riskScore,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByRiskScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByRiskFactors$(
        dynamic riskFactors,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIFraudDetectionRiskFactors,
        value: riskFactors,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByRiskFactors,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByRiskCategory$(
        String riskCategory,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIFraudDetectionRiskCategory,
        value: riskCategory,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByRiskCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByRecommendedActions$(
        dynamic recommendedActions,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIFraudDetectionRecommendedActions,
        value: recommendedActions,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByRecommendedActions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByDetectedAt$(
        DateTime detectedAt,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIFraudDetectionDetectedAt,
        value: detectedAt,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByDetectedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByReviewedAt$(
        DateTime reviewedAt,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIFraudDetectionReviewedAt,
        value: reviewedAt,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByReviewedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByReviewedBy$(
        String reviewedBy,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIFraudDetectionReviewedBy,
        value: reviewedBy,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByReviewedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByResolution$(
        String resolution,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIFraudDetectionResolution,
        value: resolution,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByResolution,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIFraudDetection>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIFraudDetection>? modelFilter,
        List<AIFraudDetectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIFraudDetectionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIFraudDetectionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIFraudDetection aIFraudDetection, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIFraudDetection.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIFraudDetection.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIFraudDetection.org = org;
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
AIFraudDetection recursiveUpsert(AIFraudDetection aIFraudDetection, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIFraudDetection'} 
        : const {};
    if (aIFraudDetection.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIFraudDetection.org = OrganizationStore.instance.recursiveUpsert(aIFraudDetection.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIFraudDetection);
}

  List<AIFraudDetection> recursiveListUpsert(List<AIFraudDetection> aIFraudDetections, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIFraudDetections = <AIFraudDetection>[];
    for (var aIFraudDetection in aIFraudDetections) {
        updatedAIFraudDetections.add(recursiveUpsert(aIFraudDetection, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIFraudDetections;
}

//   @override
//   AIFraudDetection upsert(AIFraudDetection item) {
//     return recursiveUpsert(item);
//   }

}


class AIFraudDetectionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIFraudDetectionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIFraudDetection) => AIFraudDetectionStore.instance
            .getOrg$(aIFraudDetection, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIFraudDetection) => AIFraudDetectionStore.instance
            .getOrg(aIFraudDetection, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIFraudDetectionEndpoints implements Endpoint {

    getAll('/aIFraudDetection', HttpMethod.post, List<AIFraudDetection>),
	getById('/aIFraudDetection/byId/:id', HttpMethod.post, AIFraudDetection),
	getManyByOrgId('/aIFraudDetection/byOrgId/:orgId', HttpMethod.post, List<AIFraudDetection>),
	getManyByEntityType('/aIFraudDetection/byEntityType/:entityType', HttpMethod.post, List<AIFraudDetection>),
	getManyByEntityId('/aIFraudDetection/byEntityId/:entityId', HttpMethod.post, List<AIFraudDetection>),
	getManyByRiskScore('/aIFraudDetection/byRiskScore/:riskScore', HttpMethod.post, List<AIFraudDetection>),
	getManyByRiskFactors('/aIFraudDetection/byRiskFactors/:riskFactors', HttpMethod.post, List<AIFraudDetection>),
	getManyByRiskCategory('/aIFraudDetection/byRiskCategory/:riskCategory', HttpMethod.post, List<AIFraudDetection>),
	getManyByRecommendedActions('/aIFraudDetection/byRecommendedActions/:recommendedActions', HttpMethod.post, List<AIFraudDetection>),
	getManyByDetectedAt('/aIFraudDetection/byDetectedAt/:detectedAt', HttpMethod.post, List<AIFraudDetection>),
	getManyByReviewedAt('/aIFraudDetection/byReviewedAt/:reviewedAt', HttpMethod.post, List<AIFraudDetection>),
	getManyByReviewedBy('/aIFraudDetection/byReviewedBy/:reviewedBy', HttpMethod.post, List<AIFraudDetection>),
	getManyByResolution('/aIFraudDetection/byResolution/:resolution', HttpMethod.post, List<AIFraudDetection>),
	getManyByCreatedAt('/aIFraudDetection/byCreatedAt/:createdAt', HttpMethod.post, List<AIFraudDetection>);

    const AIFraudDetectionEndpoints(this.path, this.method, this.responseType);

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
