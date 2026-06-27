import 'contact.dart';
import 'deal.dart';
import 'organization.dart';

class SolicitorManagement {
  final String id;
  final String orgId;
  final String? dealId;
  final String contactId;
  final String solicitorType;
  final String status;
  final DateTime? engagedAt;
  final DateTime? completedAt;
  final double? fee;
  final String? currency;
  final String? notes;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact contact;
  final Deal? deal;
  final Organization org;

  const SolicitorManagement({
    required this.id,
    required this.orgId,
    this.dealId,
    required this.contactId,
    required this.solicitorType,
    required this.status,
    this.engagedAt,
    this.completedAt,
    this.fee,
    this.currency,
    this.notes,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.contact,
    this.deal,
    required this.org,
  });

  factory SolicitorManagement.fromJson(Map<String, dynamic> json) {
    return SolicitorManagement(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      dealId: json['dealId'] as String?,
      contactId: json['contactId'] as String,
      solicitorType: json['solicitorType'] as String,
      status: json['status'] as String,
      engagedAt: json['engagedAt'] != null ? DateTime.parse(json['engagedAt'] as String) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      fee: (json['fee'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      notes: json['notes'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      deal: json['deal'] != null ? Deal.fromJson(json['deal'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'dealId': dealId,
      'contactId': contactId,
      'solicitorType': solicitorType,
      'status': status,
      'engagedAt': engagedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'fee': fee,
      'currency': currency,
      'notes': notes,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contact': contact.toJson(),
      'deal': deal?.toJson(),
      'org': org.toJson(),
    };
  }

  SolicitorManagement copyWith({
    String? id,
    String? orgId,
    String? dealId,
    String? contactId,
    String? solicitorType,
    String? status,
    DateTime? engagedAt,
    DateTime? completedAt,
    double? fee,
    String? currency,
    String? notes,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    Deal? deal,
    Organization? org,
  }) {
    return SolicitorManagement(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      dealId: dealId ?? this.dealId,
      contactId: contactId ?? this.contactId,
      solicitorType: solicitorType ?? this.solicitorType,
      status: status ?? this.status,
      engagedAt: engagedAt ?? this.engagedAt,
      completedAt: completedAt ?? this.completedAt,
      fee: fee ?? this.fee,
      currency: currency ?? this.currency,
      notes: notes ?? this.notes,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      deal: deal ?? this.deal,
      org: org ?? this.org,
    );
  }
}
