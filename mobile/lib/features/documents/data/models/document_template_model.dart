import '../../domain/entities/document_template.dart';

// ── Document Template Model
// Document Template entity'si için data model

class DocumentTemplateModel {
  final String? id;
  final String? orgId;
  final String? name;
  final String? type;
  final String? category;
  final String? templateContent;
  final dynamic variables;
  final bool? isActive;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const DocumentTemplateModel({
    this.id,
    this.orgId,
    this.name,
    this.type,
    this.category,
    this.templateContent,
    this.variables,
    this.isActive,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DocumentTemplateModel.fromJson(Map<String, dynamic> json) {
    return DocumentTemplateModel(
      id: json['id'] as String?,
      orgId: json['orgId'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      templateContent: json['templateContent'] as String?,
      variables: json['variables'],
      isActive: json['isActive'] as bool?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
      deletedAt: json['deletedAt'] != null 
          ? DateTime.parse(json['deletedAt'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'type': type,
      'category': category,
      'templateContent': templateContent,
      'variables': variables,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  DocumentTemplateModel copyWith({
    String? id,
    String? orgId,
    String? name,
    String? type,
    String? category,
    String? templateContent,
    dynamic variables,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return DocumentTemplateModel(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      type: type ?? this.type,
      category: category ?? this.category,
      templateContent: templateContent ?? this.templateContent,
      variables: variables ?? this.variables,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  static TemplateType? _parseTemplateType(String? type) {
    if (type == null) return null;
    try {
      return TemplateType.values.firstWhere((e) => e.name == type);
    } catch (e) {
      return null;
    }
  }

  static TemplateCategory? _parseTemplateCategory(String? category) {
    if (category == null) return null;
    try {
      return TemplateCategory.values.firstWhere((e) => e.name == category);
    } catch (e) {
      return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DocumentTemplateModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'DocumentTemplateModel(id: $id, name: $name, type: $type)';
  }
}
