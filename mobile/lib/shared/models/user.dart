import 'account.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'achievement.dart';
import 'agency.dart';
import 'agent.dart';
import 'agent_assignment.dart';
import 'agent_performance.dart';
import 'agent_team.dart';
import 'agent_team_member.dart';
import 'analytics.dart';
import 'api_key.dart';
import 'api_token.dart';
import 'appointment.dart';
import 'audit_log.dart';
import 'budget.dart';
import 'calendar_event.dart';
import 'client_relationship.dart';
import 'communication_log.dart';
import 'currency.dart';
import 'dashboard_configuration.dart';
import 'dashboard_widget.dart';
import 'document.dart';
import 'earning.dart';
import 'event_attendee.dart';
import 'extra_charge.dart';
import 'favorite.dart';
import 'government_integration.dart';
import 'hashtag.dart';
import 'included_service.dart';
import 'investor_portfolio.dart';
import 'language.dart';
import 'lead.dart';
import 'loyalty_account.dart';
import 'maintenance_work_order.dart';
import 'mention.dart';
import 'mobile_device.dart';
import 'notification.dart';
import 'offer.dart';
import 'offline_sync_queue.dart';
import 'photo.dart';
import 'post.dart';
import 'project.dart';
import 'property_compliance.dart';
import 'property_promotion.dart';
import 'property_viewing.dart';
import 'referral.dart';
import 'report.dart';
import 'session.dart';
import 'signature_signer.dart';
import 'task.dart';
import 'tenant.dart';
import 'ticket.dart';
import 'user_activity_log.dart';
import 'user_financial_profile.dart';
import 'user_preference.dart';

