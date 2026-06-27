import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UsageMetrics {
  final int propertiesUsed;
  final int listingsUsed;
  final int featuredUsed;
  final int aiTokensUsed;
  final int storageUsed;

  UsageMetrics({
    required this.propertiesUsed,
    required this.listingsUsed,
    required this.featuredUsed,
    required this.aiTokensUsed,
    required this.storageUsed,
  });

  factory UsageMetrics.fromJson(Map<String, dynamic> json) {
    return UsageMetrics(
      propertiesUsed: json['propertiesUsed'] ?? 0,
      listingsUsed: json['listingsUsed'] ?? 0,
      featuredUsed: json['featuredUsed'] ?? 0,
      aiTokensUsed: json['aiTokensUsed'] ?? 0,
      storageUsed: json['storageUsed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertiesUsed': propertiesUsed,
      'listingsUsed': listingsUsed,
      'featuredUsed': featuredUsed,
      'aiTokensUsed': aiTokensUsed,
      'storageUsed': storageUsed,
    };
  }
}
