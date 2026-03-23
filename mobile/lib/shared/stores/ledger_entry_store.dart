
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class LedgerEntryStore extends ModelStreamStore<String, LedgerEntry> {

  static LedgerEntryStore? _instance;

  static LedgerEntryStore get instance {
    _instance ??= LedgerEntryStore();
    return _instance!;
  }

  LedgerEntryStore() : super(LedgerEntry.fromJson) {
    if (_instance != null) {
        throw Exception(
            'LedgerEntryStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending LedgerEntryStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use LedgerEntryStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getLedgerEntryId(LedgerEntry ledgerEntry) => ledgerEntry.id;

	String? getLedgerEntryOrgId(LedgerEntry ledgerEntry) => ledgerEntry.orgId;

	String? getLedgerEntryPropertyId(LedgerEntry ledgerEntry) => ledgerEntry.propertyId;

	String? getLedgerEntryListingId(LedgerEntry ledgerEntry) => ledgerEntry.listingId;

	String? getLedgerEntryLeaseId(LedgerEntry ledgerEntry) => ledgerEntry.leaseId;

	String? getLedgerEntryBookingId(LedgerEntry ledgerEntry) => ledgerEntry.bookingId;

	String? getLedgerEntryContractId(LedgerEntry ledgerEntry) => ledgerEntry.contractId;

	String? getLedgerEntryBillId(LedgerEntry ledgerEntry) => ledgerEntry.billId;

	String? getLedgerEntryTransactionId(LedgerEntry ledgerEntry) => ledgerEntry.transactionId;

	LedgerEventType? getLedgerEntryType(LedgerEntry ledgerEntry) => ledgerEntry.type;

	double? getLedgerEntryAmount(LedgerEntry ledgerEntry) => ledgerEntry.amount;

	String? getLedgerEntryCurrency(LedgerEntry ledgerEntry) => ledgerEntry.currency;

	DateTime? getLedgerEntryOccurredAt(LedgerEntry ledgerEntry) => ledgerEntry.occurredAt;

	String? getLedgerEntryNote(LedgerEntry ledgerEntry) => ledgerEntry.note;

	dynamic? getLedgerEntryMeta(LedgerEntry ledgerEntry) => ledgerEntry.meta;

	String? getLedgerEntryCreatedBy(LedgerEntry ledgerEntry) => ledgerEntry.createdBy;

	DateTime? getLedgerEntryCreatedAt(LedgerEntry ledgerEntry) => ledgerEntry.createdAt;

	DateTime? getLedgerEntryUpdatedAt(LedgerEntry ledgerEntry) => ledgerEntry.updatedAt;

	DateTime? getLedgerEntryDeletedAt(LedgerEntry ledgerEntry) => ledgerEntry.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<LedgerEntry> getByOrgId(
    String orgId,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByPropertyId(
    String propertyId,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByListingId(
    String listingId,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByLeaseId(
    String leaseId,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByBookingId(
    String bookingId,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryBookingId, bookingId, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByContractId(
    String contractId,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryContractId, contractId, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByBillId(
    String billId,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryBillId, billId, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByTransactionId(
    String transactionId,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryTransactionId, transactionId, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByType(
    LedgerEventType type,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryType, type, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByAmount(
    double amount,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByCurrency(
    String currency,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByOccurredAt(
    DateTime occurredAt,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryOccurredAt, occurredAt, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByNote(
    String note,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryNote, note, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByMeta(
    dynamic meta,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryMeta, meta, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByCreatedBy(
    String createdBy,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<LedgerEntry> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}
    ) =>
    getManyIncluding(getLedgerEntryDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    LedgerEntry ledgerEntry, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (ledgerEntry.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(ledgerEntry.orgId!, includes: includes);
        ledgerEntry.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    LedgerEntry ledgerEntry, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (ledgerEntry.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(ledgerEntry.propertyId!, includes: includes);
        ledgerEntry.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<LedgerEntry>> getAll$({bool useCache = true, ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: LedgerEntryEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<LedgerEntry?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLedgerEntryId,
        value: id,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<LedgerEntry>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByBookingId$(
        String bookingId,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryBookingId,
        value: bookingId,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByBookingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByContractId$(
        String contractId,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryContractId,
        value: contractId,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByContractId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByBillId$(
        String billId,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryBillId,
        value: billId,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByBillId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByTransactionId$(
        String transactionId,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryTransactionId,
        value: transactionId,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByTransactionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByType$(
        LedgerEventType type,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<LedgerEventType>(
        getPropVal: getLedgerEntryType,
        value: type,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLedgerEntryAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByOccurredAt$(
        DateTime occurredAt,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLedgerEntryOccurredAt,
        value: occurredAt,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByOccurredAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByNote$(
        String note,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryNote,
        value: note,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByNote,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByMeta$(
        dynamic meta,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getLedgerEntryMeta,
        value: meta,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByMeta,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLedgerEntryCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLedgerEntryCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLedgerEntryUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LedgerEntry>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<LedgerEntry>? modelFilter,
        List<LedgerEntryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLedgerEntryDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: LedgerEntryEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    LedgerEntry ledgerEntry, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (ledgerEntry.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            ledgerEntry.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            ledgerEntry.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    LedgerEntry ledgerEntry, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (ledgerEntry.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            ledgerEntry.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            ledgerEntry.property = property;
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
LedgerEntry recursiveUpsert(LedgerEntry ledgerEntry, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'LedgerEntry'} 
        : const {};
    if (ledgerEntry.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        ledgerEntry.org = OrganizationStore.instance.recursiveUpsert(ledgerEntry.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (ledgerEntry.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        ledgerEntry.property = PropertyStore.instance.recursiveUpsert(ledgerEntry.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(ledgerEntry);
}

  List<LedgerEntry> recursiveListUpsert(List<LedgerEntry> ledgerEntrys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedLedgerEntrys = <LedgerEntry>[];
    for (var ledgerEntry in ledgerEntrys) {
        updatedLedgerEntrys.add(recursiveUpsert(ledgerEntry, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedLedgerEntrys;
}

//   @override
//   LedgerEntry upsert(LedgerEntry item) {
//     return recursiveUpsert(item);
//   }

}


class LedgerEntryInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      LedgerEntryInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ledgerEntry) => LedgerEntryStore.instance
            .getOrg$(ledgerEntry, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ledgerEntry) => LedgerEntryStore.instance
            .getOrg(ledgerEntry, modelFilter: modelFilter, includes: includes);
      }
}

	LedgerEntryInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ledgerEntry) => LedgerEntryStore.instance
            .getProperty$(ledgerEntry, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ledgerEntry) => LedgerEntryStore.instance
            .getProperty(ledgerEntry, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum LedgerEntryEndpoints implements Endpoint {

    getAll('/ledgerEntry', HttpMethod.post, List<LedgerEntry>),
	getById('/ledgerEntry/byId/:id', HttpMethod.post, LedgerEntry),
	getManyByOrgId('/ledgerEntry/byOrgId/:orgId', HttpMethod.post, List<LedgerEntry>),
	getManyByPropertyId('/ledgerEntry/byPropertyId/:propertyId', HttpMethod.post, List<LedgerEntry>),
	getManyByListingId('/ledgerEntry/byListingId/:listingId', HttpMethod.post, List<LedgerEntry>),
	getManyByLeaseId('/ledgerEntry/byLeaseId/:leaseId', HttpMethod.post, List<LedgerEntry>),
	getManyByBookingId('/ledgerEntry/byBookingId/:bookingId', HttpMethod.post, List<LedgerEntry>),
	getManyByContractId('/ledgerEntry/byContractId/:contractId', HttpMethod.post, List<LedgerEntry>),
	getManyByBillId('/ledgerEntry/byBillId/:billId', HttpMethod.post, List<LedgerEntry>),
	getManyByTransactionId('/ledgerEntry/byTransactionId/:transactionId', HttpMethod.post, List<LedgerEntry>),
	getManyByType('/ledgerEntry/byType/:type', HttpMethod.post, List<LedgerEntry>),
	getManyByAmount('/ledgerEntry/byAmount/:amount', HttpMethod.post, List<LedgerEntry>),
	getManyByCurrency('/ledgerEntry/byCurrency/:currency', HttpMethod.post, List<LedgerEntry>),
	getManyByOccurredAt('/ledgerEntry/byOccurredAt/:occurredAt', HttpMethod.post, List<LedgerEntry>),
	getManyByNote('/ledgerEntry/byNote/:note', HttpMethod.post, List<LedgerEntry>),
	getManyByMeta('/ledgerEntry/byMeta/:meta', HttpMethod.post, List<LedgerEntry>),
	getManyByCreatedBy('/ledgerEntry/byCreatedBy/:createdBy', HttpMethod.post, List<LedgerEntry>),
	getManyByCreatedAt('/ledgerEntry/byCreatedAt/:createdAt', HttpMethod.post, List<LedgerEntry>),
	getManyByUpdatedAt('/ledgerEntry/byUpdatedAt/:updatedAt', HttpMethod.post, List<LedgerEntry>),
	getManyByDeletedAt('/ledgerEntry/byDeletedAt/:deletedAt', HttpMethod.post, List<LedgerEntry>);

    const LedgerEntryEndpoints(this.path, this.method, this.responseType);

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
