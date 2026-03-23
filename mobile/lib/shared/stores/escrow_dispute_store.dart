
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class EscrowDisputeStore extends ModelStreamStore<String, EscrowDispute> {

  static EscrowDisputeStore? _instance;

  static EscrowDisputeStore get instance {
    _instance ??= EscrowDisputeStore();
    return _instance!;
  }

  EscrowDisputeStore() : super(EscrowDispute.fromJson) {
    if (_instance != null) {
        throw Exception(
            'EscrowDisputeStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending EscrowDisputeStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use EscrowDisputeStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getEscrowDisputeId(EscrowDispute escrowDispute) => escrowDispute.id;

	String? getEscrowDisputeOrgId(EscrowDispute escrowDispute) => escrowDispute.orgId;

	String? getEscrowDisputeReservationId(EscrowDispute escrowDispute) => escrowDispute.reservationId;

	String? getEscrowDisputeEscrowAccountId(EscrowDispute escrowDispute) => escrowDispute.escrowAccountId;

	EscrowDisputeParty? getEscrowDisputeOpenedBy(EscrowDispute escrowDispute) => escrowDispute.openedBy;

	EscrowDisputeType? getEscrowDisputeDisputeType(EscrowDispute escrowDispute) => escrowDispute.disputeType;

	String? getEscrowDisputeDescription(EscrowDispute escrowDispute) => escrowDispute.description;

	double? getEscrowDisputeClaimedAmount(EscrowDispute escrowDispute) => escrowDispute.claimedAmount;

	String? getEscrowDisputeCurrency(EscrowDispute escrowDispute) => escrowDispute.currency;

	EscrowDisputeStatus? getEscrowDisputeStatus(EscrowDispute escrowDispute) => escrowDispute.status;

	dynamic? getEscrowDisputeEvidence(EscrowDispute escrowDispute) => escrowDispute.evidence;

	String? getEscrowDisputeResolution(EscrowDispute escrowDispute) => escrowDispute.resolution;

	double? getEscrowDisputeResolvedAmount(EscrowDispute escrowDispute) => escrowDispute.resolvedAmount;

	DateTime? getEscrowDisputeResolvedAt(EscrowDispute escrowDispute) => escrowDispute.resolvedAt;

	String? getEscrowDisputeResolvedBy(EscrowDispute escrowDispute) => escrowDispute.resolvedBy;

	String? getEscrowDisputeModeratorNotes(EscrowDispute escrowDispute) => escrowDispute.moderatorNotes;

	DateTime? getEscrowDisputeEscalatedAt(EscrowDispute escrowDispute) => escrowDispute.escalatedAt;

	DateTime? getEscrowDisputeDeadlineAt(EscrowDispute escrowDispute) => escrowDispute.deadlineAt;

	DateTime? getEscrowDisputeCreatedAt(EscrowDispute escrowDispute) => escrowDispute.createdAt;

	DateTime? getEscrowDisputeUpdatedAt(EscrowDispute escrowDispute) => escrowDispute.updatedAt;

	DateTime? getEscrowDisputeDeletedAt(EscrowDispute escrowDispute) => escrowDispute.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<EscrowDispute> getByOrgId(
    String orgId,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByReservationId(
    String reservationId,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByEscrowAccountId(
    String escrowAccountId,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeEscrowAccountId, escrowAccountId, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByOpenedBy(
    EscrowDisputeParty openedBy,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeOpenedBy, openedBy, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByDisputeType(
    EscrowDisputeType disputeType,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeDisputeType, disputeType, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByDescription(
    String description,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeDescription, description, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByClaimedAmount(
    double claimedAmount,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeClaimedAmount, claimedAmount, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByCurrency(
    String currency,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByStatus(
    EscrowDisputeStatus status,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeStatus, status, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByEvidence(
    dynamic evidence,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeEvidence, evidence, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByResolution(
    String resolution,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeResolution, resolution, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByResolvedAmount(
    double resolvedAmount,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeResolvedAmount, resolvedAmount, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByResolvedAt(
    DateTime resolvedAt,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeResolvedAt, resolvedAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByResolvedBy(
    String resolvedBy,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeResolvedBy, resolvedBy, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByModeratorNotes(
    String moderatorNotes,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeModeratorNotes, moderatorNotes, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByEscalatedAt(
    DateTime escalatedAt,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeEscalatedAt, escalatedAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByDeadlineAt(
    DateTime deadlineAt,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeDeadlineAt, deadlineAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<EscrowDispute> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}
    ) =>
    getManyIncluding(getEscrowDisputeDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    EscrowDispute escrowDispute, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (escrowDispute.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(escrowDispute.orgId!, includes: includes);
        escrowDispute.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	EscrowAccount? getEscrowAccount(
    EscrowDispute escrowDispute, {ModelFilter? modelFilter, List<EscrowAccountInclude>? includes}) {
    if (escrowDispute.escrowAccountId == null) {
        return null;
    } else {
        final escrowAccount = EscrowAccountStore.instance.getById(escrowDispute.escrowAccountId!, includes: includes);
        escrowDispute.escrowAccount = escrowAccount;
        // setIncludedReferences(escrowAccount, includes: includes);
        return escrowAccount;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<EscrowDispute>> getAll$({bool useCache = true, ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: EscrowDisputeEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<EscrowDispute?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getEscrowDisputeId,
        value: id,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<EscrowDispute>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowDisputeOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowDisputeReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByEscrowAccountId$(
        String escrowAccountId,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowDisputeEscrowAccountId,
        value: escrowAccountId,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByEscrowAccountId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByOpenedBy$(
        EscrowDisputeParty openedBy,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<EscrowDisputeParty>(
        getPropVal: getEscrowDisputeOpenedBy,
        value: openedBy,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByOpenedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByDisputeType$(
        EscrowDisputeType disputeType,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<EscrowDisputeType>(
        getPropVal: getEscrowDisputeDisputeType,
        value: disputeType,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByDisputeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowDisputeDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByClaimedAmount$(
        double claimedAmount,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getEscrowDisputeClaimedAmount,
        value: claimedAmount,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByClaimedAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowDisputeCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByStatus$(
        EscrowDisputeStatus status,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<EscrowDisputeStatus>(
        getPropVal: getEscrowDisputeStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByEvidence$(
        dynamic evidence,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getEscrowDisputeEvidence,
        value: evidence,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByEvidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByResolution$(
        String resolution,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowDisputeResolution,
        value: resolution,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByResolution,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByResolvedAmount$(
        double resolvedAmount,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getEscrowDisputeResolvedAmount,
        value: resolvedAmount,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByResolvedAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByResolvedAt$(
        DateTime resolvedAt,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowDisputeResolvedAt,
        value: resolvedAt,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByResolvedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByResolvedBy$(
        String resolvedBy,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowDisputeResolvedBy,
        value: resolvedBy,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByResolvedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByModeratorNotes$(
        String moderatorNotes,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowDisputeModeratorNotes,
        value: moderatorNotes,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByModeratorNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByEscalatedAt$(
        DateTime escalatedAt,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowDisputeEscalatedAt,
        value: escalatedAt,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByEscalatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByDeadlineAt$(
        DateTime deadlineAt,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowDisputeDeadlineAt,
        value: deadlineAt,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByDeadlineAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowDisputeCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowDisputeUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowDispute>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<EscrowDispute>? modelFilter,
        List<EscrowDisputeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowDisputeDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: EscrowDisputeEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    EscrowDispute escrowDispute, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (escrowDispute.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            escrowDispute.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            escrowDispute.org = org;
        });
    }
}

	Stream<EscrowAccount?> getEscrowAccount$(
    EscrowDispute escrowDispute, {bool useCache = true, ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}) {
    if (escrowDispute.escrowAccountId == null) {
        return Stream.value(null);
    } else {
        return EscrowAccountStore.instance.getById$(
            escrowDispute.escrowAccountId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((escrowAccount) {
            escrowDispute.escrowAccount = escrowAccount;
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
EscrowDispute recursiveUpsert(EscrowDispute escrowDispute, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'EscrowDispute'} 
        : const {};
    if (escrowDispute.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        escrowDispute.org = OrganizationStore.instance.recursiveUpsert(escrowDispute.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (escrowDispute.escrowAccount != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowAccount'))) {
        escrowDispute.escrowAccount = EscrowAccountStore.instance.recursiveUpsert(escrowDispute.escrowAccount!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(escrowDispute);
}

  List<EscrowDispute> recursiveListUpsert(List<EscrowDispute> escrowDisputes, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedEscrowDisputes = <EscrowDispute>[];
    for (var escrowDispute in escrowDisputes) {
        updatedEscrowDisputes.add(recursiveUpsert(escrowDispute, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedEscrowDisputes;
}

//   @override
//   EscrowDispute upsert(EscrowDispute item) {
//     return recursiveUpsert(item);
//   }

}


class EscrowDisputeInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      EscrowDisputeInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowDispute) => EscrowDisputeStore.instance
            .getOrg$(escrowDispute, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowDispute) => EscrowDisputeStore.instance
            .getOrg(escrowDispute, modelFilter: modelFilter, includes: includes);
      }
}

	EscrowDisputeInclude.escrowAccount({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowAccount>? modelFilter,
    List<EscrowAccountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowDispute) => EscrowDisputeStore.instance
            .getEscrowAccount$(escrowDispute, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowDispute) => EscrowDisputeStore.instance
            .getEscrowAccount(escrowDispute, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum EscrowDisputeEndpoints implements Endpoint {

    getAll('/escrowDispute', HttpMethod.post, List<EscrowDispute>),
	getById('/escrowDispute/byId/:id', HttpMethod.post, EscrowDispute),
	getManyByOrgId('/escrowDispute/byOrgId/:orgId', HttpMethod.post, List<EscrowDispute>),
	getManyByReservationId('/escrowDispute/byReservationId/:reservationId', HttpMethod.post, List<EscrowDispute>),
	getManyByEscrowAccountId('/escrowDispute/byEscrowAccountId/:escrowAccountId', HttpMethod.post, List<EscrowDispute>),
	getManyByOpenedBy('/escrowDispute/byOpenedBy/:openedBy', HttpMethod.post, List<EscrowDispute>),
	getManyByDisputeType('/escrowDispute/byDisputeType/:disputeType', HttpMethod.post, List<EscrowDispute>),
	getManyByDescription('/escrowDispute/byDescription/:description', HttpMethod.post, List<EscrowDispute>),
	getManyByClaimedAmount('/escrowDispute/byClaimedAmount/:claimedAmount', HttpMethod.post, List<EscrowDispute>),
	getManyByCurrency('/escrowDispute/byCurrency/:currency', HttpMethod.post, List<EscrowDispute>),
	getManyByStatus('/escrowDispute/byStatus/:status', HttpMethod.post, List<EscrowDispute>),
	getManyByEvidence('/escrowDispute/byEvidence/:evidence', HttpMethod.post, List<EscrowDispute>),
	getManyByResolution('/escrowDispute/byResolution/:resolution', HttpMethod.post, List<EscrowDispute>),
	getManyByResolvedAmount('/escrowDispute/byResolvedAmount/:resolvedAmount', HttpMethod.post, List<EscrowDispute>),
	getManyByResolvedAt('/escrowDispute/byResolvedAt/:resolvedAt', HttpMethod.post, List<EscrowDispute>),
	getManyByResolvedBy('/escrowDispute/byResolvedBy/:resolvedBy', HttpMethod.post, List<EscrowDispute>),
	getManyByModeratorNotes('/escrowDispute/byModeratorNotes/:moderatorNotes', HttpMethod.post, List<EscrowDispute>),
	getManyByEscalatedAt('/escrowDispute/byEscalatedAt/:escalatedAt', HttpMethod.post, List<EscrowDispute>),
	getManyByDeadlineAt('/escrowDispute/byDeadlineAt/:deadlineAt', HttpMethod.post, List<EscrowDispute>),
	getManyByCreatedAt('/escrowDispute/byCreatedAt/:createdAt', HttpMethod.post, List<EscrowDispute>),
	getManyByUpdatedAt('/escrowDispute/byUpdatedAt/:updatedAt', HttpMethod.post, List<EscrowDispute>),
	getManyByDeletedAt('/escrowDispute/byDeletedAt/:deletedAt', HttpMethod.post, List<EscrowDispute>);

    const EscrowDisputeEndpoints(this.path, this.method, this.responseType);

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
