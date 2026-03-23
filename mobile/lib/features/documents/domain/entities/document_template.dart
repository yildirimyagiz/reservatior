// ── Document Template Entity
// Document şablonları için entity

class DocumentTemplate {
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

  const DocumentTemplate({
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

  DocumentTemplate copyWith({
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
    return DocumentTemplate(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DocumentTemplate && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'DocumentTemplate(id: $id, name: $name, type: $type)';
  }
}

enum TemplateType {
  contract,
  lease,
  agreement,
  form,
  letter,
  notice,
  other,
}

enum TemplateCategory {
  legal,
  financial,
  property,
  tenant,
  landlord,
  maintenance,
  other,
}
