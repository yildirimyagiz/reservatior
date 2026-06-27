import 'organization.dart';
import 'property.dart';

class KeyManagement {
  final String id;
  final String orgId;
  final String propertyId;
  final String keyType;
  final String? keyNumber;
  final String? keyLocation;
  final String? keySafeCode;
  final String keyStatus;
  final DateTime? cutDate;
  final String? cutBy;
  final double? replacementCost;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;
  final Property property;

  const KeyManagement({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.keyType,
    this.keyNumber,
    this.keyLocation,
    this.keySafeCode,
    required this.keyStatus,
    this.cutDate,
    this.cutBy,
    this.replacementCost,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
    required this.property,
  });

  factory KeyManagement.fromJson(Map<String, dynamic> json) {
    return KeyManagement(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      keyType: json['keyType'] as String,
      keyNumber: json['keyNumber'] as String?,
      keyLocation: json['keyLocation'] as String?,
      keySafeCode: json['keySafeCode'] as String?,
      keyStatus: json['keyStatus'] as String,
      cutDate: json['cutDate'] != null ? DateTime.parse(json['cutDate'] as String) : null,
      cutBy: json['cutBy'] as String?,
      replacementCost: (json['replacementCost'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
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
      'keyType': keyType,
      'keyNumber': keyNumber,
      'keyLocation': keyLocation,
      'keySafeCode': keySafeCode,
      'keyStatus': keyStatus,
      'cutDate': cutDate?.toIso8601String(),
      'cutBy': cutBy,
      'replacementCost': replacementCost,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  KeyManagement copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? keyType,
    String? keyNumber,
    String? keyLocation,
    String? keySafeCode,
    String? keyStatus,
    DateTime? cutDate,
    String? cutBy,
    double? replacementCost,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    Property? property,
  }) {
    return KeyManagement(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      keyType: keyType ?? this.keyType,
      keyNumber: keyNumber ?? this.keyNumber,
      keyLocation: keyLocation ?? this.keyLocation,
      keySafeCode: keySafeCode ?? this.keySafeCode,
      keyStatus: keyStatus ?? this.keyStatus,
      cutDate: cutDate ?? this.cutDate,
      cutBy: cutBy ?? this.cutBy,
      replacementCost: replacementCost ?? this.replacementCost,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
