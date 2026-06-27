import 'package:reservatior/shared/enums/negotiation_offer_status.dart';
import 'package:reservatior/shared/enums/negotiation_party.dart';
import 'organization.dart';
import 'payment_negotiation.dart';

class NegotiationOffer {
  final String id;
  final String? orgId;
  final String negotiationId;
  final NegotiationParty offeredBy;
  final int installmentCount;
  final double firstPaymentPct;
  final double totalAmount;
  final String currency;
  final String? notes;
  final NegotiationOfferStatus status;
  final DateTime offeredAt;
  final DateTime? expiresAt;
  final DateTime? respondedAt;
  final PaymentNegotiation negotiation;
  final Organization? org;

  const NegotiationOffer({
    required this.id,
    this.orgId,
    required this.negotiationId,
    required this.offeredBy,
    required this.installmentCount,
    required this.firstPaymentPct,
    required this.totalAmount,
    required this.currency,
    this.notes,
    required this.status,
    required this.offeredAt,
    this.expiresAt,
    this.respondedAt,
    required this.negotiation,
    this.org,
  });

  factory NegotiationOffer.fromJson(Map<String, dynamic> json) {
    return NegotiationOffer(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      negotiationId: json['negotiationId'] as String,
      offeredBy: NegotiationParty.values.firstWhere((v) => v.name == json['offeredBy']),
      installmentCount: json['installmentCount'] as int,
      firstPaymentPct: (json['firstPaymentPct'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      notes: json['notes'] as String?,
      status: NegotiationOfferStatus.values.firstWhere((v) => v.name == json['status']),
      offeredAt: DateTime.parse(json['offeredAt'] as String),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      respondedAt: json['respondedAt'] != null ? DateTime.parse(json['respondedAt'] as String) : null,
      negotiation: PaymentNegotiation.fromJson(json['negotiation'] as Map<String, dynamic>),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'negotiationId': negotiationId,
      'offeredBy': offeredBy.name,
      'installmentCount': installmentCount,
      'firstPaymentPct': firstPaymentPct,
      'totalAmount': totalAmount,
      'currency': currency,
      'notes': notes,
      'status': status.name,
      'offeredAt': offeredAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'respondedAt': respondedAt?.toIso8601String(),
      'negotiation': negotiation.toJson(),
      'org': org?.toJson(),
    };
  }

  NegotiationOffer copyWith({
    String? id,
    String? orgId,
    String? negotiationId,
    NegotiationParty? offeredBy,
    int? installmentCount,
    double? firstPaymentPct,
    double? totalAmount,
    String? currency,
    String? notes,
    NegotiationOfferStatus? status,
    DateTime? offeredAt,
    DateTime? expiresAt,
    DateTime? respondedAt,
    PaymentNegotiation? negotiation,
    Organization? org,
  }) {
    return NegotiationOffer(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      negotiationId: negotiationId ?? this.negotiationId,
      offeredBy: offeredBy ?? this.offeredBy,
      installmentCount: installmentCount ?? this.installmentCount,
      firstPaymentPct: firstPaymentPct ?? this.firstPaymentPct,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      offeredAt: offeredAt ?? this.offeredAt,
      expiresAt: expiresAt ?? this.expiresAt,
      respondedAt: respondedAt ?? this.respondedAt,
      negotiation: negotiation ?? this.negotiation,
      org: org ?? this.org,
    );
  }
}
