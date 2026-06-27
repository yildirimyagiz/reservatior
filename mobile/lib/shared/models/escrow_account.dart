import 'package:reservatior/shared/enums/escrow_status.dart';
import 'escrow_dispute.dart';
import 'escrow_release.dart';
import 'escrow_status_history.dart';
import 'organization.dart';
import 'reservation.dart';

class EscrowAccount {
  final String id;
  final String orgId;
  final String reservationId;
  final double totalAmount;
  final double depositAmount;
  final String currency;
  final EscrowStatus status;
  final DateTime heldAt;
  final DateTime? releasedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Reservation reservation;
  final List<EscrowRelease> releases;
  final List<EscrowDispute> disputes;
  final List<EscrowStatusHistory> statusHistory;

  const EscrowAccount({
    required this.id,
    required this.orgId,
    required this.reservationId,
    required this.totalAmount,
    required this.depositAmount,
    required this.currency,
    required this.status,
    required this.heldAt,
    this.releasedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.reservation,
    this.releases = const [],
    this.disputes = const [],
    this.statusHistory = const [],
  });

  factory EscrowAccount.fromJson(Map<String, dynamic> json) {
    return EscrowAccount(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      reservationId: json['reservationId'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      depositAmount: (json['depositAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: EscrowStatus.values.firstWhere((v) => v.name == json['status']),
      heldAt: DateTime.parse(json['heldAt'] as String),
      releasedAt: json['releasedAt'] != null ? DateTime.parse(json['releasedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      reservation: Reservation.fromJson(json['reservation'] as Map<String, dynamic>),
      releases: (json['releases'] as List<dynamic>?)?.map((e) => EscrowRelease.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      disputes: (json['disputes'] as List<dynamic>?)?.map((e) => EscrowDispute.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      statusHistory: (json['statusHistory'] as List<dynamic>?)?.map((e) => EscrowStatusHistory.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'reservationId': reservationId,
      'totalAmount': totalAmount,
      'depositAmount': depositAmount,
      'currency': currency,
      'status': status.name,
      'heldAt': heldAt.toIso8601String(),
      'releasedAt': releasedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'reservation': reservation.toJson(),
      'releases': releases.map((e) => e.toJson()).toList(),
      'disputes': disputes.map((e) => e.toJson()).toList(),
      'statusHistory': statusHistory.map((e) => e.toJson()).toList(),
    };
  }

  EscrowAccount copyWith({
    String? id,
    String? orgId,
    String? reservationId,
    double? totalAmount,
    double? depositAmount,
    String? currency,
    EscrowStatus? status,
    DateTime? heldAt,
    DateTime? releasedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Reservation? reservation,
    List<EscrowRelease>? releases,
    List<EscrowDispute>? disputes,
    List<EscrowStatusHistory>? statusHistory,
  }) {
    return EscrowAccount(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      reservationId: reservationId ?? this.reservationId,
      totalAmount: totalAmount ?? this.totalAmount,
      depositAmount: depositAmount ?? this.depositAmount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      heldAt: heldAt ?? this.heldAt,
      releasedAt: releasedAt ?? this.releasedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      reservation: reservation ?? this.reservation,
      releases: releases ?? this.releases,
      disputes: disputes ?? this.disputes,
      statusHistory: statusHistory ?? this.statusHistory,
    );
  }
}
