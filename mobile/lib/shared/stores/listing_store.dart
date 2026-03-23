
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ListingStore extends ModelStreamStore<String, Listing> {

  static ListingStore? _instance;

  static ListingStore get instance {
    _instance ??= ListingStore();
    return _instance!;
  }

  ListingStore() : super(Listing.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ListingStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ListingStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ListingStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getListingId(Listing listing) => listing.id;

	String? getListingOrgId(Listing listing) => listing.orgId;

	String? getListingPropertyId(Listing listing) => listing.propertyId;

	ListingType? getListingType(Listing listing) => listing.type;

	ListingStatus? getListingStatus(Listing listing) => listing.status;

	DateTime? getListingWillBeAvailableAt(Listing listing) => listing.willBeAvailableAt;

	EarningStrategy? getListingStrategy(Listing listing) => listing.strategy;

	String? getListingTitle(Listing listing) => listing.title;

	String? getListingDescription(Listing listing) => listing.description;

	double? getListingPrice(Listing listing) => listing.price;

	String? getListingPriceCurrency(Listing listing) => listing.priceCurrency;

	String? getListingCreatedBy(Listing listing) => listing.createdBy;

	DateTime? getListingCreatedAt(Listing listing) => listing.createdAt;

	DateTime? getListingUpdatedAt(Listing listing) => listing.updatedAt;

	DateTime? getListingDeletedAt(Listing listing) => listing.deletedAt;

	String? getListingLocationId(Listing listing) => listing.locationId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Listing? getByLocationId(
    String locationId,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getIncluding(getListingLocationId, locationId, modelFilter: modelFilter, includes: includes);

  
List<Listing> getByOrgId(
    String orgId,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByPropertyId(
    String propertyId,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByType(
    ListingType type,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingType, type, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByStatus(
    ListingStatus status,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByWillBeAvailableAt(
    DateTime willBeAvailableAt,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingWillBeAvailableAt, willBeAvailableAt, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByStrategy(
    EarningStrategy strategy,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingStrategy, strategy, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByTitle(
    String title,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByDescription(
    String description,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByPrice(
    double price,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingPrice, price, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByPriceCurrency(
    String priceCurrency,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingPriceCurrency, priceCurrency, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByCreatedBy(
    String createdBy,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Listing> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}
    ) =>
    getManyIncluding(getListingDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Location? getLocation(
    Listing listing, {ModelFilter? modelFilter, List<LocationInclude>? includes}) {
    if (listing.locationId == null) {
        return null;
    } else {
        final location = LocationStore.instance.getById(listing.locationId!, includes: includes);
        listing.location = location;
        // setIncludedReferences(location, includes: includes);
        return location;
    }
}

	Organization? getOrg(
    Listing listing, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (listing.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(listing.orgId!, includes: includes);
        listing.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Listing listing, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (listing.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(listing.propertyId!, includes: includes);
        listing.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<AIPriceOptimization> getAiPriceOptimizations(
    Listing listing, {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}) {
    final aiPriceOptimizations = AIPriceOptimizationStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.aiPriceOptimizations = aiPriceOptimizations;
    // setIncludedReferencesForList(aiPriceOptimizations, includes: includes);
    return aiPriceOptimizations;
}

	List<AgentAssignment> getAgentAssignments(
    Listing listing, {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}) {
    final agentAssignments = AgentAssignmentStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.agentAssignments = agentAssignments;
    // setIncludedReferencesForList(agentAssignments, includes: includes);
    return agentAssignments;
}

	List<Appointment> getAppointments(
    Listing listing, {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    final appointments = AppointmentStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.appointments = appointments;
    // setIncludedReferencesForList(appointments, includes: includes);
    return appointments;
}

	List<Booking> getBookings(
    Listing listing, {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    final bookings = BookingStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.bookings = bookings;
    // setIncludedReferencesForList(bookings, includes: includes);
    return bookings;
}

	List<Contract> getContracts(
    Listing listing, {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    final contracts = ContractStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.contracts = contracts;
    // setIncludedReferencesForList(contracts, includes: includes);
    return contracts;
}

	List<Deal> getDeals(
    Listing listing, {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    final deals = DealStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.deals = deals;
    // setIncludedReferencesForList(deals, includes: includes);
    return deals;
}

	List<Document> getDocuments(
    Listing listing, {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    final documents = DocumentStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.documents = documents;
    // setIncludedReferencesForList(documents, includes: includes);
    return documents;
}

	List<FinancialRecord> getFinancialRecords(
    Listing listing, {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    final financialRecords = FinancialRecordStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.financialRecords = financialRecords;
    // setIncludedReferencesForList(financialRecords, includes: includes);
    return financialRecords;
}

	List<Lead> getLeads(
    Listing listing, {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final leads = LeadStore.instance.getByInterestedListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.leads = leads;
    // setIncludedReferencesForList(leads, includes: includes);
    return leads;
}

	List<Lease> getLeases(
    Listing listing, {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    final leases = LeaseStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.leases = leases;
    // setIncludedReferencesForList(leases, includes: includes);
    return leases;
}

	List<LeaseRenewal> getLeaseRenewals(
    Listing listing, {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}) {
    final leaseRenewals = LeaseRenewalStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.leaseRenewals = leaseRenewals;
    // setIncludedReferencesForList(leaseRenewals, includes: includes);
    return leaseRenewals;
}

	List<ListingChannel> getChannels(
    Listing listing, {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}) {
    final channels = ListingChannelStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.channels = channels;
    // setIncludedReferencesForList(channels, includes: includes);
    return channels;
}

	List<ListingStatusHistory> getStatusHistory(
    Listing listing, {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}) {
    final statusHistory = ListingStatusHistoryStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.statusHistory = statusHistory;
    // setIncludedReferencesForList(statusHistory, includes: includes);
    return statusHistory;
}

	List<ListingTag> getTags(
    Listing listing, {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}) {
    final tags = ListingTagStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.tags = tags;
    // setIncludedReferencesForList(tags, includes: includes);
    return tags;
}

	List<MaintenanceBlock> getMaintenanceBlocks(
    Listing listing, {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}) {
    final maintenanceBlocks = MaintenanceBlockStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.maintenanceBlocks = maintenanceBlocks;
    // setIncludedReferencesForList(maintenanceBlocks, includes: includes);
    return maintenanceBlocks;
}

	MlsListingEnhancement? getMlsListingEnhancement(
    Listing listing, {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}) {
    final mlsListingEnhancement = MlsListingEnhancementStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.mlsListingEnhancement = mlsListingEnhancement;
    // setIncludedReferences(mlsListingEnhancement, includes: includes);
    return mlsListingEnhancement;
}

	List<PropertyOffer> getPropertyOffers(
    Listing listing, {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    final propertyOffers = PropertyOfferStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.propertyOffers = propertyOffers;
    // setIncludedReferencesForList(propertyOffers, includes: includes);
    return propertyOffers;
}

	List<PropertyViewing> getViewings(
    Listing listing, {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    final viewings = PropertyViewingStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.viewings = viewings;
    // setIncludedReferencesForList(viewings, includes: includes);
    return viewings;
}

	List<Quote> getQuotes(
    Listing listing, {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    final quotes = QuoteStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.quotes = quotes;
    // setIncludedReferencesForList(quotes, includes: includes);
    return quotes;
}

	List<Reservation> getReservations(
    Listing listing, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final reservations = ReservationStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.reservations = reservations;
    // setIncludedReferencesForList(reservations, includes: includes);
    return reservations;
}

	List<Task> getTasks(
    Listing listing, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<TenantApplication> getTenantApplications(
    Listing listing, {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    final tenantApplications = TenantApplicationStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.tenantApplications = tenantApplications;
    // setIncludedReferencesForList(tenantApplications, includes: includes);
    return tenantApplications;
}

	VacationRental? getVacationRental(
    Listing listing, {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}) {
    final vacationRental = VacationRentalStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.vacationRental = vacationRental;
    // setIncludedReferences(vacationRental, includes: includes);
    return vacationRental;
}

	List<VideoContent> getVideoContents(
    Listing listing, {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    final videoContents = VideoContentStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.videoContents = videoContents;
    // setIncludedReferencesForList(videoContents, includes: includes);
    return videoContents;
}

	List<PricingRule> getPricingRule(
    Listing listing, {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    final PricingRule = PricingRuleStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.PricingRule = PricingRule;
    // setIncludedReferencesForList(PricingRule, includes: includes);
    return PricingRule;
}

	List<AIChatMessage> getAiChatMessages(
    Listing listing, {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    final aiChatMessages = AIChatMessageStore.instance.getByListingId(listing.$uid!, modelFilter: modelFilter, includes: includes);
    listing.aiChatMessages = aiChatMessages;
    // setIncludedReferencesForList(aiChatMessages, includes: includes);
    return aiChatMessages;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Listing>> getAll$({bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ListingEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Listing?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getListingId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Listing?> getByLocationId$(
        String locationId,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getListingLocationId,
        value: locationId,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getByLocationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Listing>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByType$(
        ListingType type,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<ListingType>(
        getPropVal: getListingType,
        value: type,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByStatus$(
        ListingStatus status,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<ListingStatus>(
        getPropVal: getListingStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByWillBeAvailableAt$(
        DateTime willBeAvailableAt,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingWillBeAvailableAt,
        value: willBeAvailableAt,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByWillBeAvailableAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByStrategy$(
        EarningStrategy strategy,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<EarningStrategy>(
        getPropVal: getListingStrategy,
        value: strategy,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByStrategy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByPrice$(
        double price,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getListingPrice,
        value: price,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByPriceCurrency$(
        String priceCurrency,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingPriceCurrency,
        value: priceCurrency,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByPriceCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Listing>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Listing>? modelFilter,
        List<ListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ListingEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Location?> getLocation$(
    Listing listing, {bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    if (listing.locationId == null) {
        return Stream.value(null);
    } else {
        return LocationStore.instance.getById$(
            listing.locationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((location) {
            listing.location = location;
        });
    }
}

	Stream<Organization?> getOrg$(
    Listing listing, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (listing.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            listing.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            listing.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Listing listing, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (listing.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            listing.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            listing.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AIPriceOptimization>> getAiPriceOptimizations$(
    Listing listing, {bool useCache = true, ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}) {
    return AIPriceOptimizationStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiPriceOptimizations) {
        listing.aiPriceOptimizations = aiPriceOptimizations;
    });

}

	Stream<List<AgentAssignment>> getAgentAssignments$(
    Listing listing, {bool useCache = true, ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}) {
    return AgentAssignmentStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agentAssignments) {
        listing.agentAssignments = agentAssignments;
    });

}

	Stream<List<Appointment>> getAppointments$(
    Listing listing, {bool useCache = true, ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    return AppointmentStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((appointments) {
        listing.appointments = appointments;
    });

}

	Stream<List<Booking>> getBookings$(
    Listing listing, {bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    return BookingStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((bookings) {
        listing.bookings = bookings;
    });

}

	Stream<List<Contract>> getContracts$(
    Listing listing, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    return ContractStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((contracts) {
        listing.contracts = contracts;
    });

}

	Stream<List<Deal>> getDeals$(
    Listing listing, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    return DealStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((deals) {
        listing.deals = deals;
    });

}

	Stream<List<Document>> getDocuments$(
    Listing listing, {bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    return DocumentStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((documents) {
        listing.documents = documents;
    });

}

	Stream<List<FinancialRecord>> getFinancialRecords$(
    Listing listing, {bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    return FinancialRecordStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((financialRecords) {
        listing.financialRecords = financialRecords;
    });

}

	Stream<List<Lead>> getLeads$(
    Listing listing, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    return LeadStore.instance.getByInterestedListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leads) {
        listing.leads = leads;
    });

}

	Stream<List<Lease>> getLeases$(
    Listing listing, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    return LeaseStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leases) {
        listing.leases = leases;
    });

}

	Stream<List<LeaseRenewal>> getLeaseRenewals$(
    Listing listing, {bool useCache = true, ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}) {
    return LeaseRenewalStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leaseRenewals) {
        listing.leaseRenewals = leaseRenewals;
    });

}

	Stream<List<ListingChannel>> getChannels$(
    Listing listing, {bool useCache = true, ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}) {
    return ListingChannelStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((channels) {
        listing.channels = channels;
    });

}

	Stream<List<ListingStatusHistory>> getStatusHistory$(
    Listing listing, {bool useCache = true, ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}) {
    return ListingStatusHistoryStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((statusHistory) {
        listing.statusHistory = statusHistory;
    });

}

	Stream<List<ListingTag>> getTags$(
    Listing listing, {bool useCache = true, ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}) {
    return ListingTagStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tags) {
        listing.tags = tags;
    });

}

	Stream<List<MaintenanceBlock>> getMaintenanceBlocks$(
    Listing listing, {bool useCache = true, ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}) {
    return MaintenanceBlockStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((maintenanceBlocks) {
        listing.maintenanceBlocks = maintenanceBlocks;
    });

}

	Stream<MlsListingEnhancement?> getMlsListingEnhancement$(
    Listing listing, {bool useCache = true, ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}) {
    return MlsListingEnhancementStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mlsListingEnhancement) {
        listing.mlsListingEnhancement = mlsListingEnhancement;
    });

}

	Stream<List<PropertyOffer>> getPropertyOffers$(
    Listing listing, {bool useCache = true, ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    return PropertyOfferStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyOffers) {
        listing.propertyOffers = propertyOffers;
    });

}

	Stream<List<PropertyViewing>> getViewings$(
    Listing listing, {bool useCache = true, ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    return PropertyViewingStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((viewings) {
        listing.viewings = viewings;
    });

}

	Stream<List<Quote>> getQuotes$(
    Listing listing, {bool useCache = true, ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    return QuoteStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((quotes) {
        listing.quotes = quotes;
    });

}

	Stream<List<Reservation>> getReservations$(
    Listing listing, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reservations) {
        listing.reservations = reservations;
    });

}

	Stream<List<Task>> getTasks$(
    Listing listing, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        listing.tasks = tasks;
    });

}

	Stream<List<TenantApplication>> getTenantApplications$(
    Listing listing, {bool useCache = true, ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    return TenantApplicationStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenantApplications) {
        listing.tenantApplications = tenantApplications;
    });

}

	Stream<VacationRental?> getVacationRental$(
    Listing listing, {bool useCache = true, ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}) {
    return VacationRentalStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((vacationRental) {
        listing.vacationRental = vacationRental;
    });

}

	Stream<List<VideoContent>> getVideoContents$(
    Listing listing, {bool useCache = true, ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    return VideoContentStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((videoContents) {
        listing.videoContents = videoContents;
    });

}

	Stream<List<PricingRule>> getPricingRule$(
    Listing listing, {bool useCache = true, ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    return PricingRuleStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((PricingRule) {
        listing.PricingRule = PricingRule;
    });

}

	Stream<List<AIChatMessage>> getAiChatMessages$(
    Listing listing, {bool useCache = true, ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    return AIChatMessageStore.instance.getByListingId$(
        listing.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiChatMessages) {
        listing.aiChatMessages = aiChatMessages;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Listing recursiveUpsert(Listing listing, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Listing'} 
        : const {};
    if (listing.aiPriceOptimizations != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPriceOptimization'))) {
        listing.aiPriceOptimizations = AIPriceOptimizationStore.instance.recursiveListUpsert(listing.aiPriceOptimizations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.agentAssignments != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentAssignment'))) {
        listing.agentAssignments = AgentAssignmentStore.instance.recursiveListUpsert(listing.agentAssignments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.appointments != null && (!preventCircularSerialization || !upsertedTypes.contains('Appointment'))) {
        listing.appointments = AppointmentStore.instance.recursiveListUpsert(listing.appointments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.bookings != null && (!preventCircularSerialization || !upsertedTypes.contains('Booking'))) {
        listing.bookings = BookingStore.instance.recursiveListUpsert(listing.bookings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.contracts != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        listing.contracts = ContractStore.instance.recursiveListUpsert(listing.contracts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.deals != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        listing.deals = DealStore.instance.recursiveListUpsert(listing.deals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.documents != null && (!preventCircularSerialization || !upsertedTypes.contains('Document'))) {
        listing.documents = DocumentStore.instance.recursiveListUpsert(listing.documents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.financialRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('FinancialRecord'))) {
        listing.financialRecords = FinancialRecordStore.instance.recursiveListUpsert(listing.financialRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.leads != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        listing.leads = LeadStore.instance.recursiveListUpsert(listing.leads!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.leases != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        listing.leases = LeaseStore.instance.recursiveListUpsert(listing.leases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.leaseRenewals != null && (!preventCircularSerialization || !upsertedTypes.contains('LeaseRenewal'))) {
        listing.leaseRenewals = LeaseRenewalStore.instance.recursiveListUpsert(listing.leaseRenewals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.location != null && (!preventCircularSerialization || !upsertedTypes.contains('Location'))) {
        listing.location = LocationStore.instance.recursiveUpsert(listing.location!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        listing.org = OrganizationStore.instance.recursiveUpsert(listing.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        listing.property = PropertyStore.instance.recursiveUpsert(listing.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.channels != null && (!preventCircularSerialization || !upsertedTypes.contains('ListingChannel'))) {
        listing.channels = ListingChannelStore.instance.recursiveListUpsert(listing.channels!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.statusHistory != null && (!preventCircularSerialization || !upsertedTypes.contains('ListingStatusHistory'))) {
        listing.statusHistory = ListingStatusHistoryStore.instance.recursiveListUpsert(listing.statusHistory!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.tags != null && (!preventCircularSerialization || !upsertedTypes.contains('ListingTag'))) {
        listing.tags = ListingTagStore.instance.recursiveListUpsert(listing.tags!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.maintenanceBlocks != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceBlock'))) {
        listing.maintenanceBlocks = MaintenanceBlockStore.instance.recursiveListUpsert(listing.maintenanceBlocks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.mlsListingEnhancement != null && (!preventCircularSerialization || !upsertedTypes.contains('MlsListingEnhancement'))) {
        listing.mlsListingEnhancement = MlsListingEnhancementStore.instance.recursiveUpsert(listing.mlsListingEnhancement!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.propertyOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyOffer'))) {
        listing.propertyOffers = PropertyOfferStore.instance.recursiveListUpsert(listing.propertyOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.viewings != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyViewing'))) {
        listing.viewings = PropertyViewingStore.instance.recursiveListUpsert(listing.viewings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.quotes != null && (!preventCircularSerialization || !upsertedTypes.contains('Quote'))) {
        listing.quotes = QuoteStore.instance.recursiveListUpsert(listing.quotes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.reservations != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        listing.reservations = ReservationStore.instance.recursiveListUpsert(listing.reservations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        listing.tasks = TaskStore.instance.recursiveListUpsert(listing.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.tenantApplications != null && (!preventCircularSerialization || !upsertedTypes.contains('TenantApplication'))) {
        listing.tenantApplications = TenantApplicationStore.instance.recursiveListUpsert(listing.tenantApplications!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.vacationRental != null && (!preventCircularSerialization || !upsertedTypes.contains('VacationRental'))) {
        listing.vacationRental = VacationRentalStore.instance.recursiveUpsert(listing.vacationRental!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.videoContents != null && (!preventCircularSerialization || !upsertedTypes.contains('VideoContent'))) {
        listing.videoContents = VideoContentStore.instance.recursiveListUpsert(listing.videoContents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.PricingRule != null && (!preventCircularSerialization || !upsertedTypes.contains('PricingRule'))) {
        listing.PricingRule = PricingRuleStore.instance.recursiveListUpsert(listing.PricingRule!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listing.aiChatMessages != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatMessage'))) {
        listing.aiChatMessages = AIChatMessageStore.instance.recursiveListUpsert(listing.aiChatMessages!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(listing);
}

  List<Listing> recursiveListUpsert(List<Listing> listings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedListings = <Listing>[];
    for (var listing in listings) {
        updatedListings.add(recursiveUpsert(listing, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedListings;
}

//   @override
//   Listing upsert(Listing item) {
//     return recursiveUpsert(item);
//   }

}


class ListingInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ListingInclude.aiPriceOptimizations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPriceOptimization>? modelFilter,
    List<AIPriceOptimizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getAiPriceOptimizations$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getAiPriceOptimizations(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.agentAssignments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentAssignment>? modelFilter,
    List<AgentAssignmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getAgentAssignments$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getAgentAssignments(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.appointments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Appointment>? modelFilter,
    List<AppointmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getAppointments$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getAppointments(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.bookings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Booking>? modelFilter,
    List<BookingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getBookings$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getBookings(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.contracts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getContracts$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getContracts(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.deals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getDeals$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getDeals(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.documents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Document>? modelFilter,
    List<DocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getDocuments$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getDocuments(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.financialRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FinancialRecord>? modelFilter,
    List<FinancialRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getFinancialRecords$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getFinancialRecords(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.leads({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getLeads$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getLeads(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.leases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getLeases$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getLeases(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.leaseRenewals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LeaseRenewal>? modelFilter,
    List<LeaseRenewalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getLeaseRenewals$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getLeaseRenewals(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.location({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Location>? modelFilter,
    List<LocationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getLocation$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getLocation(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getOrg$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getOrg(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getProperty$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getProperty(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.channels({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ListingChannel>? modelFilter,
    List<ListingChannelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getChannels$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getChannels(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.statusHistory({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ListingStatusHistory>? modelFilter,
    List<ListingStatusHistoryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getStatusHistory$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getStatusHistory(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.tags({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ListingTag>? modelFilter,
    List<ListingTagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getTags$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getTags(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.maintenanceBlocks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceBlock>? modelFilter,
    List<MaintenanceBlockInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getMaintenanceBlocks$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getMaintenanceBlocks(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.mlsListingEnhancement({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MlsListingEnhancement>? modelFilter,
    List<MlsListingEnhancementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getMlsListingEnhancement$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getMlsListingEnhancement(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.propertyOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyOffer>? modelFilter,
    List<PropertyOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getPropertyOffers$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getPropertyOffers(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.viewings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyViewing>? modelFilter,
    List<PropertyViewingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getViewings$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getViewings(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.quotes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Quote>? modelFilter,
    List<QuoteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getQuotes$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getQuotes(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.reservations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getReservations$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getReservations(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getTasks$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getTasks(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.tenantApplications({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TenantApplication>? modelFilter,
    List<TenantApplicationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getTenantApplications$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getTenantApplications(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.vacationRental({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VacationRental>? modelFilter,
    List<VacationRentalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getVacationRental$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getVacationRental(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.videoContents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VideoContent>? modelFilter,
    List<VideoContentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getVideoContents$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getVideoContents(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.PricingRule({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PricingRule>? modelFilter,
    List<PricingRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getPricingRule$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getPricingRule(listing, modelFilter: modelFilter, includes: includes);
      }
}

	ListingInclude.aiChatMessages({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatMessage>? modelFilter,
    List<AIChatMessageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listing) => ListingStore.instance
            .getAiChatMessages$(listing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listing) => ListingStore.instance
            .getAiChatMessages(listing, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ListingEndpoints implements Endpoint {

    getAll('/listing', HttpMethod.post, List<Listing>),
	getById('/listing/byId/:id', HttpMethod.post, Listing),
	getManyByOrgId('/listing/byOrgId/:orgId', HttpMethod.post, List<Listing>),
	getManyByPropertyId('/listing/byPropertyId/:propertyId', HttpMethod.post, List<Listing>),
	getManyByType('/listing/byType/:type', HttpMethod.post, List<Listing>),
	getManyByStatus('/listing/byStatus/:status', HttpMethod.post, List<Listing>),
	getManyByWillBeAvailableAt('/listing/byWillBeAvailableAt/:willBeAvailableAt', HttpMethod.post, List<Listing>),
	getManyByStrategy('/listing/byStrategy/:strategy', HttpMethod.post, List<Listing>),
	getManyByTitle('/listing/byTitle/:title', HttpMethod.post, List<Listing>),
	getManyByDescription('/listing/byDescription/:description', HttpMethod.post, List<Listing>),
	getManyByPrice('/listing/byPrice/:price', HttpMethod.post, List<Listing>),
	getManyByPriceCurrency('/listing/byPriceCurrency/:priceCurrency', HttpMethod.post, List<Listing>),
	getManyByCreatedBy('/listing/byCreatedBy/:createdBy', HttpMethod.post, List<Listing>),
	getManyByCreatedAt('/listing/byCreatedAt/:createdAt', HttpMethod.post, List<Listing>),
	getManyByUpdatedAt('/listing/byUpdatedAt/:updatedAt', HttpMethod.post, List<Listing>),
	getManyByDeletedAt('/listing/byDeletedAt/:deletedAt', HttpMethod.post, List<Listing>),
	getByLocationId('/listing/byLocationId/:locationId', HttpMethod.post, Listing);

    const ListingEndpoints(this.path, this.method, this.responseType);

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
