
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ContractStore extends ModelStreamStore<String, Contract> {

  static ContractStore? _instance;

  static ContractStore get instance {
    _instance ??= ContractStore();
    return _instance!;
  }

  ContractStore() : super(Contract.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ContractStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ContractStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ContractStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getContractId(Contract contract) => contract.id;

	String? getContractOrgId(Contract contract) => contract.orgId;

	String? getContractPropertyId(Contract contract) => contract.propertyId;

	String? getContractListingId(Contract contract) => contract.listingId;

	String? getContractLeaseId(Contract contract) => contract.leaseId;

	String? getContractBookingId(Contract contract) => contract.bookingId;

	ContractType? getContractType(Contract contract) => contract.type;

	ContractStatus? getContractStatus(Contract contract) => contract.status;

	String? getContractTitle(Contract contract) => contract.title;

	DateTime? getContractEffectiveFrom(Contract contract) => contract.effectiveFrom;

	DateTime? getContractEffectiveTo(Contract contract) => contract.effectiveTo;

	DateTime? getContractNextRenewalAt(Contract contract) => contract.nextRenewalAt;

	int? getContractRenewalNoticeDays(Contract contract) => contract.renewalNoticeDays;

	String? getContractCreatedBy(Contract contract) => contract.createdBy;

	DateTime? getContractCreatedAt(Contract contract) => contract.createdAt;

	DateTime? getContractUpdatedAt(Contract contract) => contract.updatedAt;

	DateTime? getContractDeletedAt(Contract contract) => contract.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Contract> getByOrgId(
    String orgId,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByPropertyId(
    String propertyId,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByListingId(
    String listingId,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByLeaseId(
    String leaseId,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByBookingId(
    String bookingId,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractBookingId, bookingId, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByType(
    ContractType type,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractType, type, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByStatus(
    ContractStatus status,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByTitle(
    String title,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByEffectiveFrom(
    DateTime effectiveFrom,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractEffectiveFrom, effectiveFrom, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByEffectiveTo(
    DateTime effectiveTo,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractEffectiveTo, effectiveTo, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByNextRenewalAt(
    DateTime nextRenewalAt,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractNextRenewalAt, nextRenewalAt, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByRenewalNoticeDays(
    int renewalNoticeDays,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractRenewalNoticeDays, renewalNoticeDays, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByCreatedBy(
    String createdBy,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Contract> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}
    ) =>
    getManyIncluding(getContractDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Booking? getBooking(
    Contract contract, {ModelFilter? modelFilter, List<BookingInclude>? includes}) {
    if (contract.bookingId == null) {
        return null;
    } else {
        final booking = BookingStore.instance.getById(contract.bookingId!, includes: includes);
        contract.booking = booking;
        // setIncludedReferences(booking, includes: includes);
        return booking;
    }
}

	Lease? getLease(
    Contract contract, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (contract.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(contract.leaseId!, includes: includes);
        contract.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Listing? getListing(
    Contract contract, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (contract.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(contract.listingId!, includes: includes);
        contract.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    Contract contract, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (contract.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(contract.orgId!, includes: includes);
        contract.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Contract contract, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (contract.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(contract.propertyId!, includes: includes);
        contract.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<ContractVersion> getVersions(
    Contract contract, {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}) {
    final versions = ContractVersionStore.instance.getByContractId(contract.$uid!, modelFilter: modelFilter, includes: includes);
    contract.versions = versions;
    // setIncludedReferencesForList(versions, includes: includes);
    return versions;
}

	List<Document> getGeneralDocuments(
    Contract contract, {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    final generalDocuments = DocumentStore.instance.getByContractId(contract.$uid!, modelFilter: modelFilter, includes: includes);
    contract.generalDocuments = generalDocuments;
    // setIncludedReferencesForList(generalDocuments, includes: includes);
    return generalDocuments;
}

	List<SignatureRequest> getSignatureRequests(
    Contract contract, {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}) {
    final signatureRequests = SignatureRequestStore.instance.getByContractId(contract.$uid!, modelFilter: modelFilter, includes: includes);
    contract.signatureRequests = signatureRequests;
    // setIncludedReferencesForList(signatureRequests, includes: includes);
    return signatureRequests;
}

	List<Task> getTasks(
    Contract contract, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByContractId(contract.$uid!, modelFilter: modelFilter, includes: includes);
    contract.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<Agency> getAgencies(
    Contract contract, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(contract.$uid!, modelFilter: modelFilter, includes: includes);
    contract.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Tenant> getTenants(
    Contract contract, {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    final tenants = TenantStore.instance.getBy(contract.$uid!, modelFilter: modelFilter, includes: includes);
    contract.tenants = tenants;
    // setIncludedReferencesForList(tenants, includes: includes);
    return tenants;
}

	List<Increase> getIncreases(
    Contract contract, {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}) {
    final increases = IncreaseStore.instance.getByContractId(contract.$uid!, modelFilter: modelFilter, includes: includes);
    contract.increases = increases;
    // setIncludedReferencesForList(increases, includes: includes);
    return increases;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Contract>> getAll$({bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ContractEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Contract?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getContractId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Contract>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByBookingId$(
        String bookingId,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractBookingId,
        value: bookingId,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByBookingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByType$(
        ContractType type,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<ContractType>(
        getPropVal: getContractType,
        value: type,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByStatus$(
        ContractStatus status,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<ContractStatus>(
        getPropVal: getContractStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByEffectiveFrom$(
        DateTime effectiveFrom,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractEffectiveFrom,
        value: effectiveFrom,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByEffectiveFrom,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByEffectiveTo$(
        DateTime effectiveTo,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractEffectiveTo,
        value: effectiveTo,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByEffectiveTo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByNextRenewalAt$(
        DateTime nextRenewalAt,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractNextRenewalAt,
        value: nextRenewalAt,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByNextRenewalAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByRenewalNoticeDays$(
        int renewalNoticeDays,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getContractRenewalNoticeDays,
        value: renewalNoticeDays,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByRenewalNoticeDays,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contract>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Contract>? modelFilter,
        List<ContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ContractEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Booking?> getBooking$(
    Contract contract, {bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    if (contract.bookingId == null) {
        return Stream.value(null);
    } else {
        return BookingStore.instance.getById$(
            contract.bookingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((booking) {
            contract.booking = booking;
        });
    }
}

	Stream<Lease?> getLease$(
    Contract contract, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (contract.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            contract.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            contract.lease = lease;
        });
    }
}

	Stream<Listing?> getListing$(
    Contract contract, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (contract.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            contract.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            contract.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    Contract contract, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (contract.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            contract.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            contract.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Contract contract, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (contract.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            contract.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            contract.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<ContractVersion>> getVersions$(
    Contract contract, {bool useCache = true, ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}) {
    return ContractVersionStore.instance.getByContractId$(
        contract.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((versions) {
        contract.versions = versions;
    });

}

	Stream<List<Document>> getGeneralDocuments$(
    Contract contract, {bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    return DocumentStore.instance.getByContractId$(
        contract.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((generalDocuments) {
        contract.generalDocuments = generalDocuments;
    });

}

	Stream<List<SignatureRequest>> getSignatureRequests$(
    Contract contract, {bool useCache = true, ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}) {
    return SignatureRequestStore.instance.getByContractId$(
        contract.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((signatureRequests) {
        contract.signatureRequests = signatureRequests;
    });

}

	Stream<List<Task>> getTasks$(
    Contract contract, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByContractId$(
        contract.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        contract.tasks = tasks;
    });

}

	Stream<List<Agency>> getAgencies$(
    Contract contract, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        contract.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        contract.agencies = agencies;
    });

}

	Stream<List<Tenant>> getTenants$(
    Contract contract, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    return TenantStore.instance.getBy$(
        contract.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenants) {
        contract.tenants = tenants;
    });

}

	Stream<List<Increase>> getIncreases$(
    Contract contract, {bool useCache = true, ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}) {
    return IncreaseStore.instance.getByContractId$(
        contract.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((increases) {
        contract.increases = increases;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Contract recursiveUpsert(Contract contract, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Contract'} 
        : const {};
    if (contract.booking != null && (!preventCircularSerialization || !upsertedTypes.contains('Booking'))) {
        contract.booking = BookingStore.instance.recursiveUpsert(contract.booking!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        contract.lease = LeaseStore.instance.recursiveUpsert(contract.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        contract.listing = ListingStore.instance.recursiveUpsert(contract.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        contract.org = OrganizationStore.instance.recursiveUpsert(contract.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        contract.property = PropertyStore.instance.recursiveUpsert(contract.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.versions != null && (!preventCircularSerialization || !upsertedTypes.contains('ContractVersion'))) {
        contract.versions = ContractVersionStore.instance.recursiveListUpsert(contract.versions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.generalDocuments != null && (!preventCircularSerialization || !upsertedTypes.contains('Document'))) {
        contract.generalDocuments = DocumentStore.instance.recursiveListUpsert(contract.generalDocuments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.signatureRequests != null && (!preventCircularSerialization || !upsertedTypes.contains('SignatureRequest'))) {
        contract.signatureRequests = SignatureRequestStore.instance.recursiveListUpsert(contract.signatureRequests!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        contract.tasks = TaskStore.instance.recursiveListUpsert(contract.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        contract.agencies = AgencyStore.instance.recursiveListUpsert(contract.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.tenants != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        contract.tenants = TenantStore.instance.recursiveListUpsert(contract.tenants!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contract.increases != null && (!preventCircularSerialization || !upsertedTypes.contains('Increase'))) {
        contract.increases = IncreaseStore.instance.recursiveListUpsert(contract.increases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(contract);
}

  List<Contract> recursiveListUpsert(List<Contract> contracts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedContracts = <Contract>[];
    for (var contract in contracts) {
        updatedContracts.add(recursiveUpsert(contract, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedContracts;
}

//   @override
//   Contract upsert(Contract item) {
//     return recursiveUpsert(item);
//   }

}


class ContractInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ContractInclude.booking({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Booking>? modelFilter,
    List<BookingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getBooking$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getBooking(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getLease$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getLease(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getListing$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getListing(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getOrg$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getOrg(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getProperty$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getProperty(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.versions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ContractVersion>? modelFilter,
    List<ContractVersionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getVersions$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getVersions(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.generalDocuments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Document>? modelFilter,
    List<DocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getGeneralDocuments$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getGeneralDocuments(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.signatureRequests({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SignatureRequest>? modelFilter,
    List<SignatureRequestInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getSignatureRequests$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getSignatureRequests(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getTasks$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getTasks(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getAgencies$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getAgencies(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.tenants({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getTenants$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getTenants(contract, modelFilter: modelFilter, includes: includes);
      }
}

	ContractInclude.increases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Increase>? modelFilter,
    List<IncreaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contract) => ContractStore.instance
            .getIncreases$(contract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contract) => ContractStore.instance
            .getIncreases(contract, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ContractEndpoints implements Endpoint {

    getAll('/contract', HttpMethod.post, List<Contract>),
	getById('/contract/byId/:id', HttpMethod.post, Contract),
	getManyByOrgId('/contract/byOrgId/:orgId', HttpMethod.post, List<Contract>),
	getManyByPropertyId('/contract/byPropertyId/:propertyId', HttpMethod.post, List<Contract>),
	getManyByListingId('/contract/byListingId/:listingId', HttpMethod.post, List<Contract>),
	getManyByLeaseId('/contract/byLeaseId/:leaseId', HttpMethod.post, List<Contract>),
	getManyByBookingId('/contract/byBookingId/:bookingId', HttpMethod.post, List<Contract>),
	getManyByType('/contract/byType/:type', HttpMethod.post, List<Contract>),
	getManyByStatus('/contract/byStatus/:status', HttpMethod.post, List<Contract>),
	getManyByTitle('/contract/byTitle/:title', HttpMethod.post, List<Contract>),
	getManyByEffectiveFrom('/contract/byEffectiveFrom/:effectiveFrom', HttpMethod.post, List<Contract>),
	getManyByEffectiveTo('/contract/byEffectiveTo/:effectiveTo', HttpMethod.post, List<Contract>),
	getManyByNextRenewalAt('/contract/byNextRenewalAt/:nextRenewalAt', HttpMethod.post, List<Contract>),
	getManyByRenewalNoticeDays('/contract/byRenewalNoticeDays/:renewalNoticeDays', HttpMethod.post, List<Contract>),
	getManyByCreatedBy('/contract/byCreatedBy/:createdBy', HttpMethod.post, List<Contract>),
	getManyByCreatedAt('/contract/byCreatedAt/:createdAt', HttpMethod.post, List<Contract>),
	getManyByUpdatedAt('/contract/byUpdatedAt/:updatedAt', HttpMethod.post, List<Contract>),
	getManyByDeletedAt('/contract/byDeletedAt/:deletedAt', HttpMethod.post, List<Contract>);

    const ContractEndpoints(this.path, this.method, this.responseType);

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
