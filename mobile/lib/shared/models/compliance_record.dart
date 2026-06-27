import 'package:reservatior/shared/enums/compliance_status.dart';
import 'package:reservatior/shared/enums/compliance_type.dart';
import 'agency.dart';
import 'agent.dart';
import 'property.dart';
import 'reservation.dart';

class ComplianceRecord {
  final String id;
  final String entityId;
  final String entityType;
  final ComplianceType type;
  final ComplianceStatus status;
  final String? documentUrl;
  final DateTime? expiryDate;
  final String? notes;
  final bool isVerified;
  final String? propertyId;
  final String? agentId;
  final String? agencyId;
  final String? reservationId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Agency? agency;
  final Agent? agent;
  final Property? property;
  final Reservation? reservation;

  const ComplianceRecord({
    required this.id,
    required this.entityId,
    required this.entityType,
    required this.type,
    required this.status,
    this.documentUrl,
    this.expiryDate,
    this.notes,
    required this.isVerified,
    this.propertyId,
    this.agentId,
    this.agencyId,
    this.reservationId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.agency,
    this.agent,
    this.property,
    this.reservation,
  });

  factory ComplianceRecord.fromJson(Map<String, dynamic> json) {
    return ComplianceRecord(
      id: json['id'] as String,
      entityId: json['entityId'] as String,
      entityType: json['entityType'] as String,
      type: ComplianceType.values.firstWhere((v) => v.name == json['type']),
      status: ComplianceStatus.values.firstWhere((v) => v.name == json['status']),
      documentUrl: json['documentUrl'] as String?,
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate'] as String) : null,
      notes: json['notes'] as String?,
      isVerified: json['isVerified'] as bool,
      propertyId: json['propertyId'] as String?,
      agentId: json['agentId'] as String?,
      agencyId: json['agencyId'] as String?,
      reservationId: json['reservationId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as Map<String, dynamic>) : null,
      property: json['Property'] != null ? Property.fromJson(json['Property'] as Map<String, dynamic>) : null,
      reservation: json['Reservation'] != null ? Reservation.fromJson(json['Reservation'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entityId': entityId,
      'entityType': entityType,
      'type': type.name,
      'status': status.name,
      'documentUrl': documentUrl,
      'expiryDate': expiryDate?.toIso8601String(),
      'notes': notes,
      'isVerified': isVerified,
      'propertyId': propertyId,
      'agentId': agentId,
      'agencyId': agencyId,
      'reservationId': reservationId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'Agency': agency?.toJson(),
      'Agent': agent?.toJson(),
      'Property': property?.toJson(),
      'Reservation': reservation?.toJson(),
    };
  }

  ComplianceRecord copyWith({
    String? id,
    String? entityId,
    String? entityType,
    ComplianceType? type,
    ComplianceStatus? status,
    String? documentUrl,
    DateTime? expiryDate,
    String? notes,
    bool? isVerified,
    String? propertyId,
    String? agentId,
    String? agencyId,
    String? reservationId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Agency? agency,
    Agent? agent,
    Property? property,
    Reservation? reservation,
  }) {
    return ComplianceRecord(
      id: id ?? this.id,
      entityId: entityId ?? this.entityId,
      entityType: entityType ?? this.entityType,
      type: type ?? this.type,
      status: status ?? this.status,
      documentUrl: documentUrl ?? this.documentUrl,
      expiryDate: expiryDate ?? this.expiryDate,
      notes: notes ?? this.notes,
      isVerified: isVerified ?? this.isVerified,
      propertyId: propertyId ?? this.propertyId,
      agentId: agentId ?? this.agentId,
      agencyId: agencyId ?? this.agencyId,
      reservationId: reservationId ?? this.reservationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      agency: agency ?? this.agency,
      agent: agent ?? this.agent,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
    );
  }
}
