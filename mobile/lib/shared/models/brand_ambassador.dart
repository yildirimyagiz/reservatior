import 'package:reservatior/shared/enums/ambassador_category.dart';
import 'package:reservatior/shared/enums/ambassador_status.dart';
import 'ambassador_campaign.dart';
import 'ambassador_contract.dart';
import 'organization.dart';
import 'video_content.dart';

class BrandAmbassador {
  final String id;
  final String orgId;
  final String fullName;
  final String? emailCiphertext;
  final String? phoneCiphertext;
  final AmbassadorCategory category;
  final List<String> platform;
  final int? followerCount;
  final double? engagementRate;
  final DateTime? contractStart;
  final DateTime? contractEnd;
  final double? equityPercent;
  final double? upfrontFee;
  final String currency;
  final String? tier;
  final AmbassadorStatus status;
  final String? agencyName;
  final String? agencyContact;
  final bool ndaSigned;
  final DateTime? ndaSignedAt;
  final String? notes;
  final DateTime? pitchSentAt;
  final DateTime? respondedAt;
  final DateTime? signedAt;
  final int? actualReach;
  final double? totalRoi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final List<AmbassadorCampaign> campaigns;
  final List<AmbassadorContract> contracts;
  final List<VideoContent> videoContents;

  const BrandAmbassador({
    required this.id,
    required this.orgId,
    required this.fullName,
    this.emailCiphertext,
    this.phoneCiphertext,
    required this.category,
    this.platform = const [],
    this.followerCount,
    this.engagementRate,
    this.contractStart,
    this.contractEnd,
    this.equityPercent,
    this.upfrontFee,
    required this.currency,
    this.tier,
    required this.status,
    this.agencyName,
    this.agencyContact,
    required this.ndaSigned,
    this.ndaSignedAt,
    this.notes,
    this.pitchSentAt,
    this.respondedAt,
    this.signedAt,
    this.actualReach,
    this.totalRoi,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.campaigns = const [],
    this.contracts = const [],
    this.videoContents = const [],
  });

