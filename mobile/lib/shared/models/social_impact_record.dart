import 'package:reservatior/shared/enums/social_impact_type.dart';
import 'organization.dart';
import 'social_impact_counter.dart';

class SocialImpactRecord {
  final String id;
  final String orgId;
  final String counterId;
  final String? reservationId;
  final SocialImpactType impactType;
  final int quantity;
  final double? amount;
  final String currency;
  final String? description;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final String? proofUrl;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final SocialImpactCounter counter;
  final Organization org;

  const SocialImpactRecord({
    required this.id,
    required this.orgId,
    required this.counterId,
    this.reservationId,
    required this.impactType,
    required this.quantity,
    this.amount,
    required this.currency,
    this.description,
    this.verifiedAt,
    this.verifiedBy,
    this.proofUrl,
    this.deletedAt,
    required this.createdAt,
    required this.counter,
    required this.org,
  });

  factory SocialImpactRecord.fromJson(Map<String, dynamic> json) {
    return SocialImpactRecord(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      counterId: json['counterId'] as String,
      reservationId: json['reservationId'] as String?,
      impactType: SocialImpactType.values.firstWhere((v) => v.name == json['impactType']),
      quantity: json['quantity'] as int,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      description: json['description'] as String?,
      verifiedAt: json['verifiedAt'] != null ? DateTime.parse(json['verifiedAt'] as String) : null,
      verifiedBy: json['verifiedBy'] as String?,
      proofUrl: json['proofUrl'] as String?,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      counter: SocialImpactCounter.fromJson(json['counter'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'counterId': counterId,
      'reservationId': reservationId,
      'impactType': impactType.name,
      'quantity': quantity,
      'amount': amount,
      'currency': currency,
      'description': description,
      'verifiedAt': verifiedAt?.toIso8601String(),
      'verifiedBy': verifiedBy,
      'proofUrl': proofUrl,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'counter': counter.toJson(),
      'org': org.toJson(),
    };
  }

  SocialImpactRecord copyWith({
    String? id,
    String? orgId,
    String? counterId,
    String? reservationId,
    SocialImpactType? impactType,
    int? quantity,
    double? amount,
    String? currency,
    String? description,
    DateTime? verifiedAt,
    String? verifiedBy,
    String? proofUrl,
    DateTime? deletedAt,
    DateTime? createdAt,
    SocialImpactCounter? counter,
    Organization? org,
  }) {
    return SocialImpactRecord(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      counterId: counterId ?? this.counterId,
      reservationId: reservationId ?? this.reservationId,
      impactType: impactType ?? this.impactType,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      proofUrl: proofUrl ?? this.proofUrl,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      counter: counter ?? this.counter,
      org: org ?? this.org,
    );
  }
}