class User {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String locale;
  final String timezone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Achievement> achievements;
  final List<AgentAssignment> agentAssignments;
  final List<AgentPerformance> agentPerformance;
  final List<AgentTeam> agentTeams;
  final List<AgentTeamMember> teamMemberships;
  final List<ApiKey> apiKeys;
  final List<ApiToken> apiTokens;
  final List<Appointment> appointments;
  final List<AuditLog> auditLogs;
  final List<Budget> budgets;
  final List<CalendarEvent> calendarEvents;
  final List<ClientRelationship> clientRelationships;
  final List<DashboardConfiguration> dashboardConfigurations;
  final List<DashboardWidget> dashboardWidgets;
  final List<Document> documents;
  final List<Earning> earnings;
  final List<EventAttendee> eventAttendees;
  final List<GovernmentIntegration> governmentIntegrations;
  final InvestorPortfolio? investorPortfolio;
  final List<Lead> leads;
  final List<LoyaltyAccount> loyaltyAccounts;
  final List<MaintenanceWorkOrder> workOrdersReported;
  final List<MaintenanceWorkOrder> maintenanceAssigned;
  final List<MobileDevice> mobileDevices;
  final List<Notification> notifications;
  final List<OfflineSyncQueue> offlineSyncQueues;
  final List<Project> managedProjects;
  final List<PropertyCompliance> propertyCompliance;
  final List<PropertyViewing> assignedViewings;
  final List<Referral> referrals;
  final List<Report> reports;
  final List<Session> sessions;
  final List<SignatureSigner> signatureSigners;
  final List<Task> tasks;
  final List<UserActivityLog> activityLogs;
  final UserFinancialProfile? financialProfile;
  final UserPreference? preferences;
  final DateTime? gdprConsentAt;
  final DateTime? ccpaOptOutAt;
  final DateTime? dataRetentionUntil;
  final DateTime? anonymizedAt;
  final List<ExtraCharge> extraCharges;
  final List<Currency> currencies;
  final List<Agency> agencies;
  final List<Agency> agencyMemberships;
  final List<IncludedService> includedServices;
  final List<Hashtag> hashtags;
  final List<Tenant> tenants;
  final List<Agent> agentOwners;
  final List<Mention> mentionsByUser;
  final List<Mention> mentionsToUser;
  final List<Mention> mentionsAsGeneric;
  final List<PropertyPromotion> propertyPromotions;
  final List<Ticket> assignedTickets;
  final List<Ticket> tickets;
  final List<Account> accounts;
  final List<CommunicationLog> communicationLogs;
  final List<Favorite> favorites;
  final List<Language> languages;
  final List<Offer> offers;
  final List<Photo> photos;
  final List<Post> posts;
  final List<Analytics> analytics;
  final String? role;
  final List<String> permissions;
  final String? organizationId;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    required this.locale,
    required this.timezone,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.achievements = const [],
    this.agentAssignments = const [],
    this.agentPerformance = const [],
    this.agentTeams = const [],
    this.teamMemberships = const [],
    this.apiKeys = const [],
    this.apiTokens = const [],
    this.appointments = const [],
    this.auditLogs = const [],
    this.budgets = const [],
    this.calendarEvents = const [],
    this.clientRelationships = const [],
    this.dashboardConfigurations = const [],
    this.dashboardWidgets = const [],
    this.documents = const [],
    this.earnings = const [],
    this.eventAttendees = const [],
    this.governmentIntegrations = const [],
    this.investorPortfolio,
    this.leads = const [],
    this.loyaltyAccounts = const [],
    this.workOrdersReported = const [],
    this.maintenanceAssigned = const [],
    this.mobileDevices = const [],
    this.notifications = const [],
    this.offlineSyncQueues = const [],
    this.managedProjects = const [],
    this.propertyCompliance = const [],
    this.assignedViewings = const [],
    this.referrals = const [],
    this.reports = const [],
    this.sessions = const [],
    this.signatureSigners = const [],
    this.tasks = const [],
    this.activityLogs = const [],
    this.financialProfile,
    this.preferences,
    this.gdprConsentAt,
    this.ccpaOptOutAt,
    this.dataRetentionUntil,
    this.anonymizedAt,
    this.extraCharges = const [],
    this.currencies = const [],
    this.agencies = const [],
    this.agencyMemberships = const [],
    this.includedServices = const [],
    this.hashtags = const [],
    this.tenants = const [],
    this.agentOwners = const [],
    this.mentionsByUser = const [],
    this.mentionsToUser = const [],
    this.mentionsAsGeneric = const [],
    this.propertyPromotions = const [],
    this.assignedTickets = const [],
    this.tickets = const [],
    this.accounts = const [],
    this.communicationLogs = const [],
    this.favorites = const [],
    this.languages = const [],
    this.offers = const [],
    this.photos = const [],
    this.posts = const [],
    this.analytics = const [],
    this.role,
    this.permissions = const [],
    this.organizationId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      locale: (json['locale'] as String?) ?? 'en-US',
      timezone: (json['timezone'] as String?) ?? 'mobile.leftovers.america_new_york'.tr(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : DateTime.now(),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      achievements: (json['achievements'] as List<dynamic>?)?.map((e) => Achievement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agentAssignments: (json['agentAssignments'] as List<dynamic>?)?.map((e) => AgentAssignment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agentPerformance: (json['agentPerformance'] as List<dynamic>?)?.map((e) => AgentPerformance.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agentTeams: (json['agentTeams'] as List<dynamic>?)?.map((e) => AgentTeam.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      teamMemberships: (json['teamMemberships'] as List<dynamic>?)?.map((e) => AgentTeamMember.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      apiKeys: (json['apiKeys'] as List<dynamic>?)?.map((e) => ApiKey.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      apiTokens: (json['apiTokens'] as List<dynamic>?)?.map((e) => ApiToken.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      appointments: (json['appointments'] as List<dynamic>?)?.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      auditLogs: (json['auditLogs'] as List<dynamic>?)?.map((e) => AuditLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      budgets: (json['budgets'] as List<dynamic>?)?.map((e) => Budget.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      calendarEvents: (json['calendarEvents'] as List<dynamic>?)?.map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      clientRelationships: (json['clientRelationships'] as List<dynamic>?)?.map((e) => ClientRelationship.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      dashboardConfigurations: (json['dashboardConfigurations'] as List<dynamic>?)?.map((e) => DashboardConfiguration.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      dashboardWidgets: (json['dashboardWidgets'] as List<dynamic>?)?.map((e) => DashboardWidget.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      documents: (json['documents'] as List<dynamic>?)?.map((e) => Document.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      earnings: (json['earnings'] as List<dynamic>?)?.map((e) => Earning.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      eventAttendees: (json['eventAttendees'] as List<dynamic>?)?.map((e) => EventAttendee.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      governmentIntegrations: (json['governmentIntegrations'] as List<dynamic>?)?.map((e) => GovernmentIntegration.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      investorPortfolio: json['investorPortfolio'] != null ? InvestorPortfolio.fromJson(json['investorPortfolio'] as Map<String, dynamic>) : null,
      leads: (json['leads'] as List<dynamic>?)?.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      loyaltyAccounts: (json['loyaltyAccounts'] as List<dynamic>?)?.map((e) => LoyaltyAccount.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      workOrdersReported: (json['workOrdersReported'] as List<dynamic>?)?.map((e) => MaintenanceWorkOrder.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      maintenanceAssigned: (json['maintenanceAssigned'] as List<dynamic>?)?.map((e) => MaintenanceWorkOrder.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mobileDevices: (json['mobileDevices'] as List<dynamic>?)?.map((e) => MobileDevice.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      notifications: (json['notifications'] as List<dynamic>?)?.map((e) => Notification.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      offlineSyncQueues: (json['offlineSyncQueues'] as List<dynamic>?)?.map((e) => OfflineSyncQueue.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      managedProjects: (json['managedProjects'] as List<dynamic>?)?.map((e) => Project.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyCompliance: (json['propertyCompliance'] as List<dynamic>?)?.map((e) => PropertyCompliance.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      assignedViewings: (json['assignedViewings'] as List<dynamic>?)?.map((e) => PropertyViewing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      referrals: (json['referrals'] as List<dynamic>?)?.map((e) => Referral.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reports: (json['reports'] as List<dynamic>?)?.map((e) => Report.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      sessions: (json['sessions'] as List<dynamic>?)?.map((e) => Session.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      signatureSigners: (json['signatureSigners'] as List<dynamic>?)?.map((e) => SignatureSigner.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      activityLogs: (json['activityLogs'] as List<dynamic>?)?.map((e) => UserActivityLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      financialProfile: json['financialProfile'] != null ? UserFinancialProfile.fromJson(json['financialProfile'] as Map<String, dynamic>) : null,
      preferences: json['preferences'] != null ? UserPreference.fromJson(json['preferences'] as Map<String, dynamic>) : null,
      gdprConsentAt: json['gdprConsentAt'] != null ? DateTime.parse(json['gdprConsentAt'] as String) : null,
      ccpaOptOutAt: json['ccpaOptOutAt'] != null ? DateTime.parse(json['ccpaOptOutAt'] as String) : null,
      dataRetentionUntil: json['dataRetentionUntil'] != null ? DateTime.parse(json['dataRetentionUntil'] as String) : null,
      anonymizedAt: json['anonymizedAt'] != null ? DateTime.parse(json['anonymizedAt'] as String) : null,
      extraCharges: (json['extraCharges'] as List<dynamic>?)?.map((e) => ExtraCharge.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      currencies: (json['currencies'] as List<dynamic>?)?.map((e) => Currency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencyMemberships: (json['agencyMemberships'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      includedServices: (json['includedServices'] as List<dynamic>?)?.map((e) => IncludedService.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      hashtags: (json['hashtags'] as List<dynamic>?)?.map((e) => Hashtag.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenants: (json['tenants'] as List<dynamic>?)?.map((e) => Tenant.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agentOwners: (json['agentOwners'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mentionsByUser: (json['mentionsByUser'] as List<dynamic>?)?.map((e) => Mention.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mentionsToUser: (json['mentionsToUser'] as List<dynamic>?)?.map((e) => Mention.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mentionsAsGeneric: (json['mentionsAsGeneric'] as List<dynamic>?)?.map((e) => Mention.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyPromotions: (json['propertyPromotions'] as List<dynamic>?)?.map((e) => PropertyPromotion.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      assignedTickets: (json['assignedTickets'] as List<dynamic>?)?.map((e) => Ticket.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tickets: (json['tickets'] as List<dynamic>?)?.map((e) => Ticket.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      accounts: (json['accounts'] as List<dynamic>?)?.map((e) => Account.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      communicationLogs: (json['communicationLogs'] as List<dynamic>?)?.map((e) => CommunicationLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      favorites: (json['favorites'] as List<dynamic>?)?.map((e) => Favorite.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      languages: (json['languages'] as List<dynamic>?)?.map((e) => Language.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      offers: (json['offers'] as List<dynamic>?)?.map((e) => Offer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      photos: (json['photos'] as List<dynamic>?)?.map((e) => Photo.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      posts: (json['posts'] as List<dynamic>?)?.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      analytics: (json['analytics'] as List<dynamic>?)?.map((e) => Analytics.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      role: json['role'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      organizationId: json['organizationId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'locale': locale,
      'timezone': timezone,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'achievements': achievements.map((e) => e.toJson()).toList(),
      'agentAssignments': agentAssignments.map((e) => e.toJson()).toList(),
      'agentPerformance': agentPerformance.map((e) => e.toJson()).toList(),
      'agentTeams': agentTeams.map((e) => e.toJson()).toList(),
      'teamMemberships': teamMemberships.map((e) => e.toJson()).toList(),
      'apiKeys': apiKeys.map((e) => e.toJson()).toList(),
      'apiTokens': apiTokens.map((e) => e.toJson()).toList(),
      'appointments': appointments.map((e) => e.toJson()).toList(),
      'auditLogs': auditLogs.map((e) => e.toJson()).toList(),
      'budgets': budgets.map((e) => e.toJson()).toList(),
      'calendarEvents': calendarEvents.map((e) => e.toJson()).toList(),
      'clientRelationships': clientRelationships.map((e) => e.toJson()).toList(),
      'dashboardConfigurations': dashboardConfigurations.map((e) => e.toJson()).toList(),
      'dashboardWidgets': dashboardWidgets.map((e) => e.toJson()).toList(),
      'documents': documents.map((e) => e.toJson()).toList(),
      'earnings': earnings.map((e) => e.toJson()).toList(),
      'eventAttendees': eventAttendees.map((e) => e.toJson()).toList(),
      'governmentIntegrations': governmentIntegrations.map((e) => e.toJson()).toList(),
      'investorPortfolio': investorPortfolio?.toJson(),
      'leads': leads.map((e) => e.toJson()).toList(),
      'loyaltyAccounts': loyaltyAccounts.map((e) => e.toJson()).toList(),
      'workOrdersReported': workOrdersReported.map((e) => e.toJson()).toList(),
      'maintenanceAssigned': maintenanceAssigned.map((e) => e.toJson()).toList(),
      'mobileDevices': mobileDevices.map((e) => e.toJson()).toList(),
      'notifications': notifications.map((e) => e.toJson()).toList(),
      'offlineSyncQueues': offlineSyncQueues.map((e) => e.toJson()).toList(),
      'managedProjects': managedProjects.map((e) => e.toJson()).toList(),
      'propertyCompliance': propertyCompliance.map((e) => e.toJson()).toList(),
      'assignedViewings': assignedViewings.map((e) => e.toJson()).toList(),
      'referrals': referrals.map((e) => e.toJson()).toList(),
      'reports': reports.map((e) => e.toJson()).toList(),
      'sessions': sessions.map((e) => e.toJson()).toList(),
      'signatureSigners': signatureSigners.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'activityLogs': activityLogs.map((e) => e.toJson()).toList(),
      'financialProfile': financialProfile?.toJson(),
      'preferences': preferences?.toJson(),
      'gdprConsentAt': gdprConsentAt?.toIso8601String(),
      'ccpaOptOutAt': ccpaOptOutAt?.toIso8601String(),
      'dataRetentionUntil': dataRetentionUntil?.toIso8601String(),
      'anonymizedAt': anonymizedAt?.toIso8601String(),
      'extraCharges': extraCharges.map((e) => e.toJson()).toList(),
      'currencies': currencies.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'agencyMemberships': agencyMemberships.map((e) => e.toJson()).toList(),
      'includedServices': includedServices.map((e) => e.toJson()).toList(),
      'hashtags': hashtags.map((e) => e.toJson()).toList(),
      'tenants': tenants.map((e) => e.toJson()).toList(),
      'agentOwners': agentOwners.map((e) => e.toJson()).toList(),
      'mentionsByUser': mentionsByUser.map((e) => e.toJson()).toList(),
      'mentionsToUser': mentionsToUser.map((e) => e.toJson()).toList(),
      'mentionsAsGeneric': mentionsAsGeneric.map((e) => e.toJson()).toList(),
      'propertyPromotions': propertyPromotions.map((e) => e.toJson()).toList(),
      'assignedTickets': assignedTickets.map((e) => e.toJson()).toList(),
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'accounts': accounts.map((e) => e.toJson()).toList(),
      'communicationLogs': communicationLogs.map((e) => e.toJson()).toList(),
      'favorites': favorites.map((e) => e.toJson()).toList(),
      'languages': languages.map((e) => e.toJson()).toList(),
      'offers': offers.map((e) => e.toJson()).toList(),
      'photos': photos.map((e) => e.toJson()).toList(),
      'posts': posts.map((e) => e.toJson()).toList(),
      'analytics': analytics.map((e) => e.toJson()).toList(),
      'role': role,
      'permissions': permissions,
      'organizationId': organizationId,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? locale,
    String? timezone,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Achievement>? achievements,
    List<AgentAssignment>? agentAssignments,
    List<AgentPerformance>? agentPerformance,
    List<AgentTeam>? agentTeams,
    List<AgentTeamMember>? teamMemberships,
    List<ApiKey>? apiKeys,
    List<ApiToken>? apiTokens,
    List<Appointment>? appointments,
    List<AuditLog>? auditLogs,
    List<Budget>? budgets,
    List<CalendarEvent>? calendarEvents,
    List<ClientRelationship>? clientRelationships,
    List<DashboardConfiguration>? dashboardConfigurations,
    List<DashboardWidget>? dashboardWidgets,
    List<Document>? documents,
    List<Earning>? earnings,
    List<EventAttendee>? eventAttendees,
    List<GovernmentIntegration>? governmentIntegrations,
    InvestorPortfolio? investorPortfolio,
    List<Lead>? leads,
    List<LoyaltyAccount>? loyaltyAccounts,
    List<MaintenanceWorkOrder>? workOrdersReported,
    List<MaintenanceWorkOrder>? maintenanceAssigned,
    List<MobileDevice>? mobileDevices,
    List<Notification>? notifications,
    List<OfflineSyncQueue>? offlineSyncQueues,
    List<Project>? managedProjects,
    List<PropertyCompliance>? propertyCompliance,
    List<PropertyViewing>? assignedViewings,
    List<Referral>? referrals,
    List<Report>? reports,
    List<Session>? sessions,
    List<SignatureSigner>? signatureSigners,
    List<Task>? tasks,
    List<UserActivityLog>? activityLogs,
    UserFinancialProfile? financialProfile,
    UserPreference? preferences,
    DateTime? gdprConsentAt,
    DateTime? ccpaOptOutAt,
    DateTime? dataRetentionUntil,
    DateTime? anonymizedAt,
    List<ExtraCharge>? extraCharges,
    List<Currency>? currencies,
    List<Agency>? agencies,
    List<Agency>? agencyMemberships,
    List<IncludedService>? includedServices,
    List<Hashtag>? hashtags,
    List<Tenant>? tenants,
    List<Agent>? agentOwners,
    List<Mention>? mentionsByUser,
    List<Mention>? mentionsToUser,
    List<Mention>? mentionsAsGeneric,
    List<PropertyPromotion>? propertyPromotions,
    List<Ticket>? assignedTickets,
    List<Ticket>? tickets,
    List<Account>? accounts,
    List<CommunicationLog>? communicationLogs,
    List<Favorite>? favorites,
    List<Language>? languages,
    List<Offer>? offers,
    List<Photo>? photos,
    List<Post>? posts,
    List<Analytics>? analytics,
    String? role,
    List<String>? permissions,
    String? organizationId,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      locale: locale ?? this.locale,
      timezone: timezone ?? this.timezone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      achievements: achievements ?? this.achievements,
      agentAssignments: agentAssignments ?? this.agentAssignments,
      agentPerformance: agentPerformance ?? this.agentPerformance,
      agentTeams: agentTeams ?? this.agentTeams,
      teamMemberships: teamMemberships ?? this.teamMemberships,
      apiKeys: apiKeys ?? this.apiKeys,
      apiTokens: apiTokens ?? this.apiTokens,
      appointments: appointments ?? this.appointments,
      auditLogs: auditLogs ?? this.auditLogs,
      budgets: budgets ?? this.budgets,
      calendarEvents: calendarEvents ?? this.calendarEvents,
      clientRelationships: clientRelationships ?? this.clientRelationships,
      dashboardConfigurations: dashboardConfigurations ?? this.dashboardConfigurations,
      dashboardWidgets: dashboardWidgets ?? this.dashboardWidgets,
      documents: documents ?? this.documents,
      earnings: earnings ?? this.earnings,
      eventAttendees: eventAttendees ?? this.eventAttendees,
      governmentIntegrations: governmentIntegrations ?? this.governmentIntegrations,
      investorPortfolio: investorPortfolio ?? this.investorPortfolio,
      leads: leads ?? this.leads,
      loyaltyAccounts: loyaltyAccounts ?? this.loyaltyAccounts,
      workOrdersReported: workOrdersReported ?? this.workOrdersReported,
      maintenanceAssigned: maintenanceAssigned ?? this.maintenanceAssigned,
      mobileDevices: mobileDevices ?? this.mobileDevices,
      notifications: notifications ?? this.notifications,
      offlineSyncQueues: offlineSyncQueues ?? this.offlineSyncQueues,
      managedProjects: managedProjects ?? this.managedProjects,
      propertyCompliance: propertyCompliance ?? this.propertyCompliance,
      assignedViewings: assignedViewings ?? this.assignedViewings,
      referrals: referrals ?? this.referrals,
      reports: reports ?? this.reports,
      sessions: sessions ?? this.sessions,
      signatureSigners: signatureSigners ?? this.signatureSigners,
      tasks: tasks ?? this.tasks,
      activityLogs: activityLogs ?? this.activityLogs,
      financialProfile: financialProfile ?? this.financialProfile,
      preferences: preferences ?? this.preferences,
      gdprConsentAt: gdprConsentAt ?? this.gdprConsentAt,
      ccpaOptOutAt: ccpaOptOutAt ?? this.ccpaOptOutAt,
      dataRetentionUntil: dataRetentionUntil ?? this.dataRetentionUntil,
      anonymizedAt: anonymizedAt ?? this.anonymizedAt,
      extraCharges: extraCharges ?? this.extraCharges,
      currencies: currencies ?? this.currencies,
      agencies: agencies ?? this.agencies,
      agencyMemberships: agencyMemberships ?? this.agencyMemberships,
      includedServices: includedServices ?? this.includedServices,
      hashtags: hashtags ?? this.hashtags,
      tenants: tenants ?? this.tenants,
      agentOwners: agentOwners ?? this.agentOwners,
      mentionsByUser: mentionsByUser ?? this.mentionsByUser,
      mentionsToUser: mentionsToUser ?? this.mentionsToUser,
      mentionsAsGeneric: mentionsAsGeneric ?? this.mentionsAsGeneric,
      propertyPromotions: propertyPromotions ?? this.propertyPromotions,
      assignedTickets: assignedTickets ?? this.assignedTickets,
      tickets: tickets ?? this.tickets,
      accounts: accounts ?? this.accounts,
      communicationLogs: communicationLogs ?? this.communicationLogs,
      favorites: favorites ?? this.favorites,
      languages: languages ?? this.languages,
      offers: offers ?? this.offers,
      photos: photos ?? this.photos,
      posts: posts ?? this.posts,
      analytics: analytics ?? this.analytics,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}
