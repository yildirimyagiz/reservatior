
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class FacilityStore extends ModelStreamStore<String, Facility> {

  static FacilityStore? _instance;

  static FacilityStore get instance {
    _instance ??= FacilityStore();
    return _instance!;
  }

  FacilityStore() : super(Facility.fromJson) {
    if (_instance != null) {
        throw Exception(
            'FacilityStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending FacilityStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use FacilityStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getFacilityId(Facility facility) => facility.id;

	String? getFacilityOrgId(Facility facility) => facility.orgId;

	String? getFacilityPropertyId(Facility facility) => facility.propertyId;

	String? getFacilityName(Facility facility) => facility.name;

	double? getFacilityFeeAmount(Facility facility) => facility.feeAmount;

	String? getFacilityFeeCurrency(Facility facility) => facility.feeCurrency;

	String? getFacilityNotes(Facility facility) => facility.notes;

	String? getFacilityCreatedBy(Facility facility) => facility.createdBy;

	DateTime? getFacilityCreatedAt(Facility facility) => facility.createdAt;

	DateTime? getFacilityUpdatedAt(Facility facility) => facility.updatedAt;

	DateTime? getFacilityDeletedAt(Facility facility) => facility.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Facility> getByOrgId(
    String orgId,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByPropertyId(
    String propertyId,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByName(
    String name,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityName, name, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByFeeAmount(
    double feeAmount,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityFeeAmount, feeAmount, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByFeeCurrency(
    String feeCurrency,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityFeeCurrency, feeCurrency, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByNotes(
    String notes,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByCreatedBy(
    String createdBy,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Facility> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}
    ) =>
    getManyIncluding(getFacilityDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Facility facility, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (facility.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(facility.orgId!, includes: includes);
        facility.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Facility facility, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (facility.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(facility.propertyId!, includes: includes);
        facility.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<Agency> getAgencies(
    Facility facility, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getByFacilityId(facility.$uid!, modelFilter: modelFilter, includes: includes);
    facility.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Expense> getExpenses(
    Facility facility, {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    final expenses = ExpenseStore.instance.getByFacilityId(facility.$uid!, modelFilter: modelFilter, includes: includes);
    facility.expenses = expenses;
    // setIncludedReferencesForList(expenses, includes: includes);
    return expenses;
}

	List<ExtraCharge> getExtraCharges(
    Facility facility, {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    final extraCharges = ExtraChargeStore.instance.getByFacilityId(facility.$uid!, modelFilter: modelFilter, includes: includes);
    facility.extraCharges = extraCharges;
    // setIncludedReferencesForList(extraCharges, includes: includes);
    return extraCharges;
}

	List<FacilityBlock> getFacilityBlocks(
    Facility facility, {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}) {
    final facilityBlocks = FacilityBlockStore.instance.getByFacilityId(facility.$uid!, modelFilter: modelFilter, includes: includes);
    facility.facilityBlocks = facilityBlocks;
    // setIncludedReferencesForList(facilityBlocks, includes: includes);
    return facilityBlocks;
}

	List<IncludedService> getIncludedServices(
    Facility facility, {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    final includedServices = IncludedServiceStore.instance.getByFacilityId(facility.$uid!, modelFilter: modelFilter, includes: includes);
    facility.includedServices = includedServices;
    // setIncludedReferencesForList(includedServices, includes: includes);
    return includedServices;
}

	List<SharedAmenity> getSharedAmenities(
    Facility facility, {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}) {
    final sharedAmenities = SharedAmenityStore.instance.getByFacilityId(facility.$uid!, modelFilter: modelFilter, includes: includes);
    facility.sharedAmenities = sharedAmenities;
    // setIncludedReferencesForList(sharedAmenities, includes: includes);
    return sharedAmenities;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Facility>> getAll$({bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: FacilityEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Facility?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getFacilityId,
        value: id,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Facility>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityName,
        value: name,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByFeeAmount$(
        double feeAmount,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getFacilityFeeAmount,
        value: feeAmount,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByFeeAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByFeeCurrency$(
        String feeCurrency,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityFeeCurrency,
        value: feeCurrency,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByFeeCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFacilityCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFacilityUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Facility>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Facility>? modelFilter,
        List<FacilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFacilityDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: FacilityEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Facility facility, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (facility.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            facility.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            facility.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Facility facility, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (facility.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            facility.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            facility.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Agency>> getAgencies$(
    Facility facility, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getByFacilityId$(
        facility.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        facility.agencies = agencies;
    });

}

	Stream<List<Expense>> getExpenses$(
    Facility facility, {bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    return ExpenseStore.instance.getByFacilityId$(
        facility.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((expenses) {
        facility.expenses = expenses;
    });

}

	Stream<List<ExtraCharge>> getExtraCharges$(
    Facility facility, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    return ExtraChargeStore.instance.getByFacilityId$(
        facility.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((extraCharges) {
        facility.extraCharges = extraCharges;
    });

}

	Stream<List<FacilityBlock>> getFacilityBlocks$(
    Facility facility, {bool useCache = true, ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}) {
    return FacilityBlockStore.instance.getByFacilityId$(
        facility.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((facilityBlocks) {
        facility.facilityBlocks = facilityBlocks;
    });

}

	Stream<List<IncludedService>> getIncludedServices$(
    Facility facility, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    return IncludedServiceStore.instance.getByFacilityId$(
        facility.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((includedServices) {
        facility.includedServices = includedServices;
    });

}

	Stream<List<SharedAmenity>> getSharedAmenities$(
    Facility facility, {bool useCache = true, ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}) {
    return SharedAmenityStore.instance.getByFacilityId$(
        facility.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((sharedAmenities) {
        facility.sharedAmenities = sharedAmenities;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Facility recursiveUpsert(Facility facility, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Facility'} 
        : const {};
    if (facility.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        facility.org = OrganizationStore.instance.recursiveUpsert(facility.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (facility.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        facility.property = PropertyStore.instance.recursiveUpsert(facility.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (facility.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        facility.agencies = AgencyStore.instance.recursiveListUpsert(facility.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (facility.expenses != null && (!preventCircularSerialization || !upsertedTypes.contains('Expense'))) {
        facility.expenses = ExpenseStore.instance.recursiveListUpsert(facility.expenses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (facility.extraCharges != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        facility.extraCharges = ExtraChargeStore.instance.recursiveListUpsert(facility.extraCharges!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (facility.facilityBlocks != null && (!preventCircularSerialization || !upsertedTypes.contains('FacilityBlock'))) {
        facility.facilityBlocks = FacilityBlockStore.instance.recursiveListUpsert(facility.facilityBlocks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (facility.includedServices != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        facility.includedServices = IncludedServiceStore.instance.recursiveListUpsert(facility.includedServices!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (facility.sharedAmenities != null && (!preventCircularSerialization || !upsertedTypes.contains('SharedAmenity'))) {
        facility.sharedAmenities = SharedAmenityStore.instance.recursiveListUpsert(facility.sharedAmenities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(facility);
}

  List<Facility> recursiveListUpsert(List<Facility> facilitys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedFacilitys = <Facility>[];
    for (var facility in facilitys) {
        updatedFacilitys.add(recursiveUpsert(facility, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedFacilitys;
}

//   @override
//   Facility upsert(Facility item) {
//     return recursiveUpsert(item);
//   }

}


class FacilityInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      FacilityInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facility) => FacilityStore.instance
            .getOrg$(facility, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facility) => FacilityStore.instance
            .getOrg(facility, modelFilter: modelFilter, includes: includes);
      }
}

	FacilityInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facility) => FacilityStore.instance
            .getProperty$(facility, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facility) => FacilityStore.instance
            .getProperty(facility, modelFilter: modelFilter, includes: includes);
      }
}

	FacilityInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facility) => FacilityStore.instance
            .getAgencies$(facility, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facility) => FacilityStore.instance
            .getAgencies(facility, modelFilter: modelFilter, includes: includes);
      }
}

	FacilityInclude.expenses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Expense>? modelFilter,
    List<ExpenseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facility) => FacilityStore.instance
            .getExpenses$(facility, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facility) => FacilityStore.instance
            .getExpenses(facility, modelFilter: modelFilter, includes: includes);
      }
}

	FacilityInclude.extraCharges({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facility) => FacilityStore.instance
            .getExtraCharges$(facility, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facility) => FacilityStore.instance
            .getExtraCharges(facility, modelFilter: modelFilter, includes: includes);
      }
}

	FacilityInclude.facilityBlocks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FacilityBlock>? modelFilter,
    List<FacilityBlockInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facility) => FacilityStore.instance
            .getFacilityBlocks$(facility, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facility) => FacilityStore.instance
            .getFacilityBlocks(facility, modelFilter: modelFilter, includes: includes);
      }
}

	FacilityInclude.includedServices({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facility) => FacilityStore.instance
            .getIncludedServices$(facility, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facility) => FacilityStore.instance
            .getIncludedServices(facility, modelFilter: modelFilter, includes: includes);
      }
}

	FacilityInclude.sharedAmenities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SharedAmenity>? modelFilter,
    List<SharedAmenityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facility) => FacilityStore.instance
            .getSharedAmenities$(facility, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facility) => FacilityStore.instance
            .getSharedAmenities(facility, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum FacilityEndpoints implements Endpoint {

    getAll('/facility', HttpMethod.post, List<Facility>),
	getById('/facility/byId/:id', HttpMethod.post, Facility),
	getManyByOrgId('/facility/byOrgId/:orgId', HttpMethod.post, List<Facility>),
	getManyByPropertyId('/facility/byPropertyId/:propertyId', HttpMethod.post, List<Facility>),
	getManyByName('/facility/byName/:name', HttpMethod.post, List<Facility>),
	getManyByFeeAmount('/facility/byFeeAmount/:feeAmount', HttpMethod.post, List<Facility>),
	getManyByFeeCurrency('/facility/byFeeCurrency/:feeCurrency', HttpMethod.post, List<Facility>),
	getManyByNotes('/facility/byNotes/:notes', HttpMethod.post, List<Facility>),
	getManyByCreatedBy('/facility/byCreatedBy/:createdBy', HttpMethod.post, List<Facility>),
	getManyByCreatedAt('/facility/byCreatedAt/:createdAt', HttpMethod.post, List<Facility>),
	getManyByUpdatedAt('/facility/byUpdatedAt/:updatedAt', HttpMethod.post, List<Facility>),
	getManyByDeletedAt('/facility/byDeletedAt/:deletedAt', HttpMethod.post, List<Facility>);

    const FacilityEndpoints(this.path, this.method, this.responseType);

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
