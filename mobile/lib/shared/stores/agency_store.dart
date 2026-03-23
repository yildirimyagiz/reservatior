
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AgencyStore extends ModelStreamStore<String, Agency> {

  static AgencyStore? _instance;

  static AgencyStore get instance {
    _instance ??= AgencyStore();
    return _instance!;
  }

  AgencyStore() : super(Agency.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AgencyStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AgencyStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AgencyStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAgencyId(Agency agency) => agency.id;

	String? getAgencyOrganizationId(Agency agency) => agency.organizationId;

	String? getAgencyName(Agency agency) => agency.name;

	String? getAgencyDescription(Agency agency) => agency.description;

	String? getAgencyEmail(Agency agency) => agency.email;

	String? getAgencyPhoneNumber(Agency agency) => agency.phoneNumber;

	String? getAgencyAddress(Agency agency) => agency.address;

	String? getAgencyWebsite(Agency agency) => agency.website;

	String? getAgencyLogoUrl(Agency agency) => agency.logoUrl;

	SharedStatus? getAgencyStatus(Agency agency) => agency.status;

	DateTime? getAgencyCreatedAt(Agency agency) => agency.createdAt;

	DateTime? getAgencyDeletedAt(Agency agency) => agency.deletedAt;

	DateTime? getAgencyUpdatedAt(Agency agency) => agency.updatedAt;

	String? getAgencyFacilityId(Agency agency) => agency.facilityId;

	String? getAgencyIncludedServiceId(Agency agency) => agency.includedServiceId;

	String? getAgencyExtraChargeId(Agency agency) => agency.extraChargeId;

	bool? getAgencyIsActive(Agency agency) => agency.isActive;

	String? getAgencyOwnerId(Agency agency) => agency.ownerId;

	dynamic? getAgencySettings(Agency agency) => agency.settings;

	String? getAgencyTheme(Agency agency) => agency.theme;

	String? getAgencyExternalId(Agency agency) => agency.externalId;

	dynamic? getAgencyIntegration(Agency agency) => agency.integration;

	int? getAgencyTotalProperties(Agency agency) => agency.totalProperties;

	int? getAgencyTotalAgents(Agency agency) => agency.totalAgents;

	int? getAgencyEstablishedYear(Agency agency) => agency.establishedYear;

	String? getAgencyLicenseNumber(Agency agency) => agency.licenseNumber;

	double? getAgencyCommissionRate(Agency agency) => agency.commissionRate;

	String? getAgencyTaxIdentificationNumber(Agency agency) => agency.taxIdentificationNumber;

	String? getAgencyTaxJurisdiction(Agency agency) => agency.taxJurisdiction;

	dynamic? getAgencyMetrics(Agency agency) => agency.metrics;

	dynamic? getAgencyTaxConfiguration(Agency agency) => agency.taxConfiguration;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Agency? getByExternalId(
    String externalId,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getIncluding(getAgencyExternalId, externalId, modelFilter: modelFilter, includes: includes);

  
List<Agency> getByOrganizationId(
    String organizationId,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyOrganizationId, organizationId, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByName(
    String name,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyName, name, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByDescription(
    String description,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByEmail(
    String email,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyEmail, email, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByPhoneNumber(
    String phoneNumber,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyPhoneNumber, phoneNumber, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByAddress(
    String address,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyAddress, address, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByWebsite(
    String website,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyWebsite, website, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByLogoUrl(
    String logoUrl,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyLogoUrl, logoUrl, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByStatus(
    SharedStatus status,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByFacilityId(
    String facilityId,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyFacilityId, facilityId, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByIncludedServiceId(
    String includedServiceId,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyIncludedServiceId, includedServiceId, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByExtraChargeId(
    String extraChargeId,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyExtraChargeId, extraChargeId, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByIsActive(
    bool isActive,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByOwnerId(
    String ownerId,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyOwnerId, ownerId, modelFilter: modelFilter, includes: includes);

	
List<Agency> getBySettings(
    dynamic settings,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencySettings, settings, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByTheme(
    String theme,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyTheme, theme, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByIntegration(
    dynamic integration,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyIntegration, integration, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByTotalProperties(
    int totalProperties,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyTotalProperties, totalProperties, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByTotalAgents(
    int totalAgents,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyTotalAgents, totalAgents, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByEstablishedYear(
    int establishedYear,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyEstablishedYear, establishedYear, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByLicenseNumber(
    String licenseNumber,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyLicenseNumber, licenseNumber, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByCommissionRate(
    double commissionRate,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyCommissionRate, commissionRate, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByTaxIdentificationNumber(
    String taxIdentificationNumber,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyTaxIdentificationNumber, taxIdentificationNumber, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByTaxJurisdiction(
    String taxJurisdiction,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyTaxJurisdiction, taxJurisdiction, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByMetrics(
    dynamic metrics,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyMetrics, metrics, modelFilter: modelFilter, includes: includes);

	
List<Agency> getByTaxConfiguration(
    dynamic taxConfiguration,
    {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}
    ) =>
    getManyIncluding(getAgencyTaxConfiguration, taxConfiguration, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrganization(
    Agency agency, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (agency.organizationId == null) {
        return null;
    } else {
        final Organization = OrganizationStore.instance.getById(agency.organizationId!, includes: includes);
        agency.Organization = Organization;
        // setIncludedReferences(Organization, includes: includes);
        return Organization;
    }
}

	ExtraCharge? getExtraCharge(
    Agency agency, {ModelFilter? modelFilter, List<ExtraChargeInclude>? includes}) {
    if (agency.extraChargeId == null) {
        return null;
    } else {
        final ExtraCharge = ExtraChargeStore.instance.getById(agency.extraChargeId!, includes: includes);
        agency.ExtraCharge = ExtraCharge;
        // setIncludedReferences(ExtraCharge, includes: includes);
        return ExtraCharge;
    }
}

	Facility? getFacility(
    Agency agency, {ModelFilter? modelFilter, List<FacilityInclude>? includes}) {
    if (agency.facilityId == null) {
        return null;
    } else {
        final Facility = FacilityStore.instance.getById(agency.facilityId!, includes: includes);
        agency.Facility = Facility;
        // setIncludedReferences(Facility, includes: includes);
        return Facility;
    }
}

	IncludedService? getIncludedService(
    Agency agency, {ModelFilter? modelFilter, List<IncludedServiceInclude>? includes}) {
    if (agency.includedServiceId == null) {
        return null;
    } else {
        final IncludedService = IncludedServiceStore.instance.getById(agency.includedServiceId!, includes: includes);
        agency.IncludedService = IncludedService;
        // setIncludedReferences(IncludedService, includes: includes);
        return IncludedService;
    }
}

	User? getOwner(
    Agency agency, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (agency.ownerId == null) {
        return null;
    } else {
        final Owner = UserStore.instance.getById(agency.ownerId!, includes: includes);
        agency.Owner = Owner;
        // setIncludedReferences(Owner, includes: includes);
        return Owner;
    }
}

  /// GET RELATED MODELS 

  List<Agent> getAgent(
    Agency agency, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final Agent = AgentStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Agent = Agent;
    // setIncludedReferencesForList(Agent, includes: includes);
    return Agent;
}

	List<Analytics> getAnalytics(
    Agency agency, {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    final Analytics = AnalyticsStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Analytics = Analytics;
    // setIncludedReferencesForList(Analytics, includes: includes);
    return Analytics;
}

	List<Organization> getAgencyRelations(
    Agency agency, {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    final AgencyRelations = OrganizationStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.AgencyRelations = AgencyRelations;
    // setIncludedReferencesForList(AgencyRelations, includes: includes);
    return AgencyRelations;
}

	List<Organization> getOrganizationAgencies(
    Agency agency, {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    final OrganizationAgencies = OrganizationStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.OrganizationAgencies = OrganizationAgencies;
    // setIncludedReferencesForList(OrganizationAgencies, includes: includes);
    return OrganizationAgencies;
}

	List<CommunicationLog> getCommunicationLog(
    Agency agency, {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    final CommunicationLog = CommunicationLogStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.CommunicationLog = CommunicationLog;
    // setIncludedReferencesForList(CommunicationLog, includes: includes);
    return CommunicationLog;
}

	List<ComplianceRecord> getComplianceRecord(
    Agency agency, {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    final ComplianceRecord = ComplianceRecordStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.ComplianceRecord = ComplianceRecord;
    // setIncludedReferencesForList(ComplianceRecord, includes: includes);
    return ComplianceRecord;
}

	List<Contract> getContract(
    Agency agency, {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    final Contract = ContractStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Contract = Contract;
    // setIncludedReferencesForList(Contract, includes: includes);
    return Contract;
}

	List<Expense> getExpense(
    Agency agency, {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    final Expense = ExpenseStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Expense = Expense;
    // setIncludedReferencesForList(Expense, includes: includes);
    return Expense;
}

	List<Guest> getGuest(
    Agency agency, {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}) {
    final Guest = GuestStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Guest = Guest;
    // setIncludedReferencesForList(Guest, includes: includes);
    return Guest;
}

	List<Hashtag> getHashtag(
    Agency agency, {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}) {
    final Hashtag = HashtagStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Hashtag = Hashtag;
    // setIncludedReferencesForList(Hashtag, includes: includes);
    return Hashtag;
}

	List<Language> getLanguage(
    Agency agency, {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}) {
    final Language = LanguageStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Language = Language;
    // setIncludedReferencesForList(Language, includes: includes);
    return Language;
}

	List<Location> getLocation(
    Agency agency, {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    final location = LocationStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.location = location;
    // setIncludedReferencesForList(location, includes: includes);
    return location;
}

	List<Mention> getMention(
    Agency agency, {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    final Mention = MentionStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Mention = Mention;
    // setIncludedReferencesForList(Mention, includes: includes);
    return Mention;
}

	List<Notification> getNotification(
    Agency agency, {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    final Notification = NotificationStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Notification = Notification;
    // setIncludedReferencesForList(Notification, includes: includes);
    return Notification;
}

	List<Photo> getPhoto(
    Agency agency, {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    final Photo = PhotoStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Photo = Photo;
    // setIncludedReferencesForList(Photo, includes: includes);
    return Photo;
}

	List<Post> getPost(
    Agency agency, {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    final Post = PostStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Post = Post;
    // setIncludedReferencesForList(Post, includes: includes);
    return Post;
}

	List<Property> getProperty(
    Agency agency, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final Property = PropertyStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Property = Property;
    // setIncludedReferencesForList(Property, includes: includes);
    return Property;
}

	List<Report> getReport(
    Agency agency, {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final Report = ReportStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Report = Report;
    // setIncludedReferencesForList(Report, includes: includes);
    return Report;
}

	List<Reservation> getReservation(
    Agency agency, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final Reservation = ReservationStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Reservation = Reservation;
    // setIncludedReferencesForList(Reservation, includes: includes);
    return Reservation;
}

	List<Review> getReview(
    Agency agency, {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}) {
    final Review = ReviewStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Review = Review;
    // setIncludedReferencesForList(Review, includes: includes);
    return Review;
}

	List<Subscription> getSubscription(
    Agency agency, {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    final Subscription = SubscriptionStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Subscription = Subscription;
    // setIncludedReferencesForList(Subscription, includes: includes);
    return Subscription;
}

	List<Task> getTask(
    Agency agency, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final Task = TaskStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.Task = Task;
    // setIncludedReferencesForList(Task, includes: includes);
    return Task;
}

	List<User> getUser(
    Agency agency, {ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    final User = UserStore.instance.getBy(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.User = User;
    // setIncludedReferencesForList(User, includes: includes);
    return User;
}

	List<PropertyPromotion> getPropertyPromotion(
    Agency agency, {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    final PropertyPromotion = PropertyPromotionStore.instance.getByAgencyId(agency.$uid!, modelFilter: modelFilter, includes: includes);
    agency.PropertyPromotion = PropertyPromotion;
    // setIncludedReferencesForList(PropertyPromotion, includes: includes);
    return PropertyPromotion;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Agency>> getAll$({bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AgencyEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Agency?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgencyId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Agency?> getByExternalId$(
        String externalId,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgencyExternalId,
        value: externalId,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getByExternalId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Agency>> getByOrganizationId$(
        String organizationId,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyOrganizationId,
        value: organizationId,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByOrganizationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyName,
        value: name,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByEmail$(
        String email,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyEmail,
        value: email,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByPhoneNumber$(
        String phoneNumber,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyPhoneNumber,
        value: phoneNumber,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByPhoneNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByAddress$(
        String address,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyAddress,
        value: address,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByWebsite$(
        String website,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyWebsite,
        value: website,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByWebsite,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByLogoUrl$(
        String logoUrl,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyLogoUrl,
        value: logoUrl,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByLogoUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByStatus$(
        SharedStatus status,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<SharedStatus>(
        getPropVal: getAgencyStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgencyCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgencyDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgencyUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByFacilityId$(
        String facilityId,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyFacilityId,
        value: facilityId,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByFacilityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByIncludedServiceId$(
        String includedServiceId,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyIncludedServiceId,
        value: includedServiceId,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByIncludedServiceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByExtraChargeId$(
        String extraChargeId,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyExtraChargeId,
        value: extraChargeId,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByExtraChargeId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAgencyIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByOwnerId$(
        String ownerId,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyOwnerId,
        value: ownerId,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByOwnerId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getBySettings$(
        dynamic settings,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgencySettings,
        value: settings,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyBySettings,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByTheme$(
        String theme,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyTheme,
        value: theme,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByTheme,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByIntegration$(
        dynamic integration,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgencyIntegration,
        value: integration,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByIntegration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByTotalProperties$(
        int totalProperties,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgencyTotalProperties,
        value: totalProperties,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByTotalProperties,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByTotalAgents$(
        int totalAgents,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgencyTotalAgents,
        value: totalAgents,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByTotalAgents,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByEstablishedYear$(
        int establishedYear,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgencyEstablishedYear,
        value: establishedYear,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByEstablishedYear,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByLicenseNumber$(
        String licenseNumber,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyLicenseNumber,
        value: licenseNumber,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByLicenseNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByCommissionRate$(
        double commissionRate,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAgencyCommissionRate,
        value: commissionRate,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByCommissionRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByTaxIdentificationNumber$(
        String taxIdentificationNumber,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyTaxIdentificationNumber,
        value: taxIdentificationNumber,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByTaxIdentificationNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByTaxJurisdiction$(
        String taxJurisdiction,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgencyTaxJurisdiction,
        value: taxJurisdiction,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByTaxJurisdiction,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByMetrics$(
        dynamic metrics,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgencyMetrics,
        value: metrics,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByMetrics,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agency>> getByTaxConfiguration$(
        dynamic taxConfiguration,
        {bool useCache = true,
        ModelFilter<Agency>? modelFilter,
        List<AgencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgencyTaxConfiguration,
        value: taxConfiguration,
        modelFilter: modelFilter,
        endpoint: AgencyEndpoints.getManyByTaxConfiguration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrganization$(
    Agency agency, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (agency.organizationId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            agency.organizationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Organization) {
            agency.Organization = Organization;
        });
    }
}

	Stream<ExtraCharge?> getExtraCharge$(
    Agency agency, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    if (agency.extraChargeId == null) {
        return Stream.value(null);
    } else {
        return ExtraChargeStore.instance.getById$(
            agency.extraChargeId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((ExtraCharge) {
            agency.ExtraCharge = ExtraCharge;
        });
    }
}

	Stream<Facility?> getFacility$(
    Agency agency, {bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    if (agency.facilityId == null) {
        return Stream.value(null);
    } else {
        return FacilityStore.instance.getById$(
            agency.facilityId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Facility) {
            agency.Facility = Facility;
        });
    }
}

	Stream<IncludedService?> getIncludedService$(
    Agency agency, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    if (agency.includedServiceId == null) {
        return Stream.value(null);
    } else {
        return IncludedServiceStore.instance.getById$(
            agency.includedServiceId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((IncludedService) {
            agency.IncludedService = IncludedService;
        });
    }
}

	Stream<User?> getOwner$(
    Agency agency, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (agency.ownerId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            agency.ownerId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Owner) {
            agency.Owner = Owner;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Agent>> getAgent$(
    Agency agency, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Agent) {
        agency.Agent = Agent;
    });

}

	Stream<List<Analytics>> getAnalytics$(
    Agency agency, {bool useCache = true, ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    return AnalyticsStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Analytics) {
        agency.Analytics = Analytics;
    });

}

	Stream<List<Organization>> getAgencyRelations$(
    Agency agency, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    return OrganizationStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((AgencyRelations) {
        agency.AgencyRelations = AgencyRelations;
    });

}

	Stream<List<Organization>> getOrganizationAgencies$(
    Agency agency, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    return OrganizationStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((OrganizationAgencies) {
        agency.OrganizationAgencies = OrganizationAgencies;
    });

}

	Stream<List<CommunicationLog>> getCommunicationLog$(
    Agency agency, {bool useCache = true, ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    return CommunicationLogStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((CommunicationLog) {
        agency.CommunicationLog = CommunicationLog;
    });

}

	Stream<List<ComplianceRecord>> getComplianceRecord$(
    Agency agency, {bool useCache = true, ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    return ComplianceRecordStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((ComplianceRecord) {
        agency.ComplianceRecord = ComplianceRecord;
    });

}

	Stream<List<Contract>> getContract$(
    Agency agency, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    return ContractStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Contract) {
        agency.Contract = Contract;
    });

}

	Stream<List<Expense>> getExpense$(
    Agency agency, {bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    return ExpenseStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Expense) {
        agency.Expense = Expense;
    });

}

	Stream<List<Guest>> getGuest$(
    Agency agency, {bool useCache = true, ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}) {
    return GuestStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Guest) {
        agency.Guest = Guest;
    });

}

	Stream<List<Hashtag>> getHashtag$(
    Agency agency, {bool useCache = true, ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}) {
    return HashtagStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Hashtag) {
        agency.Hashtag = Hashtag;
    });

}

	Stream<List<Language>> getLanguage$(
    Agency agency, {bool useCache = true, ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}) {
    return LanguageStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Language) {
        agency.Language = Language;
    });

}

	Stream<List<Location>> getLocation$(
    Agency agency, {bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    return LocationStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((location) {
        agency.location = location;
    });

}

	Stream<List<Mention>> getMention$(
    Agency agency, {bool useCache = true, ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    return MentionStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Mention) {
        agency.Mention = Mention;
    });

}

	Stream<List<Notification>> getNotification$(
    Agency agency, {bool useCache = true, ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    return NotificationStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Notification) {
        agency.Notification = Notification;
    });

}

	Stream<List<Photo>> getPhoto$(
    Agency agency, {bool useCache = true, ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    return PhotoStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Photo) {
        agency.Photo = Photo;
    });

}

	Stream<List<Post>> getPost$(
    Agency agency, {bool useCache = true, ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    return PostStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Post) {
        agency.Post = Post;
    });

}

	Stream<List<Property>> getProperty$(
    Agency agency, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Property) {
        agency.Property = Property;
    });

}

	Stream<List<Report>> getReport$(
    Agency agency, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    return ReportStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Report) {
        agency.Report = Report;
    });

}

	Stream<List<Reservation>> getReservation$(
    Agency agency, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Reservation) {
        agency.Reservation = Reservation;
    });

}

	Stream<List<Review>> getReview$(
    Agency agency, {bool useCache = true, ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}) {
    return ReviewStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Review) {
        agency.Review = Review;
    });

}

	Stream<List<Subscription>> getSubscription$(
    Agency agency, {bool useCache = true, ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    return SubscriptionStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Subscription) {
        agency.Subscription = Subscription;
    });

}

	Stream<List<Task>> getTask$(
    Agency agency, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Task) {
        agency.Task = Task;
    });

}

	Stream<List<User>> getUser$(
    Agency agency, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    return UserStore.instance.getBy$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((User) {
        agency.User = User;
    });

}

	Stream<List<PropertyPromotion>> getPropertyPromotion$(
    Agency agency, {bool useCache = true, ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    return PropertyPromotionStore.instance.getByAgencyId$(
        agency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((PropertyPromotion) {
        agency.PropertyPromotion = PropertyPromotion;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Agency recursiveUpsert(Agency agency, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Agency'} 
        : const {};
    if (agency.Organization != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        agency.Organization = OrganizationStore.instance.recursiveUpsert(agency.Organization!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.ExtraCharge != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        agency.ExtraCharge = ExtraChargeStore.instance.recursiveUpsert(agency.ExtraCharge!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Facility != null && (!preventCircularSerialization || !upsertedTypes.contains('Facility'))) {
        agency.Facility = FacilityStore.instance.recursiveUpsert(agency.Facility!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.IncludedService != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        agency.IncludedService = IncludedServiceStore.instance.recursiveUpsert(agency.IncludedService!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Owner != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        agency.Owner = UserStore.instance.recursiveUpsert(agency.Owner!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Agent != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        agency.Agent = AgentStore.instance.recursiveListUpsert(agency.Agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Analytics != null && (!preventCircularSerialization || !upsertedTypes.contains('Analytics'))) {
        agency.Analytics = AnalyticsStore.instance.recursiveListUpsert(agency.Analytics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.AgencyRelations != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        agency.AgencyRelations = OrganizationStore.instance.recursiveListUpsert(agency.AgencyRelations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.OrganizationAgencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        agency.OrganizationAgencies = OrganizationStore.instance.recursiveListUpsert(agency.OrganizationAgencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.CommunicationLog != null && (!preventCircularSerialization || !upsertedTypes.contains('CommunicationLog'))) {
        agency.CommunicationLog = CommunicationLogStore.instance.recursiveListUpsert(agency.CommunicationLog!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.ComplianceRecord != null && (!preventCircularSerialization || !upsertedTypes.contains('ComplianceRecord'))) {
        agency.ComplianceRecord = ComplianceRecordStore.instance.recursiveListUpsert(agency.ComplianceRecord!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Contract != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        agency.Contract = ContractStore.instance.recursiveListUpsert(agency.Contract!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Expense != null && (!preventCircularSerialization || !upsertedTypes.contains('Expense'))) {
        agency.Expense = ExpenseStore.instance.recursiveListUpsert(agency.Expense!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Guest != null && (!preventCircularSerialization || !upsertedTypes.contains('Guest'))) {
        agency.Guest = GuestStore.instance.recursiveListUpsert(agency.Guest!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Hashtag != null && (!preventCircularSerialization || !upsertedTypes.contains('Hashtag'))) {
        agency.Hashtag = HashtagStore.instance.recursiveListUpsert(agency.Hashtag!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Language != null && (!preventCircularSerialization || !upsertedTypes.contains('Language'))) {
        agency.Language = LanguageStore.instance.recursiveListUpsert(agency.Language!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.location != null && (!preventCircularSerialization || !upsertedTypes.contains('Location'))) {
        agency.location = LocationStore.instance.recursiveListUpsert(agency.location!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Mention != null && (!preventCircularSerialization || !upsertedTypes.contains('Mention'))) {
        agency.Mention = MentionStore.instance.recursiveListUpsert(agency.Mention!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Notification != null && (!preventCircularSerialization || !upsertedTypes.contains('Notification'))) {
        agency.Notification = NotificationStore.instance.recursiveListUpsert(agency.Notification!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Photo != null && (!preventCircularSerialization || !upsertedTypes.contains('Photo'))) {
        agency.Photo = PhotoStore.instance.recursiveListUpsert(agency.Photo!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Post != null && (!preventCircularSerialization || !upsertedTypes.contains('Post'))) {
        agency.Post = PostStore.instance.recursiveListUpsert(agency.Post!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        agency.Property = PropertyStore.instance.recursiveListUpsert(agency.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Report != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        agency.Report = ReportStore.instance.recursiveListUpsert(agency.Report!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        agency.Reservation = ReservationStore.instance.recursiveListUpsert(agency.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Review != null && (!preventCircularSerialization || !upsertedTypes.contains('Review'))) {
        agency.Review = ReviewStore.instance.recursiveListUpsert(agency.Review!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Subscription != null && (!preventCircularSerialization || !upsertedTypes.contains('Subscription'))) {
        agency.Subscription = SubscriptionStore.instance.recursiveListUpsert(agency.Subscription!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.Task != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        agency.Task = TaskStore.instance.recursiveListUpsert(agency.Task!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        agency.User = UserStore.instance.recursiveListUpsert(agency.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agency.PropertyPromotion != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyPromotion'))) {
        agency.PropertyPromotion = PropertyPromotionStore.instance.recursiveListUpsert(agency.PropertyPromotion!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(agency);
}

  List<Agency> recursiveListUpsert(List<Agency> agencys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAgencys = <Agency>[];
    for (var agency in agencys) {
        updatedAgencys.add(recursiveUpsert(agency, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAgencys;
}

//   @override
//   Agency upsert(Agency item) {
//     return recursiveUpsert(item);
//   }

}


class AgencyInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AgencyInclude.Organization({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getOrganization$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getOrganization(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.ExtraCharge({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getExtraCharge$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getExtraCharge(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Facility({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Facility>? modelFilter,
    List<FacilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getFacility$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getFacility(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.IncludedService({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getIncludedService$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getIncludedService(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Owner({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getOwner$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getOwner(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getAgent$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getAgent(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Analytics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Analytics>? modelFilter,
    List<AnalyticsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getAnalytics$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getAnalytics(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.AgencyRelations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getAgencyRelations$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getAgencyRelations(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.OrganizationAgencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getOrganizationAgencies$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getOrganizationAgencies(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.CommunicationLog({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommunicationLog>? modelFilter,
    List<CommunicationLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getCommunicationLog$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getCommunicationLog(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.ComplianceRecord({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ComplianceRecord>? modelFilter,
    List<ComplianceRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getComplianceRecord$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getComplianceRecord(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Contract({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getContract$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getContract(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Expense({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Expense>? modelFilter,
    List<ExpenseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getExpense$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getExpense(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Guest({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Guest>? modelFilter,
    List<GuestInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getGuest$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getGuest(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Hashtag({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Hashtag>? modelFilter,
    List<HashtagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getHashtag$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getHashtag(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Language({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Language>? modelFilter,
    List<LanguageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getLanguage$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getLanguage(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.location({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Location>? modelFilter,
    List<LocationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getLocation$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getLocation(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Mention({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Mention>? modelFilter,
    List<MentionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getMention$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getMention(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Notification({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Notification>? modelFilter,
    List<NotificationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getNotification$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getNotification(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Photo({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Photo>? modelFilter,
    List<PhotoInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getPhoto$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getPhoto(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Post({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Post>? modelFilter,
    List<PostInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getPost$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getPost(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getProperty$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getProperty(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Report({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getReport$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getReport(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getReservation$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getReservation(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Review({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Review>? modelFilter,
    List<ReviewInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getReview$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getReview(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Subscription({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Subscription>? modelFilter,
    List<SubscriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getSubscription$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getSubscription(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.Task({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getTask$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getTask(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getUser$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getUser(agency, modelFilter: modelFilter, includes: includes);
      }
}

	AgencyInclude.PropertyPromotion({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyPromotion>? modelFilter,
    List<PropertyPromotionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agency) => AgencyStore.instance
            .getPropertyPromotion$(agency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agency) => AgencyStore.instance
            .getPropertyPromotion(agency, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AgencyEndpoints implements Endpoint {

    getAll('/agency', HttpMethod.post, List<Agency>),
	getById('/agency/byId/:id', HttpMethod.post, Agency),
	getManyByOrganizationId('/agency/byOrganizationId/:organizationId', HttpMethod.post, List<Agency>),
	getManyByName('/agency/byName/:name', HttpMethod.post, List<Agency>),
	getManyByDescription('/agency/byDescription/:description', HttpMethod.post, List<Agency>),
	getManyByEmail('/agency/byEmail/:email', HttpMethod.post, List<Agency>),
	getManyByPhoneNumber('/agency/byPhoneNumber/:phoneNumber', HttpMethod.post, List<Agency>),
	getManyByAddress('/agency/byAddress/:address', HttpMethod.post, List<Agency>),
	getManyByWebsite('/agency/byWebsite/:website', HttpMethod.post, List<Agency>),
	getManyByLogoUrl('/agency/byLogoUrl/:logoUrl', HttpMethod.post, List<Agency>),
	getManyByStatus('/agency/byStatus/:status', HttpMethod.post, List<Agency>),
	getManyByCreatedAt('/agency/byCreatedAt/:createdAt', HttpMethod.post, List<Agency>),
	getManyByDeletedAt('/agency/byDeletedAt/:deletedAt', HttpMethod.post, List<Agency>),
	getManyByUpdatedAt('/agency/byUpdatedAt/:updatedAt', HttpMethod.post, List<Agency>),
	getManyByFacilityId('/agency/byFacilityId/:facilityId', HttpMethod.post, List<Agency>),
	getManyByIncludedServiceId('/agency/byIncludedServiceId/:includedServiceId', HttpMethod.post, List<Agency>),
	getManyByExtraChargeId('/agency/byExtraChargeId/:extraChargeId', HttpMethod.post, List<Agency>),
	getManyByIsActive('/agency/byIsActive/:isActive', HttpMethod.post, List<Agency>),
	getManyByOwnerId('/agency/byOwnerId/:ownerId', HttpMethod.post, List<Agency>),
	getManyBySettings('/agency/bySettings/:settings', HttpMethod.post, List<Agency>),
	getManyByTheme('/agency/byTheme/:theme', HttpMethod.post, List<Agency>),
	getByExternalId('/agency/byExternalId/:externalId', HttpMethod.post, Agency),
	getManyByIntegration('/agency/byIntegration/:integration', HttpMethod.post, List<Agency>),
	getManyByTotalProperties('/agency/byTotalProperties/:totalProperties', HttpMethod.post, List<Agency>),
	getManyByTotalAgents('/agency/byTotalAgents/:totalAgents', HttpMethod.post, List<Agency>),
	getManyByEstablishedYear('/agency/byEstablishedYear/:establishedYear', HttpMethod.post, List<Agency>),
	getManyByLicenseNumber('/agency/byLicenseNumber/:licenseNumber', HttpMethod.post, List<Agency>),
	getManyByCommissionRate('/agency/byCommissionRate/:commissionRate', HttpMethod.post, List<Agency>),
	getManyByTaxIdentificationNumber('/agency/byTaxIdentificationNumber/:taxIdentificationNumber', HttpMethod.post, List<Agency>),
	getManyByTaxJurisdiction('/agency/byTaxJurisdiction/:taxJurisdiction', HttpMethod.post, List<Agency>),
	getManyByMetrics('/agency/byMetrics/:metrics', HttpMethod.post, List<Agency>),
	getManyByTaxConfiguration('/agency/byTaxConfiguration/:taxConfiguration', HttpMethod.post, List<Agency>);

    const AgencyEndpoints(this.path, this.method, this.responseType);

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
