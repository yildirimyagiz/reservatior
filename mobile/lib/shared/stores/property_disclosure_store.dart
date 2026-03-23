
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyDisclosureStore extends ModelStreamStore<String, PropertyDisclosure> {

  static PropertyDisclosureStore? _instance;

  static PropertyDisclosureStore get instance {
    _instance ??= PropertyDisclosureStore();
    return _instance!;
  }

  PropertyDisclosureStore() : super(PropertyDisclosure.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyDisclosureStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyDisclosureStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyDisclosureStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyDisclosureId(PropertyDisclosure propertyDisclosure) => propertyDisclosure.id;

	String? getPropertyDisclosureOrgId(PropertyDisclosure propertyDisclosure) => propertyDisclosure.orgId;

	String? getPropertyDisclosurePropertyId(PropertyDisclosure propertyDisclosure) => propertyDisclosure.propertyId;

	String? getPropertyDisclosurePackStatus(PropertyDisclosure propertyDisclosure) => propertyDisclosure.packStatus;

	DateTime? getPropertyDisclosureCreatedDate(PropertyDisclosure propertyDisclosure) => propertyDisclosure.createdDate;

	DateTime? getPropertyDisclosureSubmittedDate(PropertyDisclosure propertyDisclosure) => propertyDisclosure.submittedDate;

	dynamic? getPropertyDisclosureEnergyPerformanceCertificate(PropertyDisclosure propertyDisclosure) => propertyDisclosure.energyPerformanceCertificate;

	dynamic? getPropertyDisclosureFloorPlan(PropertyDisclosure propertyDisclosure) => propertyDisclosure.floorPlan;

	dynamic? getPropertyDisclosureLeaseholdInfo(PropertyDisclosure propertyDisclosure) => propertyDisclosure.leaseholdInfo;

	dynamic? getPropertyDisclosureBoundaryPlan(PropertyDisclosure propertyDisclosure) => propertyDisclosure.boundaryPlan;

	dynamic? getPropertyDisclosurePlanningPermission(PropertyDisclosure propertyDisclosure) => propertyDisclosure.planningPermission;

	dynamic? getPropertyDisclosurePropertyQuestionnaire(PropertyDisclosure propertyDisclosure) => propertyDisclosure.propertyQuestionnaire;

	dynamic? getPropertyDisclosureElectricalSafety(PropertyDisclosure propertyDisclosure) => propertyDisclosure.electricalSafety;

	dynamic? getPropertyDisclosureGasSafety(PropertyDisclosure propertyDisclosure) => propertyDisclosure.gasSafety;

	dynamic? getPropertyDisclosureFireSafety(PropertyDisclosure propertyDisclosure) => propertyDisclosure.fireSafety;

	String? getPropertyDisclosureCompletionNotes(PropertyDisclosure propertyDisclosure) => propertyDisclosure.completionNotes;

	DateTime? getPropertyDisclosureCreatedAt(PropertyDisclosure propertyDisclosure) => propertyDisclosure.createdAt;

	DateTime? getPropertyDisclosureUpdatedAt(PropertyDisclosure propertyDisclosure) => propertyDisclosure.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
PropertyDisclosure? getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getIncluding(getPropertyDisclosurePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

  
List<PropertyDisclosure> getByOrgId(
    String orgId,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByPackStatus(
    String packStatus,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosurePackStatus, packStatus, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByCreatedDate(
    DateTime createdDate,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureCreatedDate, createdDate, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getBySubmittedDate(
    DateTime submittedDate,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureSubmittedDate, submittedDate, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByEnergyPerformanceCertificate(
    dynamic energyPerformanceCertificate,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureEnergyPerformanceCertificate, energyPerformanceCertificate, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByFloorPlan(
    dynamic floorPlan,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureFloorPlan, floorPlan, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByLeaseholdInfo(
    dynamic leaseholdInfo,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureLeaseholdInfo, leaseholdInfo, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByBoundaryPlan(
    dynamic boundaryPlan,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureBoundaryPlan, boundaryPlan, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByPlanningPermission(
    dynamic planningPermission,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosurePlanningPermission, planningPermission, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByPropertyQuestionnaire(
    dynamic propertyQuestionnaire,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosurePropertyQuestionnaire, propertyQuestionnaire, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByElectricalSafety(
    dynamic electricalSafety,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureElectricalSafety, electricalSafety, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByGasSafety(
    dynamic gasSafety,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureGasSafety, gasSafety, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByFireSafety(
    dynamic fireSafety,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureFireSafety, fireSafety, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByCompletionNotes(
    String completionNotes,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureCompletionNotes, completionNotes, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyDisclosure> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDisclosureUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    PropertyDisclosure propertyDisclosure, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyDisclosure.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(propertyDisclosure.orgId!, includes: includes);
        propertyDisclosure.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    PropertyDisclosure propertyDisclosure, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyDisclosure.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyDisclosure.propertyId!, includes: includes);
        propertyDisclosure.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyDisclosure>> getAll$({bool useCache = true, ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyDisclosureEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyDisclosure?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyDisclosureId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<PropertyDisclosure?> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyDisclosurePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyDisclosure>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDisclosureOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByPackStatus$(
        String packStatus,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDisclosurePackStatus,
        value: packStatus,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByPackStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByCreatedDate$(
        DateTime createdDate,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyDisclosureCreatedDate,
        value: createdDate,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByCreatedDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getBySubmittedDate$(
        DateTime submittedDate,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyDisclosureSubmittedDate,
        value: submittedDate,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyBySubmittedDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByEnergyPerformanceCertificate$(
        dynamic energyPerformanceCertificate,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosureEnergyPerformanceCertificate,
        value: energyPerformanceCertificate,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByEnergyPerformanceCertificate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByFloorPlan$(
        dynamic floorPlan,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosureFloorPlan,
        value: floorPlan,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByFloorPlan,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByLeaseholdInfo$(
        dynamic leaseholdInfo,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosureLeaseholdInfo,
        value: leaseholdInfo,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByLeaseholdInfo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByBoundaryPlan$(
        dynamic boundaryPlan,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosureBoundaryPlan,
        value: boundaryPlan,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByBoundaryPlan,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByPlanningPermission$(
        dynamic planningPermission,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosurePlanningPermission,
        value: planningPermission,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByPlanningPermission,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByPropertyQuestionnaire$(
        dynamic propertyQuestionnaire,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosurePropertyQuestionnaire,
        value: propertyQuestionnaire,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByPropertyQuestionnaire,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByElectricalSafety$(
        dynamic electricalSafety,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosureElectricalSafety,
        value: electricalSafety,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByElectricalSafety,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByGasSafety$(
        dynamic gasSafety,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosureGasSafety,
        value: gasSafety,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByGasSafety,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByFireSafety$(
        dynamic fireSafety,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyDisclosureFireSafety,
        value: fireSafety,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByFireSafety,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByCompletionNotes$(
        String completionNotes,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDisclosureCompletionNotes,
        value: completionNotes,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByCompletionNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyDisclosureCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDisclosure>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyDisclosure>? modelFilter,
        List<PropertyDisclosureInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyDisclosureUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyDisclosureEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    PropertyDisclosure propertyDisclosure, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyDisclosure.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            propertyDisclosure.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            propertyDisclosure.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    PropertyDisclosure propertyDisclosure, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyDisclosure.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyDisclosure.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyDisclosure.property = property;
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
PropertyDisclosure recursiveUpsert(PropertyDisclosure propertyDisclosure, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyDisclosure'} 
        : const {};
    if (propertyDisclosure.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        propertyDisclosure.org = OrganizationStore.instance.recursiveUpsert(propertyDisclosure.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyDisclosure.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyDisclosure.property = PropertyStore.instance.recursiveUpsert(propertyDisclosure.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyDisclosure);
}

  List<PropertyDisclosure> recursiveListUpsert(List<PropertyDisclosure> propertyDisclosures, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyDisclosures = <PropertyDisclosure>[];
    for (var propertyDisclosure in propertyDisclosures) {
        updatedPropertyDisclosures.add(recursiveUpsert(propertyDisclosure, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyDisclosures;
}

//   @override
//   PropertyDisclosure upsert(PropertyDisclosure item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyDisclosureInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyDisclosureInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyDisclosure) => PropertyDisclosureStore.instance
            .getOrg$(propertyDisclosure, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyDisclosure) => PropertyDisclosureStore.instance
            .getOrg(propertyDisclosure, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyDisclosureInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyDisclosure) => PropertyDisclosureStore.instance
            .getProperty$(propertyDisclosure, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyDisclosure) => PropertyDisclosureStore.instance
            .getProperty(propertyDisclosure, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyDisclosureEndpoints implements Endpoint {

    getAll('/propertyDisclosure', HttpMethod.post, List<PropertyDisclosure>),
	getById('/propertyDisclosure/byId/:id', HttpMethod.post, PropertyDisclosure),
	getManyByOrgId('/propertyDisclosure/byOrgId/:orgId', HttpMethod.post, List<PropertyDisclosure>),
	getByPropertyId('/propertyDisclosure/byPropertyId/:propertyId', HttpMethod.post, PropertyDisclosure),
	getManyByPackStatus('/propertyDisclosure/byPackStatus/:packStatus', HttpMethod.post, List<PropertyDisclosure>),
	getManyByCreatedDate('/propertyDisclosure/byCreatedDate/:createdDate', HttpMethod.post, List<PropertyDisclosure>),
	getManyBySubmittedDate('/propertyDisclosure/bySubmittedDate/:submittedDate', HttpMethod.post, List<PropertyDisclosure>),
	getManyByEnergyPerformanceCertificate('/propertyDisclosure/byEnergyPerformanceCertificate/:energyPerformanceCertificate', HttpMethod.post, List<PropertyDisclosure>),
	getManyByFloorPlan('/propertyDisclosure/byFloorPlan/:floorPlan', HttpMethod.post, List<PropertyDisclosure>),
	getManyByLeaseholdInfo('/propertyDisclosure/byLeaseholdInfo/:leaseholdInfo', HttpMethod.post, List<PropertyDisclosure>),
	getManyByBoundaryPlan('/propertyDisclosure/byBoundaryPlan/:boundaryPlan', HttpMethod.post, List<PropertyDisclosure>),
	getManyByPlanningPermission('/propertyDisclosure/byPlanningPermission/:planningPermission', HttpMethod.post, List<PropertyDisclosure>),
	getManyByPropertyQuestionnaire('/propertyDisclosure/byPropertyQuestionnaire/:propertyQuestionnaire', HttpMethod.post, List<PropertyDisclosure>),
	getManyByElectricalSafety('/propertyDisclosure/byElectricalSafety/:electricalSafety', HttpMethod.post, List<PropertyDisclosure>),
	getManyByGasSafety('/propertyDisclosure/byGasSafety/:gasSafety', HttpMethod.post, List<PropertyDisclosure>),
	getManyByFireSafety('/propertyDisclosure/byFireSafety/:fireSafety', HttpMethod.post, List<PropertyDisclosure>),
	getManyByCompletionNotes('/propertyDisclosure/byCompletionNotes/:completionNotes', HttpMethod.post, List<PropertyDisclosure>),
	getManyByCreatedAt('/propertyDisclosure/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyDisclosure>),
	getManyByUpdatedAt('/propertyDisclosure/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyDisclosure>);

    const PropertyDisclosureEndpoints(this.path, this.method, this.responseType);

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
