
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'ambassador_category.dart';
import 'ambassador_status.dart';
import 'organization.dart';
import 'ambassador_campaign.dart';
import 'ambassador_contract.dart';
import 'video_content.dart';


class BrandAmbassador implements PrismaModel<String, BrandAmbassador> , Id<String> {
    @override
String? id;
	String? orgId;
	String? fullName;
	String? emailCiphertext;
	String? phoneCiphertext;
	AmbassadorCategory? category;
	List<String>? platform;
	int? followerCount;
	double? engagementRate;
	DateTime? contractStart;
	DateTime? contractEnd;
	double? equityPercent;
	double? upfrontFee;
	String? currency;
	String? tier;
	AmbassadorStatus? status;
	String? agencyName;
	String? agencyContact;
	bool? ndaSigned;
	DateTime? ndaSignedAt;
	String? notes;
	DateTime? pitchSentAt;
	DateTime? respondedAt;
	DateTime? signedAt;
	int? actualReach;
	double? totalRoi;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	List<AmbassadorCampaign>? campaigns;
	List<AmbassadorContract>? contracts;
	List<VideoContent>? videoContents;
	int? $platformCount;
	int? $campaignsCount;
	int? $contractsCount;
	int? $videoContentsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    BrandAmbassador({ this.id,
	 this.orgId,
	 this.fullName,
	 this.emailCiphertext,
	 this.phoneCiphertext,
	 this.category,
	 this.platform,
	 this.followerCount,
	 this.engagementRate,
	 this.contractStart,
	 this.contractEnd,
	 this.equityPercent,
	 this.upfrontFee,
	 this.currency = "USD",
	 this.tier,
	 this.status = AmbassadorStatus.PROSPECT,
	 this.agencyName,
	 this.agencyContact,
	 this.ndaSigned = false,
	 this.ndaSignedAt,
	 this.notes,
	 this.pitchSentAt,
	 this.respondedAt,
	 this.signedAt,
	 this.actualReach,
	 this.totalRoi,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.campaigns,
	 this.contracts,
	 this.videoContents,
	this.$platformCount,
	this.$campaignsCount,
	this.$contractsCount,
	this.$videoContentsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<BrandAmbassador, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"fullName": (m) => m.fullName,

	"emailCiphertext": (m) => m.emailCiphertext,

	"phoneCiphertext": (m) => m.phoneCiphertext,

	"category": (m) => m.category,

	"platform": (m) => m.platform,

	"followerCount": (m) => m.followerCount,

	"engagementRate": (m) => m.engagementRate,

	"contractStart": (m) => m.contractStart,

	"contractEnd": (m) => m.contractEnd,

	"equityPercent": (m) => m.equityPercent,

	"upfrontFee": (m) => m.upfrontFee,

	"currency": (m) => m.currency,

	"tier": (m) => m.tier,

	"status": (m) => m.status,

	"agencyName": (m) => m.agencyName,

	"agencyContact": (m) => m.agencyContact,

	"ndaSigned": (m) => m.ndaSigned,

	"ndaSignedAt": (m) => m.ndaSignedAt,

	"notes": (m) => m.notes,

	"pitchSentAt": (m) => m.pitchSentAt,

	"respondedAt": (m) => m.respondedAt,

	"signedAt": (m) => m.signedAt,

	"actualReach": (m) => m.actualReach,

	"totalRoi": (m) => m.totalRoi,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"campaigns": (m) => m.campaigns,

	"contracts": (m) => m.contracts,

	"videoContents": (m) => m.videoContents,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(BrandAmbassador) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in BrandAmbassador');
    }
    return propFunction as V? Function(BrandAmbassador);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory BrandAmbassador.fromJson(JsonMap json) =>
      BrandAmbassador(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	fullName: json['fullName'] as String?,
	emailCiphertext: json['emailCiphertext'] as String?,
	phoneCiphertext: json['phoneCiphertext'] as String?,
	category: json['category'] != null ? AmbassadorCategory.fromJson(json['category']) : null,
	platform: json['platform'] != null ? (json['platform'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	followerCount: int.tryParse(json['followerCount'].toString()),
	engagementRate: json['engagementRate']?.toDouble(),
	contractStart: json['contractStart'] != null ? DateTime.parse(json['contractStart']) : null,
	contractEnd: json['contractEnd'] != null ? DateTime.parse(json['contractEnd']) : null,
	equityPercent: json['equityPercent']?.toDouble(),
	upfrontFee: json['upfrontFee'] as double?,
	currency: json['currency'] as String?,
	tier: json['tier'] as String?,
	status: json['status'] != null ? AmbassadorStatus.fromJson(json['status']) : null,
	agencyName: json['agencyName'] as String?,
	agencyContact: json['agencyContact'] as String?,
	ndaSigned: json['ndaSigned'] as bool?,
	ndaSignedAt: json['ndaSignedAt'] != null ? DateTime.parse(json['ndaSignedAt']) : null,
	notes: json['notes'] as String?,
	pitchSentAt: json['pitchSentAt'] != null ? DateTime.parse(json['pitchSentAt']) : null,
	respondedAt: json['respondedAt'] != null ? DateTime.parse(json['respondedAt']) : null,
	signedAt: json['signedAt'] != null ? DateTime.parse(json['signedAt']) : null,
	actualReach: int.tryParse(json['actualReach'].toString()),
	totalRoi: json['totalRoi'] as double?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	campaigns: json['campaigns'] != null ? createModels<AmbassadorCampaign>((json['campaigns'] as List).cast<JsonMap>(), AmbassadorCampaign.fromJson) : null,
	contracts: json['contracts'] != null ? createModels<AmbassadorContract>((json['contracts'] as List).cast<JsonMap>(), AmbassadorContract.fromJson) : null,
	videoContents: json['videoContents'] != null ? createModels<VideoContent>((json['videoContents'] as List).cast<JsonMap>(), VideoContent.fromJson) : null,
	$platformCount: json['_count']?['platform'] as int?,
	$campaignsCount: json['_count']?['campaigns'] as int?,
	$contractsCount: json['_count']?['contracts'] as int?,
	$videoContentsCount: json['_count']?['videoContents'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    BrandAmbassador copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? fullName,
		Value<String?>? emailCiphertext,
		Value<String?>? phoneCiphertext,
		Value<AmbassadorCategory?>? category,
		Value<List<String>?>? platform,
		Value<int?>? followerCount,
		Value<double?>? engagementRate,
		Value<DateTime?>? contractStart,
		Value<DateTime?>? contractEnd,
		Value<double?>? equityPercent,
		Value<double?>? upfrontFee,
		Value<String?>? currency,
		Value<String?>? tier,
		Value<AmbassadorStatus?>? status,
		Value<String?>? agencyName,
		Value<String?>? agencyContact,
		Value<bool?>? ndaSigned,
		Value<DateTime?>? ndaSignedAt,
		Value<String?>? notes,
		Value<DateTime?>? pitchSentAt,
		Value<DateTime?>? respondedAt,
		Value<DateTime?>? signedAt,
		Value<int?>? actualReach,
		Value<double?>? totalRoi,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<List<AmbassadorCampaign>?>? campaigns,
		Value<List<AmbassadorContract>?>? contracts,
		Value<List<VideoContent>?>? videoContents,
		int? $platformCount,
		int? $campaignsCount,
		int? $contractsCount,
		int? $videoContentsCount,
        }) {
        return BrandAmbassador(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		fullName: fullName != null ? fullName.value : this.fullName,
		emailCiphertext: emailCiphertext != null ? emailCiphertext.value : this.emailCiphertext,
		phoneCiphertext: phoneCiphertext != null ? phoneCiphertext.value : this.phoneCiphertext,
		category: category != null ? category.value : this.category,
		platform: platform != null ? platform.value : this.platform,
		followerCount: followerCount != null ? followerCount.value : this.followerCount,
		engagementRate: engagementRate != null ? engagementRate.value : this.engagementRate,
		contractStart: contractStart != null ? contractStart.value : this.contractStart,
		contractEnd: contractEnd != null ? contractEnd.value : this.contractEnd,
		equityPercent: equityPercent != null ? equityPercent.value : this.equityPercent,
		upfrontFee: upfrontFee != null ? upfrontFee.value : this.upfrontFee,
		currency: currency != null ? currency.value : this.currency,
		tier: tier != null ? tier.value : this.tier,
		status: status != null ? status.value : this.status,
		agencyName: agencyName != null ? agencyName.value : this.agencyName,
		agencyContact: agencyContact != null ? agencyContact.value : this.agencyContact,
		ndaSigned: ndaSigned != null ? ndaSigned.value : this.ndaSigned,
		ndaSignedAt: ndaSignedAt != null ? ndaSignedAt.value : this.ndaSignedAt,
		notes: notes != null ? notes.value : this.notes,
		pitchSentAt: pitchSentAt != null ? pitchSentAt.value : this.pitchSentAt,
		respondedAt: respondedAt != null ? respondedAt.value : this.respondedAt,
		signedAt: signedAt != null ? signedAt.value : this.signedAt,
		actualReach: actualReach != null ? actualReach.value : this.actualReach,
		totalRoi: totalRoi != null ? totalRoi.value : this.totalRoi,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		campaigns: campaigns != null ? campaigns.value : this.campaigns,
		contracts: contracts != null ? contracts.value : this.contracts,
		videoContents: videoContents != null ? videoContents.value : this.videoContents,
		$platformCount: $platformCount ?? this.$platformCount,
		$campaignsCount: $campaignsCount ?? this.$campaignsCount,
		$contractsCount: $contractsCount ?? this.$contractsCount,
		$videoContentsCount: $videoContentsCount ?? this.$videoContentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    BrandAmbassador copyWithInstanceValues(BrandAmbassador brandAmbassador) {
        return BrandAmbassador(
            id: brandAmbassador.id ?? id,
		orgId: brandAmbassador.orgId ?? orgId,
		fullName: brandAmbassador.fullName ?? fullName,
		emailCiphertext: brandAmbassador.emailCiphertext ?? emailCiphertext,
		phoneCiphertext: brandAmbassador.phoneCiphertext ?? phoneCiphertext,
		category: brandAmbassador.category ?? category,
		platform: brandAmbassador.platform ?? platform,
		followerCount: brandAmbassador.followerCount ?? followerCount,
		engagementRate: brandAmbassador.engagementRate ?? engagementRate,
		contractStart: brandAmbassador.contractStart ?? contractStart,
		contractEnd: brandAmbassador.contractEnd ?? contractEnd,
		equityPercent: brandAmbassador.equityPercent ?? equityPercent,
		upfrontFee: brandAmbassador.upfrontFee ?? upfrontFee,
		currency: brandAmbassador.currency ?? currency,
		tier: brandAmbassador.tier ?? tier,
		status: brandAmbassador.status ?? status,
		agencyName: brandAmbassador.agencyName ?? agencyName,
		agencyContact: brandAmbassador.agencyContact ?? agencyContact,
		ndaSigned: brandAmbassador.ndaSigned ?? ndaSigned,
		ndaSignedAt: brandAmbassador.ndaSignedAt ?? ndaSignedAt,
		notes: brandAmbassador.notes ?? notes,
		pitchSentAt: brandAmbassador.pitchSentAt ?? pitchSentAt,
		respondedAt: brandAmbassador.respondedAt ?? respondedAt,
		signedAt: brandAmbassador.signedAt ?? signedAt,
		actualReach: brandAmbassador.actualReach ?? actualReach,
		totalRoi: brandAmbassador.totalRoi ?? totalRoi,
		createdAt: brandAmbassador.createdAt ?? createdAt,
		updatedAt: brandAmbassador.updatedAt ?? updatedAt,
		deletedAt: brandAmbassador.deletedAt ?? deletedAt,
		org: brandAmbassador.org ?? org,
		campaigns: brandAmbassador.campaigns ?? campaigns,
		contracts: brandAmbassador.contracts ?? contracts,
		videoContents: brandAmbassador.videoContents ?? videoContents,
		$platformCount: brandAmbassador.$platformCount ?? $platformCount,
		$campaignsCount: brandAmbassador.$campaignsCount ?? $campaignsCount,
		$contractsCount: brandAmbassador.$contractsCount ?? $contractsCount,
		$videoContentsCount: brandAmbassador.$videoContentsCount ?? $videoContentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    BrandAmbassador mergeWithInstanceValues(BrandAmbassador brandAmbassador) {
        return BrandAmbassador(
            id: brandAmbassador.$assignedFields.contains('id') ? brandAmbassador.id : id,
		orgId: brandAmbassador.$assignedFields.contains('orgId') ? brandAmbassador.orgId : orgId,
		fullName: brandAmbassador.$assignedFields.contains('fullName') ? brandAmbassador.fullName : fullName,
		emailCiphertext: brandAmbassador.$assignedFields.contains('emailCiphertext') ? brandAmbassador.emailCiphertext : emailCiphertext,
		phoneCiphertext: brandAmbassador.$assignedFields.contains('phoneCiphertext') ? brandAmbassador.phoneCiphertext : phoneCiphertext,
		category: brandAmbassador.$assignedFields.contains('category') ? brandAmbassador.category : category,
		platform: brandAmbassador.$assignedFields.contains('platform') ? brandAmbassador.platform : platform,
		followerCount: brandAmbassador.$assignedFields.contains('followerCount') ? brandAmbassador.followerCount : followerCount,
		engagementRate: brandAmbassador.$assignedFields.contains('engagementRate') ? brandAmbassador.engagementRate : engagementRate,
		contractStart: brandAmbassador.$assignedFields.contains('contractStart') ? brandAmbassador.contractStart : contractStart,
		contractEnd: brandAmbassador.$assignedFields.contains('contractEnd') ? brandAmbassador.contractEnd : contractEnd,
		equityPercent: brandAmbassador.$assignedFields.contains('equityPercent') ? brandAmbassador.equityPercent : equityPercent,
		upfrontFee: brandAmbassador.$assignedFields.contains('upfrontFee') ? brandAmbassador.upfrontFee : upfrontFee,
		currency: brandAmbassador.$assignedFields.contains('currency') ? brandAmbassador.currency : currency,
		tier: brandAmbassador.$assignedFields.contains('tier') ? brandAmbassador.tier : tier,
		status: brandAmbassador.$assignedFields.contains('status') ? brandAmbassador.status : status,
		agencyName: brandAmbassador.$assignedFields.contains('agencyName') ? brandAmbassador.agencyName : agencyName,
		agencyContact: brandAmbassador.$assignedFields.contains('agencyContact') ? brandAmbassador.agencyContact : agencyContact,
		ndaSigned: brandAmbassador.$assignedFields.contains('ndaSigned') ? brandAmbassador.ndaSigned : ndaSigned,
		ndaSignedAt: brandAmbassador.$assignedFields.contains('ndaSignedAt') ? brandAmbassador.ndaSignedAt : ndaSignedAt,
		notes: brandAmbassador.$assignedFields.contains('notes') ? brandAmbassador.notes : notes,
		pitchSentAt: brandAmbassador.$assignedFields.contains('pitchSentAt') ? brandAmbassador.pitchSentAt : pitchSentAt,
		respondedAt: brandAmbassador.$assignedFields.contains('respondedAt') ? brandAmbassador.respondedAt : respondedAt,
		signedAt: brandAmbassador.$assignedFields.contains('signedAt') ? brandAmbassador.signedAt : signedAt,
		actualReach: brandAmbassador.$assignedFields.contains('actualReach') ? brandAmbassador.actualReach : actualReach,
		totalRoi: brandAmbassador.$assignedFields.contains('totalRoi') ? brandAmbassador.totalRoi : totalRoi,
		createdAt: brandAmbassador.$assignedFields.contains('createdAt') ? brandAmbassador.createdAt : createdAt,
		updatedAt: brandAmbassador.$assignedFields.contains('updatedAt') ? brandAmbassador.updatedAt : updatedAt,
		deletedAt: brandAmbassador.$assignedFields.contains('deletedAt') ? brandAmbassador.deletedAt : deletedAt,
		org: brandAmbassador.$assignedFields.contains('org') ? brandAmbassador.org : org,
		campaigns: (brandAmbassador.$assignedFields.contains('campaigns') && brandAmbassador.campaigns != null) ? mergeModelLists(campaigns, brandAmbassador.campaigns) : campaigns,
		contracts: (brandAmbassador.$assignedFields.contains('contracts') && brandAmbassador.contracts != null) ? mergeModelLists(contracts, brandAmbassador.contracts) : contracts,
		videoContents: (brandAmbassador.$assignedFields.contains('videoContents') && brandAmbassador.videoContents != null) ? mergeModelLists(videoContents, brandAmbassador.videoContents) : videoContents,
		$platformCount: brandAmbassador.$platformCount ?? $platformCount,
		$campaignsCount: brandAmbassador.$campaignsCount ?? $campaignsCount,
		$contractsCount: brandAmbassador.$contractsCount ?? $contractsCount,
		$videoContentsCount: brandAmbassador.$videoContentsCount ?? $videoContentsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    BrandAmbassador updateWithInstanceValues(BrandAmbassador brandAmbassador) {
        if (brandAmbassador.$assignedFields.contains('id')) { id = brandAmbassador.id; }
		if (brandAmbassador.$assignedFields.contains('orgId')) { orgId = brandAmbassador.orgId; }
		if (brandAmbassador.$assignedFields.contains('fullName')) { fullName = brandAmbassador.fullName; }
		if (brandAmbassador.$assignedFields.contains('emailCiphertext')) { emailCiphertext = brandAmbassador.emailCiphertext; }
		if (brandAmbassador.$assignedFields.contains('phoneCiphertext')) { phoneCiphertext = brandAmbassador.phoneCiphertext; }
		if (brandAmbassador.$assignedFields.contains('category')) { category = brandAmbassador.category; }
		if (brandAmbassador.$assignedFields.contains('platform')) { platform = brandAmbassador.platform; }
		if (brandAmbassador.$assignedFields.contains('followerCount')) { followerCount = brandAmbassador.followerCount; }
		if (brandAmbassador.$assignedFields.contains('engagementRate')) { engagementRate = brandAmbassador.engagementRate; }
		if (brandAmbassador.$assignedFields.contains('contractStart')) { contractStart = brandAmbassador.contractStart; }
		if (brandAmbassador.$assignedFields.contains('contractEnd')) { contractEnd = brandAmbassador.contractEnd; }
		if (brandAmbassador.$assignedFields.contains('equityPercent')) { equityPercent = brandAmbassador.equityPercent; }
		if (brandAmbassador.$assignedFields.contains('upfrontFee')) { upfrontFee = brandAmbassador.upfrontFee; }
		if (brandAmbassador.$assignedFields.contains('currency')) { currency = brandAmbassador.currency; }
		if (brandAmbassador.$assignedFields.contains('tier')) { tier = brandAmbassador.tier; }
		if (brandAmbassador.$assignedFields.contains('status')) { status = brandAmbassador.status; }
		if (brandAmbassador.$assignedFields.contains('agencyName')) { agencyName = brandAmbassador.agencyName; }
		if (brandAmbassador.$assignedFields.contains('agencyContact')) { agencyContact = brandAmbassador.agencyContact; }
		if (brandAmbassador.$assignedFields.contains('ndaSigned')) { ndaSigned = brandAmbassador.ndaSigned; }
		if (brandAmbassador.$assignedFields.contains('ndaSignedAt')) { ndaSignedAt = brandAmbassador.ndaSignedAt; }
		if (brandAmbassador.$assignedFields.contains('notes')) { notes = brandAmbassador.notes; }
		if (brandAmbassador.$assignedFields.contains('pitchSentAt')) { pitchSentAt = brandAmbassador.pitchSentAt; }
		if (brandAmbassador.$assignedFields.contains('respondedAt')) { respondedAt = brandAmbassador.respondedAt; }
		if (brandAmbassador.$assignedFields.contains('signedAt')) { signedAt = brandAmbassador.signedAt; }
		if (brandAmbassador.$assignedFields.contains('actualReach')) { actualReach = brandAmbassador.actualReach; }
		if (brandAmbassador.$assignedFields.contains('totalRoi')) { totalRoi = brandAmbassador.totalRoi; }
		if (brandAmbassador.$assignedFields.contains('createdAt')) { createdAt = brandAmbassador.createdAt; }
		if (brandAmbassador.$assignedFields.contains('updatedAt')) { updatedAt = brandAmbassador.updatedAt; }
		if (brandAmbassador.$assignedFields.contains('deletedAt')) { deletedAt = brandAmbassador.deletedAt; }
		if (brandAmbassador.$assignedFields.contains('org')) { org = brandAmbassador.org; }
		if (brandAmbassador.$assignedFields.contains('campaigns') && brandAmbassador.campaigns != null) { campaigns = mergeModelLists(campaigns, brandAmbassador.campaigns); }
		if (brandAmbassador.$assignedFields.contains('contracts') && brandAmbassador.contracts != null) { contracts = mergeModelLists(contracts, brandAmbassador.contracts); }
		if (brandAmbassador.$assignedFields.contains('videoContents') && brandAmbassador.videoContents != null) { videoContents = mergeModelLists(videoContents, brandAmbassador.videoContents); }
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
          ? {...?serializedTypes, 'BrandAmbassador'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(fullName != null) 'fullName': fullName,
	if(emailCiphertext != null) 'emailCiphertext': emailCiphertext,
	if(phoneCiphertext != null) 'phoneCiphertext': phoneCiphertext,
	if(category != null) 'category': category?.toJson(),
	if(platform != null) 'platform': platform,
	if(followerCount != null) 'followerCount': followerCount,
	if(engagementRate != null) 'engagementRate': engagementRate,
	if(contractStart != null) 'contractStart': contractStart?.toIso8601String(),
	if(contractEnd != null) 'contractEnd': contractEnd?.toIso8601String(),
	if(equityPercent != null) 'equityPercent': equityPercent,
	if(upfrontFee != null) 'upfrontFee': upfrontFee,
	if(currency != null) 'currency': currency,
	if(tier != null) 'tier': tier,
	if(status != null) 'status': status?.toJson(),
	if(agencyName != null) 'agencyName': agencyName,
	if(agencyContact != null) 'agencyContact': agencyContact,
	if(ndaSigned != null) 'ndaSigned': ndaSigned,
	if(ndaSignedAt != null) 'ndaSignedAt': ndaSignedAt?.toIso8601String(),
	if(notes != null) 'notes': notes,
	if(pitchSentAt != null) 'pitchSentAt': pitchSentAt?.toIso8601String(),
	if(respondedAt != null) 'respondedAt': respondedAt?.toIso8601String(),
	if(signedAt != null) 'signedAt': signedAt?.toIso8601String(),
	if(actualReach != null) 'actualReach': actualReach,
	if(totalRoi != null) 'totalRoi': totalRoi,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(campaigns != null && (!preventCircularSerialization || !serializedModels.contains('AmbassadorCampaign'))) 'campaigns': campaigns?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(contracts != null && (!preventCircularSerialization || !serializedModels.contains('AmbassadorContract'))) 'contracts': contracts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(videoContents != null && (!preventCircularSerialization || !serializedModels.contains('VideoContent'))) 'videoContents': videoContents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($platformCount != null || $campaignsCount != null || $contractsCount != null || $videoContentsCount != null) '_count': { 
		if ($platformCount != null) 'platform': $platformCount, 
		if ($campaignsCount != null) 'campaigns': $campaignsCount, 
		if ($contractsCount != null) 'contracts': $contractsCount, 
		if ($videoContentsCount != null) 'videoContents': $videoContentsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is BrandAmbassador &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    