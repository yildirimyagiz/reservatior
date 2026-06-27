import 'package:reservatior/shared/enums/escrow_status.dart';
import 'escrow_account.dart';
import 'organization.dart';

class EscrowStatusHistory {
  final String id;
  final String? orgId;
  final String escrowId;
  final EscrowStatus fromStatus;
  final EscrowStatus toStatus;
  final String changedBy;
  final String? reason;
  final DateTime changedAt;
  final EscrowAccount escrow;
  final Organization? org;

  const EscrowStatusHistory({
    required this.id,
    this.orgId,
    required this.escrowId,
    required this.fromStatus,
    required this.toStatus,
    required this.changedBy,
    this.reason,
    required this.changedAt,
    required this.escrow,
    this.org,
  });

  factory EscrowStatusHistory.fromJson(Map<String, dynamic> json) {
    return EscrowStatusHistory(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      escrowId: json['escrowId'] as String,
      fromStatus: EscrowStatus.values.firstWhere((v) => v.name == json['fromStatus']),
      toStatus: EscrowStatus.values.firstWhere((v) => v.name == json['toStatus']),
      changedBy: json['changedBy'] as String,
      reason: json['reason'] as String?,
      changedAt: DateTime.parse(json['changedAt'] as String),
      escrow: EscrowAccount.fromJson(json['escrow'] as Map<String, dynamic>),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'escrowId': escrowId,
      'fromStatus': fromStatus.name,
      'toStatus': toStatus.name,
      'changedBy': changedBy,
      'reason': reason,
      'changedAt': changedAt.toIso8601String(),
      'escrow': escrow.toJson(),
      'org': org?.toJson(),
    };
  }

  EscrowStatusHistory copyWith({
    String? id,
    String? orgId,
    String? escrowId,
    EscrowStatus? fromStatus,
    EscrowStatus? toStatus,
    String? changedBy,
    String? reason,
    DateTime? changedAt,
    EscrowAccount? escrow,
    Organization? org,
  }) {
    return EscrowStatusHistory(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      escrowId: escrowId ?? this.escrowId,
      fromStatus: fromStatus ?? this.fromStatus,
      toStatus: toStatus ?? this.toStatus,
      changedBy: changedBy ?? this.changedBy,
      reason: reason ?? this.reason,
      changedAt: changedAt ?? this.changedAt,
      escrow: escrow ?? this.escrow,
      org: org ?? this.org,
    );
  }
}
