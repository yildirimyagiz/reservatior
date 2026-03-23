
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIPropertyValuationStore extends ModelStreamStore<String, AIPropertyValuation> {

  static AIPropertyValuationStore? _instance;

  static AIPropertyValuationStore get instance {
    _instance ??= AIPropertyValuationStore();
    return _instance!;
  }

  AIPropertyValuationStore() : super(AIPropertyValuation.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIPropertyValuationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIPropertyValuationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIPropertyValuationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIPropertyValuationId(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.id;

	String? getAIPropertyValuationOrgId(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.orgId;

	String? getAIPropertyValuationModelId(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.modelId;

	String? getAIPropertyValuationPropertyId(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.propertyId;

	double? getAIPropertyValuationPredictedValue(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.predictedValue;

	double? getAIPropertyValuationConfidenceScore(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.confidenceScore;

	DateTime? getAIPropertyValuationValuationDate(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.valuationDate;

	dynamic? getAIPropertyValuationInputFeatures(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.inputFeatures;

	dynamic? getAIPropertyValuationComparableSales(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.comparableSales;

	dynamic? getAIPropertyValuationMarketTrends(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.marketTrends;

	String? getAIPropertyValuationStatus(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.status;

	DateTime? getAIPropertyValuationCreatedAt(AIPropertyValuation aIPropertyValuation) => aIPropertyValuation.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIPropertyValuation> getByOrgId(
    String orgId,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByModelId(
    String modelId,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationModelId, modelId, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByPropertyId(
    String propertyId,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByPredictedValue(
    double predictedValue,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationPredictedValue, predictedValue, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByConfidenceScore(
    double confidenceScore,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationConfidenceScore, confidenceScore, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByValuationDate(
    DateTime valuationDate,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationValuationDate, valuationDate, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByInputFeatures(
    dynamic inputFeatures,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationInputFeatures, inputFeatures, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByComparableSales(
    dynamic comparableSales,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationComparableSales, comparableSales, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByMarketTrends(
    dynamic marketTrends,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationMarketTrends, marketTrends, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByStatus(
    String status,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyValuation> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyValuationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  AIValuationModel? getModel(
    AIPropertyValuation aIPropertyValuation, {ModelFilter? modelFilter, List<AIValuationModelInclude>? includes}) {
    if (aIPropertyValuation.modelId == null) {
        return null;
    } else {
        final model = AIValuationModelStore.instance.getById(aIPropertyValuation.modelId!, includes: includes);
        aIPropertyValuation.model = model;
        // setIncludedReferences(model, includes: includes);
        return model;
    }
}

	Organization? getOrg(
    AIPropertyValuation aIPropertyValuation, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPropertyValuation.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIPropertyValuation.orgId!, includes: includes);
        aIPropertyValuation.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    AIPropertyValuation aIPropertyValuation, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (aIPropertyValuation.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(aIPropertyValuation.propertyId!, includes: includes);
        aIPropertyValuation.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIPropertyValuation>> getAll$({bool useCache = true, ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIPropertyValuationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIPropertyValuation?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIPropertyValuationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIPropertyValuation>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyValuationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByModelId$(
        String modelId,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyValuationModelId,
        value: modelId,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByModelId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyValuationPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByPredictedValue$(
        double predictedValue,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPropertyValuationPredictedValue,
        value: predictedValue,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByPredictedValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByConfidenceScore$(
        double confidenceScore,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPropertyValuationConfidenceScore,
        value: confidenceScore,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByConfidenceScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByValuationDate$(
        DateTime valuationDate,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPropertyValuationValuationDate,
        value: valuationDate,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByValuationDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByInputFeatures$(
        dynamic inputFeatures,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPropertyValuationInputFeatures,
        value: inputFeatures,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByInputFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByComparableSales$(
        dynamic comparableSales,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPropertyValuationComparableSales,
        value: comparableSales,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByComparableSales,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByMarketTrends$(
        dynamic marketTrends,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPropertyValuationMarketTrends,
        value: marketTrends,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByMarketTrends,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyValuationStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyValuation>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIPropertyValuation>? modelFilter,
        List<AIPropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPropertyValuationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIPropertyValuationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<AIValuationModel?> getModel$(
    AIPropertyValuation aIPropertyValuation, {bool useCache = true, ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}) {
    if (aIPropertyValuation.modelId == null) {
        return Stream.value(null);
    } else {
        return AIValuationModelStore.instance.getById$(
            aIPropertyValuation.modelId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((model) {
            aIPropertyValuation.model = model;
        });
    }
}

	Stream<Organization?> getOrg$(
    AIPropertyValuation aIPropertyValuation, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPropertyValuation.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIPropertyValuation.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIPropertyValuation.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    AIPropertyValuation aIPropertyValuation, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (aIPropertyValuation.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            aIPropertyValuation.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            aIPropertyValuation.property = property;
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
AIPropertyValuation recursiveUpsert(AIPropertyValuation aIPropertyValuation, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIPropertyValuation'} 
        : const {};
    if (aIPropertyValuation.model != null && (!preventCircularSerialization || !upsertedTypes.contains('AIValuationModel'))) {
        aIPropertyValuation.model = AIValuationModelStore.instance.recursiveUpsert(aIPropertyValuation.model!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIPropertyValuation.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIPropertyValuation.org = OrganizationStore.instance.recursiveUpsert(aIPropertyValuation.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIPropertyValuation.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        aIPropertyValuation.property = PropertyStore.instance.recursiveUpsert(aIPropertyValuation.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIPropertyValuation);
}

  List<AIPropertyValuation> recursiveListUpsert(List<AIPropertyValuation> aIPropertyValuations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIPropertyValuations = <AIPropertyValuation>[];
    for (var aIPropertyValuation in aIPropertyValuations) {
        updatedAIPropertyValuations.add(recursiveUpsert(aIPropertyValuation, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIPropertyValuations;
}

//   @override
//   AIPropertyValuation upsert(AIPropertyValuation item) {
//     return recursiveUpsert(item);
//   }

}


class AIPropertyValuationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIPropertyValuationInclude.model({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIValuationModel>? modelFilter,
    List<AIValuationModelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPropertyValuation) => AIPropertyValuationStore.instance
            .getModel$(aIPropertyValuation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPropertyValuation) => AIPropertyValuationStore.instance
            .getModel(aIPropertyValuation, modelFilter: modelFilter, includes: includes);
      }
}

	AIPropertyValuationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPropertyValuation) => AIPropertyValuationStore.instance
            .getOrg$(aIPropertyValuation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPropertyValuation) => AIPropertyValuationStore.instance
            .getOrg(aIPropertyValuation, modelFilter: modelFilter, includes: includes);
      }
}

	AIPropertyValuationInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPropertyValuation) => AIPropertyValuationStore.instance
            .getProperty$(aIPropertyValuation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPropertyValuation) => AIPropertyValuationStore.instance
            .getProperty(aIPropertyValuation, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIPropertyValuationEndpoints implements Endpoint {

    getAll('/aIPropertyValuation', HttpMethod.post, List<AIPropertyValuation>),
	getById('/aIPropertyValuation/byId/:id', HttpMethod.post, AIPropertyValuation),
	getManyByOrgId('/aIPropertyValuation/byOrgId/:orgId', HttpMethod.post, List<AIPropertyValuation>),
	getManyByModelId('/aIPropertyValuation/byModelId/:modelId', HttpMethod.post, List<AIPropertyValuation>),
	getManyByPropertyId('/aIPropertyValuation/byPropertyId/:propertyId', HttpMethod.post, List<AIPropertyValuation>),
	getManyByPredictedValue('/aIPropertyValuation/byPredictedValue/:predictedValue', HttpMethod.post, List<AIPropertyValuation>),
	getManyByConfidenceScore('/aIPropertyValuation/byConfidenceScore/:confidenceScore', HttpMethod.post, List<AIPropertyValuation>),
	getManyByValuationDate('/aIPropertyValuation/byValuationDate/:valuationDate', HttpMethod.post, List<AIPropertyValuation>),
	getManyByInputFeatures('/aIPropertyValuation/byInputFeatures/:inputFeatures', HttpMethod.post, List<AIPropertyValuation>),
	getManyByComparableSales('/aIPropertyValuation/byComparableSales/:comparableSales', HttpMethod.post, List<AIPropertyValuation>),
	getManyByMarketTrends('/aIPropertyValuation/byMarketTrends/:marketTrends', HttpMethod.post, List<AIPropertyValuation>),
	getManyByStatus('/aIPropertyValuation/byStatus/:status', HttpMethod.post, List<AIPropertyValuation>),
	getManyByCreatedAt('/aIPropertyValuation/byCreatedAt/:createdAt', HttpMethod.post, List<AIPropertyValuation>);

    const AIPropertyValuationEndpoints(this.path, this.method, this.responseType);

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
