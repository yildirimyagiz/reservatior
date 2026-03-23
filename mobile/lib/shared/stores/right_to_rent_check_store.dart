
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class RightToRentCheckStore extends ModelStreamStore<String, RightToRentCheck> {

  static RightToRentCheckStore? _instance;

  static RightToRentCheckStore get instance {
    _instance ??= RightToRentCheckStore();
    return _instance!;
  }

  RightToRentCheckStore() : super(RightToRentCheck.fromJson) {
    if (_instance != null) {
        throw Exception(
            'RightToRentCheckStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending RightToRentCheckStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use RightToRentCheckStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getRightToRentCheckId(RightToRentCheck rightToRentCheck) => rightToRentCheck.id;

	String? getRightToRentCheckOrgId(RightToRentCheck rightToRentCheck) => rightToRentCheck.orgId;

	String? getRightToRentCheckLeaseId(RightToRentCheck rightToRentCheck) => rightToRentCheck.leaseId;

	String? getRightToRentCheckContactId(RightToRentCheck rightToRentCheck) => rightToRentCheck.contactId;

	String? getRightToRentCheckCheckType(RightToRentCheck rightToRentCheck) => rightToRentCheck.checkType;

	String? getRightToRentCheckReference(RightToRentCheck rightToRentCheck) => rightToRentCheck.reference;

	String? getRightToRentCheckStatus(RightToRentCheck rightToRentCheck) => rightToRentCheck.status;

	DateTime? getRightToRentCheckCheckedAt(RightToRentCheck rightToRentCheck) => rightToRentCheck.checkedAt;

	DateTime? getRightToRentCheckExpiresAt(RightToRentCheck rightToRentCheck) => rightToRentCheck.expiresAt;

	dynamic? getRightToRentCheckResult(RightToRentCheck rightToRentCheck) => rightToRentCheck.result;

	String? getRightToRentCheckCreatedBy(RightToRentCheck rightToRentCheck) => rightToRentCheck.createdBy;

	DateTime? getRightToRentCheckCreatedAt(RightToRentCheck rightToRentCheck) => rightToRentCheck.createdAt;

	DateTime? getRightToRentCheckUpdatedAt(RightToRentCheck rightToRentCheck) => rightToRentCheck.updatedAt;

	DateTime? getRightToRentCheckDeletedAt(RightToRentCheck rightToRentCheck) => rightToRentCheck.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<RightToRentCheck> getByOrgId(
    String orgId,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByLeaseId(
    String leaseId,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByContactId(
    String contactId,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByCheckType(
    String checkType,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckCheckType, checkType, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByReference(
    String reference,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckReference, reference, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByStatus(
    String status,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckStatus, status, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByCheckedAt(
    DateTime checkedAt,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckCheckedAt, checkedAt, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByResult(
    dynamic result,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckResult, result, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByCreatedBy(
    String createdBy,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<RightToRentCheck> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}
    ) =>
    getManyIncluding(getRightToRentCheckDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    RightToRentCheck rightToRentCheck, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (rightToRentCheck.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(rightToRentCheck.contactId!, includes: includes);
        rightToRentCheck.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Lease? getLease(
    RightToRentCheck rightToRentCheck, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (rightToRentCheck.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(rightToRentCheck.leaseId!, includes: includes);
        rightToRentCheck.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Organization? getOrg(
    RightToRentCheck rightToRentCheck, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (rightToRentCheck.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(rightToRentCheck.orgId!, includes: includes);
        rightToRentCheck.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<RightToRentCheck>> getAll$({bool useCache = true, ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: RightToRentCheckEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<RightToRentCheck?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getRightToRentCheckId,
        value: id,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<RightToRentCheck>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRightToRentCheckOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRightToRentCheckLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRightToRentCheckContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByCheckType$(
        String checkType,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRightToRentCheckCheckType,
        value: checkType,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByCheckType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByReference$(
        String reference,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRightToRentCheckReference,
        value: reference,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByReference,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRightToRentCheckStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByCheckedAt$(
        DateTime checkedAt,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRightToRentCheckCheckedAt,
        value: checkedAt,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByCheckedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRightToRentCheckExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByResult$(
        dynamic result,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getRightToRentCheckResult,
        value: result,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByResult,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRightToRentCheckCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRightToRentCheckCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRightToRentCheckUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RightToRentCheck>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<RightToRentCheck>? modelFilter,
        List<RightToRentCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRightToRentCheckDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: RightToRentCheckEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    RightToRentCheck rightToRentCheck, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (rightToRentCheck.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            rightToRentCheck.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            rightToRentCheck.contact = contact;
        });
    }
}

	Stream<Lease?> getLease$(
    RightToRentCheck rightToRentCheck, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (rightToRentCheck.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            rightToRentCheck.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            rightToRentCheck.lease = lease;
        });
    }
}

	Stream<Organization?> getOrg$(
    RightToRentCheck rightToRentCheck, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (rightToRentCheck.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            rightToRentCheck.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            rightToRentCheck.org = org;
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
RightToRentCheck recursiveUpsert(RightToRentCheck rightToRentCheck, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'RightToRentCheck'} 
        : const {};
    if (rightToRentCheck.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        rightToRentCheck.contact = ContactStore.instance.recursiveUpsert(rightToRentCheck.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (rightToRentCheck.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        rightToRentCheck.lease = LeaseStore.instance.recursiveUpsert(rightToRentCheck.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (rightToRentCheck.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        rightToRentCheck.org = OrganizationStore.instance.recursiveUpsert(rightToRentCheck.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(rightToRentCheck);
}

  List<RightToRentCheck> recursiveListUpsert(List<RightToRentCheck> rightToRentChecks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedRightToRentChecks = <RightToRentCheck>[];
    for (var rightToRentCheck in rightToRentChecks) {
        updatedRightToRentChecks.add(recursiveUpsert(rightToRentCheck, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedRightToRentChecks;
}

//   @override
//   RightToRentCheck upsert(RightToRentCheck item) {
//     return recursiveUpsert(item);
//   }

}


class RightToRentCheckInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      RightToRentCheckInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rightToRentCheck) => RightToRentCheckStore.instance
            .getContact$(rightToRentCheck, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rightToRentCheck) => RightToRentCheckStore.instance
            .getContact(rightToRentCheck, modelFilter: modelFilter, includes: includes);
      }
}

	RightToRentCheckInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rightToRentCheck) => RightToRentCheckStore.instance
            .getLease$(rightToRentCheck, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rightToRentCheck) => RightToRentCheckStore.instance
            .getLease(rightToRentCheck, modelFilter: modelFilter, includes: includes);
      }
}

	RightToRentCheckInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rightToRentCheck) => RightToRentCheckStore.instance
            .getOrg$(rightToRentCheck, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rightToRentCheck) => RightToRentCheckStore.instance
            .getOrg(rightToRentCheck, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum RightToRentCheckEndpoints implements Endpoint {

    getAll('/rightToRentCheck', HttpMethod.post, List<RightToRentCheck>),
	getById('/rightToRentCheck/byId/:id', HttpMethod.post, RightToRentCheck),
	getManyByOrgId('/rightToRentCheck/byOrgId/:orgId', HttpMethod.post, List<RightToRentCheck>),
	getManyByLeaseId('/rightToRentCheck/byLeaseId/:leaseId', HttpMethod.post, List<RightToRentCheck>),
	getManyByContactId('/rightToRentCheck/byContactId/:contactId', HttpMethod.post, List<RightToRentCheck>),
	getManyByCheckType('/rightToRentCheck/byCheckType/:checkType', HttpMethod.post, List<RightToRentCheck>),
	getManyByReference('/rightToRentCheck/byReference/:reference', HttpMethod.post, List<RightToRentCheck>),
	getManyByStatus('/rightToRentCheck/byStatus/:status', HttpMethod.post, List<RightToRentCheck>),
	getManyByCheckedAt('/rightToRentCheck/byCheckedAt/:checkedAt', HttpMethod.post, List<RightToRentCheck>),
	getManyByExpiresAt('/rightToRentCheck/byExpiresAt/:expiresAt', HttpMethod.post, List<RightToRentCheck>),
	getManyByResult('/rightToRentCheck/byResult/:result', HttpMethod.post, List<RightToRentCheck>),
	getManyByCreatedBy('/rightToRentCheck/byCreatedBy/:createdBy', HttpMethod.post, List<RightToRentCheck>),
	getManyByCreatedAt('/rightToRentCheck/byCreatedAt/:createdAt', HttpMethod.post, List<RightToRentCheck>),
	getManyByUpdatedAt('/rightToRentCheck/byUpdatedAt/:updatedAt', HttpMethod.post, List<RightToRentCheck>),
	getManyByDeletedAt('/rightToRentCheck/byDeletedAt/:deletedAt', HttpMethod.post, List<RightToRentCheck>);

    const RightToRentCheckEndpoints(this.path, this.method, this.responseType);

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
