
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class NegotiationOfferStore extends ModelStreamStore<String, NegotiationOffer> {

  static NegotiationOfferStore? _instance;

  static NegotiationOfferStore get instance {
    _instance ??= NegotiationOfferStore();
    return _instance!;
  }

  NegotiationOfferStore() : super(NegotiationOffer.fromJson) {
    if (_instance != null) {
        throw Exception(
            'NegotiationOfferStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending NegotiationOfferStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use NegotiationOfferStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getNegotiationOfferId(NegotiationOffer negotiationOffer) => negotiationOffer.id;

	String? getNegotiationOfferOrgId(NegotiationOffer negotiationOffer) => negotiationOffer.orgId;

	String? getNegotiationOfferNegotiationId(NegotiationOffer negotiationOffer) => negotiationOffer.negotiationId;

	NegotiationParty? getNegotiationOfferOfferedBy(NegotiationOffer negotiationOffer) => negotiationOffer.offeredBy;

	int? getNegotiationOfferInstallmentCount(NegotiationOffer negotiationOffer) => negotiationOffer.installmentCount;

	double? getNegotiationOfferFirstPaymentPct(NegotiationOffer negotiationOffer) => negotiationOffer.firstPaymentPct;

	double? getNegotiationOfferTotalAmount(NegotiationOffer negotiationOffer) => negotiationOffer.totalAmount;

	String? getNegotiationOfferCurrency(NegotiationOffer negotiationOffer) => negotiationOffer.currency;

	String? getNegotiationOfferNotes(NegotiationOffer negotiationOffer) => negotiationOffer.notes;

	NegotiationOfferStatus? getNegotiationOfferStatus(NegotiationOffer negotiationOffer) => negotiationOffer.status;

	DateTime? getNegotiationOfferOfferedAt(NegotiationOffer negotiationOffer) => negotiationOffer.offeredAt;

	DateTime? getNegotiationOfferExpiresAt(NegotiationOffer negotiationOffer) => negotiationOffer.expiresAt;

	DateTime? getNegotiationOfferRespondedAt(NegotiationOffer negotiationOffer) => negotiationOffer.respondedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<NegotiationOffer> getByOrgId(
    String orgId,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByNegotiationId(
    String negotiationId,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferNegotiationId, negotiationId, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByOfferedBy(
    NegotiationParty offeredBy,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferOfferedBy, offeredBy, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByInstallmentCount(
    int installmentCount,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferInstallmentCount, installmentCount, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByFirstPaymentPct(
    double firstPaymentPct,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferFirstPaymentPct, firstPaymentPct, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByTotalAmount(
    double totalAmount,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferTotalAmount, totalAmount, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByCurrency(
    String currency,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByNotes(
    String notes,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByStatus(
    NegotiationOfferStatus status,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferStatus, status, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByOfferedAt(
    DateTime offeredAt,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferOfferedAt, offeredAt, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<NegotiationOffer> getByRespondedAt(
    DateTime respondedAt,
    {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}
    ) =>
    getManyIncluding(getNegotiationOfferRespondedAt, respondedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  PaymentNegotiation? getNegotiation(
    NegotiationOffer negotiationOffer, {ModelFilter? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    if (negotiationOffer.negotiationId == null) {
        return null;
    } else {
        final negotiation = PaymentNegotiationStore.instance.getById(negotiationOffer.negotiationId!, includes: includes);
        negotiationOffer.negotiation = negotiation;
        // setIncludedReferences(negotiation, includes: includes);
        return negotiation;
    }
}

	Organization? getOrg(
    NegotiationOffer negotiationOffer, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (negotiationOffer.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(negotiationOffer.orgId!, includes: includes);
        negotiationOffer.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<NegotiationOffer>> getAll$({bool useCache = true, ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: NegotiationOfferEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<NegotiationOffer?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getNegotiationOfferId,
        value: id,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<NegotiationOffer>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNegotiationOfferOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByNegotiationId$(
        String negotiationId,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNegotiationOfferNegotiationId,
        value: negotiationId,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByNegotiationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByOfferedBy$(
        NegotiationParty offeredBy,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<NegotiationParty>(
        getPropVal: getNegotiationOfferOfferedBy,
        value: offeredBy,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByOfferedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByInstallmentCount$(
        int installmentCount,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getNegotiationOfferInstallmentCount,
        value: installmentCount,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByInstallmentCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByFirstPaymentPct$(
        double firstPaymentPct,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getNegotiationOfferFirstPaymentPct,
        value: firstPaymentPct,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByFirstPaymentPct,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByTotalAmount$(
        double totalAmount,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getNegotiationOfferTotalAmount,
        value: totalAmount,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByTotalAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNegotiationOfferCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNegotiationOfferNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByStatus$(
        NegotiationOfferStatus status,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<NegotiationOfferStatus>(
        getPropVal: getNegotiationOfferStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByOfferedAt$(
        DateTime offeredAt,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNegotiationOfferOfferedAt,
        value: offeredAt,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByOfferedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNegotiationOfferExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<NegotiationOffer>> getByRespondedAt$(
        DateTime respondedAt,
        {bool useCache = true,
        ModelFilter<NegotiationOffer>? modelFilter,
        List<NegotiationOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNegotiationOfferRespondedAt,
        value: respondedAt,
        modelFilter: modelFilter,
        endpoint: NegotiationOfferEndpoints.getManyByRespondedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<PaymentNegotiation?> getNegotiation$(
    NegotiationOffer negotiationOffer, {bool useCache = true, ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    if (negotiationOffer.negotiationId == null) {
        return Stream.value(null);
    } else {
        return PaymentNegotiationStore.instance.getById$(
            negotiationOffer.negotiationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((negotiation) {
            negotiationOffer.negotiation = negotiation;
        });
    }
}

	Stream<Organization?> getOrg$(
    NegotiationOffer negotiationOffer, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (negotiationOffer.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            negotiationOffer.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            negotiationOffer.org = org;
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
NegotiationOffer recursiveUpsert(NegotiationOffer negotiationOffer, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'NegotiationOffer'} 
        : const {};
    if (negotiationOffer.negotiation != null && (!preventCircularSerialization || !upsertedTypes.contains('PaymentNegotiation'))) {
        negotiationOffer.negotiation = PaymentNegotiationStore.instance.recursiveUpsert(negotiationOffer.negotiation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (negotiationOffer.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        negotiationOffer.org = OrganizationStore.instance.recursiveUpsert(negotiationOffer.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(negotiationOffer);
}

  List<NegotiationOffer> recursiveListUpsert(List<NegotiationOffer> negotiationOffers, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedNegotiationOffers = <NegotiationOffer>[];
    for (var negotiationOffer in negotiationOffers) {
        updatedNegotiationOffers.add(recursiveUpsert(negotiationOffer, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedNegotiationOffers;
}

//   @override
//   NegotiationOffer upsert(NegotiationOffer item) {
//     return recursiveUpsert(item);
//   }

}


class NegotiationOfferInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      NegotiationOfferInclude.negotiation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PaymentNegotiation>? modelFilter,
    List<PaymentNegotiationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (negotiationOffer) => NegotiationOfferStore.instance
            .getNegotiation$(negotiationOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (negotiationOffer) => NegotiationOfferStore.instance
            .getNegotiation(negotiationOffer, modelFilter: modelFilter, includes: includes);
      }
}

	NegotiationOfferInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (negotiationOffer) => NegotiationOfferStore.instance
            .getOrg$(negotiationOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (negotiationOffer) => NegotiationOfferStore.instance
            .getOrg(negotiationOffer, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum NegotiationOfferEndpoints implements Endpoint {

    getAll('/negotiationOffer', HttpMethod.post, List<NegotiationOffer>),
	getById('/negotiationOffer/byId/:id', HttpMethod.post, NegotiationOffer),
	getManyByOrgId('/negotiationOffer/byOrgId/:orgId', HttpMethod.post, List<NegotiationOffer>),
	getManyByNegotiationId('/negotiationOffer/byNegotiationId/:negotiationId', HttpMethod.post, List<NegotiationOffer>),
	getManyByOfferedBy('/negotiationOffer/byOfferedBy/:offeredBy', HttpMethod.post, List<NegotiationOffer>),
	getManyByInstallmentCount('/negotiationOffer/byInstallmentCount/:installmentCount', HttpMethod.post, List<NegotiationOffer>),
	getManyByFirstPaymentPct('/negotiationOffer/byFirstPaymentPct/:firstPaymentPct', HttpMethod.post, List<NegotiationOffer>),
	getManyByTotalAmount('/negotiationOffer/byTotalAmount/:totalAmount', HttpMethod.post, List<NegotiationOffer>),
	getManyByCurrency('/negotiationOffer/byCurrency/:currency', HttpMethod.post, List<NegotiationOffer>),
	getManyByNotes('/negotiationOffer/byNotes/:notes', HttpMethod.post, List<NegotiationOffer>),
	getManyByStatus('/negotiationOffer/byStatus/:status', HttpMethod.post, List<NegotiationOffer>),
	getManyByOfferedAt('/negotiationOffer/byOfferedAt/:offeredAt', HttpMethod.post, List<NegotiationOffer>),
	getManyByExpiresAt('/negotiationOffer/byExpiresAt/:expiresAt', HttpMethod.post, List<NegotiationOffer>),
	getManyByRespondedAt('/negotiationOffer/byRespondedAt/:respondedAt', HttpMethod.post, List<NegotiationOffer>);

    const NegotiationOfferEndpoints(this.path, this.method, this.responseType);

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
