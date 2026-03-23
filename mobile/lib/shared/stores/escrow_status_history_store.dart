
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class EscrowStatusHistoryStore extends ModelStreamStore<String, EscrowStatusHistory> {

  static EscrowStatusHistoryStore? _instance;

  static EscrowStatusHistoryStore get instance {
    _instance ??= EscrowStatusHistoryStore();
    return _instance!;
  }

  EscrowStatusHistoryStore() : super(EscrowStatusHistory.fromJson) {
    if (_instance != null) {
        throw Exception(
            'EscrowStatusHistoryStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending EscrowStatusHistoryStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use EscrowStatusHistoryStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getEscrowStatusHistoryId(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.id;

	String? getEscrowStatusHistoryOrgId(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.orgId;

	String? getEscrowStatusHistoryEscrowId(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.escrowId;

	EscrowStatus? getEscrowStatusHistoryFromStatus(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.fromStatus;

	EscrowStatus? getEscrowStatusHistoryToStatus(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.toStatus;

	String? getEscrowStatusHistoryChangedBy(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.changedBy;

	String? getEscrowStatusHistoryReason(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.reason;

	dynamic? getEscrowStatusHistoryMetadata(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.metadata;

	DateTime? getEscrowStatusHistoryChangedAt(EscrowStatusHistory escrowStatusHistory) => escrowStatusHistory.changedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<EscrowStatusHistory> getByOrgId(
    String orgId,
    {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getEscrowStatusHistoryOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<EscrowStatusHistory> getByEscrowId(
    String escrowId,
    {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getEscrowStatusHistoryEscrowId, escrowId, modelFilter: modelFilter, includes: includes);

	
List<EscrowStatusHistory> getByFromStatus(
    EscrowStatus fromStatus,
    {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getEscrowStatusHistoryFromStatus, fromStatus, modelFilter: modelFilter, includes: includes);

	
List<EscrowStatusHistory> getByToStatus(
    EscrowStatus toStatus,
    {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getEscrowStatusHistoryToStatus, toStatus, modelFilter: modelFilter, includes: includes);

	
List<EscrowStatusHistory> getByChangedBy(
    String changedBy,
    {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getEscrowStatusHistoryChangedBy, changedBy, modelFilter: modelFilter, includes: includes);

	
List<EscrowStatusHistory> getByReason(
    String reason,
    {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getEscrowStatusHistoryReason, reason, modelFilter: modelFilter, includes: includes);

	
List<EscrowStatusHistory> getByMetadata(
    dynamic metadata,
    {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getEscrowStatusHistoryMetadata, metadata, modelFilter: modelFilter, includes: includes);

	
List<EscrowStatusHistory> getByChangedAt(
    DateTime changedAt,
    {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getEscrowStatusHistoryChangedAt, changedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  EscrowAccount? getEscrow(
    EscrowStatusHistory escrowStatusHistory, {ModelFilter? modelFilter, List<EscrowAccountInclude>? includes}) {
    if (escrowStatusHistory.escrowId == null) {
        return null;
    } else {
        final escrow = EscrowAccountStore.instance.getById(escrowStatusHistory.escrowId!, includes: includes);
        escrowStatusHistory.escrow = escrow;
        // setIncludedReferences(escrow, includes: includes);
        return escrow;
    }
}

	Organization? getOrg(
    EscrowStatusHistory escrowStatusHistory, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (escrowStatusHistory.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(escrowStatusHistory.orgId!, includes: includes);
        escrowStatusHistory.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<EscrowStatusHistory>> getAll$({bool useCache = true, ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: EscrowStatusHistoryEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<EscrowStatusHistory?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getEscrowStatusHistoryId,
        value: id,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<EscrowStatusHistory>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowStatusHistoryOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowStatusHistory>> getByEscrowId$(
        String escrowId,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowStatusHistoryEscrowId,
        value: escrowId,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getManyByEscrowId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowStatusHistory>> getByFromStatus$(
        EscrowStatus fromStatus,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<EscrowStatus>(
        getPropVal: getEscrowStatusHistoryFromStatus,
        value: fromStatus,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getManyByFromStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowStatusHistory>> getByToStatus$(
        EscrowStatus toStatus,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<EscrowStatus>(
        getPropVal: getEscrowStatusHistoryToStatus,
        value: toStatus,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getManyByToStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowStatusHistory>> getByChangedBy$(
        String changedBy,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowStatusHistoryChangedBy,
        value: changedBy,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getManyByChangedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowStatusHistory>> getByReason$(
        String reason,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEscrowStatusHistoryReason,
        value: reason,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getManyByReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowStatusHistory>> getByMetadata$(
        dynamic metadata,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getEscrowStatusHistoryMetadata,
        value: metadata,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getManyByMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EscrowStatusHistory>> getByChangedAt$(
        DateTime changedAt,
        {bool useCache = true,
        ModelFilter<EscrowStatusHistory>? modelFilter,
        List<EscrowStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEscrowStatusHistoryChangedAt,
        value: changedAt,
        modelFilter: modelFilter,
        endpoint: EscrowStatusHistoryEndpoints.getManyByChangedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<EscrowAccount?> getEscrow$(
    EscrowStatusHistory escrowStatusHistory, {bool useCache = true, ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}) {
    if (escrowStatusHistory.escrowId == null) {
        return Stream.value(null);
    } else {
        return EscrowAccountStore.instance.getById$(
            escrowStatusHistory.escrowId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((escrow) {
            escrowStatusHistory.escrow = escrow;
        });
    }
}

	Stream<Organization?> getOrg$(
    EscrowStatusHistory escrowStatusHistory, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (escrowStatusHistory.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            escrowStatusHistory.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            escrowStatusHistory.org = org;
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
EscrowStatusHistory recursiveUpsert(EscrowStatusHistory escrowStatusHistory, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'EscrowStatusHistory'} 
        : const {};
    if (escrowStatusHistory.escrow != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowAccount'))) {
        escrowStatusHistory.escrow = EscrowAccountStore.instance.recursiveUpsert(escrowStatusHistory.escrow!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (escrowStatusHistory.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        escrowStatusHistory.org = OrganizationStore.instance.recursiveUpsert(escrowStatusHistory.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(escrowStatusHistory);
}

  List<EscrowStatusHistory> recursiveListUpsert(List<EscrowStatusHistory> escrowStatusHistorys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedEscrowStatusHistorys = <EscrowStatusHistory>[];
    for (var escrowStatusHistory in escrowStatusHistorys) {
        updatedEscrowStatusHistorys.add(recursiveUpsert(escrowStatusHistory, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedEscrowStatusHistorys;
}

//   @override
//   EscrowStatusHistory upsert(EscrowStatusHistory item) {
//     return recursiveUpsert(item);
//   }

}


class EscrowStatusHistoryInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      EscrowStatusHistoryInclude.escrow({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowAccount>? modelFilter,
    List<EscrowAccountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowStatusHistory) => EscrowStatusHistoryStore.instance
            .getEscrow$(escrowStatusHistory, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowStatusHistory) => EscrowStatusHistoryStore.instance
            .getEscrow(escrowStatusHistory, modelFilter: modelFilter, includes: includes);
      }
}

	EscrowStatusHistoryInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (escrowStatusHistory) => EscrowStatusHistoryStore.instance
            .getOrg$(escrowStatusHistory, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (escrowStatusHistory) => EscrowStatusHistoryStore.instance
            .getOrg(escrowStatusHistory, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum EscrowStatusHistoryEndpoints implements Endpoint {

    getAll('/escrowStatusHistory', HttpMethod.post, List<EscrowStatusHistory>),
	getById('/escrowStatusHistory/byId/:id', HttpMethod.post, EscrowStatusHistory),
	getManyByOrgId('/escrowStatusHistory/byOrgId/:orgId', HttpMethod.post, List<EscrowStatusHistory>),
	getManyByEscrowId('/escrowStatusHistory/byEscrowId/:escrowId', HttpMethod.post, List<EscrowStatusHistory>),
	getManyByFromStatus('/escrowStatusHistory/byFromStatus/:fromStatus', HttpMethod.post, List<EscrowStatusHistory>),
	getManyByToStatus('/escrowStatusHistory/byToStatus/:toStatus', HttpMethod.post, List<EscrowStatusHistory>),
	getManyByChangedBy('/escrowStatusHistory/byChangedBy/:changedBy', HttpMethod.post, List<EscrowStatusHistory>),
	getManyByReason('/escrowStatusHistory/byReason/:reason', HttpMethod.post, List<EscrowStatusHistory>),
	getManyByMetadata('/escrowStatusHistory/byMetadata/:metadata', HttpMethod.post, List<EscrowStatusHistory>),
	getManyByChangedAt('/escrowStatusHistory/byChangedAt/:changedAt', HttpMethod.post, List<EscrowStatusHistory>);

    const EscrowStatusHistoryEndpoints(this.path, this.method, this.responseType);

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
