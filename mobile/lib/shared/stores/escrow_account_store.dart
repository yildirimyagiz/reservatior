
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class EscrowAccountStore extends ModelStreamStore<String, EscrowAccount> {

  static EscrowAccountStore? _instance;

  static EscrowAccountStore get instance {
    _instance ??= EscrowAccountStore();
    return _instance!;
  }

  EscrowAccountStore() : super(EscrowAccount.fromJson) {
    if (_instance != null) {
        throw Exception(
            'EscrowAccountStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending EscrowAccountStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use EscrowAccountStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getEscrowAccountId(EscrowAccount escrowAccount) => escrowAccount.id;

	String? getEscrowAccountOrgId(EscrowAccount escrowAccount) => escrowAccount.orgId;

	String? getEscrowAccountReservationId(EscrowAccount escrowAccount) => escrowAccount.reservationId;

	double? getEscrowAccountTotalAmount(EscrowAccount escrowAccount) => escrowAccount.totalAmount;

	double? getEscrowAccountDepositAmount(EscrowAccount escrowAccount) => escrowAccount.depositAmount;

	String? getEscrowAccountCurrency(EscrowAccount escrowAccount) => escrowAccount.currency;

	EscrowStatus? getEscrowAccountStatus(EscrowAccount escrowAccount) => escrowAccount.status;

	DateTime? getEscrowAccountHeldAt(EscrowAccount escrowAccount) => escrowAccount.heldAt;

	DateTime? getEscrowAccountReleasedAt(EscrowAccount escrowAccount) => escrowAccount.releasedAt;

	DateTime? getEscrowAccountCreatedAt(EscrowAccount escrowAccount) => escrowAccount.createdAt;

	DateTime? getEscrowAccountUpdatedAt(EscrowAccount escrowAccount) => escrowAccount.updatedAt;

	DateTime? getEscrowAccountDeletedAt(EscrowAccount escrowAccount) => escrowAccount.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
EscrowAccount? getByReservationId(
    String reservationId,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getIncluding(getEscrowAccountReservationId, reservationId, modelFilter: modelFilter, includes: includes);

  
List<EscrowAccount> getByOrgId(
    String orgId,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByTotalAmount(
    double totalAmount,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountTotalAmount, totalAmount, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByDepositAmount(
    double depositAmount,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountDepositAmount, depositAmount, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByCurrency(
    String currency,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByStatus(
    EscrowStatus status,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountStatus, status, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByHeldAt(
    DateTime heldAt,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountHeldAt, heldAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByReleasedAt(
    DateTime releasedAt,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountReleasedAt, releasedAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowAccount> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}
    ) =>
    getManyIncluding(getEscrowAccountDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    EscrowAccount escrowAccount, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (escrowAccount.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(escrowAccount.orgId!, includes: includes);
        escrowAccount.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Reservation? getReservation(
    EscrowAccount escrowAccount, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (escrowAccount.reservationId == null) {
        return null;
    } else {
        final reservation = ReservationStore.instance.getById(escrowAccount.reservationId!, includes: includes);
        escrowAccount.reservation = reservation;
        // setIncludedReferences(reservation, includes: includes);
        return reservation;
    }
}

  /// GET RELATED MODELS 

  List<EscrowRelease> getReleases(
    EscrowAccount escrowAccount, {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}) {
    final releases = EscrowReleaseStore.instance.getByEscrowId(escrowAccount.$uid!, modelFilter: modelFilter, includes: includes);
    escrowAccount.releases = releases;
    // setIncludedReferencesForList(releases, includes: includes);
    return releases;
}

	List<EscrowDispute> getDisputes(
    EscrowAccount escrowAccount, {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}) {
    final disputes = EscrowDisputeStore.instance.getByEscrowAccountId(escrowAccount.$uid!, modelFilter: modelFilter, includes: includes);
    escrowAccount.disputes = disputes;
    // setIncludedReferencesForList(disputes, includes: includes);
    return disputes;
}

	List<EscrowStatusHistory> getStatusHistory(
    EscrowAccount escrowAccount, {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}) {
    final statusHistory = EscrowStatusHistoryStore.instance.getByEscrowId(escrowAccount.$uid!, modelFilter: modelFilter, includes: includes);
    escrowAccount.statusHistory = statusHistory;
    // setIncludedReferencesForList(statusHistory, includes: includes);
    return statusHistory;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<EscrowAccount>> getAll$({bool useCache = true, ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: EscrowAccountEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<EscrowAccount?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getEscrowAccountId,
        value: id,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<EscrowAccount?> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getEscrowAccountReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<EscrowAccount>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowAccountOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByTotalAmount$(
        double totalAmount,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getEscrowAccountTotalAmount,
        value: totalAmount,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByTotalAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByDepositAmount$(
        double depositAmount,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getEscrowAccountDepositAmount,
        value: depositAmount,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByDepositAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowAccountCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByStatus$(
        EscrowStatus status,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<EscrowStatus>(
        getPropVal: getEscrowAccountStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByHeldAt$(
        DateTime heldAt,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowAccountHeldAt,
        value: heldAt,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByHeldAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByReleasedAt$(
        DateTime releasedAt,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowAccountReleasedAt,
        value: releasedAt,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByReleasedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowAccountCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowAccountUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowAccount>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<EscrowAccount>? modelFilter,
        List<EscrowAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowAccountDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: EscrowAccountEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    EscrowAccount escrowAccount, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (escrowAccount.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            escrowAccount.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            escrowAccount.org = org;
        });
    }
}

	Stream<Reservation?> getReservation$(
    EscrowAccount escrowAccount, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (escrowAccount.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            escrowAccount.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((reservation) {
            escrowAccount.reservation = reservation;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<EscrowRelease>> getReleases$(
    EscrowAccount escrowAccount, {bool useCache = true, ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}) {
    return EscrowReleaseStore.instance.getByEscrowId$(
        escrowAccount.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((releases) {
        escrowAccount.releases = releases;
    });

}

	Stream<List<EscrowDispute>> getDisputes$(
    EscrowAccount escrowAccount, {bool useCache = true, ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}) {
    return EscrowDisputeStore.instance.getByEscrowAccountId$(
        escrowAccount.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((disputes) {
        escrowAccount.disputes = disputes;
    });

}

	Stream<List<EscrowStatusHistory>> getStatusHistory$(
    EscrowAccount escrowAccount, {bool useCache = true, ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}) {
    return EscrowStatusHistoryStore.instance.getByEscrowId$(
        escrowAccount.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((statusHistory) {
        escrowAccount.statusHistory = statusHistory;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
EscrowAccount recursiveUpsert(EscrowAccount escrowAccount, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'EscrowAccount'} 
        : const {};
    if (escrowAccount.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        escrowAccount.org = OrganizationStore.instance.recursiveUpsert(escrowAccount.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (escrowAccount.reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        escrowAccount.reservation = ReservationStore.instance.recursiveUpsert(escrowAccount.reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (escrowAccount.releases != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowRelease'))) {
        escrowAccount.releases = EscrowReleaseStore.instance.recursiveListUpsert(escrowAccount.releases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (escrowAccount.disputes != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowDispute'))) {
        escrowAccount.disputes = EscrowDisputeStore.instance.recursiveListUpsert(escrowAccount.disputes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (escrowAccount.statusHistory != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowStatusHistory'))) {
        escrowAccount.statusHistory = EscrowStatusHistoryStore.instance.recursiveListUpsert(escrowAccount.statusHistory!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(escrowAccount);
}

  List<EscrowAccount> recursiveListUpsert(List<EscrowAccount> escrowAccounts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedEscrowAccounts = <EscrowAccount>[];
    for (var escrowAccount in escrowAccounts) {
        updatedEscrowAccounts.add(recursiveUpsert(escrowAccount, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedEscrowAccounts;
}

//   @override
//   EscrowAccount upsert(EscrowAccount item) {
//     return recursiveUpsert(item);
//   }

}


class EscrowAccountInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      EscrowAccountInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowAccount) => EscrowAccountStore.instance
            .getOrg$(escrowAccount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowAccount) => EscrowAccountStore.instance
            .getOrg(escrowAccount, modelFilter: modelFilter, includes: includes);
      }
}

	EscrowAccountInclude.reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowAccount) => EscrowAccountStore.instance
            .getReservation$(escrowAccount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowAccount) => EscrowAccountStore.instance
            .getReservation(escrowAccount, modelFilter: modelFilter, includes: includes);
      }
}

	EscrowAccountInclude.releases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowRelease>? modelFilter,
    List<EscrowReleaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowAccount) => EscrowAccountStore.instance
            .getReleases$(escrowAccount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowAccount) => EscrowAccountStore.instance
            .getReleases(escrowAccount, modelFilter: modelFilter, includes: includes);
      }
}

	EscrowAccountInclude.disputes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowDispute>? modelFilter,
    List<EscrowDisputeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowAccount) => EscrowAccountStore.instance
            .getDisputes$(escrowAccount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowAccount) => EscrowAccountStore.instance
            .getDisputes(escrowAccount, modelFilter: modelFilter, includes: includes);
      }
}

	EscrowAccountInclude.statusHistory({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowStatusHistory>? modelFilter,
    List<EscrowStatusHistoryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowAccount) => EscrowAccountStore.instance
            .getStatusHistory$(escrowAccount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowAccount) => EscrowAccountStore.instance
            .getStatusHistory(escrowAccount, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum EscrowAccountEndpoints implements Endpoint {

    getAll('/escrowAccount', HttpMethod.post, List<EscrowAccount>),
	getById('/escrowAccount/byId/:id', HttpMethod.post, EscrowAccount),
	getManyByOrgId('/escrowAccount/byOrgId/:orgId', HttpMethod.post, List<EscrowAccount>),
	getByReservationId('/escrowAccount/byReservationId/:reservationId', HttpMethod.post, EscrowAccount),
	getManyByTotalAmount('/escrowAccount/byTotalAmount/:totalAmount', HttpMethod.post, List<EscrowAccount>),
	getManyByDepositAmount('/escrowAccount/byDepositAmount/:depositAmount', HttpMethod.post, List<EscrowAccount>),
	getManyByCurrency('/escrowAccount/byCurrency/:currency', HttpMethod.post, List<EscrowAccount>),
	getManyByStatus('/escrowAccount/byStatus/:status', HttpMethod.post, List<EscrowAccount>),
	getManyByHeldAt('/escrowAccount/byHeldAt/:heldAt', HttpMethod.post, List<EscrowAccount>),
	getManyByReleasedAt('/escrowAccount/byReleasedAt/:releasedAt', HttpMethod.post, List<EscrowAccount>),
	getManyByCreatedAt('/escrowAccount/byCreatedAt/:createdAt', HttpMethod.post, List<EscrowAccount>),
	getManyByUpdatedAt('/escrowAccount/byUpdatedAt/:updatedAt', HttpMethod.post, List<EscrowAccount>),
	getManyByDeletedAt('/escrowAccount/byDeletedAt/:deletedAt', HttpMethod.post, List<EscrowAccount>);

    const EscrowAccountEndpoints(this.path, this.method, this.responseType);

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
