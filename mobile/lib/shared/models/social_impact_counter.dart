import 'package:reservatior/shared/enums/social_impact_type.dart';
import 'organization.dart';
import 'social_impact_record.dart';

class SocialImpactCounter {
  final String id;
  final String orgId;
  final SocialImpactType impactType;
  final String currency;
  final String? partnerName;
  final String? partnerUrl;
  final String? partnerOrgId;
  final String? campaignTag;
  final bool isPublic;
  final int? displayGoal;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;
  final List<SocialImpactRecord> records;

  const SocialImpactCounter({
    required this.id,
    required this.orgId,
    required this.impactType,
    required this.currency,
    this.partnerName,
    this.partnerUrl,
    this.partnerOrgId,
    this.campaignTag,
    required this.isPublic,
    this.displayGoal,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
    this.records = const [],
  });

  factory SocialImpactCounter.fromJson(Map<String, dynamic> json) {
    return SocialImpactCounter(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      impactType: SocialImpactType.values.firstWhere((v) => v.name == json['impactType']),
      currency: json['currency'] as String,
      partnerName: json['partnerName'] as String?,
      partnerUrl: json['partnerUrl'] as String?,
      partnerOrgId: json['partnerOrgId'] as String?,
      campaignTag: json['campaignTag'] as String?,
      isPublic: json['isPublic'] as bool,
      displayGoal: json['displayGoal'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      records: (json['records'] as List<dynamic>?)?.map((e) => SocialImpactRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'impactType': impactType.name,
      'currency': currency,
      'partnerName': partnerName,
      'partnerUrl': partnerUrl,
      'partnerOrgId': partnerOrgId,
      'campaignTag': campaignTag,
      'isPublic': isPublic,
      'displayGoal': displayGoal,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
      'records': records.map((e) => e.toJson()).toList(),
    };
  }

  SocialImpactCounter copyWith({
    String? id,
    String? orgId,
    SocialImpactType? impactType,
    String? currency,
    String? partnerName,
    String? partnerUrl,
    String? partnerOrgId,
    String? campaignTag,
    bool? isPublic,
    int? displayGoal,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    List<SocialImpactRecord>? records,
  }) {
    return SocialImpactCounter(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      impactType: impactType ?? this.impactType,
      currency: currency ?? this.currency,
      partnerName: partnerName ?? this.partnerName,
      partnerUrl: partnerUrl ?? this.partnerUrl,
      partnerOrgId: partnerOrgId ?? this.partnerOrgId,
      campaignTag: campaignTag ?? this.campaignTag,
      isPublic: isPublic ?? this.isPublic,
      displayGoal: displayGoal ?? this.displayGoal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      records: records ?? this.records,
    );
  }
}
