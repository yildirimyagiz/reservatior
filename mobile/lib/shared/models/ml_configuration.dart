

class MlConfiguration {
  final String id;
  final bool enableAutoTagging;
  final double qualityThreshold;
  final bool enableMLFeatures;
  final int maxTagsPerImage;
  final String analysisMode;
  final List<String> allowedModels;
  final String? updatedBy;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MlConfiguration({
    required this.id,
    required this.enableAutoTagging,
    required this.qualityThreshold,
    required this.enableMLFeatures,
    required this.maxTagsPerImage,
    required this.analysisMode,
    this.allowedModels = const [],
    this.updatedBy,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MlConfiguration.fromJson(Map<String, dynamic> json) {
    return MlConfiguration(
      id: json['id'] as String,
      enableAutoTagging: json['enableAutoTagging'] as bool,
      qualityThreshold: (json['qualityThreshold'] as num).toDouble(),
      enableMLFeatures: json['enableMLFeatures'] as bool,
      maxTagsPerImage: json['maxTagsPerImage'] as int,
      analysisMode: json['analysisMode'] as String,
      allowedModels: (json['allowedModels'] as List<dynamic>?)?.cast<String>() ?? [],
      updatedBy: json['updatedBy'] as String?,
      version: json['version'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enableAutoTagging': enableAutoTagging,
      'qualityThreshold': qualityThreshold,
      'enableMLFeatures': enableMLFeatures,
      'maxTagsPerImage': maxTagsPerImage,
      'analysisMode': analysisMode,
      'allowedModels': allowedModels,
      'updatedBy': updatedBy,
      'version': version,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  MlConfiguration copyWith({
    String? id,
    bool? enableAutoTagging,
    double? qualityThreshold,
    bool? enableMLFeatures,
    int? maxTagsPerImage,
    String? analysisMode,
    List<String>? allowedModels,
    String? updatedBy,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MlConfiguration(
      id: id ?? this.id,
      enableAutoTagging: enableAutoTagging ?? this.enableAutoTagging,
      qualityThreshold: qualityThreshold ?? this.qualityThreshold,
      enableMLFeatures: enableMLFeatures ?? this.enableMLFeatures,
      maxTagsPerImage: maxTagsPerImage ?? this.maxTagsPerImage,
      analysisMode: analysisMode ?? this.analysisMode,
      allowedModels: allowedModels ?? this.allowedModels,
      updatedBy: updatedBy ?? this.updatedBy,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
