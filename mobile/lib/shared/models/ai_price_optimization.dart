import 'listing.dart';
import 'organization.dart';

class AiPriceOptimization {
  final String id;
  final String? orgId;
  final String listingId;
  final double currentPrice;
  final double recommendedPrice;
  final double confidence;
  final DateTime generatedAt;
  final bool isApplied;
  final DateTime? appliedAt;
  final DateTime createdAt;
  final Listing listing;
  final Organization? org;

  const AiPriceOptimization({
    required this.id,
    this.orgId,
    required this.listingId,
    required this.currentPrice,
    required this.recommendedPrice,
    required this.confidence,
    required this.generatedAt,
    required this.isApplied,
    this.appliedAt,
    required this.createdAt,
    required this.listing,
    this.org,
  });

  factory AiPriceOptimization.fromJson(Map<String, dynamic> json) {
    return AiPriceOptimization(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      listingId: json['listingId'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      recommendedPrice: (json['recommendedPrice'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      isApplied: json['isApplied'] as bool,
      appliedAt: json['appliedAt'] != null ? DateTime.parse(json['appliedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'currentPrice': currentPrice,
      'recommendedPrice': recommendedPrice,
      'confidence': confidence,
      'generatedAt': generatedAt.toIso8601String(),
      'isApplied': isApplied,
      'appliedAt': appliedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'listing': listing.toJson(),
      'org': org?.toJson(),
    };
  }

  AiPriceOptimization copyWith({
    String? id,
    String? orgId,
    String? listingId,
    double? currentPrice,
    double? recommendedPrice,
    double? confidence,
    DateTime? generatedAt,
    bool? isApplied,
    DateTime? appliedAt,
    DateTime? createdAt,
    Listing? listing,
    Organization? org,
  }) {
    return AiPriceOptimization(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      currentPrice: currentPrice ?? this.currentPrice,
      recommendedPrice: recommendedPrice ?? this.recommendedPrice,
      confidence: confidence ?? this.confidence,
      generatedAt: generatedAt ?? this.generatedAt,
      isApplied: isApplied ?? this.isApplied,
      appliedAt: appliedAt ?? this.appliedAt,
      createdAt: createdAt ?? this.createdAt,
      listing: listing ?? this.listing,
      org: org ?? this.org,
    );
  }
}
