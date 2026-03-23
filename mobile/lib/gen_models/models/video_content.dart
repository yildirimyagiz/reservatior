
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'video_lora_style.dart';
import 'video_pipeline.dart';
import 'video_lora_strategy.dart';
import 'video_target_platform.dart';
import 'video_content_status.dart';
import 'video_campaign_type.dart';
import 'organization.dart';
import 'property.dart';
import 'listing.dart';
import 'brand_ambassador.dart';
import 'ambassador_campaign.dart';


class VideoContent implements PrismaModel<String, VideoContent> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? ambassadorId;
	String? ambassadorCampaignId;
	String? title;
	VideoLoraStyle? primaryLoraStyle;
	VideoLoraStyle? secondaryLoraStyle;
	double? primaryLoraScale;
	double? secondaryLoraScale;
	VideoPipeline? pipeline;
	String? prompt;
	String? negativePrompt;
	VideoLoraStrategy? strategy;
	int? durationSeconds;
	VideoTargetPlatform? platform;
	VideoContentStatus? status;
	String? renderingJobId;
	String? storageKey;
	String? url;
	String? thumbnailUrl;
	int? fileSize;
	String? mimeType;
	DateTime? publishedAt;
	dynamic engagementData;
	VideoCampaignType? campaignType;
	String? abTestGroup;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? campaignId;
	Organization? org;
	Property? property;
	Listing? listing;
	BrandAmbassador? ambassador;
	AmbassadorCampaign? ambassadorCampaign;
	AmbassadorCampaign? campaign;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    VideoContent({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.ambassadorId,
	 this.ambassadorCampaignId,
	 this.title,
	 this.primaryLoraStyle,
	 this.secondaryLoraStyle,
	 this.primaryLoraScale = 1,
	 this.secondaryLoraScale,
	 this.pipeline = VideoPipeline.KREA_REALTIME,
	 this.prompt,
	 this.negativePrompt,
	 this.strategy = VideoLoraStrategy.PERMANENT_MERGE,
	 this.durationSeconds,
	 this.platform,
	 this.status = VideoContentStatus.DRAFT,
	 this.renderingJobId,
	 this.storageKey,
	 this.url,
	 this.thumbnailUrl,
	 this.fileSize,
	 this.mimeType,
	 this.publishedAt,
	required this.engagementData,
	 this.campaignType,
	 this.abTestGroup,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.campaignId,
	 this.org,
	 this.property,
	 this.listing,
	 this.ambassador,
	 this.ambassadorCampaign,
	 this.campaign,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<VideoContent, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"ambassadorId": (m) => m.ambassadorId,

	"ambassadorCampaignId": (m) => m.ambassadorCampaignId,

	"title": (m) => m.title,

	"primaryLoraStyle": (m) => m.primaryLoraStyle,

	"secondaryLoraStyle": (m) => m.secondaryLoraStyle,

	"primaryLoraScale": (m) => m.primaryLoraScale,

	"secondaryLoraScale": (m) => m.secondaryLoraScale,

	"pipeline": (m) => m.pipeline,

	"prompt": (m) => m.prompt,

	"negativePrompt": (m) => m.negativePrompt,

	"strategy": (m) => m.strategy,

	"durationSeconds": (m) => m.durationSeconds,

	"platform": (m) => m.platform,

	"status": (m) => m.status,

	"renderingJobId": (m) => m.renderingJobId,

	"storageKey": (m) => m.storageKey,

	"url": (m) => m.url,

	"thumbnailUrl": (m) => m.thumbnailUrl,

	"fileSize": (m) => m.fileSize,

	"mimeType": (m) => m.mimeType,

	"publishedAt": (m) => m.publishedAt,

	"engagementData": (m) => m.engagementData,

	"campaignType": (m) => m.campaignType,

	"abTestGroup": (m) => m.abTestGroup,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"campaignId": (m) => m.campaignId,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"listing": (m) => m.listing,

	"ambassador": (m) => m.ambassador,

	"ambassadorCampaign": (m) => m.ambassadorCampaign,

	"campaign": (m) => m.campaign,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(VideoContent) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in VideoContent');
    }
    return propFunction as V? Function(VideoContent);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory VideoContent.fromJson(JsonMap json) =>
      VideoContent(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	ambassadorId: json['ambassadorId'] as String?,
	ambassadorCampaignId: json['ambassadorCampaignId'] as String?,
	title: json['title'] as String?,
	primaryLoraStyle: json['primaryLoraStyle'] != null ? VideoLoraStyle.fromJson(json['primaryLoraStyle']) : null,
	secondaryLoraStyle: json['secondaryLoraStyle'] != null ? VideoLoraStyle.fromJson(json['secondaryLoraStyle']) : null,
	primaryLoraScale: json['primaryLoraScale']?.toDouble(),
	secondaryLoraScale: json['secondaryLoraScale']?.toDouble(),
	pipeline: json['pipeline'] != null ? VideoPipeline.fromJson(json['pipeline']) : null,
	prompt: json['prompt'] as String?,
	negativePrompt: json['negativePrompt'] as String?,
	strategy: json['strategy'] != null ? VideoLoraStrategy.fromJson(json['strategy']) : null,
	durationSeconds: int.tryParse(json['durationSeconds'].toString()),
	platform: json['platform'] != null ? VideoTargetPlatform.fromJson(json['platform']) : null,
	status: json['status'] != null ? VideoContentStatus.fromJson(json['status']) : null,
	renderingJobId: json['renderingJobId'] as String?,
	storageKey: json['storageKey'] as String?,
	url: json['url'] as String?,
	thumbnailUrl: json['thumbnailUrl'] as String?,
	fileSize: int.tryParse(json['fileSize'].toString()),
	mimeType: json['mimeType'] as String?,
	publishedAt: json['publishedAt'] != null ? DateTime.parse(json['publishedAt']) : null,
	engagementData: json['engagementData'] as dynamic,
	campaignType: json['campaignType'] != null ? VideoCampaignType.fromJson(json['campaignType']) : null,
	abTestGroup: json['abTestGroup'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	campaignId: json['campaignId'] as String?,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	ambassador: json['ambassador'] != null ? BrandAmbassador.fromJson(json['ambassador'] as JsonMap) : null,
	ambassadorCampaign: json['ambassadorCampaign'] != null ? AmbassadorCampaign.fromJson(json['ambassadorCampaign'] as JsonMap) : null,
	campaign: json['campaign'] != null ? AmbassadorCampaign.fromJson(json['campaign'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    VideoContent copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? ambassadorId,
		Value<String?>? ambassadorCampaignId,
		Value<String?>? title,
		Value<VideoLoraStyle?>? primaryLoraStyle,
		Value<VideoLoraStyle?>? secondaryLoraStyle,
		Value<double?>? primaryLoraScale,
		Value<double?>? secondaryLoraScale,
		Value<VideoPipeline?>? pipeline,
		Value<String?>? prompt,
		Value<String?>? negativePrompt,
		Value<VideoLoraStrategy?>? strategy,
		Value<int?>? durationSeconds,
		Value<VideoTargetPlatform?>? platform,
		Value<VideoContentStatus?>? status,
		Value<String?>? renderingJobId,
		Value<String?>? storageKey,
		Value<String?>? url,
		Value<String?>? thumbnailUrl,
		Value<int?>? fileSize,
		Value<String?>? mimeType,
		Value<DateTime?>? publishedAt,
		Value<dynamic>? engagementData,
		Value<VideoCampaignType?>? campaignType,
		Value<String?>? abTestGroup,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? campaignId,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<Listing?>? listing,
		Value<BrandAmbassador?>? ambassador,
		Value<AmbassadorCampaign?>? ambassadorCampaign,
		Value<AmbassadorCampaign?>? campaign,
        }) {
        return VideoContent(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		ambassadorId: ambassadorId != null ? ambassadorId.value : this.ambassadorId,
		ambassadorCampaignId: ambassadorCampaignId != null ? ambassadorCampaignId.value : this.ambassadorCampaignId,
		title: title != null ? title.value : this.title,
		primaryLoraStyle: primaryLoraStyle != null ? primaryLoraStyle.value : this.primaryLoraStyle,
		secondaryLoraStyle: secondaryLoraStyle != null ? secondaryLoraStyle.value : this.secondaryLoraStyle,
		primaryLoraScale: primaryLoraScale != null ? primaryLoraScale.value : this.primaryLoraScale,
		secondaryLoraScale: secondaryLoraScale != null ? secondaryLoraScale.value : this.secondaryLoraScale,
		pipeline: pipeline != null ? pipeline.value : this.pipeline,
		prompt: prompt != null ? prompt.value : this.prompt,
		negativePrompt: negativePrompt != null ? negativePrompt.value : this.negativePrompt,
		strategy: strategy != null ? strategy.value : this.strategy,
		durationSeconds: durationSeconds != null ? durationSeconds.value : this.durationSeconds,
		platform: platform != null ? platform.value : this.platform,
		status: status != null ? status.value : this.status,
		renderingJobId: renderingJobId != null ? renderingJobId.value : this.renderingJobId,
		storageKey: storageKey != null ? storageKey.value : this.storageKey,
		url: url != null ? url.value : this.url,
		thumbnailUrl: thumbnailUrl != null ? thumbnailUrl.value : this.thumbnailUrl,
		fileSize: fileSize != null ? fileSize.value : this.fileSize,
		mimeType: mimeType != null ? mimeType.value : this.mimeType,
		publishedAt: publishedAt != null ? publishedAt.value : this.publishedAt,
		engagementData: engagementData != null ? engagementData.value : this.engagementData,
		campaignType: campaignType != null ? campaignType.value : this.campaignType,
		abTestGroup: abTestGroup != null ? abTestGroup.value : this.abTestGroup,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		campaignId: campaignId != null ? campaignId.value : this.campaignId,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		listing: listing != null ? listing.value : this.listing,
		ambassador: ambassador != null ? ambassador.value : this.ambassador,
		ambassadorCampaign: ambassadorCampaign != null ? ambassadorCampaign.value : this.ambassadorCampaign,
		campaign: campaign != null ? campaign.value : this.campaign
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    VideoContent copyWithInstanceValues(VideoContent videoContent) {
        return VideoContent(
            id: videoContent.id ?? id,
		orgId: videoContent.orgId ?? orgId,
		propertyId: videoContent.propertyId ?? propertyId,
		listingId: videoContent.listingId ?? listingId,
		ambassadorId: videoContent.ambassadorId ?? ambassadorId,
		ambassadorCampaignId: videoContent.ambassadorCampaignId ?? ambassadorCampaignId,
		title: videoContent.title ?? title,
		primaryLoraStyle: videoContent.primaryLoraStyle ?? primaryLoraStyle,
		secondaryLoraStyle: videoContent.secondaryLoraStyle ?? secondaryLoraStyle,
		primaryLoraScale: videoContent.primaryLoraScale ?? primaryLoraScale,
		secondaryLoraScale: videoContent.secondaryLoraScale ?? secondaryLoraScale,
		pipeline: videoContent.pipeline ?? pipeline,
		prompt: videoContent.prompt ?? prompt,
		negativePrompt: videoContent.negativePrompt ?? negativePrompt,
		strategy: videoContent.strategy ?? strategy,
		durationSeconds: videoContent.durationSeconds ?? durationSeconds,
		platform: videoContent.platform ?? platform,
		status: videoContent.status ?? status,
		renderingJobId: videoContent.renderingJobId ?? renderingJobId,
		storageKey: videoContent.storageKey ?? storageKey,
		url: videoContent.url ?? url,
		thumbnailUrl: videoContent.thumbnailUrl ?? thumbnailUrl,
		fileSize: videoContent.fileSize ?? fileSize,
		mimeType: videoContent.mimeType ?? mimeType,
		publishedAt: videoContent.publishedAt ?? publishedAt,
		engagementData: videoContent.engagementData ?? engagementData,
		campaignType: videoContent.campaignType ?? campaignType,
		abTestGroup: videoContent.abTestGroup ?? abTestGroup,
		createdBy: videoContent.createdBy ?? createdBy,
		createdAt: videoContent.createdAt ?? createdAt,
		updatedAt: videoContent.updatedAt ?? updatedAt,
		deletedAt: videoContent.deletedAt ?? deletedAt,
		campaignId: videoContent.campaignId ?? campaignId,
		org: videoContent.org ?? org,
		property: videoContent.property ?? property,
		listing: videoContent.listing ?? listing,
		ambassador: videoContent.ambassador ?? ambassador,
		ambassadorCampaign: videoContent.ambassadorCampaign ?? ambassadorCampaign,
		campaign: videoContent.campaign ?? campaign
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    VideoContent mergeWithInstanceValues(VideoContent videoContent) {
        return VideoContent(
            id: videoContent.$assignedFields.contains('id') ? videoContent.id : id,
		orgId: videoContent.$assignedFields.contains('orgId') ? videoContent.orgId : orgId,
		propertyId: videoContent.$assignedFields.contains('propertyId') ? videoContent.propertyId : propertyId,
		listingId: videoContent.$assignedFields.contains('listingId') ? videoContent.listingId : listingId,
		ambassadorId: videoContent.$assignedFields.contains('ambassadorId') ? videoContent.ambassadorId : ambassadorId,
		ambassadorCampaignId: videoContent.$assignedFields.contains('ambassadorCampaignId') ? videoContent.ambassadorCampaignId : ambassadorCampaignId,
		title: videoContent.$assignedFields.contains('title') ? videoContent.title : title,
		primaryLoraStyle: videoContent.$assignedFields.contains('primaryLoraStyle') ? videoContent.primaryLoraStyle : primaryLoraStyle,
		secondaryLoraStyle: videoContent.$assignedFields.contains('secondaryLoraStyle') ? videoContent.secondaryLoraStyle : secondaryLoraStyle,
		primaryLoraScale: videoContent.$assignedFields.contains('primaryLoraScale') ? videoContent.primaryLoraScale : primaryLoraScale,
		secondaryLoraScale: videoContent.$assignedFields.contains('secondaryLoraScale') ? videoContent.secondaryLoraScale : secondaryLoraScale,
		pipeline: videoContent.$assignedFields.contains('pipeline') ? videoContent.pipeline : pipeline,
		prompt: videoContent.$assignedFields.contains('prompt') ? videoContent.prompt : prompt,
		negativePrompt: videoContent.$assignedFields.contains('negativePrompt') ? videoContent.negativePrompt : negativePrompt,
		strategy: videoContent.$assignedFields.contains('strategy') ? videoContent.strategy : strategy,
		durationSeconds: videoContent.$assignedFields.contains('durationSeconds') ? videoContent.durationSeconds : durationSeconds,
		platform: videoContent.$assignedFields.contains('platform') ? videoContent.platform : platform,
		status: videoContent.$assignedFields.contains('status') ? videoContent.status : status,
		renderingJobId: videoContent.$assignedFields.contains('renderingJobId') ? videoContent.renderingJobId : renderingJobId,
		storageKey: videoContent.$assignedFields.contains('storageKey') ? videoContent.storageKey : storageKey,
		url: videoContent.$assignedFields.contains('url') ? videoContent.url : url,
		thumbnailUrl: videoContent.$assignedFields.contains('thumbnailUrl') ? videoContent.thumbnailUrl : thumbnailUrl,
		fileSize: videoContent.$assignedFields.contains('fileSize') ? videoContent.fileSize : fileSize,
		mimeType: videoContent.$assignedFields.contains('mimeType') ? videoContent.mimeType : mimeType,
		publishedAt: videoContent.$assignedFields.contains('publishedAt') ? videoContent.publishedAt : publishedAt,
		engagementData: videoContent.$assignedFields.contains('engagementData') ? videoContent.engagementData : engagementData,
		campaignType: videoContent.$assignedFields.contains('campaignType') ? videoContent.campaignType : campaignType,
		abTestGroup: videoContent.$assignedFields.contains('abTestGroup') ? videoContent.abTestGroup : abTestGroup,
		createdBy: videoContent.$assignedFields.contains('createdBy') ? videoContent.createdBy : createdBy,
		createdAt: videoContent.$assignedFields.contains('createdAt') ? videoContent.createdAt : createdAt,
		updatedAt: videoContent.$assignedFields.contains('updatedAt') ? videoContent.updatedAt : updatedAt,
		deletedAt: videoContent.$assignedFields.contains('deletedAt') ? videoContent.deletedAt : deletedAt,
		campaignId: videoContent.$assignedFields.contains('campaignId') ? videoContent.campaignId : campaignId,
		org: videoContent.$assignedFields.contains('org') ? videoContent.org : org,
		property: videoContent.$assignedFields.contains('property') ? videoContent.property : property,
		listing: videoContent.$assignedFields.contains('listing') ? videoContent.listing : listing,
		ambassador: videoContent.$assignedFields.contains('ambassador') ? videoContent.ambassador : ambassador,
		ambassadorCampaign: videoContent.$assignedFields.contains('ambassadorCampaign') ? videoContent.ambassadorCampaign : ambassadorCampaign,
		campaign: videoContent.$assignedFields.contains('campaign') ? videoContent.campaign : campaign
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    VideoContent updateWithInstanceValues(VideoContent videoContent) {
        if (videoContent.$assignedFields.contains('id')) { id = videoContent.id; }
		if (videoContent.$assignedFields.contains('orgId')) { orgId = videoContent.orgId; }
		if (videoContent.$assignedFields.contains('propertyId')) { propertyId = videoContent.propertyId; }
		if (videoContent.$assignedFields.contains('listingId')) { listingId = videoContent.listingId; }
		if (videoContent.$assignedFields.contains('ambassadorId')) { ambassadorId = videoContent.ambassadorId; }
		if (videoContent.$assignedFields.contains('ambassadorCampaignId')) { ambassadorCampaignId = videoContent.ambassadorCampaignId; }
		if (videoContent.$assignedFields.contains('title')) { title = videoContent.title; }
		if (videoContent.$assignedFields.contains('primaryLoraStyle')) { primaryLoraStyle = videoContent.primaryLoraStyle; }
		if (videoContent.$assignedFields.contains('secondaryLoraStyle')) { secondaryLoraStyle = videoContent.secondaryLoraStyle; }
		if (videoContent.$assignedFields.contains('primaryLoraScale')) { primaryLoraScale = videoContent.primaryLoraScale; }
		if (videoContent.$assignedFields.contains('secondaryLoraScale')) { secondaryLoraScale = videoContent.secondaryLoraScale; }
		if (videoContent.$assignedFields.contains('pipeline')) { pipeline = videoContent.pipeline; }
		if (videoContent.$assignedFields.contains('prompt')) { prompt = videoContent.prompt; }
		if (videoContent.$assignedFields.contains('negativePrompt')) { negativePrompt = videoContent.negativePrompt; }
		if (videoContent.$assignedFields.contains('strategy')) { strategy = videoContent.strategy; }
		if (videoContent.$assignedFields.contains('durationSeconds')) { durationSeconds = videoContent.durationSeconds; }
		if (videoContent.$assignedFields.contains('platform')) { platform = videoContent.platform; }
		if (videoContent.$assignedFields.contains('status')) { status = videoContent.status; }
		if (videoContent.$assignedFields.contains('renderingJobId')) { renderingJobId = videoContent.renderingJobId; }
		if (videoContent.$assignedFields.contains('storageKey')) { storageKey = videoContent.storageKey; }
		if (videoContent.$assignedFields.contains('url')) { url = videoContent.url; }
		if (videoContent.$assignedFields.contains('thumbnailUrl')) { thumbnailUrl = videoContent.thumbnailUrl; }
		if (videoContent.$assignedFields.contains('fileSize')) { fileSize = videoContent.fileSize; }
		if (videoContent.$assignedFields.contains('mimeType')) { mimeType = videoContent.mimeType; }
		if (videoContent.$assignedFields.contains('publishedAt')) { publishedAt = videoContent.publishedAt; }
		if (videoContent.$assignedFields.contains('engagementData')) { engagementData = videoContent.engagementData; }
		if (videoContent.$assignedFields.contains('campaignType')) { campaignType = videoContent.campaignType; }
		if (videoContent.$assignedFields.contains('abTestGroup')) { abTestGroup = videoContent.abTestGroup; }
		if (videoContent.$assignedFields.contains('createdBy')) { createdBy = videoContent.createdBy; }
		if (videoContent.$assignedFields.contains('createdAt')) { createdAt = videoContent.createdAt; }
		if (videoContent.$assignedFields.contains('updatedAt')) { updatedAt = videoContent.updatedAt; }
		if (videoContent.$assignedFields.contains('deletedAt')) { deletedAt = videoContent.deletedAt; }
		if (videoContent.$assignedFields.contains('campaignId')) { campaignId = videoContent.campaignId; }
		if (videoContent.$assignedFields.contains('org')) { org = videoContent.org; }
		if (videoContent.$assignedFields.contains('property')) { property = videoContent.property; }
		if (videoContent.$assignedFields.contains('listing')) { listing = videoContent.listing; }
		if (videoContent.$assignedFields.contains('ambassador')) { ambassador = videoContent.ambassador; }
		if (videoContent.$assignedFields.contains('ambassadorCampaign')) { ambassadorCampaign = videoContent.ambassadorCampaign; }
		if (videoContent.$assignedFields.contains('campaign')) { campaign = videoContent.campaign; }
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
          ? {...?serializedTypes, 'VideoContent'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(ambassadorId != null) 'ambassadorId': ambassadorId,
	if(ambassadorCampaignId != null) 'ambassadorCampaignId': ambassadorCampaignId,
	if(title != null) 'title': title,
	if(primaryLoraStyle != null) 'primaryLoraStyle': primaryLoraStyle?.toJson(),
	if(secondaryLoraStyle != null) 'secondaryLoraStyle': secondaryLoraStyle?.toJson(),
	if(primaryLoraScale != null) 'primaryLoraScale': primaryLoraScale,
	if(secondaryLoraScale != null) 'secondaryLoraScale': secondaryLoraScale,
	if(pipeline != null) 'pipeline': pipeline?.toJson(),
	if(prompt != null) 'prompt': prompt,
	if(negativePrompt != null) 'negativePrompt': negativePrompt,
	if(strategy != null) 'strategy': strategy?.toJson(),
	if(durationSeconds != null) 'durationSeconds': durationSeconds,
	if(platform != null) 'platform': platform?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(renderingJobId != null) 'renderingJobId': renderingJobId,
	if(storageKey != null) 'storageKey': storageKey,
	if(url != null) 'url': url,
	if(thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
	if(fileSize != null) 'fileSize': fileSize,
	if(mimeType != null) 'mimeType': mimeType,
	if(publishedAt != null) 'publishedAt': publishedAt?.toIso8601String(),
	if(engagementData != null) 'engagementData': engagementData,
	if(campaignType != null) 'campaignType': campaignType?.toJson(),
	if(abTestGroup != null) 'abTestGroup': abTestGroup,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(campaignId != null) 'campaignId': campaignId,
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(ambassador != null && (!preventCircularSerialization || !serializedModels.contains('BrandAmbassador'))) 'ambassador': ambassador?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(ambassadorCampaign != null && (!preventCircularSerialization || !serializedModels.contains('AmbassadorCampaign'))) 'ambassadorCampaign': ambassadorCampaign?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(campaign != null && (!preventCircularSerialization || !serializedModels.contains('AmbassadorCampaign'))) 'campaign': campaign?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is VideoContent &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    