
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AgentStore extends ModelStreamStore<String, Agent> {

  static AgentStore? _instance;

  static AgentStore get instance {
    _instance ??= AgentStore();
    return _instance!;
  }

  AgentStore() : super(Agent.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AgentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AgentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AgentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAgentId(Agent agent) => agent.id;

	String? getAgentName(Agent agent) => agent.name;

	String? getAgentEmail(Agent agent) => agent.email;

	String? getAgentPhoneNumber(Agent agent) => agent.phoneNumber;

	String? getAgentBio(Agent agent) => agent.bio;

	String? getAgentLocationId(Agent agent) => agent.locationId;

	String? getAgentAddress(Agent agent) => agent.address;

	String? getAgentWebsite(Agent agent) => agent.website;

	String? getAgentLogoUrl(Agent agent) => agent.logoUrl;

	SharedStatus? getAgentStatus(Agent agent) => agent.status;

	DateTime? getAgentCreatedAt(Agent agent) => agent.createdAt;

	DateTime? getAgentDeletedAt(Agent agent) => agent.deletedAt;

	DateTime? getAgentUpdatedAt(Agent agent) => agent.updatedAt;

	String? getAgentAgencyId(Agent agent) => agent.agencyId;

	String? getAgentLicenseNumber(Agent agent) => agent.licenseNumber;

	double? getAgentCommissionRate(Agent agent) => agent.commissionRate;

	List<String>? getAgentSpecialties(Agent agent) => agent.specialties;

	List<String>? getAgentServiceAreas(Agent agent) => agent.serviceAreas;

	int? getAgentYearsOfExperience(Agent agent) => agent.yearsOfExperience;

	List<String>? getAgentCertifications(Agent agent) => agent.certifications;

	String? getAgentEducation(Agent agent) => agent.education;

	List<String>? getAgentLanguages(Agent agent) => agent.languages;

	dynamic? getAgentPerformanceMetrics(Agent agent) => agent.performanceMetrics;

	dynamic? getAgentTaxConfiguration(Agent agent) => agent.taxConfiguration;

	dynamic? getAgentAvailability(Agent agent) => agent.availability;

	dynamic? getAgentSocialMedia(Agent agent) => agent.socialMedia;

	List<AgentSpecialities>? getAgentSpecialities(Agent agent) => agent.specialities;

	dynamic? getAgentSettings(Agent agent) => agent.settings;

	String? getAgentExternalId(Agent agent) => agent.externalId;

	dynamic? getAgentIntegration(Agent agent) => agent.integration;

	String? getAgentOwnerId(Agent agent) => agent.ownerId;

	DateTime? getAgentLastActive(Agent agent) => agent.lastActive;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Agent? getByEmail(
    String email,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getIncluding(getAgentEmail, email, modelFilter: modelFilter, includes: includes);

	
Agent? getByExternalId(
    String externalId,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getIncluding(getAgentExternalId, externalId, modelFilter: modelFilter, includes: includes);

  
List<Agent> getByName(
    String name,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentName, name, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByPhoneNumber(
    String phoneNumber,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentPhoneNumber, phoneNumber, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByBio(
    String bio,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentBio, bio, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByLocationId(
    String locationId,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentLocationId, locationId, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByAddress(
    String address,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAddress, address, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByWebsite(
    String website,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentWebsite, website, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByLogoUrl(
    String logoUrl,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentLogoUrl, logoUrl, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByStatus(
    SharedStatus status,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByAgencyId(
    String agencyId,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByLicenseNumber(
    String licenseNumber,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentLicenseNumber, licenseNumber, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByCommissionRate(
    double commissionRate,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentCommissionRate, commissionRate, modelFilter: modelFilter, includes: includes);

	
List<Agent> getBySpecialties(
    String specialties,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentSpecialties, specialties, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByServiceAreas(
    String serviceAreas,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentServiceAreas, serviceAreas, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByYearsOfExperience(
    int yearsOfExperience,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentYearsOfExperience, yearsOfExperience, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByCertifications(
    String certifications,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentCertifications, certifications, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByEducation(
    String education,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentEducation, education, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByLanguages(
    String languages,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentLanguages, languages, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByPerformanceMetrics(
    dynamic performanceMetrics,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceMetrics, performanceMetrics, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByTaxConfiguration(
    dynamic taxConfiguration,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentTaxConfiguration, taxConfiguration, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByAvailability(
    dynamic availability,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAvailability, availability, modelFilter: modelFilter, includes: includes);

	
List<Agent> getBySocialMedia(
    dynamic socialMedia,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentSocialMedia, socialMedia, modelFilter: modelFilter, includes: includes);

	
List<Agent> getBySpecialities(
    AgentSpecialities specialities,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentSpecialities, specialities, modelFilter: modelFilter, includes: includes);

	
List<Agent> getBySettings(
    dynamic settings,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentSettings, settings, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByIntegration(
    dynamic integration,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentIntegration, integration, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByOwnerId(
    String ownerId,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentOwnerId, ownerId, modelFilter: modelFilter, includes: includes);

	
List<Agent> getByLastActive(
    DateTime lastActive,
    {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}
    ) =>
    getManyIncluding(getAgentLastActive, lastActive, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Agent agent, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (agent.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(agent.agencyId!, includes: includes);
        agent.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Location? getLocation(
    Agent agent, {ModelFilter? modelFilter, List<LocationInclude>? includes}) {
    if (agent.locationId == null) {
        return null;
    } else {
        final Location = LocationStore.instance.getById(agent.locationId!, includes: includes);
        agent.Location = Location;
        // setIncludedReferences(Location, includes: includes);
        return Location;
    }
}

	User? getOwner(
    Agent agent, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (agent.ownerId == null) {
        return null;
    } else {
        final Owner = UserStore.instance.getById(agent.ownerId!, includes: includes);
        agent.Owner = Owner;
        // setIncludedReferences(Owner, includes: includes);
        return Owner;
    }
}

  /// GET RELATED MODELS 

  List<Analytics> getAnalytics(
    Agent agent, {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    final Analytics = AnalyticsStore.instance.getByAgentId(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Analytics = Analytics;
    // setIncludedReferencesForList(Analytics, includes: includes);
    return Analytics;
}

	List<ComplianceRecord> getComplianceRecord(
    Agent agent, {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    final ComplianceRecord = ComplianceRecordStore.instance.getByAgentId(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.ComplianceRecord = ComplianceRecord;
    // setIncludedReferencesForList(ComplianceRecord, includes: includes);
    return ComplianceRecord;
}

	List<Language> getLanguage(
    Agent agent, {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}) {
    final language = LanguageStore.instance.getByAgentId(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.language = language;
    // setIncludedReferencesForList(language, includes: includes);
    return language;
}

	List<Notification> getNotification(
    Agent agent, {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    final Notification = NotificationStore.instance.getBy(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Notification = Notification;
    // setIncludedReferencesForList(Notification, includes: includes);
    return Notification;
}

	List<Photo> getPhoto(
    Agent agent, {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    final Photo = PhotoStore.instance.getByAgentId(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Photo = Photo;
    // setIncludedReferencesForList(Photo, includes: includes);
    return Photo;
}

	List<Post> getPost(
    Agent agent, {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    final Post = PostStore.instance.getByAgentId(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Post = Post;
    // setIncludedReferencesForList(Post, includes: includes);
    return Post;
}

	List<Property> getProperty(
    Agent agent, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final Property = PropertyStore.instance.getBy(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Property = Property;
    // setIncludedReferencesForList(Property, includes: includes);
    return Property;
}

	List<Report> getReport(
    Agent agent, {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final Report = ReportStore.instance.getBy(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Report = Report;
    // setIncludedReferencesForList(Report, includes: includes);
    return Report;
}

	List<Reservation> getReservation(
    Agent agent, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final Reservation = ReservationStore.instance.getBy(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Reservation = Reservation;
    // setIncludedReferencesForList(Reservation, includes: includes);
    return Reservation;
}

	List<Review> getReview(
    Agent agent, {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}) {
    final Review = ReviewStore.instance.getBy(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Review = Review;
    // setIncludedReferencesForList(Review, includes: includes);
    return Review;
}

	List<Subscription> getSubscription(
    Agent agent, {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    final Subscription = SubscriptionStore.instance.getBy(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Subscription = Subscription;
    // setIncludedReferencesForList(Subscription, includes: includes);
    return Subscription;
}

	List<Task> getTask(
    Agent agent, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final Task = TaskStore.instance.getBy(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.Task = Task;
    // setIncludedReferencesForList(Task, includes: includes);
    return Task;
}

	List<PropertyPromotion> getPropertyPromotion(
    Agent agent, {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    final PropertyPromotion = PropertyPromotionStore.instance.getByAgentId(agent.$uid!, modelFilter: modelFilter, includes: includes);
    agent.PropertyPromotion = PropertyPromotion;
    // setIncludedReferencesForList(PropertyPromotion, includes: includes);
    return PropertyPromotion;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Agent>> getAll$({bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AgentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Agent?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Agent?> getByEmail$(
        String email,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgentEmail,
        value: email,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getByEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Agent?> getByExternalId$(
        String externalId,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgentExternalId,
        value: externalId,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getByExternalId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Agent>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentName,
        value: name,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByPhoneNumber$(
        String phoneNumber,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentPhoneNumber,
        value: phoneNumber,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByPhoneNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByBio$(
        String bio,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentBio,
        value: bio,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByBio,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByLocationId$(
        String locationId,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentLocationId,
        value: locationId,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByLocationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByAddress$(
        String address,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentAddress,
        value: address,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByWebsite$(
        String website,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentWebsite,
        value: website,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByWebsite,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByLogoUrl$(
        String logoUrl,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentLogoUrl,
        value: logoUrl,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByLogoUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByStatus$(
        SharedStatus status,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<SharedStatus>(
        getPropVal: getAgentStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByLicenseNumber$(
        String licenseNumber,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentLicenseNumber,
        value: licenseNumber,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByLicenseNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByCommissionRate$(
        double commissionRate,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAgentCommissionRate,
        value: commissionRate,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByCommissionRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getBySpecialties$(
        String specialties,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentSpecialties,
        value: specialties,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyBySpecialties,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByServiceAreas$(
        String serviceAreas,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentServiceAreas,
        value: serviceAreas,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByServiceAreas,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByYearsOfExperience$(
        int yearsOfExperience,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgentYearsOfExperience,
        value: yearsOfExperience,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByYearsOfExperience,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByCertifications$(
        String certifications,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentCertifications,
        value: certifications,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByCertifications,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByEducation$(
        String education,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentEducation,
        value: education,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByEducation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByLanguages$(
        String languages,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentLanguages,
        value: languages,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByLanguages,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByPerformanceMetrics$(
        dynamic performanceMetrics,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgentPerformanceMetrics,
        value: performanceMetrics,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByPerformanceMetrics,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByTaxConfiguration$(
        dynamic taxConfiguration,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgentTaxConfiguration,
        value: taxConfiguration,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByTaxConfiguration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByAvailability$(
        dynamic availability,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgentAvailability,
        value: availability,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByAvailability,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getBySocialMedia$(
        dynamic socialMedia,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgentSocialMedia,
        value: socialMedia,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyBySocialMedia,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getBySpecialities$(
        AgentSpecialities specialities,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<AgentSpecialities>(
        getPropVal: getAgentSpecialities,
        value: specialities,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyBySpecialities,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getBySettings$(
        dynamic settings,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgentSettings,
        value: settings,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyBySettings,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByIntegration$(
        dynamic integration,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAgentIntegration,
        value: integration,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByIntegration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByOwnerId$(
        String ownerId,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentOwnerId,
        value: ownerId,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByOwnerId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Agent>> getByLastActive$(
        DateTime lastActive,
        {bool useCache = true,
        ModelFilter<Agent>? modelFilter,
        List<AgentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentLastActive,
        value: lastActive,
        modelFilter: modelFilter,
        endpoint: AgentEndpoints.getManyByLastActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Agent agent, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (agent.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            agent.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            agent.Agency = Agency;
        });
    }
}

	Stream<Location?> getLocation$(
    Agent agent, {bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    if (agent.locationId == null) {
        return Stream.value(null);
    } else {
        return LocationStore.instance.getById$(
            agent.locationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Location) {
            agent.Location = Location;
        });
    }
}

	Stream<User?> getOwner$(
    Agent agent, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (agent.ownerId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            agent.ownerId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Owner) {
            agent.Owner = Owner;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Analytics>> getAnalytics$(
    Agent agent, {bool useCache = true, ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    return AnalyticsStore.instance.getByAgentId$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Analytics) {
        agent.Analytics = Analytics;
    });

}

	Stream<List<ComplianceRecord>> getComplianceRecord$(
    Agent agent, {bool useCache = true, ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    return ComplianceRecordStore.instance.getByAgentId$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((ComplianceRecord) {
        agent.ComplianceRecord = ComplianceRecord;
    });

}

	Stream<List<Language>> getLanguage$(
    Agent agent, {bool useCache = true, ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}) {
    return LanguageStore.instance.getByAgentId$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((language) {
        agent.language = language;
    });

}

	Stream<List<Notification>> getNotification$(
    Agent agent, {bool useCache = true, ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    return NotificationStore.instance.getBy$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Notification) {
        agent.Notification = Notification;
    });

}

	Stream<List<Photo>> getPhoto$(
    Agent agent, {bool useCache = true, ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    return PhotoStore.instance.getByAgentId$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Photo) {
        agent.Photo = Photo;
    });

}

	Stream<List<Post>> getPost$(
    Agent agent, {bool useCache = true, ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    return PostStore.instance.getByAgentId$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Post) {
        agent.Post = Post;
    });

}

	Stream<List<Property>> getProperty$(
    Agent agent, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getBy$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Property) {
        agent.Property = Property;
    });

}

	Stream<List<Report>> getReport$(
    Agent agent, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    return ReportStore.instance.getBy$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Report) {
        agent.Report = Report;
    });

}

	Stream<List<Reservation>> getReservation$(
    Agent agent, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getBy$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Reservation) {
        agent.Reservation = Reservation;
    });

}

	Stream<List<Review>> getReview$(
    Agent agent, {bool useCache = true, ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}) {
    return ReviewStore.instance.getBy$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Review) {
        agent.Review = Review;
    });

}

	Stream<List<Subscription>> getSubscription$(
    Agent agent, {bool useCache = true, ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    return SubscriptionStore.instance.getBy$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Subscription) {
        agent.Subscription = Subscription;
    });

}

	Stream<List<Task>> getTask$(
    Agent agent, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getBy$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Task) {
        agent.Task = Task;
    });

}

	Stream<List<PropertyPromotion>> getPropertyPromotion$(
    Agent agent, {bool useCache = true, ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    return PropertyPromotionStore.instance.getByAgentId$(
        agent.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((PropertyPromotion) {
        agent.PropertyPromotion = PropertyPromotion;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Agent recursiveUpsert(Agent agent, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Agent'} 
        : const {};
    if (agent.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        agent.Agency = AgencyStore.instance.recursiveUpsert(agent.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Location != null && (!preventCircularSerialization || !upsertedTypes.contains('Location'))) {
        agent.Location = LocationStore.instance.recursiveUpsert(agent.Location!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Owner != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        agent.Owner = UserStore.instance.recursiveUpsert(agent.Owner!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Analytics != null && (!preventCircularSerialization || !upsertedTypes.contains('Analytics'))) {
        agent.Analytics = AnalyticsStore.instance.recursiveListUpsert(agent.Analytics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.ComplianceRecord != null && (!preventCircularSerialization || !upsertedTypes.contains('ComplianceRecord'))) {
        agent.ComplianceRecord = ComplianceRecordStore.instance.recursiveListUpsert(agent.ComplianceRecord!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.language != null && (!preventCircularSerialization || !upsertedTypes.contains('Language'))) {
        agent.language = LanguageStore.instance.recursiveListUpsert(agent.language!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Notification != null && (!preventCircularSerialization || !upsertedTypes.contains('Notification'))) {
        agent.Notification = NotificationStore.instance.recursiveListUpsert(agent.Notification!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Photo != null && (!preventCircularSerialization || !upsertedTypes.contains('Photo'))) {
        agent.Photo = PhotoStore.instance.recursiveListUpsert(agent.Photo!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Post != null && (!preventCircularSerialization || !upsertedTypes.contains('Post'))) {
        agent.Post = PostStore.instance.recursiveListUpsert(agent.Post!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        agent.Property = PropertyStore.instance.recursiveListUpsert(agent.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Report != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        agent.Report = ReportStore.instance.recursiveListUpsert(agent.Report!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        agent.Reservation = ReservationStore.instance.recursiveListUpsert(agent.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Review != null && (!preventCircularSerialization || !upsertedTypes.contains('Review'))) {
        agent.Review = ReviewStore.instance.recursiveListUpsert(agent.Review!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Subscription != null && (!preventCircularSerialization || !upsertedTypes.contains('Subscription'))) {
        agent.Subscription = SubscriptionStore.instance.recursiveListUpsert(agent.Subscription!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.Task != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        agent.Task = TaskStore.instance.recursiveListUpsert(agent.Task!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agent.PropertyPromotion != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyPromotion'))) {
        agent.PropertyPromotion = PropertyPromotionStore.instance.recursiveListUpsert(agent.PropertyPromotion!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(agent);
}

  List<Agent> recursiveListUpsert(List<Agent> agents, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAgents = <Agent>[];
    for (var agent in agents) {
        updatedAgents.add(recursiveUpsert(agent, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAgents;
}

//   @override
//   Agent upsert(Agent item) {
//     return recursiveUpsert(item);
//   }

}


class AgentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AgentInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getAgency$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getAgency(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Location({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Location>? modelFilter,
    List<LocationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getLocation$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getLocation(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Owner({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getOwner$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getOwner(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Analytics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Analytics>? modelFilter,
    List<AnalyticsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getAnalytics$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getAnalytics(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.ComplianceRecord({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ComplianceRecord>? modelFilter,
    List<ComplianceRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getComplianceRecord$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getComplianceRecord(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.language({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Language>? modelFilter,
    List<LanguageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getLanguage$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getLanguage(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Notification({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Notification>? modelFilter,
    List<NotificationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getNotification$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getNotification(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Photo({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Photo>? modelFilter,
    List<PhotoInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getPhoto$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getPhoto(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Post({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Post>? modelFilter,
    List<PostInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getPost$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getPost(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getProperty$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getProperty(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Report({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getReport$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getReport(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getReservation$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getReservation(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Review({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Review>? modelFilter,
    List<ReviewInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getReview$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getReview(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Subscription({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Subscription>? modelFilter,
    List<SubscriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getSubscription$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getSubscription(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.Task({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getTask$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getTask(agent, modelFilter: modelFilter, includes: includes);
      }
}

	AgentInclude.PropertyPromotion({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyPromotion>? modelFilter,
    List<PropertyPromotionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agent) => AgentStore.instance
            .getPropertyPromotion$(agent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agent) => AgentStore.instance
            .getPropertyPromotion(agent, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AgentEndpoints implements Endpoint {

    getAll('/agent', HttpMethod.post, List<Agent>),
	getById('/agent/byId/:id', HttpMethod.post, Agent),
	getManyByName('/agent/byName/:name', HttpMethod.post, List<Agent>),
	getByEmail('/agent/byEmail/:email', HttpMethod.post, Agent),
	getManyByPhoneNumber('/agent/byPhoneNumber/:phoneNumber', HttpMethod.post, List<Agent>),
	getManyByBio('/agent/byBio/:bio', HttpMethod.post, List<Agent>),
	getManyByLocationId('/agent/byLocationId/:locationId', HttpMethod.post, List<Agent>),
	getManyByAddress('/agent/byAddress/:address', HttpMethod.post, List<Agent>),
	getManyByWebsite('/agent/byWebsite/:website', HttpMethod.post, List<Agent>),
	getManyByLogoUrl('/agent/byLogoUrl/:logoUrl', HttpMethod.post, List<Agent>),
	getManyByStatus('/agent/byStatus/:status', HttpMethod.post, List<Agent>),
	getManyByCreatedAt('/agent/byCreatedAt/:createdAt', HttpMethod.post, List<Agent>),
	getManyByDeletedAt('/agent/byDeletedAt/:deletedAt', HttpMethod.post, List<Agent>),
	getManyByUpdatedAt('/agent/byUpdatedAt/:updatedAt', HttpMethod.post, List<Agent>),
	getManyByAgencyId('/agent/byAgencyId/:agencyId', HttpMethod.post, List<Agent>),
	getManyByLicenseNumber('/agent/byLicenseNumber/:licenseNumber', HttpMethod.post, List<Agent>),
	getManyByCommissionRate('/agent/byCommissionRate/:commissionRate', HttpMethod.post, List<Agent>),
	getManyBySpecialties('/agent/bySpecialties/:specialties', HttpMethod.post, List<Agent>),
	getManyByServiceAreas('/agent/byServiceAreas/:serviceAreas', HttpMethod.post, List<Agent>),
	getManyByYearsOfExperience('/agent/byYearsOfExperience/:yearsOfExperience', HttpMethod.post, List<Agent>),
	getManyByCertifications('/agent/byCertifications/:certifications', HttpMethod.post, List<Agent>),
	getManyByEducation('/agent/byEducation/:education', HttpMethod.post, List<Agent>),
	getManyByLanguages('/agent/byLanguages/:languages', HttpMethod.post, List<Agent>),
	getManyByPerformanceMetrics('/agent/byPerformanceMetrics/:performanceMetrics', HttpMethod.post, List<Agent>),
	getManyByTaxConfiguration('/agent/byTaxConfiguration/:taxConfiguration', HttpMethod.post, List<Agent>),
	getManyByAvailability('/agent/byAvailability/:availability', HttpMethod.post, List<Agent>),
	getManyBySocialMedia('/agent/bySocialMedia/:socialMedia', HttpMethod.post, List<Agent>),
	getManyBySpecialities('/agent/bySpecialities/:specialities', HttpMethod.post, List<Agent>),
	getManyBySettings('/agent/bySettings/:settings', HttpMethod.post, List<Agent>),
	getByExternalId('/agent/byExternalId/:externalId', HttpMethod.post, Agent),
	getManyByIntegration('/agent/byIntegration/:integration', HttpMethod.post, List<Agent>),
	getManyByOwnerId('/agent/byOwnerId/:ownerId', HttpMethod.post, List<Agent>),
	getManyByLastActive('/agent/byLastActive/:lastActive', HttpMethod.post, List<Agent>);

    const AgentEndpoints(this.path, this.method, this.responseType);

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
