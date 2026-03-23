
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class LeaseStore extends ModelStreamStore<String, Lease> {

  static LeaseStore? _instance;

  static LeaseStore get instance {
    _instance ??= LeaseStore();
    return _instance!;
  }

  LeaseStore() : super(Lease.fromJson) {
    if (_instance != null) {
        throw Exception(
            'LeaseStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending LeaseStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use LeaseStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getLeaseId(Lease lease) => lease.id;

	String? getLeaseOrgId(Lease lease) => lease.orgId;

	String? getLeaseListingId(Lease lease) => lease.listingId;

	String? getLeaseTenantId(Lease lease) => lease.tenantId;

	LeaseStatus? getLeaseStatus(Lease lease) => lease.status;

	DateTime? getLeaseStartDate(Lease lease) => lease.startDate;

	DateTime? getLeaseEndDate(Lease lease) => lease.endDate;

	double? getLeaseRent(Lease lease) => lease.rent;

	String? getLeaseCurrency(Lease lease) => lease.currency;

	double? getLeaseDeposit(Lease lease) => lease.deposit;

	int? getLeaseRentDueDay(Lease lease) => lease.rentDueDay;

	String? getLeaseNotes(Lease lease) => lease.notes;

	bool? getLeaseIsActive(Lease lease) => lease.isActive;

	String? getLeaseCreatedBy(Lease lease) => lease.createdBy;

	DateTime? getLeaseCreatedAt(Lease lease) => lease.createdAt;

	DateTime? getLeaseUpdatedAt(Lease lease) => lease.updatedAt;

	DateTime? getLeaseDeletedAt(Lease lease) => lease.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Lease> getByOrgId(
    String orgId,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByListingId(
    String listingId,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByTenantId(
    String tenantId,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseTenantId, tenantId, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByStatus(
    LeaseStatus status,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByStartDate(
    DateTime startDate,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByEndDate(
    DateTime endDate,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByRent(
    double rent,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRent, rent, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByCurrency(
    String currency,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByDeposit(
    double deposit,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseDeposit, deposit, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByRentDueDay(
    int rentDueDay,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRentDueDay, rentDueDay, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByNotes(
    String notes,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByIsActive(
    bool isActive,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByCreatedBy(
    String createdBy,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Lease> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}
    ) =>
    getManyIncluding(getLeaseDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Listing? getListing(
    Lease lease, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (lease.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(lease.listingId!, includes: includes);
        lease.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    Lease lease, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (lease.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(lease.orgId!, includes: includes);
        lease.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Tenant? getTenant(
    Lease lease, {ModelFilter? modelFilter, List<TenantInclude>? includes}) {
    if (lease.tenantId == null) {
        return null;
    } else {
        final tenant = TenantStore.instance.getById(lease.tenantId!, includes: includes);
        lease.tenant = tenant;
        // setIncludedReferences(tenant, includes: includes);
        return tenant;
    }
}

  /// GET RELATED MODELS 

  List<Contract> getContracts(
    Lease lease, {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    final contracts = ContractStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.contracts = contracts;
    // setIncludedReferencesForList(contracts, includes: includes);
    return contracts;
}

	DepositProtection? getDepositProtection(
    Lease lease, {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}) {
    final depositProtection = DepositProtectionStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.depositProtection = depositProtection;
    // setIncludedReferences(depositProtection, includes: includes);
    return depositProtection;
}

	List<FinancialRecord> getFinancialRecords(
    Lease lease, {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    final financialRecords = FinancialRecordStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.financialRecords = financialRecords;
    // setIncludedReferencesForList(financialRecords, includes: includes);
    return financialRecords;
}

	ImmigrationStatusCheck? getImmigrationStatusCheck(
    Lease lease, {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}) {
    final immigrationStatusCheck = ImmigrationStatusCheckStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.immigrationStatusCheck = immigrationStatusCheck;
    // setIncludedReferences(immigrationStatusCheck, includes: includes);
    return immigrationStatusCheck;
}

	List<LeaseRenewal> getRenewals(
    Lease lease, {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}) {
    final renewals = LeaseRenewalStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.renewals = renewals;
    // setIncludedReferencesForList(renewals, includes: includes);
    return renewals;
}

	List<PropertyInventory> getInventories(
    Lease lease, {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}) {
    final inventories = PropertyInventoryStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.inventories = inventories;
    // setIncludedReferencesForList(inventories, includes: includes);
    return inventories;
}

	List<RentArrears> getRentArrears(
    Lease lease, {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}) {
    final rentArrears = RentArrearsStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.rentArrears = rentArrears;
    // setIncludedReferencesForList(rentArrears, includes: includes);
    return rentArrears;
}

	List<RentSchedule> getRentSchedules(
    Lease lease, {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}) {
    final rentSchedules = RentScheduleStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.rentSchedules = rentSchedules;
    // setIncludedReferencesForList(rentSchedules, includes: includes);
    return rentSchedules;
}

	List<RightToRentCheck> getRightToRentChecks(
    Lease lease, {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}) {
    final rightToRentChecks = RightToRentCheckStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.rightToRentChecks = rightToRentChecks;
    // setIncludedReferencesForList(rightToRentChecks, includes: includes);
    return rightToRentChecks;
}

	SecurityDepositProtection? getSecurityDepositProtection(
    Lease lease, {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}) {
    final securityDepositProtection = SecurityDepositProtectionStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.securityDepositProtection = securityDepositProtection;
    // setIncludedReferences(securityDepositProtection, includes: includes);
    return securityDepositProtection;
}

	List<Task> getTasks(
    Lease lease, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<Contact> getContact(
    Lease lease, {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    final Contact = ContactStore.instance.getBy(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.Contact = Contact;
    // setIncludedReferencesForList(Contact, includes: includes);
    return Contact;
}

	List<Payment> getPayment(
    Lease lease, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final Payment = PaymentStore.instance.getByLeaseId(lease.$uid!, modelFilter: modelFilter, includes: includes);
    lease.Payment = Payment;
    // setIncludedReferencesForList(Payment, includes: includes);
    return Payment;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Lease>> getAll$({bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: LeaseEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Lease?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLeaseId,
        value: id,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Lease>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByTenantId$(
        String tenantId,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseTenantId,
        value: tenantId,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByTenantId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByStatus$(
        LeaseStatus status,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<LeaseStatus>(
        getPropVal: getLeaseStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeaseStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeaseEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByRent$(
        double rent,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLeaseRent,
        value: rent,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByRent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByDeposit$(
        double deposit,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLeaseDeposit,
        value: deposit,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByDeposit,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByRentDueDay$(
        int rentDueDay,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLeaseRentDueDay,
        value: rentDueDay,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByRentDueDay,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLeaseIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeaseCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeaseUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lease>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Lease>? modelFilter,
        List<LeaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeaseDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: LeaseEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Listing?> getListing$(
    Lease lease, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (lease.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            lease.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            lease.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    Lease lease, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (lease.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            lease.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            lease.org = org;
        });
    }
}

	Stream<Tenant?> getTenant$(
    Lease lease, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    if (lease.tenantId == null) {
        return Stream.value(null);
    } else {
        return TenantStore.instance.getById$(
            lease.tenantId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((tenant) {
            lease.tenant = tenant;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Contract>> getContracts$(
    Lease lease, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    return ContractStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((contracts) {
        lease.contracts = contracts;
    });

}

	Stream<DepositProtection?> getDepositProtection$(
    Lease lease, {bool useCache = true, ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}) {
    return DepositProtectionStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((depositProtection) {
        lease.depositProtection = depositProtection;
    });

}

	Stream<List<FinancialRecord>> getFinancialRecords$(
    Lease lease, {bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    return FinancialRecordStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((financialRecords) {
        lease.financialRecords = financialRecords;
    });

}

	Stream<ImmigrationStatusCheck?> getImmigrationStatusCheck$(
    Lease lease, {bool useCache = true, ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}) {
    return ImmigrationStatusCheckStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((immigrationStatusCheck) {
        lease.immigrationStatusCheck = immigrationStatusCheck;
    });

}

	Stream<List<LeaseRenewal>> getRenewals$(
    Lease lease, {bool useCache = true, ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}) {
    return LeaseRenewalStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((renewals) {
        lease.renewals = renewals;
    });

}

	Stream<List<PropertyInventory>> getInventories$(
    Lease lease, {bool useCache = true, ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}) {
    return PropertyInventoryStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((inventories) {
        lease.inventories = inventories;
    });

}

	Stream<List<RentArrears>> getRentArrears$(
    Lease lease, {bool useCache = true, ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}) {
    return RentArrearsStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rentArrears) {
        lease.rentArrears = rentArrears;
    });

}

	Stream<List<RentSchedule>> getRentSchedules$(
    Lease lease, {bool useCache = true, ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}) {
    return RentScheduleStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rentSchedules) {
        lease.rentSchedules = rentSchedules;
    });

}

	Stream<List<RightToRentCheck>> getRightToRentChecks$(
    Lease lease, {bool useCache = true, ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}) {
    return RightToRentCheckStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rightToRentChecks) {
        lease.rightToRentChecks = rightToRentChecks;
    });

}

	Stream<SecurityDepositProtection?> getSecurityDepositProtection$(
    Lease lease, {bool useCache = true, ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}) {
    return SecurityDepositProtectionStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((securityDepositProtection) {
        lease.securityDepositProtection = securityDepositProtection;
    });

}

	Stream<List<Task>> getTasks$(
    Lease lease, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        lease.tasks = tasks;
    });

}

	Stream<List<Contact>> getContact$(
    Lease lease, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    return ContactStore.instance.getBy$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Contact) {
        lease.Contact = Contact;
    });

}

	Stream<List<Payment>> getPayment$(
    Lease lease, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByLeaseId$(
        lease.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Payment) {
        lease.Payment = Payment;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Lease recursiveUpsert(Lease lease, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Lease'} 
        : const {};
    if (lease.contracts != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        lease.contracts = ContractStore.instance.recursiveListUpsert(lease.contracts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.depositProtection != null && (!preventCircularSerialization || !upsertedTypes.contains('DepositProtection'))) {
        lease.depositProtection = DepositProtectionStore.instance.recursiveUpsert(lease.depositProtection!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.financialRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('FinancialRecord'))) {
        lease.financialRecords = FinancialRecordStore.instance.recursiveListUpsert(lease.financialRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.immigrationStatusCheck != null && (!preventCircularSerialization || !upsertedTypes.contains('ImmigrationStatusCheck'))) {
        lease.immigrationStatusCheck = ImmigrationStatusCheckStore.instance.recursiveUpsert(lease.immigrationStatusCheck!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        lease.listing = ListingStore.instance.recursiveUpsert(lease.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        lease.org = OrganizationStore.instance.recursiveUpsert(lease.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.tenant != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        lease.tenant = TenantStore.instance.recursiveUpsert(lease.tenant!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.renewals != null && (!preventCircularSerialization || !upsertedTypes.contains('LeaseRenewal'))) {
        lease.renewals = LeaseRenewalStore.instance.recursiveListUpsert(lease.renewals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.inventories != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyInventory'))) {
        lease.inventories = PropertyInventoryStore.instance.recursiveListUpsert(lease.inventories!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.rentArrears != null && (!preventCircularSerialization || !upsertedTypes.contains('RentArrears'))) {
        lease.rentArrears = RentArrearsStore.instance.recursiveListUpsert(lease.rentArrears!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.rentSchedules != null && (!preventCircularSerialization || !upsertedTypes.contains('RentSchedule'))) {
        lease.rentSchedules = RentScheduleStore.instance.recursiveListUpsert(lease.rentSchedules!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.rightToRentChecks != null && (!preventCircularSerialization || !upsertedTypes.contains('RightToRentCheck'))) {
        lease.rightToRentChecks = RightToRentCheckStore.instance.recursiveListUpsert(lease.rightToRentChecks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.securityDepositProtection != null && (!preventCircularSerialization || !upsertedTypes.contains('SecurityDepositProtection'))) {
        lease.securityDepositProtection = SecurityDepositProtectionStore.instance.recursiveUpsert(lease.securityDepositProtection!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        lease.tasks = TaskStore.instance.recursiveListUpsert(lease.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.Contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        lease.Contact = ContactStore.instance.recursiveListUpsert(lease.Contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lease.Payment != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        lease.Payment = PaymentStore.instance.recursiveListUpsert(lease.Payment!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(lease);
}

  List<Lease> recursiveListUpsert(List<Lease> leases, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedLeases = <Lease>[];
    for (var lease in leases) {
        updatedLeases.add(recursiveUpsert(lease, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedLeases;
}

//   @override
//   Lease upsert(Lease item) {
//     return recursiveUpsert(item);
//   }

}


class LeaseInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      LeaseInclude.contracts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getContracts$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getContracts(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.depositProtection({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DepositProtection>? modelFilter,
    List<DepositProtectionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getDepositProtection$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getDepositProtection(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.financialRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FinancialRecord>? modelFilter,
    List<FinancialRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getFinancialRecords$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getFinancialRecords(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.immigrationStatusCheck({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ImmigrationStatusCheck>? modelFilter,
    List<ImmigrationStatusCheckInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getImmigrationStatusCheck$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getImmigrationStatusCheck(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getListing$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getListing(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getOrg$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getOrg(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.tenant({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getTenant$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getTenant(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.renewals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LeaseRenewal>? modelFilter,
    List<LeaseRenewalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getRenewals$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getRenewals(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.inventories({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyInventory>? modelFilter,
    List<PropertyInventoryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getInventories$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getInventories(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.rentArrears({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RentArrears>? modelFilter,
    List<RentArrearsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getRentArrears$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getRentArrears(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.rentSchedules({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RentSchedule>? modelFilter,
    List<RentScheduleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getRentSchedules$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getRentSchedules(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.rightToRentChecks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RightToRentCheck>? modelFilter,
    List<RightToRentCheckInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getRightToRentChecks$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getRightToRentChecks(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.securityDepositProtection({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SecurityDepositProtection>? modelFilter,
    List<SecurityDepositProtectionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getSecurityDepositProtection$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getSecurityDepositProtection(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getTasks$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getTasks(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.Contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getContact$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getContact(lease, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseInclude.Payment({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lease) => LeaseStore.instance
            .getPayment$(lease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lease) => LeaseStore.instance
            .getPayment(lease, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum LeaseEndpoints implements Endpoint {

    getAll('/lease', HttpMethod.post, List<Lease>),
	getById('/lease/byId/:id', HttpMethod.post, Lease),
	getManyByOrgId('/lease/byOrgId/:orgId', HttpMethod.post, List<Lease>),
	getManyByListingId('/lease/byListingId/:listingId', HttpMethod.post, List<Lease>),
	getManyByTenantId('/lease/byTenantId/:tenantId', HttpMethod.post, List<Lease>),
	getManyByStatus('/lease/byStatus/:status', HttpMethod.post, List<Lease>),
	getManyByStartDate('/lease/byStartDate/:startDate', HttpMethod.post, List<Lease>),
	getManyByEndDate('/lease/byEndDate/:endDate', HttpMethod.post, List<Lease>),
	getManyByRent('/lease/byRent/:rent', HttpMethod.post, List<Lease>),
	getManyByCurrency('/lease/byCurrency/:currency', HttpMethod.post, List<Lease>),
	getManyByDeposit('/lease/byDeposit/:deposit', HttpMethod.post, List<Lease>),
	getManyByRentDueDay('/lease/byRentDueDay/:rentDueDay', HttpMethod.post, List<Lease>),
	getManyByNotes('/lease/byNotes/:notes', HttpMethod.post, List<Lease>),
	getManyByIsActive('/lease/byIsActive/:isActive', HttpMethod.post, List<Lease>),
	getManyByCreatedBy('/lease/byCreatedBy/:createdBy', HttpMethod.post, List<Lease>),
	getManyByCreatedAt('/lease/byCreatedAt/:createdAt', HttpMethod.post, List<Lease>),
	getManyByUpdatedAt('/lease/byUpdatedAt/:updatedAt', HttpMethod.post, List<Lease>),
	getManyByDeletedAt('/lease/byDeletedAt/:deletedAt', HttpMethod.post, List<Lease>);

    const LeaseEndpoints(this.path, this.method, this.responseType);

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
