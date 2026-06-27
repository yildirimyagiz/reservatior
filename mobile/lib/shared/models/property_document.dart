import 'organization.dart';
import 'property.dart';

class PropertyDocument {
  final String id;
  final String orgId;
  final String propertyId;
  final String title;
  final String fileName;
  final String mimeType;
  final int sizeBytes;
  final String storageKey;
  final String? category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Property property;

  const PropertyDocument({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.title,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    required this.storageKey,
    this.category,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.property,
  });

  factory PropertyDocument.fromJson(Map<String, dynamic> json) {
    return PropertyDocument(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      title: json['title'] as String,
      fileName: json['fileName'] as String,
      mimeType: json['mimeType'] as String,
      sizeBytes: json['sizeBytes'] as int,
      storageKey: json['storageKey'] as String,
      category: json['category'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'title': title,
      'fileName': fileName,
      'mimeType': mimeType,
      'sizeBytes': sizeBytes,
      'storageKey': storageKey,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  PropertyDocument copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? title,
    String? fileName,
    String? mimeType,
    int? sizeBytes,
    String? storageKey,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Property? property,
  }) {
    return PropertyDocument(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      title: title ?? this.title,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      storageKey: storageKey ?? this.storageKey,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
