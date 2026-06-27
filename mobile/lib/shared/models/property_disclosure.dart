import 'organization.dart';
import 'property.dart';

class PropertyDisclosure {
  final String id;
  final String orgId;
  final String propertyId;
  final String packStatus;
  final DateTime createdDate;
  final DateTime? submittedDate;
  final String? completionNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;
  final Property property;

  const PropertyDisclosure({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.packStatus,
    required this.createdDate,
    this.submittedDate,
    this.completionNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
    required this.property,
  });

  factory PropertyDisclosure.fromJson(Map<String, dynamic> json) {
    return PropertyDisclosure(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      packStatus: json['packStatus'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      submittedDate: json['submittedDate'] != null ? DateTime.parse(json['submittedDate'] as String) : null,
      completionNotes: json['completionNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'packStatus': packStatus,
      'createdDate': createdDate.toIso8601String(),
      'submittedDate': submittedDate?.toIso8601String(),
      'completionNotes': completionNotes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  PropertyDisclosure copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? packStatus,
    DateTime? createdDate,
    DateTime? submittedDate,
    String? completionNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    Property? property,
  }) {
    return PropertyDisclosure(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      packStatus: packStatus ?? this.packStatus,
      createdDate: createdDate ?? this.createdDate,
      submittedDate: submittedDate ?? this.submittedDate,
      completionNotes: completionNotes ?? this.completionNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
