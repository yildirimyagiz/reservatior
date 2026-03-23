
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ReservationStore extends ModelStreamStore<String, Reservation> {

  static ReservationStore? _instance;

  static ReservationStore get instance {
    _instance ??= ReservationStore();
    return _instance!;
  }

  ReservationStore() : super(Reservation.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ReservationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ReservationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ReservationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getReservationId(Reservation reservation) => reservation.id;

	String? getReservationOrgId(Reservation reservation) => reservation.orgId;

	String? getReservationListingId(Reservation reservation) => reservation.listingId;

	String? getReservationContactId(Reservation reservation) => reservation.contactId;

	DateTime? getReservationCheckInDate(Reservation reservation) => reservation.checkInDate;

	DateTime? getReservationCheckOutDate(Reservation reservation) => reservation.checkOutDate;

	int? getReservationGuestCount(Reservation reservation) => reservation.guestCount;

	String? getReservationSpecialRequests(Reservation reservation) => reservation.specialRequests;

	double? getReservationNightlyRate(Reservation reservation) => reservation.nightlyRate;

	double? getReservationCleaningFee(Reservation reservation) => reservation.cleaningFee;

	double? getReservationTotalAmount(Reservation reservation) => reservation.totalAmount;

	String? getReservationCurrency(Reservation reservation) => reservation.currency;

	String? getReservationStatus(Reservation reservation) => reservation.status;

	PaymentStatus? getReservationPaymentStatus(Reservation reservation) => reservation.paymentStatus;

	DateTime? getReservationValidUntil(Reservation reservation) => reservation.validUntil;

	DateTime? getReservationCreatedAt(Reservation reservation) => reservation.createdAt;

	DateTime? getReservationUpdatedAt(Reservation reservation) => reservation.updatedAt;

	DateTime? getReservationDeletedAt(Reservation reservation) => reservation.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Reservation> getByOrgId(
    String orgId,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByListingId(
    String listingId,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByContactId(
    String contactId,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByCheckInDate(
    DateTime checkInDate,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationCheckInDate, checkInDate, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByCheckOutDate(
    DateTime checkOutDate,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationCheckOutDate, checkOutDate, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByGuestCount(
    int guestCount,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationGuestCount, guestCount, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getBySpecialRequests(
    String specialRequests,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationSpecialRequests, specialRequests, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByNightlyRate(
    double nightlyRate,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationNightlyRate, nightlyRate, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByCleaningFee(
    double cleaningFee,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationCleaningFee, cleaningFee, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByTotalAmount(
    double totalAmount,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationTotalAmount, totalAmount, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByCurrency(
    String currency,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByStatus(
    String status,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByPaymentStatus(
    PaymentStatus paymentStatus,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationPaymentStatus, paymentStatus, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByValidUntil(
    DateTime validUntil,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationValidUntil, validUntil, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Reservation> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}
    ) =>
    getManyIncluding(getReservationDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    Reservation reservation, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (reservation.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(reservation.contactId!, includes: includes);
        reservation.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Listing? getListing(
    Reservation reservation, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (reservation.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(reservation.listingId!, includes: includes);
        reservation.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    Reservation reservation, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (reservation.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(reservation.orgId!, includes: includes);
        reservation.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<Booking> getBookings(
    Reservation reservation, {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    final bookings = BookingStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.bookings = bookings;
    // setIncludedReferencesForList(bookings, includes: includes);
    return bookings;
}

	List<FinancialRecord> getFinancialRecords(
    Reservation reservation, {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    final financialRecords = FinancialRecordStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.financialRecords = financialRecords;
    // setIncludedReferencesForList(financialRecords, includes: includes);
    return financialRecords;
}

	List<Task> getTasks(
    Reservation reservation, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	EscrowAccount? getEscrowAccount(
    Reservation reservation, {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}) {
    final escrowAccount = EscrowAccountStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.escrowAccount = escrowAccount;
    // setIncludedReferences(escrowAccount, includes: includes);
    return escrowAccount;
}

	PaymentNegotiation? getPaymentNegotiation(
    Reservation reservation, {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    final paymentNegotiation = PaymentNegotiationStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.paymentNegotiation = paymentNegotiation;
    // setIncludedReferences(paymentNegotiation, includes: includes);
    return paymentNegotiation;
}

	List<AIChatMessage> getAiChatMessages(
    Reservation reservation, {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    final aiChatMessages = AIChatMessageStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.aiChatMessages = aiChatMessages;
    // setIncludedReferencesForList(aiChatMessages, includes: includes);
    return aiChatMessages;
}

	List<PricingRule> getPricingRules(
    Reservation reservation, {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    final pricingRules = PricingRuleStore.instance.getBy(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.pricingRules = pricingRules;
    // setIncludedReferencesForList(pricingRules, includes: includes);
    return pricingRules;
}

	List<Agent> getAgents(
    Reservation reservation, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agents = AgentStore.instance.getBy(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.agents = agents;
    // setIncludedReferencesForList(agents, includes: includes);
    return agents;
}

	List<Currency> getCurrencies(
    Reservation reservation, {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    final currencies = CurrencyStore.instance.getBy(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.currencies = currencies;
    // setIncludedReferencesForList(currencies, includes: includes);
    return currencies;
}

	List<Guest> getGuests(
    Reservation reservation, {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}) {
    final guests = GuestStore.instance.getBy(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.guests = guests;
    // setIncludedReferencesForList(guests, includes: includes);
    return guests;
}

	List<Agency> getAgencies(
    Reservation reservation, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<ReferenceSource> getReferenceSources(
    Reservation reservation, {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}) {
    final referenceSources = ReferenceSourceStore.instance.getBy(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.referenceSources = referenceSources;
    // setIncludedReferencesForList(referenceSources, includes: includes);
    return referenceSources;
}

	List<Discount> getDiscounts(
    Reservation reservation, {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}) {
    final discounts = DiscountStore.instance.getBy(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.discounts = discounts;
    // setIncludedReferencesForList(discounts, includes: includes);
    return discounts;
}

	List<Analytics> getAnalytics(
    Reservation reservation, {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    final analytics = AnalyticsStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.analytics = analytics;
    // setIncludedReferencesForList(analytics, includes: includes);
    return analytics;
}

	List<Availability> getAvailabilities(
    Reservation reservation, {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}) {
    final availabilities = AvailabilityStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.availabilities = availabilities;
    // setIncludedReferencesForList(availabilities, includes: includes);
    return availabilities;
}

	List<ComplianceRecord> getComplianceRecords(
    Reservation reservation, {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    final complianceRecords = ComplianceRecordStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.complianceRecords = complianceRecords;
    // setIncludedReferencesForList(complianceRecords, includes: includes);
    return complianceRecords;
}

	Offer? getOffer(
    Reservation reservation, {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    final offer = OfferStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.offer = offer;
    // setIncludedReferences(offer, includes: includes);
    return offer;
}

	List<Payment> getPayments(
    Reservation reservation, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final payments = PaymentStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.payments = payments;
    // setIncludedReferencesForList(payments, includes: includes);
    return payments;
}

	List<ExtraCharge> getExtraCharges(
    Reservation reservation, {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    final ExtraCharges = ExtraChargeStore.instance.getByReservationId(reservation.$uid!, modelFilter: modelFilter, includes: includes);
    reservation.ExtraCharges = ExtraCharges;
    // setIncludedReferencesForList(ExtraCharges, includes: includes);
    return ExtraCharges;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Reservation>> getAll$({bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ReservationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Reservation?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getReservationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Reservation>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReservationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReservationListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReservationContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByCheckInDate$(
        DateTime checkInDate,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReservationCheckInDate,
        value: checkInDate,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByCheckInDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByCheckOutDate$(
        DateTime checkOutDate,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReservationCheckOutDate,
        value: checkOutDate,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByCheckOutDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByGuestCount$(
        int guestCount,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getReservationGuestCount,
        value: guestCount,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByGuestCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getBySpecialRequests$(
        String specialRequests,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReservationSpecialRequests,
        value: specialRequests,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyBySpecialRequests,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByNightlyRate$(
        double nightlyRate,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getReservationNightlyRate,
        value: nightlyRate,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByNightlyRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByCleaningFee$(
        double cleaningFee,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getReservationCleaningFee,
        value: cleaningFee,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByCleaningFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByTotalAmount$(
        double totalAmount,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getReservationTotalAmount,
        value: totalAmount,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByTotalAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReservationCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReservationStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByPaymentStatus$(
        PaymentStatus paymentStatus,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentStatus>(
        getPropVal: getReservationPaymentStatus,
        value: paymentStatus,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByPaymentStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByValidUntil$(
        DateTime validUntil,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReservationValidUntil,
        value: validUntil,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByValidUntil,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReservationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReservationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Reservation>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Reservation>? modelFilter,
        List<ReservationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReservationDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ReservationEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    Reservation reservation, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (reservation.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            reservation.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            reservation.contact = contact;
        });
    }
}

	Stream<Listing?> getListing$(
    Reservation reservation, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (reservation.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            reservation.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            reservation.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    Reservation reservation, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (reservation.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            reservation.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            reservation.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Booking>> getBookings$(
    Reservation reservation, {bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    return BookingStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((bookings) {
        reservation.bookings = bookings;
    });

}

	Stream<List<FinancialRecord>> getFinancialRecords$(
    Reservation reservation, {bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    return FinancialRecordStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((financialRecords) {
        reservation.financialRecords = financialRecords;
    });

}

	Stream<List<Task>> getTasks$(
    Reservation reservation, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        reservation.tasks = tasks;
    });

}

	Stream<EscrowAccount?> getEscrowAccount$(
    Reservation reservation, {bool useCache = true, ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}) {
    return EscrowAccountStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((escrowAccount) {
        reservation.escrowAccount = escrowAccount;
    });

}

	Stream<PaymentNegotiation?> getPaymentNegotiation$(
    Reservation reservation, {bool useCache = true, ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    return PaymentNegotiationStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((paymentNegotiation) {
        reservation.paymentNegotiation = paymentNegotiation;
    });

}

	Stream<List<AIChatMessage>> getAiChatMessages$(
    Reservation reservation, {bool useCache = true, ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    return AIChatMessageStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiChatMessages) {
        reservation.aiChatMessages = aiChatMessages;
    });

}

	Stream<List<PricingRule>> getPricingRules$(
    Reservation reservation, {bool useCache = true, ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    return PricingRuleStore.instance.getBy$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((pricingRules) {
        reservation.pricingRules = pricingRules;
    });

}

	Stream<List<Agent>> getAgents$(
    Reservation reservation, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getBy$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agents) {
        reservation.agents = agents;
    });

}

	Stream<List<Currency>> getCurrencies$(
    Reservation reservation, {bool useCache = true, ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    return CurrencyStore.instance.getBy$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((currencies) {
        reservation.currencies = currencies;
    });

}

	Stream<List<Guest>> getGuests$(
    Reservation reservation, {bool useCache = true, ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}) {
    return GuestStore.instance.getBy$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((guests) {
        reservation.guests = guests;
    });

}

	Stream<List<Agency>> getAgencies$(
    Reservation reservation, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        reservation.agencies = agencies;
    });

}

	Stream<List<ReferenceSource>> getReferenceSources$(
    Reservation reservation, {bool useCache = true, ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}) {
    return ReferenceSourceStore.instance.getBy$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((referenceSources) {
        reservation.referenceSources = referenceSources;
    });

}

	Stream<List<Discount>> getDiscounts$(
    Reservation reservation, {bool useCache = true, ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}) {
    return DiscountStore.instance.getBy$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((discounts) {
        reservation.discounts = discounts;
    });

}

	Stream<List<Analytics>> getAnalytics$(
    Reservation reservation, {bool useCache = true, ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    return AnalyticsStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analytics) {
        reservation.analytics = analytics;
    });

}

	Stream<List<Availability>> getAvailabilities$(
    Reservation reservation, {bool useCache = true, ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}) {
    return AvailabilityStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((availabilities) {
        reservation.availabilities = availabilities;
    });

}

	Stream<List<ComplianceRecord>> getComplianceRecords$(
    Reservation reservation, {bool useCache = true, ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    return ComplianceRecordStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((complianceRecords) {
        reservation.complianceRecords = complianceRecords;
    });

}

	Stream<Offer?> getOffer$(
    Reservation reservation, {bool useCache = true, ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    return OfferStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((offer) {
        reservation.offer = offer;
    });

}

	Stream<List<Payment>> getPayments$(
    Reservation reservation, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((payments) {
        reservation.payments = payments;
    });

}

	Stream<List<ExtraCharge>> getExtraCharges$(
    Reservation reservation, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    return ExtraChargeStore.instance.getByReservationId$(
        reservation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((ExtraCharges) {
        reservation.ExtraCharges = ExtraCharges;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Reservation recursiveUpsert(Reservation reservation, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Reservation'} 
        : const {};
    if (reservation.bookings != null && (!preventCircularSerialization || !upsertedTypes.contains('Booking'))) {
        reservation.bookings = BookingStore.instance.recursiveListUpsert(reservation.bookings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.financialRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('FinancialRecord'))) {
        reservation.financialRecords = FinancialRecordStore.instance.recursiveListUpsert(reservation.financialRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        reservation.contact = ContactStore.instance.recursiveUpsert(reservation.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        reservation.listing = ListingStore.instance.recursiveUpsert(reservation.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        reservation.org = OrganizationStore.instance.recursiveUpsert(reservation.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        reservation.tasks = TaskStore.instance.recursiveListUpsert(reservation.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.escrowAccount != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowAccount'))) {
        reservation.escrowAccount = EscrowAccountStore.instance.recursiveUpsert(reservation.escrowAccount!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.paymentNegotiation != null && (!preventCircularSerialization || !upsertedTypes.contains('PaymentNegotiation'))) {
        reservation.paymentNegotiation = PaymentNegotiationStore.instance.recursiveUpsert(reservation.paymentNegotiation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.aiChatMessages != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatMessage'))) {
        reservation.aiChatMessages = AIChatMessageStore.instance.recursiveListUpsert(reservation.aiChatMessages!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.pricingRules != null && (!preventCircularSerialization || !upsertedTypes.contains('PricingRule'))) {
        reservation.pricingRules = PricingRuleStore.instance.recursiveListUpsert(reservation.pricingRules!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.agents != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        reservation.agents = AgentStore.instance.recursiveListUpsert(reservation.agents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.currencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Currency'))) {
        reservation.currencies = CurrencyStore.instance.recursiveListUpsert(reservation.currencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.guests != null && (!preventCircularSerialization || !upsertedTypes.contains('Guest'))) {
        reservation.guests = GuestStore.instance.recursiveListUpsert(reservation.guests!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        reservation.agencies = AgencyStore.instance.recursiveListUpsert(reservation.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.referenceSources != null && (!preventCircularSerialization || !upsertedTypes.contains('ReferenceSource'))) {
        reservation.referenceSources = ReferenceSourceStore.instance.recursiveListUpsert(reservation.referenceSources!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.discounts != null && (!preventCircularSerialization || !upsertedTypes.contains('Discount'))) {
        reservation.discounts = DiscountStore.instance.recursiveListUpsert(reservation.discounts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.analytics != null && (!preventCircularSerialization || !upsertedTypes.contains('Analytics'))) {
        reservation.analytics = AnalyticsStore.instance.recursiveListUpsert(reservation.analytics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.availabilities != null && (!preventCircularSerialization || !upsertedTypes.contains('Availability'))) {
        reservation.availabilities = AvailabilityStore.instance.recursiveListUpsert(reservation.availabilities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.complianceRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('ComplianceRecord'))) {
        reservation.complianceRecords = ComplianceRecordStore.instance.recursiveListUpsert(reservation.complianceRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.offer != null && (!preventCircularSerialization || !upsertedTypes.contains('Offer'))) {
        reservation.offer = OfferStore.instance.recursiveUpsert(reservation.offer!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.payments != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        reservation.payments = PaymentStore.instance.recursiveListUpsert(reservation.payments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reservation.ExtraCharges != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        reservation.ExtraCharges = ExtraChargeStore.instance.recursiveListUpsert(reservation.ExtraCharges!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(reservation);
}

  List<Reservation> recursiveListUpsert(List<Reservation> reservations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedReservations = <Reservation>[];
    for (var reservation in reservations) {
        updatedReservations.add(recursiveUpsert(reservation, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedReservations;
}

//   @override
//   Reservation upsert(Reservation item) {
//     return recursiveUpsert(item);
//   }

}


class ReservationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ReservationInclude.bookings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Booking>? modelFilter,
    List<BookingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getBookings$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getBookings(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.financialRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FinancialRecord>? modelFilter,
    List<FinancialRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getFinancialRecords$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getFinancialRecords(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getContact$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getContact(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getListing$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getListing(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getOrg$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getOrg(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getTasks$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getTasks(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.escrowAccount({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowAccount>? modelFilter,
    List<EscrowAccountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getEscrowAccount$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getEscrowAccount(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.paymentNegotiation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PaymentNegotiation>? modelFilter,
    List<PaymentNegotiationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getPaymentNegotiation$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getPaymentNegotiation(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.aiChatMessages({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatMessage>? modelFilter,
    List<AIChatMessageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getAiChatMessages$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getAiChatMessages(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.pricingRules({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PricingRule>? modelFilter,
    List<PricingRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getPricingRules$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getPricingRules(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.agents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getAgents$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getAgents(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.currencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Currency>? modelFilter,
    List<CurrencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getCurrencies$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getCurrencies(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.guests({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Guest>? modelFilter,
    List<GuestInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getGuests$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getGuests(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getAgencies$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getAgencies(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.referenceSources({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ReferenceSource>? modelFilter,
    List<ReferenceSourceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getReferenceSources$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getReferenceSources(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.discounts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Discount>? modelFilter,
    List<DiscountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getDiscounts$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getDiscounts(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.analytics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Analytics>? modelFilter,
    List<AnalyticsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getAnalytics$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getAnalytics(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.availabilities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Availability>? modelFilter,
    List<AvailabilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getAvailabilities$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getAvailabilities(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.complianceRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ComplianceRecord>? modelFilter,
    List<ComplianceRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getComplianceRecords$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getComplianceRecords(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.offer({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Offer>? modelFilter,
    List<OfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getOffer$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getOffer(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.payments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getPayments$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getPayments(reservation, modelFilter: modelFilter, includes: includes);
      }
}

	ReservationInclude.ExtraCharges({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reservation) => ReservationStore.instance
            .getExtraCharges$(reservation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reservation) => ReservationStore.instance
            .getExtraCharges(reservation, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ReservationEndpoints implements Endpoint {

    getAll('/reservation', HttpMethod.post, List<Reservation>),
	getById('/reservation/byId/:id', HttpMethod.post, Reservation),
	getManyByOrgId('/reservation/byOrgId/:orgId', HttpMethod.post, List<Reservation>),
	getManyByListingId('/reservation/byListingId/:listingId', HttpMethod.post, List<Reservation>),
	getManyByContactId('/reservation/byContactId/:contactId', HttpMethod.post, List<Reservation>),
	getManyByCheckInDate('/reservation/byCheckInDate/:checkInDate', HttpMethod.post, List<Reservation>),
	getManyByCheckOutDate('/reservation/byCheckOutDate/:checkOutDate', HttpMethod.post, List<Reservation>),
	getManyByGuestCount('/reservation/byGuestCount/:guestCount', HttpMethod.post, List<Reservation>),
	getManyBySpecialRequests('/reservation/bySpecialRequests/:specialRequests', HttpMethod.post, List<Reservation>),
	getManyByNightlyRate('/reservation/byNightlyRate/:nightlyRate', HttpMethod.post, List<Reservation>),
	getManyByCleaningFee('/reservation/byCleaningFee/:cleaningFee', HttpMethod.post, List<Reservation>),
	getManyByTotalAmount('/reservation/byTotalAmount/:totalAmount', HttpMethod.post, List<Reservation>),
	getManyByCurrency('/reservation/byCurrency/:currency', HttpMethod.post, List<Reservation>),
	getManyByStatus('/reservation/byStatus/:status', HttpMethod.post, List<Reservation>),
	getManyByPaymentStatus('/reservation/byPaymentStatus/:paymentStatus', HttpMethod.post, List<Reservation>),
	getManyByValidUntil('/reservation/byValidUntil/:validUntil', HttpMethod.post, List<Reservation>),
	getManyByCreatedAt('/reservation/byCreatedAt/:createdAt', HttpMethod.post, List<Reservation>),
	getManyByUpdatedAt('/reservation/byUpdatedAt/:updatedAt', HttpMethod.post, List<Reservation>),
	getManyByDeletedAt('/reservation/byDeletedAt/:deletedAt', HttpMethod.post, List<Reservation>);

    const ReservationEndpoints(this.path, this.method, this.responseType);

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
