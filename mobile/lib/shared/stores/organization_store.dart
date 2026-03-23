
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class OrganizationStore extends ModelStreamStore<String, Organization> {

  static OrganizationStore? _instance;

  static OrganizationStore get instance {
    _instance ??= OrganizationStore();
    return _instance!;
  }

  OrganizationStore() : super(Organization.fromJson) {
    if (_instance != null) {
        throw Exception(
            'OrganizationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending OrganizationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use OrganizationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getOrganizationId(Organization organization) => organization.id;

	String? getOrganizationName(Organization organization) => organization.name;

	OrgType? getOrganizationType(Organization organization) => organization.type;

	Region? getOrganizationRegion(Organization organization) => organization.region;

	String? getOrganizationDefaultCurrency(Organization organization) => organization.defaultCurrency;

	String? getOrganizationDefaultLocale(Organization organization) => organization.defaultLocale;

	String? getOrganizationLegalName(Organization organization) => organization.legalName;

	String? getOrganizationTaxId(Organization organization) => organization.taxId;

	String? getOrganizationAddress(Organization organization) => organization.address;

	String? getOrganizationContactEmail(Organization organization) => organization.contactEmail;

	ManagementFeeType? getOrganizationManagementFeeType(Organization organization) => organization.managementFeeType;

	double? getOrganizationManagementFeeRate(Organization organization) => organization.managementFeeRate;

	double? getOrganizationManagementFeeAmount(Organization organization) => organization.managementFeeAmount;

	ManagementFeeScope? getOrganizationManagementFeeScope(Organization organization) => organization.managementFeeScope;

	bool? getOrganizationTaxReportingEnabled(Organization organization) => organization.taxReportingEnabled;

	bool? getOrganizationComplianceTracking(Organization organization) => organization.complianceTracking;

	List<ComplianceType>? getOrganizationRequiredInspections(Organization organization) => organization.requiredInspections;

	DateTime? getOrganizationCreatedAt(Organization organization) => organization.createdAt;

	DateTime? getOrganizationUpdatedAt(Organization organization) => organization.updatedAt;

	DateTime? getOrganizationDeletedAt(Organization organization) => organization.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Organization> getByName(
    String name,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationName, name, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByType(
    OrgType type,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationType, type, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByRegion(
    Region region,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationRegion, region, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByDefaultCurrency(
    String defaultCurrency,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationDefaultCurrency, defaultCurrency, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByDefaultLocale(
    String defaultLocale,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationDefaultLocale, defaultLocale, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByLegalName(
    String legalName,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationLegalName, legalName, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByTaxId(
    String taxId,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationTaxId, taxId, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByAddress(
    String address,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationAddress, address, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByContactEmail(
    String contactEmail,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationContactEmail, contactEmail, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByManagementFeeType(
    ManagementFeeType managementFeeType,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationManagementFeeType, managementFeeType, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByManagementFeeRate(
    double managementFeeRate,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationManagementFeeRate, managementFeeRate, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByManagementFeeAmount(
    double managementFeeAmount,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationManagementFeeAmount, managementFeeAmount, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByManagementFeeScope(
    ManagementFeeScope managementFeeScope,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationManagementFeeScope, managementFeeScope, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByTaxReportingEnabled(
    bool taxReportingEnabled,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationTaxReportingEnabled, taxReportingEnabled, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByComplianceTracking(
    bool complianceTracking,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationComplianceTracking, complianceTracking, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByRequiredInspections(
    ComplianceType requiredInspections,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationRequiredInspections, requiredInspections, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Organization> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}
    ) =>
    getManyIncluding(getOrganizationDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  List<AIChatbotSession> getAiChatbotSessions(
    Organization organization, {ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}) {
    final aiChatbotSessions = AIChatbotSessionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiChatbotSessions = aiChatbotSessions;
    // setIncludedReferencesForList(aiChatbotSessions, includes: includes);
    return aiChatbotSessions;
}

	List<AIFraudDetection> getAiFraudDetections(
    Organization organization, {ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}) {
    final aiFraudDetections = AIFraudDetectionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiFraudDetections = aiFraudDetections;
    // setIncludedReferencesForList(aiFraudDetections, includes: includes);
    return aiFraudDetections;
}

	List<AIImageAnalysis> getAiImageAnalyses(
    Organization organization, {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}) {
    final aiImageAnalyses = AIImageAnalysisStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiImageAnalyses = aiImageAnalyses;
    // setIncludedReferencesForList(aiImageAnalyses, includes: includes);
    return aiImageAnalyses;
}

	List<AIInvestmentAnalysis> getAiInvestmentAnalyses(
    Organization organization, {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}) {
    final aiInvestmentAnalyses = AIInvestmentAnalysisStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiInvestmentAnalyses = aiInvestmentAnalyses;
    // setIncludedReferencesForList(aiInvestmentAnalyses, includes: includes);
    return aiInvestmentAnalyses;
}

	List<AILeadScore> getAiLeadScores(
    Organization organization, {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}) {
    final aiLeadScores = AILeadScoreStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiLeadScores = aiLeadScores;
    // setIncludedReferencesForList(aiLeadScores, includes: includes);
    return aiLeadScores;
}

	List<AILeadScoring> getAiLeadScoringModels(
    Organization organization, {ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}) {
    final aiLeadScoringModels = AILeadScoringStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiLeadScoringModels = aiLeadScoringModels;
    // setIncludedReferencesForList(aiLeadScoringModels, includes: includes);
    return aiLeadScoringModels;
}

	List<AIMarketAnalysis> getAiMarketAnalyses(
    Organization organization, {ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}) {
    final aiMarketAnalyses = AIMarketAnalysisStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiMarketAnalyses = aiMarketAnalyses;
    // setIncludedReferencesForList(aiMarketAnalyses, includes: includes);
    return aiMarketAnalyses;
}

	List<AIModel> getAiModels(
    Organization organization, {ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}) {
    final aiModels = AIModelStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiModels = aiModels;
    // setIncludedReferencesForList(aiModels, includes: includes);
    return aiModels;
}

	List<AIModelDeployment> getAiModelDeployments(
    Organization organization, {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}) {
    final aiModelDeployments = AIModelDeploymentStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiModelDeployments = aiModelDeployments;
    // setIncludedReferencesForList(aiModelDeployments, includes: includes);
    return aiModelDeployments;
}

	List<AIPrediction> getAiPredictions(
    Organization organization, {ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}) {
    final aiPredictions = AIPredictionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiPredictions = aiPredictions;
    // setIncludedReferencesForList(aiPredictions, includes: includes);
    return aiPredictions;
}

	List<AIPredictiveMaintenance> getAiPredictiveMaintenance(
    Organization organization, {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}) {
    final aiPredictiveMaintenance = AIPredictiveMaintenanceStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiPredictiveMaintenance = aiPredictiveMaintenance;
    // setIncludedReferencesForList(aiPredictiveMaintenance, includes: includes);
    return aiPredictiveMaintenance;
}

	List<AIPriceOptimization> getAiPriceOptimizations(
    Organization organization, {ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}) {
    final aiPriceOptimizations = AIPriceOptimizationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiPriceOptimizations = aiPriceOptimizations;
    // setIncludedReferencesForList(aiPriceOptimizations, includes: includes);
    return aiPriceOptimizations;
}

	List<AIPropertyDescription> getAiPropertyDescriptions(
    Organization organization, {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}) {
    final aiPropertyDescriptions = AIPropertyDescriptionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiPropertyDescriptions = aiPropertyDescriptions;
    // setIncludedReferencesForList(aiPropertyDescriptions, includes: includes);
    return aiPropertyDescriptions;
}

	List<AIPropertyValuation> getAiPropertyValuations(
    Organization organization, {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}) {
    final aiPropertyValuations = AIPropertyValuationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiPropertyValuations = aiPropertyValuations;
    // setIncludedReferencesForList(aiPropertyValuations, includes: includes);
    return aiPropertyValuations;
}

	List<AIRecommendation> getAiRecommendations(
    Organization organization, {ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}) {
    final aiRecommendations = AIRecommendationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiRecommendations = aiRecommendations;
    // setIncludedReferencesForList(aiRecommendations, includes: includes);
    return aiRecommendations;
}

	List<AISentimentAnalysis> getAiSentimentAnalyses(
    Organization organization, {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}) {
    final aiSentimentAnalyses = AISentimentAnalysisStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiSentimentAnalyses = aiSentimentAnalyses;
    // setIncludedReferencesForList(aiSentimentAnalyses, includes: includes);
    return aiSentimentAnalyses;
}

	List<AITenantScreening> getAiTenantScreenings(
    Organization organization, {ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}) {
    final aiTenantScreenings = AITenantScreeningStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiTenantScreenings = aiTenantScreenings;
    // setIncludedReferencesForList(aiTenantScreenings, includes: includes);
    return aiTenantScreenings;
}

	List<AIValuationModel> getAiValuationModels(
    Organization organization, {ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}) {
    final aiValuationModels = AIValuationModelStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiValuationModels = aiValuationModels;
    // setIncludedReferencesForList(aiValuationModels, includes: includes);
    return aiValuationModels;
}

	List<APIIntegration> getIntegrations(
    Organization organization, {ModelFilter<APIIntegration>? modelFilter, List<APIIntegrationInclude>? includes}) {
    final integrations = APIIntegrationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.integrations = integrations;
    // setIncludedReferencesForList(integrations, includes: includes);
    return integrations;
}

	List<Achievement> getAchievements(
    Organization organization, {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}) {
    final achievements = AchievementStore.instance.getByOrganizationId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.achievements = achievements;
    // setIncludedReferencesForList(achievements, includes: includes);
    return achievements;
}

	List<Agency> getAgencies(
    Organization organization, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getByOrganizationId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Agency> getAgencyRelations(
    Organization organization, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencyRelations = AgencyStore.instance.getBy(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.agencyRelations = agencyRelations;
    // setIncludedReferencesForList(agencyRelations, includes: includes);
    return agencyRelations;
}

	List<Agency> getOrganizationAgencies(
    Organization organization, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final organizationAgencies = AgencyStore.instance.getBy(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.organizationAgencies = organizationAgencies;
    // setIncludedReferencesForList(organizationAgencies, includes: includes);
    return organizationAgencies;
}

	List<AgentAssignment> getAgentAssignments(
    Organization organization, {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}) {
    final agentAssignments = AgentAssignmentStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.agentAssignments = agentAssignments;
    // setIncludedReferencesForList(agentAssignments, includes: includes);
    return agentAssignments;
}

	List<AgentTeam> getAgentTeams(
    Organization organization, {ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}) {
    final agentTeams = AgentTeamStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.agentTeams = agentTeams;
    // setIncludedReferencesForList(agentTeams, includes: includes);
    return agentTeams;
}

	List<Amenity> getAmenities(
    Organization organization, {ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}) {
    final amenities = AmenityStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.amenities = amenities;
    // setIncludedReferencesForList(amenities, includes: includes);
    return amenities;
}

	List<ApiIntegration> getApiIntegrations(
    Organization organization, {ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}) {
    final apiIntegrations = ApiIntegrationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.apiIntegrations = apiIntegrations;
    // setIncludedReferencesForList(apiIntegrations, includes: includes);
    return apiIntegrations;
}

	List<ApiKey> getApiKeys(
    Organization organization, {ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}) {
    final apiKeys = ApiKeyStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.apiKeys = apiKeys;
    // setIncludedReferencesForList(apiKeys, includes: includes);
    return apiKeys;
}

	List<Appointment> getAppointments(
    Organization organization, {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    final appointments = AppointmentStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.appointments = appointments;
    // setIncludedReferencesForList(appointments, includes: includes);
    return appointments;
}

	List<Attachment> getAttachments(
    Organization organization, {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    final attachments = AttachmentStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.attachments = attachments;
    // setIncludedReferencesForList(attachments, includes: includes);
    return attachments;
}

	List<AttorneyManagement> getAttorneyCases(
    Organization organization, {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}) {
    final attorneyCases = AttorneyManagementStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.attorneyCases = attorneyCases;
    // setIncludedReferencesForList(attorneyCases, includes: includes);
    return attorneyCases;
}

	List<AuditLog> getAuditLogs(
    Organization organization, {ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}) {
    final auditLogs = AuditLogStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.auditLogs = auditLogs;
    // setIncludedReferencesForList(auditLogs, includes: includes);
    return auditLogs;
}

	List<AutomationExecution> getAutomationExecutions(
    Organization organization, {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}) {
    final automationExecutions = AutomationExecutionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.automationExecutions = automationExecutions;
    // setIncludedReferencesForList(automationExecutions, includes: includes);
    return automationExecutions;
}

	List<AutomationRule> getAutomationRules(
    Organization organization, {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}) {
    final automationRules = AutomationRuleStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.automationRules = automationRules;
    // setIncludedReferencesForList(automationRules, includes: includes);
    return automationRules;
}

	List<Booking> getBookings(
    Organization organization, {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    final bookings = BookingStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.bookings = bookings;
    // setIncludedReferencesForList(bookings, includes: includes);
    return bookings;
}

	List<Budget> getBudgets(
    Organization organization, {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}) {
    final budgets = BudgetStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.budgets = budgets;
    // setIncludedReferencesForList(budgets, includes: includes);
    return budgets;
}

	List<CalendarEvent> getCalendarEvents(
    Organization organization, {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}) {
    final calendarEvents = CalendarEventStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.calendarEvents = calendarEvents;
    // setIncludedReferencesForList(calendarEvents, includes: includes);
    return calendarEvents;
}

	List<Commission> getCommissions(
    Organization organization, {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}) {
    final commissions = CommissionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.commissions = commissions;
    // setIncludedReferencesForList(commissions, includes: includes);
    return commissions;
}

	List<CommunicationTemplate> getCommunicationTemplates(
    Organization organization, {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}) {
    final communicationTemplates = CommunicationTemplateStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.communicationTemplates = communicationTemplates;
    // setIncludedReferencesForList(communicationTemplates, includes: includes);
    return communicationTemplates;
}

	List<Contact> getContacts(
    Organization organization, {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    final contacts = ContactStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.contacts = contacts;
    // setIncludedReferencesForList(contacts, includes: includes);
    return contacts;
}

	List<Contract> getContracts(
    Organization organization, {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    final contracts = ContractStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.contracts = contracts;
    // setIncludedReferencesForList(contracts, includes: includes);
    return contracts;
}

	List<ContractVersion> getContractVersions(
    Organization organization, {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}) {
    final contractVersions = ContractVersionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.contractVersions = contractVersions;
    // setIncludedReferencesForList(contractVersions, includes: includes);
    return contractVersions;
}

	List<DashboardConfiguration> getDashboardConfigurations(
    Organization organization, {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}) {
    final dashboardConfigurations = DashboardConfigurationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.dashboardConfigurations = dashboardConfigurations;
    // setIncludedReferencesForList(dashboardConfigurations, includes: includes);
    return dashboardConfigurations;
}

	List<DashboardWidget> getDashboardWidgets(
    Organization organization, {ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}) {
    final dashboardWidgets = DashboardWidgetStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.dashboardWidgets = dashboardWidgets;
    // setIncludedReferencesForList(dashboardWidgets, includes: includes);
    return dashboardWidgets;
}

	List<Deal> getDeals(
    Organization organization, {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    final deals = DealStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.deals = deals;
    // setIncludedReferencesForList(deals, includes: includes);
    return deals;
}

	List<DepositProtection> getDepositProtections(
    Organization organization, {ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}) {
    final depositProtections = DepositProtectionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.depositProtections = depositProtections;
    // setIncludedReferencesForList(depositProtections, includes: includes);
    return depositProtections;
}

	List<Document> getDocuments(
    Organization organization, {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    final documents = DocumentStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.documents = documents;
    // setIncludedReferencesForList(documents, includes: includes);
    return documents;
}

	List<DocumentTemplate> getDocumentTemplates(
    Organization organization, {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}) {
    final documentTemplates = DocumentTemplateStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.documentTemplates = documentTemplates;
    // setIncludedReferencesForList(documentTemplates, includes: includes);
    return documentTemplates;
}

	List<Earning> getEarnings(
    Organization organization, {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}) {
    final earnings = EarningStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.earnings = earnings;
    // setIncludedReferencesForList(earnings, includes: includes);
    return earnings;
}

	List<Event> getEvents(
    Organization organization, {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}) {
    final events = EventStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.events = events;
    // setIncludedReferencesForList(events, includes: includes);
    return events;
}

	List<EventAttendee> getEventAttendees(
    Organization organization, {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    final eventAttendees = EventAttendeeStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.eventAttendees = eventAttendees;
    // setIncludedReferencesForList(eventAttendees, includes: includes);
    return eventAttendees;
}

	List<ExchangeRate> getExchangeRates(
    Organization organization, {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}) {
    final exchangeRates = ExchangeRateStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.exchangeRates = exchangeRates;
    // setIncludedReferencesForList(exchangeRates, includes: includes);
    return exchangeRates;
}

	List<ExportFile> getExportFiles(
    Organization organization, {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}) {
    final exportFiles = ExportFileStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.exportFiles = exportFiles;
    // setIncludedReferencesForList(exportFiles, includes: includes);
    return exportFiles;
}

	List<ExportJob> getExportJobs(
    Organization organization, {ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}) {
    final exportJobs = ExportJobStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.exportJobs = exportJobs;
    // setIncludedReferencesForList(exportJobs, includes: includes);
    return exportJobs;
}

	List<ExternalRentalListing> getExternalRentalListings(
    Organization organization, {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}) {
    final externalRentalListings = ExternalRentalListingStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.externalRentalListings = externalRentalListings;
    // setIncludedReferencesForList(externalRentalListings, includes: includes);
    return externalRentalListings;
}

	List<Facility> getFacilities(
    Organization organization, {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    final facilities = FacilityStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.facilities = facilities;
    // setIncludedReferencesForList(facilities, includes: includes);
    return facilities;
}

	List<FinancialRecord> getFinancialRecords(
    Organization organization, {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    final financialRecords = FinancialRecordStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.financialRecords = financialRecords;
    // setIncludedReferencesForList(financialRecords, includes: includes);
    return financialRecords;
}

	List<FloorPlan> getFloorPlans(
    Organization organization, {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}) {
    final floorPlans = FloorPlanStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.floorPlans = floorPlans;
    // setIncludedReferencesForList(floorPlans, includes: includes);
    return floorPlans;
}

	List<GiftCard> getGiftCards(
    Organization organization, {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}) {
    final giftCards = GiftCardStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.giftCards = giftCards;
    // setIncludedReferencesForList(giftCards, includes: includes);
    return giftCards;
}

	List<GovernmentIntegration> getGovtIntegrations(
    Organization organization, {ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}) {
    final govtIntegrations = GovernmentIntegrationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.govtIntegrations = govtIntegrations;
    // setIncludedReferencesForList(govtIntegrations, includes: includes);
    return govtIntegrations;
}

	List<HealthCheck> getHealthChecks(
    Organization organization, {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}) {
    final healthChecks = HealthCheckStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.healthChecks = healthChecks;
    // setIncludedReferencesForList(healthChecks, includes: includes);
    return healthChecks;
}

	List<HomeInformationPack> getHomeInformationPacks(
    Organization organization, {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}) {
    final homeInformationPacks = HomeInformationPackStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.homeInformationPacks = homeInformationPacks;
    // setIncludedReferencesForList(homeInformationPacks, includes: includes);
    return homeInformationPacks;
}

	List<ImmigrationStatusCheck> getImmigrationStatusChecks(
    Organization organization, {ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}) {
    final immigrationStatusChecks = ImmigrationStatusCheckStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.immigrationStatusChecks = immigrationStatusChecks;
    // setIncludedReferencesForList(immigrationStatusChecks, includes: includes);
    return immigrationStatusChecks;
}

	List<IntegrationLog> getIntegrationLogs(
    Organization organization, {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}) {
    final integrationLogs = IntegrationLogStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.integrationLogs = integrationLogs;
    // setIncludedReferencesForList(integrationLogs, includes: includes);
    return integrationLogs;
}

	List<InvestorPortfolio> getInvestorPortfolios(
    Organization organization, {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}) {
    final investorPortfolios = InvestorPortfolioStore.instance.getByOrganizationId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.investorPortfolios = investorPortfolios;
    // setIncludedReferencesForList(investorPortfolios, includes: includes);
    return investorPortfolios;
}

	List<KeyManagement> getKeys(
    Organization organization, {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}) {
    final keys = KeyManagementStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.keys = keys;
    // setIncludedReferencesForList(keys, includes: includes);
    return keys;
}

	List<Lead> getLeads(
    Organization organization, {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final leads = LeadStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.leads = leads;
    // setIncludedReferencesForList(leads, includes: includes);
    return leads;
}

	List<LeadSource> getLeadSources(
    Organization organization, {ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}) {
    final leadSources = LeadSourceStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.leadSources = leadSources;
    // setIncludedReferencesForList(leadSources, includes: includes);
    return leadSources;
}

	List<Lease> getLeases(
    Organization organization, {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    final leases = LeaseStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.leases = leases;
    // setIncludedReferencesForList(leases, includes: includes);
    return leases;
}

	List<LeaseRenewal> getLeaseRenewals(
    Organization organization, {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}) {
    final leaseRenewals = LeaseRenewalStore.instance.getByOrganizationId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.leaseRenewals = leaseRenewals;
    // setIncludedReferencesForList(leaseRenewals, includes: includes);
    return leaseRenewals;
}

	List<LedgerEntry> getLedgerEntries(
    Organization organization, {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}) {
    final ledgerEntries = LedgerEntryStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.ledgerEntries = ledgerEntries;
    // setIncludedReferencesForList(ledgerEntries, includes: includes);
    return ledgerEntries;
}

	List<Listing> getListings(
    Organization organization, {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    final listings = ListingStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.listings = listings;
    // setIncludedReferencesForList(listings, includes: includes);
    return listings;
}

	List<ListingChannel> getListingChannels(
    Organization organization, {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}) {
    final listingChannels = ListingChannelStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.listingChannels = listingChannels;
    // setIncludedReferencesForList(listingChannels, includes: includes);
    return listingChannels;
}

	List<ListingStatusHistory> getListingStatusHistories(
    Organization organization, {ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}) {
    final listingStatusHistories = ListingStatusHistoryStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.listingStatusHistories = listingStatusHistories;
    // setIncludedReferencesForList(listingStatusHistories, includes: includes);
    return listingStatusHistories;
}

	List<ListingTag> getListingTags(
    Organization organization, {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}) {
    final listingTags = ListingTagStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.listingTags = listingTags;
    // setIncludedReferencesForList(listingTags, includes: includes);
    return listingTags;
}

	List<Location> getLocations(
    Organization organization, {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    final locations = LocationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.locations = locations;
    // setIncludedReferencesForList(locations, includes: includes);
    return locations;
}

	List<LoyaltyAccount> getLoyaltyAccounts(
    Organization organization, {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}) {
    final loyaltyAccounts = LoyaltyAccountStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.loyaltyAccounts = loyaltyAccounts;
    // setIncludedReferencesForList(loyaltyAccounts, includes: includes);
    return loyaltyAccounts;
}

	List<MLSConnection> getMlsConnections(
    Organization organization, {ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}) {
    final mlsConnections = MLSConnectionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mlsConnections = mlsConnections;
    // setIncludedReferencesForList(mlsConnections, includes: includes);
    return mlsConnections;
}

	List<MLSExternalListing> getMlsexternalListings(
    Organization organization, {ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}) {
    final mlsexternalListings = MLSExternalListingStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mlsexternalListings = mlsexternalListings;
    // setIncludedReferencesForList(mlsexternalListings, includes: includes);
    return mlsexternalListings;
}

	List<MLSSyncJob> getMlssyncJobs(
    Organization organization, {ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}) {
    final mlssyncJobs = MLSSyncJobStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mlssyncJobs = mlssyncJobs;
    // setIncludedReferencesForList(mlssyncJobs, includes: includes);
    return mlssyncJobs;
}

	List<MaintenanceBlock> getMaintenanceBlocks(
    Organization organization, {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}) {
    final maintenanceBlocks = MaintenanceBlockStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.maintenanceBlocks = maintenanceBlocks;
    // setIncludedReferencesForList(maintenanceBlocks, includes: includes);
    return maintenanceBlocks;
}

	List<MaintenanceWorkOrder> getWorkOrders(
    Organization organization, {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    final workOrders = MaintenanceWorkOrderStore.instance.getByOrganizationId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.workOrders = workOrders;
    // setIncludedReferencesForList(workOrders, includes: includes);
    return workOrders;
}

	List<MapLayer> getMapLayers(
    Organization organization, {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}) {
    final mapLayers = MapLayerStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mapLayers = mapLayers;
    // setIncludedReferencesForList(mapLayers, includes: includes);
    return mapLayers;
}

	List<MarketingCampaign> getMarketingCampaigns(
    Organization organization, {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}) {
    final marketingCampaigns = MarketingCampaignStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.marketingCampaigns = marketingCampaigns;
    // setIncludedReferencesForList(marketingCampaigns, includes: includes);
    return marketingCampaigns;
}

	List<Message> getMessages(
    Organization organization, {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}) {
    final messages = MessageStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.messages = messages;
    // setIncludedReferencesForList(messages, includes: includes);
    return messages;
}

	List<MlsDataMapping> getMlsDataMappings(
    Organization organization, {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}) {
    final mlsDataMappings = MlsDataMappingStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mlsDataMappings = mlsDataMappings;
    // setIncludedReferencesForList(mlsDataMappings, includes: includes);
    return mlsDataMappings;
}

	List<MlsListingEnhancement> getMlsListingEnhancements(
    Organization organization, {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}) {
    final mlsListingEnhancements = MlsListingEnhancementStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mlsListingEnhancements = mlsListingEnhancements;
    // setIncludedReferencesForList(mlsListingEnhancements, includes: includes);
    return mlsListingEnhancements;
}

	List<MobileDevice> getMobileDevices(
    Organization organization, {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}) {
    final mobileDevices = MobileDeviceStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mobileDevices = mobileDevices;
    // setIncludedReferencesForList(mobileDevices, includes: includes);
    return mobileDevices;
}

	List<MortgageOffer> getMortgageOffers(
    Organization organization, {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}) {
    final mortgageOffers = MortgageOfferStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mortgageOffers = mortgageOffers;
    // setIncludedReferencesForList(mortgageOffers, includes: includes);
    return mortgageOffers;
}

	List<MortgagePreApproval> getMortgagePreApprovals(
    Organization organization, {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}) {
    final mortgagePreApprovals = MortgagePreApprovalStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.mortgagePreApprovals = mortgagePreApprovals;
    // setIncludedReferencesForList(mortgagePreApprovals, includes: includes);
    return mortgagePreApprovals;
}

	List<Neighborhood> getNeighborhoods(
    Organization organization, {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}) {
    final neighborhoods = NeighborhoodStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.neighborhoods = neighborhoods;
    // setIncludedReferencesForList(neighborhoods, includes: includes);
    return neighborhoods;
}

	List<Notification> getNotifications(
    Organization organization, {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    final notifications = NotificationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.notifications = notifications;
    // setIncludedReferencesForList(notifications, includes: includes);
    return notifications;
}

	List<OfflineSyncQueue> getOfflineSyncQueues(
    Organization organization, {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}) {
    final offlineSyncQueues = OfflineSyncQueueStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.offlineSyncQueues = offlineSyncQueues;
    // setIncludedReferencesForList(offlineSyncQueues, includes: includes);
    return offlineSyncQueues;
}

	OrgSubscription? getOrgSubscription(
    Organization organization, {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}) {
    final orgSubscription = OrgSubscriptionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.orgSubscription = orgSubscription;
    // setIncludedReferences(orgSubscription, includes: includes);
    return orgSubscription;
}

	List<Payout> getPayouts(
    Organization organization, {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    final payouts = PayoutStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.payouts = payouts;
    // setIncludedReferencesForList(payouts, includes: includes);
    return payouts;
}

	List<PerformanceAlert> getPerformanceAlerts(
    Organization organization, {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}) {
    final performanceAlerts = PerformanceAlertStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.performanceAlerts = performanceAlerts;
    // setIncludedReferencesForList(performanceAlerts, includes: includes);
    return performanceAlerts;
}

	List<PredictiveModel> getPredictiveModels(
    Organization organization, {ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}) {
    final predictiveModels = PredictiveModelStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.predictiveModels = predictiveModels;
    // setIncludedReferencesForList(predictiveModels, includes: includes);
    return predictiveModels;
}

	List<Project> getProjects(
    Organization organization, {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    final projects = ProjectStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.projects = projects;
    // setIncludedReferencesForList(projects, includes: includes);
    return projects;
}

	List<Property> getProperties(
    Organization organization, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final properties = PropertyStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.properties = properties;
    // setIncludedReferencesForList(properties, includes: includes);
    return properties;
}

	List<PropertyAmenity> getPropertyAmenities(
    Organization organization, {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}) {
    final propertyAmenities = PropertyAmenityStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.propertyAmenities = propertyAmenities;
    // setIncludedReferencesForList(propertyAmenities, includes: includes);
    return propertyAmenities;
}

	List<PropertyCompliance> getPropertyCompliance(
    Organization organization, {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    final propertyCompliance = PropertyComplianceStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.propertyCompliance = propertyCompliance;
    // setIncludedReferencesForList(propertyCompliance, includes: includes);
    return propertyCompliance;
}

	List<PropertyDisclosure> getPropertyDisclosures(
    Organization organization, {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}) {
    final propertyDisclosures = PropertyDisclosureStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.propertyDisclosures = propertyDisclosures;
    // setIncludedReferencesForList(propertyDisclosures, includes: includes);
    return propertyDisclosures;
}

	List<PropertyDocument> getPropertyDocuments(
    Organization organization, {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}) {
    final propertyDocuments = PropertyDocumentStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.propertyDocuments = propertyDocuments;
    // setIncludedReferencesForList(propertyDocuments, includes: includes);
    return propertyDocuments;
}

	List<PropertyInventory> getInventories(
    Organization organization, {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}) {
    final inventories = PropertyInventoryStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.inventories = inventories;
    // setIncludedReferencesForList(inventories, includes: includes);
    return inventories;
}

	List<PropertyOffer> getPropertyOffers(
    Organization organization, {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    final propertyOffers = PropertyOfferStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.propertyOffers = propertyOffers;
    // setIncludedReferencesForList(propertyOffers, includes: includes);
    return propertyOffers;
}

	List<PropertyPhoto> getPropertyPhotos(
    Organization organization, {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}) {
    final propertyPhotos = PropertyPhotoStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.propertyPhotos = propertyPhotos;
    // setIncludedReferencesForList(propertyPhotos, includes: includes);
    return propertyPhotos;
}

	List<PropertyViewing> getPropertyViewings(
    Organization organization, {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    final propertyViewings = PropertyViewingStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.propertyViewings = propertyViewings;
    // setIncludedReferencesForList(propertyViewings, includes: includes);
    return propertyViewings;
}

	List<QueueConfiguration> getQueueConfigurations(
    Organization organization, {ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}) {
    final queueConfigurations = QueueConfigurationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.queueConfigurations = queueConfigurations;
    // setIncludedReferencesForList(queueConfigurations, includes: includes);
    return queueConfigurations;
}

	List<QueueMessage> getQueueMessages(
    Organization organization, {ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}) {
    final queueMessages = QueueMessageStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.queueMessages = queueMessages;
    // setIncludedReferencesForList(queueMessages, includes: includes);
    return queueMessages;
}

	List<Quote> getQuotes(
    Organization organization, {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    final quotes = QuoteStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.quotes = quotes;
    // setIncludedReferencesForList(quotes, includes: includes);
    return quotes;
}

	List<RecommendationResult> getRecommendationResults(
    Organization organization, {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}) {
    final recommendationResults = RecommendationResultStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.recommendationResults = recommendationResults;
    // setIncludedReferencesForList(recommendationResults, includes: includes);
    return recommendationResults;
}

	List<Referral> getReferrals(
    Organization organization, {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}) {
    final referrals = ReferralStore.instance.getByOrganizationId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.referrals = referrals;
    // setIncludedReferencesForList(referrals, includes: includes);
    return referrals;
}

	List<RentArrears> getRentArrears(
    Organization organization, {ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}) {
    final rentArrears = RentArrearsStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.rentArrears = rentArrears;
    // setIncludedReferencesForList(rentArrears, includes: includes);
    return rentArrears;
}

	List<RentSchedule> getRentSchedules(
    Organization organization, {ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}) {
    final rentSchedules = RentScheduleStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.rentSchedules = rentSchedules;
    // setIncludedReferencesForList(rentSchedules, includes: includes);
    return rentSchedules;
}

	List<RentalSyncJob> getRentalSyncJobs(
    Organization organization, {ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}) {
    final rentalSyncJobs = RentalSyncJobStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.rentalSyncJobs = rentalSyncJobs;
    // setIncludedReferencesForList(rentalSyncJobs, includes: includes);
    return rentalSyncJobs;
}

	List<Report> getReports(
    Organization organization, {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final reports = ReportStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.reports = reports;
    // setIncludedReferencesForList(reports, includes: includes);
    return reports;
}

	List<ReportExecution> getReportExecutions(
    Organization organization, {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}) {
    final reportExecutions = ReportExecutionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.reportExecutions = reportExecutions;
    // setIncludedReferencesForList(reportExecutions, includes: includes);
    return reportExecutions;
}

	List<Reservation> getReservations(
    Organization organization, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final reservations = ReservationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.reservations = reservations;
    // setIncludedReferencesForList(reservations, includes: includes);
    return reservations;
}

	List<Review> getReviews(
    Organization organization, {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}) {
    final reviews = ReviewStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.reviews = reviews;
    // setIncludedReferencesForList(reviews, includes: includes);
    return reviews;
}

	List<RightToRentCheck> getRightToRentChecks(
    Organization organization, {ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}) {
    final rightToRentChecks = RightToRentCheckStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.rightToRentChecks = rightToRentChecks;
    // setIncludedReferencesForList(rightToRentChecks, includes: includes);
    return rightToRentChecks;
}

	List<Role> getRoles(
    Organization organization, {ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}) {
    final roles = RoleStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.roles = roles;
    // setIncludedReferencesForList(roles, includes: includes);
    return roles;
}

	List<Route> getRoutes(
    Organization organization, {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}) {
    final routes = RouteStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.routes = routes;
    // setIncludedReferencesForList(routes, includes: includes);
    return routes;
}

	List<SecurityDepositProtection> getSecurityDepositProtections(
    Organization organization, {ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}) {
    final securityDepositProtections = SecurityDepositProtectionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.securityDepositProtections = securityDepositProtections;
    // setIncludedReferencesForList(securityDepositProtections, includes: includes);
    return securityDepositProtections;
}

	List<SignatureRequest> getSignatureRequests(
    Organization organization, {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}) {
    final signatureRequests = SignatureRequestStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.signatureRequests = signatureRequests;
    // setIncludedReferencesForList(signatureRequests, includes: includes);
    return signatureRequests;
}

	List<SignatureSigner> getSignatureSigners(
    Organization organization, {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    final signatureSigners = SignatureSignerStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.signatureSigners = signatureSigners;
    // setIncludedReferencesForList(signatureSigners, includes: includes);
    return signatureSigners;
}

	List<SolicitorManagement> getSolicitorManagements(
    Organization organization, {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}) {
    final solicitorManagements = SolicitorManagementStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.solicitorManagements = solicitorManagements;
    // setIncludedReferencesForList(solicitorManagements, includes: includes);
    return solicitorManagements;
}

	List<Subscription> getSubscriptions(
    Organization organization, {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    final subscriptions = SubscriptionStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.subscriptions = subscriptions;
    // setIncludedReferencesForList(subscriptions, includes: includes);
    return subscriptions;
}

	List<SystemMetrics> getSystemMetrics(
    Organization organization, {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}) {
    final systemMetrics = SystemMetricsStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.systemMetrics = systemMetrics;
    // setIncludedReferencesForList(systemMetrics, includes: includes);
    return systemMetrics;
}

	List<Tag> getTags(
    Organization organization, {ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}) {
    final tags = TagStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.tags = tags;
    // setIncludedReferencesForList(tags, includes: includes);
    return tags;
}

	List<Task> getTasks(
    Organization organization, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<Tax1099Form> getTax1099Forms(
    Organization organization, {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}) {
    final tax1099Forms = Tax1099FormStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.tax1099Forms = tax1099Forms;
    // setIncludedReferencesForList(tax1099Forms, includes: includes);
    return tax1099Forms;
}

	List<TaxDepreciation> getTaxDepreciations(
    Organization organization, {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}) {
    final taxDepreciations = TaxDepreciationStore.instance.getByOrganizationId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.taxDepreciations = taxDepreciations;
    // setIncludedReferencesForList(taxDepreciations, includes: includes);
    return taxDepreciations;
}

	List<TaxRecord> getTaxRecords(
    Organization organization, {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    final taxRecords = TaxRecordStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.taxRecords = taxRecords;
    // setIncludedReferencesForList(taxRecords, includes: includes);
    return taxRecords;
}

	List<TenantApplication> getTenantApplications(
    Organization organization, {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    final tenantApplications = TenantApplicationStore.instance.getByOrganizationId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.tenantApplications = tenantApplications;
    // setIncludedReferencesForList(tenantApplications, includes: includes);
    return tenantApplications;
}

	List<UserActivityLog> getUserActivityLogs(
    Organization organization, {ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}) {
    final userActivityLogs = UserActivityLogStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.userActivityLogs = userActivityLogs;
    // setIncludedReferencesForList(userActivityLogs, includes: includes);
    return userActivityLogs;
}

	List<UserPreference> getUserPreferences(
    Organization organization, {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}) {
    final userPreferences = UserPreferenceStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.userPreferences = userPreferences;
    // setIncludedReferencesForList(userPreferences, includes: includes);
    return userPreferences;
}

	List<VacationRental> getVacationRentals(
    Organization organization, {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}) {
    final vacationRentals = VacationRentalStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.vacationRentals = vacationRentals;
    // setIncludedReferencesForList(vacationRentals, includes: includes);
    return vacationRentals;
}

	List<VendorProfile> getVendors(
    Organization organization, {ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}) {
    final vendors = VendorProfileStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.vendors = vendors;
    // setIncludedReferencesForList(vendors, includes: includes);
    return vendors;
}

	List<VirtualTour> getVirtualTours(
    Organization organization, {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}) {
    final virtualTours = VirtualTourStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.virtualTours = virtualTours;
    // setIncludedReferencesForList(virtualTours, includes: includes);
    return virtualTours;
}

	List<Webhook> getWebhooks(
    Organization organization, {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}) {
    final webhooks = WebhookStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.webhooks = webhooks;
    // setIncludedReferencesForList(webhooks, includes: includes);
    return webhooks;
}

	List<WebhookDelivery> getWebhookDeliveries(
    Organization organization, {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}) {
    final webhookDeliveries = WebhookDeliveryStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.webhookDeliveries = webhookDeliveries;
    // setIncludedReferencesForList(webhookDeliveries, includes: includes);
    return webhookDeliveries;
}

	List<EscrowAccount> getEscrowAccounts(
    Organization organization, {ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}) {
    final escrowAccounts = EscrowAccountStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.escrowAccounts = escrowAccounts;
    // setIncludedReferencesForList(escrowAccounts, includes: includes);
    return escrowAccounts;
}

	List<EscrowRelease> getEscrowReleases(
    Organization organization, {ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}) {
    final escrowReleases = EscrowReleaseStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.escrowReleases = escrowReleases;
    // setIncludedReferencesForList(escrowReleases, includes: includes);
    return escrowReleases;
}

	List<EscrowDispute> getEscrowDisputes(
    Organization organization, {ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}) {
    final escrowDisputes = EscrowDisputeStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.escrowDisputes = escrowDisputes;
    // setIncludedReferencesForList(escrowDisputes, includes: includes);
    return escrowDisputes;
}

	List<PaymentNegotiation> getPaymentNegotiations(
    Organization organization, {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    final paymentNegotiations = PaymentNegotiationStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.paymentNegotiations = paymentNegotiations;
    // setIncludedReferencesForList(paymentNegotiations, includes: includes);
    return paymentNegotiations;
}

	List<PaymentInstallment> getPaymentInstallments(
    Organization organization, {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}) {
    final paymentInstallments = PaymentInstallmentStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.paymentInstallments = paymentInstallments;
    // setIncludedReferencesForList(paymentInstallments, includes: includes);
    return paymentInstallments;
}

	List<VideoContent> getVideoContents(
    Organization organization, {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    final videoContents = VideoContentStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.videoContents = videoContents;
    // setIncludedReferencesForList(videoContents, includes: includes);
    return videoContents;
}

	List<BrandAmbassador> getBrandAmbassadors(
    Organization organization, {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    final brandAmbassadors = BrandAmbassadorStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.brandAmbassadors = brandAmbassadors;
    // setIncludedReferencesForList(brandAmbassadors, includes: includes);
    return brandAmbassadors;
}

	List<AmbassadorCampaign> getAmbassadorCampaigns(
    Organization organization, {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    final ambassadorCampaigns = AmbassadorCampaignStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.ambassadorCampaigns = ambassadorCampaigns;
    // setIncludedReferencesForList(ambassadorCampaigns, includes: includes);
    return ambassadorCampaigns;
}

	List<SocialImpactCounter> getSocialImpactCounters(
    Organization organization, {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}) {
    final socialImpactCounters = SocialImpactCounterStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.socialImpactCounters = socialImpactCounters;
    // setIncludedReferencesForList(socialImpactCounters, includes: includes);
    return socialImpactCounters;
}

	List<SocialImpactRecord> getSocialImpactRecords(
    Organization organization, {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}) {
    final socialImpactRecords = SocialImpactRecordStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.socialImpactRecords = socialImpactRecords;
    // setIncludedReferencesForList(socialImpactRecords, includes: includes);
    return socialImpactRecords;
}

	List<NegotiationOffer> getNegotiationOffers(
    Organization organization, {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}) {
    final negotiationOffers = NegotiationOfferStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.negotiationOffers = negotiationOffers;
    // setIncludedReferencesForList(negotiationOffers, includes: includes);
    return negotiationOffers;
}

	List<AmbassadorContract> getAmbassadorContracts(
    Organization organization, {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}) {
    final ambassadorContracts = AmbassadorContractStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.ambassadorContracts = ambassadorContracts;
    // setIncludedReferencesForList(ambassadorContracts, includes: includes);
    return ambassadorContracts;
}

	List<EscrowStatusHistory> getEscrowStatusHistories(
    Organization organization, {ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}) {
    final escrowStatusHistories = EscrowStatusHistoryStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.escrowStatusHistories = escrowStatusHistories;
    // setIncludedReferencesForList(escrowStatusHistories, includes: includes);
    return escrowStatusHistories;
}

	List<AIChatMessage> getAiChatMessages(
    Organization organization, {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    final aiChatMessages = AIChatMessageStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiChatMessages = aiChatMessages;
    // setIncludedReferencesForList(aiChatMessages, includes: includes);
    return aiChatMessages;
}

	List<AIChatHandoff> getAiChatHandoffs(
    Organization organization, {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}) {
    final aiChatHandoffs = AIChatHandoffStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.aiChatHandoffs = aiChatHandoffs;
    // setIncludedReferencesForList(aiChatHandoffs, includes: includes);
    return aiChatHandoffs;
}

	List<DocumentAnalysis> getAnalyses(
    Organization organization, {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}) {
    final analyses = DocumentAnalysisStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.analyses = analyses;
    // setIncludedReferencesForList(analyses, includes: includes);
    return analyses;
}

	List<AnalysisJob> getAnalysisJobs(
    Organization organization, {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}) {
    final analysisJobs = AnalysisJobStore.instance.getByOrgId(organization.$uid!, modelFilter: modelFilter, includes: includes);
    organization.analysisJobs = analysisJobs;
    // setIncludedReferencesForList(analysisJobs, includes: includes);
    return analysisJobs;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Organization>> getAll$({bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: OrganizationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Organization?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getOrganizationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Organization>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrganizationName,
        value: name,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByType$(
        OrgType type,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<OrgType>(
        getPropVal: getOrganizationType,
        value: type,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByRegion$(
        Region region,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<Region>(
        getPropVal: getOrganizationRegion,
        value: region,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByRegion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByDefaultCurrency$(
        String defaultCurrency,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrganizationDefaultCurrency,
        value: defaultCurrency,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByDefaultCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByDefaultLocale$(
        String defaultLocale,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrganizationDefaultLocale,
        value: defaultLocale,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByDefaultLocale,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByLegalName$(
        String legalName,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrganizationLegalName,
        value: legalName,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByLegalName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByTaxId$(
        String taxId,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrganizationTaxId,
        value: taxId,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByTaxId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByAddress$(
        String address,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrganizationAddress,
        value: address,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByContactEmail$(
        String contactEmail,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrganizationContactEmail,
        value: contactEmail,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByContactEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByManagementFeeType$(
        ManagementFeeType managementFeeType,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<ManagementFeeType>(
        getPropVal: getOrganizationManagementFeeType,
        value: managementFeeType,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByManagementFeeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByManagementFeeRate$(
        double managementFeeRate,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getOrganizationManagementFeeRate,
        value: managementFeeRate,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByManagementFeeRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByManagementFeeAmount$(
        double managementFeeAmount,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getOrganizationManagementFeeAmount,
        value: managementFeeAmount,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByManagementFeeAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByManagementFeeScope$(
        ManagementFeeScope managementFeeScope,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<ManagementFeeScope>(
        getPropVal: getOrganizationManagementFeeScope,
        value: managementFeeScope,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByManagementFeeScope,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByTaxReportingEnabled$(
        bool taxReportingEnabled,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getOrganizationTaxReportingEnabled,
        value: taxReportingEnabled,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByTaxReportingEnabled,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByComplianceTracking$(
        bool complianceTracking,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getOrganizationComplianceTracking,
        value: complianceTracking,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByComplianceTracking,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByRequiredInspections$(
        ComplianceType requiredInspections,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<ComplianceType>(
        getPropVal: getOrganizationRequiredInspections,
        value: requiredInspections,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByRequiredInspections,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOrganizationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOrganizationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Organization>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Organization>? modelFilter,
        List<OrganizationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOrganizationDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: OrganizationEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  Stream<List<AIChatbotSession>> getAiChatbotSessions$(
    Organization organization, {bool useCache = true, ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}) {
    return AIChatbotSessionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiChatbotSessions) {
        organization.aiChatbotSessions = aiChatbotSessions;
    });

}

	Stream<List<AIFraudDetection>> getAiFraudDetections$(
    Organization organization, {bool useCache = true, ModelFilter<AIFraudDetection>? modelFilter, List<AIFraudDetectionInclude>? includes}) {
    return AIFraudDetectionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiFraudDetections) {
        organization.aiFraudDetections = aiFraudDetections;
    });

}

	Stream<List<AIImageAnalysis>> getAiImageAnalyses$(
    Organization organization, {bool useCache = true, ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}) {
    return AIImageAnalysisStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiImageAnalyses) {
        organization.aiImageAnalyses = aiImageAnalyses;
    });

}

	Stream<List<AIInvestmentAnalysis>> getAiInvestmentAnalyses$(
    Organization organization, {bool useCache = true, ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}) {
    return AIInvestmentAnalysisStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiInvestmentAnalyses) {
        organization.aiInvestmentAnalyses = aiInvestmentAnalyses;
    });

}

	Stream<List<AILeadScore>> getAiLeadScores$(
    Organization organization, {bool useCache = true, ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}) {
    return AILeadScoreStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiLeadScores) {
        organization.aiLeadScores = aiLeadScores;
    });

}

	Stream<List<AILeadScoring>> getAiLeadScoringModels$(
    Organization organization, {bool useCache = true, ModelFilter<AILeadScoring>? modelFilter, List<AILeadScoringInclude>? includes}) {
    return AILeadScoringStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiLeadScoringModels) {
        organization.aiLeadScoringModels = aiLeadScoringModels;
    });

}

	Stream<List<AIMarketAnalysis>> getAiMarketAnalyses$(
    Organization organization, {bool useCache = true, ModelFilter<AIMarketAnalysis>? modelFilter, List<AIMarketAnalysisInclude>? includes}) {
    return AIMarketAnalysisStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiMarketAnalyses) {
        organization.aiMarketAnalyses = aiMarketAnalyses;
    });

}

	Stream<List<AIModel>> getAiModels$(
    Organization organization, {bool useCache = true, ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}) {
    return AIModelStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiModels) {
        organization.aiModels = aiModels;
    });

}

	Stream<List<AIModelDeployment>> getAiModelDeployments$(
    Organization organization, {bool useCache = true, ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}) {
    return AIModelDeploymentStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiModelDeployments) {
        organization.aiModelDeployments = aiModelDeployments;
    });

}

	Stream<List<AIPrediction>> getAiPredictions$(
    Organization organization, {bool useCache = true, ModelFilter<AIPrediction>? modelFilter, List<AIPredictionInclude>? includes}) {
    return AIPredictionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiPredictions) {
        organization.aiPredictions = aiPredictions;
    });

}

	Stream<List<AIPredictiveMaintenance>> getAiPredictiveMaintenance$(
    Organization organization, {bool useCache = true, ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}) {
    return AIPredictiveMaintenanceStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiPredictiveMaintenance) {
        organization.aiPredictiveMaintenance = aiPredictiveMaintenance;
    });

}

	Stream<List<AIPriceOptimization>> getAiPriceOptimizations$(
    Organization organization, {bool useCache = true, ModelFilter<AIPriceOptimization>? modelFilter, List<AIPriceOptimizationInclude>? includes}) {
    return AIPriceOptimizationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiPriceOptimizations) {
        organization.aiPriceOptimizations = aiPriceOptimizations;
    });

}

	Stream<List<AIPropertyDescription>> getAiPropertyDescriptions$(
    Organization organization, {bool useCache = true, ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}) {
    return AIPropertyDescriptionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiPropertyDescriptions) {
        organization.aiPropertyDescriptions = aiPropertyDescriptions;
    });

}

	Stream<List<AIPropertyValuation>> getAiPropertyValuations$(
    Organization organization, {bool useCache = true, ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}) {
    return AIPropertyValuationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiPropertyValuations) {
        organization.aiPropertyValuations = aiPropertyValuations;
    });

}

	Stream<List<AIRecommendation>> getAiRecommendations$(
    Organization organization, {bool useCache = true, ModelFilter<AIRecommendation>? modelFilter, List<AIRecommendationInclude>? includes}) {
    return AIRecommendationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiRecommendations) {
        organization.aiRecommendations = aiRecommendations;
    });

}

	Stream<List<AISentimentAnalysis>> getAiSentimentAnalyses$(
    Organization organization, {bool useCache = true, ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}) {
    return AISentimentAnalysisStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiSentimentAnalyses) {
        organization.aiSentimentAnalyses = aiSentimentAnalyses;
    });

}

	Stream<List<AITenantScreening>> getAiTenantScreenings$(
    Organization organization, {bool useCache = true, ModelFilter<AITenantScreening>? modelFilter, List<AITenantScreeningInclude>? includes}) {
    return AITenantScreeningStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiTenantScreenings) {
        organization.aiTenantScreenings = aiTenantScreenings;
    });

}

	Stream<List<AIValuationModel>> getAiValuationModels$(
    Organization organization, {bool useCache = true, ModelFilter<AIValuationModel>? modelFilter, List<AIValuationModelInclude>? includes}) {
    return AIValuationModelStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiValuationModels) {
        organization.aiValuationModels = aiValuationModels;
    });

}

	Stream<List<APIIntegration>> getIntegrations$(
    Organization organization, {bool useCache = true, ModelFilter<APIIntegration>? modelFilter, List<APIIntegrationInclude>? includes}) {
    return APIIntegrationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((integrations) {
        organization.integrations = integrations;
    });

}

	Stream<List<Achievement>> getAchievements$(
    Organization organization, {bool useCache = true, ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}) {
    return AchievementStore.instance.getByOrganizationId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((achievements) {
        organization.achievements = achievements;
    });

}

	Stream<List<Agency>> getAgencies$(
    Organization organization, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getByOrganizationId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        organization.agencies = agencies;
    });

}

	Stream<List<Agency>> getAgencyRelations$(
    Organization organization, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencyRelations) {
        organization.agencyRelations = agencyRelations;
    });

}

	Stream<List<Agency>> getOrganizationAgencies$(
    Organization organization, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((organizationAgencies) {
        organization.organizationAgencies = organizationAgencies;
    });

}

	Stream<List<AgentAssignment>> getAgentAssignments$(
    Organization organization, {bool useCache = true, ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}) {
    return AgentAssignmentStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agentAssignments) {
        organization.agentAssignments = agentAssignments;
    });

}

	Stream<List<AgentTeam>> getAgentTeams$(
    Organization organization, {bool useCache = true, ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}) {
    return AgentTeamStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agentTeams) {
        organization.agentTeams = agentTeams;
    });

}

	Stream<List<Amenity>> getAmenities$(
    Organization organization, {bool useCache = true, ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}) {
    return AmenityStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((amenities) {
        organization.amenities = amenities;
    });

}

	Stream<List<ApiIntegration>> getApiIntegrations$(
    Organization organization, {bool useCache = true, ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}) {
    return ApiIntegrationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((apiIntegrations) {
        organization.apiIntegrations = apiIntegrations;
    });

}

	Stream<List<ApiKey>> getApiKeys$(
    Organization organization, {bool useCache = true, ModelFilter<ApiKey>? modelFilter, List<ApiKeyInclude>? includes}) {
    return ApiKeyStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((apiKeys) {
        organization.apiKeys = apiKeys;
    });

}

	Stream<List<Appointment>> getAppointments$(
    Organization organization, {bool useCache = true, ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    return AppointmentStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((appointments) {
        organization.appointments = appointments;
    });

}

	Stream<List<Attachment>> getAttachments$(
    Organization organization, {bool useCache = true, ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    return AttachmentStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attachments) {
        organization.attachments = attachments;
    });

}

	Stream<List<AttorneyManagement>> getAttorneyCases$(
    Organization organization, {bool useCache = true, ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}) {
    return AttorneyManagementStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attorneyCases) {
        organization.attorneyCases = attorneyCases;
    });

}

	Stream<List<AuditLog>> getAuditLogs$(
    Organization organization, {bool useCache = true, ModelFilter<AuditLog>? modelFilter, List<AuditLogInclude>? includes}) {
    return AuditLogStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((auditLogs) {
        organization.auditLogs = auditLogs;
    });

}

	Stream<List<AutomationExecution>> getAutomationExecutions$(
    Organization organization, {bool useCache = true, ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}) {
    return AutomationExecutionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((automationExecutions) {
        organization.automationExecutions = automationExecutions;
    });

}

	Stream<List<AutomationRule>> getAutomationRules$(
    Organization organization, {bool useCache = true, ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}) {
    return AutomationRuleStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((automationRules) {
        organization.automationRules = automationRules;
    });

}

	Stream<List<Booking>> getBookings$(
    Organization organization, {bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    return BookingStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((bookings) {
        organization.bookings = bookings;
    });

}

	Stream<List<Budget>> getBudgets$(
    Organization organization, {bool useCache = true, ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}) {
    return BudgetStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((budgets) {
        organization.budgets = budgets;
    });

}

	Stream<List<CalendarEvent>> getCalendarEvents$(
    Organization organization, {bool useCache = true, ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}) {
    return CalendarEventStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((calendarEvents) {
        organization.calendarEvents = calendarEvents;
    });

}

	Stream<List<Commission>> getCommissions$(
    Organization organization, {bool useCache = true, ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}) {
    return CommissionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((commissions) {
        organization.commissions = commissions;
    });

}

	Stream<List<CommunicationTemplate>> getCommunicationTemplates$(
    Organization organization, {bool useCache = true, ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}) {
    return CommunicationTemplateStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((communicationTemplates) {
        organization.communicationTemplates = communicationTemplates;
    });

}

	Stream<List<Contact>> getContacts$(
    Organization organization, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    return ContactStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((contacts) {
        organization.contacts = contacts;
    });

}

	Stream<List<Contract>> getContracts$(
    Organization organization, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    return ContractStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((contracts) {
        organization.contracts = contracts;
    });

}

	Stream<List<ContractVersion>> getContractVersions$(
    Organization organization, {bool useCache = true, ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}) {
    return ContractVersionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((contractVersions) {
        organization.contractVersions = contractVersions;
    });

}

	Stream<List<DashboardConfiguration>> getDashboardConfigurations$(
    Organization organization, {bool useCache = true, ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}) {
    return DashboardConfigurationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((dashboardConfigurations) {
        organization.dashboardConfigurations = dashboardConfigurations;
    });

}

	Stream<List<DashboardWidget>> getDashboardWidgets$(
    Organization organization, {bool useCache = true, ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}) {
    return DashboardWidgetStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((dashboardWidgets) {
        organization.dashboardWidgets = dashboardWidgets;
    });

}

	Stream<List<Deal>> getDeals$(
    Organization organization, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    return DealStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((deals) {
        organization.deals = deals;
    });

}

	Stream<List<DepositProtection>> getDepositProtections$(
    Organization organization, {bool useCache = true, ModelFilter<DepositProtection>? modelFilter, List<DepositProtectionInclude>? includes}) {
    return DepositProtectionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((depositProtections) {
        organization.depositProtections = depositProtections;
    });

}

	Stream<List<Document>> getDocuments$(
    Organization organization, {bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    return DocumentStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((documents) {
        organization.documents = documents;
    });

}

	Stream<List<DocumentTemplate>> getDocumentTemplates$(
    Organization organization, {bool useCache = true, ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}) {
    return DocumentTemplateStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((documentTemplates) {
        organization.documentTemplates = documentTemplates;
    });

}

	Stream<List<Earning>> getEarnings$(
    Organization organization, {bool useCache = true, ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}) {
    return EarningStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((earnings) {
        organization.earnings = earnings;
    });

}

	Stream<List<Event>> getEvents$(
    Organization organization, {bool useCache = true, ModelFilter<Event>? modelFilter, List<EventInclude>? includes}) {
    return EventStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((events) {
        organization.events = events;
    });

}

	Stream<List<EventAttendee>> getEventAttendees$(
    Organization organization, {bool useCache = true, ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    return EventAttendeeStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((eventAttendees) {
        organization.eventAttendees = eventAttendees;
    });

}

	Stream<List<ExchangeRate>> getExchangeRates$(
    Organization organization, {bool useCache = true, ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}) {
    return ExchangeRateStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((exchangeRates) {
        organization.exchangeRates = exchangeRates;
    });

}

	Stream<List<ExportFile>> getExportFiles$(
    Organization organization, {bool useCache = true, ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}) {
    return ExportFileStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((exportFiles) {
        organization.exportFiles = exportFiles;
    });

}

	Stream<List<ExportJob>> getExportJobs$(
    Organization organization, {bool useCache = true, ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}) {
    return ExportJobStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((exportJobs) {
        organization.exportJobs = exportJobs;
    });

}

	Stream<List<ExternalRentalListing>> getExternalRentalListings$(
    Organization organization, {bool useCache = true, ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}) {
    return ExternalRentalListingStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((externalRentalListings) {
        organization.externalRentalListings = externalRentalListings;
    });

}

	Stream<List<Facility>> getFacilities$(
    Organization organization, {bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    return FacilityStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((facilities) {
        organization.facilities = facilities;
    });

}

	Stream<List<FinancialRecord>> getFinancialRecords$(
    Organization organization, {bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    return FinancialRecordStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((financialRecords) {
        organization.financialRecords = financialRecords;
    });

}

	Stream<List<FloorPlan>> getFloorPlans$(
    Organization organization, {bool useCache = true, ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}) {
    return FloorPlanStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((floorPlans) {
        organization.floorPlans = floorPlans;
    });

}

	Stream<List<GiftCard>> getGiftCards$(
    Organization organization, {bool useCache = true, ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}) {
    return GiftCardStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((giftCards) {
        organization.giftCards = giftCards;
    });

}

	Stream<List<GovernmentIntegration>> getGovtIntegrations$(
    Organization organization, {bool useCache = true, ModelFilter<GovernmentIntegration>? modelFilter, List<GovernmentIntegrationInclude>? includes}) {
    return GovernmentIntegrationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((govtIntegrations) {
        organization.govtIntegrations = govtIntegrations;
    });

}

	Stream<List<HealthCheck>> getHealthChecks$(
    Organization organization, {bool useCache = true, ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}) {
    return HealthCheckStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((healthChecks) {
        organization.healthChecks = healthChecks;
    });

}

	Stream<List<HomeInformationPack>> getHomeInformationPacks$(
    Organization organization, {bool useCache = true, ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}) {
    return HomeInformationPackStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((homeInformationPacks) {
        organization.homeInformationPacks = homeInformationPacks;
    });

}

	Stream<List<ImmigrationStatusCheck>> getImmigrationStatusChecks$(
    Organization organization, {bool useCache = true, ModelFilter<ImmigrationStatusCheck>? modelFilter, List<ImmigrationStatusCheckInclude>? includes}) {
    return ImmigrationStatusCheckStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((immigrationStatusChecks) {
        organization.immigrationStatusChecks = immigrationStatusChecks;
    });

}

	Stream<List<IntegrationLog>> getIntegrationLogs$(
    Organization organization, {bool useCache = true, ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}) {
    return IntegrationLogStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((integrationLogs) {
        organization.integrationLogs = integrationLogs;
    });

}

	Stream<List<InvestorPortfolio>> getInvestorPortfolios$(
    Organization organization, {bool useCache = true, ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}) {
    return InvestorPortfolioStore.instance.getByOrganizationId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((investorPortfolios) {
        organization.investorPortfolios = investorPortfolios;
    });

}

	Stream<List<KeyManagement>> getKeys$(
    Organization organization, {bool useCache = true, ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}) {
    return KeyManagementStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((keys) {
        organization.keys = keys;
    });

}

	Stream<List<Lead>> getLeads$(
    Organization organization, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    return LeadStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leads) {
        organization.leads = leads;
    });

}

	Stream<List<LeadSource>> getLeadSources$(
    Organization organization, {bool useCache = true, ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}) {
    return LeadSourceStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leadSources) {
        organization.leadSources = leadSources;
    });

}

	Stream<List<Lease>> getLeases$(
    Organization organization, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    return LeaseStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leases) {
        organization.leases = leases;
    });

}

	Stream<List<LeaseRenewal>> getLeaseRenewals$(
    Organization organization, {bool useCache = true, ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}) {
    return LeaseRenewalStore.instance.getByOrganizationId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leaseRenewals) {
        organization.leaseRenewals = leaseRenewals;
    });

}

	Stream<List<LedgerEntry>> getLedgerEntries$(
    Organization organization, {bool useCache = true, ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}) {
    return LedgerEntryStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((ledgerEntries) {
        organization.ledgerEntries = ledgerEntries;
    });

}

	Stream<List<Listing>> getListings$(
    Organization organization, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    return ListingStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((listings) {
        organization.listings = listings;
    });

}

	Stream<List<ListingChannel>> getListingChannels$(
    Organization organization, {bool useCache = true, ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}) {
    return ListingChannelStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((listingChannels) {
        organization.listingChannels = listingChannels;
    });

}

	Stream<List<ListingStatusHistory>> getListingStatusHistories$(
    Organization organization, {bool useCache = true, ModelFilter<ListingStatusHistory>? modelFilter, List<ListingStatusHistoryInclude>? includes}) {
    return ListingStatusHistoryStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((listingStatusHistories) {
        organization.listingStatusHistories = listingStatusHistories;
    });

}

	Stream<List<ListingTag>> getListingTags$(
    Organization organization, {bool useCache = true, ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}) {
    return ListingTagStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((listingTags) {
        organization.listingTags = listingTags;
    });

}

	Stream<List<Location>> getLocations$(
    Organization organization, {bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    return LocationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((locations) {
        organization.locations = locations;
    });

}

	Stream<List<LoyaltyAccount>> getLoyaltyAccounts$(
    Organization organization, {bool useCache = true, ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}) {
    return LoyaltyAccountStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((loyaltyAccounts) {
        organization.loyaltyAccounts = loyaltyAccounts;
    });

}

	Stream<List<MLSConnection>> getMlsConnections$(
    Organization organization, {bool useCache = true, ModelFilter<MLSConnection>? modelFilter, List<MLSConnectionInclude>? includes}) {
    return MLSConnectionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mlsConnections) {
        organization.mlsConnections = mlsConnections;
    });

}

	Stream<List<MLSExternalListing>> getMlsexternalListings$(
    Organization organization, {bool useCache = true, ModelFilter<MLSExternalListing>? modelFilter, List<MLSExternalListingInclude>? includes}) {
    return MLSExternalListingStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mlsexternalListings) {
        organization.mlsexternalListings = mlsexternalListings;
    });

}

	Stream<List<MLSSyncJob>> getMlssyncJobs$(
    Organization organization, {bool useCache = true, ModelFilter<MLSSyncJob>? modelFilter, List<MLSSyncJobInclude>? includes}) {
    return MLSSyncJobStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mlssyncJobs) {
        organization.mlssyncJobs = mlssyncJobs;
    });

}

	Stream<List<MaintenanceBlock>> getMaintenanceBlocks$(
    Organization organization, {bool useCache = true, ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}) {
    return MaintenanceBlockStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((maintenanceBlocks) {
        organization.maintenanceBlocks = maintenanceBlocks;
    });

}

	Stream<List<MaintenanceWorkOrder>> getWorkOrders$(
    Organization organization, {bool useCache = true, ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    return MaintenanceWorkOrderStore.instance.getByOrganizationId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((workOrders) {
        organization.workOrders = workOrders;
    });

}

	Stream<List<MapLayer>> getMapLayers$(
    Organization organization, {bool useCache = true, ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}) {
    return MapLayerStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mapLayers) {
        organization.mapLayers = mapLayers;
    });

}

	Stream<List<MarketingCampaign>> getMarketingCampaigns$(
    Organization organization, {bool useCache = true, ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}) {
    return MarketingCampaignStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((marketingCampaigns) {
        organization.marketingCampaigns = marketingCampaigns;
    });

}

	Stream<List<Message>> getMessages$(
    Organization organization, {bool useCache = true, ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}) {
    return MessageStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((messages) {
        organization.messages = messages;
    });

}

	Stream<List<MlsDataMapping>> getMlsDataMappings$(
    Organization organization, {bool useCache = true, ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}) {
    return MlsDataMappingStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mlsDataMappings) {
        organization.mlsDataMappings = mlsDataMappings;
    });

}

	Stream<List<MlsListingEnhancement>> getMlsListingEnhancements$(
    Organization organization, {bool useCache = true, ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}) {
    return MlsListingEnhancementStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mlsListingEnhancements) {
        organization.mlsListingEnhancements = mlsListingEnhancements;
    });

}

	Stream<List<MobileDevice>> getMobileDevices$(
    Organization organization, {bool useCache = true, ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}) {
    return MobileDeviceStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mobileDevices) {
        organization.mobileDevices = mobileDevices;
    });

}

	Stream<List<MortgageOffer>> getMortgageOffers$(
    Organization organization, {bool useCache = true, ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}) {
    return MortgageOfferStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mortgageOffers) {
        organization.mortgageOffers = mortgageOffers;
    });

}

	Stream<List<MortgagePreApproval>> getMortgagePreApprovals$(
    Organization organization, {bool useCache = true, ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}) {
    return MortgagePreApprovalStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mortgagePreApprovals) {
        organization.mortgagePreApprovals = mortgagePreApprovals;
    });

}

	Stream<List<Neighborhood>> getNeighborhoods$(
    Organization organization, {bool useCache = true, ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}) {
    return NeighborhoodStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((neighborhoods) {
        organization.neighborhoods = neighborhoods;
    });

}

	Stream<List<Notification>> getNotifications$(
    Organization organization, {bool useCache = true, ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    return NotificationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((notifications) {
        organization.notifications = notifications;
    });

}

	Stream<List<OfflineSyncQueue>> getOfflineSyncQueues$(
    Organization organization, {bool useCache = true, ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}) {
    return OfflineSyncQueueStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((offlineSyncQueues) {
        organization.offlineSyncQueues = offlineSyncQueues;
    });

}

	Stream<OrgSubscription?> getOrgSubscription$(
    Organization organization, {bool useCache = true, ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}) {
    return OrgSubscriptionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((orgSubscription) {
        organization.orgSubscription = orgSubscription;
    });

}

	Stream<List<Payout>> getPayouts$(
    Organization organization, {bool useCache = true, ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    return PayoutStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((payouts) {
        organization.payouts = payouts;
    });

}

	Stream<List<PerformanceAlert>> getPerformanceAlerts$(
    Organization organization, {bool useCache = true, ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}) {
    return PerformanceAlertStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((performanceAlerts) {
        organization.performanceAlerts = performanceAlerts;
    });

}

	Stream<List<PredictiveModel>> getPredictiveModels$(
    Organization organization, {bool useCache = true, ModelFilter<PredictiveModel>? modelFilter, List<PredictiveModelInclude>? includes}) {
    return PredictiveModelStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((predictiveModels) {
        organization.predictiveModels = predictiveModels;
    });

}

	Stream<List<Project>> getProjects$(
    Organization organization, {bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    return ProjectStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((projects) {
        organization.projects = projects;
    });

}

	Stream<List<Property>> getProperties$(
    Organization organization, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((properties) {
        organization.properties = properties;
    });

}

	Stream<List<PropertyAmenity>> getPropertyAmenities$(
    Organization organization, {bool useCache = true, ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}) {
    return PropertyAmenityStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyAmenities) {
        organization.propertyAmenities = propertyAmenities;
    });

}

	Stream<List<PropertyCompliance>> getPropertyCompliance$(
    Organization organization, {bool useCache = true, ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    return PropertyComplianceStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyCompliance) {
        organization.propertyCompliance = propertyCompliance;
    });

}

	Stream<List<PropertyDisclosure>> getPropertyDisclosures$(
    Organization organization, {bool useCache = true, ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}) {
    return PropertyDisclosureStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyDisclosures) {
        organization.propertyDisclosures = propertyDisclosures;
    });

}

	Stream<List<PropertyDocument>> getPropertyDocuments$(
    Organization organization, {bool useCache = true, ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}) {
    return PropertyDocumentStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyDocuments) {
        organization.propertyDocuments = propertyDocuments;
    });

}

	Stream<List<PropertyInventory>> getInventories$(
    Organization organization, {bool useCache = true, ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}) {
    return PropertyInventoryStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((inventories) {
        organization.inventories = inventories;
    });

}

	Stream<List<PropertyOffer>> getPropertyOffers$(
    Organization organization, {bool useCache = true, ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    return PropertyOfferStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyOffers) {
        organization.propertyOffers = propertyOffers;
    });

}

	Stream<List<PropertyPhoto>> getPropertyPhotos$(
    Organization organization, {bool useCache = true, ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}) {
    return PropertyPhotoStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyPhotos) {
        organization.propertyPhotos = propertyPhotos;
    });

}

	Stream<List<PropertyViewing>> getPropertyViewings$(
    Organization organization, {bool useCache = true, ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    return PropertyViewingStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyViewings) {
        organization.propertyViewings = propertyViewings;
    });

}

	Stream<List<QueueConfiguration>> getQueueConfigurations$(
    Organization organization, {bool useCache = true, ModelFilter<QueueConfiguration>? modelFilter, List<QueueConfigurationInclude>? includes}) {
    return QueueConfigurationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((queueConfigurations) {
        organization.queueConfigurations = queueConfigurations;
    });

}

	Stream<List<QueueMessage>> getQueueMessages$(
    Organization organization, {bool useCache = true, ModelFilter<QueueMessage>? modelFilter, List<QueueMessageInclude>? includes}) {
    return QueueMessageStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((queueMessages) {
        organization.queueMessages = queueMessages;
    });

}

	Stream<List<Quote>> getQuotes$(
    Organization organization, {bool useCache = true, ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    return QuoteStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((quotes) {
        organization.quotes = quotes;
    });

}

	Stream<List<RecommendationResult>> getRecommendationResults$(
    Organization organization, {bool useCache = true, ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}) {
    return RecommendationResultStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((recommendationResults) {
        organization.recommendationResults = recommendationResults;
    });

}

	Stream<List<Referral>> getReferrals$(
    Organization organization, {bool useCache = true, ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}) {
    return ReferralStore.instance.getByOrganizationId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((referrals) {
        organization.referrals = referrals;
    });

}

	Stream<List<RentArrears>> getRentArrears$(
    Organization organization, {bool useCache = true, ModelFilter<RentArrears>? modelFilter, List<RentArrearsInclude>? includes}) {
    return RentArrearsStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rentArrears) {
        organization.rentArrears = rentArrears;
    });

}

	Stream<List<RentSchedule>> getRentSchedules$(
    Organization organization, {bool useCache = true, ModelFilter<RentSchedule>? modelFilter, List<RentScheduleInclude>? includes}) {
    return RentScheduleStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rentSchedules) {
        organization.rentSchedules = rentSchedules;
    });

}

	Stream<List<RentalSyncJob>> getRentalSyncJobs$(
    Organization organization, {bool useCache = true, ModelFilter<RentalSyncJob>? modelFilter, List<RentalSyncJobInclude>? includes}) {
    return RentalSyncJobStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rentalSyncJobs) {
        organization.rentalSyncJobs = rentalSyncJobs;
    });

}

	Stream<List<Report>> getReports$(
    Organization organization, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    return ReportStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reports) {
        organization.reports = reports;
    });

}

	Stream<List<ReportExecution>> getReportExecutions$(
    Organization organization, {bool useCache = true, ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}) {
    return ReportExecutionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reportExecutions) {
        organization.reportExecutions = reportExecutions;
    });

}

	Stream<List<Reservation>> getReservations$(
    Organization organization, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reservations) {
        organization.reservations = reservations;
    });

}

	Stream<List<Review>> getReviews$(
    Organization organization, {bool useCache = true, ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}) {
    return ReviewStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reviews) {
        organization.reviews = reviews;
    });

}

	Stream<List<RightToRentCheck>> getRightToRentChecks$(
    Organization organization, {bool useCache = true, ModelFilter<RightToRentCheck>? modelFilter, List<RightToRentCheckInclude>? includes}) {
    return RightToRentCheckStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((rightToRentChecks) {
        organization.rightToRentChecks = rightToRentChecks;
    });

}

	Stream<List<Role>> getRoles$(
    Organization organization, {bool useCache = true, ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}) {
    return RoleStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((roles) {
        organization.roles = roles;
    });

}

	Stream<List<Route>> getRoutes$(
    Organization organization, {bool useCache = true, ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}) {
    return RouteStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((routes) {
        organization.routes = routes;
    });

}

	Stream<List<SecurityDepositProtection>> getSecurityDepositProtections$(
    Organization organization, {bool useCache = true, ModelFilter<SecurityDepositProtection>? modelFilter, List<SecurityDepositProtectionInclude>? includes}) {
    return SecurityDepositProtectionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((securityDepositProtections) {
        organization.securityDepositProtections = securityDepositProtections;
    });

}

	Stream<List<SignatureRequest>> getSignatureRequests$(
    Organization organization, {bool useCache = true, ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}) {
    return SignatureRequestStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((signatureRequests) {
        organization.signatureRequests = signatureRequests;
    });

}

	Stream<List<SignatureSigner>> getSignatureSigners$(
    Organization organization, {bool useCache = true, ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    return SignatureSignerStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((signatureSigners) {
        organization.signatureSigners = signatureSigners;
    });

}

	Stream<List<SolicitorManagement>> getSolicitorManagements$(
    Organization organization, {bool useCache = true, ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}) {
    return SolicitorManagementStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((solicitorManagements) {
        organization.solicitorManagements = solicitorManagements;
    });

}

	Stream<List<Subscription>> getSubscriptions$(
    Organization organization, {bool useCache = true, ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    return SubscriptionStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((subscriptions) {
        organization.subscriptions = subscriptions;
    });

}

	Stream<List<SystemMetrics>> getSystemMetrics$(
    Organization organization, {bool useCache = true, ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}) {
    return SystemMetricsStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((systemMetrics) {
        organization.systemMetrics = systemMetrics;
    });

}

	Stream<List<Tag>> getTags$(
    Organization organization, {bool useCache = true, ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}) {
    return TagStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tags) {
        organization.tags = tags;
    });

}

	Stream<List<Task>> getTasks$(
    Organization organization, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        organization.tasks = tasks;
    });

}

	Stream<List<Tax1099Form>> getTax1099Forms$(
    Organization organization, {bool useCache = true, ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}) {
    return Tax1099FormStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tax1099Forms) {
        organization.tax1099Forms = tax1099Forms;
    });

}

	Stream<List<TaxDepreciation>> getTaxDepreciations$(
    Organization organization, {bool useCache = true, ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}) {
    return TaxDepreciationStore.instance.getByOrganizationId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((taxDepreciations) {
        organization.taxDepreciations = taxDepreciations;
    });

}

	Stream<List<TaxRecord>> getTaxRecords$(
    Organization organization, {bool useCache = true, ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    return TaxRecordStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((taxRecords) {
        organization.taxRecords = taxRecords;
    });

}

	Stream<List<TenantApplication>> getTenantApplications$(
    Organization organization, {bool useCache = true, ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    return TenantApplicationStore.instance.getByOrganizationId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenantApplications) {
        organization.tenantApplications = tenantApplications;
    });

}

	Stream<List<UserActivityLog>> getUserActivityLogs$(
    Organization organization, {bool useCache = true, ModelFilter<UserActivityLog>? modelFilter, List<UserActivityLogInclude>? includes}) {
    return UserActivityLogStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((userActivityLogs) {
        organization.userActivityLogs = userActivityLogs;
    });

}

	Stream<List<UserPreference>> getUserPreferences$(
    Organization organization, {bool useCache = true, ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}) {
    return UserPreferenceStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((userPreferences) {
        organization.userPreferences = userPreferences;
    });

}

	Stream<List<VacationRental>> getVacationRentals$(
    Organization organization, {bool useCache = true, ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}) {
    return VacationRentalStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((vacationRentals) {
        organization.vacationRentals = vacationRentals;
    });

}

	Stream<List<VendorProfile>> getVendors$(
    Organization organization, {bool useCache = true, ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}) {
    return VendorProfileStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((vendors) {
        organization.vendors = vendors;
    });

}

	Stream<List<VirtualTour>> getVirtualTours$(
    Organization organization, {bool useCache = true, ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}) {
    return VirtualTourStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((virtualTours) {
        organization.virtualTours = virtualTours;
    });

}

	Stream<List<Webhook>> getWebhooks$(
    Organization organization, {bool useCache = true, ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}) {
    return WebhookStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((webhooks) {
        organization.webhooks = webhooks;
    });

}

	Stream<List<WebhookDelivery>> getWebhookDeliveries$(
    Organization organization, {bool useCache = true, ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}) {
    return WebhookDeliveryStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((webhookDeliveries) {
        organization.webhookDeliveries = webhookDeliveries;
    });

}

	Stream<List<EscrowAccount>> getEscrowAccounts$(
    Organization organization, {bool useCache = true, ModelFilter<EscrowAccount>? modelFilter, List<EscrowAccountInclude>? includes}) {
    return EscrowAccountStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((escrowAccounts) {
        organization.escrowAccounts = escrowAccounts;
    });

}

	Stream<List<EscrowRelease>> getEscrowReleases$(
    Organization organization, {bool useCache = true, ModelFilter<EscrowRelease>? modelFilter, List<EscrowReleaseInclude>? includes}) {
    return EscrowReleaseStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((escrowReleases) {
        organization.escrowReleases = escrowReleases;
    });

}

	Stream<List<EscrowDispute>> getEscrowDisputes$(
    Organization organization, {bool useCache = true, ModelFilter<EscrowDispute>? modelFilter, List<EscrowDisputeInclude>? includes}) {
    return EscrowDisputeStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((escrowDisputes) {
        organization.escrowDisputes = escrowDisputes;
    });

}

	Stream<List<PaymentNegotiation>> getPaymentNegotiations$(
    Organization organization, {bool useCache = true, ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    return PaymentNegotiationStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((paymentNegotiations) {
        organization.paymentNegotiations = paymentNegotiations;
    });

}

	Stream<List<PaymentInstallment>> getPaymentInstallments$(
    Organization organization, {bool useCache = true, ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}) {
    return PaymentInstallmentStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((paymentInstallments) {
        organization.paymentInstallments = paymentInstallments;
    });

}

	Stream<List<VideoContent>> getVideoContents$(
    Organization organization, {bool useCache = true, ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    return VideoContentStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((videoContents) {
        organization.videoContents = videoContents;
    });

}

	Stream<List<BrandAmbassador>> getBrandAmbassadors$(
    Organization organization, {bool useCache = true, ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    return BrandAmbassadorStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((brandAmbassadors) {
        organization.brandAmbassadors = brandAmbassadors;
    });

}

	Stream<List<AmbassadorCampaign>> getAmbassadorCampaigns$(
    Organization organization, {bool useCache = true, ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    return AmbassadorCampaignStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((ambassadorCampaigns) {
        organization.ambassadorCampaigns = ambassadorCampaigns;
    });

}

	Stream<List<SocialImpactCounter>> getSocialImpactCounters$(
    Organization organization, {bool useCache = true, ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}) {
    return SocialImpactCounterStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((socialImpactCounters) {
        organization.socialImpactCounters = socialImpactCounters;
    });

}

	Stream<List<SocialImpactRecord>> getSocialImpactRecords$(
    Organization organization, {bool useCache = true, ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}) {
    return SocialImpactRecordStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((socialImpactRecords) {
        organization.socialImpactRecords = socialImpactRecords;
    });

}

	Stream<List<NegotiationOffer>> getNegotiationOffers$(
    Organization organization, {bool useCache = true, ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}) {
    return NegotiationOfferStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((negotiationOffers) {
        organization.negotiationOffers = negotiationOffers;
    });

}

	Stream<List<AmbassadorContract>> getAmbassadorContracts$(
    Organization organization, {bool useCache = true, ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}) {
    return AmbassadorContractStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((ambassadorContracts) {
        organization.ambassadorContracts = ambassadorContracts;
    });

}

	Stream<List<EscrowStatusHistory>> getEscrowStatusHistories$(
    Organization organization, {bool useCache = true, ModelFilter<EscrowStatusHistory>? modelFilter, List<EscrowStatusHistoryInclude>? includes}) {
    return EscrowStatusHistoryStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((escrowStatusHistories) {
        organization.escrowStatusHistories = escrowStatusHistories;
    });

}

	Stream<List<AIChatMessage>> getAiChatMessages$(
    Organization organization, {bool useCache = true, ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    return AIChatMessageStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiChatMessages) {
        organization.aiChatMessages = aiChatMessages;
    });

}

	Stream<List<AIChatHandoff>> getAiChatHandoffs$(
    Organization organization, {bool useCache = true, ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}) {
    return AIChatHandoffStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiChatHandoffs) {
        organization.aiChatHandoffs = aiChatHandoffs;
    });

}

	Stream<List<DocumentAnalysis>> getAnalyses$(
    Organization organization, {bool useCache = true, ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}) {
    return DocumentAnalysisStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analyses) {
        organization.analyses = analyses;
    });

}

	Stream<List<AnalysisJob>> getAnalysisJobs$(
    Organization organization, {bool useCache = true, ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}) {
    return AnalysisJobStore.instance.getByOrgId$(
        organization.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analysisJobs) {
        organization.analysisJobs = analysisJobs;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Organization recursiveUpsert(Organization organization, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Organization'} 
        : const {};
    if (organization.aiChatbotSessions != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatbotSession'))) {
        organization.aiChatbotSessions = AIChatbotSessionStore.instance.recursiveListUpsert(organization.aiChatbotSessions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiFraudDetections != null && (!preventCircularSerialization || !upsertedTypes.contains('AIFraudDetection'))) {
        organization.aiFraudDetections = AIFraudDetectionStore.instance.recursiveListUpsert(organization.aiFraudDetections!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiImageAnalyses != null && (!preventCircularSerialization || !upsertedTypes.contains('AIImageAnalysis'))) {
        organization.aiImageAnalyses = AIImageAnalysisStore.instance.recursiveListUpsert(organization.aiImageAnalyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiInvestmentAnalyses != null && (!preventCircularSerialization || !upsertedTypes.contains('AIInvestmentAnalysis'))) {
        organization.aiInvestmentAnalyses = AIInvestmentAnalysisStore.instance.recursiveListUpsert(organization.aiInvestmentAnalyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiLeadScores != null && (!preventCircularSerialization || !upsertedTypes.contains('AILeadScore'))) {
        organization.aiLeadScores = AILeadScoreStore.instance.recursiveListUpsert(organization.aiLeadScores!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiLeadScoringModels != null && (!preventCircularSerialization || !upsertedTypes.contains('AILeadScoring'))) {
        organization.aiLeadScoringModels = AILeadScoringStore.instance.recursiveListUpsert(organization.aiLeadScoringModels!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiMarketAnalyses != null && (!preventCircularSerialization || !upsertedTypes.contains('AIMarketAnalysis'))) {
        organization.aiMarketAnalyses = AIMarketAnalysisStore.instance.recursiveListUpsert(organization.aiMarketAnalyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiModels != null && (!preventCircularSerialization || !upsertedTypes.contains('AIModel'))) {
        organization.aiModels = AIModelStore.instance.recursiveListUpsert(organization.aiModels!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiModelDeployments != null && (!preventCircularSerialization || !upsertedTypes.contains('AIModelDeployment'))) {
        organization.aiModelDeployments = AIModelDeploymentStore.instance.recursiveListUpsert(organization.aiModelDeployments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiPredictions != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPrediction'))) {
        organization.aiPredictions = AIPredictionStore.instance.recursiveListUpsert(organization.aiPredictions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiPredictiveMaintenance != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPredictiveMaintenance'))) {
        organization.aiPredictiveMaintenance = AIPredictiveMaintenanceStore.instance.recursiveListUpsert(organization.aiPredictiveMaintenance!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiPriceOptimizations != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPriceOptimization'))) {
        organization.aiPriceOptimizations = AIPriceOptimizationStore.instance.recursiveListUpsert(organization.aiPriceOptimizations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiPropertyDescriptions != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPropertyDescription'))) {
        organization.aiPropertyDescriptions = AIPropertyDescriptionStore.instance.recursiveListUpsert(organization.aiPropertyDescriptions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiPropertyValuations != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPropertyValuation'))) {
        organization.aiPropertyValuations = AIPropertyValuationStore.instance.recursiveListUpsert(organization.aiPropertyValuations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiRecommendations != null && (!preventCircularSerialization || !upsertedTypes.contains('AIRecommendation'))) {
        organization.aiRecommendations = AIRecommendationStore.instance.recursiveListUpsert(organization.aiRecommendations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiSentimentAnalyses != null && (!preventCircularSerialization || !upsertedTypes.contains('AISentimentAnalysis'))) {
        organization.aiSentimentAnalyses = AISentimentAnalysisStore.instance.recursiveListUpsert(organization.aiSentimentAnalyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiTenantScreenings != null && (!preventCircularSerialization || !upsertedTypes.contains('AITenantScreening'))) {
        organization.aiTenantScreenings = AITenantScreeningStore.instance.recursiveListUpsert(organization.aiTenantScreenings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiValuationModels != null && (!preventCircularSerialization || !upsertedTypes.contains('AIValuationModel'))) {
        organization.aiValuationModels = AIValuationModelStore.instance.recursiveListUpsert(organization.aiValuationModels!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.integrations != null && (!preventCircularSerialization || !upsertedTypes.contains('APIIntegration'))) {
        organization.integrations = APIIntegrationStore.instance.recursiveListUpsert(organization.integrations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.achievements != null && (!preventCircularSerialization || !upsertedTypes.contains('Achievement'))) {
        organization.achievements = AchievementStore.instance.recursiveListUpsert(organization.achievements!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        organization.agencies = AgencyStore.instance.recursiveListUpsert(organization.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.agencyRelations != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        organization.agencyRelations = AgencyStore.instance.recursiveListUpsert(organization.agencyRelations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.organizationAgencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        organization.organizationAgencies = AgencyStore.instance.recursiveListUpsert(organization.organizationAgencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.agentAssignments != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentAssignment'))) {
        organization.agentAssignments = AgentAssignmentStore.instance.recursiveListUpsert(organization.agentAssignments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.agentTeams != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentTeam'))) {
        organization.agentTeams = AgentTeamStore.instance.recursiveListUpsert(organization.agentTeams!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.amenities != null && (!preventCircularSerialization || !upsertedTypes.contains('Amenity'))) {
        organization.amenities = AmenityStore.instance.recursiveListUpsert(organization.amenities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.apiIntegrations != null && (!preventCircularSerialization || !upsertedTypes.contains('ApiIntegration'))) {
        organization.apiIntegrations = ApiIntegrationStore.instance.recursiveListUpsert(organization.apiIntegrations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.apiKeys != null && (!preventCircularSerialization || !upsertedTypes.contains('ApiKey'))) {
        organization.apiKeys = ApiKeyStore.instance.recursiveListUpsert(organization.apiKeys!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.appointments != null && (!preventCircularSerialization || !upsertedTypes.contains('Appointment'))) {
        organization.appointments = AppointmentStore.instance.recursiveListUpsert(organization.appointments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.attachments != null && (!preventCircularSerialization || !upsertedTypes.contains('Attachment'))) {
        organization.attachments = AttachmentStore.instance.recursiveListUpsert(organization.attachments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.attorneyCases != null && (!preventCircularSerialization || !upsertedTypes.contains('AttorneyManagement'))) {
        organization.attorneyCases = AttorneyManagementStore.instance.recursiveListUpsert(organization.attorneyCases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.auditLogs != null && (!preventCircularSerialization || !upsertedTypes.contains('AuditLog'))) {
        organization.auditLogs = AuditLogStore.instance.recursiveListUpsert(organization.auditLogs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.automationExecutions != null && (!preventCircularSerialization || !upsertedTypes.contains('AutomationExecution'))) {
        organization.automationExecutions = AutomationExecutionStore.instance.recursiveListUpsert(organization.automationExecutions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.automationRules != null && (!preventCircularSerialization || !upsertedTypes.contains('AutomationRule'))) {
        organization.automationRules = AutomationRuleStore.instance.recursiveListUpsert(organization.automationRules!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.bookings != null && (!preventCircularSerialization || !upsertedTypes.contains('Booking'))) {
        organization.bookings = BookingStore.instance.recursiveListUpsert(organization.bookings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.budgets != null && (!preventCircularSerialization || !upsertedTypes.contains('Budget'))) {
        organization.budgets = BudgetStore.instance.recursiveListUpsert(organization.budgets!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.calendarEvents != null && (!preventCircularSerialization || !upsertedTypes.contains('CalendarEvent'))) {
        organization.calendarEvents = CalendarEventStore.instance.recursiveListUpsert(organization.calendarEvents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.commissions != null && (!preventCircularSerialization || !upsertedTypes.contains('Commission'))) {
        organization.commissions = CommissionStore.instance.recursiveListUpsert(organization.commissions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.communicationTemplates != null && (!preventCircularSerialization || !upsertedTypes.contains('CommunicationTemplate'))) {
        organization.communicationTemplates = CommunicationTemplateStore.instance.recursiveListUpsert(organization.communicationTemplates!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.contacts != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        organization.contacts = ContactStore.instance.recursiveListUpsert(organization.contacts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.contracts != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        organization.contracts = ContractStore.instance.recursiveListUpsert(organization.contracts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.contractVersions != null && (!preventCircularSerialization || !upsertedTypes.contains('ContractVersion'))) {
        organization.contractVersions = ContractVersionStore.instance.recursiveListUpsert(organization.contractVersions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.dashboardConfigurations != null && (!preventCircularSerialization || !upsertedTypes.contains('DashboardConfiguration'))) {
        organization.dashboardConfigurations = DashboardConfigurationStore.instance.recursiveListUpsert(organization.dashboardConfigurations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.dashboardWidgets != null && (!preventCircularSerialization || !upsertedTypes.contains('DashboardWidget'))) {
        organization.dashboardWidgets = DashboardWidgetStore.instance.recursiveListUpsert(organization.dashboardWidgets!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.deals != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        organization.deals = DealStore.instance.recursiveListUpsert(organization.deals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.depositProtections != null && (!preventCircularSerialization || !upsertedTypes.contains('DepositProtection'))) {
        organization.depositProtections = DepositProtectionStore.instance.recursiveListUpsert(organization.depositProtections!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.documents != null && (!preventCircularSerialization || !upsertedTypes.contains('Document'))) {
        organization.documents = DocumentStore.instance.recursiveListUpsert(organization.documents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.documentTemplates != null && (!preventCircularSerialization || !upsertedTypes.contains('DocumentTemplate'))) {
        organization.documentTemplates = DocumentTemplateStore.instance.recursiveListUpsert(organization.documentTemplates!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.earnings != null && (!preventCircularSerialization || !upsertedTypes.contains('Earning'))) {
        organization.earnings = EarningStore.instance.recursiveListUpsert(organization.earnings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.events != null && (!preventCircularSerialization || !upsertedTypes.contains('Event'))) {
        organization.events = EventStore.instance.recursiveListUpsert(organization.events!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.eventAttendees != null && (!preventCircularSerialization || !upsertedTypes.contains('EventAttendee'))) {
        organization.eventAttendees = EventAttendeeStore.instance.recursiveListUpsert(organization.eventAttendees!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.exchangeRates != null && (!preventCircularSerialization || !upsertedTypes.contains('ExchangeRate'))) {
        organization.exchangeRates = ExchangeRateStore.instance.recursiveListUpsert(organization.exchangeRates!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.exportFiles != null && (!preventCircularSerialization || !upsertedTypes.contains('ExportFile'))) {
        organization.exportFiles = ExportFileStore.instance.recursiveListUpsert(organization.exportFiles!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.exportJobs != null && (!preventCircularSerialization || !upsertedTypes.contains('ExportJob'))) {
        organization.exportJobs = ExportJobStore.instance.recursiveListUpsert(organization.exportJobs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.externalRentalListings != null && (!preventCircularSerialization || !upsertedTypes.contains('ExternalRentalListing'))) {
        organization.externalRentalListings = ExternalRentalListingStore.instance.recursiveListUpsert(organization.externalRentalListings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.facilities != null && (!preventCircularSerialization || !upsertedTypes.contains('Facility'))) {
        organization.facilities = FacilityStore.instance.recursiveListUpsert(organization.facilities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.financialRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('FinancialRecord'))) {
        organization.financialRecords = FinancialRecordStore.instance.recursiveListUpsert(organization.financialRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.floorPlans != null && (!preventCircularSerialization || !upsertedTypes.contains('FloorPlan'))) {
        organization.floorPlans = FloorPlanStore.instance.recursiveListUpsert(organization.floorPlans!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.giftCards != null && (!preventCircularSerialization || !upsertedTypes.contains('GiftCard'))) {
        organization.giftCards = GiftCardStore.instance.recursiveListUpsert(organization.giftCards!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.govtIntegrations != null && (!preventCircularSerialization || !upsertedTypes.contains('GovernmentIntegration'))) {
        organization.govtIntegrations = GovernmentIntegrationStore.instance.recursiveListUpsert(organization.govtIntegrations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.healthChecks != null && (!preventCircularSerialization || !upsertedTypes.contains('HealthCheck'))) {
        organization.healthChecks = HealthCheckStore.instance.recursiveListUpsert(organization.healthChecks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.homeInformationPacks != null && (!preventCircularSerialization || !upsertedTypes.contains('HomeInformationPack'))) {
        organization.homeInformationPacks = HomeInformationPackStore.instance.recursiveListUpsert(organization.homeInformationPacks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.immigrationStatusChecks != null && (!preventCircularSerialization || !upsertedTypes.contains('ImmigrationStatusCheck'))) {
        organization.immigrationStatusChecks = ImmigrationStatusCheckStore.instance.recursiveListUpsert(organization.immigrationStatusChecks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.integrationLogs != null && (!preventCircularSerialization || !upsertedTypes.contains('IntegrationLog'))) {
        organization.integrationLogs = IntegrationLogStore.instance.recursiveListUpsert(organization.integrationLogs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.investorPortfolios != null && (!preventCircularSerialization || !upsertedTypes.contains('InvestorPortfolio'))) {
        organization.investorPortfolios = InvestorPortfolioStore.instance.recursiveListUpsert(organization.investorPortfolios!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.keys != null && (!preventCircularSerialization || !upsertedTypes.contains('KeyManagement'))) {
        organization.keys = KeyManagementStore.instance.recursiveListUpsert(organization.keys!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.leads != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        organization.leads = LeadStore.instance.recursiveListUpsert(organization.leads!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.leadSources != null && (!preventCircularSerialization || !upsertedTypes.contains('LeadSource'))) {
        organization.leadSources = LeadSourceStore.instance.recursiveListUpsert(organization.leadSources!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.leases != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        organization.leases = LeaseStore.instance.recursiveListUpsert(organization.leases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.leaseRenewals != null && (!preventCircularSerialization || !upsertedTypes.contains('LeaseRenewal'))) {
        organization.leaseRenewals = LeaseRenewalStore.instance.recursiveListUpsert(organization.leaseRenewals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.ledgerEntries != null && (!preventCircularSerialization || !upsertedTypes.contains('LedgerEntry'))) {
        organization.ledgerEntries = LedgerEntryStore.instance.recursiveListUpsert(organization.ledgerEntries!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.listings != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        organization.listings = ListingStore.instance.recursiveListUpsert(organization.listings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.listingChannels != null && (!preventCircularSerialization || !upsertedTypes.contains('ListingChannel'))) {
        organization.listingChannels = ListingChannelStore.instance.recursiveListUpsert(organization.listingChannels!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.listingStatusHistories != null && (!preventCircularSerialization || !upsertedTypes.contains('ListingStatusHistory'))) {
        organization.listingStatusHistories = ListingStatusHistoryStore.instance.recursiveListUpsert(organization.listingStatusHistories!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.listingTags != null && (!preventCircularSerialization || !upsertedTypes.contains('ListingTag'))) {
        organization.listingTags = ListingTagStore.instance.recursiveListUpsert(organization.listingTags!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.locations != null && (!preventCircularSerialization || !upsertedTypes.contains('Location'))) {
        organization.locations = LocationStore.instance.recursiveListUpsert(organization.locations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.loyaltyAccounts != null && (!preventCircularSerialization || !upsertedTypes.contains('LoyaltyAccount'))) {
        organization.loyaltyAccounts = LoyaltyAccountStore.instance.recursiveListUpsert(organization.loyaltyAccounts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mlsConnections != null && (!preventCircularSerialization || !upsertedTypes.contains('MLSConnection'))) {
        organization.mlsConnections = MLSConnectionStore.instance.recursiveListUpsert(organization.mlsConnections!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mlsexternalListings != null && (!preventCircularSerialization || !upsertedTypes.contains('MLSExternalListing'))) {
        organization.mlsexternalListings = MLSExternalListingStore.instance.recursiveListUpsert(organization.mlsexternalListings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mlssyncJobs != null && (!preventCircularSerialization || !upsertedTypes.contains('MLSSyncJob'))) {
        organization.mlssyncJobs = MLSSyncJobStore.instance.recursiveListUpsert(organization.mlssyncJobs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.maintenanceBlocks != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceBlock'))) {
        organization.maintenanceBlocks = MaintenanceBlockStore.instance.recursiveListUpsert(organization.maintenanceBlocks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.workOrders != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceWorkOrder'))) {
        organization.workOrders = MaintenanceWorkOrderStore.instance.recursiveListUpsert(organization.workOrders!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mapLayers != null && (!preventCircularSerialization || !upsertedTypes.contains('MapLayer'))) {
        organization.mapLayers = MapLayerStore.instance.recursiveListUpsert(organization.mapLayers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.marketingCampaigns != null && (!preventCircularSerialization || !upsertedTypes.contains('MarketingCampaign'))) {
        organization.marketingCampaigns = MarketingCampaignStore.instance.recursiveListUpsert(organization.marketingCampaigns!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.messages != null && (!preventCircularSerialization || !upsertedTypes.contains('Message'))) {
        organization.messages = MessageStore.instance.recursiveListUpsert(organization.messages!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mlsDataMappings != null && (!preventCircularSerialization || !upsertedTypes.contains('MlsDataMapping'))) {
        organization.mlsDataMappings = MlsDataMappingStore.instance.recursiveListUpsert(organization.mlsDataMappings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mlsListingEnhancements != null && (!preventCircularSerialization || !upsertedTypes.contains('MlsListingEnhancement'))) {
        organization.mlsListingEnhancements = MlsListingEnhancementStore.instance.recursiveListUpsert(organization.mlsListingEnhancements!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mobileDevices != null && (!preventCircularSerialization || !upsertedTypes.contains('MobileDevice'))) {
        organization.mobileDevices = MobileDeviceStore.instance.recursiveListUpsert(organization.mobileDevices!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mortgageOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('MortgageOffer'))) {
        organization.mortgageOffers = MortgageOfferStore.instance.recursiveListUpsert(organization.mortgageOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.mortgagePreApprovals != null && (!preventCircularSerialization || !upsertedTypes.contains('MortgagePreApproval'))) {
        organization.mortgagePreApprovals = MortgagePreApprovalStore.instance.recursiveListUpsert(organization.mortgagePreApprovals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.neighborhoods != null && (!preventCircularSerialization || !upsertedTypes.contains('Neighborhood'))) {
        organization.neighborhoods = NeighborhoodStore.instance.recursiveListUpsert(organization.neighborhoods!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.notifications != null && (!preventCircularSerialization || !upsertedTypes.contains('Notification'))) {
        organization.notifications = NotificationStore.instance.recursiveListUpsert(organization.notifications!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.offlineSyncQueues != null && (!preventCircularSerialization || !upsertedTypes.contains('OfflineSyncQueue'))) {
        organization.offlineSyncQueues = OfflineSyncQueueStore.instance.recursiveListUpsert(organization.offlineSyncQueues!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.orgSubscription != null && (!preventCircularSerialization || !upsertedTypes.contains('OrgSubscription'))) {
        organization.orgSubscription = OrgSubscriptionStore.instance.recursiveUpsert(organization.orgSubscription!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.payouts != null && (!preventCircularSerialization || !upsertedTypes.contains('Payout'))) {
        organization.payouts = PayoutStore.instance.recursiveListUpsert(organization.payouts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.performanceAlerts != null && (!preventCircularSerialization || !upsertedTypes.contains('PerformanceAlert'))) {
        organization.performanceAlerts = PerformanceAlertStore.instance.recursiveListUpsert(organization.performanceAlerts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.predictiveModels != null && (!preventCircularSerialization || !upsertedTypes.contains('PredictiveModel'))) {
        organization.predictiveModels = PredictiveModelStore.instance.recursiveListUpsert(organization.predictiveModels!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.projects != null && (!preventCircularSerialization || !upsertedTypes.contains('Project'))) {
        organization.projects = ProjectStore.instance.recursiveListUpsert(organization.projects!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.properties != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        organization.properties = PropertyStore.instance.recursiveListUpsert(organization.properties!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.propertyAmenities != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyAmenity'))) {
        organization.propertyAmenities = PropertyAmenityStore.instance.recursiveListUpsert(organization.propertyAmenities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.propertyCompliance != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyCompliance'))) {
        organization.propertyCompliance = PropertyComplianceStore.instance.recursiveListUpsert(organization.propertyCompliance!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.propertyDisclosures != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyDisclosure'))) {
        organization.propertyDisclosures = PropertyDisclosureStore.instance.recursiveListUpsert(organization.propertyDisclosures!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.propertyDocuments != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyDocument'))) {
        organization.propertyDocuments = PropertyDocumentStore.instance.recursiveListUpsert(organization.propertyDocuments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.inventories != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyInventory'))) {
        organization.inventories = PropertyInventoryStore.instance.recursiveListUpsert(organization.inventories!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.propertyOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyOffer'))) {
        organization.propertyOffers = PropertyOfferStore.instance.recursiveListUpsert(organization.propertyOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.propertyPhotos != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyPhoto'))) {
        organization.propertyPhotos = PropertyPhotoStore.instance.recursiveListUpsert(organization.propertyPhotos!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.propertyViewings != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyViewing'))) {
        organization.propertyViewings = PropertyViewingStore.instance.recursiveListUpsert(organization.propertyViewings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.queueConfigurations != null && (!preventCircularSerialization || !upsertedTypes.contains('QueueConfiguration'))) {
        organization.queueConfigurations = QueueConfigurationStore.instance.recursiveListUpsert(organization.queueConfigurations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.queueMessages != null && (!preventCircularSerialization || !upsertedTypes.contains('QueueMessage'))) {
        organization.queueMessages = QueueMessageStore.instance.recursiveListUpsert(organization.queueMessages!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.quotes != null && (!preventCircularSerialization || !upsertedTypes.contains('Quote'))) {
        organization.quotes = QuoteStore.instance.recursiveListUpsert(organization.quotes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.recommendationResults != null && (!preventCircularSerialization || !upsertedTypes.contains('RecommendationResult'))) {
        organization.recommendationResults = RecommendationResultStore.instance.recursiveListUpsert(organization.recommendationResults!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.referrals != null && (!preventCircularSerialization || !upsertedTypes.contains('Referral'))) {
        organization.referrals = ReferralStore.instance.recursiveListUpsert(organization.referrals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.rentArrears != null && (!preventCircularSerialization || !upsertedTypes.contains('RentArrears'))) {
        organization.rentArrears = RentArrearsStore.instance.recursiveListUpsert(organization.rentArrears!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.rentSchedules != null && (!preventCircularSerialization || !upsertedTypes.contains('RentSchedule'))) {
        organization.rentSchedules = RentScheduleStore.instance.recursiveListUpsert(organization.rentSchedules!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.rentalSyncJobs != null && (!preventCircularSerialization || !upsertedTypes.contains('RentalSyncJob'))) {
        organization.rentalSyncJobs = RentalSyncJobStore.instance.recursiveListUpsert(organization.rentalSyncJobs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.reports != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        organization.reports = ReportStore.instance.recursiveListUpsert(organization.reports!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.reportExecutions != null && (!preventCircularSerialization || !upsertedTypes.contains('ReportExecution'))) {
        organization.reportExecutions = ReportExecutionStore.instance.recursiveListUpsert(organization.reportExecutions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.reservations != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        organization.reservations = ReservationStore.instance.recursiveListUpsert(organization.reservations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.reviews != null && (!preventCircularSerialization || !upsertedTypes.contains('Review'))) {
        organization.reviews = ReviewStore.instance.recursiveListUpsert(organization.reviews!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.rightToRentChecks != null && (!preventCircularSerialization || !upsertedTypes.contains('RightToRentCheck'))) {
        organization.rightToRentChecks = RightToRentCheckStore.instance.recursiveListUpsert(organization.rightToRentChecks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.roles != null && (!preventCircularSerialization || !upsertedTypes.contains('Role'))) {
        organization.roles = RoleStore.instance.recursiveListUpsert(organization.roles!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.routes != null && (!preventCircularSerialization || !upsertedTypes.contains('Route'))) {
        organization.routes = RouteStore.instance.recursiveListUpsert(organization.routes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.securityDepositProtections != null && (!preventCircularSerialization || !upsertedTypes.contains('SecurityDepositProtection'))) {
        organization.securityDepositProtections = SecurityDepositProtectionStore.instance.recursiveListUpsert(organization.securityDepositProtections!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.signatureRequests != null && (!preventCircularSerialization || !upsertedTypes.contains('SignatureRequest'))) {
        organization.signatureRequests = SignatureRequestStore.instance.recursiveListUpsert(organization.signatureRequests!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.signatureSigners != null && (!preventCircularSerialization || !upsertedTypes.contains('SignatureSigner'))) {
        organization.signatureSigners = SignatureSignerStore.instance.recursiveListUpsert(organization.signatureSigners!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.solicitorManagements != null && (!preventCircularSerialization || !upsertedTypes.contains('SolicitorManagement'))) {
        organization.solicitorManagements = SolicitorManagementStore.instance.recursiveListUpsert(organization.solicitorManagements!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.subscriptions != null && (!preventCircularSerialization || !upsertedTypes.contains('Subscription'))) {
        organization.subscriptions = SubscriptionStore.instance.recursiveListUpsert(organization.subscriptions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.systemMetrics != null && (!preventCircularSerialization || !upsertedTypes.contains('SystemMetrics'))) {
        organization.systemMetrics = SystemMetricsStore.instance.recursiveListUpsert(organization.systemMetrics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.tags != null && (!preventCircularSerialization || !upsertedTypes.contains('Tag'))) {
        organization.tags = TagStore.instance.recursiveListUpsert(organization.tags!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        organization.tasks = TaskStore.instance.recursiveListUpsert(organization.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.tax1099Forms != null && (!preventCircularSerialization || !upsertedTypes.contains('Tax1099Form'))) {
        organization.tax1099Forms = Tax1099FormStore.instance.recursiveListUpsert(organization.tax1099Forms!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.taxDepreciations != null && (!preventCircularSerialization || !upsertedTypes.contains('TaxDepreciation'))) {
        organization.taxDepreciations = TaxDepreciationStore.instance.recursiveListUpsert(organization.taxDepreciations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.taxRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('TaxRecord'))) {
        organization.taxRecords = TaxRecordStore.instance.recursiveListUpsert(organization.taxRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.tenantApplications != null && (!preventCircularSerialization || !upsertedTypes.contains('TenantApplication'))) {
        organization.tenantApplications = TenantApplicationStore.instance.recursiveListUpsert(organization.tenantApplications!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.userActivityLogs != null && (!preventCircularSerialization || !upsertedTypes.contains('UserActivityLog'))) {
        organization.userActivityLogs = UserActivityLogStore.instance.recursiveListUpsert(organization.userActivityLogs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.userPreferences != null && (!preventCircularSerialization || !upsertedTypes.contains('UserPreference'))) {
        organization.userPreferences = UserPreferenceStore.instance.recursiveListUpsert(organization.userPreferences!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.vacationRentals != null && (!preventCircularSerialization || !upsertedTypes.contains('VacationRental'))) {
        organization.vacationRentals = VacationRentalStore.instance.recursiveListUpsert(organization.vacationRentals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.vendors != null && (!preventCircularSerialization || !upsertedTypes.contains('VendorProfile'))) {
        organization.vendors = VendorProfileStore.instance.recursiveListUpsert(organization.vendors!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.virtualTours != null && (!preventCircularSerialization || !upsertedTypes.contains('VirtualTour'))) {
        organization.virtualTours = VirtualTourStore.instance.recursiveListUpsert(organization.virtualTours!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.webhooks != null && (!preventCircularSerialization || !upsertedTypes.contains('Webhook'))) {
        organization.webhooks = WebhookStore.instance.recursiveListUpsert(organization.webhooks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.webhookDeliveries != null && (!preventCircularSerialization || !upsertedTypes.contains('WebhookDelivery'))) {
        organization.webhookDeliveries = WebhookDeliveryStore.instance.recursiveListUpsert(organization.webhookDeliveries!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.escrowAccounts != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowAccount'))) {
        organization.escrowAccounts = EscrowAccountStore.instance.recursiveListUpsert(organization.escrowAccounts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.escrowReleases != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowRelease'))) {
        organization.escrowReleases = EscrowReleaseStore.instance.recursiveListUpsert(organization.escrowReleases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.escrowDisputes != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowDispute'))) {
        organization.escrowDisputes = EscrowDisputeStore.instance.recursiveListUpsert(organization.escrowDisputes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.paymentNegotiations != null && (!preventCircularSerialization || !upsertedTypes.contains('PaymentNegotiation'))) {
        organization.paymentNegotiations = PaymentNegotiationStore.instance.recursiveListUpsert(organization.paymentNegotiations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.paymentInstallments != null && (!preventCircularSerialization || !upsertedTypes.contains('PaymentInstallment'))) {
        organization.paymentInstallments = PaymentInstallmentStore.instance.recursiveListUpsert(organization.paymentInstallments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.videoContents != null && (!preventCircularSerialization || !upsertedTypes.contains('VideoContent'))) {
        organization.videoContents = VideoContentStore.instance.recursiveListUpsert(organization.videoContents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.brandAmbassadors != null && (!preventCircularSerialization || !upsertedTypes.contains('BrandAmbassador'))) {
        organization.brandAmbassadors = BrandAmbassadorStore.instance.recursiveListUpsert(organization.brandAmbassadors!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.ambassadorCampaigns != null && (!preventCircularSerialization || !upsertedTypes.contains('AmbassadorCampaign'))) {
        organization.ambassadorCampaigns = AmbassadorCampaignStore.instance.recursiveListUpsert(organization.ambassadorCampaigns!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.socialImpactCounters != null && (!preventCircularSerialization || !upsertedTypes.contains('SocialImpactCounter'))) {
        organization.socialImpactCounters = SocialImpactCounterStore.instance.recursiveListUpsert(organization.socialImpactCounters!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.socialImpactRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('SocialImpactRecord'))) {
        organization.socialImpactRecords = SocialImpactRecordStore.instance.recursiveListUpsert(organization.socialImpactRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.negotiationOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('NegotiationOffer'))) {
        organization.negotiationOffers = NegotiationOfferStore.instance.recursiveListUpsert(organization.negotiationOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.ambassadorContracts != null && (!preventCircularSerialization || !upsertedTypes.contains('AmbassadorContract'))) {
        organization.ambassadorContracts = AmbassadorContractStore.instance.recursiveListUpsert(organization.ambassadorContracts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.escrowStatusHistories != null && (!preventCircularSerialization || !upsertedTypes.contains('EscrowStatusHistory'))) {
        organization.escrowStatusHistories = EscrowStatusHistoryStore.instance.recursiveListUpsert(organization.escrowStatusHistories!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiChatMessages != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatMessage'))) {
        organization.aiChatMessages = AIChatMessageStore.instance.recursiveListUpsert(organization.aiChatMessages!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.aiChatHandoffs != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatHandoff'))) {
        organization.aiChatHandoffs = AIChatHandoffStore.instance.recursiveListUpsert(organization.aiChatHandoffs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.analyses != null && (!preventCircularSerialization || !upsertedTypes.contains('DocumentAnalysis'))) {
        organization.analyses = DocumentAnalysisStore.instance.recursiveListUpsert(organization.analyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (organization.analysisJobs != null && (!preventCircularSerialization || !upsertedTypes.contains('AnalysisJob'))) {
        organization.analysisJobs = AnalysisJobStore.instance.recursiveListUpsert(organization.analysisJobs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(organization);
}

  List<Organization> recursiveListUpsert(List<Organization> organizations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedOrganizations = <Organization>[];
    for (var organization in organizations) {
        updatedOrganizations.add(recursiveUpsert(organization, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedOrganizations;
}

//   @override
//   Organization upsert(Organization item) {
//     return recursiveUpsert(item);
//   }

}


class OrganizationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      OrganizationInclude.aiChatbotSessions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatbotSession>? modelFilter,
    List<AIChatbotSessionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiChatbotSessions$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiChatbotSessions(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiFraudDetections({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIFraudDetection>? modelFilter,
    List<AIFraudDetectionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiFraudDetections$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiFraudDetections(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiImageAnalyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIImageAnalysis>? modelFilter,
    List<AIImageAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiImageAnalyses$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiImageAnalyses(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiInvestmentAnalyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIInvestmentAnalysis>? modelFilter,
    List<AIInvestmentAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiInvestmentAnalyses$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiInvestmentAnalyses(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiLeadScores({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AILeadScore>? modelFilter,
    List<AILeadScoreInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiLeadScores$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiLeadScores(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiLeadScoringModels({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AILeadScoring>? modelFilter,
    List<AILeadScoringInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiLeadScoringModels$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiLeadScoringModels(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiMarketAnalyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIMarketAnalysis>? modelFilter,
    List<AIMarketAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiMarketAnalyses$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiMarketAnalyses(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiModels({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIModel>? modelFilter,
    List<AIModelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiModels$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiModels(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiModelDeployments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIModelDeployment>? modelFilter,
    List<AIModelDeploymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiModelDeployments$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiModelDeployments(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiPredictions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPrediction>? modelFilter,
    List<AIPredictionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiPredictions$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiPredictions(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiPredictiveMaintenance({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPredictiveMaintenance>? modelFilter,
    List<AIPredictiveMaintenanceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiPredictiveMaintenance$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiPredictiveMaintenance(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiPriceOptimizations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPriceOptimization>? modelFilter,
    List<AIPriceOptimizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiPriceOptimizations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiPriceOptimizations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiPropertyDescriptions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPropertyDescription>? modelFilter,
    List<AIPropertyDescriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiPropertyDescriptions$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiPropertyDescriptions(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiPropertyValuations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPropertyValuation>? modelFilter,
    List<AIPropertyValuationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiPropertyValuations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiPropertyValuations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiRecommendations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIRecommendation>? modelFilter,
    List<AIRecommendationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiRecommendations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiRecommendations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiSentimentAnalyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AISentimentAnalysis>? modelFilter,
    List<AISentimentAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiSentimentAnalyses$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiSentimentAnalyses(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiTenantScreenings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AITenantScreening>? modelFilter,
    List<AITenantScreeningInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiTenantScreenings$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiTenantScreenings(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiValuationModels({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIValuationModel>? modelFilter,
    List<AIValuationModelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiValuationModels$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiValuationModels(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.integrations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<APIIntegration>? modelFilter,
    List<APIIntegrationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getIntegrations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getIntegrations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.achievements({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Achievement>? modelFilter,
    List<AchievementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAchievements$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAchievements(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAgencies$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAgencies(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.agencyRelations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAgencyRelations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAgencyRelations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.organizationAgencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getOrganizationAgencies$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getOrganizationAgencies(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.agentAssignments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentAssignment>? modelFilter,
    List<AgentAssignmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAgentAssignments$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAgentAssignments(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.agentTeams({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentTeam>? modelFilter,
    List<AgentTeamInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAgentTeams$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAgentTeams(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.amenities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Amenity>? modelFilter,
    List<AmenityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAmenities$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAmenities(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.apiIntegrations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ApiIntegration>? modelFilter,
    List<ApiIntegrationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getApiIntegrations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getApiIntegrations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.apiKeys({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ApiKey>? modelFilter,
    List<ApiKeyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getApiKeys$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getApiKeys(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.appointments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Appointment>? modelFilter,
    List<AppointmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAppointments$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAppointments(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.attachments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Attachment>? modelFilter,
    List<AttachmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAttachments$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAttachments(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.attorneyCases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AttorneyManagement>? modelFilter,
    List<AttorneyManagementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAttorneyCases$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAttorneyCases(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.auditLogs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AuditLog>? modelFilter,
    List<AuditLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAuditLogs$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAuditLogs(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.automationExecutions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AutomationExecution>? modelFilter,
    List<AutomationExecutionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAutomationExecutions$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAutomationExecutions(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.automationRules({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AutomationRule>? modelFilter,
    List<AutomationRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAutomationRules$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAutomationRules(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.bookings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Booking>? modelFilter,
    List<BookingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getBookings$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getBookings(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.budgets({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Budget>? modelFilter,
    List<BudgetInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getBudgets$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getBudgets(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.calendarEvents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CalendarEvent>? modelFilter,
    List<CalendarEventInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getCalendarEvents$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getCalendarEvents(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.commissions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Commission>? modelFilter,
    List<CommissionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getCommissions$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getCommissions(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.communicationTemplates({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommunicationTemplate>? modelFilter,
    List<CommunicationTemplateInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getCommunicationTemplates$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getCommunicationTemplates(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.contacts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getContacts$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getContacts(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.contracts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getContracts$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getContracts(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.contractVersions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ContractVersion>? modelFilter,
    List<ContractVersionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getContractVersions$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getContractVersions(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.dashboardConfigurations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DashboardConfiguration>? modelFilter,
    List<DashboardConfigurationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getDashboardConfigurations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getDashboardConfigurations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.dashboardWidgets({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DashboardWidget>? modelFilter,
    List<DashboardWidgetInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getDashboardWidgets$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getDashboardWidgets(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.deals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getDeals$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getDeals(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.depositProtections({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DepositProtection>? modelFilter,
    List<DepositProtectionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getDepositProtections$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getDepositProtections(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.documents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Document>? modelFilter,
    List<DocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getDocuments$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getDocuments(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.documentTemplates({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DocumentTemplate>? modelFilter,
    List<DocumentTemplateInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getDocumentTemplates$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getDocumentTemplates(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.earnings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Earning>? modelFilter,
    List<EarningInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getEarnings$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getEarnings(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.events({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Event>? modelFilter,
    List<EventInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getEvents$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getEvents(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.eventAttendees({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EventAttendee>? modelFilter,
    List<EventAttendeeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getEventAttendees$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getEventAttendees(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.exchangeRates({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExchangeRate>? modelFilter,
    List<ExchangeRateInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getExchangeRates$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getExchangeRates(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.exportFiles({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExportFile>? modelFilter,
    List<ExportFileInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getExportFiles$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getExportFiles(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.exportJobs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExportJob>? modelFilter,
    List<ExportJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getExportJobs$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getExportJobs(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.externalRentalListings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExternalRentalListing>? modelFilter,
    List<ExternalRentalListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getExternalRentalListings$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getExternalRentalListings(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.facilities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Facility>? modelFilter,
    List<FacilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getFacilities$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getFacilities(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.financialRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FinancialRecord>? modelFilter,
    List<FinancialRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getFinancialRecords$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getFinancialRecords(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.floorPlans({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FloorPlan>? modelFilter,
    List<FloorPlanInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getFloorPlans$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getFloorPlans(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.giftCards({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<GiftCard>? modelFilter,
    List<GiftCardInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getGiftCards$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getGiftCards(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.govtIntegrations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<GovernmentIntegration>? modelFilter,
    List<GovernmentIntegrationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getGovtIntegrations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getGovtIntegrations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.healthChecks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<HealthCheck>? modelFilter,
    List<HealthCheckInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getHealthChecks$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getHealthChecks(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.homeInformationPacks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<HomeInformationPack>? modelFilter,
    List<HomeInformationPackInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getHomeInformationPacks$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getHomeInformationPacks(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.immigrationStatusChecks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ImmigrationStatusCheck>? modelFilter,
    List<ImmigrationStatusCheckInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getImmigrationStatusChecks$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getImmigrationStatusChecks(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.integrationLogs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IntegrationLog>? modelFilter,
    List<IntegrationLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getIntegrationLogs$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getIntegrationLogs(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.investorPortfolios({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<InvestorPortfolio>? modelFilter,
    List<InvestorPortfolioInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getInvestorPortfolios$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getInvestorPortfolios(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.keys({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<KeyManagement>? modelFilter,
    List<KeyManagementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getKeys$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getKeys(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.leads({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getLeads$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getLeads(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.leadSources({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LeadSource>? modelFilter,
    List<LeadSourceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getLeadSources$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getLeadSources(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.leases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getLeases$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getLeases(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.leaseRenewals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LeaseRenewal>? modelFilter,
    List<LeaseRenewalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getLeaseRenewals$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getLeaseRenewals(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.ledgerEntries({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LedgerEntry>? modelFilter,
    List<LedgerEntryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getLedgerEntries$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getLedgerEntries(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.listings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getListings$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getListings(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.listingChannels({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ListingChannel>? modelFilter,
    List<ListingChannelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getListingChannels$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getListingChannels(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.listingStatusHistories({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ListingStatusHistory>? modelFilter,
    List<ListingStatusHistoryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getListingStatusHistories$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getListingStatusHistories(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.listingTags({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ListingTag>? modelFilter,
    List<ListingTagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getListingTags$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getListingTags(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.locations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Location>? modelFilter,
    List<LocationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getLocations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getLocations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.loyaltyAccounts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LoyaltyAccount>? modelFilter,
    List<LoyaltyAccountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getLoyaltyAccounts$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getLoyaltyAccounts(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mlsConnections({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MLSConnection>? modelFilter,
    List<MLSConnectionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMlsConnections$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMlsConnections(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mlsexternalListings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MLSExternalListing>? modelFilter,
    List<MLSExternalListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMlsexternalListings$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMlsexternalListings(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mlssyncJobs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MLSSyncJob>? modelFilter,
    List<MLSSyncJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMlssyncJobs$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMlssyncJobs(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.maintenanceBlocks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceBlock>? modelFilter,
    List<MaintenanceBlockInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMaintenanceBlocks$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMaintenanceBlocks(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.workOrders({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceWorkOrder>? modelFilter,
    List<MaintenanceWorkOrderInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getWorkOrders$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getWorkOrders(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mapLayers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MapLayer>? modelFilter,
    List<MapLayerInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMapLayers$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMapLayers(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.marketingCampaigns({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MarketingCampaign>? modelFilter,
    List<MarketingCampaignInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMarketingCampaigns$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMarketingCampaigns(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.messages({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Message>? modelFilter,
    List<MessageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMessages$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMessages(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mlsDataMappings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MlsDataMapping>? modelFilter,
    List<MlsDataMappingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMlsDataMappings$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMlsDataMappings(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mlsListingEnhancements({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MlsListingEnhancement>? modelFilter,
    List<MlsListingEnhancementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMlsListingEnhancements$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMlsListingEnhancements(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mobileDevices({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MobileDevice>? modelFilter,
    List<MobileDeviceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMobileDevices$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMobileDevices(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mortgageOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MortgageOffer>? modelFilter,
    List<MortgageOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMortgageOffers$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMortgageOffers(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.mortgagePreApprovals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MortgagePreApproval>? modelFilter,
    List<MortgagePreApprovalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getMortgagePreApprovals$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getMortgagePreApprovals(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.neighborhoods({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Neighborhood>? modelFilter,
    List<NeighborhoodInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getNeighborhoods$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getNeighborhoods(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.notifications({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Notification>? modelFilter,
    List<NotificationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getNotifications$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getNotifications(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.offlineSyncQueues({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<OfflineSyncQueue>? modelFilter,
    List<OfflineSyncQueueInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getOfflineSyncQueues$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getOfflineSyncQueues(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.orgSubscription({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<OrgSubscription>? modelFilter,
    List<OrgSubscriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getOrgSubscription$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getOrgSubscription(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.payouts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payout>? modelFilter,
    List<PayoutInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPayouts$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPayouts(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.performanceAlerts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PerformanceAlert>? modelFilter,
    List<PerformanceAlertInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPerformanceAlerts$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPerformanceAlerts(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.predictiveModels({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PredictiveModel>? modelFilter,
    List<PredictiveModelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPredictiveModels$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPredictiveModels(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.projects({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Project>? modelFilter,
    List<ProjectInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getProjects$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getProjects(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.properties({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getProperties$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getProperties(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.propertyAmenities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyAmenity>? modelFilter,
    List<PropertyAmenityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPropertyAmenities$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPropertyAmenities(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.propertyCompliance({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyCompliance>? modelFilter,
    List<PropertyComplianceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPropertyCompliance$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPropertyCompliance(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.propertyDisclosures({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyDisclosure>? modelFilter,
    List<PropertyDisclosureInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPropertyDisclosures$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPropertyDisclosures(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.propertyDocuments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyDocument>? modelFilter,
    List<PropertyDocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPropertyDocuments$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPropertyDocuments(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.inventories({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyInventory>? modelFilter,
    List<PropertyInventoryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getInventories$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getInventories(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.propertyOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyOffer>? modelFilter,
    List<PropertyOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPropertyOffers$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPropertyOffers(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.propertyPhotos({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyPhoto>? modelFilter,
    List<PropertyPhotoInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPropertyPhotos$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPropertyPhotos(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.propertyViewings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyViewing>? modelFilter,
    List<PropertyViewingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPropertyViewings$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPropertyViewings(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.queueConfigurations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<QueueConfiguration>? modelFilter,
    List<QueueConfigurationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getQueueConfigurations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getQueueConfigurations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.queueMessages({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<QueueMessage>? modelFilter,
    List<QueueMessageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getQueueMessages$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getQueueMessages(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.quotes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Quote>? modelFilter,
    List<QuoteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getQuotes$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getQuotes(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.recommendationResults({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RecommendationResult>? modelFilter,
    List<RecommendationResultInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getRecommendationResults$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getRecommendationResults(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.referrals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Referral>? modelFilter,
    List<ReferralInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getReferrals$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getReferrals(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.rentArrears({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RentArrears>? modelFilter,
    List<RentArrearsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getRentArrears$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getRentArrears(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.rentSchedules({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RentSchedule>? modelFilter,
    List<RentScheduleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getRentSchedules$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getRentSchedules(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.rentalSyncJobs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RentalSyncJob>? modelFilter,
    List<RentalSyncJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getRentalSyncJobs$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getRentalSyncJobs(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.reports({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getReports$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getReports(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.reportExecutions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ReportExecution>? modelFilter,
    List<ReportExecutionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getReportExecutions$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getReportExecutions(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.reservations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getReservations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getReservations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.reviews({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Review>? modelFilter,
    List<ReviewInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getReviews$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getReviews(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.rightToRentChecks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RightToRentCheck>? modelFilter,
    List<RightToRentCheckInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getRightToRentChecks$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getRightToRentChecks(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.roles({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Role>? modelFilter,
    List<RoleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getRoles$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getRoles(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.routes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Route>? modelFilter,
    List<RouteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getRoutes$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getRoutes(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.securityDepositProtections({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SecurityDepositProtection>? modelFilter,
    List<SecurityDepositProtectionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getSecurityDepositProtections$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getSecurityDepositProtections(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.signatureRequests({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SignatureRequest>? modelFilter,
    List<SignatureRequestInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getSignatureRequests$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getSignatureRequests(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.signatureSigners({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SignatureSigner>? modelFilter,
    List<SignatureSignerInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getSignatureSigners$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getSignatureSigners(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.solicitorManagements({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SolicitorManagement>? modelFilter,
    List<SolicitorManagementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getSolicitorManagements$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getSolicitorManagements(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.subscriptions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Subscription>? modelFilter,
    List<SubscriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getSubscriptions$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getSubscriptions(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.systemMetrics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SystemMetrics>? modelFilter,
    List<SystemMetricsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getSystemMetrics$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getSystemMetrics(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.tags({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tag>? modelFilter,
    List<TagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getTags$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getTags(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getTasks$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getTasks(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.tax1099Forms({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tax1099Form>? modelFilter,
    List<Tax1099FormInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getTax1099Forms$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getTax1099Forms(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.taxDepreciations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TaxDepreciation>? modelFilter,
    List<TaxDepreciationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getTaxDepreciations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getTaxDepreciations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.taxRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TaxRecord>? modelFilter,
    List<TaxRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getTaxRecords$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getTaxRecords(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.tenantApplications({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TenantApplication>? modelFilter,
    List<TenantApplicationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getTenantApplications$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getTenantApplications(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.userActivityLogs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<UserActivityLog>? modelFilter,
    List<UserActivityLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getUserActivityLogs$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getUserActivityLogs(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.userPreferences({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<UserPreference>? modelFilter,
    List<UserPreferenceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getUserPreferences$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getUserPreferences(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.vacationRentals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VacationRental>? modelFilter,
    List<VacationRentalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getVacationRentals$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getVacationRentals(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.vendors({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VendorProfile>? modelFilter,
    List<VendorProfileInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getVendors$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getVendors(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.virtualTours({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VirtualTour>? modelFilter,
    List<VirtualTourInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getVirtualTours$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getVirtualTours(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.webhooks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Webhook>? modelFilter,
    List<WebhookInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getWebhooks$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getWebhooks(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.webhookDeliveries({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<WebhookDelivery>? modelFilter,
    List<WebhookDeliveryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getWebhookDeliveries$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getWebhookDeliveries(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.escrowAccounts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowAccount>? modelFilter,
    List<EscrowAccountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getEscrowAccounts$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getEscrowAccounts(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.escrowReleases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowRelease>? modelFilter,
    List<EscrowReleaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getEscrowReleases$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getEscrowReleases(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.escrowDisputes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowDispute>? modelFilter,
    List<EscrowDisputeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getEscrowDisputes$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getEscrowDisputes(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.paymentNegotiations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PaymentNegotiation>? modelFilter,
    List<PaymentNegotiationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPaymentNegotiations$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPaymentNegotiations(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.paymentInstallments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PaymentInstallment>? modelFilter,
    List<PaymentInstallmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getPaymentInstallments$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getPaymentInstallments(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.videoContents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VideoContent>? modelFilter,
    List<VideoContentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getVideoContents$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getVideoContents(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.brandAmbassadors({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<BrandAmbassador>? modelFilter,
    List<BrandAmbassadorInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getBrandAmbassadors$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getBrandAmbassadors(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.ambassadorCampaigns({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AmbassadorCampaign>? modelFilter,
    List<AmbassadorCampaignInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAmbassadorCampaigns$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAmbassadorCampaigns(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.socialImpactCounters({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SocialImpactCounter>? modelFilter,
    List<SocialImpactCounterInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getSocialImpactCounters$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getSocialImpactCounters(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.socialImpactRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SocialImpactRecord>? modelFilter,
    List<SocialImpactRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getSocialImpactRecords$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getSocialImpactRecords(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.negotiationOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<NegotiationOffer>? modelFilter,
    List<NegotiationOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getNegotiationOffers$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getNegotiationOffers(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.ambassadorContracts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AmbassadorContract>? modelFilter,
    List<AmbassadorContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAmbassadorContracts$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAmbassadorContracts(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.escrowStatusHistories({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EscrowStatusHistory>? modelFilter,
    List<EscrowStatusHistoryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getEscrowStatusHistories$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getEscrowStatusHistories(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiChatMessages({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatMessage>? modelFilter,
    List<AIChatMessageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiChatMessages$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiChatMessages(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.aiChatHandoffs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatHandoff>? modelFilter,
    List<AIChatHandoffInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAiChatHandoffs$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAiChatHandoffs(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.analyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DocumentAnalysis>? modelFilter,
    List<DocumentAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAnalyses$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAnalyses(organization, modelFilter: modelFilter, includes: includes);
      }
}

	OrganizationInclude.analysisJobs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AnalysisJob>? modelFilter,
    List<AnalysisJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (organization) => OrganizationStore.instance
            .getAnalysisJobs$(organization, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (organization) => OrganizationStore.instance
            .getAnalysisJobs(organization, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum OrganizationEndpoints implements Endpoint {

    getAll('/organization', HttpMethod.post, List<Organization>),
	getById('/organization/byId/:id', HttpMethod.post, Organization),
	getManyByName('/organization/byName/:name', HttpMethod.post, List<Organization>),
	getManyByType('/organization/byType/:type', HttpMethod.post, List<Organization>),
	getManyByRegion('/organization/byRegion/:region', HttpMethod.post, List<Organization>),
	getManyByDefaultCurrency('/organization/byDefaultCurrency/:defaultCurrency', HttpMethod.post, List<Organization>),
	getManyByDefaultLocale('/organization/byDefaultLocale/:defaultLocale', HttpMethod.post, List<Organization>),
	getManyByLegalName('/organization/byLegalName/:legalName', HttpMethod.post, List<Organization>),
	getManyByTaxId('/organization/byTaxId/:taxId', HttpMethod.post, List<Organization>),
	getManyByAddress('/organization/byAddress/:address', HttpMethod.post, List<Organization>),
	getManyByContactEmail('/organization/byContactEmail/:contactEmail', HttpMethod.post, List<Organization>),
	getManyByManagementFeeType('/organization/byManagementFeeType/:managementFeeType', HttpMethod.post, List<Organization>),
	getManyByManagementFeeRate('/organization/byManagementFeeRate/:managementFeeRate', HttpMethod.post, List<Organization>),
	getManyByManagementFeeAmount('/organization/byManagementFeeAmount/:managementFeeAmount', HttpMethod.post, List<Organization>),
	getManyByManagementFeeScope('/organization/byManagementFeeScope/:managementFeeScope', HttpMethod.post, List<Organization>),
	getManyByTaxReportingEnabled('/organization/byTaxReportingEnabled/:taxReportingEnabled', HttpMethod.post, List<Organization>),
	getManyByComplianceTracking('/organization/byComplianceTracking/:complianceTracking', HttpMethod.post, List<Organization>),
	getManyByRequiredInspections('/organization/byRequiredInspections/:requiredInspections', HttpMethod.post, List<Organization>),
	getManyByCreatedAt('/organization/byCreatedAt/:createdAt', HttpMethod.post, List<Organization>),
	getManyByUpdatedAt('/organization/byUpdatedAt/:updatedAt', HttpMethod.post, List<Organization>),
	getManyByDeletedAt('/organization/byDeletedAt/:deletedAt', HttpMethod.post, List<Organization>);

    const OrganizationEndpoints(this.path, this.method, this.responseType);

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