  factory BrandAmbassador.fromJson(Map<String, dynamic> json) {
    return BrandAmbassador(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      fullName: json['fullName'] as String,
      emailCiphertext: json['emailCiphertext'] as String?,
      phoneCiphertext: json['phoneCiphertext'] as String?,
      category: AmbassadorCategory.values.firstWhere((v) => v.name == json['category']),
      platform: (json['platform'] as List<dynamic>?)?.cast<String>() ?? [],
      followerCount: json['followerCount'] as int?,
      engagementRate: (json['engagementRate'] as num?)?.toDouble(),
      contractStart: json['contractStart'] != null ? DateTime.parse(json['contractStart'] as String) : null,
      contractEnd: json['contractEnd'] != null ? DateTime.parse(json['contractEnd'] as String) : null,
      equityPercent: (json['equityPercent'] as num?)?.toDouble(),
      upfrontFee: (json['upfrontFee'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      tier: json['tier'] as String?,
      status: AmbassadorStatus.values.firstWhere((v) => v.name == json['status']),
      agencyName: json['agencyName'] as String?,
      agencyContact: json['agencyContact'] as String?,
      ndaSigned: json['ndaSigned'] as bool,
      ndaSignedAt: json['ndaSignedAt'] != null ? DateTime.parse(json['ndaSignedAt'] as String) : null,
      notes: json['notes'] as String?,
      pitchSentAt: json['pitchSentAt'] != null ? DateTime.parse(json['pitchSentAt'] as String) : null,
      respondedAt: json['respondedAt'] != null ? DateTime.parse(json['respondedAt'] as String) : null,
      signedAt: json['signedAt'] != null ? DateTime.parse(json['signedAt'] as String) : null,
      actualReach: json['actualReach'] as int?,
      totalRoi: (json['totalRoi'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      campaigns: (json['campaigns'] as List<dynamic>?)?.map((e) => AmbassadorCampaign.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      contracts: (json['contracts'] as List<dynamic>?)?.map((e) => AmbassadorContract.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      videoContents: (json['videoContents'] as List<dynamic>?)?.map((e) => VideoContent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'fullName': fullName,
      'emailCiphertext': emailCiphertext,
      'phoneCiphertext': phoneCiphertext,
      'category': category.name,
      'platform': platform,
      'followerCount': followerCount,
      'engagementRate': engagementRate,
      'contractStart': contractStart?.toIso8601String(),
      'contractEnd': contractEnd?.toIso8601String(),
      'equityPercent': equityPercent,
      'upfrontFee': upfrontFee,
      'currency': currency,
      'tier': tier,
      'status': status.name,
      'agencyName': agencyName,
      'agencyContact': agencyContact,
      'ndaSigned': ndaSigned,
      'ndaSignedAt': ndaSignedAt?.toIso8601String(),
      'notes': notes,
      'pitchSentAt': pitchSentAt?.toIso8601String(),
      'respondedAt': respondedAt?.toIso8601String(),
      'signedAt': signedAt?.toIso8601String(),
      'actualReach': actualReach,
      'totalRoi': totalRoi,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'campaigns': campaigns.map((e) => e.toJson()).toList(),
      'contracts': contracts.map((e) => e.toJson()).toList(),
      'videoContents': videoContents.map((e) => e.toJson()).toList(),
    };
  }

  BrandAmbassador copyWith({
    String? id,
    String? orgId,
    String? fullName,
    String? emailCiphertext,
    String? phoneCiphertext,
    AmbassadorCategory? category,
    List<String>? platform,
    int? followerCount,
    double? engagementRate,
    DateTime? contractStart,
    DateTime? contractEnd,
    double? equityPercent,
    double? upfrontFee,
    String? currency,
    String? tier,
    AmbassadorStatus? status,
    String? agencyName,
    String? agencyContact,
    bool? ndaSigned,
    DateTime? ndaSignedAt,
    String? notes,
    DateTime? pitchSentAt,
    DateTime? respondedAt,
    DateTime? signedAt,
    int? actualReach,
    double? totalRoi,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    List<AmbassadorCampaign>? campaigns,
    List<AmbassadorContract>? contracts,
    List<VideoContent>? videoContents,
  }) {
    return BrandAmbassador(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      fullName: fullName ?? this.fullName,
      emailCiphertext: emailCiphertext ?? this.emailCiphertext,
      phoneCiphertext: phoneCiphertext ?? this.phoneCiphertext,
      category: category ?? this.category,
      platform: platform ?? this.platform,
      followerCount: followerCount ?? this.followerCount,
      engagementRate: engagementRate ?? this.engagementRate,
      contractStart: contractStart ?? this.contractStart,
      contractEnd: contractEnd ?? this.contractEnd,
      equityPercent: equityPercent ?? this.equityPercent,
      upfrontFee: upfrontFee ?? this.upfrontFee,
      currency: currency ?? this.currency,
      tier: tier ?? this.tier,
      status: status ?? this.status,
      agencyName: agencyName ?? this.agencyName,
      agencyContact: agencyContact ?? this.agencyContact,
      ndaSigned: ndaSigned ?? this.ndaSigned,
      ndaSignedAt: ndaSignedAt ?? this.ndaSignedAt,
      notes: notes ?? this.notes,
      pitchSentAt: pitchSentAt ?? this.pitchSentAt,
      respondedAt: respondedAt ?? this.respondedAt,
      signedAt: signedAt ?? this.signedAt,
      actualReach: actualReach ?? this.actualReach,
      totalRoi: totalRoi ?? this.totalRoi,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      campaigns: campaigns ?? this.campaigns,
      contracts: contracts ?? this.contracts,
      videoContents: videoContents ?? this.videoContents,
    );
  }
}
