
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyInventoryStore extends ModelStreamStore<String, PropertyInventory> {

  static PropertyInventoryStore? _instance;

  static PropertyInventoryStore get instance {
    _instance ??= PropertyInventoryStore();
    return _instance!;
  }

  PropertyInventoryStore() : super(PropertyInventory.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyInventoryStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyInventoryStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyInventoryStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyInventoryId(PropertyInventory propertyInventory) => propertyInventory.id;

	String? getPropertyInventoryOrgId(PropertyInventory propertyInventory) => propertyInventory.orgId;

	String? getPropertyInventoryPropertyId(PropertyInventory propertyInventory) => propertyInventory.propertyId;

	String? getPropertyInventoryLeaseId(PropertyInventory propertyInventory) => propertyInventory.leaseId;

	String? getPropertyInventoryInventoryType(PropertyInventory propertyInventory) => propertyInventory.inventoryType;

	DateTime? getPropertyInventoryInventoryDate(PropertyInventory propertyInventory) => propertyInventory.inventoryDate;

	String? getPropertyInventoryConductedBy(PropertyInventory propertyInventory) => propertyInventory.conductedBy;

	List<String>? getPropertyInventoryPresentAtCheck(PropertyInventory propertyInventory) => propertyInventory.presentAtCheck;

	dynamic? getPropertyInventoryRooms(PropertyInventory propertyInventory) => propertyInventory.rooms;

	String? getPropertyInventoryOverallCondition(PropertyInventory propertyInventory) => propertyInventory.overallCondition;

	dynamic? getPropertyInventoryDamages(PropertyInventory propertyInventory) => propertyInventory.damages;

	bool? getPropertyInventoryCleaningRequired(PropertyInventory propertyInventory) => propertyInventory.cleaningRequired;

	String? getPropertyInventoryTenantSignature(PropertyInventory propertyInventory) => propertyInventory.tenantSignature;

	String? getPropertyInventoryLandlordSignature(PropertyInventory propertyInventory) => propertyInventory.landlordSignature;

	String? getPropertyInventoryAgentSignature(PropertyInventory propertyInventory) => propertyInventory.agentSignature;

	String? getPropertyInventoryReportUrl(PropertyInventory propertyInventory) => propertyInventory.reportUrl;

	dynamic? getPropertyInventoryPhotos(PropertyInventory propertyInventory) => propertyInventory.photos;

	DateTime? getPropertyInventoryCreatedAt(PropertyInventory propertyInventory) => propertyInventory.createdAt;

	DateTime? getPropertyInventoryUpdatedAt(PropertyInventory propertyInventory) => propertyInventory.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyInventory> getByOrgId(
    String orgId,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByLeaseId(
    String leaseId,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByInventoryType(
    String inventoryType,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryInventoryType, inventoryType, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByInventoryDate(
    DateTime inventoryDate,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryInventoryDate, inventoryDate, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByConductedBy(
    String conductedBy,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryConductedBy, conductedBy, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByPresentAtCheck(
    String presentAtCheck,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryPresentAtCheck, presentAtCheck, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByRooms(
    dynamic rooms,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryRooms, rooms, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByOverallCondition(
    String overallCondition,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryOverallCondition, overallCondition, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByDamages(
    dynamic damages,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryDamages, damages, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByCleaningRequired(
    bool cleaningRequired,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryCleaningRequired, cleaningRequired, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByTenantSignature(
    String tenantSignature,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryTenantSignature, tenantSignature, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByLandlordSignature(
    String landlordSignature,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryLandlordSignature, landlordSignature, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByAgentSignature(
    String agentSignature,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryAgentSignature, agentSignature, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByReportUrl(
    String reportUrl,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryReportUrl, reportUrl, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByPhotos(
    dynamic photos,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryPhotos, photos, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyInventory> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInventoryUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Lease? getLease(
    PropertyInventory propertyInventory, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (propertyInventory.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(propertyInventory.leaseId!, includes: includes);
        propertyInventory.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Organization? getOrg(
    PropertyInventory propertyInventory, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyInventory.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(propertyInventory.orgId!, includes: includes);
        propertyInventory.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    PropertyInventory propertyInventory, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyInventory.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyInventory.propertyId!, includes: includes);
        propertyInventory.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyInventory>> getAll$({bool useCache = true, ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyInventoryEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyInventory?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyInventoryId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyInventory>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByInventoryType$(
        String inventoryType,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryInventoryType,
        value: inventoryType,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByInventoryType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByInventoryDate$(
        DateTime inventoryDate,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyInventoryInventoryDate,
        value: inventoryDate,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByInventoryDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByConductedBy$(
        String conductedBy,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryConductedBy,
        value: conductedBy,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByConductedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByPresentAtCheck$(
        String presentAtCheck,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryPresentAtCheck,
        value: presentAtCheck,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByPresentAtCheck,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByRooms$(
        dynamic rooms,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyInventoryRooms,
        value: rooms,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByRooms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByOverallCondition$(
        String overallCondition,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryOverallCondition,
        value: overallCondition,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByOverallCondition,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByDamages$(
        dynamic damages,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyInventoryDamages,
        value: damages,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByDamages,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByCleaningRequired$(
        bool cleaningRequired,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPropertyInventoryCleaningRequired,
        value: cleaningRequired,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByCleaningRequired,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByTenantSignature$(
        String tenantSignature,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryTenantSignature,
        value: tenantSignature,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByTenantSignature,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByLandlordSignature$(
        String landlordSignature,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryLandlordSignature,
        value: landlordSignature,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByLandlordSignature,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByAgentSignature$(
        String agentSignature,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryAgentSignature,
        value: agentSignature,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByAgentSignature,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByReportUrl$(
        String reportUrl,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInventoryReportUrl,
        value: reportUrl,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByReportUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByPhotos$(
        dynamic photos,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyInventoryPhotos,
        value: photos,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByPhotos,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyInventoryCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyInventory>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyInventory>? modelFilter,
        List<PropertyInventoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyInventoryUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyInventoryEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Lease?> getLease$(
    PropertyInventory propertyInventory, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (propertyInventory.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            propertyInventory.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            propertyInventory.lease = lease;
        });
    }
}

	Stream<Organization?> getOrg$(
    PropertyInventory propertyInventory, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyInventory.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            propertyInventory.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            propertyInventory.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    PropertyInventory propertyInventory, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyInventory.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyInventory.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyInventory.property = property;
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
PropertyInventory recursiveUpsert(PropertyInventory propertyInventory, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyInventory'} 
        : const {};
    if (propertyInventory.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        propertyInventory.lease = LeaseStore.instance.recursiveUpsert(propertyInventory.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyInventory.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        propertyInventory.org = OrganizationStore.instance.recursiveUpsert(propertyInventory.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyInventory.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyInventory.property = PropertyStore.instance.recursiveUpsert(propertyInventory.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyInventory);
}

  List<PropertyInventory> recursiveListUpsert(List<PropertyInventory> propertyInventorys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyInventorys = <PropertyInventory>[];
    for (var propertyInventory in propertyInventorys) {
        updatedPropertyInventorys.add(recursiveUpsert(propertyInventory, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyInventorys;
}

//   @override
//   PropertyInventory upsert(PropertyInventory item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyInventoryInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyInventoryInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyInventory) => PropertyInventoryStore.instance
            .getLease$(propertyInventory, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyInventory) => PropertyInventoryStore.instance
            .getLease(propertyInventory, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInventoryInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyInventory) => PropertyInventoryStore.instance
            .getOrg$(propertyInventory, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyInventory) => PropertyInventoryStore.instance
            .getOrg(propertyInventory, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInventoryInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyInventory) => PropertyInventoryStore.instance
            .getProperty$(propertyInventory, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyInventory) => PropertyInventoryStore.instance
            .getProperty(propertyInventory, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyInventoryEndpoints implements Endpoint {

    getAll('/propertyInventory', HttpMethod.post, List<PropertyInventory>),
	getById('/propertyInventory/byId/:id', HttpMethod.post, PropertyInventory),
	getManyByOrgId('/propertyInventory/byOrgId/:orgId', HttpMethod.post, List<PropertyInventory>),
	getManyByPropertyId('/propertyInventory/byPropertyId/:propertyId', HttpMethod.post, List<PropertyInventory>),
	getManyByLeaseId('/propertyInventory/byLeaseId/:leaseId', HttpMethod.post, List<PropertyInventory>),
	getManyByInventoryType('/propertyInventory/byInventoryType/:inventoryType', HttpMethod.post, List<PropertyInventory>),
	getManyByInventoryDate('/propertyInventory/byInventoryDate/:inventoryDate', HttpMethod.post, List<PropertyInventory>),
	getManyByConductedBy('/propertyInventory/byConductedBy/:conductedBy', HttpMethod.post, List<PropertyInventory>),
	getManyByPresentAtCheck('/propertyInventory/byPresentAtCheck/:presentAtCheck', HttpMethod.post, List<PropertyInventory>),
	getManyByRooms('/propertyInventory/byRooms/:rooms', HttpMethod.post, List<PropertyInventory>),
	getManyByOverallCondition('/propertyInventory/byOverallCondition/:overallCondition', HttpMethod.post, List<PropertyInventory>),
	getManyByDamages('/propertyInventory/byDamages/:damages', HttpMethod.post, List<PropertyInventory>),
	getManyByCleaningRequired('/propertyInventory/byCleaningRequired/:cleaningRequired', HttpMethod.post, List<PropertyInventory>),
	getManyByTenantSignature('/propertyInventory/byTenantSignature/:tenantSignature', HttpMethod.post, List<PropertyInventory>),
	getManyByLandlordSignature('/propertyInventory/byLandlordSignature/:landlordSignature', HttpMethod.post, List<PropertyInventory>),
	getManyByAgentSignature('/propertyInventory/byAgentSignature/:agentSignature', HttpMethod.post, List<PropertyInventory>),
	getManyByReportUrl('/propertyInventory/byReportUrl/:reportUrl', HttpMethod.post, List<PropertyInventory>),
	getManyByPhotos('/propertyInventory/byPhotos/:photos', HttpMethod.post, List<PropertyInventory>),
	getManyByCreatedAt('/propertyInventory/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyInventory>),
	getManyByUpdatedAt('/propertyInventory/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyInventory>);

    const PropertyInventoryEndpoints(this.path, this.method, this.responseType);

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
