
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'campaign_status.dart';
import 'brand_ambassador.dart';
import 'organization.dart';
import 'video_content.dart';


class AmbassadorCampaign implements PrismaModel<String, AmbassadorCampaign> , Id<String> {
    @override
String? id;
	String? orgId;
	String? ambassadorId;
	String? name;
	String? description;
	DateTime? startDate;
	DateTime? endDate;
	double? budget;
	double? actualSpend;
	String? currency;
	CampaignStatus? status;
	int? targetReach;
	int? actualReach;
	int? impressions;
	int? clicks;
	int? conversions;
	double? conversionValue;
	double? roi;
	dynamic content;
	List<String>? platforms;
	DateTime? deletedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	BrandAmbassador? ambassador;
	Organization? org;
	List<VideoContent>? videoContents;
	List<VideoContent>? campaignVideos;
	int? $platformsCount;
	int? $videoContentsCount;
	int? $campaignVideosCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AmbassadorCampaign({ this.id,
	 this.orgId,
	 this.ambassadorId,
	 this.name,
	 this.description,
	 this.startDate,
	 this.endDate,
	 this.budget,
	 this.actualSpend,
	 this.currency = "USD",
	 this.status = CampaignStatus.DRAFT,
	 this.targetReach,
	 this.actualReach,
	 this.impressions,
	 this.clicks,
	 this.conversions,
	 this.conversionValue,
	 this.roi,
	required this.content,
	 this.platforms,
	 this.deletedAt,
	 this.createdAt,
	 this.updatedAt,
	 this.ambassador,
	 this.org,
	 this.videoContents,
	 this.campaignVideos,
	this.$platformsCount,
	this.$videoContentsCount,
	this.$campaignVideosCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AmbassadorCampaign, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"ambassadorId": (m) => m.ambassadorId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"budget": (m) => m.budget,

	"actualSpend": (m) => m.actualSpend,

	"currency": (m) => m.currency,

	"status": (m) => m.status,

	"targetReach": (m) => m.targetReach,

	"actualReach": (m) => m.actualReach,

	"impressions": (m) => m.impressions,

	"clicks": (m) => m.clicks,

	"conversions": (m) => m.conversions,

	"conversionValue": (m) => m.conversionValue,

	"roi": (m) => m.roi,

	"content": (m) => m.content,

	"platforms": (m) => m.platforms,

	"deletedAt": (m) => m.deletedAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"ambassador": (m) => m.ambassador,

	"org": (m) => m.org,

	"videoContents": (m) => m.videoContents,

	"campaignVideos": (m) => m.campaignVideos,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AmbassadorCampaign) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AmbassadorCampaign');
    }
    return propFunction as V? Function(AmbassadorCampaign);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AmbassadorCampaign.fromJson(JsonMap json) =>
      AmbassadorCampaign(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	ambassadorId: json['ambassadorId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	budget: json['budget'] as double?,
	actualSpend: json['actualSpend'] as double?,
	currency: json['currency'] as String?,
	status: json['status'] != null ? CampaignStatus.fromJson(json['status']) : null,
	targetReach: int.tryParse(json['targetReach'].toString()),
	actualReach: int.tryParse(json['actualReach'].toString()),
	impressions: int.tryParse(json['impressions'].toString()),
	clicks: int.tryParse(json['clicks'].toString()),
	conversions: int.tryParse(json['conversions'].toString()),
	conversionValue: json['conversionValue'] as double?,
	roi: json['roi']?.toDouble(),
	content: json['content'] as dynamic,
	platforms: json['platforms'] != null ? (json['platforms'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	ambassador: json['ambassador'] != null ? BrandAmbassador.fromJson(json['ambassador'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	videoContents: json['videoContents'] != null ? createModels<VideoContent>((json['videoContents'] as List).cast<JsonMap>(), VideoContent.fromJson) : null,
	campaignVideos: json['campaignVideos'] != null ? createModels<VideoContent>((json['campaignVideos'] as List).cast<JsonMap>(), VideoContent.fromJson) : null,
	$platformsCount: json['_count']?['platforms'] as int?,
	$videoContentsCount: json['_count']?['videoContents'] as int?,
	$campaignVideosCount: json['_count']?['campaignVideos'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AmbassadorCampaign copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? ambassadorId,
		Value<String?>? name,
		Value<String?>? description,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<double?>? budget,
		Value<double?>? actualSpend,
		Value<String?>? currency,
		Value<CampaignStatus?>? status,
		Value<int?>? targetReach,
		Value<int?>? actualReach,
		Value<int?>? impressions,
		Value<int?>? clicks,
		Value<int?>? conversions,
		Value<double?>? conversionValue,
		Value<double?>? roi,
		Value<dynamic>? content,
		Value<List<String>?>? platforms,
		Value<DateTime?>? deletedAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<BrandAmbassador?>? ambassador,
		Value<Organization?>? org,
		Value<List<VideoContent>?>? videoContents,
		Value<List<VideoContent>?>? campaignVideos,
		int? $platformsCount,
		int? $videoContentsCount,
		int? $campaignVideosCount,
        }) {
        return AmbassadorCampaign(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		ambassadorId: ambassadorId != null ? ambassadorId.value : this.ambassadorId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		budget: budget != null ? budget.value : this.budget,
		actualSpend: actualSpend != null ? actualSpend.value : this.actualSpend,
		currency: currency != null ? currency.value : this.currency,
		status: status != null ? status.value : this.status,
		targetReach: targetReach != null ? targetReach.value : this.targetReach,
		actualReach: actualReach != null ? actualReach.value : this.actualReach,
		impressions: impressions != null ? impressions.value : this.impressions,
		clicks: clicks != null ? clicks.value : this.clicks,
		conversions: conversions != null ? conversions.value : this.conversions,
		conversionValue: conversionValue != null ? conversionValue.value : this.conversionValue,
		roi: roi != null ? roi.value : this.roi,
		content: content != null ? content.value : this.content,
		platforms: platforms != null ? platforms.value : this.platforms,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		ambassador: ambassador != null ? ambassador.value : this.ambassador,
		org: org != null ? org.value : this.org,
		videoContents: videoContents != null ? videoContents.value : this.videoContents,
		campaignVideos: campaignVideos != null ? campaignVideos.value : this.campaignVideos,
		$platformsCount: $platformsCount ?? this.$platformsCount,
		$videoContentsCount: $videoContentsCount ?? this.$videoContentsCount,
		$campaignVideosCount: $campaignVideosCount ?? this.$campaignVideosCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AmbassadorCampaign copyWithInstanceValues(AmbassadorCampaign ambassadorCampaign) {
        return AmbassadorCampaign(
            id: ambassadorCampaign.id ?? id,
		orgId: ambassadorCampaign.orgId ?? orgId,
		ambassadorId: ambassadorCampaign.ambassadorId ?? ambassadorId,
		name: ambassadorCampaign.name ?? name,
		description: ambassadorCampaign.description ?? description,
		startDate: ambassadorCampaign.startDate ?? startDate,
		endDate: ambassadorCampaign.endDate ?? endDate,
		budget: ambassadorCampaign.budget ?? budget,
		actualSpend: ambassadorCampaign.actualSpend ?? actualSpend,
		currency: ambassadorCampaign.currency ?? currency,
		status: ambassadorCampaign.status ?? status,
		targetReach: ambassadorCampaign.targetReach ?? targetReach,
		actualReach: ambassadorCampaign.actualReach ?? actualReach,
		impressions: ambassadorCampaign.impressions ?? impressions,
		clicks: ambassadorCampaign.clicks ?? clicks,
		conversions: ambassadorCampaign.conversions ?? conversions,
		conversionValue: ambassadorCampaign.conversionValue ?? conversionValue,
		roi: ambassadorCampaign.roi ?? roi,
		content: ambassadorCampaign.content ?? content,
		platforms: ambassadorCampaign.platforms ?? platforms,
		deletedAt: ambassadorCampaign.deletedAt ?? deletedAt,
		createdAt: ambassadorCampaign.createdAt ?? createdAt,
		updatedAt: ambassadorCampaign.updatedAt ?? updatedAt,
		ambassador: ambassadorCampaign.ambassador ?? ambassador,
		org: ambassadorCampaign.org ?? org,
		videoContents: ambassadorCampaign.videoContents ?? videoContents,
		campaignVideos: ambassadorCampaign.campaignVideos ?? campaignVideos,
		$platformsCount: ambassadorCampaign.$platformsCount ?? $platformsCount,
		$videoContentsCount: ambassadorCampaign.$videoContentsCount ?? $videoContentsCount,
		$campaignVideosCount: ambassadorCampaign.$campaignVideosCount ?? $campaignVideosCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AmbassadorCampaign mergeWithInstanceValues(AmbassadorCampaign ambassadorCampaign) {
        return AmbassadorCampaign(
            id: ambassadorCampaign.$assignedFields.contains('id') ? ambassadorCampaign.id : id,
		orgId: ambassadorCampaign.$assignedFields.contains('orgId') ? ambassadorCampaign.orgId : orgId,
		ambassadorId: ambassadorCampaign.$assignedFields.contains('ambassadorId') ? ambassadorCampaign.ambassadorId : ambassadorId,
		name: ambassadorCampaign.$assignedFields.contains('name') ? ambassadorCampaign.name : name,
		description: ambassadorCampaign.$assignedFields.contains('description') ? ambassadorCampaign.description : description,
		startDate: ambassadorCampaign.$assignedFields.contains('startDate') ? ambassadorCampaign.startDate : startDate,
		endDate: ambassadorCampaign.$assignedFields.contains('endDate') ? ambassadorCampaign.endDate : endDate,
		budget: ambassadorCampaign.$assignedFields.contains('budget') ? ambassadorCampaign.budget : budget,
		actualSpend: ambassadorCampaign.$assignedFields.contains('actualSpend') ? ambassadorCampaign.actualSpend : actualSpend,
		currency: ambassadorCampaign.$assignedFields.contains('currency') ? ambassadorCampaign.currency : currency,
		status: ambassadorCampaign.$assignedFields.contains('status') ? ambassadorCampaign.status : status,
		targetReach: ambassadorCampaign.$assignedFields.contains('targetReach') ? ambassadorCampaign.targetReach : targetReach,
		actualReach: ambassadorCampaign.$assignedFields.contains('actualReach') ? ambassadorCampaign.actualReach : actualReach,
		impressions: ambassadorCampaign.$assignedFields.contains('impressions') ? ambassadorCampaign.impressions : impressions,
		clicks: ambassadorCampaign.$assignedFields.contains('clicks') ? ambassadorCampaign.clicks : clicks,
		conversions: ambassadorCampaign.$assignedFields.contains('conversions') ? ambassadorCampaign.conversions : conversions,
		conversionValue: ambassadorCampaign.$assignedFields.contains('conversionValue') ? ambassadorCampaign.conversionValue : conversionValue,
		roi: ambassadorCampaign.$assignedFields.contains('roi') ? ambassadorCampaign.roi : roi,
		content: ambassadorCampaign.$assignedFields.contains('content') ? ambassadorCampaign.content : content,
		platforms: ambassadorCampaign.$assignedFields.contains('platforms') ? ambassadorCampaign.platforms : platforms,
		deletedAt: ambassadorCampaign.$assignedFields.contains('deletedAt') ? ambassadorCampaign.deletedAt : deletedAt,
		createdAt: ambassadorCampaign.$assignedFields.contains('createdAt') ? ambassadorCampaign.createdAt : createdAt,
		updatedAt: ambassadorCampaign.$assignedFields.contains('updatedAt') ? ambassadorCampaign.updatedAt : updatedAt,
		ambassador: ambassadorCampaign.$assignedFields.contains('ambassador') ? ambassadorCampaign.ambassador : ambassador,
		org: ambassadorCampaign.$assignedFields.contains('org') ? ambassadorCampaign.org : org,
		videoContents: (ambassadorCampaign.$assignedFields.contains('videoContents') && ambassadorCampaign.videoContents != null) ? mergeModelLists(videoContents, ambassadorCampaign.videoContents) : videoContents,
		campaignVideos: (ambassadorCampaign.$assignedFields.contains('campaignVideos') && ambassadorCampaign.campaignVideos != null) ? mergeModelLists(campaignVideos, ambassadorCampaign.campaignVideos) : campaignVideos,
		$platformsCount: ambassadorCampaign.$platformsCount ?? $platformsCount,
		$videoContentsCount: ambassadorCampaign.$videoContentsCount ?? $videoContentsCount,
		$campaignVideosCount: ambassadorCampaign.$campaignVideosCount ?? $campaignVideosCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AmbassadorCampaign updateWithInstanceValues(AmbassadorCampaign ambassadorCampaign) {
        if (ambassadorCampaign.$assignedFields.contains('id')) { id = ambassadorCampaign.id; }
		if (ambassadorCampaign.$assignedFields.contains('orgId')) { orgId = ambassadorCampaign.orgId; }
		if (ambassadorCampaign.$assignedFields.contains('ambassadorId')) { ambassadorId = ambassadorCampaign.ambassadorId; }
		if (ambassadorCampaign.$assignedFields.contains('name')) { name = ambassadorCampaign.name; }
		if (ambassadorCampaign.$assignedFields.contains('description')) { description = ambassadorCampaign.description; }
		if (ambassadorCampaign.$assignedFields.contains('startDate')) { startDate = ambassadorCampaign.startDate; }
		if (ambassadorCampaign.$assignedFields.contains('endDate')) { endDate = ambassadorCampaign.endDate; }
		if (ambassadorCampaign.$assignedFields.contains('budget')) { budget = ambassadorCampaign.budget; }
		if (ambassadorCampaign.$assignedFields.contains('actualSpend')) { actualSpend = ambassadorCampaign.actualSpend; }
		if (ambassadorCampaign.$assignedFields.contains('currency')) { currency = ambassadorCampaign.currency; }
		if (ambassadorCampaign.$assignedFields.contains('status')) { status = ambassadorCampaign.status; }
		if (ambassadorCampaign.$assignedFields.contains('targetReach')) { targetReach = ambassadorCampaign.targetReach; }
		if (ambassadorCampaign.$assignedFields.contains('actualReach')) { actualReach = ambassadorCampaign.actualReach; }
		if (ambassadorCampaign.$assignedFields.contains('impressions')) { impressions = ambassadorCampaign.impressions; }
		if (ambassadorCampaign.$assignedFields.contains('clicks')) { clicks = ambassadorCampaign.clicks; }
		if (ambassadorCampaign.$assignedFields.contains('conversions')) { conversions = ambassadorCampaign.conversions; }
		if (ambassadorCampaign.$assignedFields.contains('conversionValue')) { conversionValue = ambassadorCampaign.conversionValue; }
		if (ambassadorCampaign.$assignedFields.contains('roi')) { roi = ambassadorCampaign.roi; }
		if (ambassadorCampaign.$assignedFields.contains('content')) { content = ambassadorCampaign.content; }
		if (ambassadorCampaign.$assignedFields.contains('platforms')) { platforms = ambassadorCampaign.platforms; }
		if (ambassadorCampaign.$assignedFields.contains('deletedAt')) { deletedAt = ambassadorCampaign.deletedAt; }
		if (ambassadorCampaign.$assignedFields.contains('createdAt')) { createdAt = ambassadorCampaign.createdAt; }
		if (ambassadorCampaign.$assignedFields.contains('updatedAt')) { updatedAt = ambassadorCampaign.updatedAt; }
		if (ambassadorCampaign.$assignedFields.contains('ambassador')) { ambassador = ambassadorCampaign.ambassador; }
		if (ambassadorCampaign.$assignedFields.contains('org')) { org = ambassadorCampaign.org; }
		if (ambassadorCampaign.$assignedFields.contains('videoContents') && ambassadorCampaign.videoContents != null) { videoContents = mergeModelLists(videoContents, ambassadorCampaign.videoContents); }
		if (ambassadorCampaign.$assignedFields.contains('campaignVideos') && ambassadorCampaign.campaignVideos != null) { campaignVideos = mergeModelLists(campaignVideos, ambassadorCampaign.campaignVideos); }
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
          ? {...?serializedTypes, 'AmbassadorCampaign'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(ambassadorId != null) 'ambassadorId': ambassadorId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(budget != null) 'budget': budget,
	if(actualSpend != null) 'actualSpend': actualSpend,
	if(currency != null) 'currency': currency,
	if(status != null) 'status': status?.toJson(),
	if(targetReach != null) 'targetReach': targetReach,
	if(actualReach != null) 'actualReach': actualReach,
	if(impressions != null) 'impressions': impressions,
	if(clicks != null) 'clicks': clicks,
	if(conversions != null) 'conversions': conversions,
	if(conversionValue != null) 'conversionValue': conversionValue,
	if(roi != null) 'roi': roi,
	if(content != null) 'content': content,
	if(platforms != null) 'platforms': platforms,
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(ambassador != null && (!preventCircularSerialization || !serializedModels.contains('BrandAmbassador'))) 'ambassador': ambassador?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(videoContents != null && (!preventCircularSerialization || !serializedModels.contains('VideoContent'))) 'videoContents': videoContents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(campaignVideos != null && (!preventCircularSerialization || !serializedModels.contains('VideoContent'))) 'campaignVideos': campaignVideos?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($platformsCount != null || $videoContentsCount != null || $campaignVideosCount != null) '_count': { 
		if ($platformsCount != null) 'platforms': $platformsCount, 
		if ($videoContentsCount != null) 'videoContents': $videoContentsCount, 
		if ($campaignVideosCount != null) 'campaignVideos': $campaignVideosCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AmbassadorCampaign &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    