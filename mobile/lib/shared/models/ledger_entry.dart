import 'package:reservatior/shared/enums/ledger_event_type.dart';
import 'organization.dart';
import 'property.dart';

class LedgerEntry {
  final String id;
  final String orgId;
  final String propertyId;
  final String? listingId;
  final String? leaseId;
  final String? bookingId;
  final String? contractId;
  final String? billId;
  final String? transactionId;
  final LedgerEventType type;
  final double? amount;
  final String? currency;
  final DateTime occurredAt;
  final String? note;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Property property;

  const LedgerEntry({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.listingId,
    this.leaseId,
    this.bookingId,
    this.contractId,
    this.billId,
    this.transactionId,
    required this.type,
    this.amount,
    this.currency,
    required this.occurredAt,
    this.note,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.property,
  });

  factory LedgerEntry.fromJson(Map<String, dynamic> json) {
    return LedgerEntry(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      leaseId: json['leaseId'] as String?,
      bookingId: json['bookingId'] as String?,
      contractId: json['contractId'] as String?,
      billId: json['billId'] as String?,
      transactionId: json['transactionId'] as String?,
      type: LedgerEventType.values.firstWhere((v) => v.name == json['type']),
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      occurredAt: DateTime.parse(json['occurredAt'] as String),
      note: json['note'] as String?,
      createdBy: json['createdBy'] as String?,
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
      'listingId': listingId,
      'leaseId': leaseId,
      'bookingId': bookingId,
      'contractId': contractId,
      'billId': billId,
      'transactionId': transactionId,
      'type': type.name,
      'amount': amount,
      'currency': currency,
      'occurredAt': occurredAt.toIso8601String(),
      'note': note,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  LedgerEntry copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? leaseId,
    String? bookingId,
    String? contractId,
    String? billId,
    String? transactionId,
    LedgerEventType? type,
    double? amount,
    String? currency,
    DateTime? occurredAt,
    String? note,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Property? property,
  }) {
    return LedgerEntry(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      leaseId: leaseId ?? this.leaseId,
      bookingId: bookingId ?? this.bookingId,
      contractId: contractId ?? this.contractId,
      billId: billId ?? this.billId,
      transactionId: transactionId ?? this.transactionId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      occurredAt: occurredAt ?? this.occurredAt,
      note: note ?? this.note,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
