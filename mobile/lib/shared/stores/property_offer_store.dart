
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyOfferStore extends ModelStreamStore<String, PropertyOffer> {

  static PropertyOfferStore? _instance;

  static PropertyOfferStore get instance {
    _instance ??= PropertyOfferStore();
    return _instance!;
  }

  PropertyOfferStore() : super(PropertyOffer.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyOfferStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyOfferStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyOfferStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyOfferId(PropertyOffer propertyOffer) => propertyOffer.id;

	String? getPropertyOfferOrgId(PropertyOffer propertyOffer) => propertyOffer.orgId;

	String? getPropertyOfferPropertyId(PropertyOffer propertyOffer) => propertyOffer.propertyId;

	String? getPropertyOfferListingId(PropertyOffer propertyOffer) => propertyOffer.listingId;

	String? getPropertyOfferContactId(PropertyOffer propertyOffer) => propertyOffer.contactId;

	String? getPropertyOfferOriginalOfferId(PropertyOffer propertyOffer) => propertyOffer.originalOfferId;

	double? getPropertyOfferOfferPrice(PropertyOffer propertyOffer) => propertyOffer.offerPrice;

	String? getPropertyOfferCurrency(PropertyOffer propertyOffer) => propertyOffer.currency;

	DateTime? getPropertyOfferClosingDate(PropertyOffer propertyOffer) => propertyOffer.closingDate;

	String? getPropertyOfferFinancingType(PropertyOffer propertyOffer) => propertyOffer.financingType;

	double? getPropertyOfferEarnestMoneyDeposit(PropertyOffer propertyOffer) => propertyOffer.earnestMoneyDeposit;

	int? getPropertyOfferDueDiligencePeriod(PropertyOffer propertyOffer) => propertyOffer.dueDiligencePeriod;

	bool? getPropertyOfferInspectionContingency(PropertyOffer propertyOffer) => propertyOffer.inspectionContingency;

	bool? getPropertyOfferAppraisalContingency(PropertyOffer propertyOffer) => propertyOffer.appraisalContingency;

	String? getPropertyOfferSpecialConditions(PropertyOffer propertyOffer) => propertyOffer.specialConditions;

	String? getPropertyOfferStatus(PropertyOffer propertyOffer) => propertyOffer.status;

	DateTime? getPropertyOfferValidUntil(PropertyOffer propertyOffer) => propertyOffer.validUntil;

	DateTime? getPropertyOfferCreatedAt(PropertyOffer propertyOffer) => propertyOffer.createdAt;

	DateTime? getPropertyOfferUpdatedAt(PropertyOffer propertyOffer) => propertyOffer.updatedAt;

	DateTime? getPropertyOfferDeletedAt(PropertyOffer propertyOffer) => propertyOffer.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyOffer> getByOrgId(
    String orgId,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByListingId(
    String listingId,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByContactId(
    String contactId,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByOriginalOfferId(
    String originalOfferId,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferOriginalOfferId, originalOfferId, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByOfferPrice(
    double offerPrice,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferOfferPrice, offerPrice, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByCurrency(
    String currency,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByClosingDate(
    DateTime closingDate,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferClosingDate, closingDate, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByFinancingType(
    String financingType,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferFinancingType, financingType, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByEarnestMoneyDeposit(
    double earnestMoneyDeposit,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferEarnestMoneyDeposit, earnestMoneyDeposit, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByDueDiligencePeriod(
    int dueDiligencePeriod,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferDueDiligencePeriod, dueDiligencePeriod, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByInspectionContingency(
    bool inspectionContingency,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferInspectionContingency, inspectionContingency, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByAppraisalContingency(
    bool appraisalContingency,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferAppraisalContingency, appraisalContingency, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getBySpecialConditions(
    String specialConditions,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferSpecialConditions, specialConditions, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByStatus(
    String status,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferStatus, status, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByValidUntil(
    DateTime validUntil,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferValidUntil, validUntil, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyOffer> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOfferDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    PropertyOffer propertyOffer, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (propertyOffer.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(propertyOffer.contactId!, includes: includes);
        propertyOffer.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Listing? getListing(
    PropertyOffer propertyOffer, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (propertyOffer.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(propertyOffer.listingId!, includes: includes);
        propertyOffer.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    PropertyOffer propertyOffer, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyOffer.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(propertyOffer.orgId!, includes: includes);
        propertyOffer.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	PropertyOffer? getOriginalOffer(
    PropertyOffer propertyOffer, {ModelFilter? modelFilter, List<PropertyOfferInclude>? includes}) {
    if (propertyOffer.originalOfferId == null) {
        return null;
    } else {
        final originalOffer = PropertyOfferStore.instance.getById(propertyOffer.originalOfferId!, includes: includes);
        propertyOffer.originalOffer = originalOffer;
        // setIncludedReferences(originalOffer, includes: includes);
        return originalOffer;
    }
}

	Property? getProperty(
    PropertyOffer propertyOffer, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyOffer.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyOffer.propertyId!, includes: includes);
        propertyOffer.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<PropertyOffer> getCounterOffers(
    PropertyOffer propertyOffer, {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    final counterOffers = PropertyOfferStore.instance.getByOriginalOfferId(propertyOffer.$uid!, modelFilter: modelFilter, includes: includes);
    propertyOffer.counterOffers = counterOffers;
    // setIncludedReferencesForList(counterOffers, includes: includes);
    return counterOffers;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyOffer>> getAll$({bool useCache = true, ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyOfferEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyOffer?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyOfferId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyOffer>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByOriginalOfferId$(
        String originalOfferId,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferOriginalOfferId,
        value: originalOfferId,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByOriginalOfferId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByOfferPrice$(
        double offerPrice,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyOfferOfferPrice,
        value: offerPrice,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByOfferPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByClosingDate$(
        DateTime closingDate,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyOfferClosingDate,
        value: closingDate,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByClosingDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByFinancingType$(
        String financingType,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferFinancingType,
        value: financingType,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByFinancingType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByEarnestMoneyDeposit$(
        double earnestMoneyDeposit,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyOfferEarnestMoneyDeposit,
        value: earnestMoneyDeposit,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByEarnestMoneyDeposit,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByDueDiligencePeriod$(
        int dueDiligencePeriod,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyOfferDueDiligencePeriod,
        value: dueDiligencePeriod,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByDueDiligencePeriod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByInspectionContingency$(
        bool inspectionContingency,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPropertyOfferInspectionContingency,
        value: inspectionContingency,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByInspectionContingency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByAppraisalContingency$(
        bool appraisalContingency,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPropertyOfferAppraisalContingency,
        value: appraisalContingency,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByAppraisalContingency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getBySpecialConditions$(
        String specialConditions,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferSpecialConditions,
        value: specialConditions,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyBySpecialConditions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOfferStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByValidUntil$(
        DateTime validUntil,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyOfferValidUntil,
        value: validUntil,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByValidUntil,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyOfferCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyOfferUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyOffer>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<PropertyOffer>? modelFilter,
        List<PropertyOfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyOfferDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PropertyOfferEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    PropertyOffer propertyOffer, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (propertyOffer.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            propertyOffer.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            propertyOffer.contact = contact;
        });
    }
}

	Stream<Listing?> getListing$(
    PropertyOffer propertyOffer, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (propertyOffer.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            propertyOffer.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            propertyOffer.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    PropertyOffer propertyOffer, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyOffer.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            propertyOffer.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            propertyOffer.org = org;
        });
    }
}

	Stream<PropertyOffer?> getOriginalOffer$(
    PropertyOffer propertyOffer, {bool useCache = true, ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    if (propertyOffer.originalOfferId == null) {
        return Stream.value(null);
    } else {
        return PropertyOfferStore.instance.getById$(
            propertyOffer.originalOfferId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((originalOffer) {
            propertyOffer.originalOffer = originalOffer;
        });
    }
}

	Stream<Property?> getProperty$(
    PropertyOffer propertyOffer, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyOffer.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyOffer.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyOffer.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<PropertyOffer>> getCounterOffers$(
    PropertyOffer propertyOffer, {bool useCache = true, ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    return PropertyOfferStore.instance.getByOriginalOfferId$(
        propertyOffer.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((counterOffers) {
        propertyOffer.counterOffers = counterOffers;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
PropertyOffer recursiveUpsert(PropertyOffer propertyOffer, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyOffer'} 
        : const {};
    if (propertyOffer.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        propertyOffer.contact = ContactStore.instance.recursiveUpsert(propertyOffer.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyOffer.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        propertyOffer.listing = ListingStore.instance.recursiveUpsert(propertyOffer.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyOffer.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        propertyOffer.org = OrganizationStore.instance.recursiveUpsert(propertyOffer.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyOffer.originalOffer != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyOffer'))) {
        propertyOffer.originalOffer = PropertyOfferStore.instance.recursiveUpsert(propertyOffer.originalOffer!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyOffer.counterOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyOffer'))) {
        propertyOffer.counterOffers = PropertyOfferStore.instance.recursiveListUpsert(propertyOffer.counterOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyOffer.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyOffer.property = PropertyStore.instance.recursiveUpsert(propertyOffer.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyOffer);
}

  List<PropertyOffer> recursiveListUpsert(List<PropertyOffer> propertyOffers, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyOffers = <PropertyOffer>[];
    for (var propertyOffer in propertyOffers) {
        updatedPropertyOffers.add(recursiveUpsert(propertyOffer, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyOffers;
}

//   @override
//   PropertyOffer upsert(PropertyOffer item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyOfferInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyOfferInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyOffer) => PropertyOfferStore.instance
            .getContact$(propertyOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyOffer) => PropertyOfferStore.instance
            .getContact(propertyOffer, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyOfferInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyOffer) => PropertyOfferStore.instance
            .getListing$(propertyOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyOffer) => PropertyOfferStore.instance
            .getListing(propertyOffer, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyOfferInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyOffer) => PropertyOfferStore.instance
            .getOrg$(propertyOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyOffer) => PropertyOfferStore.instance
            .getOrg(propertyOffer, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyOfferInclude.originalOffer({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyOffer>? modelFilter,
    List<PropertyOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyOffer) => PropertyOfferStore.instance
            .getOriginalOffer$(propertyOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyOffer) => PropertyOfferStore.instance
            .getOriginalOffer(propertyOffer, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyOfferInclude.counterOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyOffer>? modelFilter,
    List<PropertyOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyOffer) => PropertyOfferStore.instance
            .getCounterOffers$(propertyOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyOffer) => PropertyOfferStore.instance
            .getCounterOffers(propertyOffer, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyOfferInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyOffer) => PropertyOfferStore.instance
            .getProperty$(propertyOffer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyOffer) => PropertyOfferStore.instance
            .getProperty(propertyOffer, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyOfferEndpoints implements Endpoint {

    getAll('/propertyOffer', HttpMethod.post, List<PropertyOffer>),
	getById('/propertyOffer/byId/:id', HttpMethod.post, PropertyOffer),
	getManyByOrgId('/propertyOffer/byOrgId/:orgId', HttpMethod.post, List<PropertyOffer>),
	getManyByPropertyId('/propertyOffer/byPropertyId/:propertyId', HttpMethod.post, List<PropertyOffer>),
	getManyByListingId('/propertyOffer/byListingId/:listingId', HttpMethod.post, List<PropertyOffer>),
	getManyByContactId('/propertyOffer/byContactId/:contactId', HttpMethod.post, List<PropertyOffer>),
	getManyByOriginalOfferId('/propertyOffer/byOriginalOfferId/:originalOfferId', HttpMethod.post, List<PropertyOffer>),
	getManyByOfferPrice('/propertyOffer/byOfferPrice/:offerPrice', HttpMethod.post, List<PropertyOffer>),
	getManyByCurrency('/propertyOffer/byCurrency/:currency', HttpMethod.post, List<PropertyOffer>),
	getManyByClosingDate('/propertyOffer/byClosingDate/:closingDate', HttpMethod.post, List<PropertyOffer>),
	getManyByFinancingType('/propertyOffer/byFinancingType/:financingType', HttpMethod.post, List<PropertyOffer>),
	getManyByEarnestMoneyDeposit('/propertyOffer/byEarnestMoneyDeposit/:earnestMoneyDeposit', HttpMethod.post, List<PropertyOffer>),
	getManyByDueDiligencePeriod('/propertyOffer/byDueDiligencePeriod/:dueDiligencePeriod', HttpMethod.post, List<PropertyOffer>),
	getManyByInspectionContingency('/propertyOffer/byInspectionContingency/:inspectionContingency', HttpMethod.post, List<PropertyOffer>),
	getManyByAppraisalContingency('/propertyOffer/byAppraisalContingency/:appraisalContingency', HttpMethod.post, List<PropertyOffer>),
	getManyBySpecialConditions('/propertyOffer/bySpecialConditions/:specialConditions', HttpMethod.post, List<PropertyOffer>),
	getManyByStatus('/propertyOffer/byStatus/:status', HttpMethod.post, List<PropertyOffer>),
	getManyByValidUntil('/propertyOffer/byValidUntil/:validUntil', HttpMethod.post, List<PropertyOffer>),
	getManyByCreatedAt('/propertyOffer/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyOffer>),
	getManyByUpdatedAt('/propertyOffer/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyOffer>),
	getManyByDeletedAt('/propertyOffer/byDeletedAt/:deletedAt', HttpMethod.post, List<PropertyOffer>);

    const PropertyOfferEndpoints(this.path, this.method, this.responseType);

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
