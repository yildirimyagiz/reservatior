
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class RentScheduleStore extends ModelStreamStore<String, RentSchedule> {

  static RentScheduleStore? _instance;

  static RentScheduleStore get instance {
    _instance ??= RentScheduleStore();
    return _instance!;
  }

  RentScheduleStore() : super(RentSchedule.fromJson) {
    if (_instance != null) {
        throw Exception(
            'RentScheduleStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending RentScheduleStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use RentScheduleStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getRentScheduleId(RentSchedule rentSchedule) => rentSchedule.id;

	String? getRentScheduleOrgId(RentSchedule rentSchedule) => rentSchedule.orgId;

	String? getRentScheduleLeaseId(RentSchedule rentSchedule) => rentSchedule.leaseId;

	DateTime? getRentScheduleDueDate(RentSchedule rentSchedule) => rentSchedule.dueDate;

	double? getRentScheduleAmount(RentSchedule rentSchedule) => rentSchedule.amount;

	String? getRentScheduleCurrency(RentSchedule rentSchedule) => rentSchedule.currency;

	PaymentStatus? getRentScheduleStatus(RentSchedule rentSchedule) => rentSchedule.status;

	DateTime? getRentSchedulePaidAt(RentSchedule rentSchedule) => rentSchedule.paidAt;

	DateTime? getRentScheduleCreatedAt(RentSchedule rentSchedule) => rentSchedule.createdAt;

	DateTime? getRentScheduleUpdatedAt(RentSchedule rentSchedule) => rentSchedule.updatedAt;

	DateTime? getRentScheduleDeletedAt(RentSchedule rentSchedule) => rentSchedule.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<RentSchedule> getByOrgId(
    String orgId,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByLeaseId(
    String leaseId,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByDueDate(
    DateTime dueDate,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleDueDate, dueDate, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByAmount(
    double amount,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByCurrency(
    String currency,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByStatus(
    PaymentStatus status,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleStatus, status, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByPaidAt(
    DateTime paidAt,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentSchedulePaidAt, paidAt, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<RentSchedule> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}
    ) =>
    getManyIncluding(getRentScheduleDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Lease? getLease(
    RentSchedule rentSchedule, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (rentSchedule.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(rentSchedule.leaseId!, includes: includes);
        rentSchedule.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Organization? getOrg(
    RentSchedule rentSchedule, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (rentSchedule.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(rentSchedule.orgId!, includes: includes);
        rentSchedule.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<RentSchedule>> getAll$({bool useCache = true, ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: RentScheduleEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<RentSchedule?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getRentScheduleId,
        value: id,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<RentSchedule>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentScheduleOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentScheduleLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByDueDate$(
        DateTime dueDate,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentScheduleDueDate,
        value: dueDate,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByDueDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRentScheduleAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRentScheduleCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByStatus$(
        PaymentStatus status,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentStatus>(
        getPropVal: getRentScheduleStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByPaidAt$(
        DateTime paidAt,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentSchedulePaidAt,
        value: paidAt,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByPaidAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentScheduleCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentScheduleUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RentSchedule>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<RentSchedule>? modelFilter,
        List<RentScheduleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRentScheduleDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: RentScheduleEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Lease?> getLease$(
    RentSchedule rentSchedule, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (rentSchedule.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            rentSchedule.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            rentSchedule.lease = lease;
        });
    }
}

	Stream<Organization?> getOrg$(
    RentSchedule rentSchedule, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (rentSchedule.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            rentSchedule.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            rentSchedule.org = org;
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
RentSchedule recursiveUpsert(RentSchedule rentSchedule, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'RentSchedule'} 
        : const {};
    if (rentSchedule.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        rentSchedule.lease = LeaseStore.instance.recursiveUpsert(rentSchedule.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (rentSchedule.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        rentSchedule.org = OrganizationStore.instance.recursiveUpsert(rentSchedule.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(rentSchedule);
}

  List<RentSchedule> recursiveListUpsert(List<RentSchedule> rentSchedules, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedRentSchedules = <RentSchedule>[];
    for (var rentSchedule in rentSchedules) {
        updatedRentSchedules.add(recursiveUpsert(rentSchedule, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedRentSchedules;
}

//   @override
//   RentSchedule upsert(RentSchedule item) {
//     return recursiveUpsert(item);
//   }

}


class RentScheduleInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      RentScheduleInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rentSchedule) => RentScheduleStore.instance
            .getLease$(rentSchedule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rentSchedule) => RentScheduleStore.instance
            .getLease(rentSchedule, modelFilter: modelFilter, includes: includes);
      }
}

	RentScheduleInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rentSchedule) => RentScheduleStore.instance
            .getOrg$(rentSchedule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rentSchedule) => RentScheduleStore.instance
            .getOrg(rentSchedule, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum RentScheduleEndpoints implements Endpoint {

    getAll('/rentSchedule', HttpMethod.post, List<RentSchedule>),
	getById('/rentSchedule/byId/:id', HttpMethod.post, RentSchedule),
	getManyByOrgId('/rentSchedule/byOrgId/:orgId', HttpMethod.post, List<RentSchedule>),
	getManyByLeaseId('/rentSchedule/byLeaseId/:leaseId', HttpMethod.post, List<RentSchedule>),
	getManyByDueDate('/rentSchedule/byDueDate/:dueDate', HttpMethod.post, List<RentSchedule>),
	getManyByAmount('/rentSchedule/byAmount/:amount', HttpMethod.post, List<RentSchedule>),
	getManyByCurrency('/rentSchedule/byCurrency/:currency', HttpMethod.post, List<RentSchedule>),
	getManyByStatus('/rentSchedule/byStatus/:status', HttpMethod.post, List<RentSchedule>),
	getManyByPaidAt('/rentSchedule/byPaidAt/:paidAt', HttpMethod.post, List<RentSchedule>),
	getManyByCreatedAt('/rentSchedule/byCreatedAt/:createdAt', HttpMethod.post, List<RentSchedule>),
	getManyByUpdatedAt('/rentSchedule/byUpdatedAt/:updatedAt', HttpMethod.post, List<RentSchedule>),
	getManyByDeletedAt('/rentSchedule/byDeletedAt/:deletedAt', HttpMethod.post, List<RentSchedule>);

    const RentScheduleEndpoints(this.path, this.method, this.responseType);

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
