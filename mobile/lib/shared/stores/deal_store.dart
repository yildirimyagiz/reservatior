
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class DealStore extends ModelStreamStore<String, Deal> {

  static DealStore? _instance;

  static DealStore get instance {
    _instance ??= DealStore();
    return _instance!;
  }

  DealStore() : super(Deal.fromJson) {
    if (_instance != null) {
        throw Exception(
            'DealStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending DealStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use DealStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getDealId(Deal deal) => deal.id;

	String? getDealOrgId(Deal deal) => deal.orgId;

	String? getDealListingId(Deal deal) => deal.listingId;

	String? getDealPropertyId(Deal deal) => deal.propertyId;

	String? getDealClientId(Deal deal) => deal.clientId;

	String? getDealAgentId(Deal deal) => deal.agentId;

	String? getDealLocationId(Deal deal) => deal.locationId;

	DealStatusUSA? getDealDealStatus(Deal deal) => deal.dealStatus;

	String? getDealDealType(Deal deal) => deal.dealType;

	double? getDealOfferPrice(Deal deal) => deal.offerPrice;

	double? getDealListPrice(Deal deal) => deal.listPrice;

	double? getDealSalePrice(Deal deal) => deal.salePrice;

	double? getDealCommissionRate(Deal deal) => deal.commissionRate;

	double? getDealCommissionAmount(Deal deal) => deal.commissionAmount;

	DateTime? getDealClosingDate(Deal deal) => deal.closingDate;

	String? getDealFinancingType(Deal deal) => deal.financingType;

	double? getDealLoanAmount(Deal deal) => deal.loanAmount;

	double? getDealDownPayment(Deal deal) => deal.downPayment;

	double? getDealEarnestMoney(Deal deal) => deal.earnestMoney;

	double? getDealEscrowAmount(Deal deal) => deal.escrowAmount;

	double? getDealClosingCosts(Deal deal) => deal.closingCosts;

	double? getDealSellerConcessions(Deal deal) => deal.sellerConcessions;

	double? getDealBuyerCredits(Deal deal) => deal.buyerCredits;

	int? getDealInspectionPeriod(Deal deal) => deal.inspectionPeriod;

	bool? getDealFinancingContingency(Deal deal) => deal.financingContingency;

	bool? getDealAppraisalContingency(Deal deal) => deal.appraisalContingency;

	bool? getDealTitleContingency(Deal deal) => deal.titleContingency;

	bool? getDealAttorneyReview(Deal deal) => deal.attorneyReview;

	bool? getDealMultipleOffers(Deal deal) => deal.multipleOffers;

	String? getDealCreatedBy(Deal deal) => deal.createdBy;

	DateTime? getDealCreatedAt(Deal deal) => deal.createdAt;

	DateTime? getDealUpdatedAt(Deal deal) => deal.updatedAt;

	DateTime? getDealDeletedAt(Deal deal) => deal.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Deal? getByLocationId(
    String locationId,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getIncluding(getDealLocationId, locationId, modelFilter: modelFilter, includes: includes);

  
List<Deal> getByOrgId(
    String orgId,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByListingId(
    String listingId,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByPropertyId(
    String propertyId,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByClientId(
    String clientId,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealClientId, clientId, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByAgentId(
    String agentId,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealAgentId, agentId, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByDealStatus(
    DealStatusUSA dealStatus,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealDealStatus, dealStatus, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByDealType(
    String dealType,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealDealType, dealType, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByOfferPrice(
    double offerPrice,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealOfferPrice, offerPrice, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByListPrice(
    double listPrice,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealListPrice, listPrice, modelFilter: modelFilter, includes: includes);

	
List<Deal> getBySalePrice(
    double salePrice,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealSalePrice, salePrice, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByCommissionRate(
    double commissionRate,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealCommissionRate, commissionRate, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByCommissionAmount(
    double commissionAmount,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealCommissionAmount, commissionAmount, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByClosingDate(
    DateTime closingDate,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealClosingDate, closingDate, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByFinancingType(
    String financingType,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealFinancingType, financingType, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByLoanAmount(
    double loanAmount,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealLoanAmount, loanAmount, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByDownPayment(
    double downPayment,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealDownPayment, downPayment, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByEarnestMoney(
    double earnestMoney,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealEarnestMoney, earnestMoney, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByEscrowAmount(
    double escrowAmount,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealEscrowAmount, escrowAmount, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByClosingCosts(
    double closingCosts,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealClosingCosts, closingCosts, modelFilter: modelFilter, includes: includes);

	
List<Deal> getBySellerConcessions(
    double sellerConcessions,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealSellerConcessions, sellerConcessions, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByBuyerCredits(
    double buyerCredits,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealBuyerCredits, buyerCredits, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByInspectionPeriod(
    int inspectionPeriod,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealInspectionPeriod, inspectionPeriod, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByFinancingContingency(
    bool financingContingency,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealFinancingContingency, financingContingency, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByAppraisalContingency(
    bool appraisalContingency,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealAppraisalContingency, appraisalContingency, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByTitleContingency(
    bool titleContingency,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealTitleContingency, titleContingency, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByAttorneyReview(
    bool attorneyReview,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealAttorneyReview, attorneyReview, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByMultipleOffers(
    bool multipleOffers,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealMultipleOffers, multipleOffers, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByCreatedBy(
    String createdBy,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Deal> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}
    ) =>
    getManyIncluding(getDealDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getAgent(
    Deal deal, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (deal.agentId == null) {
        return null;
    } else {
        final agent = ContactStore.instance.getById(deal.agentId!, includes: includes);
        deal.agent = agent;
        // setIncludedReferences(agent, includes: includes);
        return agent;
    }
}

	Contact? getClient(
    Deal deal, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (deal.clientId == null) {
        return null;
    } else {
        final client = ContactStore.instance.getById(deal.clientId!, includes: includes);
        deal.client = client;
        // setIncludedReferences(client, includes: includes);
        return client;
    }
}

	Listing? getListing(
    Deal deal, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (deal.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(deal.listingId!, includes: includes);
        deal.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Location? getLocation(
    Deal deal, {ModelFilter? modelFilter, List<LocationInclude>? includes}) {
    if (deal.locationId == null) {
        return null;
    } else {
        final location = LocationStore.instance.getById(deal.locationId!, includes: includes);
        deal.location = location;
        // setIncludedReferences(location, includes: includes);
        return location;
    }
}

	Organization? getOrg(
    Deal deal, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (deal.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(deal.orgId!, includes: includes);
        deal.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Deal deal, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (deal.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(deal.propertyId!, includes: includes);
        deal.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  AttorneyManagement? getAttorney(
    Deal deal, {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}) {
    final attorney = AttorneyManagementStore.instance.getByDealId(deal.$uid!, modelFilter: modelFilter, includes: includes);
    deal.attorney = attorney;
    // setIncludedReferences(attorney, includes: includes);
    return attorney;
}

	List<Document> getDocuments(
    Deal deal, {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    final documents = DocumentStore.instance.getByDealId(deal.$uid!, modelFilter: modelFilter, includes: includes);
    deal.documents = documents;
    // setIncludedReferencesForList(documents, includes: includes);
    return documents;
}

	List<MortgagePreApproval> getMortgagePreApprovals(
    Deal deal, {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}) {
    final mortgagePreApprovals = MortgagePreApprovalStore.instance.getByDealId(deal.$uid!, modelFilter: modelFilter, includes: includes);
    deal.mortgagePreApprovals = mortgagePreApprovals;
    // setIncludedReferencesForList(mortgagePreApprovals, includes: includes);
    return mortgagePreApprovals;
}

	List<Payout> getPayouts(
    Deal deal, {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    final payouts = PayoutStore.instance.getByDealId(deal.$uid!, modelFilter: modelFilter, includes: includes);
    deal.payouts = payouts;
    // setIncludedReferencesForList(payouts, includes: includes);
    return payouts;
}

	List<SolicitorManagement> getSolicitorManagements(
    Deal deal, {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}) {
    final solicitorManagements = SolicitorManagementStore.instance.getByDealId(deal.$uid!, modelFilter: modelFilter, includes: includes);
    deal.solicitorManagements = solicitorManagements;
    // setIncludedReferencesForList(solicitorManagements, includes: includes);
    return solicitorManagements;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Deal>> getAll$({bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: DealEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Deal?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDealId,
        value: id,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Deal?> getByLocationId$(
        String locationId,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDealLocationId,
        value: locationId,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getByLocationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Deal>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDealOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDealListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDealPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByClientId$(
        String clientId,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDealClientId,
        value: clientId,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByClientId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDealAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByDealStatus$(
        DealStatusUSA dealStatus,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<DealStatusUSA>(
        getPropVal: getDealDealStatus,
        value: dealStatus,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByDealStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByDealType$(
        String dealType,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDealDealType,
        value: dealType,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByDealType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByOfferPrice$(
        double offerPrice,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealOfferPrice,
        value: offerPrice,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByOfferPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByListPrice$(
        double listPrice,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealListPrice,
        value: listPrice,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByListPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getBySalePrice$(
        double salePrice,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealSalePrice,
        value: salePrice,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyBySalePrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByCommissionRate$(
        double commissionRate,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealCommissionRate,
        value: commissionRate,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByCommissionRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByCommissionAmount$(
        double commissionAmount,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealCommissionAmount,
        value: commissionAmount,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByCommissionAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByClosingDate$(
        DateTime closingDate,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDealClosingDate,
        value: closingDate,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByClosingDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByFinancingType$(
        String financingType,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDealFinancingType,
        value: financingType,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByFinancingType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByLoanAmount$(
        double loanAmount,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealLoanAmount,
        value: loanAmount,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByLoanAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByDownPayment$(
        double downPayment,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealDownPayment,
        value: downPayment,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByDownPayment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByEarnestMoney$(
        double earnestMoney,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealEarnestMoney,
        value: earnestMoney,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByEarnestMoney,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByEscrowAmount$(
        double escrowAmount,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealEscrowAmount,
        value: escrowAmount,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByEscrowAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByClosingCosts$(
        double closingCosts,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealClosingCosts,
        value: closingCosts,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByClosingCosts,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getBySellerConcessions$(
        double sellerConcessions,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealSellerConcessions,
        value: sellerConcessions,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyBySellerConcessions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByBuyerCredits$(
        double buyerCredits,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDealBuyerCredits,
        value: buyerCredits,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByBuyerCredits,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByInspectionPeriod$(
        int inspectionPeriod,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getDealInspectionPeriod,
        value: inspectionPeriod,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByInspectionPeriod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByFinancingContingency$(
        bool financingContingency,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDealFinancingContingency,
        value: financingContingency,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByFinancingContingency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByAppraisalContingency$(
        bool appraisalContingency,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDealAppraisalContingency,
        value: appraisalContingency,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByAppraisalContingency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByTitleContingency$(
        bool titleContingency,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDealTitleContingency,
        value: titleContingency,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByTitleContingency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByAttorneyReview$(
        bool attorneyReview,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDealAttorneyReview,
        value: attorneyReview,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByAttorneyReview,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByMultipleOffers$(
        bool multipleOffers,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDealMultipleOffers,
        value: multipleOffers,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByMultipleOffers,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDealCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDealCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDealUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Deal>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Deal>? modelFilter,
        List<DealInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDealDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: DealEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getAgent$(
    Deal deal, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (deal.agentId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            deal.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((agent) {
            deal.agent = agent;
        });
    }
}

	Stream<Contact?> getClient$(
    Deal deal, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (deal.clientId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            deal.clientId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((client) {
            deal.client = client;
        });
    }
}

	Stream<Listing?> getListing$(
    Deal deal, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (deal.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            deal.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            deal.listing = listing;
        });
    }
}

	Stream<Location?> getLocation$(
    Deal deal, {bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    if (deal.locationId == null) {
        return Stream.value(null);
    } else {
        return LocationStore.instance.getById$(
            deal.locationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((location) {
            deal.location = location;
        });
    }
}

	Stream<Organization?> getOrg$(
    Deal deal, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (deal.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            deal.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            deal.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Deal deal, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (deal.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            deal.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            deal.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<AttorneyManagement?> getAttorney$(
    Deal deal, {bool useCache = true, ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}) {
    return AttorneyManagementStore.instance.getByDealId$(
        deal.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attorney) {
        deal.attorney = attorney;
    });

}

	Stream<List<Document>> getDocuments$(
    Deal deal, {bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    return DocumentStore.instance.getByDealId$(
        deal.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((documents) {
        deal.documents = documents;
    });

}

	Stream<List<MortgagePreApproval>> getMortgagePreApprovals$(
    Deal deal, {bool useCache = true, ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}) {
    return MortgagePreApprovalStore.instance.getByDealId$(
        deal.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mortgagePreApprovals) {
        deal.mortgagePreApprovals = mortgagePreApprovals;
    });

}

	Stream<List<Payout>> getPayouts$(
    Deal deal, {bool useCache = true, ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    return PayoutStore.instance.getByDealId$(
        deal.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((payouts) {
        deal.payouts = payouts;
    });

}

	Stream<List<SolicitorManagement>> getSolicitorManagements$(
    Deal deal, {bool useCache = true, ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}) {
    return SolicitorManagementStore.instance.getByDealId$(
        deal.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((solicitorManagements) {
        deal.solicitorManagements = solicitorManagements;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Deal recursiveUpsert(Deal deal, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Deal'} 
        : const {};
    if (deal.attorney != null && (!preventCircularSerialization || !upsertedTypes.contains('AttorneyManagement'))) {
        deal.attorney = AttorneyManagementStore.instance.recursiveUpsert(deal.attorney!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.agent != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        deal.agent = ContactStore.instance.recursiveUpsert(deal.agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.client != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        deal.client = ContactStore.instance.recursiveUpsert(deal.client!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        deal.listing = ListingStore.instance.recursiveUpsert(deal.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.location != null && (!preventCircularSerialization || !upsertedTypes.contains('Location'))) {
        deal.location = LocationStore.instance.recursiveUpsert(deal.location!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        deal.org = OrganizationStore.instance.recursiveUpsert(deal.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        deal.property = PropertyStore.instance.recursiveUpsert(deal.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.documents != null && (!preventCircularSerialization || !upsertedTypes.contains('Document'))) {
        deal.documents = DocumentStore.instance.recursiveListUpsert(deal.documents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.mortgagePreApprovals != null && (!preventCircularSerialization || !upsertedTypes.contains('MortgagePreApproval'))) {
        deal.mortgagePreApprovals = MortgagePreApprovalStore.instance.recursiveListUpsert(deal.mortgagePreApprovals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.payouts != null && (!preventCircularSerialization || !upsertedTypes.contains('Payout'))) {
        deal.payouts = PayoutStore.instance.recursiveListUpsert(deal.payouts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (deal.solicitorManagements != null && (!preventCircularSerialization || !upsertedTypes.contains('SolicitorManagement'))) {
        deal.solicitorManagements = SolicitorManagementStore.instance.recursiveListUpsert(deal.solicitorManagements!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(deal);
}

  List<Deal> recursiveListUpsert(List<Deal> deals, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedDeals = <Deal>[];
    for (var deal in deals) {
        updatedDeals.add(recursiveUpsert(deal, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedDeals;
}

//   @override
//   Deal upsert(Deal item) {
//     return recursiveUpsert(item);
//   }

}


class DealInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      DealInclude.attorney({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AttorneyManagement>? modelFilter,
    List<AttorneyManagementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getAttorney$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getAttorney(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getAgent$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getAgent(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.client({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getClient$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getClient(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getListing$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getListing(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.location({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Location>? modelFilter,
    List<LocationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getLocation$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getLocation(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getOrg$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getOrg(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getProperty$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getProperty(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.documents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Document>? modelFilter,
    List<DocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getDocuments$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getDocuments(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.mortgagePreApprovals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MortgagePreApproval>? modelFilter,
    List<MortgagePreApprovalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getMortgagePreApprovals$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getMortgagePreApprovals(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.payouts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payout>? modelFilter,
    List<PayoutInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getPayouts$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getPayouts(deal, modelFilter: modelFilter, includes: includes);
      }
}

	DealInclude.solicitorManagements({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SolicitorManagement>? modelFilter,
    List<SolicitorManagementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (deal) => DealStore.instance
            .getSolicitorManagements$(deal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (deal) => DealStore.instance
            .getSolicitorManagements(deal, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum DealEndpoints implements Endpoint {

    getAll('/deal', HttpMethod.post, List<Deal>),
	getById('/deal/byId/:id', HttpMethod.post, Deal),
	getManyByOrgId('/deal/byOrgId/:orgId', HttpMethod.post, List<Deal>),
	getManyByListingId('/deal/byListingId/:listingId', HttpMethod.post, List<Deal>),
	getManyByPropertyId('/deal/byPropertyId/:propertyId', HttpMethod.post, List<Deal>),
	getManyByClientId('/deal/byClientId/:clientId', HttpMethod.post, List<Deal>),
	getManyByAgentId('/deal/byAgentId/:agentId', HttpMethod.post, List<Deal>),
	getByLocationId('/deal/byLocationId/:locationId', HttpMethod.post, Deal),
	getManyByDealStatus('/deal/byDealStatus/:dealStatus', HttpMethod.post, List<Deal>),
	getManyByDealType('/deal/byDealType/:dealType', HttpMethod.post, List<Deal>),
	getManyByOfferPrice('/deal/byOfferPrice/:offerPrice', HttpMethod.post, List<Deal>),
	getManyByListPrice('/deal/byListPrice/:listPrice', HttpMethod.post, List<Deal>),
	getManyBySalePrice('/deal/bySalePrice/:salePrice', HttpMethod.post, List<Deal>),
	getManyByCommissionRate('/deal/byCommissionRate/:commissionRate', HttpMethod.post, List<Deal>),
	getManyByCommissionAmount('/deal/byCommissionAmount/:commissionAmount', HttpMethod.post, List<Deal>),
	getManyByClosingDate('/deal/byClosingDate/:closingDate', HttpMethod.post, List<Deal>),
	getManyByFinancingType('/deal/byFinancingType/:financingType', HttpMethod.post, List<Deal>),
	getManyByLoanAmount('/deal/byLoanAmount/:loanAmount', HttpMethod.post, List<Deal>),
	getManyByDownPayment('/deal/byDownPayment/:downPayment', HttpMethod.post, List<Deal>),
	getManyByEarnestMoney('/deal/byEarnestMoney/:earnestMoney', HttpMethod.post, List<Deal>),
	getManyByEscrowAmount('/deal/byEscrowAmount/:escrowAmount', HttpMethod.post, List<Deal>),
	getManyByClosingCosts('/deal/byClosingCosts/:closingCosts', HttpMethod.post, List<Deal>),
	getManyBySellerConcessions('/deal/bySellerConcessions/:sellerConcessions', HttpMethod.post, List<Deal>),
	getManyByBuyerCredits('/deal/byBuyerCredits/:buyerCredits', HttpMethod.post, List<Deal>),
	getManyByInspectionPeriod('/deal/byInspectionPeriod/:inspectionPeriod', HttpMethod.post, List<Deal>),
	getManyByFinancingContingency('/deal/byFinancingContingency/:financingContingency', HttpMethod.post, List<Deal>),
	getManyByAppraisalContingency('/deal/byAppraisalContingency/:appraisalContingency', HttpMethod.post, List<Deal>),
	getManyByTitleContingency('/deal/byTitleContingency/:titleContingency', HttpMethod.post, List<Deal>),
	getManyByAttorneyReview('/deal/byAttorneyReview/:attorneyReview', HttpMethod.post, List<Deal>),
	getManyByMultipleOffers('/deal/byMultipleOffers/:multipleOffers', HttpMethod.post, List<Deal>),
	getManyByCreatedBy('/deal/byCreatedBy/:createdBy', HttpMethod.post, List<Deal>),
	getManyByCreatedAt('/deal/byCreatedAt/:createdAt', HttpMethod.post, List<Deal>),
	getManyByUpdatedAt('/deal/byUpdatedAt/:updatedAt', HttpMethod.post, List<Deal>),
	getManyByDeletedAt('/deal/byDeletedAt/:deletedAt', HttpMethod.post, List<Deal>);

    const DealEndpoints(this.path, this.method, this.responseType);

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
