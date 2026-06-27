import 'attachment.dart';
import 'contact.dart';
import 'organization.dart';
import 'property.dart';
import 'user.dart';

class PropertyCompliance {
  final String id;
  final String orgId;
  final String propertyId;
  final String type;
  final String status;
  final String? inspectorId;
  final String? inspectorContactId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Attachment> attachments;
  final Contact? inspectorContact;
  final User? inspector;
  final Organization org;
  final Property property;

  const PropertyCompliance({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.type,
    required this.status,
    this.inspectorId,
    this.inspectorContactId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.attachments = const [],
    this.inspectorContact,
    this.inspector,
    required this.org,
    required this.property,
  });

  factory PropertyCompliance.fromJson(Map<String, dynamic> json) {
    return PropertyCompliance(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      inspectorId: json['inspectorId'] as String?,
      inspectorContactId: json['inspectorContactId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Attachment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      inspectorContact: json['inspectorContact'] != null ? Contact.fromJson(json['inspectorContact'] as Map<String, dynamic>) : null,
      inspector: json['inspector'] != null ? User.fromJson(json['inspector'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'type': type,
      'status': status,
      'inspectorId': inspectorId,
      'inspectorContactId': inspectorContactId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'inspectorContact': inspectorContact?.toJson(),
      'inspector': inspector?.toJson(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  PropertyCompliance copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? type,
    String? status,
    String? inspectorId,
    String? inspectorContactId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Attachment>? attachments,
    Contact? inspectorContact,
    User? inspector,
    Organization? org,
    Property? property,
  }) {
    return PropertyCompliance(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      type: type ?? this.type,
      status: status ?? this.status,
      inspectorId: inspectorId ?? this.inspectorId,
      inspectorContactId: inspectorContactId ?? this.inspectorContactId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      attachments: attachments ?? this.attachments,
      inspectorContact: inspectorContact ?? this.inspectorContact,
      inspector: inspector ?? this.inspector,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
