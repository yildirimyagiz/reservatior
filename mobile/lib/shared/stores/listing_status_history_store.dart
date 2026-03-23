
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ListingStatusHistoryStore extends ModelStreamStore<String, ListingStatusHistory> {

  static ListingStatusHistoryStore? _instance;

  static ListingStatusHistoryStore get instance {
    _instance ??= ListingStatusHistoryStore();
    return _instance!;
  }

  ListingStatusHistoryStore() : super(ListingStatusHistory.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ListingStatusHistoryStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ListingStatusHistoryStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ListingStatusHistoryStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getListingStatusHistoryId(ListingStatusHistory listingStatusHistory) => listingStatusHistory.id;

	String? getListingStatusHistoryOrgId(ListingStatusHistory listingStatusHistory) => listingStatusHistory.orgId;

	String? getListingStatusHistoryListingId(ListingStatusHistory listingStatusHistory) => listingStatusHistory.listingId;

	ListingStatus? getListingStatusHistoryStatus(ListingStatusHistory listingStatusHistory) => listingStatusHistory.status;

	DateTime? getListingStatusHistoryFromDate(ListingStatusHistory listingStatusHistory) => listingStatusHistory.fromDate;

	DateTime? getListingStatusHistoryToDate(ListingStatusHistory listingStatusHistory) => listingStatusHistory.toDate;

	String? getListingStatusHistoryReason(ListingStatusHistory listingStatusHistory) => listingStatusHistory.reason;

	String? getListingStatusHistoryCreatedBy(ListingStatusHistory listingStatusHistory) => listingStatusHistory.createdBy;

	DateTime? getListingStatusHistoryCreatedAt(ListingStatusHistory listingStatusHistory) => listingStatusHistory.createdAt;

	DateTime? getListingStatusHistoryUpdatedAt(ListingStatusHistory listingStatusHistory) => listingStatusHistory.updatedAt;

	DateTime? getListingStatusHistoryDeletedAt(ListingStatusHistory listingStatusHistory) => listingStatusHistory.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ListingStatusHistory> getByOrgId(
    String orgId,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByListingId(
    String listingId,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByStatus(
    ListingStatus status,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryStatus, status, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByFromDate(
    DateTime fromDate,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryFromDate, fromDate, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByToDate(
    DateTime toDate,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryToDate, toDate, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByReason(
    String reason,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryReason, reason, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByCreatedBy(
    String createdBy,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ListingStatusHistory> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}
    ) =>
    getManyIncluding(getListingStatusHistoryDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Listing? getListing(
    ListingStatusHistory listingStatusHistory, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (listingStatusHistory.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(listingStatusHistory.listingId!, includes: includes);
        listingStatusHistory.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    ListingStatusHistory listingStatusHistory, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (listingStatusHistory.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(listingStatusHistory.orgId!, includes: includes);
        listingStatusHistory.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ListingStatusHistory>> getAll$({bool useCache = true, ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ListingStatusHistoryEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ListingStatusHistory?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getListingStatusHistoryId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ListingStatusHistory>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingStatusHistoryOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingStatusHistoryListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByStatus$(
        ListingStatus status,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<ListingStatus>(
        getPropVal: getListingStatusHistoryStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByFromDate$(
        DateTime fromDate,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingStatusHistoryFromDate,
        value: fromDate,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByFromDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByToDate$(
        DateTime toDate,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingStatusHistoryToDate,
        value: toDate,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByToDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByReason$(
        String reason,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingStatusHistoryReason,
        value: reason,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingStatusHistoryCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingStatusHistoryCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingStatusHistoryUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingStatusHistory>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ListingStatusHistory>? modelFilter,
        List<ListingStatusHistoryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingStatusHistoryDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ListingStatusHistoryEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Listing?> getListing$(
    ListingStatusHistory listingStatusHistory, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (listingStatusHistory.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            listingStatusHistory.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            listingStatusHistory.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    ListingStatusHistory listingStatusHistory, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (listingStatusHistory.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            listingStatusHistory.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            listingStatusHistory.org = org;
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
ListingStatusHistory recursiveUpsert(ListingStatusHistory listingStatusHistory, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ListingStatusHistory'} 
        : const {};
    if (listingStatusHistory.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        listingStatusHistory.listing = ListingStore.instance.recursiveUpsert(listingStatusHistory.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listingStatusHistory.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        listingStatusHistory.org = OrganizationStore.instance.recursiveUpsert(listingStatusHistory.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(listingStatusHistory);
}

  List<ListingStatusHistory> recursiveListUpsert(List<ListingStatusHistory> listingStatusHistorys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedListingStatusHistorys = <ListingStatusHistory>[];
    for (var listingStatusHistory in listingStatusHistorys) {
        updatedListingStatusHistorys.add(recursiveUpsert(listingStatusHistory, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedListingStatusHistorys;
}

//   @override
//   ListingStatusHistory upsert(ListingStatusHistory item) {
//     return recursiveUpsert(item);
//   }

}


class ListingStatusHistoryInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ListingStatusHistoryInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listingStatusHistory) => ListingStatusHistoryStore.instance
            .getListing$(listingStatusHistory, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listingStatusHistory) => ListingStatusHistoryStore.instance
            .getListing(listingStatusHistory, modelFilter: modelFilter, includes: includes);
      }
}

	ListingStatusHistoryInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listingStatusHistory) => ListingStatusHistoryStore.instance
            .getOrg$(listingStatusHistory, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listingStatusHistory) => ListingStatusHistoryStore.instance
            .getOrg(listingStatusHistory, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ListingStatusHistoryEndpoints implements Endpoint {

    getAll('/listingStatusHistory', HttpMethod.post, List<ListingStatusHistory>),
	getById('/listingStatusHistory/byId/:id', HttpMethod.post, ListingStatusHistory),
	getManyByOrgId('/listingStatusHistory/byOrgId/:orgId', HttpMethod.post, List<ListingStatusHistory>),
	getManyByListingId('/listingStatusHistory/byListingId/:listingId', HttpMethod.post, List<ListingStatusHistory>),
	getManyByStatus('/listingStatusHistory/byStatus/:status', HttpMethod.post, List<ListingStatusHistory>),
	getManyByFromDate('/listingStatusHistory/byFromDate/:fromDate', HttpMethod.post, List<ListingStatusHistory>),
	getManyByToDate('/listingStatusHistory/byToDate/:toDate', HttpMethod.post, List<ListingStatusHistory>),
	getManyByReason('/listingStatusHistory/byReason/:reason', HttpMethod.post, List<ListingStatusHistory>),
	getManyByCreatedBy('/listingStatusHistory/byCreatedBy/:createdBy', HttpMethod.post, List<ListingStatusHistory>),
	getManyByCreatedAt('/listingStatusHistory/byCreatedAt/:createdAt', HttpMethod.post, List<ListingStatusHistory>),
	getManyByUpdatedAt('/listingStatusHistory/byUpdatedAt/:updatedAt', HttpMethod.post, List<ListingStatusHistory>),
	getManyByDeletedAt('/listingStatusHistory/byDeletedAt/:deletedAt', HttpMethod.post, List<ListingStatusHistory>);

    const ListingStatusHistoryEndpoints(this.path, this.method, this.responseType);

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
