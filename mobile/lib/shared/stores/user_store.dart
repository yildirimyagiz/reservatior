
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class UserStore extends ModelStreamStore<String, User> {

  static UserStore? _instance;

  static UserStore get instance {
    _instance ??= UserStore();
    return _instance!;
  }

  UserStore() : super(User.fromJson) {
    if (_instance != null) {
        throw Exception(
            'UserStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending UserStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use UserStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getUserId(User user) => user.id;

	String? getUserEmail(User user) => user.email;

	String? getUserName(User user) => user.name;

	String? getUserPhone(User user) => user.phone;

	String? getUserLocale(User user) => user.locale;

	String? getUserTimezone(User user) => user.timezone;

	DateTime? getUserCreatedAt(User user) => user.createdAt;

	DateTime? getUserUpdatedAt(User user) => user.updatedAt;

	DateTime? getUserDeletedAt(User user) => user.deletedAt;

	DateTime? getUserGdprConsentAt(User user) => user.gdprConsentAt;

	DateTime? getUserCcpaOptOutAt(User user) => user.ccpaOptOutAt;

	DateTime? getUserDataRetentionUntil(User user) => user.dataRetentionUntil;

	DateTime? getUserAnonymizedAt(User user) => user.anonymizedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
User? getByEmail(
    String email,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getIncluding(getUserEmail, email, modelFilter: modelFilter, includes: includes);

  
List<User> getByName(
    String name,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserName, name, modelFilter: modelFilter, includes: includes);

	
List<User> getByPhone(
    String phone,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserPhone, phone, modelFilter: modelFilter, includes: includes);

	
List<User> getByLocale(
    String locale,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserLocale, locale, modelFilter: modelFilter, includes: includes);

	
List<User> getByTimezone(
    String timezone,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserTimezone, timezone, modelFilter: modelFilter, includes: includes);

	
List<User> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<User> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<User> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<User> getByGdprConsentAt(
    DateTime gdprConsentAt,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserGdprConsentAt, gdprConsentAt, modelFilter: modelFilter, includes: includes);

	
List<User> getByCcpaOptOutAt(
    DateTime ccpaOptOutAt,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserCcpaOptOutAt, ccpaOptOutAt, modelFilter: modelFilter, includes: includes);

	
List<User> getByDataRetentionUntil(
    DateTime dataRetentionUntil,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserDataRetentionUntil, dataRetentionUntil, modelFilter: modelFilter, includes: includes);

	
List<User> getByAnonymizedAt(
    DateTime anonymizedAt,
    {ModelFilter<User>? modelFilter, List<UserInclude>? includes}
    ) =>
    getManyIncluding(getUserAnonymizedAt, anonymizedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  List<Achievement> getAchievements(
    User user, {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}) {
    final achievements = AchievementStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.achievements = achievements;
    // setIncludedReferencesForList(achievements, includes: includes);
    return achievements;
}

	List<AgentAssignment> getAgentAssignments(
    User user, {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}) {
    final agentAssignments = AgentAssignmentStore.instance.getByAgentUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.agentAssignments = agentAssignments;
    // setIncludedReferencesForList(agentAssignments, includes: includes);
    return agentAssignments;
}

	List<AgentPerformance> getAgentPerformance(
    User user, {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}) {
    final agentPerformance = AgentPerformanceStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.agentPerformance = agentPerformance;
    // setIncludedReferencesForList(agentPerformance, includes: includes);
    return agentPerformance;
}

	List<AgentTeam> getAgentTeams(
    User user, {ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}) {
    final agentTeams = AgentTeamStore.instance.getByLeaderId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.agentTeams = agentTeams;
    // setIncludedReferencesForList(agentTeams, includes: includes);
    return agentTeams;
}

	List<AgentTeamMember> getTeamMemberships(
    User user, {ModelFilter<AgentTeamMember>? modelFilter, List<AgentTeamMemberInclude>? includes}) {
    final teamMemberships = AgentTeamMemberStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.teamMemberships = teamMemberships;
    // setIncludedReferencesForList(teamMemberships, includes: includes);
    return teamMemberships;
}

	List<ApiKey> getApiKeys(
    User user, {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}) {
    final apiKeys = ApiKeyStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.apiKeys = apiKeys;
    // setIncludedReferencesForList(apiKeys, includes: includes);
    return apiKeys;
}

	List<ApiToken> getApiTokens(
    User user, {ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}) {
    final apiTokens = ApiTokenStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.apiTokens = apiTokens;
    // setIncludedReferencesForList(apiTokens, includes: includes);
    return apiTokens;
}

	List<Appointment> getAppointments(
    User user, {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    final appointments = AppointmentStore.instance.getByAssignedToUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.appointments = appointments;
    // setIncludedReferencesForList(appointments, includes: includes);
    return appointments;
}

	List<AuditLog> getAuditLogs(
    User user, {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}) {
    final auditLogs = AuditLogStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.auditLogs = auditLogs;
    // setIncludedReferencesForList(auditLogs, includes: includes);
    return auditLogs;
}

	List<Budget> getBudgets(
    User user, {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}) {
    final budgets = BudgetStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.budgets = budgets;
    // setIncludedReferencesForList(budgets, includes: includes);
    return budgets;
}

	List<CalendarEvent> getCalendarEvents(
    User user, {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}) {
    final calendarEvents = CalendarEventStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.calendarEvents = calendarEvents;
    // setIncludedReferencesForList(calendarEvents, includes: includes);
    return calendarEvents;
}

	List<ClientRelationship> getClientRelationships(
    User user, {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}) {
    final clientRelationships = ClientRelationshipStore.instance.getByAgentId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.clientRelationships = clientRelationships;
    // setIncludedReferencesForList(clientRelationships, includes: includes);
    return clientRelationships;
}

	List<DashboardConfiguration> getDashboardConfigurations(
    User user, {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}) {
    final dashboardConfigurations = DashboardConfigurationStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.dashboardConfigurations = dashboardConfigurations;
    // setIncludedReferencesForList(dashboardConfigurations, includes: includes);
    return dashboardConfigurations;
}

	List<DashboardWidget> getDashboardWidgets(
    User user, {ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}) {
    final dashboardWidgets = DashboardWidgetStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.dashboardWidgets = dashboardWidgets;
    // setIncludedReferencesForList(dashboardWidgets, includes: includes);
    return dashboardWidgets;
}

	List<Document> getDocuments(
    User user, {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    final documents = DocumentStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.documents = documents;
    // setIncludedReferencesForList(documents, includes: includes);
    return documents;
}

	List<Earning> getEarnings(
    User user, {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}) {
    final earnings = EarningStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.earnings = earnings;
    // setIncludedReferencesForList(earnings, includes: includes);
    return earnings;
}

	List<EventAttendee> getEventAttendees(
    User user, {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    final eventAttendees = EventAttendeeStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.eventAttendees = eventAttendees;
    // setIncludedReferencesForList(eventAttendees, includes: includes);
    return eventAttendees;
}

	List<GovernmentIntegration> getGovernmentIntegrations(
    User user, {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}) {
    final governmentIntegrations = GovernmentIntegrationStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.governmentIntegrations = governmentIntegrations;
    // setIncludedReferencesForList(governmentIntegrations, includes: includes);
    return governmentIntegrations;
}

	InvestorPortfolio? getInvestorPortfolio(
    User user, {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}) {
    final investorPortfolio = InvestorPortfolioStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.investorPortfolio = investorPortfolio;
    // setIncludedReferences(investorPortfolio, includes: includes);
    return investorPortfolio;
}

	List<Lead> getLeads(
    User user, {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final leads = LeadStore.instance.getByAssignedToUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.leads = leads;
    // setIncludedReferencesForList(leads, includes: includes);
    return leads;
}

	List<LoyaltyAccount> getLoyaltyAccounts(
    User user, {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}) {
    final loyaltyAccounts = LoyaltyAccountStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.loyaltyAccounts = loyaltyAccounts;
    // setIncludedReferencesForList(loyaltyAccounts, includes: includes);
    return loyaltyAccounts;
}

	List<MaintenanceWorkOrder> getWorkOrdersReported(
    User user, {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    final workOrdersReported = MaintenanceWorkOrderStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.workOrdersReported = workOrdersReported;
    // setIncludedReferencesForList(workOrdersReported, includes: includes);
    return workOrdersReported;
}

	List<MaintenanceWorkOrder> getMaintenanceAssigned(
    User user, {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    final maintenanceAssigned = MaintenanceWorkOrderStore.instance.getByAssignedTo(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.maintenanceAssigned = maintenanceAssigned;
    // setIncludedReferencesForList(maintenanceAssigned, includes: includes);
    return maintenanceAssigned;
}

	List<MobileDevice> getMobileDevices(
    User user, {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}) {
    final mobileDevices = MobileDeviceStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.mobileDevices = mobileDevices;
    // setIncludedReferencesForList(mobileDevices, includes: includes);
    return mobileDevices;
}

	List<Notification> getNotifications(
    User user, {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    final notifications = NotificationStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.notifications = notifications;
    // setIncludedReferencesForList(notifications, includes: includes);
    return notifications;
}

	List<OfflineSyncQueue> getOfflineSyncQueues(
    User user, {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}) {
    final offlineSyncQueues = OfflineSyncQueueStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.offlineSyncQueues = offlineSyncQueues;
    // setIncludedReferencesForList(offlineSyncQueues, includes: includes);
    return offlineSyncQueues;
}

	List<Project> getManagedProjects(
    User user, {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    final managedProjects = ProjectStore.instance.getByManagerId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.managedProjects = managedProjects;
    // setIncludedReferencesForList(managedProjects, includes: includes);
    return managedProjects;
}

	List<PropertyCompliance> getPropertyCompliance(
    User user, {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    final propertyCompliance = PropertyComplianceStore.instance.getByInspectorId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.propertyCompliance = propertyCompliance;
    // setIncludedReferencesForList(propertyCompliance, includes: includes);
    return propertyCompliance;
}

	List<PropertyViewing> getAssignedViewings(
    User user, {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    final assignedViewings = PropertyViewingStore.instance.getByAssignedAgentId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.assignedViewings = assignedViewings;
    // setIncludedReferencesForList(assignedViewings, includes: includes);
    return assignedViewings;
}

	List<Referral> getReferrals(
    User user, {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}) {
    final referrals = ReferralStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.referrals = referrals;
    // setIncludedReferencesForList(referrals, includes: includes);
    return referrals;
}

	List<Report> getReports(
    User user, {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final reports = ReportStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.reports = reports;
    // setIncludedReferencesForList(reports, includes: includes);
    return reports;
}

	List<Session> getSessions(
    User user, {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}) {
    final sessions = SessionStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.sessions = sessions;
    // setIncludedReferencesForList(sessions, includes: includes);
    return sessions;
}

	List<SignatureSigner> getSignatureSigners(
    User user, {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    final signatureSigners = SignatureSignerStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.signatureSigners = signatureSigners;
    // setIncludedReferencesForList(signatureSigners, includes: includes);
    return signatureSigners;
}

	List<Task> getTasks(
    User user, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByAssignedToUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<UserActivityLog> getActivityLogs(
    User user, {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}) {
    final activityLogs = UserActivityLogStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.activityLogs = activityLogs;
    // setIncludedReferencesForList(activityLogs, includes: includes);
    return activityLogs;
}

	UserFinancialProfile? getFinancialProfile(
    User user, {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}) {
    final financialProfile = UserFinancialProfileStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.financialProfile = financialProfile;
    // setIncludedReferences(financialProfile, includes: includes);
    return financialProfile;
}

	UserPreference? getPreferences(
    User user, {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}) {
    final preferences = UserPreferenceStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.preferences = preferences;
    // setIncludedReferences(preferences, includes: includes);
    return preferences;
}

	List<ExtraCharge> getExtraCharges(
    User user, {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    final extraCharges = ExtraChargeStore.instance.getBy(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.extraCharges = extraCharges;
    // setIncludedReferencesForList(extraCharges, includes: includes);
    return extraCharges;
}

	List<Currency> getCurrencies(
    User user, {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    final currencies = CurrencyStore.instance.getBy(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.currencies = currencies;
    // setIncludedReferencesForList(currencies, includes: includes);
    return currencies;
}

	List<Agency> getAgencies(
    User user, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getByOwnerId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Agency> getAgencyMemberships(
    User user, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencyMemberships = AgencyStore.instance.getBy(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.agencyMemberships = agencyMemberships;
    // setIncludedReferencesForList(agencyMemberships, includes: includes);
    return agencyMemberships;
}

	List<IncludedService> getIncludedServices(
    User user, {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    final includedServices = IncludedServiceStore.instance.getBy(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.includedServices = includedServices;
    // setIncludedReferencesForList(includedServices, includes: includes);
    return includedServices;
}

	List<Hashtag> getHashtags(
    User user, {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}) {
    final hashtags = HashtagStore.instance.getByCreatedById(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.hashtags = hashtags;
    // setIncludedReferencesForList(hashtags, includes: includes);
    return hashtags;
}

	List<Tenant> getTenants(
    User user, {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    final tenants = TenantStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.tenants = tenants;
    // setIncludedReferencesForList(tenants, includes: includes);
    return tenants;
}

	List<Agent> getAgentOwners(
    User user, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agentOwners = AgentStore.instance.getByOwnerId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.agentOwners = agentOwners;
    // setIncludedReferencesForList(agentOwners, includes: includes);
    return agentOwners;
}

	List<Mention> getMentionsByUser(
    User user, {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    final mentionsByUser = MentionStore.instance.getByMentionedById(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.mentionsByUser = mentionsByUser;
    // setIncludedReferencesForList(mentionsByUser, includes: includes);
    return mentionsByUser;
}

	List<Mention> getMentionsToUser(
    User user, {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    final mentionsToUser = MentionStore.instance.getByMentionedToId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.mentionsToUser = mentionsToUser;
    // setIncludedReferencesForList(mentionsToUser, includes: includes);
    return mentionsToUser;
}

	List<Mention> getMentionsAsGeneric(
    User user, {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    final mentionsAsGeneric = MentionStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.mentionsAsGeneric = mentionsAsGeneric;
    // setIncludedReferencesForList(mentionsAsGeneric, includes: includes);
    return mentionsAsGeneric;
}

	List<PropertyPromotion> getPropertyPromotions(
    User user, {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    final propertyPromotions = PropertyPromotionStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.propertyPromotions = propertyPromotions;
    // setIncludedReferencesForList(propertyPromotions, includes: includes);
    return propertyPromotions;
}

	List<Ticket> getAssignedTickets(
    User user, {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}) {
    final assignedTickets = TicketStore.instance.getByAgentId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.assignedTickets = assignedTickets;
    // setIncludedReferencesForList(assignedTickets, includes: includes);
    return assignedTickets;
}

	List<Ticket> getTickets(
    User user, {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}) {
    final tickets = TicketStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.tickets = tickets;
    // setIncludedReferencesForList(tickets, includes: includes);
    return tickets;
}

	List<Account> getAccounts(
    User user, {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}) {
    final accounts = AccountStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.accounts = accounts;
    // setIncludedReferencesForList(accounts, includes: includes);
    return accounts;
}

	List<CommunicationLog> getCommunicationLogs(
    User user, {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    final communicationLogs = CommunicationLogStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.communicationLogs = communicationLogs;
    // setIncludedReferencesForList(communicationLogs, includes: includes);
    return communicationLogs;
}

	List<Favorite> getFavorites(
    User user, {ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}) {
    final favorites = FavoriteStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.favorites = favorites;
    // setIncludedReferencesForList(favorites, includes: includes);
    return favorites;
}

	List<Language> getLanguages(
    User user, {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}) {
    final languages = LanguageStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.languages = languages;
    // setIncludedReferencesForList(languages, includes: includes);
    return languages;
}

	List<Offer> getOffers(
    User user, {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    final offers = OfferStore.instance.getByGuestId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.offers = offers;
    // setIncludedReferencesForList(offers, includes: includes);
    return offers;
}

	List<Photo> getPhotos(
    User user, {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    final photos = PhotoStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.photos = photos;
    // setIncludedReferencesForList(photos, includes: includes);
    return photos;
}

	List<Post> getPosts(
    User user, {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    final posts = PostStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.posts = posts;
    // setIncludedReferencesForList(posts, includes: includes);
    return posts;
}

	List<Analytics> getAnalytics(
    User user, {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    final analytics = AnalyticsStore.instance.getByUserId(user.$uid!, modelFilter: modelFilter, includes: includes);
    user.analytics = analytics;
    // setIncludedReferencesForList(analytics, includes: includes);
    return analytics;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<User>> getAll$({bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: UserEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<User?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getUserId,
        value: id,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<User?> getByEmail$(
        String email,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getUserEmail,
        value: email,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getByEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<User>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserName,
        value: name,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByPhone$(
        String phone,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserPhone,
        value: phone,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByPhone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByLocale$(
        String locale,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserLocale,
        value: locale,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByLocale,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByTimezone$(
        String timezone,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserTimezone,
        value: timezone,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByTimezone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByGdprConsentAt$(
        DateTime gdprConsentAt,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserGdprConsentAt,
        value: gdprConsentAt,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByGdprConsentAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByCcpaOptOutAt$(
        DateTime ccpaOptOutAt,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserCcpaOptOutAt,
        value: ccpaOptOutAt,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByCcpaOptOutAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByDataRetentionUntil$(
        DateTime dataRetentionUntil,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserDataRetentionUntil,
        value: dataRetentionUntil,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByDataRetentionUntil,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<User>> getByAnonymizedAt$(
        DateTime anonymizedAt,
        {bool useCache = true,
        ModelFilter<User>? modelFilter,
        List<UserInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserAnonymizedAt,
        value: anonymizedAt,
        modelFilter: modelFilter,
        endpoint: UserEndpoints.getManyByAnonymizedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  Stream<List<Achievement>> getAchievements$(
    User user, {bool useCache = true, ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}) {
    return AchievementStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((achievements) {
        user.achievements = achievements;
    });

}

	Stream<List<AgentAssignment>> getAgentAssignments$(
    User user, {bool useCache = true, ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}) {
    return AgentAssignmentStore.instance.getByAgentUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agentAssignments) {
        user.agentAssignments = agentAssignments;
    });

}

	Stream<List<AgentPerformance>> getAgentPerformance$(
    User user, {bool useCache = true, ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}) {
    return AgentPerformanceStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agentPerformance) {
        user.agentPerformance = agentPerformance;
    });

}

	Stream<List<AgentTeam>> getAgentTeams$(
    User user, {bool useCache = true, ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}) {
    return AgentTeamStore.instance.getByLeaderId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agentTeams) {
        user.agentTeams = agentTeams;
    });

}

	Stream<List<AgentTeamMember>> getTeamMemberships$(
    User user, {bool useCache = true, ModelFilter<AgentTeamMember>? modelFilter, List<AgentTeamMemberInclude>? includes}) {
    return AgentTeamMemberStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((teamMemberships) {
        user.teamMemberships = teamMemberships;
    });

}

	Stream<List<ApiKey>> getApiKeys$(
    User user, {bool useCache = true, ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}) {
    return ApiKeyStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((apiKeys) {
        user.apiKeys = apiKeys;
    });

}

	Stream<List<ApiToken>> getApiTokens$(
    User user, {bool useCache = true, ModelFilter<ApiToken>? modelFilter, List<ApiTokenInclude>? includes}) {
    return ApiTokenStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((apiTokens) {
        user.apiTokens = apiTokens;
    });

}

	Stream<List<Appointment>> getAppointments$(
    User user, {bool useCache = true, ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    return AppointmentStore.instance.getByAssignedToUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((appointments) {
        user.appointments = appointments;
    });

}

	Stream<List<AuditLog>> getAuditLogs$(
    User user, {bool useCache = true, ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}) {
    return AuditLogStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((auditLogs) {
        user.auditLogs = auditLogs;
    });

}

	Stream<List<Budget>> getBudgets$(
    User user, {bool useCache = true, ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}) {
    return BudgetStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((budgets) {
        user.budgets = budgets;
    });

}

	Stream<List<CalendarEvent>> getCalendarEvents$(
    User user, {bool useCache = true, ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}) {
    return CalendarEventStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((calendarEvents) {
        user.calendarEvents = calendarEvents;
    });

}

	Stream<List<ClientRelationship>> getClientRelationships$(
    User user, {bool useCache = true, ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}) {
    return ClientRelationshipStore.instance.getByAgentId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((clientRelationships) {
        user.clientRelationships = clientRelationships;
    });

}

	Stream<List<DashboardConfiguration>> getDashboardConfigurations$(
    User user, {bool useCache = true, ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}) {
    return DashboardConfigurationStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((dashboardConfigurations) {
        user.dashboardConfigurations = dashboardConfigurations;
    });

}

	Stream<List<DashboardWidget>> getDashboardWidgets$(
    User user, {bool useCache = true, ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}) {
    return DashboardWidgetStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((dashboardWidgets) {
        user.dashboardWidgets = dashboardWidgets;
    });

}

	Stream<List<Document>> getDocuments$(
    User user, {bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    return DocumentStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((documents) {
        user.documents = documents;
    });

}

	Stream<List<Earning>> getEarnings$(
    User user, {bool useCache = true, ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}) {
    return EarningStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((earnings) {
        user.earnings = earnings;
    });

}

	Stream<List<EventAttendee>> getEventAttendees$(
    User user, {bool useCache = true, ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    return EventAttendeeStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((eventAttendees) {
        user.eventAttendees = eventAttendees;
    });

}

	Stream<List<GovernmentIntegration>> getGovernmentIntegrations$(
    User user, {bool useCache = true, ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}) {
    return GovernmentIntegrationStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((governmentIntegrations) {
        user.governmentIntegrations = governmentIntegrations;
    });

}

	Stream<InvestorPortfolio?> getInvestorPortfolio$(
    User user, {bool useCache = true, ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}) {
    return InvestorPortfolioStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((investorPortfolio) {
        user.investorPortfolio = investorPortfolio;
    });

}

	Stream<List<Lead>> getLeads$(
    User user, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    return LeadStore.instance.getByAssignedToUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leads) {
        user.leads = leads;
    });

}

	Stream<List<LoyaltyAccount>> getLoyaltyAccounts$(
    User user, {bool useCache = true, ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}) {
    return LoyaltyAccountStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((loyaltyAccounts) {
        user.loyaltyAccounts = loyaltyAccounts;
    });

}

	Stream<List<MaintenanceWorkOrder>> getWorkOrdersReported$(
    User user, {bool useCache = true, ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    return MaintenanceWorkOrderStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((workOrdersReported) {
        user.workOrdersReported = workOrdersReported;
    });

}

	Stream<List<MaintenanceWorkOrder>> getMaintenanceAssigned$(
    User user, {bool useCache = true, ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    return MaintenanceWorkOrderStore.instance.getByAssignedTo$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((maintenanceAssigned) {
        user.maintenanceAssigned = maintenanceAssigned;
    });

}

	Stream<List<MobileDevice>> getMobileDevices$(
    User user, {bool useCache = true, ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}) {
    return MobileDeviceStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mobileDevices) {
        user.mobileDevices = mobileDevices;
    });

}

	Stream<List<Notification>> getNotifications$(
    User user, {bool useCache = true, ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    return NotificationStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((notifications) {
        user.notifications = notifications;
    });

}

	Stream<List<OfflineSyncQueue>> getOfflineSyncQueues$(
    User user, {bool useCache = true, ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}) {
    return OfflineSyncQueueStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((offlineSyncQueues) {
        user.offlineSyncQueues = offlineSyncQueues;
    });

}

	Stream<List<Project>> getManagedProjects$(
    User user, {bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    return ProjectStore.instance.getByManagerId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((managedProjects) {
        user.managedProjects = managedProjects;
    });

}

	Stream<List<PropertyCompliance>> getPropertyCompliance$(
    User user, {bool useCache = true, ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    return PropertyComplianceStore.instance.getByInspectorId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyCompliance) {
        user.propertyCompliance = propertyCompliance;
    });

}

	Stream<List<PropertyViewing>> getAssignedViewings$(
    User user, {bool useCache = true, ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    return PropertyViewingStore.instance.getByAssignedAgentId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((assignedViewings) {
        user.assignedViewings = assignedViewings;
    });

}

	Stream<List<Referral>> getReferrals$(
    User user, {bool useCache = true, ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}) {
    return ReferralStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((referrals) {
        user.referrals = referrals;
    });

}

	Stream<List<Report>> getReports$(
    User user, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    return ReportStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reports) {
        user.reports = reports;
    });

}

	Stream<List<Session>> getSessions$(
    User user, {bool useCache = true, ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}) {
    return SessionStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((sessions) {
        user.sessions = sessions;
    });

}

	Stream<List<SignatureSigner>> getSignatureSigners$(
    User user, {bool useCache = true, ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    return SignatureSignerStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((signatureSigners) {
        user.signatureSigners = signatureSigners;
    });

}

	Stream<List<Task>> getTasks$(
    User user, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByAssignedToUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        user.tasks = tasks;
    });

}

	Stream<List<UserActivityLog>> getActivityLogs$(
    User user, {bool useCache = true, ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}) {
    return UserActivityLogStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((activityLogs) {
        user.activityLogs = activityLogs;
    });

}

	Stream<UserFinancialProfile?> getFinancialProfile$(
    User user, {bool useCache = true, ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}) {
    return UserFinancialProfileStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((financialProfile) {
        user.financialProfile = financialProfile;
    });

}

	Stream<UserPreference?> getPreferences$(
    User user, {bool useCache = true, ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}) {
    return UserPreferenceStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((preferences) {
        user.preferences = preferences;
    });

}

	Stream<List<ExtraCharge>> getExtraCharges$(
    User user, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    return ExtraChargeStore.instance.getBy$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((extraCharges) {
        user.extraCharges = extraCharges;
    });

}

	Stream<List<Currency>> getCurrencies$(
    User user, {bool useCache = true, ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    return CurrencyStore.instance.getBy$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((currencies) {
        user.currencies = currencies;
    });

}

	Stream<List<Agency>> getAgencies$(
    User user, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getByOwnerId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        user.agencies = agencies;
    });

}

	Stream<List<Agency>> getAgencyMemberships$(
    User user, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencyMemberships) {
        user.agencyMemberships = agencyMemberships;
    });

}

	Stream<List<IncludedService>> getIncludedServices$(
    User user, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    return IncludedServiceStore.instance.getBy$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((includedServices) {
        user.includedServices = includedServices;
    });

}

	Stream<List<Hashtag>> getHashtags$(
    User user, {bool useCache = true, ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}) {
    return HashtagStore.instance.getByCreatedById$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((hashtags) {
        user.hashtags = hashtags;
    });

}

	Stream<List<Tenant>> getTenants$(
    User user, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    return TenantStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenants) {
        user.tenants = tenants;
    });

}

	Stream<List<Agent>> getAgentOwners$(
    User user, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getByOwnerId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agentOwners) {
        user.agentOwners = agentOwners;
    });

}

	Stream<List<Mention>> getMentionsByUser$(
    User user, {bool useCache = true, ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    return MentionStore.instance.getByMentionedById$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mentionsByUser) {
        user.mentionsByUser = mentionsByUser;
    });

}

	Stream<List<Mention>> getMentionsToUser$(
    User user, {bool useCache = true, ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    return MentionStore.instance.getByMentionedToId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mentionsToUser) {
        user.mentionsToUser = mentionsToUser;
    });

}

	Stream<List<Mention>> getMentionsAsGeneric$(
    User user, {bool useCache = true, ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    return MentionStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mentionsAsGeneric) {
        user.mentionsAsGeneric = mentionsAsGeneric;
    });

}

	Stream<List<PropertyPromotion>> getPropertyPromotions$(
    User user, {bool useCache = true, ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    return PropertyPromotionStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyPromotions) {
        user.propertyPromotions = propertyPromotions;
    });

}

	Stream<List<Ticket>> getAssignedTickets$(
    User user, {bool useCache = true, ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}) {
    return TicketStore.instance.getByAgentId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((assignedTickets) {
        user.assignedTickets = assignedTickets;
    });

}

	Stream<List<Ticket>> getTickets$(
    User user, {bool useCache = true, ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}) {
    return TicketStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tickets) {
        user.tickets = tickets;
    });

}

	Stream<List<Account>> getAccounts$(
    User user, {bool useCache = true, ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}) {
    return AccountStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((accounts) {
        user.accounts = accounts;
    });

}

	Stream<List<CommunicationLog>> getCommunicationLogs$(
    User user, {bool useCache = true, ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    return CommunicationLogStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((communicationLogs) {
        user.communicationLogs = communicationLogs;
    });

}

	Stream<List<Favorite>> getFavorites$(
    User user, {bool useCache = true, ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}) {
    return FavoriteStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((favorites) {
        user.favorites = favorites;
    });

}

	Stream<List<Language>> getLanguages$(
    User user, {bool useCache = true, ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}) {
    return LanguageStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((languages) {
        user.languages = languages;
    });

}

	Stream<List<Offer>> getOffers$(
    User user, {bool useCache = true, ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    return OfferStore.instance.getByGuestId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((offers) {
        user.offers = offers;
    });

}

	Stream<List<Photo>> getPhotos$(
    User user, {bool useCache = true, ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    return PhotoStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((photos) {
        user.photos = photos;
    });

}

	Stream<List<Post>> getPosts$(
    User user, {bool useCache = true, ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    return PostStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((posts) {
        user.posts = posts;
    });

}

	Stream<List<Analytics>> getAnalytics$(
    User user, {bool useCache = true, ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    return AnalyticsStore.instance.getByUserId$(
        user.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analytics) {
        user.analytics = analytics;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
User recursiveUpsert(User user, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'User'} 
        : const {};
    if (user.achievements != null && (!preventCircularSerialization || !upsertedTypes.contains('Achievement'))) {
        user.achievements = AchievementStore.instance.recursiveListUpsert(user.achievements!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.agentAssignments != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentAssignment'))) {
        user.agentAssignments = AgentAssignmentStore.instance.recursiveListUpsert(user.agentAssignments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.agentPerformance != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentPerformance'))) {
        user.agentPerformance = AgentPerformanceStore.instance.recursiveListUpsert(user.agentPerformance!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.agentTeams != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentTeam'))) {
        user.agentTeams = AgentTeamStore.instance.recursiveListUpsert(user.agentTeams!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.teamMemberships != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentTeamMember'))) {
        user.teamMemberships = AgentTeamMemberStore.instance.recursiveListUpsert(user.teamMemberships!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.apiKeys != null && (!preventCircularSerialization || !upsertedTypes.contains('ApiKey'))) {
        user.apiKeys = ApiKeyStore.instance.recursiveListUpsert(user.apiKeys!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.apiTokens != null && (!preventCircularSerialization || !upsertedTypes.contains('ApiToken'))) {
        user.apiTokens = ApiTokenStore.instance.recursiveListUpsert(user.apiTokens!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.appointments != null && (!preventCircularSerialization || !upsertedTypes.contains('Appointment'))) {
        user.appointments = AppointmentStore.instance.recursiveListUpsert(user.appointments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.auditLogs != null && (!preventCircularSerialization || !upsertedTypes.contains('AuditLog'))) {
        user.auditLogs = AuditLogStore.instance.recursiveListUpsert(user.auditLogs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.budgets != null && (!preventCircularSerialization || !upsertedTypes.contains('Budget'))) {
        user.budgets = BudgetStore.instance.recursiveListUpsert(user.budgets!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.calendarEvents != null && (!preventCircularSerialization || !upsertedTypes.contains('CalendarEvent'))) {
        user.calendarEvents = CalendarEventStore.instance.recursiveListUpsert(user.calendarEvents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.clientRelationships != null && (!preventCircularSerialization || !upsertedTypes.contains('ClientRelationship'))) {
        user.clientRelationships = ClientRelationshipStore.instance.recursiveListUpsert(user.clientRelationships!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.dashboardConfigurations != null && (!preventCircularSerialization || !upsertedTypes.contains('DashboardConfiguration'))) {
        user.dashboardConfigurations = DashboardConfigurationStore.instance.recursiveListUpsert(user.dashboardConfigurations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.dashboardWidgets != null && (!preventCircularSerialization || !upsertedTypes.contains('DashboardWidget'))) {
        user.dashboardWidgets = DashboardWidgetStore.instance.recursiveListUpsert(user.dashboardWidgets!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.documents != null && (!preventCircularSerialization || !upsertedTypes.contains('Document'))) {
        user.documents = DocumentStore.instance.recursiveListUpsert(user.documents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.earnings != null && (!preventCircularSerialization || !upsertedTypes.contains('Earning'))) {
        user.earnings = EarningStore.instance.recursiveListUpsert(user.earnings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.eventAttendees != null && (!preventCircularSerialization || !upsertedTypes.contains('EventAttendee'))) {
        user.eventAttendees = EventAttendeeStore.instance.recursiveListUpsert(user.eventAttendees!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.governmentIntegrations != null && (!preventCircularSerialization || !upsertedTypes.contains('GovernmentIntegration'))) {
        user.governmentIntegrations = GovernmentIntegrationStore.instance.recursiveListUpsert(user.governmentIntegrations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.investorPortfolio != null && (!preventCircularSerialization || !upsertedTypes.contains('InvestorPortfolio'))) {
        user.investorPortfolio = InvestorPortfolioStore.instance.recursiveUpsert(user.investorPortfolio!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.leads != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        user.leads = LeadStore.instance.recursiveListUpsert(user.leads!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.loyaltyAccounts != null && (!preventCircularSerialization || !upsertedTypes.contains('LoyaltyAccount'))) {
        user.loyaltyAccounts = LoyaltyAccountStore.instance.recursiveListUpsert(user.loyaltyAccounts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.workOrdersReported != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceWorkOrder'))) {
        user.workOrdersReported = MaintenanceWorkOrderStore.instance.recursiveListUpsert(user.workOrdersReported!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.maintenanceAssigned != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceWorkOrder'))) {
        user.maintenanceAssigned = MaintenanceWorkOrderStore.instance.recursiveListUpsert(user.maintenanceAssigned!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.mobileDevices != null && (!preventCircularSerialization || !upsertedTypes.contains('MobileDevice'))) {
        user.mobileDevices = MobileDeviceStore.instance.recursiveListUpsert(user.mobileDevices!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.notifications != null && (!preventCircularSerialization || !upsertedTypes.contains('Notification'))) {
        user.notifications = NotificationStore.instance.recursiveListUpsert(user.notifications!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.offlineSyncQueues != null && (!preventCircularSerialization || !upsertedTypes.contains('OfflineSyncQueue'))) {
        user.offlineSyncQueues = OfflineSyncQueueStore.instance.recursiveListUpsert(user.offlineSyncQueues!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.managedProjects != null && (!preventCircularSerialization || !upsertedTypes.contains('Project'))) {
        user.managedProjects = ProjectStore.instance.recursiveListUpsert(user.managedProjects!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.propertyCompliance != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyCompliance'))) {
        user.propertyCompliance = PropertyComplianceStore.instance.recursiveListUpsert(user.propertyCompliance!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.assignedViewings != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyViewing'))) {
        user.assignedViewings = PropertyViewingStore.instance.recursiveListUpsert(user.assignedViewings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.referrals != null && (!preventCircularSerialization || !upsertedTypes.contains('Referral'))) {
        user.referrals = ReferralStore.instance.recursiveListUpsert(user.referrals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.reports != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        user.reports = ReportStore.instance.recursiveListUpsert(user.reports!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.sessions != null && (!preventCircularSerialization || !upsertedTypes.contains('Session'))) {
        user.sessions = SessionStore.instance.recursiveListUpsert(user.sessions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.signatureSigners != null && (!preventCircularSerialization || !upsertedTypes.contains('SignatureSigner'))) {
        user.signatureSigners = SignatureSignerStore.instance.recursiveListUpsert(user.signatureSigners!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        user.tasks = TaskStore.instance.recursiveListUpsert(user.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.activityLogs != null && (!preventCircularSerialization || !upsertedTypes.contains('UserActivityLog'))) {
        user.activityLogs = UserActivityLogStore.instance.recursiveListUpsert(user.activityLogs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.financialProfile != null && (!preventCircularSerialization || !upsertedTypes.contains('UserFinancialProfile'))) {
        user.financialProfile = UserFinancialProfileStore.instance.recursiveUpsert(user.financialProfile!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.preferences != null && (!preventCircularSerialization || !upsertedTypes.contains('UserPreference'))) {
        user.preferences = UserPreferenceStore.instance.recursiveUpsert(user.preferences!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.extraCharges != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        user.extraCharges = ExtraChargeStore.instance.recursiveListUpsert(user.extraCharges!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.currencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Currency'))) {
        user.currencies = CurrencyStore.instance.recursiveListUpsert(user.currencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        user.agencies = AgencyStore.instance.recursiveListUpsert(user.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.agencyMemberships != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        user.agencyMemberships = AgencyStore.instance.recursiveListUpsert(user.agencyMemberships!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.includedServices != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        user.includedServices = IncludedServiceStore.instance.recursiveListUpsert(user.includedServices!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.hashtags != null && (!preventCircularSerialization || !upsertedTypes.contains('Hashtag'))) {
        user.hashtags = HashtagStore.instance.recursiveListUpsert(user.hashtags!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.tenants != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        user.tenants = TenantStore.instance.recursiveListUpsert(user.tenants!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.agentOwners != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        user.agentOwners = AgentStore.instance.recursiveListUpsert(user.agentOwners!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.mentionsByUser != null && (!preventCircularSerialization || !upsertedTypes.contains('Mention'))) {
        user.mentionsByUser = MentionStore.instance.recursiveListUpsert(user.mentionsByUser!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.mentionsToUser != null && (!preventCircularSerialization || !upsertedTypes.contains('Mention'))) {
        user.mentionsToUser = MentionStore.instance.recursiveListUpsert(user.mentionsToUser!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.mentionsAsGeneric != null && (!preventCircularSerialization || !upsertedTypes.contains('Mention'))) {
        user.mentionsAsGeneric = MentionStore.instance.recursiveListUpsert(user.mentionsAsGeneric!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.propertyPromotions != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyPromotion'))) {
        user.propertyPromotions = PropertyPromotionStore.instance.recursiveListUpsert(user.propertyPromotions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.assignedTickets != null && (!preventCircularSerialization || !upsertedTypes.contains('Ticket'))) {
        user.assignedTickets = TicketStore.instance.recursiveListUpsert(user.assignedTickets!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.tickets != null && (!preventCircularSerialization || !upsertedTypes.contains('Ticket'))) {
        user.tickets = TicketStore.instance.recursiveListUpsert(user.tickets!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.accounts != null && (!preventCircularSerialization || !upsertedTypes.contains('Account'))) {
        user.accounts = AccountStore.instance.recursiveListUpsert(user.accounts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.communicationLogs != null && (!preventCircularSerialization || !upsertedTypes.contains('CommunicationLog'))) {
        user.communicationLogs = CommunicationLogStore.instance.recursiveListUpsert(user.communicationLogs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.favorites != null && (!preventCircularSerialization || !upsertedTypes.contains('Favorite'))) {
        user.favorites = FavoriteStore.instance.recursiveListUpsert(user.favorites!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.languages != null && (!preventCircularSerialization || !upsertedTypes.contains('Language'))) {
        user.languages = LanguageStore.instance.recursiveListUpsert(user.languages!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.offers != null && (!preventCircularSerialization || !upsertedTypes.contains('Offer'))) {
        user.offers = OfferStore.instance.recursiveListUpsert(user.offers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.photos != null && (!preventCircularSerialization || !upsertedTypes.contains('Photo'))) {
        user.photos = PhotoStore.instance.recursiveListUpsert(user.photos!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.posts != null && (!preventCircularSerialization || !upsertedTypes.contains('Post'))) {
        user.posts = PostStore.instance.recursiveListUpsert(user.posts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (user.analytics != null && (!preventCircularSerialization || !upsertedTypes.contains('Analytics'))) {
        user.analytics = AnalyticsStore.instance.recursiveListUpsert(user.analytics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(user);
}

  List<User> recursiveListUpsert(List<User> users, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedUsers = <User>[];
    for (var user in users) {
        updatedUsers.add(recursiveUpsert(user, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedUsers;
}

//   @override
//   User upsert(User item) {
//     return recursiveUpsert(item);
//   }

}


class UserInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      UserInclude.achievements({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Achievement>? modelFilter,
    List<AchievementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAchievements$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAchievements(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.agentAssignments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentAssignment>? modelFilter,
    List<AgentAssignmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAgentAssignments$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAgentAssignments(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.agentPerformance({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentPerformance>? modelFilter,
    List<AgentPerformanceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAgentPerformance$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAgentPerformance(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.agentTeams({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentTeam>? modelFilter,
    List<AgentTeamInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAgentTeams$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAgentTeams(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.teamMemberships({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentTeamMember>? modelFilter,
    List<AgentTeamMemberInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getTeamMemberships$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getTeamMemberships(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.apiKeys({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ApiKey>? modelFilter,
    List<ApiKeyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getApiKeys$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getApiKeys(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.apiTokens({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ApiToken>? modelFilter,
    List<ApiTokenInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getApiTokens$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getApiTokens(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.appointments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Appointment>? modelFilter,
    List<AppointmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAppointments$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAppointments(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.auditLogs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AuditLog>? modelFilter,
    List<AuditLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAuditLogs$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAuditLogs(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.budgets({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Budget>? modelFilter,
    List<BudgetInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getBudgets$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getBudgets(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.calendarEvents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CalendarEvent>? modelFilter,
    List<CalendarEventInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getCalendarEvents$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getCalendarEvents(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.clientRelationships({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ClientRelationship>? modelFilter,
    List<ClientRelationshipInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getClientRelationships$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getClientRelationships(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.dashboardConfigurations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DashboardConfiguration>? modelFilter,
    List<DashboardConfigurationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getDashboardConfigurations$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getDashboardConfigurations(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.dashboardWidgets({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DashboardWidget>? modelFilter,
    List<DashboardWidgetInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getDashboardWidgets$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getDashboardWidgets(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.documents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Document>? modelFilter,
    List<DocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getDocuments$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getDocuments(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.earnings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Earning>? modelFilter,
    List<EarningInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getEarnings$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getEarnings(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.eventAttendees({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EventAttendee>? modelFilter,
    List<EventAttendeeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getEventAttendees$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getEventAttendees(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.governmentIntegrations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<GovernmentIntegration>? modelFilter,
    List<GovernmentIntegrationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getGovernmentIntegrations$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getGovernmentIntegrations(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.investorPortfolio({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<InvestorPortfolio>? modelFilter,
    List<InvestorPortfolioInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getInvestorPortfolio$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getInvestorPortfolio(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.leads({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getLeads$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getLeads(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.loyaltyAccounts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LoyaltyAccount>? modelFilter,
    List<LoyaltyAccountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getLoyaltyAccounts$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getLoyaltyAccounts(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.workOrdersReported({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceWorkOrder>? modelFilter,
    List<MaintenanceWorkOrderInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getWorkOrdersReported$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getWorkOrdersReported(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.maintenanceAssigned({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceWorkOrder>? modelFilter,
    List<MaintenanceWorkOrderInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getMaintenanceAssigned$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getMaintenanceAssigned(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.mobileDevices({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MobileDevice>? modelFilter,
    List<MobileDeviceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getMobileDevices$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getMobileDevices(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.notifications({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Notification>? modelFilter,
    List<NotificationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getNotifications$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getNotifications(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.offlineSyncQueues({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<OfflineSyncQueue>? modelFilter,
    List<OfflineSyncQueueInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getOfflineSyncQueues$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getOfflineSyncQueues(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.managedProjects({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Project>? modelFilter,
    List<ProjectInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getManagedProjects$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getManagedProjects(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.propertyCompliance({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyCompliance>? modelFilter,
    List<PropertyComplianceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getPropertyCompliance$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getPropertyCompliance(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.assignedViewings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyViewing>? modelFilter,
    List<PropertyViewingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAssignedViewings$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAssignedViewings(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.referrals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Referral>? modelFilter,
    List<ReferralInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getReferrals$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getReferrals(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.reports({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getReports$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getReports(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.sessions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Session>? modelFilter,
    List<SessionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getSessions$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getSessions(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.signatureSigners({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SignatureSigner>? modelFilter,
    List<SignatureSignerInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getSignatureSigners$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getSignatureSigners(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getTasks$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getTasks(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.activityLogs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<UserActivityLog>? modelFilter,
    List<UserActivityLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getActivityLogs$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getActivityLogs(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.financialProfile({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<UserFinancialProfile>? modelFilter,
    List<UserFinancialProfileInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getFinancialProfile$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getFinancialProfile(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.preferences({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<UserPreference>? modelFilter,
    List<UserPreferenceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getPreferences$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getPreferences(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.extraCharges({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getExtraCharges$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getExtraCharges(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.currencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Currency>? modelFilter,
    List<CurrencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getCurrencies$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getCurrencies(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAgencies$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAgencies(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.agencyMemberships({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAgencyMemberships$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAgencyMemberships(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.includedServices({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getIncludedServices$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getIncludedServices(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.hashtags({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Hashtag>? modelFilter,
    List<HashtagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getHashtags$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getHashtags(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.tenants({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getTenants$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getTenants(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.agentOwners({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAgentOwners$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAgentOwners(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.mentionsByUser({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Mention>? modelFilter,
    List<MentionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getMentionsByUser$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getMentionsByUser(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.mentionsToUser({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Mention>? modelFilter,
    List<MentionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getMentionsToUser$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getMentionsToUser(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.mentionsAsGeneric({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Mention>? modelFilter,
    List<MentionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getMentionsAsGeneric$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getMentionsAsGeneric(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.propertyPromotions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyPromotion>? modelFilter,
    List<PropertyPromotionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getPropertyPromotions$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getPropertyPromotions(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.assignedTickets({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Ticket>? modelFilter,
    List<TicketInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAssignedTickets$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAssignedTickets(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.tickets({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Ticket>? modelFilter,
    List<TicketInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getTickets$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getTickets(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.accounts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Account>? modelFilter,
    List<AccountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAccounts$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAccounts(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.communicationLogs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommunicationLog>? modelFilter,
    List<CommunicationLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getCommunicationLogs$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getCommunicationLogs(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.favorites({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Favorite>? modelFilter,
    List<FavoriteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getFavorites$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getFavorites(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.languages({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Language>? modelFilter,
    List<LanguageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getLanguages$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getLanguages(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.offers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Offer>? modelFilter,
    List<OfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getOffers$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getOffers(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.photos({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Photo>? modelFilter,
    List<PhotoInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getPhotos$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getPhotos(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.posts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Post>? modelFilter,
    List<PostInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getPosts$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getPosts(user, modelFilter: modelFilter, includes: includes);
      }
}

	UserInclude.analytics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Analytics>? modelFilter,
    List<AnalyticsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (user) => UserStore.instance
            .getAnalytics$(user, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (user) => UserStore.instance
            .getAnalytics(user, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum UserEndpoints implements Endpoint {

    getAll('/user', HttpMethod.post, List<User>),
	getById('/user/byId/:id', HttpMethod.post, User),
	getByEmail('/user/byEmail/:email', HttpMethod.post, User),
	getManyByName('/user/byName/:name', HttpMethod.post, List<User>),
	getManyByPhone('/user/byPhone/:phone', HttpMethod.post, List<User>),
	getManyByLocale('/user/byLocale/:locale', HttpMethod.post, List<User>),
	getManyByTimezone('/user/byTimezone/:timezone', HttpMethod.post, List<User>),
	getManyByCreatedAt('/user/byCreatedAt/:createdAt', HttpMethod.post, List<User>),
	getManyByUpdatedAt('/user/byUpdatedAt/:updatedAt', HttpMethod.post, List<User>),
	getManyByDeletedAt('/user/byDeletedAt/:deletedAt', HttpMethod.post, List<User>),
	getManyByGdprConsentAt('/user/byGdprConsentAt/:gdprConsentAt', HttpMethod.post, List<User>),
	getManyByCcpaOptOutAt('/user/byCcpaOptOutAt/:ccpaOptOutAt', HttpMethod.post, List<User>),
	getManyByDataRetentionUntil('/user/byDataRetentionUntil/:dataRetentionUntil', HttpMethod.post, List<User>),
	getManyByAnonymizedAt('/user/byAnonymizedAt/:anonymizedAt', HttpMethod.post, List<User>);

    const UserEndpoints(this.path, this.method, this.responseType);

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
