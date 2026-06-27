import 'organization.dart';

class DocumentTemplate {
  final String id;
  final String orgId;
  final String name;
  final String type;
  final String? category;
  final String templateContent;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;

  const DocumentTemplate({
    required this.id,
    required this.orgId,
    required this.name,
    required this.type,
    this.category,
    required this.templateContent,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
  });

  factory DocumentTemplate.fromJson(Map<String, dynamic> json) {
    return DocumentTemplate(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      category: json['category'] as String?,
      templateContent: json['templateContent'] as String,
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
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
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
    };
  }

  DocumentTemplate copyWith({
    String? id,
    String? orgId,
    String? name,
    String? type,
    String? category,
    String? templateContent,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
  }) {
    return DocumentTemplate(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      type: type ?? this.type,
      category: category ?? this.category,
      templateContent: templateContent ?? this.templateContent,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
    );
  }
}
