
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class DepositProtectionStore extends ModelStreamStore<String, DepositProtection> {

  static DepositProtectionStore? _instance;

  static DepositProtectionStore get instance {
    _instance ??= DepositProtectionStore();
    return _instance!;
  }

  DepositProtectionStore() : super(DepositProtection.fromJson) {
    if (_instance != null) {
        throw Exception(
            'DepositProtectionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending DepositProtectionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use DepositProtectionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getDepositProtectionId(DepositProtection depositProtection) => depositProtection.id;

	String? getDepositProtectionOrgId(DepositProtection depositProtection) => depositProtection.orgId;

	String? getDepositProtectionLeaseId(DepositProtection depositProtection) => depositProtection.leaseId;

	String? getDepositProtectionProvider(DepositProtection depositProtection) => depositProtection.provider;

	String? getDepositProtectionScheme(DepositProtection depositProtection) => depositProtection.scheme;

	String? getDepositProtectionReference(DepositProtection depositProtection) => depositProtection.reference;

	double? getDepositProtectionAmount(DepositProtection depositProtection) => depositProtection.amount;

	String? getDepositProtectionCurrency(DepositProtection depositProtection) => depositProtection.currency;

	String? getDepositProtectionStatus(DepositProtection depositProtection) => depositProtection.status;

	DateTime? getDepositProtectionProtectedAt(DepositProtection depositProtection) => depositProtection.protectedAt;

	DateTime? getDepositProtectionClaimedAt(DepositProtection depositProtection) => depositProtection.claimedAt;

	DateTime? getDepositProtectionReturnedAt(DepositProtection depositProtection) => depositProtection.returnedAt;

	String? getDepositProtectionCreatedBy(DepositProtection depositProtection) => depositProtection.createdBy;

	DateTime? getDepositProtectionCreatedAt(DepositProtection depositProtection) => depositProtection.createdAt;

	DateTime? getDepositProtectionUpdatedAt(DepositProtection depositProtection) => depositProtection.updatedAt;

	DateTime? getDepositProtectionDeletedAt(DepositProtection depositProtection) => depositProtection.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
DepositProtection? getByLeaseId(
    String leaseId,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getIncluding(getDepositProtectionLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

  
List<DepositProtection> getByOrgId(
    String orgId,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByProvider(
    String provider,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionProvider, provider, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByScheme(
    String scheme,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionScheme, scheme, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByReference(
    String reference,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionReference, reference, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByAmount(
    double amount,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByCurrency(
    String currency,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByStatus(
    String status,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionStatus, status, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByProtectedAt(
    DateTime protectedAt,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionProtectedAt, protectedAt, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByClaimedAt(
    DateTime claimedAt,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionClaimedAt, claimedAt, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByReturnedAt(
    DateTime returnedAt,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionReturnedAt, returnedAt, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByCreatedBy(
    String createdBy,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<DepositProtection> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}
    ) =>
    getManyIncluding(getDepositProtectionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Lease? getLease(
    DepositProtection depositProtection, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (depositProtection.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(depositProtection.leaseId!, includes: includes);
        depositProtection.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Organization? getOrg(
    DepositProtection depositProtection, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (depositProtection.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(depositProtection.orgId!, includes: includes);
        depositProtection.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<DepositProtection>> getAll$({bool useCache = true, ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: DepositProtectionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<DepositProtection?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDepositProtectionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<DepositProtection?> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDepositProtectionLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<DepositProtection>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDepositProtectionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByProvider$(
        String provider,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDepositProtectionProvider,
        value: provider,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByScheme$(
        String scheme,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDepositProtectionScheme,
        value: scheme,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByScheme,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByReference$(
        String reference,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDepositProtectionReference,
        value: reference,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByReference,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDepositProtectionAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDepositProtectionCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDepositProtectionStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByProtectedAt$(
        DateTime protectedAt,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDepositProtectionProtectedAt,
        value: protectedAt,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByProtectedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByClaimedAt$(
        DateTime claimedAt,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDepositProtectionClaimedAt,
        value: claimedAt,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByClaimedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByReturnedAt$(
        DateTime returnedAt,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDepositProtectionReturnedAt,
        value: returnedAt,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByReturnedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDepositProtectionCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDepositProtectionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDepositProtectionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DepositProtection>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<DepositProtection>? modelFilter,
        List<DepositProtectionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDepositProtectionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: DepositProtectionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Lease?> getLease$(
    DepositProtection depositProtection, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (depositProtection.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            depositProtection.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            depositProtection.lease = lease;
        });
    }
}

	Stream<Organization?> getOrg$(
    DepositProtection depositProtection, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (depositProtection.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            depositProtection.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            depositProtection.org = org;
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
DepositProtection recursiveUpsert(DepositProtection depositProtection, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'DepositProtection'} 
        : const {};
    if (depositProtection.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        depositProtection.lease = LeaseStore.instance.recursiveUpsert(depositProtection.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (depositProtection.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        depositProtection.org = OrganizationStore.instance.recursiveUpsert(depositProtection.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(depositProtection);
}

  List<DepositProtection> recursiveListUpsert(List<DepositProtection> depositProtections, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedDepositProtections = <DepositProtection>[];
    for (var depositProtection in depositProtections) {
        updatedDepositProtections.add(recursiveUpsert(depositProtection, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedDepositProtections;
}

//   @override
//   DepositProtection upsert(DepositProtection item) {
//     return recursiveUpsert(item);
//   }

}


class DepositProtectionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      DepositProtectionInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (depositProtection) => DepositProtectionStore.instance
            .getLease$(depositProtection, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (depositProtection) => DepositProtectionStore.instance
            .getLease(depositProtection, modelFilter: modelFilter, includes: includes);
      }
}

	DepositProtectionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (depositProtection) => DepositProtectionStore.instance
            .getOrg$(depositProtection, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (depositProtection) => DepositProtectionStore.instance
            .getOrg(depositProtection, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum DepositProtectionEndpoints implements Endpoint {

    getAll('/depositProtection', HttpMethod.post, List<DepositProtection>),
	getById('/depositProtection/byId/:id', HttpMethod.post, DepositProtection),
	getManyByOrgId('/depositProtection/byOrgId/:orgId', HttpMethod.post, List<DepositProtection>),
	getByLeaseId('/depositProtection/byLeaseId/:leaseId', HttpMethod.post, DepositProtection),
	getManyByProvider('/depositProtection/byProvider/:provider', HttpMethod.post, List<DepositProtection>),
	getManyByScheme('/depositProtection/byScheme/:scheme', HttpMethod.post, List<DepositProtection>),
	getManyByReference('/depositProtection/byReference/:reference', HttpMethod.post, List<DepositProtection>),
	getManyByAmount('/depositProtection/byAmount/:amount', HttpMethod.post, List<DepositProtection>),
	getManyByCurrency('/depositProtection/byCurrency/:currency', HttpMethod.post, List<DepositProtection>),
	getManyByStatus('/depositProtection/byStatus/:status', HttpMethod.post, List<DepositProtection>),
	getManyByProtectedAt('/depositProtection/byProtectedAt/:protectedAt', HttpMethod.post, List<DepositProtection>),
	getManyByClaimedAt('/depositProtection/byClaimedAt/:claimedAt', HttpMethod.post, List<DepositProtection>),
	getManyByReturnedAt('/depositProtection/byReturnedAt/:returnedAt', HttpMethod.post, List<DepositProtection>),
	getManyByCreatedBy('/depositProtection/byCreatedBy/:createdBy', HttpMethod.post, List<DepositProtection>),
	getManyByCreatedAt('/depositProtection/byCreatedAt/:createdAt', HttpMethod.post, List<DepositProtection>),
	getManyByUpdatedAt('/depositProtection/byUpdatedAt/:updatedAt', HttpMethod.post, List<DepositProtection>),
	getManyByDeletedAt('/depositProtection/byDeletedAt/:deletedAt', HttpMethod.post, List<DepositProtection>);

    const DepositProtectionEndpoints(this.path, this.method, this.responseType);

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
