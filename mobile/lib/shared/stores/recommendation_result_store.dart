
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class RecommendationResultStore extends ModelStreamStore<String, RecommendationResult> {

  static RecommendationResultStore? _instance;

  static RecommendationResultStore get instance {
    _instance ??= RecommendationResultStore();
    return _instance!;
  }

  RecommendationResultStore() : super(RecommendationResult.fromJson) {
    if (_instance != null) {
        throw Exception(
            'RecommendationResultStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending RecommendationResultStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use RecommendationResultStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getRecommendationResultId(RecommendationResult recommendationResult) => recommendationResult.id;

	String? getRecommendationResultProfileId(RecommendationResult recommendationResult) => recommendationResult.profileId;

	String? getRecommendationResultOrgId(RecommendationResult recommendationResult) => recommendationResult.orgId;

	String? getRecommendationResultListingId(RecommendationResult recommendationResult) => recommendationResult.listingId;

	int? getRecommendationResultScore(RecommendationResult recommendationResult) => recommendationResult.score;

	String? getRecommendationResultExplanation(RecommendationResult recommendationResult) => recommendationResult.explanation;

	dynamic? getRecommendationResultBreakdown(RecommendationResult recommendationResult) => recommendationResult.breakdown;

	DateTime? getRecommendationResultCreatedAt(RecommendationResult recommendationResult) => recommendationResult.createdAt;

	DateTime? getRecommendationResultUpdatedAt(RecommendationResult recommendationResult) => recommendationResult.updatedAt;

	DateTime? getRecommendationResultDeletedAt(RecommendationResult recommendationResult) => recommendationResult.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<RecommendationResult> getByProfileId(
    String profileId,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultProfileId, profileId, modelFilter: modelFilter, includes: includes);

	
List<RecommendationResult> getByOrgId(
    String orgId,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<RecommendationResult> getByListingId(
    String listingId,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<RecommendationResult> getByScore(
    int score,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultScore, score, modelFilter: modelFilter, includes: includes);

	
List<RecommendationResult> getByExplanation(
    String explanation,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultExplanation, explanation, modelFilter: modelFilter, includes: includes);

	
List<RecommendationResult> getByBreakdown(
    dynamic breakdown,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultBreakdown, breakdown, modelFilter: modelFilter, includes: includes);

	
List<RecommendationResult> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<RecommendationResult> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<RecommendationResult> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}
    ) =>
    getManyIncluding(getRecommendationResultDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    RecommendationResult recommendationResult, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (recommendationResult.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(recommendationResult.orgId!, includes: includes);
        recommendationResult.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	UserFinancialProfile? getProfile(
    RecommendationResult recommendationResult, {ModelFilter? modelFilter, List<UserFinancialProfileInclude>? includes}) {
    if (recommendationResult.profileId == null) {
        return null;
    } else {
        final profile = UserFinancialProfileStore.instance.getById(recommendationResult.profileId!, includes: includes);
        recommendationResult.profile = profile;
        // setIncludedReferences(profile, includes: includes);
        return profile;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<RecommendationResult>> getAll$({bool useCache = true, ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: RecommendationResultEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<RecommendationResult?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getRecommendationResultId,
        value: id,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<RecommendationResult>> getByProfileId$(
        String profileId,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRecommendationResultProfileId,
        value: profileId,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByProfileId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RecommendationResult>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRecommendationResultOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RecommendationResult>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRecommendationResultListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RecommendationResult>> getByScore$(
        int score,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getRecommendationResultScore,
        value: score,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RecommendationResult>> getByExplanation$(
        String explanation,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRecommendationResultExplanation,
        value: explanation,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByExplanation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RecommendationResult>> getByBreakdown$(
        dynamic breakdown,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getRecommendationResultBreakdown,
        value: breakdown,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByBreakdown,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RecommendationResult>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRecommendationResultCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RecommendationResult>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRecommendationResultUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RecommendationResult>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<RecommendationResult>? modelFilter,
        List<RecommendationResultInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRecommendationResultDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: RecommendationResultEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    RecommendationResult recommendationResult, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (recommendationResult.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            recommendationResult.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            recommendationResult.org = org;
        });
    }
}

	Stream<UserFinancialProfile?> getProfile$(
    RecommendationResult recommendationResult, {bool useCache = true, ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}) {
    if (recommendationResult.profileId == null) {
        return Stream.value(null);
    } else {
        return UserFinancialProfileStore.instance.getById$(
            recommendationResult.profileId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((profile) {
            recommendationResult.profile = profile;
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
RecommendationResult recursiveUpsert(RecommendationResult recommendationResult, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'RecommendationResult'} 
        : const {};
    if (recommendationResult.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        recommendationResult.org = OrganizationStore.instance.recursiveUpsert(recommendationResult.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (recommendationResult.profile != null && (!preventCircularSerialization || !upsertedTypes.contains('UserFinancialProfile'))) {
        recommendationResult.profile = UserFinancialProfileStore.instance.recursiveUpsert(recommendationResult.profile!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(recommendationResult);
}

  List<RecommendationResult> recursiveListUpsert(List<RecommendationResult> recommendationResults, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedRecommendationResults = <RecommendationResult>[];
    for (var recommendationResult in recommendationResults) {
        updatedRecommendationResults.add(recursiveUpsert(recommendationResult, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedRecommendationResults;
}

//   @override
//   RecommendationResult upsert(RecommendationResult item) {
//     return recursiveUpsert(item);
//   }

}


class RecommendationResultInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      RecommendationResultInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (recommendationResult) => RecommendationResultStore.instance
            .getOrg$(recommendationResult, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (recommendationResult) => RecommendationResultStore.instance
            .getOrg(recommendationResult, modelFilter: modelFilter, includes: includes);
      }
}

	RecommendationResultInclude.profile({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<UserFinancialProfile>? modelFilter,
    List<UserFinancialProfileInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (recommendationResult) => RecommendationResultStore.instance
            .getProfile$(recommendationResult, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (recommendationResult) => RecommendationResultStore.instance
            .getProfile(recommendationResult, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum RecommendationResultEndpoints implements Endpoint {

    getAll('/recommendationResult', HttpMethod.post, List<RecommendationResult>),
	getById('/recommendationResult/byId/:id', HttpMethod.post, RecommendationResult),
	getManyByProfileId('/recommendationResult/byProfileId/:profileId', HttpMethod.post, List<RecommendationResult>),
	getManyByOrgId('/recommendationResult/byOrgId/:orgId', HttpMethod.post, List<RecommendationResult>),
	getManyByListingId('/recommendationResult/byListingId/:listingId', HttpMethod.post, List<RecommendationResult>),
	getManyByScore('/recommendationResult/byScore/:score', HttpMethod.post, List<RecommendationResult>),
	getManyByExplanation('/recommendationResult/byExplanation/:explanation', HttpMethod.post, List<RecommendationResult>),
	getManyByBreakdown('/recommendationResult/byBreakdown/:breakdown', HttpMethod.post, List<RecommendationResult>),
	getManyByCreatedAt('/recommendationResult/byCreatedAt/:createdAt', HttpMethod.post, List<RecommendationResult>),
	getManyByUpdatedAt('/recommendationResult/byUpdatedAt/:updatedAt', HttpMethod.post, List<RecommendationResult>),
	getManyByDeletedAt('/recommendationResult/byDeletedAt/:deletedAt', HttpMethod.post, List<RecommendationResult>);

    const RecommendationResultEndpoints(this.path, this.method, this.responseType);

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
