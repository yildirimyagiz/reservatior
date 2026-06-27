

class MlModel {
  final String id;
  final String modelName;
  final String modelType;
  final String version;
  final double? accuracy;
  final String? modelPath;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MlModel({
    required this.id,
    required this.modelName,
    required this.modelType,
    required this.version,
    this.accuracy,
    this.modelPath,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MlModel.fromJson(Map<String, dynamic> json) {
    return MlModel(
      id: json['id'] as String,
      modelName: json['modelName'] as String,
      modelType: json['modelType'] as String,
      version: json['version'] as String,
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      modelPath: json['modelPath'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelName': modelName,
      'modelType': modelType,
      'version': version,
      'accuracy': accuracy,
      'modelPath': modelPath,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  MlModel copyWith({
    String? id,
    String? modelName,
    String? modelType,
    String? version,
    double? accuracy,
    String? modelPath,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MlModel(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
      modelType: modelType ?? this.modelType,
      version: version ?? this.version,
      accuracy: accuracy ?? this.accuracy,
      modelPath: modelPath ?? this.modelPath,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
