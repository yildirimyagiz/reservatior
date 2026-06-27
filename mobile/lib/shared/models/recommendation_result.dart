import 'organization.dart';
import 'user_financial_profile.dart';

class RecommendationResult {
  final String id;
  final String profileId;
  final String orgId;
  final String? listingId;
  final int score;
  final String explanation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final UserFinancialProfile profile;

  const RecommendationResult({
    required this.id,
    required this.profileId,
    required this.orgId,
    this.listingId,
    required this.score,
    required this.explanation,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.profile,
  });

  factory RecommendationResult.fromJson(Map<String, dynamic> json) {
    return RecommendationResult(
      id: json['id'] as String,
      profileId: json['profileId'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String?,
      score: json['score'] as int,
      explanation: json['explanation'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      profile: UserFinancialProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileId': profileId,
      'orgId': orgId,
      'listingId': listingId,
      'score': score,
      'explanation': explanation,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'profile': profile.toJson(),
    };
  }

  RecommendationResult copyWith({
    String? id,
    String? profileId,
    String? orgId,
    String? listingId,
    int? score,
    String? explanation,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    UserFinancialProfile? profile,
  }) {
    return RecommendationResult(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      score: score ?? this.score,
      explanation: explanation ?? this.explanation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      profile: profile ?? this.profile,
    );
  }
}
