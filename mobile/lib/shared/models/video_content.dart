import 'package:reservatior/shared/enums/video_campaign_type.dart';
import 'package:reservatior/shared/enums/video_content_status.dart';
import 'package:reservatior/shared/enums/video_lora_strategy.dart';
import 'package:reservatior/shared/enums/video_lora_style.dart';
import 'package:reservatior/shared/enums/video_pipeline.dart';
import 'package:reservatior/shared/enums/video_target_platform.dart';
import 'ambassador_campaign.dart';
import 'brand_ambassador.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';

class VideoContent {
  final String id;
  final String orgId;
  final String? propertyId;
  final String? listingId;
  final String? ambassadorId;
  final String? ambassadorCampaignId;
  final String? title;
  final VideoLoraStyle primaryLoraStyle;
  final VideoLoraStyle? secondaryLoraStyle;
  final double primaryLoraScale;
  final double? secondaryLoraScale;
  final VideoPipeline pipeline;
  final String prompt;
  final String? negativePrompt;
  final VideoLoraStrategy strategy;
  final int? durationSeconds;
  final VideoTargetPlatform platform;
  final VideoContentStatus status;
  final String? renderingJobId;
  final String? storageKey;
  final String? url;
  final String? thumbnailUrl;
  final int? fileSize;
  final String? mimeType;
  final DateTime? publishedAt;
  final VideoCampaignType? campaignType;
  final String? abTestGroup;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? campaignId;
  final Organization org;
  final Property? property;
  final Listing? listing;
  final BrandAmbassador? ambassador;
  final AmbassadorCampaign? ambassadorCampaign;
  final AmbassadorCampaign? campaign;

  const VideoContent({
    required this.id,
    required this.orgId,
    this.propertyId,
    this.listingId,
    this.ambassadorId,
    this.ambassadorCampaignId,
    this.title,
    required this.primaryLoraStyle,
    this.secondaryLoraStyle,
    required this.primaryLoraScale,
    this.secondaryLoraScale,
    required this.pipeline,
    required this.prompt,
    this.negativePrompt,
    required this.strategy,
    this.durationSeconds,
    required this.platform,
    required this.status,
    this.renderingJobId,
    this.storageKey,
    this.url,
    this.thumbnailUrl,
    this.fileSize,
    this.mimeType,
    this.publishedAt,
    this.campaignType,
    this.abTestGroup,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.campaignId,
    required this.org,
    this.property,
    this.listing,
    this.ambassador,
    this.ambassadorCampaign,
    this.campaign,
  });

