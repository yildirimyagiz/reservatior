
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIPredictiveMaintenanceStore extends ModelStreamStore<String, AIPredictiveMaintenance> {

  static AIPredictiveMaintenanceStore? _instance;

  static AIPredictiveMaintenanceStore get instance {
    _instance ??= AIPredictiveMaintenanceStore();
    return _instance!;
  }

  AIPredictiveMaintenanceStore() : super(AIPredictiveMaintenance.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIPredictiveMaintenanceStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIPredictiveMaintenanceStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIPredictiveMaintenanceStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIPredictiveMaintenanceId(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.id;

	String? getAIPredictiveMaintenanceOrgId(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.orgId;

	String? getAIPredictiveMaintenancePropertyId(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.propertyId;

	String? getAIPredictiveMaintenanceComponentType(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.componentType;

	double? getAIPredictiveMaintenanceFailureProbability(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.failureProbability;

	DateTime? getAIPredictiveMaintenancePredictedFailureDate(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.predictedFailureDate;

	String? getAIPredictiveMaintenanceRiskLevel(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.riskLevel;

	double? getAIPredictiveMaintenanceEstimatedCost(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.estimatedCost;

	dynamic? getAIPredictiveMaintenanceContributingFactors(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.contributingFactors;

	DateTime? getAIPredictiveMaintenanceLastInspectionDate(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.lastInspectionDate;

	String? getAIPredictiveMaintenanceRecommendedAction(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.recommendedAction;

	DateTime? getAIPredictiveMaintenanceGeneratedAt(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.generatedAt;

	DateTime? getAIPredictiveMaintenanceCreatedAt(AIPredictiveMaintenance aIPredictiveMaintenance) => aIPredictiveMaintenance.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIPredictiveMaintenance> getByOrgId(
    String orgId,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByPropertyId(
    String propertyId,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenancePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByComponentType(
    String componentType,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceComponentType, componentType, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByFailureProbability(
    double failureProbability,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceFailureProbability, failureProbability, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByPredictedFailureDate(
    DateTime predictedFailureDate,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenancePredictedFailureDate, predictedFailureDate, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByRiskLevel(
    String riskLevel,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceRiskLevel, riskLevel, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByEstimatedCost(
    double estimatedCost,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceEstimatedCost, estimatedCost, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByContributingFactors(
    dynamic contributingFactors,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceContributingFactors, contributingFactors, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByLastInspectionDate(
    DateTime lastInspectionDate,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceLastInspectionDate, lastInspectionDate, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByRecommendedAction(
    String recommendedAction,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceRecommendedAction, recommendedAction, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByGeneratedAt(
    DateTime generatedAt,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceGeneratedAt, generatedAt, modelFilter: modelFilter, includes: includes);

	
List<AIPredictiveMaintenance> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}
    ) =>
    getManyIncluding(getAIPredictiveMaintenanceCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIPredictiveMaintenance aIPredictiveMaintenance, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPredictiveMaintenance.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIPredictiveMaintenance.orgId!, includes: includes);
        aIPredictiveMaintenance.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    AIPredictiveMaintenance aIPredictiveMaintenance, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (aIPredictiveMaintenance.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(aIPredictiveMaintenance.propertyId!, includes: includes);
        aIPredictiveMaintenance.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIPredictiveMaintenance>> getAll$({bool useCache = true, ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIPredictiveMaintenanceEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIPredictiveMaintenance?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIPredictiveMaintenanceId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIPredictiveMaintenance>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictiveMaintenanceOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictiveMaintenancePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByComponentType$(
        String componentType,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictiveMaintenanceComponentType,
        value: componentType,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByComponentType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByFailureProbability$(
        double failureProbability,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPredictiveMaintenanceFailureProbability,
        value: failureProbability,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByFailureProbability,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByPredictedFailureDate$(
        DateTime predictedFailureDate,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPredictiveMaintenancePredictedFailureDate,
        value: predictedFailureDate,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByPredictedFailureDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByRiskLevel$(
        String riskLevel,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictiveMaintenanceRiskLevel,
        value: riskLevel,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByRiskLevel,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByEstimatedCost$(
        double estimatedCost,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPredictiveMaintenanceEstimatedCost,
        value: estimatedCost,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByEstimatedCost,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByContributingFactors$(
        dynamic contributingFactors,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPredictiveMaintenanceContributingFactors,
        value: contributingFactors,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByContributingFactors,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByLastInspectionDate$(
        DateTime lastInspectionDate,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPredictiveMaintenanceLastInspectionDate,
        value: lastInspectionDate,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByLastInspectionDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByRecommendedAction$(
        String recommendedAction,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPredictiveMaintenanceRecommendedAction,
        value: recommendedAction,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByRecommendedAction,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByGeneratedAt$(
        DateTime generatedAt,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPredictiveMaintenanceGeneratedAt,
        value: generatedAt,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByGeneratedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPredictiveMaintenance>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIPredictiveMaintenance>? modelFilter,
        List<AIPredictiveMaintenanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPredictiveMaintenanceCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIPredictiveMaintenanceEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIPredictiveMaintenance aIPredictiveMaintenance, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPredictiveMaintenance.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIPredictiveMaintenance.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIPredictiveMaintenance.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    AIPredictiveMaintenance aIPredictiveMaintenance, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (aIPredictiveMaintenance.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            aIPredictiveMaintenance.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            aIPredictiveMaintenance.property = property;
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
AIPredictiveMaintenance recursiveUpsert(AIPredictiveMaintenance aIPredictiveMaintenance, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIPredictiveMaintenance'} 
        : const {};
    if (aIPredictiveMaintenance.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIPredictiveMaintenance.org = OrganizationStore.instance.recursiveUpsert(aIPredictiveMaintenance.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIPredictiveMaintenance.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        aIPredictiveMaintenance.property = PropertyStore.instance.recursiveUpsert(aIPredictiveMaintenance.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIPredictiveMaintenance);
}

  List<AIPredictiveMaintenance> recursiveListUpsert(List<AIPredictiveMaintenance> aIPredictiveMaintenances, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIPredictiveMaintenances = <AIPredictiveMaintenance>[];
    for (var aIPredictiveMaintenance in aIPredictiveMaintenances) {
        updatedAIPredictiveMaintenances.add(recursiveUpsert(aIPredictiveMaintenance, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIPredictiveMaintenances;
}

//   @override
//   AIPredictiveMaintenance upsert(AIPredictiveMaintenance item) {
//     return recursiveUpsert(item);
//   }

}


class AIPredictiveMaintenanceInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIPredictiveMaintenanceInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPredictiveMaintenance) => AIPredictiveMaintenanceStore.instance
            .getOrg$(aIPredictiveMaintenance, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPredictiveMaintenance) => AIPredictiveMaintenanceStore.instance
            .getOrg(aIPredictiveMaintenance, modelFilter: modelFilter, includes: includes);
      }
}

	AIPredictiveMaintenanceInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPredictiveMaintenance) => AIPredictiveMaintenanceStore.instance
            .getProperty$(aIPredictiveMaintenance, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPredictiveMaintenance) => AIPredictiveMaintenanceStore.instance
            .getProperty(aIPredictiveMaintenance, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIPredictiveMaintenanceEndpoints implements Endpoint {

    getAll('/aIPredictiveMaintenance', HttpMethod.post, List<AIPredictiveMaintenance>),
	getById('/aIPredictiveMaintenance/byId/:id', HttpMethod.post, AIPredictiveMaintenance),
	getManyByOrgId('/aIPredictiveMaintenance/byOrgId/:orgId', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByPropertyId('/aIPredictiveMaintenance/byPropertyId/:propertyId', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByComponentType('/aIPredictiveMaintenance/byComponentType/:componentType', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByFailureProbability('/aIPredictiveMaintenance/byFailureProbability/:failureProbability', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByPredictedFailureDate('/aIPredictiveMaintenance/byPredictedFailureDate/:predictedFailureDate', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByRiskLevel('/aIPredictiveMaintenance/byRiskLevel/:riskLevel', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByEstimatedCost('/aIPredictiveMaintenance/byEstimatedCost/:estimatedCost', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByContributingFactors('/aIPredictiveMaintenance/byContributingFactors/:contributingFactors', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByLastInspectionDate('/aIPredictiveMaintenance/byLastInspectionDate/:lastInspectionDate', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByRecommendedAction('/aIPredictiveMaintenance/byRecommendedAction/:recommendedAction', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByGeneratedAt('/aIPredictiveMaintenance/byGeneratedAt/:generatedAt', HttpMethod.post, List<AIPredictiveMaintenance>),
	getManyByCreatedAt('/aIPredictiveMaintenance/byCreatedAt/:createdAt', HttpMethod.post, List<AIPredictiveMaintenance>);

    const AIPredictiveMaintenanceEndpoints(this.path, this.method, this.responseType);

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
