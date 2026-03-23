
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class RentArrearsStore extends ModelStreamStore<String, RentArrears> {

  static RentArrearsStore? _instance;

  static RentArrearsStore get instance {
    _instance ??= RentArrearsStore();
    return _instance!;
  }

  RentArrearsStore() : super(RentArrears.fromJson) {
    if (_instance != null) {
        throw Exception(
            'RentArrearsStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending RentArrearsStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use RentArrearsStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getRentArrearsId(RentArrears rentArrears) => rentArrears.id;

	String? getRentArrearsOrgId(RentArrears rentArrears) => rentArrears.orgId;

	String? getRentArrearsLeaseId(RentArrears rentArrears) => rentArrears.leaseId;

	String? getRentArrearsTenantId(RentArrears rentArrears) => rentArrears.tenantId;

	DateTime? getRentArrearsPeriodStart(RentArrears rentArrears) => rentArrears.periodStart;

	DateTime? getRentArrearsPeriodEnd(RentArrears rentArrears) => rentArrears.periodEnd;

	double? getRentArrearsRentDue(RentArrears rentArrears) => rentArrears.rentDue;

	double? getRentArrearsRentPaid(RentArrears rentArrears) => rentArrears.rentPaid;

	double? getRentArrearsArrearsAmount(RentArrears rentArrears) => rentArrears.arrearsAmount;

	String? getRentArrearsStatus(RentArrears rentArrears) => rentArrears.status;

	DateTime? getRentArrearsLastPaymentDate(RentArrears rentArrears) => rentArrears.lastPaymentDate;

	bool? getRentArrearsNoticeSent(RentArrears rentArrears) => rentArrears.noticeSent;

	DateTime? getRentArrearsNoticeDate(RentArrears rentArrears) => rentArrears.noticeDate;

	String? getRentArrearsNoticeType(RentArrears rentArrears) => rentArrears.noticeType;

	bool? getRentArrearsLegalAction(RentArrears rentArrears) => rentArrears.legalAction;

	String? getRentArrearsLegalReference(RentArrears rentArrears) => rentArrears.legalReference;

	DateTime? getRentArrearsCourtDate(RentArrears rentArrears) => rentArrears.courtDate;

	double? getRentArrearsRecoveryAmount(RentArrears rentArrears) => rentArrears.recoveryAmount;

	double? getRentArrearsWriteOffAmount(RentArrears rentArrears) => rentArrears.writeOffAmount;

	DateTime? getRentArrearsCreatedAt(RentArrears rentArrears) => rentArrears.createdAt;

	DateTime? getRentArrearsUpdatedAt(RentArrears rentArrears) => rentArrears.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<RentArrears> getByOrgId(
    String orgId,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByLeaseId(
    String leaseId,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByTenantId(
    String tenantId,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsTenantId, tenantId, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByPeriodStart(
    DateTime periodStart,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsPeriodStart, periodStart, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByPeriodEnd(
    DateTime periodEnd,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsPeriodEnd, periodEnd, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByRentDue(
    double rentDue,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsRentDue, rentDue, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByRentPaid(
    double rentPaid,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsRentPaid, rentPaid, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByArrearsAmount(
    double arrearsAmount,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsArrearsAmount, arrearsAmount, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByStatus(
    String status,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsStatus, status, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByLastPaymentDate(
    DateTime lastPaymentDate,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsLastPaymentDate, lastPaymentDate, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByNoticeSent(
    bool noticeSent,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsNoticeSent, noticeSent, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByNoticeDate(
    DateTime noticeDate,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsNoticeDate, noticeDate, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByNoticeType(
    String noticeType,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsNoticeType, noticeType, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByLegalAction(
    bool legalAction,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsLegalAction, legalAction, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByLegalReference(
    String legalReference,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsLegalReference, legalReference, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByCourtDate(
    DateTime courtDate,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsCourtDate, courtDate, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByRecoveryAmount(
    double recoveryAmount,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsRecoveryAmount, recoveryAmount, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByWriteOffAmount(
    double writeOffAmount,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsWriteOffAmount, writeOffAmount, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<RentArrears> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}
    ) =>
    getManyIncluding(getRentArrearsUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Lease? getLease(
    RentArrears rentArrears, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (rentArrears.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(rentArrears.leaseId!, includes: includes);
        rentArrears.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Organization? getOrg(
    RentArrears rentArrears, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (rentArrears.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(rentArrears.orgId!, includes: includes);
        rentArrears.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Contact? getTenant(
    RentArrears rentArrears, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (rentArrears.tenantId == null) {
        return null;
    } else {
        final tenant = ContactStore.instance.getById(rentArrears.tenantId!, includes: includes);
        rentArrears.tenant = tenant;
        // setIncludedReferences(tenant, includes: includes);
        return tenant;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<RentArrears>> getAll$({bool useCache = true, ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: RentArrearsEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<RentArrears?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getRentArrearsId,
        value: id,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<RentArrears>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentArrearsOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentArrearsLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByTenantId$(
        String tenantId,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentArrearsTenantId,
        value: tenantId,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByTenantId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByPeriodStart$(
        DateTime periodStart,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentArrearsPeriodStart,
        value: periodStart,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByPeriodStart,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByPeriodEnd$(
        DateTime periodEnd,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentArrearsPeriodEnd,
        value: periodEnd,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByPeriodEnd,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByRentDue$(
        double rentDue,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRentArrearsRentDue,
        value: rentDue,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByRentDue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByRentPaid$(
        double rentPaid,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRentArrearsRentPaid,
        value: rentPaid,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByRentPaid,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByArrearsAmount$(
        double arrearsAmount,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRentArrearsArrearsAmount,
        value: arrearsAmount,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByArrearsAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentArrearsStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByLastPaymentDate$(
        DateTime lastPaymentDate,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentArrearsLastPaymentDate,
        value: lastPaymentDate,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByLastPaymentDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByNoticeSent$(
        bool noticeSent,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getRentArrearsNoticeSent,
        value: noticeSent,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByNoticeSent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByNoticeDate$(
        DateTime noticeDate,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentArrearsNoticeDate,
        value: noticeDate,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByNoticeDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByNoticeType$(
        String noticeType,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentArrearsNoticeType,
        value: noticeType,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByNoticeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByLegalAction$(
        bool legalAction,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getRentArrearsLegalAction,
        value: legalAction,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByLegalAction,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByLegalReference$(
        String legalReference,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentArrearsLegalReference,
        value: legalReference,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByLegalReference,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByCourtDate$(
        DateTime courtDate,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentArrearsCourtDate,
        value: courtDate,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByCourtDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByRecoveryAmount$(
        double recoveryAmount,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRentArrearsRecoveryAmount,
        value: recoveryAmount,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByRecoveryAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByWriteOffAmount$(
        double writeOffAmount,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRentArrearsWriteOffAmount,
        value: writeOffAmount,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByWriteOffAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentArrearsCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentArrears>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<RentArrears>? modelFilter,
        List<RentArrearsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentArrearsUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: RentArrearsEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Lease?> getLease$(
    RentArrears rentArrears, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (rentArrears.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            rentArrears.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            rentArrears.lease = lease;
        });
    }
}

	Stream<Organization?> getOrg$(
    RentArrears rentArrears, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (rentArrears.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            rentArrears.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            rentArrears.org = org;
        });
    }
}

	Stream<Contact?> getTenant$(
    RentArrears rentArrears, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (rentArrears.tenantId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            rentArrears.tenantId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((tenant) {
            rentArrears.tenant = tenant;
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
RentArrears recursiveUpsert(RentArrears rentArrears, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'RentArrears'} 
        : const {};
    if (rentArrears.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        rentArrears.lease = LeaseStore.instance.recursiveUpsert(rentArrears.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (rentArrears.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        rentArrears.org = OrganizationStore.instance.recursiveUpsert(rentArrears.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (rentArrears.tenant != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        rentArrears.tenant = ContactStore.instance.recursiveUpsert(rentArrears.tenant!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(rentArrears);
}

  List<RentArrears> recursiveListUpsert(List<RentArrears> rentArrearss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedRentArrearss = <RentArrears>[];
    for (var rentArrears in rentArrearss) {
        updatedRentArrearss.add(recursiveUpsert(rentArrears, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedRentArrearss;
}

//   @override
//   RentArrears upsert(RentArrears item) {
//     return recursiveUpsert(item);
//   }

}


class RentArrearsInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      RentArrearsInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rentArrears) => RentArrearsStore.instance
            .getLease$(rentArrears, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rentArrears) => RentArrearsStore.instance
            .getLease(rentArrears, modelFilter: modelFilter, includes: includes);
      }
}

	RentArrearsInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rentArrears) => RentArrearsStore.instance
            .getOrg$(rentArrears, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rentArrears) => RentArrearsStore.instance
            .getOrg(rentArrears, modelFilter: modelFilter, includes: includes);
      }
}

	RentArrearsInclude.tenant({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rentArrears) => RentArrearsStore.instance
            .getTenant$(rentArrears, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rentArrears) => RentArrearsStore.instance
            .getTenant(rentArrears, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum RentArrearsEndpoints implements Endpoint {

    getAll('/rentArrears', HttpMethod.post, List<RentArrears>),
	getById('/rentArrears/byId/:id', HttpMethod.post, RentArrears),
	getManyByOrgId('/rentArrears/byOrgId/:orgId', HttpMethod.post, List<RentArrears>),
	getManyByLeaseId('/rentArrears/byLeaseId/:leaseId', HttpMethod.post, List<RentArrears>),
	getManyByTenantId('/rentArrears/byTenantId/:tenantId', HttpMethod.post, List<RentArrears>),
	getManyByPeriodStart('/rentArrears/byPeriodStart/:periodStart', HttpMethod.post, List<RentArrears>),
	getManyByPeriodEnd('/rentArrears/byPeriodEnd/:periodEnd', HttpMethod.post, List<RentArrears>),
	getManyByRentDue('/rentArrears/byRentDue/:rentDue', HttpMethod.post, List<RentArrears>),
	getManyByRentPaid('/rentArrears/byRentPaid/:rentPaid', HttpMethod.post, List<RentArrears>),
	getManyByArrearsAmount('/rentArrears/byArrearsAmount/:arrearsAmount', HttpMethod.post, List<RentArrears>),
	getManyByStatus('/rentArrears/byStatus/:status', HttpMethod.post, List<RentArrears>),
	getManyByLastPaymentDate('/rentArrears/byLastPaymentDate/:lastPaymentDate', HttpMethod.post, List<RentArrears>),
	getManyByNoticeSent('/rentArrears/byNoticeSent/:noticeSent', HttpMethod.post, List<RentArrears>),
	getManyByNoticeDate('/rentArrears/byNoticeDate/:noticeDate', HttpMethod.post, List<RentArrears>),
	getManyByNoticeType('/rentArrears/byNoticeType/:noticeType', HttpMethod.post, List<RentArrears>),
	getManyByLegalAction('/rentArrears/byLegalAction/:legalAction', HttpMethod.post, List<RentArrears>),
	getManyByLegalReference('/rentArrears/byLegalReference/:legalReference', HttpMethod.post, List<RentArrears>),
	getManyByCourtDate('/rentArrears/byCourtDate/:courtDate', HttpMethod.post, List<RentArrears>),
	getManyByRecoveryAmount('/rentArrears/byRecoveryAmount/:recoveryAmount', HttpMethod.post, List<RentArrears>),
	getManyByWriteOffAmount('/rentArrears/byWriteOffAmount/:writeOffAmount', HttpMethod.post, List<RentArrears>),
	getManyByCreatedAt('/rentArrears/byCreatedAt/:createdAt', HttpMethod.post, List<RentArrears>),
	getManyByUpdatedAt('/rentArrears/byUpdatedAt/:updatedAt', HttpMethod.post, List<RentArrears>);

    const RentArrearsEndpoints(this.path, this.method, this.responseType);

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
