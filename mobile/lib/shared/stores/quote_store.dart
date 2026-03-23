
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class QuoteStore extends ModelStreamStore<String, Quote> {

  static QuoteStore? _instance;

  static QuoteStore get instance {
    _instance ??= QuoteStore();
    return _instance!;
  }

  QuoteStore() : super(Quote.fromJson) {
    if (_instance != null) {
        throw Exception(
            'QuoteStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending QuoteStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use QuoteStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getQuoteId(Quote quote) => quote.id;

	String? getQuoteOrgId(Quote quote) => quote.orgId;

	String? getQuoteContactId(Quote quote) => quote.contactId;

	String? getQuoteQuoteNumber(Quote quote) => quote.quoteNumber;

	String? getQuoteTitle(Quote quote) => quote.title;

	String? getQuoteDescription(Quote quote) => quote.description;

	String? getQuotePropertyId(Quote quote) => quote.propertyId;

	String? getQuoteListingId(Quote quote) => quote.listingId;

	dynamic? getQuoteItems(Quote quote) => quote.items;

	double? getQuoteSubtotal(Quote quote) => quote.subtotal;

	double? getQuoteTaxAmount(Quote quote) => quote.taxAmount;

	double? getQuoteTotalAmount(Quote quote) => quote.totalAmount;

	String? getQuoteCurrency(Quote quote) => quote.currency;

	DateTime? getQuoteValidUntil(Quote quote) => quote.validUntil;

	String? getQuoteStatus(Quote quote) => quote.status;

	String? getQuoteNotes(Quote quote) => quote.notes;

	String? getQuoteTerms(Quote quote) => quote.terms;

	String? getQuoteCreatedBy(Quote quote) => quote.createdBy;

	DateTime? getQuoteCreatedAt(Quote quote) => quote.createdAt;

	DateTime? getQuoteUpdatedAt(Quote quote) => quote.updatedAt;

	DateTime? getQuoteDeletedAt(Quote quote) => quote.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Quote? getByQuoteNumber(
    String quoteNumber,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getIncluding(getQuoteQuoteNumber, quoteNumber, modelFilter: modelFilter, includes: includes);

  
List<Quote> getByOrgId(
    String orgId,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByContactId(
    String contactId,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByTitle(
    String title,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByDescription(
    String description,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByPropertyId(
    String propertyId,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuotePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByListingId(
    String listingId,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByItems(
    dynamic items,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteItems, items, modelFilter: modelFilter, includes: includes);

	
List<Quote> getBySubtotal(
    double subtotal,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteSubtotal, subtotal, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByTaxAmount(
    double taxAmount,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteTaxAmount, taxAmount, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByTotalAmount(
    double totalAmount,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteTotalAmount, totalAmount, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByCurrency(
    String currency,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByValidUntil(
    DateTime validUntil,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteValidUntil, validUntil, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByStatus(
    String status,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByNotes(
    String notes,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByTerms(
    String terms,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteTerms, terms, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByCreatedBy(
    String createdBy,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Quote> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}
    ) =>
    getManyIncluding(getQuoteDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    Quote quote, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (quote.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(quote.contactId!, includes: includes);
        quote.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Listing? getListing(
    Quote quote, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (quote.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(quote.listingId!, includes: includes);
        quote.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    Quote quote, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (quote.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(quote.orgId!, includes: includes);
        quote.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Quote quote, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (quote.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(quote.propertyId!, includes: includes);
        quote.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Quote>> getAll$({bool useCache = true, ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: QuoteEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Quote?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getQuoteId,
        value: id,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Quote?> getByQuoteNumber$(
        String quoteNumber,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getQuoteQuoteNumber,
        value: quoteNumber,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getByQuoteNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Quote>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuotePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByItems$(
        dynamic items,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getQuoteItems,
        value: items,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByItems,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getBySubtotal$(
        double subtotal,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getQuoteSubtotal,
        value: subtotal,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyBySubtotal,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByTaxAmount$(
        double taxAmount,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getQuoteTaxAmount,
        value: taxAmount,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByTaxAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByTotalAmount$(
        double totalAmount,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getQuoteTotalAmount,
        value: totalAmount,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByTotalAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByValidUntil$(
        DateTime validUntil,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQuoteValidUntil,
        value: validUntil,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByValidUntil,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByTerms$(
        String terms,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteTerms,
        value: terms,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByTerms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getQuoteCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQuoteCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQuoteUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Quote>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Quote>? modelFilter,
        List<QuoteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getQuoteDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: QuoteEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    Quote quote, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (quote.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            quote.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            quote.contact = contact;
        });
    }
}

	Stream<Listing?> getListing$(
    Quote quote, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (quote.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            quote.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            quote.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    Quote quote, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (quote.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            quote.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            quote.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Quote quote, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (quote.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            quote.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            quote.property = property;
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
Quote recursiveUpsert(Quote quote, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Quote'} 
        : const {};
    if (quote.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        quote.contact = ContactStore.instance.recursiveUpsert(quote.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (quote.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        quote.listing = ListingStore.instance.recursiveUpsert(quote.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (quote.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        quote.org = OrganizationStore.instance.recursiveUpsert(quote.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (quote.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        quote.property = PropertyStore.instance.recursiveUpsert(quote.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(quote);
}

  List<Quote> recursiveListUpsert(List<Quote> quotes, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedQuotes = <Quote>[];
    for (var quote in quotes) {
        updatedQuotes.add(recursiveUpsert(quote, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedQuotes;
}

//   @override
//   Quote upsert(Quote item) {
//     return recursiveUpsert(item);
//   }

}


class QuoteInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      QuoteInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (quote) => QuoteStore.instance
            .getContact$(quote, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (quote) => QuoteStore.instance
            .getContact(quote, modelFilter: modelFilter, includes: includes);
      }
}

	QuoteInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (quote) => QuoteStore.instance
            .getListing$(quote, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (quote) => QuoteStore.instance
            .getListing(quote, modelFilter: modelFilter, includes: includes);
      }
}

	QuoteInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (quote) => QuoteStore.instance
            .getOrg$(quote, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (quote) => QuoteStore.instance
            .getOrg(quote, modelFilter: modelFilter, includes: includes);
      }
}

	QuoteInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (quote) => QuoteStore.instance
            .getProperty$(quote, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (quote) => QuoteStore.instance
            .getProperty(quote, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum QuoteEndpoints implements Endpoint {

    getAll('/quote', HttpMethod.post, List<Quote>),
	getById('/quote/byId/:id', HttpMethod.post, Quote),
	getManyByOrgId('/quote/byOrgId/:orgId', HttpMethod.post, List<Quote>),
	getManyByContactId('/quote/byContactId/:contactId', HttpMethod.post, List<Quote>),
	getByQuoteNumber('/quote/byQuoteNumber/:quoteNumber', HttpMethod.post, Quote),
	getManyByTitle('/quote/byTitle/:title', HttpMethod.post, List<Quote>),
	getManyByDescription('/quote/byDescription/:description', HttpMethod.post, List<Quote>),
	getManyByPropertyId('/quote/byPropertyId/:propertyId', HttpMethod.post, List<Quote>),
	getManyByListingId('/quote/byListingId/:listingId', HttpMethod.post, List<Quote>),
	getManyByItems('/quote/byItems/:items', HttpMethod.post, List<Quote>),
	getManyBySubtotal('/quote/bySubtotal/:subtotal', HttpMethod.post, List<Quote>),
	getManyByTaxAmount('/quote/byTaxAmount/:taxAmount', HttpMethod.post, List<Quote>),
	getManyByTotalAmount('/quote/byTotalAmount/:totalAmount', HttpMethod.post, List<Quote>),
	getManyByCurrency('/quote/byCurrency/:currency', HttpMethod.post, List<Quote>),
	getManyByValidUntil('/quote/byValidUntil/:validUntil', HttpMethod.post, List<Quote>),
	getManyByStatus('/quote/byStatus/:status', HttpMethod.post, List<Quote>),
	getManyByNotes('/quote/byNotes/:notes', HttpMethod.post, List<Quote>),
	getManyByTerms('/quote/byTerms/:terms', HttpMethod.post, List<Quote>),
	getManyByCreatedBy('/quote/byCreatedBy/:createdBy', HttpMethod.post, List<Quote>),
	getManyByCreatedAt('/quote/byCreatedAt/:createdAt', HttpMethod.post, List<Quote>),
	getManyByUpdatedAt('/quote/byUpdatedAt/:updatedAt', HttpMethod.post, List<Quote>),
	getManyByDeletedAt('/quote/byDeletedAt/:deletedAt', HttpMethod.post, List<Quote>);

    const QuoteEndpoints(this.path, this.method, this.responseType);

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
