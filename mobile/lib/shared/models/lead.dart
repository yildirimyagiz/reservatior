import 'package:reservatior/shared/enums/lead_status.dart';
import 'agent_team.dart';
import 'ai_lead_score.dart';
import 'contact.dart';
import 'lead_source.dart';
import 'listing.dart';
import 'marketing_campaign.dart';
import 'organization.dart';
import 'property.dart';
import 'user.dart';

class Lead {
  final String id;
  final String orgId;
  final String? campaignId;
  final String? sourceId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final double? budget;
  final String? timeline;
  final String? notes;
  final LeadStatus status;
  final String? sourceDetail;
  final String? assignedToUserId;
  final String? assignedToContactId;
  final String? interestedPropertyId;
  final String? interestedListingId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? agentTeamId;
  final List<AiLeadScore> aiScores;
  final AgentTeam? agentTeam;
  final Contact? assignedContact;
  final User? assignedUser;
  final MarketingCampaign? campaign;
  final Listing? interestedListing;
  final Property? interestedProperty;
  final Organization org;
  final LeadSource? source;

  const Lead({
    required this.id,
    required this.orgId,
    this.campaignId,
    this.sourceId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.budget,
    this.timeline,
    this.notes,
    required this.status,
    this.sourceDetail,
    this.assignedToUserId,
    this.assignedToContactId,
    this.interestedPropertyId,
    this.interestedListingId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.agentTeamId,
    this.aiScores = const [],
    this.agentTeam,
    this.assignedContact,
    this.assignedUser,
    this.campaign,
    this.interestedListing,
    this.interestedProperty,
    required this.org,
    this.source,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      campaignId: json['campaignId'] as String?,
      sourceId: json['sourceId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      budget: (json['budget'] as num?)?.toDouble(),
      timeline: json['timeline'] as String?,
      notes: json['notes'] as String?,
      status: LeadStatus.values.firstWhere((v) => v.name == json['status']),
      sourceDetail: json['sourceDetail'] as String?,
      assignedToUserId: json['assignedToUserId'] as String?,
      assignedToContactId: json['assignedToContactId'] as String?,
      interestedPropertyId: json['interestedPropertyId'] as String?,
      interestedListingId: json['interestedListingId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      agentTeamId: json['agentTeamId'] as String?,
      aiScores: (json['aiScores'] as List<dynamic>?)?.map((e) => AiLeadScore.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agentTeam: json['agentTeam'] != null ? AgentTeam.fromJson(json['agentTeam'] as Map<String, dynamic>) : null,
      assignedContact: json['assignedContact'] != null ? Contact.fromJson(json['assignedContact'] as Map<String, dynamic>) : null,
      assignedUser: json['assignedUser'] != null ? User.fromJson(json['assignedUser'] as Map<String, dynamic>) : null,
      campaign: json['campaign'] != null ? MarketingCampaign.fromJson(json['campaign'] as Map<String, dynamic>) : null,
      interestedListing: json['interestedListing'] != null ? Listing.fromJson(json['interestedListing'] as Map<String, dynamic>) : null,
      interestedProperty: json['interestedProperty'] != null ? Property.fromJson(json['interestedProperty'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      source: json['source'] != null ? LeadSource.fromJson(json['source'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'campaignId': campaignId,
      'sourceId': sourceId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'budget': budget,
      'timeline': timeline,
      'notes': notes,
      'status': status.name,
      'sourceDetail': sourceDetail,
      'assignedToUserId': assignedToUserId,
      'assignedToContactId': assignedToContactId,
      'interestedPropertyId': interestedPropertyId,
      'interestedListingId': interestedListingId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'agentTeamId': agentTeamId,
      'aiScores': aiScores.map((e) => e.toJson()).toList(),
      'agentTeam': agentTeam?.toJson(),
      'assignedContact': assignedContact?.toJson(),
      'assignedUser': assignedUser?.toJson(),
      'campaign': campaign?.toJson(),
      'interestedListing': interestedListing?.toJson(),
      'interestedProperty': interestedProperty?.toJson(),
      'org': org.toJson(),
      'source': source?.toJson(),
    };
  }

  Lead copyWith({
    String? id,
    String? orgId,
    String? campaignId,
    String? sourceId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    double? budget,
    String? timeline,
    String? notes,
    LeadStatus? status,
    String? sourceDetail,
    String? assignedToUserId,
    String? assignedToContactId,
    String? interestedPropertyId,
    String? interestedListingId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? agentTeamId,
    List<AiLeadScore>? aiScores,
    AgentTeam? agentTeam,
    Contact? assignedContact,
    User? assignedUser,
    MarketingCampaign? campaign,
    Listing? interestedListing,
    Property? interestedProperty,
    Organization? org,
    LeadSource? source,
  }) {
    return Lead(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      campaignId: campaignId ?? this.campaignId,
      sourceId: sourceId ?? this.sourceId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      budget: budget ?? this.budget,
      timeline: timeline ?? this.timeline,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      sourceDetail: sourceDetail ?? this.sourceDetail,
      assignedToUserId: assignedToUserId ?? this.assignedToUserId,
      assignedToContactId: assignedToContactId ?? this.assignedToContactId,
      interestedPropertyId: interestedPropertyId ?? this.interestedPropertyId,
      interestedListingId: interestedListingId ?? this.interestedListingId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      agentTeamId: agentTeamId ?? this.agentTeamId,
      aiScores: aiScores ?? this.aiScores,
      agentTeam: agentTeam ?? this.agentTeam,
      assignedContact: assignedContact ?? this.assignedContact,
      assignedUser: assignedUser ?? this.assignedUser,
      campaign: campaign ?? this.campaign,
      interestedListing: interestedListing ?? this.interestedListing,
      interestedProperty: interestedProperty ?? this.interestedProperty,
      org: org ?? this.org,
      source: source ?? this.source,
    );
  }
}
