import 'package:reservatior/shared/enums/payment_status.dart';
import 'lease.dart';
import 'organization.dart';

class RentSchedule {
  final String id;
  final String orgId;
  final String leaseId;
  final DateTime dueDate;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final DateTime? paidAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Lease lease;
  final Organization org;

  const RentSchedule({
    required this.id,
    required this.orgId,
    required this.leaseId,
    required this.dueDate,
    required this.amount,
    required this.currency,
    required this.status,
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.lease,
    required this.org,
  });

  factory RentSchedule.fromJson(Map<String, dynamic> json) {
    return RentSchedule(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      leaseId: json['leaseId'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: PaymentStatus.values.firstWhere((v) => v.name == json['status']),
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      lease: Lease.fromJson(json['lease'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'leaseId': leaseId,
      'dueDate': dueDate.toIso8601String(),
      'amount': amount,
      'currency': currency,
      'status': status.name,
      'paidAt': paidAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'lease': lease.toJson(),
      'org': org.toJson(),
    };
  }

  RentSchedule copyWith({
    String? id,
    String? orgId,
    String? leaseId,
    DateTime? dueDate,
    double? amount,
    String? currency,
    PaymentStatus? status,
    DateTime? paidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Lease? lease,
    Organization? org,
  }) {
    return RentSchedule(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      leaseId: leaseId ?? this.leaseId,
      dueDate: dueDate ?? this.dueDate,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      lease: lease ?? this.lease,
      org: org ?? this.org,
    );
  }
}