  factory VideoContent.fromJson(Map<String, dynamic> json) {
    T safeParse<T extends Enum>(List<T> values, dynamic jsonValue, T defaultValue) {
      if (jsonValue == null) return defaultValue;
      final valUpper = jsonValue.toString().toUpperCase();
      return values.firstWhere(
        (v) => v.name.toUpperCase() == valUpper,
        orElse: () => defaultValue,
      );
    }

    return VideoContent(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String?,
      listingId: json['listingId'] as String?,
      ambassadorId: json['ambassadorId'] as String?,
      ambassadorCampaignId: json['ambassadorCampaignId'] as String?,
      title: json['title'] as String?,
      primaryLoraStyle: safeParse(VideoLoraStyle.values, json['primaryLoraStyle'], VideoLoraStyle.REALISTIC),
      secondaryLoraStyle: json['secondaryLoraStyle'] != null ? safeParse(VideoLoraStyle.values, json['secondaryLoraStyle'], VideoLoraStyle.REALISTIC) : null,
      primaryLoraScale: (json['primaryLoraScale'] as num).toDouble(),
      secondaryLoraScale: (json['secondaryLoraScale'] as num?)?.toDouble(),
      pipeline: safeParse(VideoPipeline.values, json['pipeline'], VideoPipeline.STREAM_DIFFUSION_V2),
      prompt: json['prompt'] as String,
      negativePrompt: json['negativePrompt'] as String?,
      strategy: safeParse(VideoLoraStrategy.values, json['strategy'], VideoLoraStrategy.PERMANENT_MERGE),
      durationSeconds: json['durationSeconds'] as int?,
      platform: safeParse(VideoTargetPlatform.values, json['platform'], VideoTargetPlatform.TIKTOK),
      status: safeParse(VideoContentStatus.values, json['status'], VideoContentStatus.DRAFT),
      renderingJobId: json['renderingJobId'] as String?,
      storageKey: json['storageKey'] as String?,
      url: json['url'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      fileSize: json['fileSize'] as int?,
      mimeType: json['mimeType'] as String?,
      publishedAt: json['publishedAt'] != null ? DateTime.parse(json['publishedAt'] as String) : null,
      campaignType: json['campaignType'] != null ? safeParse(VideoCampaignType.values, json['campaignType'], VideoCampaignType.SALES_ASSISTANT) : null,
      abTestGroup: json['abTestGroup'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      campaignId: json['campaignId'] as String?,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      ambassador: json['ambassador'] != null ? BrandAmbassador.fromJson(json['ambassador'] as Map<String, dynamic>) : null,
      ambassadorCampaign: json['ambassadorCampaign'] != null ? AmbassadorCampaign.fromJson(json['ambassadorCampaign'] as Map<String, dynamic>) : null,
      campaign: json['campaign'] != null ? AmbassadorCampaign.fromJson(json['campaign'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'ambassadorId': ambassadorId,
      'ambassadorCampaignId': ambassadorCampaignId,
      'title': title,
      'primaryLoraStyle': primaryLoraStyle.name,
      'secondaryLoraStyle': secondaryLoraStyle?.name,
      'primaryLoraScale': primaryLoraScale,
      'secondaryLoraScale': secondaryLoraScale,
      'pipeline': pipeline.name,
      'prompt': prompt,
      'negativePrompt': negativePrompt,
      'strategy': strategy.name,
      'durationSeconds': durationSeconds,
      'platform': platform.name,
      'status': status.name,
      'renderingJobId': renderingJobId,
      'storageKey': storageKey,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'fileSize': fileSize,
      'mimeType': mimeType,
      'publishedAt': publishedAt?.toIso8601String(),
      'campaignType': campaignType?.name,
      'abTestGroup': abTestGroup,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'campaignId': campaignId,
      'org': org.toJson(),
      'property': property?.toJson(),
      'listing': listing?.toJson(),
      'ambassador': ambassador?.toJson(),
      'ambassadorCampaign': ambassadorCampaign?.toJson(),
      'campaign': campaign?.toJson(),
    };
  }

  VideoContent copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? ambassadorId,
    String? ambassadorCampaignId,
    String? title,
    VideoLoraStyle? primaryLoraStyle,
    VideoLoraStyle? secondaryLoraStyle,
    double? primaryLoraScale,
    double? secondaryLoraScale,
    VideoPipeline? pipeline,
    String? prompt,
    String? negativePrompt,
    VideoLoraStrategy? strategy,
    int? durationSeconds,
    VideoTargetPlatform? platform,
    VideoContentStatus? status,
    String? renderingJobId,
    String? storageKey,
    String? url,
    String? thumbnailUrl,
    int? fileSize,
    String? mimeType,
    DateTime? publishedAt,
    VideoCampaignType? campaignType,
    String? abTestGroup,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? campaignId,
    Organization? org,
    Property? property,
    Listing? listing,
    BrandAmbassador? ambassador,
    AmbassadorCampaign? ambassadorCampaign,
    AmbassadorCampaign? campaign,
  }) {
    return VideoContent(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      ambassadorId: ambassadorId ?? this.ambassadorId,
      ambassadorCampaignId: ambassadorCampaignId ?? this.ambassadorCampaignId,
      title: title ?? this.title,
      primaryLoraStyle: primaryLoraStyle ?? this.primaryLoraStyle,
      secondaryLoraStyle: secondaryLoraStyle ?? this.secondaryLoraStyle,
      primaryLoraScale: primaryLoraScale ?? this.primaryLoraScale,
      secondaryLoraScale: secondaryLoraScale ?? this.secondaryLoraScale,
      pipeline: pipeline ?? this.pipeline,
      prompt: prompt ?? this.prompt,
      negativePrompt: negativePrompt ?? this.negativePrompt,
      strategy: strategy ?? this.strategy,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      platform: platform ?? this.platform,
      status: status ?? this.status,
      renderingJobId: renderingJobId ?? this.renderingJobId,
      storageKey: storageKey ?? this.storageKey,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      fileSize: fileSize ?? this.fileSize,
      mimeType: mimeType ?? this.mimeType,
      publishedAt: publishedAt ?? this.publishedAt,
      campaignType: campaignType ?? this.campaignType,
      abTestGroup: abTestGroup ?? this.abTestGroup,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      campaignId: campaignId ?? this.campaignId,
      org: org ?? this.org,
      property: property ?? this.property,
      listing: listing ?? this.listing,
      ambassador: ambassador ?? this.ambassador,
      ambassadorCampaign: ambassadorCampaign ?? this.ambassadorCampaign,
      campaign: campaign ?? this.campaign,
    );
  }
}
