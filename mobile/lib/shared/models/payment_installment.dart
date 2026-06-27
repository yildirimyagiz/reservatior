import 'package:reservatior/shared/enums/payment_method_us.dart';
import 'package:reservatior/shared/enums/payment_status.dart';
import 'organization.dart';
import 'payment_negotiation.dart';

class PaymentInstallment {
  final String id;
  final String orgId;
  final String negotiationId;
  final int installmentNo;
  final double amount;
  final String currency;
  final DateTime dueDate;
  final PaymentStatus status;
  final DateTime? paidAt;
  final PaymentMethodUS? paymentMethod;
  final String? referenceNo;
  final String? notes;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PaymentNegotiation negotiation;
  final Organization org;

  const PaymentInstallment({
    required this.id,
    required this.orgId,
    required this.negotiationId,
    required this.installmentNo,
    required this.amount,
    required this.currency,
    required this.dueDate,
    required this.status,
    this.paidAt,
    this.paymentMethod,
    this.referenceNo,
    this.notes,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.negotiation,
    required this.org,
  });

  factory PaymentInstallment.fromJson(Map<String, dynamic> json) {
    return PaymentInstallment(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      negotiationId: json['negotiationId'] as String,
      installmentNo: json['installmentNo'] as int,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: PaymentStatus.values.firstWhere((v) => v.name == json['status']),
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt'] as String) : null,
      paymentMethod: json['paymentMethod'] != null ? PaymentMethodUS.values.firstWhere((v) => v.name == json['paymentMethod']) : null,
      referenceNo: json['referenceNo'] as String?,
      notes: json['notes'] as String?,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      negotiation: PaymentNegotiation.fromJson(json['negotiation'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'negotiationId': negotiationId,
      'installmentNo': installmentNo,
      'amount': amount,
      'currency': currency,
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'paidAt': paidAt?.toIso8601String(),
      'paymentMethod': paymentMethod?.name,
      'referenceNo': referenceNo,
      'notes': notes,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'negotiation': negotiation.toJson(),
      'org': org.toJson(),
    };
  }

  PaymentInstallment copyWith({
    String? id,
    String? orgId,
    String? negotiationId,
    int? installmentNo,
    double? amount,
    String? currency,
    DateTime? dueDate,
    PaymentStatus? status,
    DateTime? paidAt,
    PaymentMethodUS? paymentMethod,
    String? referenceNo,
    String? notes,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    PaymentNegotiation? negotiation,
    Organization? org,
  }) {
    return PaymentInstallment(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      negotiationId: negotiationId ?? this.negotiationId,
      installmentNo: installmentNo ?? this.installmentNo,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      referenceNo: referenceNo ?? this.referenceNo,
      notes: notes ?? this.notes,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      negotiation: negotiation ?? this.negotiation,
      org: org ?? this.org,
    );
  }
}
