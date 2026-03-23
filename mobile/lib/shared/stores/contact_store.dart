
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ContactStore extends ModelStreamStore<String, Contact> {

  static ContactStore? _instance;

  static ContactStore get instance {
    _instance ??= ContactStore();
    return _instance!;
  }

  ContactStore() : super(Contact.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ContactStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ContactStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ContactStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getContactId(Contact contact) => contact.id;

	String? getContactOrgId(Contact contact) => contact.orgId;

	ContactType? getContactType(Contact contact) => contact.type;

	String? getContactFullName(Contact contact) => contact.fullName;

	String? getContactEmail(Contact contact) => contact.email;

	String? getContactPhone(Contact contact) => contact.phone;

	String? getContactNotes(Contact contact) => contact.notes;

	String? getContactLocale(Contact contact) => contact.locale;

	String? getContactCurrency(Contact contact) => contact.currency;

	DateTime? getContactCreatedAt(Contact contact) => contact.createdAt;

	DateTime? getContactUpdatedAt(Contact contact) => contact.updatedAt;

	DateTime? getContactDeletedAt(Contact contact) => contact.deletedAt;

	DateTime? getContactConsentGivenAt(Contact contact) => contact.consentGivenAt;

	DateTime? getContactConsentWithdrawnAt(Contact contact) => contact.consentWithdrawnAt;

	String? getContactDataSubjectId(Contact contact) => contact.dataSubjectId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Contact? getByDataSubjectId(
    String dataSubjectId,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getIncluding(getContactDataSubjectId, dataSubjectId, modelFilter: modelFilter, includes: includes);

  
List<Contact> getByOrgId(
    String orgId,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByType(
    ContactType type,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactType, type, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByFullName(
    String fullName,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactFullName, fullName, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByEmail(
    String email,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactEmail, email, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByPhone(
    String phone,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactPhone, phone, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByNotes(
    String notes,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByLocale(
    String locale,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactLocale, locale, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByCurrency(
    String currency,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByConsentGivenAt(
    DateTime consentGivenAt,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactConsentGivenAt, consentGivenAt, modelFilter: modelFilter, includes: includes);

	
List<Contact> getByConsentWithdrawnAt(
    DateTime consentWithdrawnAt,
    {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}
    ) =>
    getManyIncluding(getContactConsentWithdrawnAt, consentWithdrawnAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Contact contact, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (contact.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(contact.orgId!, includes: includes);
        contact.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<Appointment> getAssignedAppointments(
    Contact contact, {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    final assignedAppointments = AppointmentStore.instance.getByAssignedToContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.assignedAppointments = assignedAppointments;
    // setIncludedReferencesForList(assignedAppointments, includes: includes);
    return assignedAppointments;
}

	List<Appointment> getAppointments(
    Contact contact, {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    final appointments = AppointmentStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.appointments = appointments;
    // setIncludedReferencesForList(appointments, includes: includes);
    return appointments;
}

	List<AttorneyManagement> getAttorneyCases(
    Contact contact, {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}) {
    final attorneyCases = AttorneyManagementStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.attorneyCases = attorneyCases;
    // setIncludedReferencesForList(attorneyCases, includes: includes);
    return attorneyCases;
}

	List<Booking> getBookings(
    Contact contact, {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    final bookings = BookingStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.bookings = bookings;
    // setIncludedReferencesForList(bookings, includes: includes);
    return bookings;
}

	List<ClientRelationship> getClientRelationships(
    Contact contact, {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}) {
    final clientRelationships = ClientRelationshipStore.instance.getByClientId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.clientRelationships = clientRelationships;
    // setIncludedReferencesForList(clientRelationships, includes: includes);
    return clientRelationships;
}

	List<Deal> getDealAgents(
    Contact contact, {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    final dealAgents = DealStore.instance.getByAgentId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.dealAgents = dealAgents;
    // setIncludedReferencesForList(dealAgents, includes: includes);
    return dealAgents;
}

	List<Deal> getDealClients(
    Contact contact, {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    final dealClients = DealStore.instance.getByClientId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.dealClients = dealClients;
    // setIncludedReferencesForList(dealClients, includes: includes);
    return dealClients;
}

	List<EventAttendee> getEventAttendees(
    Contact contact, {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    final eventAttendees = EventAttendeeStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.eventAttendees = eventAttendees;
    // setIncludedReferencesForList(eventAttendees, includes: includes);
    return eventAttendees;
}

	List<FinancialRecord> getVendorRecords(
    Contact contact, {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    final vendorRecords = FinancialRecordStore.instance.getByVendorContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.vendorRecords = vendorRecords;
    // setIncludedReferencesForList(vendorRecords, includes: includes);
    return vendorRecords;
}

	GuestProfile? getGuestProfile(
    Contact contact, {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}) {
    final guestProfile = GuestProfileStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.guestProfile = guestProfile;
    // setIncludedReferences(guestProfile, includes: includes);
    return guestProfile;
}

	List<GuestReview> getGuestReviews(
    Contact contact, {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}) {
    final guestReviews = GuestReviewStore.instance.getByGuestId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.guestReviews = guestReviews;
    // setIncludedReferencesForList(guestReviews, includes: includes);
    return guestReviews;
}

	List<ImmigrationStatusCheck> getImmigrationStatusChecks(
    Contact contact, {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}) {
    final immigrationStatusChecks = ImmigrationStatusCheckStore.instance.getByTenantId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.immigrationStatusChecks = immigrationStatusChecks;
    // setIncludedReferencesForList(immigrationStatusChecks, includes: includes);
    return immigrationStatusChecks;
}

	List<Lead> getLeads(
    Contact contact, {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final leads = LeadStore.instance.getByAssignedToContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.leads = leads;
    // setIncludedReferencesForList(leads, includes: includes);
    return leads;
}

	List<Lease> getLeases(
    Contact contact, {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    final leases = LeaseStore.instance.getBy(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.leases = leases;
    // setIncludedReferencesForList(leases, includes: includes);
    return leases;
}

	List<MaintenanceWorkOrder> getWorkOrders(
    Contact contact, {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    final workOrders = MaintenanceWorkOrderStore.instance.getBy(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.workOrders = workOrders;
    // setIncludedReferencesForList(workOrders, includes: includes);
    return workOrders;
}

	List<MortgageOffer> getMortgageOffers(
    Contact contact, {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}) {
    final mortgageOffers = MortgageOfferStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.mortgageOffers = mortgageOffers;
    // setIncludedReferencesForList(mortgageOffers, includes: includes);
    return mortgageOffers;
}

	List<MortgagePreApproval> getMortgagePreApprovals(
    Contact contact, {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}) {
    final mortgagePreApprovals = MortgagePreApprovalStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.mortgagePreApprovals = mortgagePreApprovals;
    // setIncludedReferencesForList(mortgagePreApprovals, includes: includes);
    return mortgagePreApprovals;
}

	List<Payout> getPayoutProcessors(
    Contact contact, {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    final payoutProcessors = PayoutStore.instance.getByProcessorId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.payoutProcessors = payoutProcessors;
    // setIncludedReferencesForList(payoutProcessors, includes: includes);
    return payoutProcessors;
}

	List<Payout> getPayoutRecipients(
    Contact contact, {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    final payoutRecipients = PayoutStore.instance.getByRecipientId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.payoutRecipients = payoutRecipients;
    // setIncludedReferencesForList(payoutRecipients, includes: includes);
    return payoutRecipients;
}

	List<Project> getProjects(
    Contact contact, {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    final projects = ProjectStore.instance.getByContractorId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.projects = projects;
    // setIncludedReferencesForList(projects, includes: includes);
    return projects;
}

	List<PropertyCompliance> getPropertyCompliance(
    Contact contact, {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    final propertyCompliance = PropertyComplianceStore.instance.getByInspectorContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.propertyCompliance = propertyCompliance;
    // setIncludedReferencesForList(propertyCompliance, includes: includes);
    return propertyCompliance;
}

	List<PropertyOffer> getPropertyOffers(
    Contact contact, {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    final propertyOffers = PropertyOfferStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.propertyOffers = propertyOffers;
    // setIncludedReferencesForList(propertyOffers, includes: includes);
    return propertyOffers;
}

	List<Quote> getQuotes(
    Contact contact, {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    final quotes = QuoteStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.quotes = quotes;
    // setIncludedReferencesForList(quotes, includes: includes);
    return quotes;
}

	List<RentArrears> getRentArrears(
    Contact contact, {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}) {
    final rentArrears = RentArrearsStore.instance.getByTenantId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.rentArrears = rentArrears;
    // setIncludedReferencesForList(rentArrears, includes: includes);
    return rentArrears;
}

	List<Reservation> getReservations(
    Contact contact, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final reservations = ReservationStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.reservations = reservations;
    // setIncludedReferencesForList(reservations, includes: includes);
    return reservations;
}

	List<RightToRentCheck> getRightToRentChecks(
    Contact contact, {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}) {
    final rightToRentChecks = RightToRentCheckStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.rightToRentChecks = rightToRentChecks;
    // setIncludedReferencesForList(rightToRentChecks, includes: includes);
    return rightToRentChecks;
}

	List<SignatureSigner> getSignatureSigners(
    Contact contact, {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    final signatureSigners = SignatureSignerStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.signatureSigners = signatureSigners;
    // setIncludedReferencesForList(signatureSigners, includes: includes);
    return signatureSigners;
}

	List<SolicitorManagement> getSolicitorManagements(
    Contact contact, {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}) {
    final solicitorManagements = SolicitorManagementStore.instance.getByContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.solicitorManagements = solicitorManagements;
    // setIncludedReferencesForList(solicitorManagements, includes: includes);
    return solicitorManagements;
}

	List<Task> getTasks(
    Contact contact, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByAssignedToContactId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<Tax1099Form> getTax1099Forms(
    Contact contact, {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}) {
    final tax1099Forms = Tax1099FormStore.instance.getByRecipientId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.tax1099Forms = tax1099Forms;
    // setIncludedReferencesForList(tax1099Forms, includes: includes);
    return tax1099Forms;
}

	List<TenantApplication> getTenantApplications(
    Contact contact, {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    final tenantApplications = TenantApplicationStore.instance.getByApplicantId(contact.$uid!, modelFilter: modelFilter, includes: includes);
    contact.tenantApplications = tenantApplications;
    // setIncludedReferencesForList(tenantApplications, includes: includes);
    return tenantApplications;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Contact>> getAll$({bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ContactEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Contact?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getContactId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Contact?> getByDataSubjectId$(
        String dataSubjectId,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getContactDataSubjectId,
        value: dataSubjectId,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getByDataSubjectId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Contact>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContactOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByType$(
        ContactType type,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<ContactType>(
        getPropVal: getContactType,
        value: type,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByFullName$(
        String fullName,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContactFullName,
        value: fullName,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByFullName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByEmail$(
        String email,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContactEmail,
        value: email,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByPhone$(
        String phone,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContactPhone,
        value: phone,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByPhone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContactNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByLocale$(
        String locale,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContactLocale,
        value: locale,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByLocale,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContactCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContactCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContactUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContactDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByConsentGivenAt$(
        DateTime consentGivenAt,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContactConsentGivenAt,
        value: consentGivenAt,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByConsentGivenAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Contact>> getByConsentWithdrawnAt$(
        DateTime consentWithdrawnAt,
        {bool useCache = true,
        ModelFilter<Contact>? modelFilter,
        List<ContactInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContactConsentWithdrawnAt,
        value: consentWithdrawnAt,
        modelFilter: modelFilter,
        endpoint: ContactEndpoints.getManyByConsentWithdrawnAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Contact contact, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (contact.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            contact.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            contact.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Appointment>> getAssignedAppointments$(
    Contact contact, {bool useCache = true, ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    return AppointmentStore.instance.getByAssignedToContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((assignedAppointments) {
        contact.assignedAppointments = assignedAppointments;
    });

}

	Stream<List<Appointment>> getAppointments$(
    Contact contact, {bool useCache = true, ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    return AppointmentStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((appointments) {
        contact.appointments = appointments;
    });

}

	Stream<List<AttorneyManagement>> getAttorneyCases$(
    Contact contact, {bool useCache = true, ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}) {
    return AttorneyManagementStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attorneyCases) {
        contact.attorneyCases = attorneyCases;
    });

}

	Stream<List<Booking>> getBookings$(
    Contact contact, {bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    return BookingStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((bookings) {
        contact.bookings = bookings;
    });

}

	Stream<List<ClientRelationship>> getClientRelationships$(
    Contact contact, {bool useCache = true, ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}) {
    return ClientRelationshipStore.instance.getByClientId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((clientRelationships) {
        contact.clientRelationships = clientRelationships;
    });

}

	Stream<List<Deal>> getDealAgents$(
    Contact contact, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    return DealStore.instance.getByAgentId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((dealAgents) {
        contact.dealAgents = dealAgents;
    });

}

	Stream<List<Deal>> getDealClients$(
    Contact contact, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    return DealStore.instance.getByClientId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((dealClients) {
        contact.dealClients = dealClients;
    });

}

	Stream<List<EventAttendee>> getEventAttendees$(
    Contact contact, {bool useCache = true, ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    return EventAttendeeStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((eventAttendees) {
        contact.eventAttendees = eventAttendees;
    });

}

	Stream<List<FinancialRecord>> getVendorRecords$(
    Contact contact, {bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    return FinancialRecordStore.instance.getByVendorContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((vendorRecords) {
        contact.vendorRecords = vendorRecords;
    });

}

	Stream<GuestProfile?> getGuestProfile$(
    Contact contact, {bool useCache = true, ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}) {
    return GuestProfileStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((guestProfile) {
        contact.guestProfile = guestProfile;
    });

}

	Stream<List<GuestReview>> getGuestReviews$(
    Contact contact, {bool useCache = true, ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}) {
    return GuestReviewStore.instance.getByGuestId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((guestReviews) {
        contact.guestReviews = guestReviews;
    });

}

	Stream<List<ImmigrationStatusCheck>> getImmigrationStatusChecks$(
    Contact contact, {bool useCache = true, ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}) {
    return ImmigrationStatusCheckStore.instance.getByTenantId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((immigrationStatusChecks) {
        contact.immigrationStatusChecks = immigrationStatusChecks;
    });

}

	Stream<List<Lead>> getLeads$(
    Contact contact, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    return LeadStore.instance.getByAssignedToContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leads) {
        contact.leads = leads;
    });

}

	Stream<List<Lease>> getLeases$(
    Contact contact, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    return LeaseStore.instance.getBy$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leases) {
        contact.leases = leases;
    });

}

	Stream<List<MaintenanceWorkOrder>> getWorkOrders$(
    Contact contact, {bool useCache = true, ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    return MaintenanceWorkOrderStore.instance.getBy$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((workOrders) {
        contact.workOrders = workOrders;
    });

}

	Stream<List<MortgageOffer>> getMortgageOffers$(
    Contact contact, {bool useCache = true, ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}) {
    return MortgageOfferStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mortgageOffers) {
        contact.mortgageOffers = mortgageOffers;
    });

}

	Stream<List<MortgagePreApproval>> getMortgagePreApprovals$(
    Contact contact, {bool useCache = true, ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}) {
    return MortgagePreApprovalStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mortgagePreApprovals) {
        contact.mortgagePreApprovals = mortgagePreApprovals;
    });

}

	Stream<List<Payout>> getPayoutProcessors$(
    Contact contact, {bool useCache = true, ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    return PayoutStore.instance.getByProcessorId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((payoutProcessors) {
        contact.payoutProcessors = payoutProcessors;
    });

}

	Stream<List<Payout>> getPayoutRecipients$(
    Contact contact, {bool useCache = true, ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    return PayoutStore.instance.getByRecipientId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((payoutRecipients) {
        contact.payoutRecipients = payoutRecipients;
    });

}

	Stream<List<Project>> getProjects$(
    Contact contact, {bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    return ProjectStore.instance.getByContractorId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((projects) {
        contact.projects = projects;
    });

}

	Stream<List<PropertyCompliance>> getPropertyCompliance$(
    Contact contact, {bool useCache = true, ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    return PropertyComplianceStore.instance.getByInspectorContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyCompliance) {
        contact.propertyCompliance = propertyCompliance;
    });

}

	Stream<List<PropertyOffer>> getPropertyOffers$(
    Contact contact, {bool useCache = true, ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    return PropertyOfferStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyOffers) {
        contact.propertyOffers = propertyOffers;
    });

}

	Stream<List<Quote>> getQuotes$(
    Contact contact, {bool useCache = true, ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    return QuoteStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((quotes) {
        contact.quotes = quotes;
    });

}

	Stream<List<RentArrears>> getRentArrears$(
    Contact contact, {bool useCache = true, ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}) {
    return RentArrearsStore.instance.getByTenantId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rentArrears) {
        contact.rentArrears = rentArrears;
    });

}

	Stream<List<Reservation>> getReservations$(
    Contact contact, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reservations) {
        contact.reservations = reservations;
    });

}

	Stream<List<RightToRentCheck>> getRightToRentChecks$(
    Contact contact, {bool useCache = true, ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}) {
    return RightToRentCheckStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rightToRentChecks) {
        contact.rightToRentChecks = rightToRentChecks;
    });

}

	Stream<List<SignatureSigner>> getSignatureSigners$(
    Contact contact, {bool useCache = true, ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    return SignatureSignerStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((signatureSigners) {
        contact.signatureSigners = signatureSigners;
    });

}

	Stream<List<SolicitorManagement>> getSolicitorManagements$(
    Contact contact, {bool useCache = true, ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}) {
    return SolicitorManagementStore.instance.getByContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((solicitorManagements) {
        contact.solicitorManagements = solicitorManagements;
    });

}

	Stream<List<Task>> getTasks$(
    Contact contact, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByAssignedToContactId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        contact.tasks = tasks;
    });

}

	Stream<List<Tax1099Form>> getTax1099Forms$(
    Contact contact, {bool useCache = true, ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}) {
    return Tax1099FormStore.instance.getByRecipientId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tax1099Forms) {
        contact.tax1099Forms = tax1099Forms;
    });

}

	Stream<List<TenantApplication>> getTenantApplications$(
    Contact contact, {bool useCache = true, ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    return TenantApplicationStore.instance.getByApplicantId$(
        contact.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenantApplications) {
        contact.tenantApplications = tenantApplications;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Contact recursiveUpsert(Contact contact, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Contact'} 
        : const {};
    if (contact.assignedAppointments != null && (!preventCircularSerialization || !upsertedTypes.contains('Appointment'))) {
        contact.assignedAppointments = AppointmentStore.instance.recursiveListUpsert(contact.assignedAppointments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.appointments != null && (!preventCircularSerialization || !upsertedTypes.contains('Appointment'))) {
        contact.appointments = AppointmentStore.instance.recursiveListUpsert(contact.appointments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.attorneyCases != null && (!preventCircularSerialization || !upsertedTypes.contains('AttorneyManagement'))) {
        contact.attorneyCases = AttorneyManagementStore.instance.recursiveListUpsert(contact.attorneyCases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.bookings != null && (!preventCircularSerialization || !upsertedTypes.contains('Booking'))) {
        contact.bookings = BookingStore.instance.recursiveListUpsert(contact.bookings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.clientRelationships != null && (!preventCircularSerialization || !upsertedTypes.contains('ClientRelationship'))) {
        contact.clientRelationships = ClientRelationshipStore.instance.recursiveListUpsert(contact.clientRelationships!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        contact.org = OrganizationStore.instance.recursiveUpsert(contact.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.dealAgents != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        contact.dealAgents = DealStore.instance.recursiveListUpsert(contact.dealAgents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.dealClients != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        contact.dealClients = DealStore.instance.recursiveListUpsert(contact.dealClients!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.eventAttendees != null && (!preventCircularSerialization || !upsertedTypes.contains('EventAttendee'))) {
        contact.eventAttendees = EventAttendeeStore.instance.recursiveListUpsert(contact.eventAttendees!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.vendorRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('FinancialRecord'))) {
        contact.vendorRecords = FinancialRecordStore.instance.recursiveListUpsert(contact.vendorRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.guestProfile != null && (!preventCircularSerialization || !upsertedTypes.contains('GuestProfile'))) {
        contact.guestProfile = GuestProfileStore.instance.recursiveUpsert(contact.guestProfile!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.guestReviews != null && (!preventCircularSerialization || !upsertedTypes.contains('GuestReview'))) {
        contact.guestReviews = GuestReviewStore.instance.recursiveListUpsert(contact.guestReviews!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.immigrationStatusChecks != null && (!preventCircularSerialization || !upsertedTypes.contains('ImmigrationStatusCheck'))) {
        contact.immigrationStatusChecks = ImmigrationStatusCheckStore.instance.recursiveListUpsert(contact.immigrationStatusChecks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.leads != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        contact.leads = LeadStore.instance.recursiveListUpsert(contact.leads!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.leases != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        contact.leases = LeaseStore.instance.recursiveListUpsert(contact.leases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.workOrders != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceWorkOrder'))) {
        contact.workOrders = MaintenanceWorkOrderStore.instance.recursiveListUpsert(contact.workOrders!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.mortgageOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('MortgageOffer'))) {
        contact.mortgageOffers = MortgageOfferStore.instance.recursiveListUpsert(contact.mortgageOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.mortgagePreApprovals != null && (!preventCircularSerialization || !upsertedTypes.contains('MortgagePreApproval'))) {
        contact.mortgagePreApprovals = MortgagePreApprovalStore.instance.recursiveListUpsert(contact.mortgagePreApprovals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.payoutProcessors != null && (!preventCircularSerialization || !upsertedTypes.contains('Payout'))) {
        contact.payoutProcessors = PayoutStore.instance.recursiveListUpsert(contact.payoutProcessors!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.payoutRecipients != null && (!preventCircularSerialization || !upsertedTypes.contains('Payout'))) {
        contact.payoutRecipients = PayoutStore.instance.recursiveListUpsert(contact.payoutRecipients!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.projects != null && (!preventCircularSerialization || !upsertedTypes.contains('Project'))) {
        contact.projects = ProjectStore.instance.recursiveListUpsert(contact.projects!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.propertyCompliance != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyCompliance'))) {
        contact.propertyCompliance = PropertyComplianceStore.instance.recursiveListUpsert(contact.propertyCompliance!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.propertyOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyOffer'))) {
        contact.propertyOffers = PropertyOfferStore.instance.recursiveListUpsert(contact.propertyOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.quotes != null && (!preventCircularSerialization || !upsertedTypes.contains('Quote'))) {
        contact.quotes = QuoteStore.instance.recursiveListUpsert(contact.quotes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.rentArrears != null && (!preventCircularSerialization || !upsertedTypes.contains('RentArrears'))) {
        contact.rentArrears = RentArrearsStore.instance.recursiveListUpsert(contact.rentArrears!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.reservations != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        contact.reservations = ReservationStore.instance.recursiveListUpsert(contact.reservations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.rightToRentChecks != null && (!preventCircularSerialization || !upsertedTypes.contains('RightToRentCheck'))) {
        contact.rightToRentChecks = RightToRentCheckStore.instance.recursiveListUpsert(contact.rightToRentChecks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.signatureSigners != null && (!preventCircularSerialization || !upsertedTypes.contains('SignatureSigner'))) {
        contact.signatureSigners = SignatureSignerStore.instance.recursiveListUpsert(contact.signatureSigners!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.solicitorManagements != null && (!preventCircularSerialization || !upsertedTypes.contains('SolicitorManagement'))) {
        contact.solicitorManagements = SolicitorManagementStore.instance.recursiveListUpsert(contact.solicitorManagements!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        contact.tasks = TaskStore.instance.recursiveListUpsert(contact.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.tax1099Forms != null && (!preventCircularSerialization || !upsertedTypes.contains('Tax1099Form'))) {
        contact.tax1099Forms = Tax1099FormStore.instance.recursiveListUpsert(contact.tax1099Forms!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contact.tenantApplications != null && (!preventCircularSerialization || !upsertedTypes.contains('TenantApplication'))) {
        contact.tenantApplications = TenantApplicationStore.instance.recursiveListUpsert(contact.tenantApplications!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(contact);
}

  List<Contact> recursiveListUpsert(List<Contact> contacts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedContacts = <Contact>[];
    for (var contact in contacts) {
        updatedContacts.add(recursiveUpsert(contact, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedContacts;
}

//   @override
//   Contact upsert(Contact item) {
//     return recursiveUpsert(item);
//   }

}


class ContactInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ContactInclude.assignedAppointments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Appointment>? modelFilter,
    List<AppointmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getAssignedAppointments$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getAssignedAppointments(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.appointments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Appointment>? modelFilter,
    List<AppointmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getAppointments$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getAppointments(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.attorneyCases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AttorneyManagement>? modelFilter,
    List<AttorneyManagementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getAttorneyCases$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getAttorneyCases(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.bookings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Booking>? modelFilter,
    List<BookingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getBookings$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getBookings(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.clientRelationships({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ClientRelationship>? modelFilter,
    List<ClientRelationshipInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getClientRelationships$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getClientRelationships(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getOrg$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getOrg(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.dealAgents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getDealAgents$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getDealAgents(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.dealClients({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getDealClients$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getDealClients(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.eventAttendees({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EventAttendee>? modelFilter,
    List<EventAttendeeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getEventAttendees$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getEventAttendees(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.vendorRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FinancialRecord>? modelFilter,
    List<FinancialRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getVendorRecords$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getVendorRecords(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.guestProfile({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<GuestProfile>? modelFilter,
    List<GuestProfileInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getGuestProfile$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getGuestProfile(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.guestReviews({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<GuestReview>? modelFilter,
    List<GuestReviewInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getGuestReviews$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getGuestReviews(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.immigrationStatusChecks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ImmigrationStatusCheck>? modelFilter,
    List<ImmigrationStatusCheckInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getImmigrationStatusChecks$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getImmigrationStatusChecks(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.leads({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getLeads$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getLeads(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.leases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getLeases$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getLeases(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.workOrders({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceWorkOrder>? modelFilter,
    List<MaintenanceWorkOrderInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getWorkOrders$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getWorkOrders(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.mortgageOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MortgageOffer>? modelFilter,
    List<MortgageOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getMortgageOffers$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getMortgageOffers(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.mortgagePreApprovals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MortgagePreApproval>? modelFilter,
    List<MortgagePreApprovalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getMortgagePreApprovals$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getMortgagePreApprovals(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.payoutProcessors({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payout>? modelFilter,
    List<PayoutInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getPayoutProcessors$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getPayoutProcessors(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.payoutRecipients({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payout>? modelFilter,
    List<PayoutInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getPayoutRecipients$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getPayoutRecipients(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.projects({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Project>? modelFilter,
    List<ProjectInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getProjects$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getProjects(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.propertyCompliance({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyCompliance>? modelFilter,
    List<PropertyComplianceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getPropertyCompliance$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getPropertyCompliance(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.propertyOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyOffer>? modelFilter,
    List<PropertyOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getPropertyOffers$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getPropertyOffers(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.quotes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Quote>? modelFilter,
    List<QuoteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getQuotes$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getQuotes(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.rentArrears({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RentArrears>? modelFilter,
    List<RentArrearsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getRentArrears$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getRentArrears(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.reservations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getReservations$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getReservations(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.rightToRentChecks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RightToRentCheck>? modelFilter,
    List<RightToRentCheckInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getRightToRentChecks$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getRightToRentChecks(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.signatureSigners({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SignatureSigner>? modelFilter,
    List<SignatureSignerInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getSignatureSigners$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getSignatureSigners(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.solicitorManagements({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SolicitorManagement>? modelFilter,
    List<SolicitorManagementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getSolicitorManagements$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getSolicitorManagements(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getTasks$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getTasks(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.tax1099Forms({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tax1099Form>? modelFilter,
    List<Tax1099FormInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getTax1099Forms$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getTax1099Forms(contact, modelFilter: modelFilter, includes: includes);
      }
}

	ContactInclude.tenantApplications({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TenantApplication>? modelFilter,
    List<TenantApplicationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contact) => ContactStore.instance
            .getTenantApplications$(contact, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contact) => ContactStore.instance
            .getTenantApplications(contact, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ContactEndpoints implements Endpoint {

    getAll('/contact', HttpMethod.post, List<Contact>),
	getById('/contact/byId/:id', HttpMethod.post, Contact),
	getManyByOrgId('/contact/byOrgId/:orgId', HttpMethod.post, List<Contact>),
	getManyByType('/contact/byType/:type', HttpMethod.post, List<Contact>),
	getManyByFullName('/contact/byFullName/:fullName', HttpMethod.post, List<Contact>),
	getManyByEmail('/contact/byEmail/:email', HttpMethod.post, List<Contact>),
	getManyByPhone('/contact/byPhone/:phone', HttpMethod.post, List<Contact>),
	getManyByNotes('/contact/byNotes/:notes', HttpMethod.post, List<Contact>),
	getManyByLocale('/contact/byLocale/:locale', HttpMethod.post, List<Contact>),
	getManyByCurrency('/contact/byCurrency/:currency', HttpMethod.post, List<Contact>),
	getManyByCreatedAt('/contact/byCreatedAt/:createdAt', HttpMethod.post, List<Contact>),
	getManyByUpdatedAt('/contact/byUpdatedAt/:updatedAt', HttpMethod.post, List<Contact>),
	getManyByDeletedAt('/contact/byDeletedAt/:deletedAt', HttpMethod.post, List<Contact>),
	getManyByConsentGivenAt('/contact/byConsentGivenAt/:consentGivenAt', HttpMethod.post, List<Contact>),
	getManyByConsentWithdrawnAt('/contact/byConsentWithdrawnAt/:consentWithdrawnAt', HttpMethod.post, List<Contact>),
	getByDataSubjectId('/contact/byDataSubjectId/:dataSubjectId', HttpMethod.post, Contact);

    const ContactEndpoints(this.path, this.method, this.responseType);

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
