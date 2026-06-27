class AiVideoGeneration {
  final String id;
  final String propertyId;
  final String? listingId;
  final String videoUrl;
  final String? thumbnailUrl;
  final String? caption;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;

  AiVideoGeneration({
    required this.id,
    required this.propertyId,
    this.listingId,
    required this.videoUrl,
    this.thumbnailUrl,
    this.caption,
    this.metadata,
    required this.createdAt,
  });

  factory AiVideoGeneration.fromJson(Map<String, dynamic> json) {
    return AiVideoGeneration(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      caption: json['caption'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'listingId': listingId,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'caption': caption,
      'metadata': metadata,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
