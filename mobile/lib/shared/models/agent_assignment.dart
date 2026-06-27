import 'listing.dart';
import 'organization.dart';
import 'user.dart';

class AgentAssignment {
  final String id;
  final String orgId;
  final String listingId;
  final String agentUserId;
  final String? agencyOrgId;
  final int? commissionBps;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final User agent;
  final Listing listing;
  final Organization org;

  const AgentAssignment({
    required this.id,
    required this.orgId,
    required this.listingId,
    required this.agentUserId,
    this.agencyOrgId,
    this.commissionBps,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.agent,
    required this.listing,
    required this.org,
  });

  factory AgentAssignment.fromJson(Map<String, dynamic> json) {
    return AgentAssignment(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String,
      agentUserId: json['agentUserId'] as String,
      agencyOrgId: json['agencyOrgId'] as String?,
      commissionBps: json['commissionBps'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      agent: User.fromJson(json['agent'] as Map<String, dynamic>),
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'agentUserId': agentUserId,
      'agencyOrgId': agencyOrgId,
      'commissionBps': commissionBps,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'agent': agent.toJson(),
      'listing': listing.toJson(),
      'org': org.toJson(),
    };
  }

  AgentAssignment copyWith({
    String? id,
    String? orgId,
    String? listingId,
    String? agentUserId,
    String? agencyOrgId,
    int? commissionBps,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    User? agent,
    Listing? listing,
    Organization? org,
  }) {
    return AgentAssignment(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      agentUserId: agentUserId ?? this.agentUserId,
      agencyOrgId: agencyOrgId ?? this.agencyOrgId,
      commissionBps: commissionBps ?? this.commissionBps,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      agent: agent ?? this.agent,
      listing: listing ?? this.listing,
      org: org ?? this.org,
    );
  }
}
