
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AILeadScoringStore extends ModelStreamStore<String, AILeadScoring> {

  static AILeadScoringStore? _instance;

  static AILeadScoringStore get instance {
    _instance ??= AILeadScoringStore();
    return _instance!;
  }

  AILeadScoringStore() : super(AILeadScoring.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AILeadScoringStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AILeadScoringStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AILeadScoringStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAILeadScoringId(AILeadScoring aILeadScoring) => aILeadScoring.id;

	String? getAILeadScoringOrgId(AILeadScoring aILeadScoring) => aILeadScoring.orgId;

	String? getAILeadScoringModelName(AILeadScoring aILeadScoring) => aILeadScoring.modelName;

	String? getAILeadScoringModelVersion(AILeadScoring aILeadScoring) => aILeadScoring.modelVersion;

	double? getAILeadScoringAccuracy(AILeadScoring aILeadScoring) => aILeadScoring.accuracy;

	DateTime? getAILeadScoringLastTrainedAt(AILeadScoring aILeadScoring) => aILeadScoring.lastTrainedAt;

	dynamic? getAILeadScoringFeatures(AILeadScoring aILeadScoring) => aILeadScoring.features;

	dynamic? getAILeadScoringScoringLogic(AILeadScoring aILeadScoring) => aILeadScoring.scoringLogic;

	bool? getAILeadScoringIsActive(AILeadScoring aILeadScoring) => aILeadScoring.isActive;

	DateTime? getAILeadScoringCreatedAt(AILeadScoring aILeadScoring) => aILeadScoring.createdAt;

	DateTime? getAILeadScoringUpdatedAt(AILeadScoring aILeadScoring) => aILeadScoring.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AILeadScoring> getByOrgId(
    String orgId,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByModelName(
    String modelName,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringModelName, modelName, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByModelVersion(
    String modelVersion,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringModelVersion, modelVersion, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByAccuracy(
    double accuracy,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringAccuracy, accuracy, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByLastTrainedAt(
    DateTime lastTrainedAt,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringLastTrainedAt, lastTrainedAt, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByFeatures(
    dynamic features,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringFeatures, features, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByScoringLogic(
    dynamic scoringLogic,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringScoringLogic, scoringLogic, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByIsActive(
    bool isActive,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AILeadScoring> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}
    ) =>
    getManyIncluding(getAILeadScoringUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AILeadScoring aILeadScoring, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aILeadScoring.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aILeadScoring.orgId!, includes: includes);
        aILeadScoring.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<AILeadScore> getScores(
    AILeadScoring aILeadScoring, {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}) {
    final scores = AILeadScoreStore.instance.getByModelId(aILeadScoring.$uid!, modelFilter: modelFilter, includes: includes);
    aILeadScoring.scores = scores;
    // setIncludedReferencesForList(scores, includes: includes);
    return scores;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AILeadScoring>> getAll$({bool useCache = true, ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AILeadScoringEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AILeadScoring?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAILeadScoringId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AILeadScoring>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAILeadScoringOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByModelName$(
        String modelName,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAILeadScoringModelName,
        value: modelName,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByModelName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByModelVersion$(
        String modelVersion,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAILeadScoringModelVersion,
        value: modelVersion,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByModelVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByAccuracy$(
        double accuracy,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAILeadScoringAccuracy,
        value: accuracy,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByAccuracy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByLastTrainedAt$(
        DateTime lastTrainedAt,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAILeadScoringLastTrainedAt,
        value: lastTrainedAt,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByLastTrainedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByFeatures$(
        dynamic features,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAILeadScoringFeatures,
        value: features,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByScoringLogic$(
        dynamic scoringLogic,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAILeadScoringScoringLogic,
        value: scoringLogic,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByScoringLogic,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAILeadScoringIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAILeadScoringCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AILeadScoring>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AILeadScoring>? modelFilter,
        List<AILeadScoringInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAILeadScoringUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AILeadScoringEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AILeadScoring aILeadScoring, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aILeadScoring.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aILeadScoring.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aILeadScoring.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AILeadScore>> getScores$(
    AILeadScoring aILeadScoring, {bool useCache = true, ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}) {
    return AILeadScoreStore.instance.getByModelId$(
        aILeadScoring.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((scores) {
        aILeadScoring.scores = scores;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AILeadScoring recursiveUpsert(AILeadScoring aILeadScoring, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AILeadScoring'} 
        : const {};
    if (aILeadScoring.scores != null && (!preventCircularSerialization || !upsertedTypes.contains('AILeadScore'))) {
        aILeadScoring.scores = AILeadScoreStore.instance.recursiveListUpsert(aILeadScoring.scores!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aILeadScoring.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aILeadScoring.org = OrganizationStore.instance.recursiveUpsert(aILeadScoring.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aILeadScoring);
}

  List<AILeadScoring> recursiveListUpsert(List<AILeadScoring> aILeadScorings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAILeadScorings = <AILeadScoring>[];
    for (var aILeadScoring in aILeadScorings) {
        updatedAILeadScorings.add(recursiveUpsert(aILeadScoring, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAILeadScorings;
}

//   @override
//   AILeadScoring upsert(AILeadScoring item) {
//     return recursiveUpsert(item);
//   }

}


class AILeadScoringInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AILeadScoringInclude.scores({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AILeadScore>? modelFilter,
    List<AILeadScoreInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aILeadScoring) => AILeadScoringStore.instance
            .getScores$(aILeadScoring, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aILeadScoring) => AILeadScoringStore.instance
            .getScores(aILeadScoring, modelFilter: modelFilter, includes: includes);
      }
}

	AILeadScoringInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aILeadScoring) => AILeadScoringStore.instance
            .getOrg$(aILeadScoring, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aILeadScoring) => AILeadScoringStore.instance
            .getOrg(aILeadScoring, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AILeadScoringEndpoints implements Endpoint {

    getAll('/aILeadScoring', HttpMethod.post, List<AILeadScoring>),
	getById('/aILeadScoring/byId/:id', HttpMethod.post, AILeadScoring),
	getManyByOrgId('/aILeadScoring/byOrgId/:orgId', HttpMethod.post, List<AILeadScoring>),
	getManyByModelName('/aILeadScoring/byModelName/:modelName', HttpMethod.post, List<AILeadScoring>),
	getManyByModelVersion('/aILeadScoring/byModelVersion/:modelVersion', HttpMethod.post, List<AILeadScoring>),
	getManyByAccuracy('/aILeadScoring/byAccuracy/:accuracy', HttpMethod.post, List<AILeadScoring>),
	getManyByLastTrainedAt('/aILeadScoring/byLastTrainedAt/:lastTrainedAt', HttpMethod.post, List<AILeadScoring>),
	getManyByFeatures('/aILeadScoring/byFeatures/:features', HttpMethod.post, List<AILeadScoring>),
	getManyByScoringLogic('/aILeadScoring/byScoringLogic/:scoringLogic', HttpMethod.post, List<AILeadScoring>),
	getManyByIsActive('/aILeadScoring/byIsActive/:isActive', HttpMethod.post, List<AILeadScoring>),
	getManyByCreatedAt('/aILeadScoring/byCreatedAt/:createdAt', HttpMethod.post, List<AILeadScoring>),
	getManyByUpdatedAt('/aILeadScoring/byUpdatedAt/:updatedAt', HttpMethod.post, List<AILeadScoring>);

    const AILeadScoringEndpoints(this.path, this.method, this.responseType);

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
