import 'package:reservatior/shared/enums/notification_status.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/enums/org_type.dart';
import 'package:reservatior/shared/enums/region.dart';
import 'agency.dart';
import 'agent.dart';
import 'organization.dart';
import 'tenant.dart';
import 'user.dart';

class Notification {
  final String id;
  final String orgId;
  final String? userId;
  final String title;
  final String body;
  final dynamic data;
  final NotificationStatus status;
  final DateTime? sentAt;
  final DateTime? readAt;
  final dynamic userPreferences;
  final dynamic deliveries;
  final String? ruleKey;
  final dynamic ruleConfig;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final User? user;
  final List<Agent> agents;
  final List<Agency> agencies;
  final List<Tenant> tenants;

  const Notification({
    required this.id,
    required this.orgId,
    this.userId,
    required this.title,
    required this.body,
    this.data,
    required this.status,
    this.sentAt,
    this.readAt,
    this.userPreferences,
    this.deliveries,
    this.ruleKey,
    this.ruleConfig,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.user,
    this.agents = const [],
    this.agencies = const [],
    this.tenants = const [],
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      data: json['data'],
      status: NotificationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => NotificationStatus.QUEUED,
      ),
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt'] as String) : null,
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt'] as String) : null,
      userPreferences: json['userPreferences'],
      deliveries: json['deliveries'],
      ruleKey: json['ruleKey'] as String?,
      ruleConfig: json['ruleConfig'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : 
            Organization(
              id: json['orgId'], 
              name: 'mobile.leftovers.unknown_org'.tr(), 
              type: OrgType.AGENCY,
              region: Region.USA_NORTHEAST,
              defaultCurrency: 'USD',
              defaultLocale: 'en',
              taxReportingEnabled: false,
              complianceTracking: false,
              createdAt: DateTime.now(), 
              updatedAt: DateTime.now()
            ),
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      agents: (json['agents'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenants: (json['tenants'] as List<dynamic>?)?.map((e) => Tenant.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'title': title,
      'body': body,
      'data': data,
      'status': status.toString().split('.').last,
      'sentAt': sentAt?.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'userPreferences': userPreferences,
      'deliveries': deliveries,
      'ruleKey': ruleKey,
      'ruleConfig': ruleConfig,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'user': user?.toJson(),
      'agents': agents.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'tenants': tenants.map((e) => e.toJson()).toList(),
    };
  }

  Notification copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? title,
    String? body,
    dynamic data,
    NotificationStatus? status,
    DateTime? sentAt,
    DateTime? readAt,
    dynamic userPreferences,
    dynamic deliveries,
    String? ruleKey,
    dynamic ruleConfig,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    User? user,
    List<Agent>? agents,
    List<Agency>? agencies,
    List<Tenant>? tenants,
  }) {
    return Notification(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      status: status ?? this.status,
      sentAt: sentAt ?? this.sentAt,
      readAt: readAt ?? this.readAt,
      userPreferences: userPreferences ?? this.userPreferences,
      deliveries: deliveries ?? this.deliveries,
      ruleKey: ruleKey ?? this.ruleKey,
      ruleConfig: ruleConfig ?? this.ruleConfig,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      user: user ?? this.user,
      agents: agents ?? this.agents,
      agencies: agencies ?? this.agencies,
      tenants: tenants ?? this.tenants,
    );
  }
}
