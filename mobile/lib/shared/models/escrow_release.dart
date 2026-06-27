import 'package:reservatior/shared/enums/escrow_release_status.dart';
import 'package:reservatior/shared/enums/escrow_trigger_event.dart';
import 'escrow_account.dart';
import 'organization.dart';

class EscrowRelease {
  final String id;
  final String orgId;
  final String escrowId;
  final EscrowTriggerEvent triggerEvent;
  final double releasePercent;
  final double amount;
  final String currency;
  final EscrowReleaseStatus status;
  final DateTime? scheduledAt;
  final DateTime? releasedAt;
  final List<String> approvalRequiredBy;
  final DateTime? approvalCompletedAt;
  final String? approvedBy;
  final String? failureReason;
  final int retryCount;
  final String? notes;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final EscrowAccount escrow;
  final Organization org;

  const EscrowRelease({
    required this.id,
    required this.orgId,
    required this.escrowId,
    required this.triggerEvent,
    required this.releasePercent,
    required this.amount,
    required this.currency,
    required this.status,
    this.scheduledAt,
    this.releasedAt,
    this.approvalRequiredBy = const [],
    this.approvalCompletedAt,
    this.approvedBy,
    this.failureReason,
    required this.retryCount,
    this.notes,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.escrow,
    required this.org,
  });

  factory EscrowRelease.fromJson(Map<String, dynamic> json) {
    return EscrowRelease(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      escrowId: json['escrowId'] as String,
      triggerEvent: EscrowTriggerEvent.values.firstWhere((v) => v.name == json['triggerEvent']),
      releasePercent: (json['releasePercent'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: EscrowReleaseStatus.values.firstWhere((v) => v.name == json['status']),
      scheduledAt: json['scheduledAt'] != null ? DateTime.parse(json['scheduledAt'] as String) : null,
      releasedAt: json['releasedAt'] != null ? DateTime.parse(json['releasedAt'] as String) : null,
      approvalRequiredBy: (json['approvalRequiredBy'] as List<dynamic>?)?.cast<String>() ?? [],
      approvalCompletedAt: json['approvalCompletedAt'] != null ? DateTime.parse(json['approvalCompletedAt'] as String) : null,
      approvedBy: json['approvedBy'] as String?,
      failureReason: json['failureReason'] as String?,
      retryCount: json['retryCount'] as int,
      notes: json['notes'] as String?,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      escrow: EscrowAccount.fromJson(json['escrow'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'escrowId': escrowId,
      'triggerEvent': triggerEvent.name,
      'releasePercent': releasePercent,
      'amount': amount,
      'currency': currency,
      'status': status.name,
      'scheduledAt': scheduledAt?.toIso8601String(),
      'releasedAt': releasedAt?.toIso8601String(),
      'approvalRequiredBy': approvalRequiredBy,
      'approvalCompletedAt': approvalCompletedAt?.toIso8601String(),
      'approvedBy': approvedBy,
      'failureReason': failureReason,
      'retryCount': retryCount,
      'notes': notes,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'escrow': escrow.toJson(),
      'org': org.toJson(),
    };
  }

  EscrowRelease copyWith({
    String? id,
    String? orgId,
    String? escrowId,
    EscrowTriggerEvent? triggerEvent,
    double? releasePercent,
    double? amount,
    String? currency,
    EscrowReleaseStatus? status,
    DateTime? scheduledAt,
    DateTime? releasedAt,
    List<String>? approvalRequiredBy,
    DateTime? approvalCompletedAt,
    String? approvedBy,
    String? failureReason,
    int? retryCount,
    String? notes,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    EscrowAccount? escrow,
    Organization? org,
  }) {
    return EscrowRelease(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      escrowId: escrowId ?? this.escrowId,
      triggerEvent: triggerEvent ?? this.triggerEvent,
      releasePercent: releasePercent ?? this.releasePercent,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      releasedAt: releasedAt ?? this.releasedAt,
      approvalRequiredBy: approvalRequiredBy ?? this.approvalRequiredBy,
      approvalCompletedAt: approvalCompletedAt ?? this.approvalCompletedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      failureReason: failureReason ?? this.failureReason,
      retryCount: retryCount ?? this.retryCount,
      notes: notes ?? this.notes,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      escrow: escrow ?? this.escrow,
      org: org ?? this.org,
    );
  }
}
