
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIRecommendationStore extends ModelStreamStore<String, AIRecommendation> {

  static AIRecommendationStore? _instance;

  static AIRecommendationStore get instance {
    _instance ??= AIRecommendationStore();
    return _instance!;
  }

  AIRecommendationStore() : super(AIRecommendation.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIRecommendationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIRecommendationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIRecommendationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIRecommendationId(AIRecommendation aIRecommendation) => aIRecommendation.id;

	String? getAIRecommendationOrgId(AIRecommendation aIRecommendation) => aIRecommendation.orgId;

	String? getAIRecommendationUserType(AIRecommendation aIRecommendation) => aIRecommendation.userType;

	String? getAIRecommendationUserId(AIRecommendation aIRecommendation) => aIRecommendation.userId;

	String? getAIRecommendationSessionId(AIRecommendation aIRecommendation) => aIRecommendation.sessionId;

	dynamic? getAIRecommendationRecommendedProperties(AIRecommendation aIRecommendation) => aIRecommendation.recommendedProperties;

	String? getAIRecommendationRecommendationType(AIRecommendation aIRecommendation) => aIRecommendation.recommendationType;

	dynamic? getAIRecommendationUserPreferences(AIRecommendation aIRecommendation) => aIRecommendation.userPreferences;

	dynamic? getAIRecommendationReasoning(AIRecommendation aIRecommendation) => aIRecommendation.reasoning;

	DateTime? getAIRecommendationGeneratedAt(AIRecommendation aIRecommendation) => aIRecommendation.generatedAt;

	DateTime? getAIRecommendationExpiresAt(AIRecommendation aIRecommendation) => aIRecommendation.expiresAt;

	DateTime? getAIRecommendationCreatedAt(AIRecommendation aIRecommendation) => aIRecommendation.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIRecommendation> getByOrgId(
    String orgId,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByUserType(
    String userType,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationUserType, userType, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByUserId(
    String userId,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getBySessionId(
    String sessionId,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationSessionId, sessionId, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByRecommendedProperties(
    dynamic recommendedProperties,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationRecommendedProperties, recommendedProperties, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByRecommendationType(
    String recommendationType,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationRecommendationType, recommendationType, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByUserPreferences(
    dynamic userPreferences,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationUserPreferences, userPreferences, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByReasoning(
    dynamic reasoning,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationReasoning, reasoning, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByGeneratedAt(
    DateTime generatedAt,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationGeneratedAt, generatedAt, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<AIRecommendation> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}
    ) =>
    getManyIncluding(getAIRecommendationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIRecommendation aIRecommendation, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIRecommendation.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIRecommendation.orgId!, includes: includes);
        aIRecommendation.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIRecommendation>> getAll$({bool useCache = true, ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIRecommendationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIRecommendation?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIRecommendationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIRecommendation>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIRecommendationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByUserType$(
        String userType,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIRecommendationUserType,
        value: userType,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByUserType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIRecommendationUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getBySessionId$(
        String sessionId,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIRecommendationSessionId,
        value: sessionId,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyBySessionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByRecommendedProperties$(
        dynamic recommendedProperties,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIRecommendationRecommendedProperties,
        value: recommendedProperties,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByRecommendedProperties,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByRecommendationType$(
        String recommendationType,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIRecommendationRecommendationType,
        value: recommendationType,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByRecommendationType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByUserPreferences$(
        dynamic userPreferences,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIRecommendationUserPreferences,
        value: userPreferences,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByUserPreferences,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByReasoning$(
        dynamic reasoning,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIRecommendationReasoning,
        value: reasoning,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByReasoning,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByGeneratedAt$(
        DateTime generatedAt,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIRecommendationGeneratedAt,
        value: generatedAt,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByGeneratedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIRecommendationExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIRecommendation>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIRecommendation>? modelFilter,
        List<AIRecommendationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIRecommendationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIRecommendationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIRecommendation aIRecommendation, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIRecommendation.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIRecommendation.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIRecommendation.org = org;
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
AIRecommendation recursiveUpsert(AIRecommendation aIRecommendation, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIRecommendation'} 
        : const {};
    if (aIRecommendation.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIRecommendation.org = OrganizationStore.instance.recursiveUpsert(aIRecommendation.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIRecommendation);
}

  List<AIRecommendation> recursiveListUpsert(List<AIRecommendation> aIRecommendations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIRecommendations = <AIRecommendation>[];
    for (var aIRecommendation in aIRecommendations) {
        updatedAIRecommendations.add(recursiveUpsert(aIRecommendation, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIRecommendations;
}

//   @override
//   AIRecommendation upsert(AIRecommendation item) {
//     return recursiveUpsert(item);
//   }

}


class AIRecommendationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIRecommendationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIRecommendation) => AIRecommendationStore.instance
            .getOrg$(aIRecommendation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIRecommendation) => AIRecommendationStore.instance
            .getOrg(aIRecommendation, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIRecommendationEndpoints implements Endpoint {

    getAll('/aIRecommendation', HttpMethod.post, List<AIRecommendation>),
	getById('/aIRecommendation/byId/:id', HttpMethod.post, AIRecommendation),
	getManyByOrgId('/aIRecommendation/byOrgId/:orgId', HttpMethod.post, List<AIRecommendation>),
	getManyByUserType('/aIRecommendation/byUserType/:userType', HttpMethod.post, List<AIRecommendation>),
	getManyByUserId('/aIRecommendation/byUserId/:userId', HttpMethod.post, List<AIRecommendation>),
	getManyBySessionId('/aIRecommendation/bySessionId/:sessionId', HttpMethod.post, List<AIRecommendation>),
	getManyByRecommendedProperties('/aIRecommendation/byRecommendedProperties/:recommendedProperties', HttpMethod.post, List<AIRecommendation>),
	getManyByRecommendationType('/aIRecommendation/byRecommendationType/:recommendationType', HttpMethod.post, List<AIRecommendation>),
	getManyByUserPreferences('/aIRecommendation/byUserPreferences/:userPreferences', HttpMethod.post, List<AIRecommendation>),
	getManyByReasoning('/aIRecommendation/byReasoning/:reasoning', HttpMethod.post, List<AIRecommendation>),
	getManyByGeneratedAt('/aIRecommendation/byGeneratedAt/:generatedAt', HttpMethod.post, List<AIRecommendation>),
	getManyByExpiresAt('/aIRecommendation/byExpiresAt/:expiresAt', HttpMethod.post, List<AIRecommendation>),
	getManyByCreatedAt('/aIRecommendation/byCreatedAt/:createdAt', HttpMethod.post, List<AIRecommendation>);

    const AIRecommendationEndpoints(this.path, this.method, this.responseType);

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
