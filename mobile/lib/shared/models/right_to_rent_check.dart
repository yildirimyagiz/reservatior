import 'contact.dart';
import 'lease.dart';
import 'organization.dart';

class RightToRentCheck {
  final String id;
  final String orgId;
  final String? leaseId;
  final String contactId;
  final String checkType;
  final String reference;
  final String status;
  final DateTime? checkedAt;
  final DateTime? expiresAt;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact contact;
  final Lease? lease;
  final Organization org;

  const RightToRentCheck({
    required this.id,
    required this.orgId,
    this.leaseId,
    required this.contactId,
    required this.checkType,
    required this.reference,
    required this.status,
    this.checkedAt,
    this.expiresAt,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.contact,
    this.lease,
    required this.org,
  });

  factory RightToRentCheck.fromJson(Map<String, dynamic> json) {
    return RightToRentCheck(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      leaseId: json['leaseId'] as String?,
      contactId: json['contactId'] as String,
      checkType: json['checkType'] as String,
      reference: json['reference'] as String,
      status: json['status'] as String,
      checkedAt: json['checkedAt'] != null ? DateTime.parse(json['checkedAt'] as String) : null,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      lease: json['lease'] != null ? Lease.fromJson(json['lease'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'leaseId': leaseId,
      'contactId': contactId,
      'checkType': checkType,
      'reference': reference,
      'status': status,
      'checkedAt': checkedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contact': contact.toJson(),
      'lease': lease?.toJson(),
      'org': org.toJson(),
    };
  }

  RightToRentCheck copyWith({
    String? id,
    String? orgId,
    String? leaseId,
    String? contactId,
    String? checkType,
    String? reference,
    String? status,
    DateTime? checkedAt,
    DateTime? expiresAt,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    Lease? lease,
    Organization? org,
  }) {
    return RightToRentCheck(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      leaseId: leaseId ?? this.leaseId,
      contactId: contactId ?? this.contactId,
      checkType: checkType ?? this.checkType,
      reference: reference ?? this.reference,
      status: status ?? this.status,
      checkedAt: checkedAt ?? this.checkedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      lease: lease ?? this.lease,
      org: org ?? this.org,
    );
  }
}
