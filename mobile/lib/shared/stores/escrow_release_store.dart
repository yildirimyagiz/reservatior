
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class EscrowReleaseStore extends ModelStreamStore<String, EscrowRelease> {

  static EscrowReleaseStore? _instance;

  static EscrowReleaseStore get instance {
    _instance ??= EscrowReleaseStore();
    return _instance!;
  }

  EscrowReleaseStore() : super(EscrowRelease.fromJson) {
    if (_instance != null) {
        throw Exception(
            'EscrowReleaseStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending EscrowReleaseStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use EscrowReleaseStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getEscrowReleaseId(EscrowRelease escrowRelease) => escrowRelease.id;

	String? getEscrowReleaseOrgId(EscrowRelease escrowRelease) => escrowRelease.orgId;

	String? getEscrowReleaseEscrowId(EscrowRelease escrowRelease) => escrowRelease.escrowId;

	EscrowTriggerEvent? getEscrowReleaseTriggerEvent(EscrowRelease escrowRelease) => escrowRelease.triggerEvent;

	double? getEscrowReleaseReleasePercent(EscrowRelease escrowRelease) => escrowRelease.releasePercent;

	double? getEscrowReleaseAmount(EscrowRelease escrowRelease) => escrowRelease.amount;

	String? getEscrowReleaseCurrency(EscrowRelease escrowRelease) => escrowRelease.currency;

	EscrowReleaseStatus? getEscrowReleaseStatus(EscrowRelease escrowRelease) => escrowRelease.status;

	DateTime? getEscrowReleaseScheduledAt(EscrowRelease escrowRelease) => escrowRelease.scheduledAt;

	DateTime? getEscrowReleaseReleasedAt(EscrowRelease escrowRelease) => escrowRelease.releasedAt;

	List<String>? getEscrowReleaseApprovalRequiredBy(EscrowRelease escrowRelease) => escrowRelease.approvalRequiredBy;

	dynamic? getEscrowReleaseApprovals(EscrowRelease escrowRelease) => escrowRelease.approvals;

	DateTime? getEscrowReleaseApprovalCompletedAt(EscrowRelease escrowRelease) => escrowRelease.approvalCompletedAt;

	String? getEscrowReleaseApprovedBy(EscrowRelease escrowRelease) => escrowRelease.approvedBy;

	String? getEscrowReleaseFailureReason(EscrowRelease escrowRelease) => escrowRelease.failureReason;

	int? getEscrowReleaseRetryCount(EscrowRelease escrowRelease) => escrowRelease.retryCount;

	String? getEscrowReleaseNotes(EscrowRelease escrowRelease) => escrowRelease.notes;

	DateTime? getEscrowReleaseDeletedAt(EscrowRelease escrowRelease) => escrowRelease.deletedAt;

	DateTime? getEscrowReleaseCreatedAt(EscrowRelease escrowRelease) => escrowRelease.createdAt;

	DateTime? getEscrowReleaseUpdatedAt(EscrowRelease escrowRelease) => escrowRelease.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<EscrowRelease> getByOrgId(
    String orgId,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByEscrowId(
    String escrowId,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseEscrowId, escrowId, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByTriggerEvent(
    EscrowTriggerEvent triggerEvent,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseTriggerEvent, triggerEvent, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByReleasePercent(
    double releasePercent,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseReleasePercent, releasePercent, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByAmount(
    double amount,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByCurrency(
    String currency,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByStatus(
    EscrowReleaseStatus status,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseStatus, status, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByScheduledAt(
    DateTime scheduledAt,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseScheduledAt, scheduledAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByReleasedAt(
    DateTime releasedAt,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseReleasedAt, releasedAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByApprovalRequiredBy(
    String approvalRequiredBy,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseApprovalRequiredBy, approvalRequiredBy, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByApprovals(
    dynamic approvals,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseApprovals, approvals, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByApprovalCompletedAt(
    DateTime approvalCompletedAt,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseApprovalCompletedAt, approvalCompletedAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByApprovedBy(
    String approvedBy,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseApprovedBy, approvedBy, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByFailureReason(
    String failureReason,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseFailureReason, failureReason, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByRetryCount(
    int retryCount,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseRetryCount, retryCount, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByNotes(
    String notes,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowRelease> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}
    ) =>
    getManyIncluding(getEscrowReleaseUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  EscrowAccount? getEscrow(
    EscrowRelease escrowRelease, {ModelFilter? modelFilter, List<EscrowAccountInclude>? includes}) {
    if (escrowRelease.escrowId == null) {
        return null;
    } else {
        final escrow = EscrowAccountStore.instance.getById(escrowRelease.escrowId!, includes: includes);
        escrowRelease.escrow = escrow;
        // setIncludedReferences(escrow, includes: includes);
        return escrow;
    }
}

	Organization? getOrg(
    EscrowRelease escrowRelease, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (escrowRelease.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(escrowRelease.orgId!, includes: includes);
        escrowRelease.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<EscrowRelease>> getAll$({bool useCache = true, ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: EscrowReleaseEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<EscrowRelease?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getEscrowReleaseId,
        value: id,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<EscrowRelease>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowReleaseOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByEscrowId$(
        String escrowId,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowReleaseEscrowId,
        value: escrowId,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByEscrowId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByTriggerEvent$(
        EscrowTriggerEvent triggerEvent,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<EscrowTriggerEvent>(
        getPropVal: getEscrowReleaseTriggerEvent,
        value: triggerEvent,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByTriggerEvent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByReleasePercent$(
        double releasePercent,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getEscrowReleaseReleasePercent,
        value: releasePercent,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByReleasePercent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getEscrowReleaseAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowReleaseCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByStatus$(
        EscrowReleaseStatus status,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<EscrowReleaseStatus>(
        getPropVal: getEscrowReleaseStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByScheduledAt$(
        DateTime scheduledAt,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowReleaseScheduledAt,
        value: scheduledAt,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByScheduledAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByReleasedAt$(
        DateTime releasedAt,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowReleaseReleasedAt,
        value: releasedAt,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByReleasedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByApprovalRequiredBy$(
        String approvalRequiredBy,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowReleaseApprovalRequiredBy,
        value: approvalRequiredBy,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByApprovalRequiredBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByApprovals$(
        dynamic approvals,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getEscrowReleaseApprovals,
        value: approvals,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByApprovals,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByApprovalCompletedAt$(
        DateTime approvalCompletedAt,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowReleaseApprovalCompletedAt,
        value: approvalCompletedAt,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByApprovalCompletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByApprovedBy$(
        String approvedBy,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowReleaseApprovedBy,
        value: approvedBy,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByApprovedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByFailureReason$(
        String failureReason,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowReleaseFailureReason,
        value: failureReason,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByFailureReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByRetryCount$(
        int retryCount,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getEscrowReleaseRetryCount,
        value: retryCount,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByRetryCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowReleaseNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowReleaseDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowReleaseCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowRelease>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<EscrowRelease>? modelFilter,
        List<EscrowReleaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowReleaseUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: EscrowReleaseEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<EscrowAccount?> getEscrow$(
    EscrowRelease escrowRelease, {bool useCache = true, ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}) {
    if (escrowRelease.escrowId == null) {
        return Stream.value(null);
    } else {
        return EscrowAccountStore.instance.getById$(
            escrowRelease.escrowId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((escrow) {
            escrowRelease.escrow = escrow;
        });
    }
}

	Stream<Organization?> getOrg$(
    EscrowRelease escrowRelease, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (escrowRelease.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            escrowRelease.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            escrowRelease.org = org;
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
EscrowRelease recursiveUpsert(EscrowRelease escrowRelease, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'EscrowRelease'} 
        : const {};
    if (escrowRelease.escrow != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowAccount'))) {
        escrowRelease.escrow = EscrowAccountStore.instance.recursiveUpsert(escrowRelease.escrow!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (escrowRelease.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        escrowRelease.org = OrganizationStore.instance.recursiveUpsert(escrowRelease.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(escrowRelease);
}

  List<EscrowRelease> recursiveListUpsert(List<EscrowRelease> escrowReleases, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedEscrowReleases = <EscrowRelease>[];
    for (var escrowRelease in escrowReleases) {
        updatedEscrowReleases.add(recursiveUpsert(escrowRelease, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedEscrowReleases;
}

//   @override
//   EscrowRelease upsert(EscrowRelease item) {
//     return recursiveUpsert(item);
//   }

}


class EscrowReleaseInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      EscrowReleaseInclude.escrow({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowAccount>? modelFilter,
    List<EscrowAccountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowRelease) => EscrowReleaseStore.instance
            .getEscrow$(escrowRelease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowRelease) => EscrowReleaseStore.instance
            .getEscrow(escrowRelease, modelFilter: modelFilter, includes: includes);
      }
}

	EscrowReleaseInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowRelease) => EscrowReleaseStore.instance
            .getOrg$(escrowRelease, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowRelease) => EscrowReleaseStore.instance
            .getOrg(escrowRelease, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum EscrowReleaseEndpoints implements Endpoint {

    getAll('/escrowRelease', HttpMethod.post, List<EscrowRelease>),
	getById('/escrowRelease/byId/:id', HttpMethod.post, EscrowRelease),
	getManyByOrgId('/escrowRelease/byOrgId/:orgId', HttpMethod.post, List<EscrowRelease>),
	getManyByEscrowId('/escrowRelease/byEscrowId/:escrowId', HttpMethod.post, List<EscrowRelease>),
	getManyByTriggerEvent('/escrowRelease/byTriggerEvent/:triggerEvent', HttpMethod.post, List<EscrowRelease>),
	getManyByReleasePercent('/escrowRelease/byReleasePercent/:releasePercent', HttpMethod.post, List<EscrowRelease>),
	getManyByAmount('/escrowRelease/byAmount/:amount', HttpMethod.post, List<EscrowRelease>),
	getManyByCurrency('/escrowRelease/byCurrency/:currency', HttpMethod.post, List<EscrowRelease>),
	getManyByStatus('/escrowRelease/byStatus/:status', HttpMethod.post, List<EscrowRelease>),
	getManyByScheduledAt('/escrowRelease/byScheduledAt/:scheduledAt', HttpMethod.post, List<EscrowRelease>),
	getManyByReleasedAt('/escrowRelease/byReleasedAt/:releasedAt', HttpMethod.post, List<EscrowRelease>),
	getManyByApprovalRequiredBy('/escrowRelease/byApprovalRequiredBy/:approvalRequiredBy', HttpMethod.post, List<EscrowRelease>),
	getManyByApprovals('/escrowRelease/byApprovals/:approvals', HttpMethod.post, List<EscrowRelease>),
	getManyByApprovalCompletedAt('/escrowRelease/byApprovalCompletedAt/:approvalCompletedAt', HttpMethod.post, List<EscrowRelease>),
	getManyByApprovedBy('/escrowRelease/byApprovedBy/:approvedBy', HttpMethod.post, List<EscrowRelease>),
	getManyByFailureReason('/escrowRelease/byFailureReason/:failureReason', HttpMethod.post, List<EscrowRelease>),
	getManyByRetryCount('/escrowRelease/byRetryCount/:retryCount', HttpMethod.post, List<EscrowRelease>),
	getManyByNotes('/escrowRelease/byNotes/:notes', HttpMethod.post, List<EscrowRelease>),
	getManyByDeletedAt('/escrowRelease/byDeletedAt/:deletedAt', HttpMethod.post, List<EscrowRelease>),
	getManyByCreatedAt('/escrowRelease/byCreatedAt/:createdAt', HttpMethod.post, List<EscrowRelease>),
	getManyByUpdatedAt('/escrowRelease/byUpdatedAt/:updatedAt', HttpMethod.post, List<EscrowRelease>);

    const EscrowReleaseEndpoints(this.path, this.method, this.responseType);

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
