
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ImmigrationStatusCheckStore extends ModelStreamStore<String, ImmigrationStatusCheck> {

  static ImmigrationStatusCheckStore? _instance;

  static ImmigrationStatusCheckStore get instance {
    _instance ??= ImmigrationStatusCheckStore();
    return _instance!;
  }

  ImmigrationStatusCheckStore() : super(ImmigrationStatusCheck.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ImmigrationStatusCheckStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ImmigrationStatusCheckStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ImmigrationStatusCheckStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getImmigrationStatusCheckId(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.id;

	String? getImmigrationStatusCheckOrgId(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.orgId;

	String? getImmigrationStatusCheckLeaseId(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.leaseId;

	String? getImmigrationStatusCheckTenantId(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.tenantId;

	String? getImmigrationStatusCheckCheckStatus(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.checkStatus;

	DateTime? getImmigrationStatusCheckCheckDate(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.checkDate;

	DateTime? getImmigrationStatusCheckValidUntil(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.validUntil;

	String? getImmigrationStatusCheckImmigrationStatus(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.immigrationStatus;

	String? getImmigrationStatusCheckVisaType(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.visaType;

	DateTime? getImmigrationStatusCheckVisaExpiry(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.visaExpiry;

	String? getImmigrationStatusCheckDocumentType(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.documentType;

	String? getImmigrationStatusCheckDocumentNumber(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.documentNumber;

	bool? getImmigrationStatusCheckDocumentVerified(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.documentVerified;

	String? getImmigrationStatusCheckShareCode(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.shareCode;

	String? getImmigrationStatusCheckCheckReference(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.checkReference;

	String? getImmigrationStatusCheckNotes(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.notes;

	DateTime? getImmigrationStatusCheckCreatedAt(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.createdAt;

	DateTime? getImmigrationStatusCheckUpdatedAt(ImmigrationStatusCheck immigrationStatusCheck) => immigrationStatusCheck.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
ImmigrationStatusCheck? getByLeaseId(
    String leaseId,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getIncluding(getImmigrationStatusCheckLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

  
List<ImmigrationStatusCheck> getByOrgId(
    String orgId,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByTenantId(
    String tenantId,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckTenantId, tenantId, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByCheckStatus(
    String checkStatus,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckCheckStatus, checkStatus, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByCheckDate(
    DateTime checkDate,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckCheckDate, checkDate, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByValidUntil(
    DateTime validUntil,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckValidUntil, validUntil, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByImmigrationStatus(
    String immigrationStatus,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckImmigrationStatus, immigrationStatus, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByVisaType(
    String visaType,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckVisaType, visaType, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByVisaExpiry(
    DateTime visaExpiry,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckVisaExpiry, visaExpiry, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByDocumentType(
    String documentType,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckDocumentType, documentType, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByDocumentNumber(
    String documentNumber,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckDocumentNumber, documentNumber, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByDocumentVerified(
    bool documentVerified,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckDocumentVerified, documentVerified, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByShareCode(
    String shareCode,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckShareCode, shareCode, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByCheckReference(
    String checkReference,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckCheckReference, checkReference, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByNotes(
    String notes,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ImmigrationStatusCheck> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}
    ) =>
    getManyIncluding(getImmigrationStatusCheckUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Lease? getLease(
    ImmigrationStatusCheck immigrationStatusCheck, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (immigrationStatusCheck.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(immigrationStatusCheck.leaseId!, includes: includes);
        immigrationStatusCheck.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Organization? getOrg(
    ImmigrationStatusCheck immigrationStatusCheck, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (immigrationStatusCheck.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(immigrationStatusCheck.orgId!, includes: includes);
        immigrationStatusCheck.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Contact? getTenant(
    ImmigrationStatusCheck immigrationStatusCheck, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (immigrationStatusCheck.tenantId == null) {
        return null;
    } else {
        final tenant = ContactStore.instance.getById(immigrationStatusCheck.tenantId!, includes: includes);
        immigrationStatusCheck.tenant = tenant;
        // setIncludedReferences(tenant, includes: includes);
        return tenant;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ImmigrationStatusCheck>> getAll$({bool useCache = true, ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ImmigrationStatusCheckEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ImmigrationStatusCheck?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<ImmigrationStatusCheck?> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ImmigrationStatusCheck>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByTenantId$(
        String tenantId,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckTenantId,
        value: tenantId,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByTenantId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByCheckStatus$(
        String checkStatus,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckCheckStatus,
        value: checkStatus,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByCheckStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByCheckDate$(
        DateTime checkDate,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getImmigrationStatusCheckCheckDate,
        value: checkDate,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByCheckDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByValidUntil$(
        DateTime validUntil,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getImmigrationStatusCheckValidUntil,
        value: validUntil,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByValidUntil,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByImmigrationStatus$(
        String immigrationStatus,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckImmigrationStatus,
        value: immigrationStatus,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByImmigrationStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByVisaType$(
        String visaType,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckVisaType,
        value: visaType,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByVisaType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByVisaExpiry$(
        DateTime visaExpiry,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getImmigrationStatusCheckVisaExpiry,
        value: visaExpiry,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByVisaExpiry,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByDocumentType$(
        String documentType,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckDocumentType,
        value: documentType,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByDocumentType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByDocumentNumber$(
        String documentNumber,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckDocumentNumber,
        value: documentNumber,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByDocumentNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByDocumentVerified$(
        bool documentVerified,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getImmigrationStatusCheckDocumentVerified,
        value: documentVerified,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByDocumentVerified,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByShareCode$(
        String shareCode,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckShareCode,
        value: shareCode,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByShareCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByCheckReference$(
        String checkReference,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckCheckReference,
        value: checkReference,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByCheckReference,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getImmigrationStatusCheckNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getImmigrationStatusCheckCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ImmigrationStatusCheck>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ImmigrationStatusCheck>? modelFilter,
        List<ImmigrationStatusCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getImmigrationStatusCheckUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ImmigrationStatusCheckEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Lease?> getLease$(
    ImmigrationStatusCheck immigrationStatusCheck, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (immigrationStatusCheck.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            immigrationStatusCheck.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            immigrationStatusCheck.lease = lease;
        });
    }
}

	Stream<Organization?> getOrg$(
    ImmigrationStatusCheck immigrationStatusCheck, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (immigrationStatusCheck.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            immigrationStatusCheck.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            immigrationStatusCheck.org = org;
        });
    }
}

	Stream<Contact?> getTenant$(
    ImmigrationStatusCheck immigrationStatusCheck, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (immigrationStatusCheck.tenantId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            immigrationStatusCheck.tenantId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((tenant) {
            immigrationStatusCheck.tenant = tenant;
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
ImmigrationStatusCheck recursiveUpsert(ImmigrationStatusCheck immigrationStatusCheck, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ImmigrationStatusCheck'} 
        : const {};
    if (immigrationStatusCheck.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        immigrationStatusCheck.lease = LeaseStore.instance.recursiveUpsert(immigrationStatusCheck.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (immigrationStatusCheck.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        immigrationStatusCheck.org = OrganizationStore.instance.recursiveUpsert(immigrationStatusCheck.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (immigrationStatusCheck.tenant != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        immigrationStatusCheck.tenant = ContactStore.instance.recursiveUpsert(immigrationStatusCheck.tenant!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(immigrationStatusCheck);
}

  List<ImmigrationStatusCheck> recursiveListUpsert(List<ImmigrationStatusCheck> immigrationStatusChecks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedImmigrationStatusChecks = <ImmigrationStatusCheck>[];
    for (var immigrationStatusCheck in immigrationStatusChecks) {
        updatedImmigrationStatusChecks.add(recursiveUpsert(immigrationStatusCheck, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedImmigrationStatusChecks;
}

//   @override
//   ImmigrationStatusCheck upsert(ImmigrationStatusCheck item) {
//     return recursiveUpsert(item);
//   }

}


class ImmigrationStatusCheckInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ImmigrationStatusCheckInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (immigrationStatusCheck) => ImmigrationStatusCheckStore.instance
            .getLease$(immigrationStatusCheck, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (immigrationStatusCheck) => ImmigrationStatusCheckStore.instance
            .getLease(immigrationStatusCheck, modelFilter: modelFilter, includes: includes);
      }
}

	ImmigrationStatusCheckInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (immigrationStatusCheck) => ImmigrationStatusCheckStore.instance
            .getOrg$(immigrationStatusCheck, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (immigrationStatusCheck) => ImmigrationStatusCheckStore.instance
            .getOrg(immigrationStatusCheck, modelFilter: modelFilter, includes: includes);
      }
}

	ImmigrationStatusCheckInclude.tenant({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (immigrationStatusCheck) => ImmigrationStatusCheckStore.instance
            .getTenant$(immigrationStatusCheck, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (immigrationStatusCheck) => ImmigrationStatusCheckStore.instance
            .getTenant(immigrationStatusCheck, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ImmigrationStatusCheckEndpoints implements Endpoint {

    getAll('/immigrationStatusCheck', HttpMethod.post, List<ImmigrationStatusCheck>),
	getById('/immigrationStatusCheck/byId/:id', HttpMethod.post, ImmigrationStatusCheck),
	getManyByOrgId('/immigrationStatusCheck/byOrgId/:orgId', HttpMethod.post, List<ImmigrationStatusCheck>),
	getByLeaseId('/immigrationStatusCheck/byLeaseId/:leaseId', HttpMethod.post, ImmigrationStatusCheck),
	getManyByTenantId('/immigrationStatusCheck/byTenantId/:tenantId', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByCheckStatus('/immigrationStatusCheck/byCheckStatus/:checkStatus', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByCheckDate('/immigrationStatusCheck/byCheckDate/:checkDate', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByValidUntil('/immigrationStatusCheck/byValidUntil/:validUntil', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByImmigrationStatus('/immigrationStatusCheck/byImmigrationStatus/:immigrationStatus', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByVisaType('/immigrationStatusCheck/byVisaType/:visaType', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByVisaExpiry('/immigrationStatusCheck/byVisaExpiry/:visaExpiry', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByDocumentType('/immigrationStatusCheck/byDocumentType/:documentType', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByDocumentNumber('/immigrationStatusCheck/byDocumentNumber/:documentNumber', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByDocumentVerified('/immigrationStatusCheck/byDocumentVerified/:documentVerified', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByShareCode('/immigrationStatusCheck/byShareCode/:shareCode', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByCheckReference('/immigrationStatusCheck/byCheckReference/:checkReference', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByNotes('/immigrationStatusCheck/byNotes/:notes', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByCreatedAt('/immigrationStatusCheck/byCreatedAt/:createdAt', HttpMethod.post, List<ImmigrationStatusCheck>),
	getManyByUpdatedAt('/immigrationStatusCheck/byUpdatedAt/:updatedAt', HttpMethod.post, List<ImmigrationStatusCheck>);

    const ImmigrationStatusCheckEndpoints(this.path, this.method, this.responseType);

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
