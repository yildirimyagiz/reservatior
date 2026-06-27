import 'package:reservatior/shared/enums/escrow_dispute_party.dart';
import 'package:reservatior/shared/enums/escrow_dispute_status.dart';
import 'package:reservatior/shared/enums/escrow_dispute_type.dart';
import 'escrow_account.dart';
import 'organization.dart';

class EscrowDispute {
  final String id;
  final String orgId;
  final String reservationId;
  final String escrowAccountId;
  final EscrowDisputeParty openedBy;
  final EscrowDisputeType disputeType;
  final String description;
  final double? claimedAmount;
  final String currency;
  final EscrowDisputeStatus status;
  final String? resolution;
  final double? resolvedAmount;
  final DateTime? resolvedAt;
  final String? resolvedBy;
  final String? moderatorNotes;
  final DateTime? escalatedAt;
  final DateTime? deadlineAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final EscrowAccount escrowAccount;

  const EscrowDispute({
    required this.id,
    required this.orgId,
    required this.reservationId,
    required this.escrowAccountId,
    required this.openedBy,
    required this.disputeType,
    required this.description,
    this.claimedAmount,
    required this.currency,
    required this.status,
    this.resolution,
    this.resolvedAmount,
    this.resolvedAt,
    this.resolvedBy,
    this.moderatorNotes,
    this.escalatedAt,
    this.deadlineAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.escrowAccount,
  });

  factory EscrowDispute.fromJson(Map<String, dynamic> json) {
    return EscrowDispute(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      reservationId: json['reservationId'] as String,
      escrowAccountId: json['escrowAccountId'] as String,
      openedBy: EscrowDisputeParty.values.firstWhere((v) => v.name == json['openedBy']),
      disputeType: EscrowDisputeType.values.firstWhere((v) => v.name == json['disputeType']),
      description: json['description'] as String,
      claimedAmount: (json['claimedAmount'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      status: EscrowDisputeStatus.values.firstWhere((v) => v.name == json['status']),
      resolution: json['resolution'] as String?,
      resolvedAmount: (json['resolvedAmount'] as num?)?.toDouble(),
      resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt'] as String) : null,
      resolvedBy: json['resolvedBy'] as String?,
      moderatorNotes: json['moderatorNotes'] as String?,
      escalatedAt: json['escalatedAt'] != null ? DateTime.parse(json['escalatedAt'] as String) : null,
      deadlineAt: json['deadlineAt'] != null ? DateTime.parse(json['deadlineAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      escrowAccount: EscrowAccount.fromJson(json['escrowAccount'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'reservationId': reservationId,
      'escrowAccountId': escrowAccountId,
      'openedBy': openedBy.name,
      'disputeType': disputeType.name,
      'description': description,
      'claimedAmount': claimedAmount,
      'currency': currency,
      'status': status.name,
      'resolution': resolution,
      'resolvedAmount': resolvedAmount,
      'resolvedAt': resolvedAt?.toIso8601String(),
      'resolvedBy': resolvedBy,
      'moderatorNotes': moderatorNotes,
      'escalatedAt': escalatedAt?.toIso8601String(),
      'deadlineAt': deadlineAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'escrowAccount': escrowAccount.toJson(),
    };
  }

  EscrowDispute copyWith({
    String? id,
    String? orgId,
    String? reservationId,
    String? escrowAccountId,
    EscrowDisputeParty? openedBy,
    EscrowDisputeType? disputeType,
    String? description,
    double? claimedAmount,
    String? currency,
    EscrowDisputeStatus? status,
    String? resolution,
    double? resolvedAmount,
    DateTime? resolvedAt,
    String? resolvedBy,
    String? moderatorNotes,
    DateTime? escalatedAt,
    DateTime? deadlineAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    EscrowAccount? escrowAccount,
  }) {
    return EscrowDispute(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      reservationId: reservationId ?? this.reservationId,
      escrowAccountId: escrowAccountId ?? this.escrowAccountId,
      openedBy: openedBy ?? this.openedBy,
      disputeType: disputeType ?? this.disputeType,
      description: description ?? this.description,
      claimedAmount: claimedAmount ?? this.claimedAmount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      resolution: resolution ?? this.resolution,
      resolvedAmount: resolvedAmount ?? this.resolvedAmount,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      resolvedBy: resolvedBy ?? this.resolvedBy,
      moderatorNotes: moderatorNotes ?? this.moderatorNotes,
      escalatedAt: escalatedAt ?? this.escalatedAt,
      deadlineAt: deadlineAt ?? this.deadlineAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      escrowAccount: escrowAccount ?? this.escrowAccount,
    );
  }
}
