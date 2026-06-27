import 'organization.dart';

class AiSentimentAnalysis {
  final String id;
  final String? orgId;
  final String contentType;
  final String contentId;
  final String contentText;
  final String sentiment;
  final double sentimentScore;
  final double confidence;
  final DateTime analyzedAt;
  final DateTime createdAt;
  final Organization? org;

  const AiSentimentAnalysis({
    required this.id,
    this.orgId,
    required this.contentType,
    required this.contentId,
    required this.contentText,
    required this.sentiment,
    required this.sentimentScore,
    required this.confidence,
    required this.analyzedAt,
    required this.createdAt,
    this.org,
  });

  factory AiSentimentAnalysis.fromJson(Map<String, dynamic> json) {
    return AiSentimentAnalysis(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      contentType: json['contentType'] as String,
      contentId: json['contentId'] as String,
      contentText: json['contentText'] as String,
      sentiment: json['sentiment'] as String,
      sentimentScore: (json['sentimentScore'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      analyzedAt: DateTime.parse(json['analyzedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'contentType': contentType,
      'contentId': contentId,
      'contentText': contentText,
      'sentiment': sentiment,
      'sentimentScore': sentimentScore,
      'confidence': confidence,
      'analyzedAt': analyzedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  AiSentimentAnalysis copyWith({
    String? id,
    String? orgId,
    String? contentType,
    String? contentId,
    String? contentText,
    String? sentiment,
    double? sentimentScore,
    double? confidence,
    DateTime? analyzedAt,
    DateTime? createdAt,
    Organization? org,
  }) {
    return AiSentimentAnalysis(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      contentText: contentText ?? this.contentText,
      sentiment: sentiment ?? this.sentiment,
      sentimentScore: sentimentScore ?? this.sentimentScore,
      confidence: confidence ?? this.confidence,
      analyzedAt: analyzedAt ?? this.analyzedAt,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
    );
  }
}
