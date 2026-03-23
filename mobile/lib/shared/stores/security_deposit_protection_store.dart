
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SecurityDepositProtectionStore extends ModelStreamStore<String, SecurityDepositProtection> {

  static SecurityDepositProtectionStore? _instance;

  static SecurityDepositProtectionStore get instance {
    _instance ??= SecurityDepositProtectionStore();
    return _instance!;
  }

  SecurityDepositProtectionStore() : super(SecurityDepositProtection.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SecurityDepositProtectionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SecurityDepositProtectionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SecurityDepositProtectionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSecurityDepositProtectionId(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.id;

	String? getSecurityDepositProtectionOrgId(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.orgId;

	String? getSecurityDepositProtectionLeaseId(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.leaseId;

	String? getSecurityDepositProtectionSchemeProvider(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.schemeProvider;

	String? getSecurityDepositProtectionSchemeReference(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.schemeReference;

	double? getSecurityDepositProtectionDepositAmount(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.depositAmount;

	String? getSecurityDepositProtectionCurrency(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.currency;

	String? getSecurityDepositProtectionProtectionStatus(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.protectionStatus;

	DateTime? getSecurityDepositProtectionProtectedDate(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.protectedDate;

	DateTime? getSecurityDepositProtectionReleasedDate(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.releasedDate;

	dynamic? getSecurityDepositProtectionTenantDetails(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.tenantDetails;

	dynamic? getSecurityDepositProtectionLandlordDetails(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.landlordDetails;

	String? getSecurityDepositProtectionDisputeStatus(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.disputeStatus;

	String? getSecurityDepositProtectionDisputeReason(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.disputeReason;

	String? getSecurityDepositProtectionDisputeResolution(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.disputeResolution;

	DateTime? getSecurityDepositProtectionCreatedAt(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.createdAt;

	DateTime? getSecurityDepositProtectionUpdatedAt(SecurityDepositProtection securityDepositProtection) => securityDepositProtection.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
SecurityDepositProtection? getByLeaseId(
    String leaseId,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getIncluding(getSecurityDepositProtectionLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
SecurityDepositProtection? getBySchemeReference(
    String schemeReference,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getIncluding(getSecurityDepositProtectionSchemeReference, schemeReference, modelFilter: modelFilter, includes: includes);

  
List<SecurityDepositProtection> getByOrgId(
    String orgId,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getBySchemeProvider(
    String schemeProvider,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionSchemeProvider, schemeProvider, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByDepositAmount(
    double depositAmount,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionDepositAmount, depositAmount, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByCurrency(
    String currency,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByProtectionStatus(
    String protectionStatus,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionProtectionStatus, protectionStatus, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByProtectedDate(
    DateTime protectedDate,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionProtectedDate, protectedDate, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByReleasedDate(
    DateTime releasedDate,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionReleasedDate, releasedDate, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByTenantDetails(
    dynamic tenantDetails,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionTenantDetails, tenantDetails, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByLandlordDetails(
    dynamic landlordDetails,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionLandlordDetails, landlordDetails, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByDisputeStatus(
    String disputeStatus,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionDisputeStatus, disputeStatus, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByDisputeReason(
    String disputeReason,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionDisputeReason, disputeReason, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByDisputeResolution(
    String disputeResolution,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionDisputeResolution, disputeResolution, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<SecurityDepositProtection> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getSecurityDepositProtectionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Lease? getLease(
    SecurityDepositProtection securityDepositProtection, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (securityDepositProtection.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(securityDepositProtection.leaseId!, includes: includes);
        securityDepositProtection.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Organization? getOrg(
    SecurityDepositProtection securityDepositProtection, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (securityDepositProtection.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(securityDepositProtection.orgId!, includes: includes);
        securityDepositProtection.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<SecurityDepositProtection>> getAll$({bool useCache = true, ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SecurityDepositProtectionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<SecurityDepositProtection?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<SecurityDepositProtection?> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<SecurityDepositProtection?> getBySchemeReference$(
        String schemeReference,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionSchemeReference,
        value: schemeReference,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getBySchemeReference,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<SecurityDepositProtection>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getBySchemeProvider$(
        String schemeProvider,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionSchemeProvider,
        value: schemeProvider,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyBySchemeProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByDepositAmount$(
        double depositAmount,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getSecurityDepositProtectionDepositAmount,
        value: depositAmount,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByDepositAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByProtectionStatus$(
        String protectionStatus,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionProtectionStatus,
        value: protectionStatus,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByProtectionStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByProtectedDate$(
        DateTime protectedDate,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSecurityDepositProtectionProtectedDate,
        value: protectedDate,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByProtectedDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByReleasedDate$(
        DateTime releasedDate,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSecurityDepositProtectionReleasedDate,
        value: releasedDate,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByReleasedDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByTenantDetails$(
        dynamic tenantDetails,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getSecurityDepositProtectionTenantDetails,
        value: tenantDetails,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByTenantDetails,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByLandlordDetails$(
        dynamic landlordDetails,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getSecurityDepositProtectionLandlordDetails,
        value: landlordDetails,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByLandlordDetails,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByDisputeStatus$(
        String disputeStatus,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionDisputeStatus,
        value: disputeStatus,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByDisputeStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByDisputeReason$(
        String disputeReason,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionDisputeReason,
        value: disputeReason,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByDisputeReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByDisputeResolution$(
        String disputeResolution,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSecurityDepositProtectionDisputeResolution,
        value: disputeResolution,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByDisputeResolution,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSecurityDepositProtectionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SecurityDepositProtection>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<SecurityDepositProtection>? modelFilter,
        List<SecurityDepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSecurityDepositProtectionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: SecurityDepositProtectionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Lease?> getLease$(
    SecurityDepositProtection securityDepositProtection, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (securityDepositProtection.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            securityDepositProtection.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            securityDepositProtection.lease = lease;
        });
    }
}

	Stream<Organization?> getOrg$(
    SecurityDepositProtection securityDepositProtection, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (securityDepositProtection.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            securityDepositProtection.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            securityDepositProtection.org = org;
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
SecurityDepositProtection recursiveUpsert(SecurityDepositProtection securityDepositProtection, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'SecurityDepositProtection'} 
        : const {};
    if (securityDepositProtection.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        securityDepositProtection.lease = LeaseStore.instance.recursiveUpsert(securityDepositProtection.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (securityDepositProtection.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        securityDepositProtection.org = OrganizationStore.instance.recursiveUpsert(securityDepositProtection.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(securityDepositProtection);
}

  List<SecurityDepositProtection> recursiveListUpsert(List<SecurityDepositProtection> securityDepositProtections, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSecurityDepositProtections = <SecurityDepositProtection>[];
    for (var securityDepositProtection in securityDepositProtections) {
        updatedSecurityDepositProtections.add(recursiveUpsert(securityDepositProtection, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSecurityDepositProtections;
}

//   @override
//   SecurityDepositProtection upsert(SecurityDepositProtection item) {
//     return recursiveUpsert(item);
//   }

}


class SecurityDepositProtectionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SecurityDepositProtectionInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (securityDepositProtection) => SecurityDepositProtectionStore.instance
            .getLease$(securityDepositProtection, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (securityDepositProtection) => SecurityDepositProtectionStore.instance
            .getLease(securityDepositProtection, modelFilter: modelFilter, includes: includes);
      }
}

	SecurityDepositProtectionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (securityDepositProtection) => SecurityDepositProtectionStore.instance
            .getOrg$(securityDepositProtection, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (securityDepositProtection) => SecurityDepositProtectionStore.instance
            .getOrg(securityDepositProtection, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SecurityDepositProtectionEndpoints implements Endpoint {

    getAll('/securityDepositProtection', HttpMethod.post, List<SecurityDepositProtection>),
	getById('/securityDepositProtection/byId/:id', HttpMethod.post, SecurityDepositProtection),
	getManyByOrgId('/securityDepositProtection/byOrgId/:orgId', HttpMethod.post, List<SecurityDepositProtection>),
	getByLeaseId('/securityDepositProtection/byLeaseId/:leaseId', HttpMethod.post, SecurityDepositProtection),
	getManyBySchemeProvider('/securityDepositProtection/bySchemeProvider/:schemeProvider', HttpMethod.post, List<SecurityDepositProtection>),
	getBySchemeReference('/securityDepositProtection/bySchemeReference/:schemeReference', HttpMethod.post, SecurityDepositProtection),
	getManyByDepositAmount('/securityDepositProtection/byDepositAmount/:depositAmount', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByCurrency('/securityDepositProtection/byCurrency/:currency', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByProtectionStatus('/securityDepositProtection/byProtectionStatus/:protectionStatus', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByProtectedDate('/securityDepositProtection/byProtectedDate/:protectedDate', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByReleasedDate('/securityDepositProtection/byReleasedDate/:releasedDate', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByTenantDetails('/securityDepositProtection/byTenantDetails/:tenantDetails', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByLandlordDetails('/securityDepositProtection/byLandlordDetails/:landlordDetails', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByDisputeStatus('/securityDepositProtection/byDisputeStatus/:disputeStatus', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByDisputeReason('/securityDepositProtection/byDisputeReason/:disputeReason', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByDisputeResolution('/securityDepositProtection/byDisputeResolution/:disputeResolution', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByCreatedAt('/securityDepositProtection/byCreatedAt/:createdAt', HttpMethod.post, List<SecurityDepositProtection>),
	getManyByUpdatedAt('/securityDepositProtection/byUpdatedAt/:updatedAt', HttpMethod.post, List<SecurityDepositProtection>);

    const SecurityDepositProtectionEndpoints(this.path, this.method, this.responseType);

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
