import 'package:reservatior/shared/enums/campaign_status.dart';
import 'package:reservatior/shared/enums/campaign_type.dart';
import 'lead.dart';
import 'organization.dart';

class MarketingCampaign {
  final String id;
  final String orgId;
  final String name;
  final CampaignType type;
  final CampaignStatus status;
  final String targetType;
  final List<String> targetIds;
  final String? subject;
  final String? content;
  final String? templateId;
  final DateTime? scheduledAt;
  final DateTime? sentAt;
  final DateTime? completedAt;
  final int sentCount;
  final int openCount;
  final int clickCount;
  final int conversionCount;
  final double? budget;
  final double? actualSpend;
  final String? objective;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Lead> leads;
  final Organization org;

  const MarketingCampaign({
    required this.id,
    required this.orgId,
    required this.name,
    required this.type,
    required this.status,
    required this.targetType,
    this.targetIds = const [],
    this.subject,
    this.content,
    this.templateId,
    this.scheduledAt,
    this.sentAt,
    this.completedAt,
    required this.sentCount,
    required this.openCount,
    required this.clickCount,
    required this.conversionCount,
    this.budget,
    this.actualSpend,
    this.objective,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.leads = const [],
    required this.org,
  });

  factory MarketingCampaign.fromJson(Map<String, dynamic> json) {
    return MarketingCampaign(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      type: CampaignType.values.firstWhere((v) => v.name == json['type']),
      status: CampaignStatus.values.firstWhere((v) => v.name == json['status']),
      targetType: json['targetType'] as String,
      targetIds: (json['targetIds'] as List<dynamic>?)?.cast<String>() ?? [],
      subject: json['subject'] as String?,
      content: json['content'] as String?,
      templateId: json['templateId'] as String?,
      scheduledAt: json['scheduledAt'] != null ? DateTime.parse(json['scheduledAt'] as String) : null,
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt'] as String) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      sentCount: json['sentCount'] as int,
      openCount: json['openCount'] as int,
      clickCount: json['clickCount'] as int,
      conversionCount: json['conversionCount'] as int,
      budget: (json['budget'] as num?)?.toDouble(),
      actualSpend: (json['actualSpend'] as num?)?.toDouble(),
      objective: json['objective'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      leads: (json['leads'] as List<dynamic>?)?.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'type': type.name,
      'status': status.name,
      'targetType': targetType,
      'targetIds': targetIds,
      'subject': subject,
      'content': content,
      'templateId': templateId,
      'scheduledAt': scheduledAt?.toIso8601String(),
      'sentAt': sentAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'sentCount': sentCount,
      'openCount': openCount,
      'clickCount': clickCount,
      'conversionCount': conversionCount,
      'budget': budget,
      'actualSpend': actualSpend,
      'objective': objective,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'leads': leads.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
    };
  }

  MarketingCampaign copyWith({
    String? id,
    String? orgId,
    String? name,
    CampaignType? type,
    CampaignStatus? status,
    String? targetType,
    List<String>? targetIds,
    String? subject,
    String? content,
    String? templateId,
    DateTime? scheduledAt,
    DateTime? sentAt,
    DateTime? completedAt,
    int? sentCount,
    int? openCount,
    int? clickCount,
    int? conversionCount,
    double? budget,
    double? actualSpend,
    String? objective,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Lead>? leads,
    Organization? org,
  }) {
    return MarketingCampaign(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      targetType: targetType ?? this.targetType,
      targetIds: targetIds ?? this.targetIds,
      subject: subject ?? this.subject,
      content: content ?? this.content,
      templateId: templateId ?? this.templateId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      sentAt: sentAt ?? this.sentAt,
      completedAt: completedAt ?? this.completedAt,
      sentCount: sentCount ?? this.sentCount,
      openCount: openCount ?? this.openCount,
      clickCount: clickCount ?? this.clickCount,
      conversionCount: conversionCount ?? this.conversionCount,
      budget: budget ?? this.budget,
      actualSpend: actualSpend ?? this.actualSpend,
      objective: objective ?? this.objective,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      leads: leads ?? this.leads,
      org: org ?? this.org,
    );
  }
}
