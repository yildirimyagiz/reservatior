
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'achievement.dart';
import 'agent_assignment.dart';
import 'agent_performance.dart';
import 'agent_team.dart';
import 'agent_team_member.dart';
import 'api_key.dart';
import 'api_token.dart';
import 'appointment.dart';
import 'audit_log.dart';
import 'budget.dart';
import 'calendar_event.dart';
import 'client_relationship.dart';
import 'dashboard_configuration.dart';
import 'dashboard_widget.dart';
import 'document.dart';
import 'earning.dart';
import 'event_attendee.dart';
import 'government_integration.dart';
import 'investor_portfolio.dart';
import 'lead.dart';
import 'loyalty_account.dart';
import 'maintenance_work_order.dart';
import 'mobile_device.dart';
import 'notification.dart';
import 'offline_sync_queue.dart';
import 'project.dart';
import 'property_compliance.dart';
import 'property_viewing.dart';
import 'referral.dart';
import 'report.dart';
import 'session.dart';
import 'signature_signer.dart';
import 'task.dart';
import 'user_activity_log.dart';
import 'user_financial_profile.dart';
import 'user_preference.dart';
import 'extra_charge.dart';
import 'currency.dart';
import 'agency.dart';
import 'included_service.dart';
import 'hashtag.dart';
import 'tenant.dart';
import 'agent.dart';
import 'mention.dart';
import 'property_promotion.dart';
import 'ticket.dart';
import 'account.dart';
import 'communication_log.dart';
import 'favorite.dart';
import 'language.dart';
import 'offer.dart';
import 'photo.dart';
import 'post.dart';
import 'analytics.dart';


