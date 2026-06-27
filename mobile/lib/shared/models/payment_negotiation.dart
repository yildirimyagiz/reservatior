import 'package:reservatior/shared/enums/payment_negotiation_status.dart';
import 'negotiation_offer.dart';
import 'organization.dart';
import 'payment_installment.dart';
import 'reservation.dart';

class PaymentNegotiation {
  final String id;
  final String orgId;
  final String reservationId;
  final String tenantContactId;
  final String? ownerContactId;
  final String? ownerUserId;
  final PaymentNegotiationStatus status;
  final int maxInstallments;
  final double minFirstPaymentPct;
  final bool platformValidated;
  final String? validationNotes;
  final String? agreedOfferId;
  final DateTime? agreedAt;
  final DateTime? expiresAt;
  final DateTime? reminderSentAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Reservation reservation;
  final List<NegotiationOffer> offers;
  final List<PaymentInstallment> installments;

  const PaymentNegotiation({
    required this.id,
    required this.orgId,
    required this.reservationId,
    required this.tenantContactId,
    this.ownerContactId,
    this.ownerUserId,
    required this.status,
    required this.maxInstallments,
    required this.minFirstPaymentPct,
    required this.platformValidated,
    this.validationNotes,
    this.agreedOfferId,
    this.agreedAt,
    this.expiresAt,
    this.reminderSentAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.reservation,
    this.offers = const [],
    this.installments = const [],
  });

  factory PaymentNegotiation.fromJson(Map<String, dynamic> json) {
    return PaymentNegotiation(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      reservationId: json['reservationId'] as String,
      tenantContactId: json['tenantContactId'] as String,
      ownerContactId: json['ownerContactId'] as String?,
      ownerUserId: json['ownerUserId'] as String?,
      status: PaymentNegotiationStatus.values.firstWhere((v) => v.name == json['status']),
      maxInstallments: json['maxInstallments'] as int,
      minFirstPaymentPct: (json['minFirstPaymentPct'] as num).toDouble(),
      platformValidated: json['platformValidated'] as bool,
      validationNotes: json['validationNotes'] as String?,
      agreedOfferId: json['agreedOfferId'] as String?,
      agreedAt: json['agreedAt'] != null ? DateTime.parse(json['agreedAt'] as String) : null,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      reminderSentAt: json['reminderSentAt'] != null ? DateTime.parse(json['reminderSentAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      reservation: Reservation.fromJson(json['reservation'] as Map<String, dynamic>),
      offers: (json['offers'] as List<dynamic>?)?.map((e) => NegotiationOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      installments: (json['installments'] as List<dynamic>?)?.map((e) => PaymentInstallment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'reservationId': reservationId,
      'tenantContactId': tenantContactId,
      'ownerContactId': ownerContactId,
      'ownerUserId': ownerUserId,
      'status': status.name,
      'maxInstallments': maxInstallments,
      'minFirstPaymentPct': minFirstPaymentPct,
      'platformValidated': platformValidated,
      'validationNotes': validationNotes,
      'agreedOfferId': agreedOfferId,
      'agreedAt': agreedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'reminderSentAt': reminderSentAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'reservation': reservation.toJson(),
      'offers': offers.map((e) => e.toJson()).toList(),
      'installments': installments.map((e) => e.toJson()).toList(),
    };
  }

  PaymentNegotiation copyWith({
    String? id,
    String? orgId,
    String? reservationId,
    String? tenantContactId,
    String? ownerContactId,
    String? ownerUserId,
    PaymentNegotiationStatus? status,
    int? maxInstallments,
    double? minFirstPaymentPct,
    bool? platformValidated,
    String? validationNotes,
    String? agreedOfferId,
    DateTime? agreedAt,
    DateTime? expiresAt,
    DateTime? reminderSentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Reservation? reservation,
    List<NegotiationOffer>? offers,
    List<PaymentInstallment>? installments,
  }) {
    return PaymentNegotiation(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      reservationId: reservationId ?? this.reservationId,
      tenantContactId: tenantContactId ?? this.tenantContactId,
      ownerContactId: ownerContactId ?? this.ownerContactId,
      ownerUserId: ownerUserId ?? this.ownerUserId,
      status: status ?? this.status,
      maxInstallments: maxInstallments ?? this.maxInstallments,
      minFirstPaymentPct: minFirstPaymentPct ?? this.minFirstPaymentPct,
      platformValidated: platformValidated ?? this.platformValidated,
      validationNotes: validationNotes ?? this.validationNotes,
      agreedOfferId: agreedOfferId ?? this.agreedOfferId,
      agreedAt: agreedAt ?? this.agreedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      reminderSentAt: reminderSentAt ?? this.reminderSentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      reservation: reservation ?? this.reservation,
      offers: offers ?? this.offers,
      installments: installments ?? this.installments,
    );
  }
}
