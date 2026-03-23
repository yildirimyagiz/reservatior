
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIPriceOptimizationStore extends ModelStreamStore<String, AIPriceOptimization> {

  static AIPriceOptimizationStore? _instance;

  static AIPriceOptimizationStore get instance {
    _instance ??= AIPriceOptimizationStore();
    return _instance!;
  }

  AIPriceOptimizationStore() : super(AIPriceOptimization.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIPriceOptimizationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIPriceOptimizationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIPriceOptimizationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIPriceOptimizationId(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.id;

	String? getAIPriceOptimizationOrgId(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.orgId;

	String? getAIPriceOptimizationListingId(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.listingId;

	double? getAIPriceOptimizationCurrentPrice(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.currentPrice;

	double? getAIPriceOptimizationRecommendedPrice(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.recommendedPrice;

	dynamic? getAIPriceOptimizationPriceRange(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.priceRange;

	dynamic? getAIPriceOptimizationFactors(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.factors;

	dynamic? getAIPriceOptimizationComparableData(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.comparableData;

	dynamic? getAIPriceOptimizationMarketTrends(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.marketTrends;

	double? getAIPriceOptimizationConfidence(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.confidence;

	DateTime? getAIPriceOptimizationGeneratedAt(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.generatedAt;

	bool? getAIPriceOptimizationIsApplied(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.isApplied;

	DateTime? getAIPriceOptimizationAppliedAt(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.appliedAt;

	DateTime? getAIPriceOptimizationCreatedAt(AIPriceOptimization aIPriceOptimization) => aIPriceOptimization.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIPriceOptimization> getByOrgId(
    String orgId,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByListingId(
    String listingId,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByCurrentPrice(
    double currentPrice,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationCurrentPrice, currentPrice, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByRecommendedPrice(
    double recommendedPrice,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationRecommendedPrice, recommendedPrice, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByPriceRange(
    dynamic priceRange,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationPriceRange, priceRange, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByFactors(
    dynamic factors,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationFactors, factors, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByComparableData(
    dynamic comparableData,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationComparableData, comparableData, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByMarketTrends(
    dynamic marketTrends,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationMarketTrends, marketTrends, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByConfidence(
    double confidence,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByGeneratedAt(
    DateTime generatedAt,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationGeneratedAt, generatedAt, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByIsApplied(
    bool isApplied,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationIsApplied, isApplied, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByAppliedAt(
    DateTime appliedAt,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationAppliedAt, appliedAt, modelFilter: modelFilter, includes: includes);

	
List<AIPriceOptimization> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}
    ) =>
    getManyIncluding(getAIPriceOptimizationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Listing? getListing(
    AIPriceOptimization aIPriceOptimization, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (aIPriceOptimization.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(aIPriceOptimization.listingId!, includes: includes);
        aIPriceOptimization.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    AIPriceOptimization aIPriceOptimization, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPriceOptimization.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIPriceOptimization.orgId!, includes: includes);
        aIPriceOptimization.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIPriceOptimization>> getAll$({bool useCache = true, ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIPriceOptimizationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIPriceOptimization?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIPriceOptimizationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIPriceOptimization>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPriceOptimizationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPriceOptimizationListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByCurrentPrice$(
        double currentPrice,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPriceOptimizationCurrentPrice,
        value: currentPrice,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByCurrentPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByRecommendedPrice$(
        double recommendedPrice,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPriceOptimizationRecommendedPrice,
        value: recommendedPrice,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByRecommendedPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByPriceRange$(
        dynamic priceRange,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPriceOptimizationPriceRange,
        value: priceRange,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByPriceRange,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByFactors$(
        dynamic factors,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPriceOptimizationFactors,
        value: factors,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByFactors,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByComparableData$(
        dynamic comparableData,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPriceOptimizationComparableData,
        value: comparableData,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByComparableData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByMarketTrends$(
        dynamic marketTrends,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPriceOptimizationMarketTrends,
        value: marketTrends,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByMarketTrends,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPriceOptimizationConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByGeneratedAt$(
        DateTime generatedAt,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPriceOptimizationGeneratedAt,
        value: generatedAt,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByGeneratedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByIsApplied$(
        bool isApplied,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAIPriceOptimizationIsApplied,
        value: isApplied,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByIsApplied,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByAppliedAt$(
        DateTime appliedAt,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPriceOptimizationAppliedAt,
        value: appliedAt,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByAppliedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPriceOptimization>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIPriceOptimization>? modelFilter,
        List<AIPriceOptimizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPriceOptimizationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIPriceOptimizationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Listing?> getListing$(
    AIPriceOptimization aIPriceOptimization, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (aIPriceOptimization.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            aIPriceOptimization.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            aIPriceOptimization.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    AIPriceOptimization aIPriceOptimization, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPriceOptimization.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIPriceOptimization.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIPriceOptimization.org = org;
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
AIPriceOptimization recursiveUpsert(AIPriceOptimization aIPriceOptimization, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIPriceOptimization'} 
        : const {};
    if (aIPriceOptimization.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        aIPriceOptimization.listing = ListingStore.instance.recursiveUpsert(aIPriceOptimization.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIPriceOptimization.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIPriceOptimization.org = OrganizationStore.instance.recursiveUpsert(aIPriceOptimization.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIPriceOptimization);
}

  List<AIPriceOptimization> recursiveListUpsert(List<AIPriceOptimization> aIPriceOptimizations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIPriceOptimizations = <AIPriceOptimization>[];
    for (var aIPriceOptimization in aIPriceOptimizations) {
        updatedAIPriceOptimizations.add(recursiveUpsert(aIPriceOptimization, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIPriceOptimizations;
}

//   @override
//   AIPriceOptimization upsert(AIPriceOptimization item) {
//     return recursiveUpsert(item);
//   }

}


class AIPriceOptimizationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIPriceOptimizationInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPriceOptimization) => AIPriceOptimizationStore.instance
            .getListing$(aIPriceOptimization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPriceOptimization) => AIPriceOptimizationStore.instance
            .getListing(aIPriceOptimization, modelFilter: modelFilter, includes: includes);
      }
}

	AIPriceOptimizationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPriceOptimization) => AIPriceOptimizationStore.instance
            .getOrg$(aIPriceOptimization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPriceOptimization) => AIPriceOptimizationStore.instance
            .getOrg(aIPriceOptimization, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIPriceOptimizationEndpoints implements Endpoint {

    getAll('/aIPriceOptimization', HttpMethod.post, List<AIPriceOptimization>),
	getById('/aIPriceOptimization/byId/:id', HttpMethod.post, AIPriceOptimization),
	getManyByOrgId('/aIPriceOptimization/byOrgId/:orgId', HttpMethod.post, List<AIPriceOptimization>),
	getManyByListingId('/aIPriceOptimization/byListingId/:listingId', HttpMethod.post, List<AIPriceOptimization>),
	getManyByCurrentPrice('/aIPriceOptimization/byCurrentPrice/:currentPrice', HttpMethod.post, List<AIPriceOptimization>),
	getManyByRecommendedPrice('/aIPriceOptimization/byRecommendedPrice/:recommendedPrice', HttpMethod.post, List<AIPriceOptimization>),
	getManyByPriceRange('/aIPriceOptimization/byPriceRange/:priceRange', HttpMethod.post, List<AIPriceOptimization>),
	getManyByFactors('/aIPriceOptimization/byFactors/:factors', HttpMethod.post, List<AIPriceOptimization>),
	getManyByComparableData('/aIPriceOptimization/byComparableData/:comparableData', HttpMethod.post, List<AIPriceOptimization>),
	getManyByMarketTrends('/aIPriceOptimization/byMarketTrends/:marketTrends', HttpMethod.post, List<AIPriceOptimization>),
	getManyByConfidence('/aIPriceOptimization/byConfidence/:confidence', HttpMethod.post, List<AIPriceOptimization>),
	getManyByGeneratedAt('/aIPriceOptimization/byGeneratedAt/:generatedAt', HttpMethod.post, List<AIPriceOptimization>),
	getManyByIsApplied('/aIPriceOptimization/byIsApplied/:isApplied', HttpMethod.post, List<AIPriceOptimization>),
	getManyByAppliedAt('/aIPriceOptimization/byAppliedAt/:appliedAt', HttpMethod.post, List<AIPriceOptimization>),
	getManyByCreatedAt('/aIPriceOptimization/byCreatedAt/:createdAt', HttpMethod.post, List<AIPriceOptimization>);

    const AIPriceOptimizationEndpoints(this.path, this.method, this.responseType);

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