class User implements PrismaModel<String, User> , Id<String> {
    @override
String? id;
	String? email;
	String? name;
	String? phone;
	String? locale;
	String? timezone;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Achievement>? achievements;
	List<AgentAssignment>? agentAssignments;
	List<AgentPerformance>? agentPerformance;
	List<AgentTeam>? agentTeams;
	List<AgentTeamMember>? teamMemberships;
	List<ApiKey>? apiKeys;
	List<ApiToken>? apiTokens;
	List<Appointment>? appointments;
	List<AuditLog>? auditLogs;
	List<Budget>? budgets;
	List<CalendarEvent>? calendarEvents;
	List<ClientRelationship>? clientRelationships;
	List<DashboardConfiguration>? dashboardConfigurations;
	List<DashboardWidget>? dashboardWidgets;
	List<Document>? documents;
	List<Earning>? earnings;
	List<EventAttendee>? eventAttendees;
	List<GovernmentIntegration>? governmentIntegrations;
	InvestorPortfolio? investorPortfolio;
	List<Lead>? leads;
	List<LoyaltyAccount>? loyaltyAccounts;
	List<MaintenanceWorkOrder>? workOrdersReported;
	List<MaintenanceWorkOrder>? maintenanceAssigned;
	List<MobileDevice>? mobileDevices;
	List<Notification>? notifications;
	List<OfflineSyncQueue>? offlineSyncQueues;
	List<Project>? managedProjects;
	List<PropertyCompliance>? propertyCompliance;
	List<PropertyViewing>? assignedViewings;
	List<Referral>? referrals;
	List<Report>? reports;
	List<Session>? sessions;
	List<SignatureSigner>? signatureSigners;
	List<Task>? tasks;
	List<UserActivityLog>? activityLogs;
	UserFinancialProfile? financialProfile;
	UserPreference? preferences;
	DateTime? gdprConsentAt;
	DateTime? ccpaOptOutAt;
	DateTime? dataRetentionUntil;
	DateTime? anonymizedAt;
	List<ExtraCharge>? extraCharges;
	List<Currency>? currencies;
	List<Agency>? agencies;
	List<Agency>? agencyMemberships;
	List<IncludedService>? includedServices;
	List<Hashtag>? hashtags;
	List<Tenant>? tenants;
	List<Agent>? agentOwners;
	List<Mention>? mentionsByUser;
	List<Mention>? mentionsToUser;
	List<Mention>? mentionsAsGeneric;
	List<PropertyPromotion>? propertyPromotions;
	List<Ticket>? assignedTickets;
	List<Ticket>? tickets;
	List<Account>? accounts;
	List<CommunicationLog>? communicationLogs;
	List<Favorite>? favorites;
	List<Language>? languages;
	List<Offer>? offers;
	List<Photo>? photos;
	List<Post>? posts;
	List<Analytics>? analytics;
	int? $achievementsCount;
	int? $agentAssignmentsCount;
	int? $agentPerformanceCount;
	int? $agentTeamsCount;
	int? $teamMembershipsCount;
	int? $apiKeysCount;
	int? $apiTokensCount;
	int? $appointmentsCount;
	int? $auditLogsCount;
	int? $budgetsCount;
	int? $calendarEventsCount;
	int? $clientRelationshipsCount;
	int? $dashboardConfigurationsCount;
	int? $dashboardWidgetsCount;
	int? $documentsCount;
	int? $earningsCount;
	int? $eventAttendeesCount;
	int? $governmentIntegrationsCount;
	int? $leadsCount;
	int? $loyaltyAccountsCount;
	int? $workOrdersReportedCount;
	int? $maintenanceAssignedCount;
	int? $mobileDevicesCount;
	int? $notificationsCount;
	int? $offlineSyncQueuesCount;
	int? $managedProjectsCount;
	int? $propertyComplianceCount;
	int? $assignedViewingsCount;
	int? $referralsCount;
	int? $reportsCount;
	int? $sessionsCount;
	int? $signatureSignersCount;
	int? $tasksCount;
	int? $activityLogsCount;
	int? $extraChargesCount;
	int? $currenciesCount;
	int? $agenciesCount;
	int? $agencyMembershipsCount;
	int? $includedServicesCount;
	int? $hashtagsCount;
	int? $tenantsCount;
	int? $agentOwnersCount;
	int? $mentionsByUserCount;
	int? $mentionsToUserCount;
	int? $mentionsAsGenericCount;
	int? $propertyPromotionsCount;
	int? $assignedTicketsCount;
	int? $ticketsCount;
	int? $accountsCount;
	int? $communicationLogsCount;
	int? $favoritesCount;
	int? $languagesCount;
	int? $offersCount;
	int? $photosCount;
	int? $postsCount;
	int? $analyticsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    User({ this.id,
	 this.email,
	 this.name,
	 this.phone,
	 this.locale = "en-US",
	 this.timezone = "America/New_York",
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.achievements,
	 this.agentAssignments,
	 this.agentPerformance,
	 this.agentTeams,
	 this.teamMemberships,
	 this.apiKeys,
	 this.apiTokens,
	 this.appointments,
	 this.auditLogs,
	 this.budgets,
	 this.calendarEvents,
	 this.clientRelationships,
	 this.dashboardConfigurations,
	 this.dashboardWidgets,
	 this.documents,
	 this.earnings,
	 this.eventAttendees,
	 this.governmentIntegrations,
	 this.investorPortfolio,
	 this.leads,
	 this.loyaltyAccounts,
	 this.workOrdersReported,
	 this.maintenanceAssigned,
	 this.mobileDevices,
	 this.notifications,
	 this.offlineSyncQueues,
	 this.managedProjects,
	 this.propertyCompliance,
	 this.assignedViewings,
	 this.referrals,
	 this.reports,
	 this.sessions,
	 this.signatureSigners,
	 this.tasks,
	 this.activityLogs,
	 this.financialProfile,
	 this.preferences,
	 this.gdprConsentAt,
	 this.ccpaOptOutAt,
	 this.dataRetentionUntil,
	 this.anonymizedAt,
	 this.extraCharges,
	 this.currencies,
	 this.agencies,
	 this.agencyMemberships,
	 this.includedServices,
	 this.hashtags,
	 this.tenants,
	 this.agentOwners,
	 this.mentionsByUser,
	 this.mentionsToUser,
	 this.mentionsAsGeneric,
	 this.propertyPromotions,
	 this.assignedTickets,
	 this.tickets,
	 this.accounts,
	 this.communicationLogs,
	 this.favorites,
	 this.languages,
	 this.offers,
	 this.photos,
	 this.posts,
	 this.analytics,
	this.$achievementsCount,
	this.$agentAssignmentsCount,
	this.$agentPerformanceCount,
	this.$agentTeamsCount,
	this.$teamMembershipsCount,
	this.$apiKeysCount,
	this.$apiTokensCount,
	this.$appointmentsCount,
	this.$auditLogsCount,
	this.$budgetsCount,
	this.$calendarEventsCount,
	this.$clientRelationshipsCount,
	this.$dashboardConfigurationsCount,
	this.$dashboardWidgetsCount,
	this.$documentsCount,
	this.$earningsCount,
	this.$eventAttendeesCount,
	this.$governmentIntegrationsCount,
	this.$leadsCount,
	this.$loyaltyAccountsCount,
	this.$workOrdersReportedCount,
	this.$maintenanceAssignedCount,
	this.$mobileDevicesCount,
	this.$notificationsCount,
	this.$offlineSyncQueuesCount,
	this.$managedProjectsCount,
	this.$propertyComplianceCount,
	this.$assignedViewingsCount,
	this.$referralsCount,
	this.$reportsCount,
	this.$sessionsCount,
	this.$signatureSignersCount,
	this.$tasksCount,
	this.$activityLogsCount,
	this.$extraChargesCount,
	this.$currenciesCount,
	this.$agenciesCount,
	this.$agencyMembershipsCount,
	this.$includedServicesCount,
	this.$hashtagsCount,
	this.$tenantsCount,
	this.$agentOwnersCount,
	this.$mentionsByUserCount,
	this.$mentionsToUserCount,
	this.$mentionsAsGenericCount,
	this.$propertyPromotionsCount,
	this.$assignedTicketsCount,
	this.$ticketsCount,
	this.$accountsCount,
	this.$communicationLogsCount,
	this.$favoritesCount,
	this.$languagesCount,
	this.$offersCount,
	this.$photosCount,
	this.$postsCount,
	this.$analyticsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<User, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"email": (m) => m.email,

	"name": (m) => m.name,

	"phone": (m) => m.phone,

	"locale": (m) => m.locale,

	"timezone": (m) => m.timezone,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"achievements": (m) => m.achievements,

	"agentAssignments": (m) => m.agentAssignments,

	"agentPerformance": (m) => m.agentPerformance,

	"agentTeams": (m) => m.agentTeams,

	"teamMemberships": (m) => m.teamMemberships,

	"apiKeys": (m) => m.apiKeys,

	"apiTokens": (m) => m.apiTokens,

	"appointments": (m) => m.appointments,

	"auditLogs": (m) => m.auditLogs,

	"budgets": (m) => m.budgets,

	"calendarEvents": (m) => m.calendarEvents,

	"clientRelationships": (m) => m.clientRelationships,

	"dashboardConfigurations": (m) => m.dashboardConfigurations,

	"dashboardWidgets": (m) => m.dashboardWidgets,

	"documents": (m) => m.documents,

	"earnings": (m) => m.earnings,

	"eventAttendees": (m) => m.eventAttendees,

	"governmentIntegrations": (m) => m.governmentIntegrations,

	"investorPortfolio": (m) => m.investorPortfolio,

	"leads": (m) => m.leads,

	"loyaltyAccounts": (m) => m.loyaltyAccounts,

	"workOrdersReported": (m) => m.workOrdersReported,

	"maintenanceAssigned": (m) => m.maintenanceAssigned,

	"mobileDevices": (m) => m.mobileDevices,

	"notifications": (m) => m.notifications,

	"offlineSyncQueues": (m) => m.offlineSyncQueues,

	"managedProjects": (m) => m.managedProjects,

	"propertyCompliance": (m) => m.propertyCompliance,

	"assignedViewings": (m) => m.assignedViewings,

	"referrals": (m) => m.referrals,

	"reports": (m) => m.reports,

	"sessions": (m) => m.sessions,

	"signatureSigners": (m) => m.signatureSigners,

	"tasks": (m) => m.tasks,

	"activityLogs": (m) => m.activityLogs,

	"financialProfile": (m) => m.financialProfile,

	"preferences": (m) => m.preferences,

	"gdprConsentAt": (m) => m.gdprConsentAt,

	"ccpaOptOutAt": (m) => m.ccpaOptOutAt,

	"dataRetentionUntil": (m) => m.dataRetentionUntil,

	"anonymizedAt": (m) => m.anonymizedAt,

	"extraCharges": (m) => m.extraCharges,

	"currencies": (m) => m.currencies,

	"agencies": (m) => m.agencies,

	"agencyMemberships": (m) => m.agencyMemberships,

	"includedServices": (m) => m.includedServices,

	"hashtags": (m) => m.hashtags,

	"tenants": (m) => m.tenants,

	"agentOwners": (m) => m.agentOwners,

	"mentionsByUser": (m) => m.mentionsByUser,

	"mentionsToUser": (m) => m.mentionsToUser,

	"mentionsAsGeneric": (m) => m.mentionsAsGeneric,

	"propertyPromotions": (m) => m.propertyPromotions,

	"assignedTickets": (m) => m.assignedTickets,

	"tickets": (m) => m.tickets,

	"accounts": (m) => m.accounts,

	"communicationLogs": (m) => m.communicationLogs,

	"favorites": (m) => m.favorites,

	"languages": (m) => m.languages,

	"offers": (m) => m.offers,

	"photos": (m) => m.photos,

	"posts": (m) => m.posts,

	"analytics": (m) => m.analytics,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(User) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in User');
    }
    return propFunction as V? Function(User);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory User.fromJson(JsonMap json) =>
      User(
        id: json['id'] as String?,
	email: json['email'] as String?,
	name: json['name'] as String?,
	phone: json['phone'] as String?,
	locale: json['locale'] as String?,
	timezone: json['timezone'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	achievements: json['achievements'] != null ? createModels<Achievement>((json['achievements'] as List).cast<JsonMap>(), Achievement.fromJson) : null,
	agentAssignments: json['agentAssignments'] != null ? createModels<AgentAssignment>((json['agentAssignments'] as List).cast<JsonMap>(), AgentAssignment.fromJson) : null,
	agentPerformance: json['agentPerformance'] != null ? createModels<AgentPerformance>((json['agentPerformance'] as List).cast<JsonMap>(), AgentPerformance.fromJson) : null,
	agentTeams: json['agentTeams'] != null ? createModels<AgentTeam>((json['agentTeams'] as List).cast<JsonMap>(), AgentTeam.fromJson) : null,
	teamMemberships: json['teamMemberships'] != null ? createModels<AgentTeamMember>((json['teamMemberships'] as List).cast<JsonMap>(), AgentTeamMember.fromJson) : null,
	apiKeys: json['apiKeys'] != null ? createModels<ApiKey>((json['apiKeys'] as List).cast<JsonMap>(), ApiKey.fromJson) : null,
	apiTokens: json['apiTokens'] != null ? createModels<ApiToken>((json['apiTokens'] as List).cast<JsonMap>(), ApiToken.fromJson) : null,
	appointments: json['appointments'] != null ? createModels<Appointment>((json['appointments'] as List).cast<JsonMap>(), Appointment.fromJson) : null,
	auditLogs: json['auditLogs'] != null ? createModels<AuditLog>((json['auditLogs'] as List).cast<JsonMap>(), AuditLog.fromJson) : null,
	budgets: json['budgets'] != null ? createModels<Budget>((json['budgets'] as List).cast<JsonMap>(), Budget.fromJson) : null,
	calendarEvents: json['calendarEvents'] != null ? createModels<CalendarEvent>((json['calendarEvents'] as List).cast<JsonMap>(), CalendarEvent.fromJson) : null,
	clientRelationships: json['clientRelationships'] != null ? createModels<ClientRelationship>((json['clientRelationships'] as List).cast<JsonMap>(), ClientRelationship.fromJson) : null,
	dashboardConfigurations: json['dashboardConfigurations'] != null ? createModels<DashboardConfiguration>((json['dashboardConfigurations'] as List).cast<JsonMap>(), DashboardConfiguration.fromJson) : null,
	dashboardWidgets: json['dashboardWidgets'] != null ? createModels<DashboardWidget>((json['dashboardWidgets'] as List).cast<JsonMap>(), DashboardWidget.fromJson) : null,
	documents: json['documents'] != null ? createModels<Document>((json['documents'] as List).cast<JsonMap>(), Document.fromJson) : null,
	earnings: json['earnings'] != null ? createModels<Earning>((json['earnings'] as List).cast<JsonMap>(), Earning.fromJson) : null,
	eventAttendees: json['eventAttendees'] != null ? createModels<EventAttendee>((json['eventAttendees'] as List).cast<JsonMap>(), EventAttendee.fromJson) : null,
	governmentIntegrations: json['governmentIntegrations'] != null ? createModels<GovernmentIntegration>((json['governmentIntegrations'] as List).cast<JsonMap>(), GovernmentIntegration.fromJson) : null,
	investorPortfolio: json['investorPortfolio'] != null ? InvestorPortfolio.fromJson(json['investorPortfolio'] as JsonMap) : null,
	leads: json['leads'] != null ? createModels<Lead>((json['leads'] as List).cast<JsonMap>(), Lead.fromJson) : null,
	loyaltyAccounts: json['loyaltyAccounts'] != null ? createModels<LoyaltyAccount>((json['loyaltyAccounts'] as List).cast<JsonMap>(), LoyaltyAccount.fromJson) : null,
	workOrdersReported: json['workOrdersReported'] != null ? createModels<MaintenanceWorkOrder>((json['workOrdersReported'] as List).cast<JsonMap>(), MaintenanceWorkOrder.fromJson) : null,
	maintenanceAssigned: json['maintenanceAssigned'] != null ? createModels<MaintenanceWorkOrder>((json['maintenanceAssigned'] as List).cast<JsonMap>(), MaintenanceWorkOrder.fromJson) : null,
	mobileDevices: json['mobileDevices'] != null ? createModels<MobileDevice>((json['mobileDevices'] as List).cast<JsonMap>(), MobileDevice.fromJson) : null,
	notifications: json['notifications'] != null ? createModels<Notification>((json['notifications'] as List).cast<JsonMap>(), Notification.fromJson) : null,
	offlineSyncQueues: json['offlineSyncQueues'] != null ? createModels<OfflineSyncQueue>((json['offlineSyncQueues'] as List).cast<JsonMap>(), OfflineSyncQueue.fromJson) : null,
	managedProjects: json['managedProjects'] != null ? createModels<Project>((json['managedProjects'] as List).cast<JsonMap>(), Project.fromJson) : null,
	propertyCompliance: json['propertyCompliance'] != null ? createModels<PropertyCompliance>((json['propertyCompliance'] as List).cast<JsonMap>(), PropertyCompliance.fromJson) : null,
	assignedViewings: json['assignedViewings'] != null ? createModels<PropertyViewing>((json['assignedViewings'] as List).cast<JsonMap>(), PropertyViewing.fromJson) : null,
	referrals: json['referrals'] != null ? createModels<Referral>((json['referrals'] as List).cast<JsonMap>(), Referral.fromJson) : null,
	reports: json['reports'] != null ? createModels<Report>((json['reports'] as List).cast<JsonMap>(), Report.fromJson) : null,
	sessions: json['sessions'] != null ? createModels<Session>((json['sessions'] as List).cast<JsonMap>(), Session.fromJson) : null,
	signatureSigners: json['signatureSigners'] != null ? createModels<SignatureSigner>((json['signatureSigners'] as List).cast<JsonMap>(), SignatureSigner.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	activityLogs: json['activityLogs'] != null ? createModels<UserActivityLog>((json['activityLogs'] as List).cast<JsonMap>(), UserActivityLog.fromJson) : null,
	financialProfile: json['financialProfile'] != null ? UserFinancialProfile.fromJson(json['financialProfile'] as JsonMap) : null,
	preferences: json['preferences'] != null ? UserPreference.fromJson(json['preferences'] as JsonMap) : null,
	gdprConsentAt: json['gdprConsentAt'] != null ? DateTime.parse(json['gdprConsentAt']) : null,
	ccpaOptOutAt: json['ccpaOptOutAt'] != null ? DateTime.parse(json['ccpaOptOutAt']) : null,
	dataRetentionUntil: json['dataRetentionUntil'] != null ? DateTime.parse(json['dataRetentionUntil']) : null,
	anonymizedAt: json['anonymizedAt'] != null ? DateTime.parse(json['anonymizedAt']) : null,
	extraCharges: json['extraCharges'] != null ? createModels<ExtraCharge>((json['extraCharges'] as List).cast<JsonMap>(), ExtraCharge.fromJson) : null,
	currencies: json['currencies'] != null ? createModels<Currency>((json['currencies'] as List).cast<JsonMap>(), Currency.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	agencyMemberships: json['agencyMemberships'] != null ? createModels<Agency>((json['agencyMemberships'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	includedServices: json['includedServices'] != null ? createModels<IncludedService>((json['includedServices'] as List).cast<JsonMap>(), IncludedService.fromJson) : null,
	hashtags: json['hashtags'] != null ? createModels<Hashtag>((json['hashtags'] as List).cast<JsonMap>(), Hashtag.fromJson) : null,
	tenants: json['tenants'] != null ? createModels<Tenant>((json['tenants'] as List).cast<JsonMap>(), Tenant.fromJson) : null,
	agentOwners: json['agentOwners'] != null ? createModels<Agent>((json['agentOwners'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	mentionsByUser: json['mentionsByUser'] != null ? createModels<Mention>((json['mentionsByUser'] as List).cast<JsonMap>(), Mention.fromJson) : null,
	mentionsToUser: json['mentionsToUser'] != null ? createModels<Mention>((json['mentionsToUser'] as List).cast<JsonMap>(), Mention.fromJson) : null,
	mentionsAsGeneric: json['mentionsAsGeneric'] != null ? createModels<Mention>((json['mentionsAsGeneric'] as List).cast<JsonMap>(), Mention.fromJson) : null,
	propertyPromotions: json['propertyPromotions'] != null ? createModels<PropertyPromotion>((json['propertyPromotions'] as List).cast<JsonMap>(), PropertyPromotion.fromJson) : null,
	assignedTickets: json['assignedTickets'] != null ? createModels<Ticket>((json['assignedTickets'] as List).cast<JsonMap>(), Ticket.fromJson) : null,
	tickets: json['tickets'] != null ? createModels<Ticket>((json['tickets'] as List).cast<JsonMap>(), Ticket.fromJson) : null,
	accounts: json['accounts'] != null ? createModels<Account>((json['accounts'] as List).cast<JsonMap>(), Account.fromJson) : null,
	communicationLogs: json['communicationLogs'] != null ? createModels<CommunicationLog>((json['communicationLogs'] as List).cast<JsonMap>(), CommunicationLog.fromJson) : null,
	favorites: json['favorites'] != null ? createModels<Favorite>((json['favorites'] as List).cast<JsonMap>(), Favorite.fromJson) : null,
	languages: json['languages'] != null ? createModels<Language>((json['languages'] as List).cast<JsonMap>(), Language.fromJson) : null,
	offers: json['offers'] != null ? createModels<Offer>((json['offers'] as List).cast<JsonMap>(), Offer.fromJson) : null,
	photos: json['photos'] != null ? createModels<Photo>((json['photos'] as List).cast<JsonMap>(), Photo.fromJson) : null,
	posts: json['posts'] != null ? createModels<Post>((json['posts'] as List).cast<JsonMap>(), Post.fromJson) : null,
	analytics: json['analytics'] != null ? createModels<Analytics>((json['analytics'] as List).cast<JsonMap>(), Analytics.fromJson) : null,
	$achievementsCount: json['_count']?['achievements'] as int?,
	$agentAssignmentsCount: json['_count']?['agentAssignments'] as int?,
	$agentPerformanceCount: json['_count']?['agentPerformance'] as int?,
	$agentTeamsCount: json['_count']?['agentTeams'] as int?,
	$teamMembershipsCount: json['_count']?['teamMemberships'] as int?,
	$apiKeysCount: json['_count']?['apiKeys'] as int?,
	$apiTokensCount: json['_count']?['apiTokens'] as int?,
	$appointmentsCount: json['_count']?['appointments'] as int?,
	$auditLogsCount: json['_count']?['auditLogs'] as int?,
	$budgetsCount: json['_count']?['budgets'] as int?,
	$calendarEventsCount: json['_count']?['calendarEvents'] as int?,
	$clientRelationshipsCount: json['_count']?['clientRelationships'] as int?,
	$dashboardConfigurationsCount: json['_count']?['dashboardConfigurations'] as int?,
	$dashboardWidgetsCount: json['_count']?['dashboardWidgets'] as int?,
	$documentsCount: json['_count']?['documents'] as int?,
	$earningsCount: json['_count']?['earnings'] as int?,
	$eventAttendeesCount: json['_count']?['eventAttendees'] as int?,
	$governmentIntegrationsCount: json['_count']?['governmentIntegrations'] as int?,
	$leadsCount: json['_count']?['leads'] as int?,
	$loyaltyAccountsCount: json['_count']?['loyaltyAccounts'] as int?,
	$workOrdersReportedCount: json['_count']?['workOrdersReported'] as int?,
	$maintenanceAssignedCount: json['_count']?['maintenanceAssigned'] as int?,
	$mobileDevicesCount: json['_count']?['mobileDevices'] as int?,
	$notificationsCount: json['_count']?['notifications'] as int?,
	$offlineSyncQueuesCount: json['_count']?['offlineSyncQueues'] as int?,
	$managedProjectsCount: json['_count']?['managedProjects'] as int?,
	$propertyComplianceCount: json['_count']?['propertyCompliance'] as int?,
	$assignedViewingsCount: json['_count']?['assignedViewings'] as int?,
	$referralsCount: json['_count']?['referrals'] as int?,
	$reportsCount: json['_count']?['reports'] as int?,
	$sessionsCount: json['_count']?['sessions'] as int?,
	$signatureSignersCount: json['_count']?['signatureSigners'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$activityLogsCount: json['_count']?['activityLogs'] as int?,
	$extraChargesCount: json['_count']?['extraCharges'] as int?,
	$currenciesCount: json['_count']?['currencies'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$agencyMembershipsCount: json['_count']?['agencyMemberships'] as int?,
	$includedServicesCount: json['_count']?['includedServices'] as int?,
	$hashtagsCount: json['_count']?['hashtags'] as int?,
	$tenantsCount: json['_count']?['tenants'] as int?,
	$agentOwnersCount: json['_count']?['agentOwners'] as int?,
	$mentionsByUserCount: json['_count']?['mentionsByUser'] as int?,
	$mentionsToUserCount: json['_count']?['mentionsToUser'] as int?,
	$mentionsAsGenericCount: json['_count']?['mentionsAsGeneric'] as int?,
	$propertyPromotionsCount: json['_count']?['propertyPromotions'] as int?,
	$assignedTicketsCount: json['_count']?['assignedTickets'] as int?,
	$ticketsCount: json['_count']?['tickets'] as int?,
	$accountsCount: json['_count']?['accounts'] as int?,
	$communicationLogsCount: json['_count']?['communicationLogs'] as int?,
	$favoritesCount: json['_count']?['favorites'] as int?,
	$languagesCount: json['_count']?['languages'] as int?,
	$offersCount: json['_count']?['offers'] as int?,
	$photosCount: json['_count']?['photos'] as int?,
	$postsCount: json['_count']?['posts'] as int?,
	$analyticsCount: json['_count']?['analytics'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    User copyWith({
        Value<String?>? id,
		Value<String?>? email,
		Value<String?>? name,
		Value<String?>? phone,
		Value<String?>? locale,
		Value<String?>? timezone,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Achievement>?>? achievements,
		Value<List<AgentAssignment>?>? agentAssignments,
		Value<List<AgentPerformance>?>? agentPerformance,
		Value<List<AgentTeam>?>? agentTeams,
		Value<List<AgentTeamMember>?>? teamMemberships,
		Value<List<ApiKey>?>? apiKeys,
		Value<List<ApiToken>?>? apiTokens,
		Value<List<Appointment>?>? appointments,
		Value<List<AuditLog>?>? auditLogs,
		Value<List<Budget>?>? budgets,
		Value<List<CalendarEvent>?>? calendarEvents,
		Value<List<ClientRelationship>?>? clientRelationships,
		Value<List<DashboardConfiguration>?>? dashboardConfigurations,
		Value<List<DashboardWidget>?>? dashboardWidgets,
		Value<List<Document>?>? documents,
		Value<List<Earning>?>? earnings,
		Value<List<EventAttendee>?>? eventAttendees,
		Value<List<GovernmentIntegration>?>? governmentIntegrations,
		Value<InvestorPortfolio?>? investorPortfolio,
		Value<List<Lead>?>? leads,
		Value<List<LoyaltyAccount>?>? loyaltyAccounts,
		Value<List<MaintenanceWorkOrder>?>? workOrdersReported,
		Value<List<MaintenanceWorkOrder>?>? maintenanceAssigned,
		Value<List<MobileDevice>?>? mobileDevices,
		Value<List<Notification>?>? notifications,
		Value<List<OfflineSyncQueue>?>? offlineSyncQueues,
		Value<List<Project>?>? managedProjects,
		Value<List<PropertyCompliance>?>? propertyCompliance,
		Value<List<PropertyViewing>?>? assignedViewings,
		Value<List<Referral>?>? referrals,
		Value<List<Report>?>? reports,
		Value<List<Session>?>? sessions,
		Value<List<SignatureSigner>?>? signatureSigners,
		Value<List<Task>?>? tasks,
		Value<List<UserActivityLog>?>? activityLogs,
		Value<UserFinancialProfile?>? financialProfile,
		Value<UserPreference?>? preferences,
		Value<DateTime?>? gdprConsentAt,
		Value<DateTime?>? ccpaOptOutAt,
		Value<DateTime?>? dataRetentionUntil,
		Value<DateTime?>? anonymizedAt,
		Value<List<ExtraCharge>?>? extraCharges,
		Value<List<Currency>?>? currencies,
		Value<List<Agency>?>? agencies,
		Value<List<Agency>?>? agencyMemberships,
		Value<List<IncludedService>?>? includedServices,
		Value<List<Hashtag>?>? hashtags,
		Value<List<Tenant>?>? tenants,
		Value<List<Agent>?>? agentOwners,
		Value<List<Mention>?>? mentionsByUser,
		Value<List<Mention>?>? mentionsToUser,
		Value<List<Mention>?>? mentionsAsGeneric,
		Value<List<PropertyPromotion>?>? propertyPromotions,
		Value<List<Ticket>?>? assignedTickets,
		Value<List<Ticket>?>? tickets,
		Value<List<Account>?>? accounts,
		Value<List<CommunicationLog>?>? communicationLogs,
		Value<List<Favorite>?>? favorites,
		Value<List<Language>?>? languages,
		Value<List<Offer>?>? offers,
		Value<List<Photo>?>? photos,
		Value<List<Post>?>? posts,
		Value<List<Analytics>?>? analytics,
		int? $achievementsCount,
		int? $agentAssignmentsCount,
		int? $agentPerformanceCount,
		int? $agentTeamsCount,
		int? $teamMembershipsCount,
		int? $apiKeysCount,
		int? $apiTokensCount,
		int? $appointmentsCount,
		int? $auditLogsCount,
		int? $budgetsCount,
		int? $calendarEventsCount,
		int? $clientRelationshipsCount,
		int? $dashboardConfigurationsCount,
		int? $dashboardWidgetsCount,
		int? $documentsCount,
		int? $earningsCount,
		int? $eventAttendeesCount,
		int? $governmentIntegrationsCount,
		int? $leadsCount,
		int? $loyaltyAccountsCount,
		int? $workOrdersReportedCount,
		int? $maintenanceAssignedCount,
		int? $mobileDevicesCount,
		int? $notificationsCount,
		int? $offlineSyncQueuesCount,
		int? $managedProjectsCount,
		int? $propertyComplianceCount,
		int? $assignedViewingsCount,
		int? $referralsCount,
		int? $reportsCount,
		int? $sessionsCount,
		int? $signatureSignersCount,
		int? $tasksCount,
		int? $activityLogsCount,
		int? $extraChargesCount,
		int? $currenciesCount,
		int? $agenciesCount,
		int? $agencyMembershipsCount,
		int? $includedServicesCount,
		int? $hashtagsCount,
		int? $tenantsCount,
		int? $agentOwnersCount,
		int? $mentionsByUserCount,
		int? $mentionsToUserCount,
		int? $mentionsAsGenericCount,
		int? $propertyPromotionsCount,
		int? $assignedTicketsCount,
		int? $ticketsCount,
		int? $accountsCount,
		int? $communicationLogsCount,
		int? $favoritesCount,
		int? $languagesCount,
		int? $offersCount,
		int? $photosCount,
		int? $postsCount,
		int? $analyticsCount,
        }) {
        return User(
            id: id != null ? id.value : this.id,
		email: email != null ? email.value : this.email,
		name: name != null ? name.value : this.name,
		phone: phone != null ? phone.value : this.phone,
		locale: locale != null ? locale.value : this.locale,
		timezone: timezone != null ? timezone.value : this.timezone,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		achievements: achievements != null ? achievements.value : this.achievements,
		agentAssignments: agentAssignments != null ? agentAssignments.value : this.agentAssignments,
		agentPerformance: agentPerformance != null ? agentPerformance.value : this.agentPerformance,
		agentTeams: agentTeams != null ? agentTeams.value : this.agentTeams,
		teamMemberships: teamMemberships != null ? teamMemberships.value : this.teamMemberships,
		apiKeys: apiKeys != null ? apiKeys.value : this.apiKeys,
		apiTokens: apiTokens != null ? apiTokens.value : this.apiTokens,
		appointments: appointments != null ? appointments.value : this.appointments,
		auditLogs: auditLogs != null ? auditLogs.value : this.auditLogs,
		budgets: budgets != null ? budgets.value : this.budgets,
		calendarEvents: calendarEvents != null ? calendarEvents.value : this.calendarEvents,
		clientRelationships: clientRelationships != null ? clientRelationships.value : this.clientRelationships,
		dashboardConfigurations: dashboardConfigurations != null ? dashboardConfigurations.value : this.dashboardConfigurations,
		dashboardWidgets: dashboardWidgets != null ? dashboardWidgets.value : this.dashboardWidgets,
		documents: documents != null ? documents.value : this.documents,
		earnings: earnings != null ? earnings.value : this.earnings,
		eventAttendees: eventAttendees != null ? eventAttendees.value : this.eventAttendees,
		governmentIntegrations: governmentIntegrations != null ? governmentIntegrations.value : this.governmentIntegrations,
		investorPortfolio: investorPortfolio != null ? investorPortfolio.value : this.investorPortfolio,
		leads: leads != null ? leads.value : this.leads,
		loyaltyAccounts: loyaltyAccounts != null ? loyaltyAccounts.value : this.loyaltyAccounts,
		workOrdersReported: workOrdersReported != null ? workOrdersReported.value : this.workOrdersReported,
		maintenanceAssigned: maintenanceAssigned != null ? maintenanceAssigned.value : this.maintenanceAssigned,
		mobileDevices: mobileDevices != null ? mobileDevices.value : this.mobileDevices,
		notifications: notifications != null ? notifications.value : this.notifications,
		offlineSyncQueues: offlineSyncQueues != null ? offlineSyncQueues.value : this.offlineSyncQueues,
		managedProjects: managedProjects != null ? managedProjects.value : this.managedProjects,
		propertyCompliance: propertyCompliance != null ? propertyCompliance.value : this.propertyCompliance,
		assignedViewings: assignedViewings != null ? assignedViewings.value : this.assignedViewings,
		referrals: referrals != null ? referrals.value : this.referrals,
		reports: reports != null ? reports.value : this.reports,
		sessions: sessions != null ? sessions.value : this.sessions,
		signatureSigners: signatureSigners != null ? signatureSigners.value : this.signatureSigners,
		tasks: tasks != null ? tasks.value : this.tasks,
		activityLogs: activityLogs != null ? activityLogs.value : this.activityLogs,
		financialProfile: financialProfile != null ? financialProfile.value : this.financialProfile,
		preferences: preferences != null ? preferences.value : this.preferences,
		gdprConsentAt: gdprConsentAt != null ? gdprConsentAt.value : this.gdprConsentAt,
		ccpaOptOutAt: ccpaOptOutAt != null ? ccpaOptOutAt.value : this.ccpaOptOutAt,
		dataRetentionUntil: dataRetentionUntil != null ? dataRetentionUntil.value : this.dataRetentionUntil,
		anonymizedAt: anonymizedAt != null ? anonymizedAt.value : this.anonymizedAt,
		extraCharges: extraCharges != null ? extraCharges.value : this.extraCharges,
		currencies: currencies != null ? currencies.value : this.currencies,
		agencies: agencies != null ? agencies.value : this.agencies,
		agencyMemberships: agencyMemberships != null ? agencyMemberships.value : this.agencyMemberships,
		includedServices: includedServices != null ? includedServices.value : this.includedServices,
		hashtags: hashtags != null ? hashtags.value : this.hashtags,
		tenants: tenants != null ? tenants.value : this.tenants,
		agentOwners: agentOwners != null ? agentOwners.value : this.agentOwners,
		mentionsByUser: mentionsByUser != null ? mentionsByUser.value : this.mentionsByUser,
		mentionsToUser: mentionsToUser != null ? mentionsToUser.value : this.mentionsToUser,
		mentionsAsGeneric: mentionsAsGeneric != null ? mentionsAsGeneric.value : this.mentionsAsGeneric,
		propertyPromotions: propertyPromotions != null ? propertyPromotions.value : this.propertyPromotions,
		assignedTickets: assignedTickets != null ? assignedTickets.value : this.assignedTickets,
		tickets: tickets != null ? tickets.value : this.tickets,
		accounts: accounts != null ? accounts.value : this.accounts,
		communicationLogs: communicationLogs != null ? communicationLogs.value : this.communicationLogs,
		favorites: favorites != null ? favorites.value : this.favorites,
		languages: languages != null ? languages.value : this.languages,
		offers: offers != null ? offers.value : this.offers,
		photos: photos != null ? photos.value : this.photos,
		posts: posts != null ? posts.value : this.posts,
		analytics: analytics != null ? analytics.value : this.analytics,
		$achievementsCount: $achievementsCount ?? this.$achievementsCount,
		$agentAssignmentsCount: $agentAssignmentsCount ?? this.$agentAssignmentsCount,
		$agentPerformanceCount: $agentPerformanceCount ?? this.$agentPerformanceCount,
		$agentTeamsCount: $agentTeamsCount ?? this.$agentTeamsCount,
		$teamMembershipsCount: $teamMembershipsCount ?? this.$teamMembershipsCount,
		$apiKeysCount: $apiKeysCount ?? this.$apiKeysCount,
		$apiTokensCount: $apiTokensCount ?? this.$apiTokensCount,
		$appointmentsCount: $appointmentsCount ?? this.$appointmentsCount,
		$auditLogsCount: $auditLogsCount ?? this.$auditLogsCount,
		$budgetsCount: $budgetsCount ?? this.$budgetsCount,
		$calendarEventsCount: $calendarEventsCount ?? this.$calendarEventsCount,
		$clientRelationshipsCount: $clientRelationshipsCount ?? this.$clientRelationshipsCount,
		$dashboardConfigurationsCount: $dashboardConfigurationsCount ?? this.$dashboardConfigurationsCount,
		$dashboardWidgetsCount: $dashboardWidgetsCount ?? this.$dashboardWidgetsCount,
		$documentsCount: $documentsCount ?? this.$documentsCount,
		$earningsCount: $earningsCount ?? this.$earningsCount,
		$eventAttendeesCount: $eventAttendeesCount ?? this.$eventAttendeesCount,
		$governmentIntegrationsCount: $governmentIntegrationsCount ?? this.$governmentIntegrationsCount,
		$leadsCount: $leadsCount ?? this.$leadsCount,
		$loyaltyAccountsCount: $loyaltyAccountsCount ?? this.$loyaltyAccountsCount,
		$workOrdersReportedCount: $workOrdersReportedCount ?? this.$workOrdersReportedCount,
		$maintenanceAssignedCount: $maintenanceAssignedCount ?? this.$maintenanceAssignedCount,
		$mobileDevicesCount: $mobileDevicesCount ?? this.$mobileDevicesCount,
		$notificationsCount: $notificationsCount ?? this.$notificationsCount,
		$offlineSyncQueuesCount: $offlineSyncQueuesCount ?? this.$offlineSyncQueuesCount,
		$managedProjectsCount: $managedProjectsCount ?? this.$managedProjectsCount,
		$propertyComplianceCount: $propertyComplianceCount ?? this.$propertyComplianceCount,
		$assignedViewingsCount: $assignedViewingsCount ?? this.$assignedViewingsCount,
		$referralsCount: $referralsCount ?? this.$referralsCount,
		$reportsCount: $reportsCount ?? this.$reportsCount,
		$sessionsCount: $sessionsCount ?? this.$sessionsCount,
		$signatureSignersCount: $signatureSignersCount ?? this.$signatureSignersCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$activityLogsCount: $activityLogsCount ?? this.$activityLogsCount,
		$extraChargesCount: $extraChargesCount ?? this.$extraChargesCount,
		$currenciesCount: $currenciesCount ?? this.$currenciesCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$agencyMembershipsCount: $agencyMembershipsCount ?? this.$agencyMembershipsCount,
		$includedServicesCount: $includedServicesCount ?? this.$includedServicesCount,
		$hashtagsCount: $hashtagsCount ?? this.$hashtagsCount,
		$tenantsCount: $tenantsCount ?? this.$tenantsCount,
		$agentOwnersCount: $agentOwnersCount ?? this.$agentOwnersCount,
		$mentionsByUserCount: $mentionsByUserCount ?? this.$mentionsByUserCount,
		$mentionsToUserCount: $mentionsToUserCount ?? this.$mentionsToUserCount,
		$mentionsAsGenericCount: $mentionsAsGenericCount ?? this.$mentionsAsGenericCount,
		$propertyPromotionsCount: $propertyPromotionsCount ?? this.$propertyPromotionsCount,
		$assignedTicketsCount: $assignedTicketsCount ?? this.$assignedTicketsCount,
		$ticketsCount: $ticketsCount ?? this.$ticketsCount,
		$accountsCount: $accountsCount ?? this.$accountsCount,
		$communicationLogsCount: $communicationLogsCount ?? this.$communicationLogsCount,
		$favoritesCount: $favoritesCount ?? this.$favoritesCount,
		$languagesCount: $languagesCount ?? this.$languagesCount,
		$offersCount: $offersCount ?? this.$offersCount,
		$photosCount: $photosCount ?? this.$photosCount,
		$postsCount: $postsCount ?? this.$postsCount,
		$analyticsCount: $analyticsCount ?? this.$analyticsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    User copyWithInstanceValues(User user) {
        return User(
            id: user.id ?? id,
		email: user.email ?? email,
		name: user.name ?? name,
		phone: user.phone ?? phone,
		locale: user.locale ?? locale,
		timezone: user.timezone ?? timezone,
		createdAt: user.createdAt ?? createdAt,
		updatedAt: user.updatedAt ?? updatedAt,
		deletedAt: user.deletedAt ?? deletedAt,
		achievements: user.achievements ?? achievements,
		agentAssignments: user.agentAssignments ?? agentAssignments,
		agentPerformance: user.agentPerformance ?? agentPerformance,
		agentTeams: user.agentTeams ?? agentTeams,
		teamMemberships: user.teamMemberships ?? teamMemberships,
		apiKeys: user.apiKeys ?? apiKeys,
		apiTokens: user.apiTokens ?? apiTokens,
		appointments: user.appointments ?? appointments,
		auditLogs: user.auditLogs ?? auditLogs,
		budgets: user.budgets ?? budgets,
		calendarEvents: user.calendarEvents ?? calendarEvents,
		clientRelationships: user.clientRelationships ?? clientRelationships,
		dashboardConfigurations: user.dashboardConfigurations ?? dashboardConfigurations,
		dashboardWidgets: user.dashboardWidgets ?? dashboardWidgets,
		documents: user.documents ?? documents,
		earnings: user.earnings ?? earnings,
		eventAttendees: user.eventAttendees ?? eventAttendees,
		governmentIntegrations: user.governmentIntegrations ?? governmentIntegrations,
		investorPortfolio: user.investorPortfolio ?? investorPortfolio,
		leads: user.leads ?? leads,
		loyaltyAccounts: user.loyaltyAccounts ?? loyaltyAccounts,
		workOrdersReported: user.workOrdersReported ?? workOrdersReported,
		maintenanceAssigned: user.maintenanceAssigned ?? maintenanceAssigned,
		mobileDevices: user.mobileDevices ?? mobileDevices,
		notifications: user.notifications ?? notifications,
		offlineSyncQueues: user.offlineSyncQueues ?? offlineSyncQueues,
		managedProjects: user.managedProjects ?? managedProjects,
		propertyCompliance: user.propertyCompliance ?? propertyCompliance,
		assignedViewings: user.assignedViewings ?? assignedViewings,
		referrals: user.referrals ?? referrals,
		reports: user.reports ?? reports,
		sessions: user.sessions ?? sessions,
		signatureSigners: user.signatureSigners ?? signatureSigners,
		tasks: user.tasks ?? tasks,
		activityLogs: user.activityLogs ?? activityLogs,
		financialProfile: user.financialProfile ?? financialProfile,
		preferences: user.preferences ?? preferences,
		gdprConsentAt: user.gdprConsentAt ?? gdprConsentAt,
		ccpaOptOutAt: user.ccpaOptOutAt ?? ccpaOptOutAt,
		dataRetentionUntil: user.dataRetentionUntil ?? dataRetentionUntil,
		anonymizedAt: user.anonymizedAt ?? anonymizedAt,
		extraCharges: user.extraCharges ?? extraCharges,
		currencies: user.currencies ?? currencies,
		agencies: user.agencies ?? agencies,
		agencyMemberships: user.agencyMemberships ?? agencyMemberships,
		includedServices: user.includedServices ?? includedServices,
		hashtags: user.hashtags ?? hashtags,
		tenants: user.tenants ?? tenants,
		agentOwners: user.agentOwners ?? agentOwners,
		mentionsByUser: user.mentionsByUser ?? mentionsByUser,
		mentionsToUser: user.mentionsToUser ?? mentionsToUser,
		mentionsAsGeneric: user.mentionsAsGeneric ?? mentionsAsGeneric,
		propertyPromotions: user.propertyPromotions ?? propertyPromotions,
		assignedTickets: user.assignedTickets ?? assignedTickets,
		tickets: user.tickets ?? tickets,
		accounts: user.accounts ?? accounts,
		communicationLogs: user.communicationLogs ?? communicationLogs,
		favorites: user.favorites ?? favorites,
		languages: user.languages ?? languages,
		offers: user.offers ?? offers,
		photos: user.photos ?? photos,
		posts: user.posts ?? posts,
		analytics: user.analytics ?? analytics,
		$achievementsCount: user.$achievementsCount ?? $achievementsCount,
		$agentAssignmentsCount: user.$agentAssignmentsCount ?? $agentAssignmentsCount,
		$agentPerformanceCount: user.$agentPerformanceCount ?? $agentPerformanceCount,
		$agentTeamsCount: user.$agentTeamsCount ?? $agentTeamsCount,
		$teamMembershipsCount: user.$teamMembershipsCount ?? $teamMembershipsCount,
		$apiKeysCount: user.$apiKeysCount ?? $apiKeysCount,
		$apiTokensCount: user.$apiTokensCount ?? $apiTokensCount,
		$appointmentsCount: user.$appointmentsCount ?? $appointmentsCount,
		$auditLogsCount: user.$auditLogsCount ?? $auditLogsCount,
		$budgetsCount: user.$budgetsCount ?? $budgetsCount,
		$calendarEventsCount: user.$calendarEventsCount ?? $calendarEventsCount,
		$clientRelationshipsCount: user.$clientRelationshipsCount ?? $clientRelationshipsCount,
		$dashboardConfigurationsCount: user.$dashboardConfigurationsCount ?? $dashboardConfigurationsCount,
		$dashboardWidgetsCount: user.$dashboardWidgetsCount ?? $dashboardWidgetsCount,
		$documentsCount: user.$documentsCount ?? $documentsCount,
		$earningsCount: user.$earningsCount ?? $earningsCount,
		$eventAttendeesCount: user.$eventAttendeesCount ?? $eventAttendeesCount,
		$governmentIntegrationsCount: user.$governmentIntegrationsCount ?? $governmentIntegrationsCount,
		$leadsCount: user.$leadsCount ?? $leadsCount,
		$loyaltyAccountsCount: user.$loyaltyAccountsCount ?? $loyaltyAccountsCount,
		$workOrdersReportedCount: user.$workOrdersReportedCount ?? $workOrdersReportedCount,
		$maintenanceAssignedCount: user.$maintenanceAssignedCount ?? $maintenanceAssignedCount,
		$mobileDevicesCount: user.$mobileDevicesCount ?? $mobileDevicesCount,
		$notificationsCount: user.$notificationsCount ?? $notificationsCount,
		$offlineSyncQueuesCount: user.$offlineSyncQueuesCount ?? $offlineSyncQueuesCount,
		$managedProjectsCount: user.$managedProjectsCount ?? $managedProjectsCount,
		$propertyComplianceCount: user.$propertyComplianceCount ?? $propertyComplianceCount,
		$assignedViewingsCount: user.$assignedViewingsCount ?? $assignedViewingsCount,
		$referralsCount: user.$referralsCount ?? $referralsCount,
		$reportsCount: user.$reportsCount ?? $reportsCount,
		$sessionsCount: user.$sessionsCount ?? $sessionsCount,
		$signatureSignersCount: user.$signatureSignersCount ?? $signatureSignersCount,
		$tasksCount: user.$tasksCount ?? $tasksCount,
		$activityLogsCount: user.$activityLogsCount ?? $activityLogsCount,
		$extraChargesCount: user.$extraChargesCount ?? $extraChargesCount,
		$currenciesCount: user.$currenciesCount ?? $currenciesCount,
		$agenciesCount: user.$agenciesCount ?? $agenciesCount,
		$agencyMembershipsCount: user.$agencyMembershipsCount ?? $agencyMembershipsCount,
		$includedServicesCount: user.$includedServicesCount ?? $includedServicesCount,
		$hashtagsCount: user.$hashtagsCount ?? $hashtagsCount,
		$tenantsCount: user.$tenantsCount ?? $tenantsCount,
		$agentOwnersCount: user.$agentOwnersCount ?? $agentOwnersCount,
		$mentionsByUserCount: user.$mentionsByUserCount ?? $mentionsByUserCount,
		$mentionsToUserCount: user.$mentionsToUserCount ?? $mentionsToUserCount,
		$mentionsAsGenericCount: user.$mentionsAsGenericCount ?? $mentionsAsGenericCount,
		$propertyPromotionsCount: user.$propertyPromotionsCount ?? $propertyPromotionsCount,
		$assignedTicketsCount: user.$assignedTicketsCount ?? $assignedTicketsCount,
		$ticketsCount: user.$ticketsCount ?? $ticketsCount,
		$accountsCount: user.$accountsCount ?? $accountsCount,
		$communicationLogsCount: user.$communicationLogsCount ?? $communicationLogsCount,
		$favoritesCount: user.$favoritesCount ?? $favoritesCount,
		$languagesCount: user.$languagesCount ?? $languagesCount,
		$offersCount: user.$offersCount ?? $offersCount,
		$photosCount: user.$photosCount ?? $photosCount,
		$postsCount: user.$postsCount ?? $postsCount,
		$analyticsCount: user.$analyticsCount ?? $analyticsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    User mergeWithInstanceValues(User user) {
        return User(
            id: user.$assignedFields.contains('id') ? user.id : id,
		email: user.$assignedFields.contains('email') ? user.email : email,
		name: user.$assignedFields.contains('name') ? user.name : name,
		phone: user.$assignedFields.contains('phone') ? user.phone : phone,
		locale: user.$assignedFields.contains('locale') ? user.locale : locale,
		timezone: user.$assignedFields.contains('timezone') ? user.timezone : timezone,
		createdAt: user.$assignedFields.contains('createdAt') ? user.createdAt : createdAt,
		updatedAt: user.$assignedFields.contains('updatedAt') ? user.updatedAt : updatedAt,
		deletedAt: user.$assignedFields.contains('deletedAt') ? user.deletedAt : deletedAt,
		achievements: (user.$assignedFields.contains('achievements') && user.achievements != null) ? mergeModelLists(achievements, user.achievements) : achievements,
		agentAssignments: (user.$assignedFields.contains('agentAssignments') && user.agentAssignments != null) ? mergeModelLists(agentAssignments, user.agentAssignments) : agentAssignments,
		agentPerformance: (user.$assignedFields.contains('agentPerformance') && user.agentPerformance != null) ? mergeModelLists(agentPerformance, user.agentPerformance) : agentPerformance,
		agentTeams: (user.$assignedFields.contains('agentTeams') && user.agentTeams != null) ? mergeModelLists(agentTeams, user.agentTeams) : agentTeams,
		teamMemberships: (user.$assignedFields.contains('teamMemberships') && user.teamMemberships != null) ? mergeModelLists(teamMemberships, user.teamMemberships) : teamMemberships,
		apiKeys: (user.$assignedFields.contains('apiKeys') && user.apiKeys != null) ? mergeModelLists(apiKeys, user.apiKeys) : apiKeys,
		apiTokens: (user.$assignedFields.contains('apiTokens') && user.apiTokens != null) ? mergeModelLists(apiTokens, user.apiTokens) : apiTokens,
		appointments: (user.$assignedFields.contains('appointments') && user.appointments != null) ? mergeModelLists(appointments, user.appointments) : appointments,
		auditLogs: (user.$assignedFields.contains('auditLogs') && user.auditLogs != null) ? mergeModelLists(auditLogs, user.auditLogs) : auditLogs,
		budgets: (user.$assignedFields.contains('budgets') && user.budgets != null) ? mergeModelLists(budgets, user.budgets) : budgets,
		calendarEvents: (user.$assignedFields.contains('calendarEvents') && user.calendarEvents != null) ? mergeModelLists(calendarEvents, user.calendarEvents) : calendarEvents,
		clientRelationships: (user.$assignedFields.contains('clientRelationships') && user.clientRelationships != null) ? mergeModelLists(clientRelationships, user.clientRelationships) : clientRelationships,
		dashboardConfigurations: (user.$assignedFields.contains('dashboardConfigurations') && user.dashboardConfigurations != null) ? mergeModelLists(dashboardConfigurations, user.dashboardConfigurations) : dashboardConfigurations,
		dashboardWidgets: (user.$assignedFields.contains('dashboardWidgets') && user.dashboardWidgets != null) ? mergeModelLists(dashboardWidgets, user.dashboardWidgets) : dashboardWidgets,
		documents: (user.$assignedFields.contains('documents') && user.documents != null) ? mergeModelLists(documents, user.documents) : documents,
		earnings: (user.$assignedFields.contains('earnings') && user.earnings != null) ? mergeModelLists(earnings, user.earnings) : earnings,
		eventAttendees: (user.$assignedFields.contains('eventAttendees') && user.eventAttendees != null) ? mergeModelLists(eventAttendees, user.eventAttendees) : eventAttendees,
		governmentIntegrations: (user.$assignedFields.contains('governmentIntegrations') && user.governmentIntegrations != null) ? mergeModelLists(governmentIntegrations, user.governmentIntegrations) : governmentIntegrations,
		investorPortfolio: user.$assignedFields.contains('investorPortfolio') ? user.investorPortfolio : investorPortfolio,
		leads: (user.$assignedFields.contains('leads') && user.leads != null) ? mergeModelLists(leads, user.leads) : leads,
		loyaltyAccounts: (user.$assignedFields.contains('loyaltyAccounts') && user.loyaltyAccounts != null) ? mergeModelLists(loyaltyAccounts, user.loyaltyAccounts) : loyaltyAccounts,
		workOrdersReported: (user.$assignedFields.contains('workOrdersReported') && user.workOrdersReported != null) ? mergeModelLists(workOrdersReported, user.workOrdersReported) : workOrdersReported,
		maintenanceAssigned: (user.$assignedFields.contains('maintenanceAssigned') && user.maintenanceAssigned != null) ? mergeModelLists(maintenanceAssigned, user.maintenanceAssigned) : maintenanceAssigned,
		mobileDevices: (user.$assignedFields.contains('mobileDevices') && user.mobileDevices != null) ? mergeModelLists(mobileDevices, user.mobileDevices) : mobileDevices,
		notifications: (user.$assignedFields.contains('notifications') && user.notifications != null) ? mergeModelLists(notifications, user.notifications) : notifications,
		offlineSyncQueues: (user.$assignedFields.contains('offlineSyncQueues') && user.offlineSyncQueues != null) ? mergeModelLists(offlineSyncQueues, user.offlineSyncQueues) : offlineSyncQueues,
		managedProjects: (user.$assignedFields.contains('managedProjects') && user.managedProjects != null) ? mergeModelLists(managedProjects, user.managedProjects) : managedProjects,
		propertyCompliance: (user.$assignedFields.contains('propertyCompliance') && user.propertyCompliance != null) ? mergeModelLists(propertyCompliance, user.propertyCompliance) : propertyCompliance,
		assignedViewings: (user.$assignedFields.contains('assignedViewings') && user.assignedViewings != null) ? mergeModelLists(assignedViewings, user.assignedViewings) : assignedViewings,
		referrals: (user.$assignedFields.contains('referrals') && user.referrals != null) ? mergeModelLists(referrals, user.referrals) : referrals,
		reports: (user.$assignedFields.contains('reports') && user.reports != null) ? mergeModelLists(reports, user.reports) : reports,
		sessions: (user.$assignedFields.contains('sessions') && user.sessions != null) ? mergeModelLists(sessions, user.sessions) : sessions,
		signatureSigners: (user.$assignedFields.contains('signatureSigners') && user.signatureSigners != null) ? mergeModelLists(signatureSigners, user.signatureSigners) : signatureSigners,
		tasks: (user.$assignedFields.contains('tasks') && user.tasks != null) ? mergeModelLists(tasks, user.tasks) : tasks,
		activityLogs: (user.$assignedFields.contains('activityLogs') && user.activityLogs != null) ? mergeModelLists(activityLogs, user.activityLogs) : activityLogs,
		financialProfile: user.$assignedFields.contains('financialProfile') ? user.financialProfile : financialProfile,
		preferences: user.$assignedFields.contains('preferences') ? user.preferences : preferences,
		gdprConsentAt: user.$assignedFields.contains('gdprConsentAt') ? user.gdprConsentAt : gdprConsentAt,
		ccpaOptOutAt: user.$assignedFields.contains('ccpaOptOutAt') ? user.ccpaOptOutAt : ccpaOptOutAt,
		dataRetentionUntil: user.$assignedFields.contains('dataRetentionUntil') ? user.dataRetentionUntil : dataRetentionUntil,
		anonymizedAt: user.$assignedFields.contains('anonymizedAt') ? user.anonymizedAt : anonymizedAt,
		extraCharges: (user.$assignedFields.contains('extraCharges') && user.extraCharges != null) ? mergeModelLists(extraCharges, user.extraCharges) : extraCharges,
		currencies: (user.$assignedFields.contains('currencies') && user.currencies != null) ? mergeModelLists(currencies, user.currencies) : currencies,
		agencies: (user.$assignedFields.contains('agencies') && user.agencies != null) ? mergeModelLists(agencies, user.agencies) : agencies,
		agencyMemberships: (user.$assignedFields.contains('agencyMemberships') && user.agencyMemberships != null) ? mergeModelLists(agencyMemberships, user.agencyMemberships) : agencyMemberships,
		includedServices: (user.$assignedFields.contains('includedServices') && user.includedServices != null) ? mergeModelLists(includedServices, user.includedServices) : includedServices,
		hashtags: (user.$assignedFields.contains('hashtags') && user.hashtags != null) ? mergeModelLists(hashtags, user.hashtags) : hashtags,
		tenants: (user.$assignedFields.contains('tenants') && user.tenants != null) ? mergeModelLists(tenants, user.tenants) : tenants,
		agentOwners: (user.$assignedFields.contains('agentOwners') && user.agentOwners != null) ? mergeModelLists(agentOwners, user.agentOwners) : agentOwners,
		mentionsByUser: (user.$assignedFields.contains('mentionsByUser') && user.mentionsByUser != null) ? mergeModelLists(mentionsByUser, user.mentionsByUser) : mentionsByUser,
		mentionsToUser: (user.$assignedFields.contains('mentionsToUser') && user.mentionsToUser != null) ? mergeModelLists(mentionsToUser, user.mentionsToUser) : mentionsToUser,
		mentionsAsGeneric: (user.$assignedFields.contains('mentionsAsGeneric') && user.mentionsAsGeneric != null) ? mergeModelLists(mentionsAsGeneric, user.mentionsAsGeneric) : mentionsAsGeneric,
		propertyPromotions: (user.$assignedFields.contains('propertyPromotions') && user.propertyPromotions != null) ? mergeModelLists(propertyPromotions, user.propertyPromotions) : propertyPromotions,
		assignedTickets: (user.$assignedFields.contains('assignedTickets') && user.assignedTickets != null) ? mergeModelLists(assignedTickets, user.assignedTickets) : assignedTickets,
		tickets: (user.$assignedFields.contains('tickets') && user.tickets != null) ? mergeModelLists(tickets, user.tickets) : tickets,
		accounts: (user.$assignedFields.contains('accounts') && user.accounts != null) ? mergeModelLists(accounts, user.accounts) : accounts,
		communicationLogs: (user.$assignedFields.contains('communicationLogs') && user.communicationLogs != null) ? mergeModelLists(communicationLogs, user.communicationLogs) : communicationLogs,
		favorites: (user.$assignedFields.contains('favorites') && user.favorites != null) ? mergeModelLists(favorites, user.favorites) : favorites,
		languages: (user.$assignedFields.contains('languages') && user.languages != null) ? mergeModelLists(languages, user.languages) : languages,
		offers: (user.$assignedFields.contains('offers') && user.offers != null) ? mergeModelLists(offers, user.offers) : offers,
		photos: (user.$assignedFields.contains('photos') && user.photos != null) ? mergeModelLists(photos, user.photos) : photos,
		posts: (user.$assignedFields.contains('posts') && user.posts != null) ? mergeModelLists(posts, user.posts) : posts,
		analytics: (user.$assignedFields.contains('analytics') && user.analytics != null) ? mergeModelLists(analytics, user.analytics) : analytics,
		$achievementsCount: user.$achievementsCount ?? $achievementsCount,
		$agentAssignmentsCount: user.$agentAssignmentsCount ?? $agentAssignmentsCount,
		$agentPerformanceCount: user.$agentPerformanceCount ?? $agentPerformanceCount,
		$agentTeamsCount: user.$agentTeamsCount ?? $agentTeamsCount,
		$teamMembershipsCount: user.$teamMembershipsCount ?? $teamMembershipsCount,
		$apiKeysCount: user.$apiKeysCount ?? $apiKeysCount,
		$apiTokensCount: user.$apiTokensCount ?? $apiTokensCount,
		$appointmentsCount: user.$appointmentsCount ?? $appointmentsCount,
		$auditLogsCount: user.$auditLogsCount ?? $auditLogsCount,
		$budgetsCount: user.$budgetsCount ?? $budgetsCount,
		$calendarEventsCount: user.$calendarEventsCount ?? $calendarEventsCount,
		$clientRelationshipsCount: user.$clientRelationshipsCount ?? $clientRelationshipsCount,
		$dashboardConfigurationsCount: user.$dashboardConfigurationsCount ?? $dashboardConfigurationsCount,
		$dashboardWidgetsCount: user.$dashboardWidgetsCount ?? $dashboardWidgetsCount,
		$documentsCount: user.$documentsCount ?? $documentsCount,
		$earningsCount: user.$earningsCount ?? $earningsCount,
		$eventAttendeesCount: user.$eventAttendeesCount ?? $eventAttendeesCount,
		$governmentIntegrationsCount: user.$governmentIntegrationsCount ?? $governmentIntegrationsCount,
		$leadsCount: user.$leadsCount ?? $leadsCount,
		$loyaltyAccountsCount: user.$loyaltyAccountsCount ?? $loyaltyAccountsCount,
		$workOrdersReportedCount: user.$workOrdersReportedCount ?? $workOrdersReportedCount,
		$maintenanceAssignedCount: user.$maintenanceAssignedCount ?? $maintenanceAssignedCount,
		$mobileDevicesCount: user.$mobileDevicesCount ?? $mobileDevicesCount,
		$notificationsCount: user.$notificationsCount ?? $notificationsCount,
		$offlineSyncQueuesCount: user.$offlineSyncQueuesCount ?? $offlineSyncQueuesCount,
		$managedProjectsCount: user.$managedProjectsCount ?? $managedProjectsCount,
		$propertyComplianceCount: user.$propertyComplianceCount ?? $propertyComplianceCount,
		$assignedViewingsCount: user.$assignedViewingsCount ?? $assignedViewingsCount,
		$referralsCount: user.$referralsCount ?? $referralsCount,
		$reportsCount: user.$reportsCount ?? $reportsCount,
		$sessionsCount: user.$sessionsCount ?? $sessionsCount,
		$signatureSignersCount: user.$signatureSignersCount ?? $signatureSignersCount,
		$tasksCount: user.$tasksCount ?? $tasksCount,
		$activityLogsCount: user.$activityLogsCount ?? $activityLogsCount,
		$extraChargesCount: user.$extraChargesCount ?? $extraChargesCount,
		$currenciesCount: user.$currenciesCount ?? $currenciesCount,
		$agenciesCount: user.$agenciesCount ?? $agenciesCount,
		$agencyMembershipsCount: user.$agencyMembershipsCount ?? $agencyMembershipsCount,
		$includedServicesCount: user.$includedServicesCount ?? $includedServicesCount,
		$hashtagsCount: user.$hashtagsCount ?? $hashtagsCount,
		$tenantsCount: user.$tenantsCount ?? $tenantsCount,
		$agentOwnersCount: user.$agentOwnersCount ?? $agentOwnersCount,
		$mentionsByUserCount: user.$mentionsByUserCount ?? $mentionsByUserCount,
		$mentionsToUserCount: user.$mentionsToUserCount ?? $mentionsToUserCount,
		$mentionsAsGenericCount: user.$mentionsAsGenericCount ?? $mentionsAsGenericCount,
		$propertyPromotionsCount: user.$propertyPromotionsCount ?? $propertyPromotionsCount,
		$assignedTicketsCount: user.$assignedTicketsCount ?? $assignedTicketsCount,
		$ticketsCount: user.$ticketsCount ?? $ticketsCount,
		$accountsCount: user.$accountsCount ?? $accountsCount,
		$communicationLogsCount: user.$communicationLogsCount ?? $communicationLogsCount,
		$favoritesCount: user.$favoritesCount ?? $favoritesCount,
		$languagesCount: user.$languagesCount ?? $languagesCount,
		$offersCount: user.$offersCount ?? $offersCount,
		$photosCount: user.$photosCount ?? $photosCount,
		$postsCount: user.$postsCount ?? $postsCount,
		$analyticsCount: user.$analyticsCount ?? $analyticsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    User updateWithInstanceValues(User user) {
        if (user.$assignedFields.contains('id')) { id = user.id; }
		if (user.$assignedFields.contains('email')) { email = user.email; }
		if (user.$assignedFields.contains('name')) { name = user.name; }
		if (user.$assignedFields.contains('phone')) { phone = user.phone; }
		if (user.$assignedFields.contains('locale')) { locale = user.locale; }
		if (user.$assignedFields.contains('timezone')) { timezone = user.timezone; }
		if (user.$assignedFields.contains('createdAt')) { createdAt = user.createdAt; }
		if (user.$assignedFields.contains('updatedAt')) { updatedAt = user.updatedAt; }
		if (user.$assignedFields.contains('deletedAt')) { deletedAt = user.deletedAt; }
		if (user.$assignedFields.contains('achievements') && user.achievements != null) { achievements = mergeModelLists(achievements, user.achievements); }
		if (user.$assignedFields.contains('agentAssignments') && user.agentAssignments != null) { agentAssignments = mergeModelLists(agentAssignments, user.agentAssignments); }
		if (user.$assignedFields.contains('agentPerformance') && user.agentPerformance != null) { agentPerformance = mergeModelLists(agentPerformance, user.agentPerformance); }
		if (user.$assignedFields.contains('agentTeams') && user.agentTeams != null) { agentTeams = mergeModelLists(agentTeams, user.agentTeams); }
		if (user.$assignedFields.contains('teamMemberships') && user.teamMemberships != null) { teamMemberships = mergeModelLists(teamMemberships, user.teamMemberships); }
		if (user.$assignedFields.contains('apiKeys') && user.apiKeys != null) { apiKeys = mergeModelLists(apiKeys, user.apiKeys); }
		if (user.$assignedFields.contains('apiTokens') && user.apiTokens != null) { apiTokens = mergeModelLists(apiTokens, user.apiTokens); }
		if (user.$assignedFields.contains('appointments') && user.appointments != null) { appointments = mergeModelLists(appointments, user.appointments); }
		if (user.$assignedFields.contains('auditLogs') && user.auditLogs != null) { auditLogs = mergeModelLists(auditLogs, user.auditLogs); }
		if (user.$assignedFields.contains('budgets') && user.budgets != null) { budgets = mergeModelLists(budgets, user.budgets); }
		if (user.$assignedFields.contains('calendarEvents') && user.calendarEvents != null) { calendarEvents = mergeModelLists(calendarEvents, user.calendarEvents); }
		if (user.$assignedFields.contains('clientRelationships') && user.clientRelationships != null) { clientRelationships = mergeModelLists(clientRelationships, user.clientRelationships); }
		if (user.$assignedFields.contains('dashboardConfigurations') && user.dashboardConfigurations != null) { dashboardConfigurations = mergeModelLists(dashboardConfigurations, user.dashboardConfigurations); }
		if (user.$assignedFields.contains('dashboardWidgets') && user.dashboardWidgets != null) { dashboardWidgets = mergeModelLists(dashboardWidgets, user.dashboardWidgets); }
		if (user.$assignedFields.contains('documents') && user.documents != null) { documents = mergeModelLists(documents, user.documents); }
		if (user.$assignedFields.contains('earnings') && user.earnings != null) { earnings = mergeModelLists(earnings, user.earnings); }
		if (user.$assignedFields.contains('eventAttendees') && user.eventAttendees != null) { eventAttendees = mergeModelLists(eventAttendees, user.eventAttendees); }
		if (user.$assignedFields.contains('governmentIntegrations') && user.governmentIntegrations != null) { governmentIntegrations = mergeModelLists(governmentIntegrations, user.governmentIntegrations); }
		if (user.$assignedFields.contains('investorPortfolio')) { investorPortfolio = user.investorPortfolio; }
		if (user.$assignedFields.contains('leads') && user.leads != null) { leads = mergeModelLists(leads, user.leads); }
		if (user.$assignedFields.contains('loyaltyAccounts') && user.loyaltyAccounts != null) { loyaltyAccounts = mergeModelLists(loyaltyAccounts, user.loyaltyAccounts); }
		if (user.$assignedFields.contains('workOrdersReported') && user.workOrdersReported != null) { workOrdersReported = mergeModelLists(workOrdersReported, user.workOrdersReported); }
		if (user.$assignedFields.contains('maintenanceAssigned') && user.maintenanceAssigned != null) { maintenanceAssigned = mergeModelLists(maintenanceAssigned, user.maintenanceAssigned); }
		if (user.$assignedFields.contains('mobileDevices') && user.mobileDevices != null) { mobileDevices = mergeModelLists(mobileDevices, user.mobileDevices); }
		if (user.$assignedFields.contains('notifications') && user.notifications != null) { notifications = mergeModelLists(notifications, user.notifications); }
		if (user.$assignedFields.contains('offlineSyncQueues') && user.offlineSyncQueues != null) { offlineSyncQueues = mergeModelLists(offlineSyncQueues, user.offlineSyncQueues); }
		if (user.$assignedFields.contains('managedProjects') && user.managedProjects != null) { managedProjects = mergeModelLists(managedProjects, user.managedProjects); }
		if (user.$assignedFields.contains('propertyCompliance') && user.propertyCompliance != null) { propertyCompliance = mergeModelLists(propertyCompliance, user.propertyCompliance); }
		if (user.$assignedFields.contains('assignedViewings') && user.assignedViewings != null) { assignedViewings = mergeModelLists(assignedViewings, user.assignedViewings); }
		if (user.$assignedFields.contains('referrals') && user.referrals != null) { referrals = mergeModelLists(referrals, user.referrals); }
		if (user.$assignedFields.contains('reports') && user.reports != null) { reports = mergeModelLists(reports, user.reports); }
		if (user.$assignedFields.contains('sessions') && user.sessions != null) { sessions = mergeModelLists(sessions, user.sessions); }
		if (user.$assignedFields.contains('signatureSigners') && user.signatureSigners != null) { signatureSigners = mergeModelLists(signatureSigners, user.signatureSigners); }
		if (user.$assignedFields.contains('tasks') && user.tasks != null) { tasks = mergeModelLists(tasks, user.tasks); }
		if (user.$assignedFields.contains('activityLogs') && user.activityLogs != null) { activityLogs = mergeModelLists(activityLogs, user.activityLogs); }
		if (user.$assignedFields.contains('financialProfile')) { financialProfile = user.financialProfile; }
		if (user.$assignedFields.contains('preferences')) { preferences = user.preferences; }
		if (user.$assignedFields.contains('gdprConsentAt')) { gdprConsentAt = user.gdprConsentAt; }
		if (user.$assignedFields.contains('ccpaOptOutAt')) { ccpaOptOutAt = user.ccpaOptOutAt; }
		if (user.$assignedFields.contains('dataRetentionUntil')) { dataRetentionUntil = user.dataRetentionUntil; }
		if (user.$assignedFields.contains('anonymizedAt')) { anonymizedAt = user.anonymizedAt; }
		if (user.$assignedFields.contains('extraCharges') && user.extraCharges != null) { extraCharges = mergeModelLists(extraCharges, user.extraCharges); }
		if (user.$assignedFields.contains('currencies') && user.currencies != null) { currencies = mergeModelLists(currencies, user.currencies); }
		if (user.$assignedFields.contains('agencies') && user.agencies != null) { agencies = mergeModelLists(agencies, user.agencies); }
		if (user.$assignedFields.contains('agencyMemberships') && user.agencyMemberships != null) { agencyMemberships = mergeModelLists(agencyMemberships, user.agencyMemberships); }
		if (user.$assignedFields.contains('includedServices') && user.includedServices != null) { includedServices = mergeModelLists(includedServices, user.includedServices); }
		if (user.$assignedFields.contains('hashtags') && user.hashtags != null) { hashtags = mergeModelLists(hashtags, user.hashtags); }
		if (user.$assignedFields.contains('tenants') && user.tenants != null) { tenants = mergeModelLists(tenants, user.tenants); }
		if (user.$assignedFields.contains('agentOwners') && user.agentOwners != null) { agentOwners = mergeModelLists(agentOwners, user.agentOwners); }
		if (user.$assignedFields.contains('mentionsByUser') && user.mentionsByUser != null) { mentionsByUser = mergeModelLists(mentionsByUser, user.mentionsByUser); }
		if (user.$assignedFields.contains('mentionsToUser') && user.mentionsToUser != null) { mentionsToUser = mergeModelLists(mentionsToUser, user.mentionsToUser); }
		if (user.$assignedFields.contains('mentionsAsGeneric') && user.mentionsAsGeneric != null) { mentionsAsGeneric = mergeModelLists(mentionsAsGeneric, user.mentionsAsGeneric); }
		if (user.$assignedFields.contains('propertyPromotions') && user.propertyPromotions != null) { propertyPromotions = mergeModelLists(propertyPromotions, user.propertyPromotions); }
		if (user.$assignedFields.contains('assignedTickets') && user.assignedTickets != null) { assignedTickets = mergeModelLists(assignedTickets, user.assignedTickets); }
		if (user.$assignedFields.contains('tickets') && user.tickets != null) { tickets = mergeModelLists(tickets, user.tickets); }
		if (user.$assignedFields.contains('accounts') && user.accounts != null) { accounts = mergeModelLists(accounts, user.accounts); }
		if (user.$assignedFields.contains('communicationLogs') && user.communicationLogs != null) { communicationLogs = mergeModelLists(communicationLogs, user.communicationLogs); }
		if (user.$assignedFields.contains('favorites') && user.favorites != null) { favorites = mergeModelLists(favorites, user.favorites); }
		if (user.$assignedFields.contains('languages') && user.languages != null) { languages = mergeModelLists(languages, user.languages); }
		if (user.$assignedFields.contains('offers') && user.offers != null) { offers = mergeModelLists(offers, user.offers); }
		if (user.$assignedFields.contains('photos') && user.photos != null) { photos = mergeModelLists(photos, user.photos); }
		if (user.$assignedFields.contains('posts') && user.posts != null) { posts = mergeModelLists(posts, user.posts); }
		if (user.$assignedFields.contains('analytics') && user.analytics != null) { analytics = mergeModelLists(analytics, user.analytics); }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'User'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(email != null) 'email': email,
	if(name != null) 'name': name,
	if(phone != null) 'phone': phone,
	if(locale != null) 'locale': locale,
	if(timezone != null) 'timezone': timezone,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(achievements != null && (!preventCircularSerialization || !serializedModels.contains('Achievement'))) 'achievements': achievements?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agentAssignments != null && (!preventCircularSerialization || !serializedModels.contains('AgentAssignment'))) 'agentAssignments': agentAssignments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agentPerformance != null && (!preventCircularSerialization || !serializedModels.contains('AgentPerformance'))) 'agentPerformance': agentPerformance?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agentTeams != null && (!preventCircularSerialization || !serializedModels.contains('AgentTeam'))) 'agentTeams': agentTeams?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(teamMemberships != null && (!preventCircularSerialization || !serializedModels.contains('AgentTeamMember'))) 'teamMemberships': teamMemberships?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(apiKeys != null && (!preventCircularSerialization || !serializedModels.contains('ApiKey'))) 'apiKeys': apiKeys?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(apiTokens != null && (!preventCircularSerialization || !serializedModels.contains('ApiToken'))) 'apiTokens': apiTokens?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(appointments != null && (!preventCircularSerialization || !serializedModels.contains('Appointment'))) 'appointments': appointments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(auditLogs != null && (!preventCircularSerialization || !serializedModels.contains('AuditLog'))) 'auditLogs': auditLogs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(budgets != null && (!preventCircularSerialization || !serializedModels.contains('Budget'))) 'budgets': budgets?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(calendarEvents != null && (!preventCircularSerialization || !serializedModels.contains('CalendarEvent'))) 'calendarEvents': calendarEvents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(clientRelationships != null && (!preventCircularSerialization || !serializedModels.contains('ClientRelationship'))) 'clientRelationships': clientRelationships?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(dashboardConfigurations != null && (!preventCircularSerialization || !serializedModels.contains('DashboardConfiguration'))) 'dashboardConfigurations': dashboardConfigurations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(dashboardWidgets != null && (!preventCircularSerialization || !serializedModels.contains('DashboardWidget'))) 'dashboardWidgets': dashboardWidgets?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(documents != null && (!preventCircularSerialization || !serializedModels.contains('Document'))) 'documents': documents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(earnings != null && (!preventCircularSerialization || !serializedModels.contains('Earning'))) 'earnings': earnings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(eventAttendees != null && (!preventCircularSerialization || !serializedModels.contains('EventAttendee'))) 'eventAttendees': eventAttendees?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(governmentIntegrations != null && (!preventCircularSerialization || !serializedModels.contains('GovernmentIntegration'))) 'governmentIntegrations': governmentIntegrations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(investorPortfolio != null && (!preventCircularSerialization || !serializedModels.contains('InvestorPortfolio'))) 'investorPortfolio': investorPortfolio?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(leads != null && (!preventCircularSerialization || !serializedModels.contains('Lead'))) 'leads': leads?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(loyaltyAccounts != null && (!preventCircularSerialization || !serializedModels.contains('LoyaltyAccount'))) 'loyaltyAccounts': loyaltyAccounts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(workOrdersReported != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceWorkOrder'))) 'workOrdersReported': workOrdersReported?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(maintenanceAssigned != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceWorkOrder'))) 'maintenanceAssigned': maintenanceAssigned?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mobileDevices != null && (!preventCircularSerialization || !serializedModels.contains('MobileDevice'))) 'mobileDevices': mobileDevices?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(notifications != null && (!preventCircularSerialization || !serializedModels.contains('Notification'))) 'notifications': notifications?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(offlineSyncQueues != null && (!preventCircularSerialization || !serializedModels.contains('OfflineSyncQueue'))) 'offlineSyncQueues': offlineSyncQueues?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(managedProjects != null && (!preventCircularSerialization || !serializedModels.contains('Project'))) 'managedProjects': managedProjects?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyCompliance != null && (!preventCircularSerialization || !serializedModels.contains('PropertyCompliance'))) 'propertyCompliance': propertyCompliance?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(assignedViewings != null && (!preventCircularSerialization || !serializedModels.contains('PropertyViewing'))) 'assignedViewings': assignedViewings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(referrals != null && (!preventCircularSerialization || !serializedModels.contains('Referral'))) 'referrals': referrals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reports != null && (!preventCircularSerialization || !serializedModels.contains('Report'))) 'reports': reports?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(sessions != null && (!preventCircularSerialization || !serializedModels.contains('Session'))) 'sessions': sessions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(signatureSigners != null && (!preventCircularSerialization || !serializedModels.contains('SignatureSigner'))) 'signatureSigners': signatureSigners?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(activityLogs != null && (!preventCircularSerialization || !serializedModels.contains('UserActivityLog'))) 'activityLogs': activityLogs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(financialProfile != null && (!preventCircularSerialization || !serializedModels.contains('UserFinancialProfile'))) 'financialProfile': financialProfile?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(preferences != null && (!preventCircularSerialization || !serializedModels.contains('UserPreference'))) 'preferences': preferences?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(gdprConsentAt != null) 'gdprConsentAt': gdprConsentAt?.toIso8601String(),
	if(ccpaOptOutAt != null) 'ccpaOptOutAt': ccpaOptOutAt?.toIso8601String(),
	if(dataRetentionUntil != null) 'dataRetentionUntil': dataRetentionUntil?.toIso8601String(),
	if(anonymizedAt != null) 'anonymizedAt': anonymizedAt?.toIso8601String(),
	if(extraCharges != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'extraCharges': extraCharges?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(currencies != null && (!preventCircularSerialization || !serializedModels.contains('Currency'))) 'currencies': currencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencyMemberships != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencyMemberships': agencyMemberships?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(includedServices != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'includedServices': includedServices?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(hashtags != null && (!preventCircularSerialization || !serializedModels.contains('Hashtag'))) 'hashtags': hashtags?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenants != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'tenants': tenants?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agentOwners != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agentOwners': agentOwners?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mentionsByUser != null && (!preventCircularSerialization || !serializedModels.contains('Mention'))) 'mentionsByUser': mentionsByUser?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mentionsToUser != null && (!preventCircularSerialization || !serializedModels.contains('Mention'))) 'mentionsToUser': mentionsToUser?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mentionsAsGeneric != null && (!preventCircularSerialization || !serializedModels.contains('Mention'))) 'mentionsAsGeneric': mentionsAsGeneric?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyPromotions != null && (!preventCircularSerialization || !serializedModels.contains('PropertyPromotion'))) 'propertyPromotions': propertyPromotions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(assignedTickets != null && (!preventCircularSerialization || !serializedModels.contains('Ticket'))) 'assignedTickets': assignedTickets?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tickets != null && (!preventCircularSerialization || !serializedModels.contains('Ticket'))) 'tickets': tickets?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(accounts != null && (!preventCircularSerialization || !serializedModels.contains('Account'))) 'accounts': accounts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(communicationLogs != null && (!preventCircularSerialization || !serializedModels.contains('CommunicationLog'))) 'communicationLogs': communicationLogs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(favorites != null && (!preventCircularSerialization || !serializedModels.contains('Favorite'))) 'favorites': favorites?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(languages != null && (!preventCircularSerialization || !serializedModels.contains('Language'))) 'languages': languages?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(offers != null && (!preventCircularSerialization || !serializedModels.contains('Offer'))) 'offers': offers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(photos != null && (!preventCircularSerialization || !serializedModels.contains('Photo'))) 'photos': photos?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(posts != null && (!preventCircularSerialization || !serializedModels.contains('Post'))) 'posts': posts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(analytics != null && (!preventCircularSerialization || !serializedModels.contains('Analytics'))) 'analytics': analytics?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($achievementsCount != null || $agentAssignmentsCount != null || $agentPerformanceCount != null || $agentTeamsCount != null || $teamMembershipsCount != null || $apiKeysCount != null || $apiTokensCount != null || $appointmentsCount != null || $auditLogsCount != null || $budgetsCount != null || $calendarEventsCount != null || $clientRelationshipsCount != null || $dashboardConfigurationsCount != null || $dashboardWidgetsCount != null || $documentsCount != null || $earningsCount != null || $eventAttendeesCount != null || $governmentIntegrationsCount != null || $leadsCount != null || $loyaltyAccountsCount != null || $workOrdersReportedCount != null || $maintenanceAssignedCount != null || $mobileDevicesCount != null || $notificationsCount != null || $offlineSyncQueuesCount != null || $managedProjectsCount != null || $propertyComplianceCount != null || $assignedViewingsCount != null || $referralsCount != null || $reportsCount != null || $sessionsCount != null || $signatureSignersCount != null || $tasksCount != null || $activityLogsCount != null || $extraChargesCount != null || $currenciesCount != null || $agenciesCount != null || $agencyMembershipsCount != null || $includedServicesCount != null || $hashtagsCount != null || $tenantsCount != null || $agentOwnersCount != null || $mentionsByUserCount != null || $mentionsToUserCount != null || $mentionsAsGenericCount != null || $propertyPromotionsCount != null || $assignedTicketsCount != null || $ticketsCount != null || $accountsCount != null || $communicationLogsCount != null || $favoritesCount != null || $languagesCount != null || $offersCount != null || $photosCount != null || $postsCount != null || $analyticsCount != null) '_count': { 
		if ($achievementsCount != null) 'achievements': $achievementsCount, 
		if ($agentAssignmentsCount != null) 'agentAssignments': $agentAssignmentsCount, 
		if ($agentPerformanceCount != null) 'agentPerformance': $agentPerformanceCount, 
		if ($agentTeamsCount != null) 'agentTeams': $agentTeamsCount, 
		if ($teamMembershipsCount != null) 'teamMemberships': $teamMembershipsCount, 
		if ($apiKeysCount != null) 'apiKeys': $apiKeysCount, 
		if ($apiTokensCount != null) 'apiTokens': $apiTokensCount, 
		if ($appointmentsCount != null) 'appointments': $appointmentsCount, 
		if ($auditLogsCount != null) 'auditLogs': $auditLogsCount, 
		if ($budgetsCount != null) 'budgets': $budgetsCount, 
		if ($calendarEventsCount != null) 'calendarEvents': $calendarEventsCount, 
		if ($clientRelationshipsCount != null) 'clientRelationships': $clientRelationshipsCount, 
		if ($dashboardConfigurationsCount != null) 'dashboardConfigurations': $dashboardConfigurationsCount, 
		if ($dashboardWidgetsCount != null) 'dashboardWidgets': $dashboardWidgetsCount, 
		if ($documentsCount != null) 'documents': $documentsCount, 
		if ($earningsCount != null) 'earnings': $earningsCount, 
		if ($eventAttendeesCount != null) 'eventAttendees': $eventAttendeesCount, 
		if ($governmentIntegrationsCount != null) 'governmentIntegrations': $governmentIntegrationsCount, 
		if ($leadsCount != null) 'leads': $leadsCount, 
		if ($loyaltyAccountsCount != null) 'loyaltyAccounts': $loyaltyAccountsCount, 
		if ($workOrdersReportedCount != null) 'workOrdersReported': $workOrdersReportedCount, 
		if ($maintenanceAssignedCount != null) 'maintenanceAssigned': $maintenanceAssignedCount, 
		if ($mobileDevicesCount != null) 'mobileDevices': $mobileDevicesCount, 
		if ($notificationsCount != null) 'notifications': $notificationsCount, 
		if ($offlineSyncQueuesCount != null) 'offlineSyncQueues': $offlineSyncQueuesCount, 
		if ($managedProjectsCount != null) 'managedProjects': $managedProjectsCount, 
		if ($propertyComplianceCount != null) 'propertyCompliance': $propertyComplianceCount, 
		if ($assignedViewingsCount != null) 'assignedViewings': $assignedViewingsCount, 
		if ($referralsCount != null) 'referrals': $referralsCount, 
		if ($reportsCount != null) 'reports': $reportsCount, 
		if ($sessionsCount != null) 'sessions': $sessionsCount, 
		if ($signatureSignersCount != null) 'signatureSigners': $signatureSignersCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($activityLogsCount != null) 'activityLogs': $activityLogsCount, 
		if ($extraChargesCount != null) 'extraCharges': $extraChargesCount, 
		if ($currenciesCount != null) 'currencies': $currenciesCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($agencyMembershipsCount != null) 'agencyMemberships': $agencyMembershipsCount, 
		if ($includedServicesCount != null) 'includedServices': $includedServicesCount, 
		if ($hashtagsCount != null) 'hashtags': $hashtagsCount, 
		if ($tenantsCount != null) 'tenants': $tenantsCount, 
		if ($agentOwnersCount != null) 'agentOwners': $agentOwnersCount, 
		if ($mentionsByUserCount != null) 'mentionsByUser': $mentionsByUserCount, 
		if ($mentionsToUserCount != null) 'mentionsToUser': $mentionsToUserCount, 
		if ($mentionsAsGenericCount != null) 'mentionsAsGeneric': $mentionsAsGenericCount, 
		if ($propertyPromotionsCount != null) 'propertyPromotions': $propertyPromotionsCount, 
		if ($assignedTicketsCount != null) 'assignedTickets': $assignedTicketsCount, 
		if ($ticketsCount != null) 'tickets': $ticketsCount, 
		if ($accountsCount != null) 'accounts': $accountsCount, 
		if ($communicationLogsCount != null) 'communicationLogs': $communicationLogsCount, 
		if ($favoritesCount != null) 'favorites': $favoritesCount, 
		if ($languagesCount != null) 'languages': $languagesCount, 
		if ($offersCount != null) 'offers': $offersCount, 
		if ($photosCount != null) 'photos': $photosCount, 
		if ($postsCount != null) 'posts': $postsCount, 
		if ($analyticsCount != null) 'analytics': $analyticsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is User &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    