import 'contact.dart';
import 'lease.dart';
import 'organization.dart';

class RentArrears {
  final String id;
  final String orgId;
  final String leaseId;
  final String tenantId;
  final DateTime periodStart;
  final DateTime periodEnd;
  final double rentDue;
  final double rentPaid;
  final double arrearsAmount;
  final String status;
  final DateTime? lastPaymentDate;
  final bool noticeSent;
  final DateTime? noticeDate;
  final String? noticeType;
  final bool legalAction;
  final String? legalReference;
  final DateTime? courtDate;
  final double recoveryAmount;
  final double writeOffAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Lease lease;
  final Organization org;
  final Contact tenant;

  const RentArrears({
    required this.id,
    required this.orgId,
    required this.leaseId,
    required this.tenantId,
    required this.periodStart,
    required this.periodEnd,
    required this.rentDue,
    required this.rentPaid,
    required this.arrearsAmount,
    required this.status,
    this.lastPaymentDate,
    required this.noticeSent,
    this.noticeDate,
    this.noticeType,
    required this.legalAction,
    this.legalReference,
    this.courtDate,
    required this.recoveryAmount,
    required this.writeOffAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.lease,
    required this.org,
    required this.tenant,
  });

  factory RentArrears.fromJson(Map<String, dynamic> json) {
    return RentArrears(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      leaseId: json['leaseId'] as String,
      tenantId: json['tenantId'] as String,
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
      rentDue: (json['rentDue'] as num).toDouble(),
      rentPaid: (json['rentPaid'] as num).toDouble(),
      arrearsAmount: (json['arrearsAmount'] as num).toDouble(),
      status: json['status'] as String,
      lastPaymentDate: json['lastPaymentDate'] != null ? DateTime.parse(json['lastPaymentDate'] as String) : null,
      noticeSent: json['noticeSent'] as bool,
      noticeDate: json['noticeDate'] != null ? DateTime.parse(json['noticeDate'] as String) : null,
      noticeType: json['noticeType'] as String?,
      legalAction: json['legalAction'] as bool,
      legalReference: json['legalReference'] as String?,
      courtDate: json['courtDate'] != null ? DateTime.parse(json['courtDate'] as String) : null,
      recoveryAmount: (json['recoveryAmount'] as num).toDouble(),
      writeOffAmount: (json['writeOffAmount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lease: Lease.fromJson(json['lease'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      tenant: Contact.fromJson(json['tenant'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'leaseId': leaseId,
      'tenantId': tenantId,
      'periodStart': periodStart.toIso8601String(),
      'periodEnd': periodEnd.toIso8601String(),
      'rentDue': rentDue,
      'rentPaid': rentPaid,
      'arrearsAmount': arrearsAmount,
      'status': status,
      'lastPaymentDate': lastPaymentDate?.toIso8601String(),
      'noticeSent': noticeSent,
      'noticeDate': noticeDate?.toIso8601String(),
      'noticeType': noticeType,
      'legalAction': legalAction,
      'legalReference': legalReference,
      'courtDate': courtDate?.toIso8601String(),
      'recoveryAmount': recoveryAmount,
      'writeOffAmount': writeOffAmount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lease': lease.toJson(),
      'org': org.toJson(),
      'tenant': tenant.toJson(),
    };
  }

  RentArrears copyWith({
    String? id,
    String? orgId,
    String? leaseId,
    String? tenantId,
    DateTime? periodStart,
    DateTime? periodEnd,
    double? rentDue,
    double? rentPaid,
    double? arrearsAmount,
    String? status,
    DateTime? lastPaymentDate,
    bool? noticeSent,
    DateTime? noticeDate,
    String? noticeType,
    bool? legalAction,
    String? legalReference,
    DateTime? courtDate,
    double? recoveryAmount,
    double? writeOffAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Lease? lease,
    Organization? org,
    Contact? tenant,
  }) {
    return RentArrears(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      leaseId: leaseId ?? this.leaseId,
      tenantId: tenantId ?? this.tenantId,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      rentDue: rentDue ?? this.rentDue,
      rentPaid: rentPaid ?? this.rentPaid,
      arrearsAmount: arrearsAmount ?? this.arrearsAmount,
      status: status ?? this.status,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      noticeSent: noticeSent ?? this.noticeSent,
      noticeDate: noticeDate ?? this.noticeDate,
      noticeType: noticeType ?? this.noticeType,
      legalAction: legalAction ?? this.legalAction,
      legalReference: legalReference ?? this.legalReference,
      courtDate: courtDate ?? this.courtDate,
      recoveryAmount: recoveryAmount ?? this.recoveryAmount,
      writeOffAmount: writeOffAmount ?? this.writeOffAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lease: lease ?? this.lease,
      org: org ?? this.org,
      tenant: tenant ?? this.tenant,
    );
  }
}
