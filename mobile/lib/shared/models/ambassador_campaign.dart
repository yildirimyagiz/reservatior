import 'package:reservatior/shared/enums/campaign_status.dart';
import 'brand_ambassador.dart';
import 'organization.dart';
import 'video_content.dart';

class AmbassadorCampaign {
  final String id;
  final String orgId;
  final String ambassadorId;
  final String name;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? budget;
  final double? actualSpend;
  final String currency;
  final CampaignStatus status;
  final int? targetReach;
  final int? actualReach;
  final int? impressions;
  final int? clicks;
  final int? conversions;
  final double? conversionValue;
  final double? roi;
  final List<String> platforms;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BrandAmbassador ambassador;
  final Organization org;
  final List<VideoContent> videoContents;
  final List<VideoContent> campaignVideos;

  const AmbassadorCampaign({
    required this.id,
    required this.orgId,
    required this.ambassadorId,
    required this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.budget,
    this.actualSpend,
    required this.currency,
    required this.status,
    this.targetReach,
    this.actualReach,
    this.impressions,
    this.clicks,
    this.conversions,
    this.conversionValue,
    this.roi,
    this.platforms = const [],
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.ambassador,
    required this.org,
    this.videoContents = const [],
    this.campaignVideos = const [],
  });

  factory AmbassadorCampaign.fromJson(Map<String, dynamic> json) {
    return AmbassadorCampaign(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      ambassadorId: json['ambassadorId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      budget: (json['budget'] as num?)?.toDouble(),
      actualSpend: (json['actualSpend'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      status: CampaignStatus.values.firstWhere((v) => v.name == json['status']),
      targetReach: json['targetReach'] as int?,
      actualReach: json['actualReach'] as int?,
      impressions: json['impressions'] as int?,
      clicks: json['clicks'] as int?,
      conversions: json['conversions'] as int?,
      conversionValue: (json['conversionValue'] as num?)?.toDouble(),
      roi: (json['roi'] as num?)?.toDouble(),
      platforms: (json['platforms'] as List<dynamic>?)?.cast<String>() ?? [],
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      ambassador: BrandAmbassador.fromJson(json['ambassador'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      videoContents: (json['videoContents'] as List<dynamic>?)?.map((e) => VideoContent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      campaignVideos: (json['campaignVideos'] as List<dynamic>?)?.map((e) => VideoContent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'ambassadorId': ambassadorId,
      'name': name,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'budget': budget,
      'actualSpend': actualSpend,
      'currency': currency,
      'status': status.name,
      'targetReach': targetReach,
      'actualReach': actualReach,
      'impressions': impressions,
      'clicks': clicks,
      'conversions': conversions,
      'conversionValue': conversionValue,
      'roi': roi,
      'platforms': platforms,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'ambassador': ambassador.toJson(),
      'org': org.toJson(),
      'videoContents': videoContents.map((e) => e.toJson()).toList(),
      'campaignVideos': campaignVideos.map((e) => e.toJson()).toList(),
    };
  }

  AmbassadorCampaign copyWith({
    String? id,
    String? orgId,
    String? ambassadorId,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    double? budget,
    double? actualSpend,
    String? currency,
    CampaignStatus? status,
    int? targetReach,
    int? actualReach,
    int? impressions,
    int? clicks,
    int? conversions,
    double? conversionValue,
    double? roi,
    List<String>? platforms,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    BrandAmbassador? ambassador,
    Organization? org,
    List<VideoContent>? videoContents,
    List<VideoContent>? campaignVideos,
  }) {
    return AmbassadorCampaign(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      ambassadorId: ambassadorId ?? this.ambassadorId,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      budget: budget ?? this.budget,
      actualSpend: actualSpend ?? this.actualSpend,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      targetReach: targetReach ?? this.targetReach,
      actualReach: actualReach ?? this.actualReach,
      impressions: impressions ?? this.impressions,
      clicks: clicks ?? this.clicks,
      conversions: conversions ?? this.conversions,
      conversionValue: conversionValue ?? this.conversionValue,
      roi: roi ?? this.roi,
      platforms: platforms ?? this.platforms,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ambassador: ambassador ?? this.ambassador,
      org: org ?? this.org,
      videoContents: videoContents ?? this.videoContents,
      campaignVideos: campaignVideos ?? this.campaignVideos,
    );
  }
}
