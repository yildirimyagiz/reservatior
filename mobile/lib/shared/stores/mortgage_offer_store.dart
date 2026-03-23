
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MortgageOfferStore extends ModelStreamStore<String, MortgageOffer> {

  static MortgageOfferStore? _instance;

  static MortgageOfferStore get instance {
    _instance ??= MortgageOfferStore();
    return _instance!;
  }

  MortgageOfferStore() : super(MortgageOffer.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MortgageOfferStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MortgageOfferStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MortgageOfferStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMortgageOfferId(MortgageOffer mortgageOffer) => mortgageOffer.id;

	String? getMortgageOfferOrgId(MortgageOffer mortgageOffer) => mortgageOffer.orgId;

	String? getMortgageOfferContactId(MortgageOffer mortgageOffer) => mortgageOffer.contactId;

	String? getMortgageOfferPropertyId(MortgageOffer mortgageOffer) => mortgageOffer.propertyId;

	String? getMortgageOfferLender(MortgageOffer mortgageOffer) => mortgageOffer.lender;

	double? getMortgageOfferOfferAmount(MortgageOffer mortgageOffer) => mortgageOffer.offerAmount;

	double? getMortgageOfferInterestRate(MortgageOffer mortgageOffer) => mortgageOffer.interestRate;

	int? getMortgageOfferTermYears(MortgageOffer mortgageOffer) => mortgageOffer.termYears;

	double? getMortgageOfferMonthlyPayment(MortgageOffer mortgageOffer) => mortgageOffer.monthlyPayment;

	String? getMortgageOfferCurrency(MortgageOffer mortgageOffer) => mortgageOffer.currency;

	String? getMortgageOfferStatus(MortgageOffer mortgageOffer) => mortgageOffer.status;

	DateTime? getMortgageOfferOfferedAt(MortgageOffer mortgageOffer) => mortgageOffer.offeredAt;

	DateTime? getMortgageOfferAcceptedAt(MortgageOffer mortgageOffer) => mortgageOffer.acceptedAt;

	DateTime? getMortgageOfferExpiresAt(MortgageOffer mortgageOffer) => mortgageOffer.expiresAt;

	String? getMortgageOfferConditions(MortgageOffer mortgageOffer) => mortgageOffer.conditions;

	String? getMortgageOfferCreatedBy(MortgageOffer mortgageOffer) => mortgageOffer.createdBy;

	DateTime? getMortgageOfferCreatedAt(MortgageOffer mortgageOffer) => mortgageOffer.createdAt;

	DateTime? getMortgageOfferUpdatedAt(MortgageOffer mortgageOffer) => mortgageOffer.updatedAt;

	DateTime? getMortgageOfferDeletedAt(MortgageOffer mortgageOffer) => mortgageOffer.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MortgageOffer> getByOrgId(
    String orgId,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByContactId(
    String contactId,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByPropertyId(
    String propertyId,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByLender(
    String lender,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferLender, lender, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByOfferAmount(
    double offerAmount,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferOfferAmount, offerAmount, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByInterestRate(
    double interestRate,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferInterestRate, interestRate, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByTermYears(
    int termYears,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferTermYears, termYears, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByMonthlyPayment(
    double monthlyPayment,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferMonthlyPayment, monthlyPayment, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByCurrency(
    String currency,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByStatus(
    String status,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferStatus, status, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByOfferedAt(
    DateTime offeredAt,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferOfferedAt, offeredAt, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByAcceptedAt(
    DateTime acceptedAt,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferAcceptedAt, acceptedAt, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByConditions(
    String conditions,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferConditions, conditions, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByCreatedBy(
    String createdBy,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<MortgageOffer> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}
    ) =>
    getManyIncluding(getMortgageOfferDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    MortgageOffer mortgageOffer, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (mortgageOffer.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(mortgageOffer.contactId!, includes: includes);
        mortgageOffer.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Organization? getOrg(
    MortgageOffer mortgageOffer, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mortgageOffer.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mortgageOffer.orgId!, includes: includes);
        mortgageOffer.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    MortgageOffer mortgageOffer, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (mortgageOffer.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(mortgageOffer.propertyId!, includes: includes);
        mortgageOffer.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MortgageOffer>> getAll$({bool useCache = true, ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MortgageOfferEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MortgageOffer?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMortgageOfferId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MortgageOffer>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageOfferOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageOfferContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageOfferPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByLender$(
        String lender,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageOfferLender,
        value: lender,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByLender,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByOfferAmount$(
        double offerAmount,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgageOfferOfferAmount,
        value: offerAmount,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByOfferAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByInterestRate$(
        double interestRate,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgageOfferInterestRate,
        value: interestRate,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByInterestRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByTermYears$(
        int termYears,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMortgageOfferTermYears,
        value: termYears,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByTermYears,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByMonthlyPayment$(
        double monthlyPayment,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgageOfferMonthlyPayment,
        value: monthlyPayment,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByMonthlyPayment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageOfferCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageOfferStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByOfferedAt$(
        DateTime offeredAt,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageOfferOfferedAt,
        value: offeredAt,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByOfferedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByAcceptedAt$(
        DateTime acceptedAt,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageOfferAcceptedAt,
        value: acceptedAt,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByAcceptedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageOfferExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByConditions$(
        String conditions,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageOfferConditions,
        value: conditions,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByConditions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageOfferCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageOfferCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageOfferUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgageOffer>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<MortgageOffer>? modelFilter,
        List<MortgageOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageOfferDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MortgageOfferEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    MortgageOffer mortgageOffer, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (mortgageOffer.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            mortgageOffer.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            mortgageOffer.contact = contact;
        });
    }
}

	Stream<Organization?> getOrg$(
    MortgageOffer mortgageOffer, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mortgageOffer.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mortgageOffer.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mortgageOffer.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    MortgageOffer mortgageOffer, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (mortgageOffer.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            mortgageOffer.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            mortgageOffer.property = property;
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
MortgageOffer recursiveUpsert(MortgageOffer mortgageOffer, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MortgageOffer'} 
        : const {};
    if (mortgageOffer.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        mortgageOffer.contact = ContactStore.instance.recursiveUpsert(mortgageOffer.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mortgageOffer.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mortgageOffer.org = OrganizationStore.instance.recursiveUpsert(mortgageOffer.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mortgageOffer.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        mortgageOffer.property = PropertyStore.instance.recursiveUpsert(mortgageOffer.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mortgageOffer);
}

  List<MortgageOffer> recursiveListUpsert(List<MortgageOffer> mortgageOffers, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMortgageOffers = <MortgageOffer>[];
    for (var mortgageOffer in mortgageOffers) {
        updatedMortgageOffers.add(recursiveUpsert(mortgageOffer, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMortgageOffers;
}

//   @override
//   MortgageOffer upsert(MortgageOffer item) {
//     return recursiveUpsert(item);
//   }

}


class MortgageOfferInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MortgageOfferInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mortgageOffer) => MortgageOfferStore.instance
            .getContact$(mortgageOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mortgageOffer) => MortgageOfferStore.instance
            .getContact(mortgageOffer, modelFilter: modelFilter, includes: includes);
      }
}

	MortgageOfferInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mortgageOffer) => MortgageOfferStore.instance
            .getOrg$(mortgageOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mortgageOffer) => MortgageOfferStore.instance
            .getOrg(mortgageOffer, modelFilter: modelFilter, includes: includes);
      }
}

	MortgageOfferInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mortgageOffer) => MortgageOfferStore.instance
            .getProperty$(mortgageOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mortgageOffer) => MortgageOfferStore.instance
            .getProperty(mortgageOffer, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MortgageOfferEndpoints implements Endpoint {

    getAll('/mortgageOffer', HttpMethod.post, List<MortgageOffer>),
	getById('/mortgageOffer/byId/:id', HttpMethod.post, MortgageOffer),
	getManyByOrgId('/mortgageOffer/byOrgId/:orgId', HttpMethod.post, List<MortgageOffer>),
	getManyByContactId('/mortgageOffer/byContactId/:contactId', HttpMethod.post, List<MortgageOffer>),
	getManyByPropertyId('/mortgageOffer/byPropertyId/:propertyId', HttpMethod.post, List<MortgageOffer>),
	getManyByLender('/mortgageOffer/byLender/:lender', HttpMethod.post, List<MortgageOffer>),
	getManyByOfferAmount('/mortgageOffer/byOfferAmount/:offerAmount', HttpMethod.post, List<MortgageOffer>),
	getManyByInterestRate('/mortgageOffer/byInterestRate/:interestRate', HttpMethod.post, List<MortgageOffer>),
	getManyByTermYears('/mortgageOffer/byTermYears/:termYears', HttpMethod.post, List<MortgageOffer>),
	getManyByMonthlyPayment('/mortgageOffer/byMonthlyPayment/:monthlyPayment', HttpMethod.post, List<MortgageOffer>),
	getManyByCurrency('/mortgageOffer/byCurrency/:currency', HttpMethod.post, List<MortgageOffer>),
	getManyByStatus('/mortgageOffer/byStatus/:status', HttpMethod.post, List<MortgageOffer>),
	getManyByOfferedAt('/mortgageOffer/byOfferedAt/:offeredAt', HttpMethod.post, List<MortgageOffer>),
	getManyByAcceptedAt('/mortgageOffer/byAcceptedAt/:acceptedAt', HttpMethod.post, List<MortgageOffer>),
	getManyByExpiresAt('/mortgageOffer/byExpiresAt/:expiresAt', HttpMethod.post, List<MortgageOffer>),
	getManyByConditions('/mortgageOffer/byConditions/:conditions', HttpMethod.post, List<MortgageOffer>),
	getManyByCreatedBy('/mortgageOffer/byCreatedBy/:createdBy', HttpMethod.post, List<MortgageOffer>),
	getManyByCreatedAt('/mortgageOffer/byCreatedAt/:createdAt', HttpMethod.post, List<MortgageOffer>),
	getManyByUpdatedAt('/mortgageOffer/byUpdatedAt/:updatedAt', HttpMethod.post, List<MortgageOffer>),
	getManyByDeletedAt('/mortgageOffer/byDeletedAt/:deletedAt', HttpMethod.post, List<MortgageOffer>);

    const MortgageOfferEndpoints(this.path, this.method, this.responseType);

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
