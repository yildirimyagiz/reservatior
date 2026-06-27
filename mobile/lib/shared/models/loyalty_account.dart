import 'package:reservatior/shared/enums/loyalty_tier.dart';
import 'organization.dart';
import 'user.dart';

class LoyaltyAccount {
  final String id;
  final String orgId;
  final String userId;
  final String name;
  final String? description;
  final double pointsPerDollar;
  final int? pointsExpiryDays;
  final bool tiersEnabled;
  final int bronzeThreshold;
  final int silverThreshold;
  final int goldThreshold;
  final int platinumThreshold;
  final int diamondThreshold;
  final int currentPoints;
  final LoyaltyTier currentTier;
  final int totalEarned;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;
  final User user;

  const LoyaltyAccount({
    required this.id,
    required this.orgId,
    required this.userId,
    required this.name,
    this.description,
    required this.pointsPerDollar,
    this.pointsExpiryDays,
    required this.tiersEnabled,
    required this.bronzeThreshold,
    required this.silverThreshold,
    required this.goldThreshold,
    required this.platinumThreshold,
    required this.diamondThreshold,
    required this.currentPoints,
    required this.currentTier,
    required this.totalEarned,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
    required this.user,
  });

  factory LoyaltyAccount.fromJson(Map<String, dynamic> json) {
    return LoyaltyAccount(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      pointsPerDollar: (json['pointsPerDollar'] as num).toDouble(),
      pointsExpiryDays: json['pointsExpiryDays'] as int?,
      tiersEnabled: json['tiersEnabled'] as bool,
      bronzeThreshold: json['bronzeThreshold'] as int,
      silverThreshold: json['silverThreshold'] as int,
      goldThreshold: json['goldThreshold'] as int,
      platinumThreshold: json['platinumThreshold'] as int,
      diamondThreshold: json['diamondThreshold'] as int,
      currentPoints: json['currentPoints'] as int,
      currentTier: LoyaltyTier.values.firstWhere((v) => v.name == json['currentTier']),
      totalEarned: json['totalEarned'] as int,
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'name': name,
      'description': description,
      'pointsPerDollar': pointsPerDollar,
      'pointsExpiryDays': pointsExpiryDays,
      'tiersEnabled': tiersEnabled,
      'bronzeThreshold': bronzeThreshold,
      'silverThreshold': silverThreshold,
      'goldThreshold': goldThreshold,
      'platinumThreshold': platinumThreshold,
      'diamondThreshold': diamondThreshold,
      'currentPoints': currentPoints,
      'currentTier': currentTier.name,
      'totalEarned': totalEarned,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
      'user': user.toJson(),
    };
  }

  LoyaltyAccount copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? name,
    String? description,
    double? pointsPerDollar,
    int? pointsExpiryDays,
    bool? tiersEnabled,
    int? bronzeThreshold,
    int? silverThreshold,
    int? goldThreshold,
    int? platinumThreshold,
    int? diamondThreshold,
    int? currentPoints,
    LoyaltyTier? currentTier,
    int? totalEarned,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    User? user,
  }) {
    return LoyaltyAccount(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      pointsPerDollar: pointsPerDollar ?? this.pointsPerDollar,
      pointsExpiryDays: pointsExpiryDays ?? this.pointsExpiryDays,
      tiersEnabled: tiersEnabled ?? this.tiersEnabled,
      bronzeThreshold: bronzeThreshold ?? this.bronzeThreshold,
      silverThreshold: silverThreshold ?? this.silverThreshold,
      goldThreshold: goldThreshold ?? this.goldThreshold,
      platinumThreshold: platinumThreshold ?? this.platinumThreshold,
      diamondThreshold: diamondThreshold ?? this.diamondThreshold,
      currentPoints: currentPoints ?? this.currentPoints,
      currentTier: currentTier ?? this.currentTier,
      totalEarned: totalEarned ?? this.totalEarned,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
