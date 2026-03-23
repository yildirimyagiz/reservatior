
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AILeadScoreStore extends ModelStreamStore<String, AILeadScore> {

  static AILeadScoreStore? _instance;

  static AILeadScoreStore get instance {
    _instance ??= AILeadScoreStore();
    return _instance!;
  }

  AILeadScoreStore() : super(AILeadScore.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AILeadScoreStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AILeadScoreStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AILeadScoreStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAILeadScoreId(AILeadScore aILeadScore) => aILeadScore.id;

	String? getAILeadScoreOrgId(AILeadScore aILeadScore) => aILeadScore.orgId;

	String? getAILeadScoreModelId(AILeadScore aILeadScore) => aILeadScore.modelId;

	String? getAILeadScoreLeadId(AILeadScore aILeadScore) => aILeadScore.leadId;

	double? getAILeadScoreScore(AILeadScore aILeadScore) => aILeadScore.score;

	dynamic? getAILeadScoreScoreBreakdown(AILeadScore aILeadScore) => aILeadScore.scoreBreakdown;

	double? getAILeadScoreConfidence(AILeadScore aILeadScore) => aILeadScore.confidence;

	DateTime? getAILeadScoreScoredAt(AILeadScore aILeadScore) => aILeadScore.scoredAt;

	dynamic? getAILeadScoreFeaturesUsed(AILeadScore aILeadScore) => aILeadScore.featuresUsed;

	String? getAILeadScoreStatus(AILeadScore aILeadScore) => aILeadScore.status;

	DateTime? getAILeadScoreCreatedAt(AILeadScore aILeadScore) => aILeadScore.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AILeadScore> getByOrgId(
    String orgId,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByModelId(
    String modelId,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreModelId, modelId, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByLeadId(
    String leadId,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreLeadId, leadId, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByScore(
    double score,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreScore, score, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByScoreBreakdown(
    dynamic scoreBreakdown,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreScoreBreakdown, scoreBreakdown, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByConfidence(
    double confidence,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByScoredAt(
    DateTime scoredAt,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreScoredAt, scoredAt, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByFeaturesUsed(
    dynamic featuresUsed,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreFeaturesUsed, featuresUsed, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByStatus(
    String status,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AILeadScore> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoreCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Lead? getLead(
    AILeadScore aILeadScore, {ModelFilter? modelFilter, List<LeadInclude>? includes}) {
    if (aILeadScore.leadId == null) {
        return null;
    } else {
        final lead = LeadStore.instance.getById(aILeadScore.leadId!, includes: includes);
        aILeadScore.lead = lead;
        // setIncludedReferences(lead, includes: includes);
        return lead;
    }
}

	AILeadScoring? getModel(
    AILeadScore aILeadScore, {ModelFilter? modelFilter, List<AILeadScoringInclude>? includes}) {
    if (aILeadScore.modelId == null) {
        return null;
    } else {
        final model = AILeadScoringStore.instance.getById(aILeadScore.modelId!, includes: includes);
        aILeadScore.model = model;
        // setIncludedReferences(model, includes: includes);
        return model;
    }
}

	Organization? getOrg(
    AILeadScore aILeadScore, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aILeadScore.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aILeadScore.orgId!, includes: includes);
        aILeadScore.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AILeadScore>> getAll$({bool useCache = true, ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AILeadScoreEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AILeadScore?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAILeadScoreId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AILeadScore>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAILeadScoreOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByModelId$(
        String modelId,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAILeadScoreModelId,
        value: modelId,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByModelId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByLeadId$(
        String leadId,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAILeadScoreLeadId,
        value: leadId,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByLeadId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByScore$(
        double score,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAILeadScoreScore,
        value: score,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByScoreBreakdown$(
        dynamic scoreBreakdown,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAILeadScoreScoreBreakdown,
        value: scoreBreakdown,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByScoreBreakdown,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAILeadScoreConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByScoredAt$(
        DateTime scoredAt,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAILeadScoreScoredAt,
        value: scoredAt,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByScoredAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByFeaturesUsed$(
        dynamic featuresUsed,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAILeadScoreFeaturesUsed,
        value: featuresUsed,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByFeaturesUsed,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAILeadScoreStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScore>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AILeadScore>? modelFilter,
        List<AILeadScoreInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAILeadScoreCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AILeadScoreEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Lead?> getLead$(
    AILeadScore aILeadScore, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    if (aILeadScore.leadId == null) {
        return Stream.value(null);
    } else {
        return LeadStore.instance.getById$(
            aILeadScore.leadId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lead) {
            aILeadScore.lead = lead;
        });
    }
}

	Stream<AILeadScoring?> getModel$(
    AILeadScore aILeadScore, {bool useCache = true, ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}) {
    if (aILeadScore.modelId == null) {
        return Stream.value(null);
    } else {
        return AILeadScoringStore.instance.getById$(
            aILeadScore.modelId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((model) {
            aILeadScore.model = model;
        });
    }
}

	Stream<Organization?> getOrg$(
    AILeadScore aILeadScore, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aILeadScore.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aILeadScore.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aILeadScore.org = org;
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
AILeadScore recursiveUpsert(AILeadScore aILeadScore, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AILeadScore'} 
        : const {};
    if (aILeadScore.lead != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        aILeadScore.lead = LeadStore.instance.recursiveUpsert(aILeadScore.lead!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aILeadScore.model != null && (!preventCircularSerialization || !upsertedTypes.contains('AILeadScoring'))) {
        aILeadScore.model = AILeadScoringStore.instance.recursiveUpsert(aILeadScore.model!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aILeadScore.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aILeadScore.org = OrganizationStore.instance.recursiveUpsert(aILeadScore.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aILeadScore);
}

  List<AILeadScore> recursiveListUpsert(List<AILeadScore> aILeadScores, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAILeadScores = <AILeadScore>[];
    for (var aILeadScore in aILeadScores) {
        updatedAILeadScores.add(recursiveUpsert(aILeadScore, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAILeadScores;
}

//   @override
//   AILeadScore upsert(AILeadScore item) {
//     return recursiveUpsert(item);
//   }

}


class AILeadScoreInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AILeadScoreInclude.lead({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aILeadScore) => AILeadScoreStore.instance
            .getLead$(aILeadScore, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aILeadScore) => AILeadScoreStore.instance
            .getLead(aILeadScore, modelFilter: modelFilter, includes: includes);
      }
}

	AILeadScoreInclude.model({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AILeadScoring>? modelFilter,
    List<AILeadScoringInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aILeadScore) => AILeadScoreStore.instance
            .getModel$(aILeadScore, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aILeadScore) => AILeadScoreStore.instance
            .getModel(aILeadScore, modelFilter: modelFilter, includes: includes);
      }
}

	AILeadScoreInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aILeadScore) => AILeadScoreStore.instance
            .getOrg$(aILeadScore, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aILeadScore) => AILeadScoreStore.instance
            .getOrg(aILeadScore, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AILeadScoreEndpoints implements Endpoint {

    getAll('/aILeadScore', HttpMethod.post, List<AILeadScore>),
	getById('/aILeadScore/byId/:id', HttpMethod.post, AILeadScore),
	getManyByOrgId('/aILeadScore/byOrgId/:orgId', HttpMethod.post, List<AILeadScore>),
	getManyByModelId('/aILeadScore/byModelId/:modelId', HttpMethod.post, List<AILeadScore>),
	getManyByLeadId('/aILeadScore/byLeadId/:leadId', HttpMethod.post, List<AILeadScore>),
	getManyByScore('/aILeadScore/byScore/:score', HttpMethod.post, List<AILeadScore>),
	getManyByScoreBreakdown('/aILeadScore/byScoreBreakdown/:scoreBreakdown', HttpMethod.post, List<AILeadScore>),
	getManyByConfidence('/aILeadScore/byConfidence/:confidence', HttpMethod.post, List<AILeadScore>),
	getManyByScoredAt('/aILeadScore/byScoredAt/:scoredAt', HttpMethod.post, List<AILeadScore>),
	getManyByFeaturesUsed('/aILeadScore/byFeaturesUsed/:featuresUsed', HttpMethod.post, List<AILeadScore>),
	getManyByStatus('/aILeadScore/byStatus/:status', HttpMethod.post, List<AILeadScore>),
	getManyByCreatedAt('/aILeadScore/byCreatedAt/:createdAt', HttpMethod.post, List<AILeadScore>);

    const AILeadScoreEndpoints(this.path, this.method, this.responseType);

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
