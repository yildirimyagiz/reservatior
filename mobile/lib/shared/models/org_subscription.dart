import 'organization.dart';
import 'plan.dart';

class OrgSubscription {
  final String id;
  final String orgId;
  final String planId;
  final String status;
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final DateTime? currentPeriodEnd;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Plan plan;

  const OrgSubscription({
    required this.id,
    required this.orgId,
    required this.planId,
    required this.status,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.currentPeriodEnd,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.plan,
  });

  factory OrgSubscription.fromJson(Map<String, dynamic> json) {
    return OrgSubscription(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      planId: json['planId'] as String,
      status: json['status'] as String,
      stripeCustomerId: json['stripeCustomerId'] as String?,
      stripeSubscriptionId: json['stripeSubscriptionId'] as String?,
      currentPeriodEnd: json['currentPeriodEnd'] != null ? DateTime.parse(json['currentPeriodEnd'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      plan: Plan.fromJson(json['plan'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'planId': planId,
      'status': status,
      'stripeCustomerId': stripeCustomerId,
      'stripeSubscriptionId': stripeSubscriptionId,
      'currentPeriodEnd': currentPeriodEnd?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'plan': plan.toJson(),
    };
  }

  OrgSubscription copyWith({
    String? id,
    String? orgId,
    String? planId,
    String? status,
    String? stripeCustomerId,
    String? stripeSubscriptionId,
    DateTime? currentPeriodEnd,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Plan? plan,
  }) {
    return OrgSubscription(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      planId: planId ?? this.planId,
      status: status ?? this.status,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
      stripeSubscriptionId: stripeSubscriptionId ?? this.stripeSubscriptionId,
      currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      plan: plan ?? this.plan,
    );
  }
}
