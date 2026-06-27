import 'package:reservatior/shared/enums/commission_type_us.dart';
import 'package:reservatior/shared/enums/payment_method_us.dart';
import 'package:reservatior/shared/enums/payout_status_usa.dart';
import 'commission.dart';
import 'contact.dart';
import 'deal.dart';
import 'organization.dart';

class Payout {
  final String id;
  final String orgId;
  final String? dealId;
  final String? commissionId;
  final String? recipientId;
  final String? processorId;
  final PayoutStatusUSA payoutStatus;
  final CommissionTypeUS payoutType;
  final double amount;
  final double grossAmount;
  final double netAmount;
  final double taxWithheld;
  final double fees;
  final PaymentMethodUS paymentMethod;
  final DateTime? scheduledDate;
  final DateTime? processedDate;
  final DateTime? completedDate;
  final String? referenceNumber;
  final String? trackingNumber;
  final String? checkNumber;
  final String? wireReference;
  final String? achRouting;
  final DateTime? escrowReleaseDate;
  final String? holdReason;
  final String? failureReason;
  final int retryCount;
  final int maxRetries;
  final DateTime? nextRetryDate;
  final String priority;
  final bool approvalRequired;
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? notes;
  final bool taxFormGenerated;
  final bool taxFormSent;
  final bool yearEndReport;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Commission? commission;
  final Deal? deal;
  final Organization org;
  final Contact? processor;
  final Contact? recipient;

  const Payout({
    required this.id,
    required this.orgId,
    this.dealId,
    this.commissionId,
    this.recipientId,
    this.processorId,
    required this.payoutStatus,
    required this.payoutType,
    required this.amount,
    required this.grossAmount,
    required this.netAmount,
    required this.taxWithheld,
    required this.fees,
    required this.paymentMethod,
    this.scheduledDate,
    this.processedDate,
    this.completedDate,
    this.referenceNumber,
    this.trackingNumber,
    this.checkNumber,
    this.wireReference,
    this.achRouting,
    this.escrowReleaseDate,
    this.holdReason,
    this.failureReason,
    required this.retryCount,
    required this.maxRetries,
    this.nextRetryDate,
    required this.priority,
    required this.approvalRequired,
    this.approvedBy,
    this.approvedAt,
    this.notes,
    required this.taxFormGenerated,
    required this.taxFormSent,
    required this.yearEndReport,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.commission,
    this.deal,
    required this.org,
    this.processor,
    this.recipient,
  });

  factory Payout.fromJson(Map<String, dynamic> json) {
    return Payout(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      dealId: json['dealId'] as String?,
      commissionId: json['commissionId'] as String?,
      recipientId: json['recipientId'] as String?,
      processorId: json['processorId'] as String?,
      payoutStatus: PayoutStatusUSA.values.firstWhere((v) => v.name == json['payoutStatus']),
      payoutType: CommissionTypeUS.values.firstWhere((v) => v.name == json['payoutType']),
      amount: (json['amount'] as num).toDouble(),
      grossAmount: (json['grossAmount'] as num).toDouble(),
      netAmount: (json['netAmount'] as num).toDouble(),
      taxWithheld: (json['taxWithheld'] as num).toDouble(),
      fees: (json['fees'] as num).toDouble(),
      paymentMethod: PaymentMethodUS.values.firstWhere((v) => v.name == json['paymentMethod']),
      scheduledDate: json['scheduledDate'] != null ? DateTime.parse(json['scheduledDate'] as String) : null,
      processedDate: json['processedDate'] != null ? DateTime.parse(json['processedDate'] as String) : null,
      completedDate: json['completedDate'] != null ? DateTime.parse(json['completedDate'] as String) : null,
      referenceNumber: json['referenceNumber'] as String?,
      trackingNumber: json['trackingNumber'] as String?,
      checkNumber: json['checkNumber'] as String?,
      wireReference: json['wireReference'] as String?,
      achRouting: json['achRouting'] as String?,
      escrowReleaseDate: json['escrowReleaseDate'] != null ? DateTime.parse(json['escrowReleaseDate'] as String) : null,
      holdReason: json['holdReason'] as String?,
      failureReason: json['failureReason'] as String?,
      retryCount: json['retryCount'] as int,
      maxRetries: json['maxRetries'] as int,
      nextRetryDate: json['nextRetryDate'] != null ? DateTime.parse(json['nextRetryDate'] as String) : null,
      priority: json['priority'] as String,
      approvalRequired: json['approvalRequired'] as bool,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] != null ? DateTime.parse(json['approvedAt'] as String) : null,
      notes: json['notes'] as String?,
      taxFormGenerated: json['taxFormGenerated'] as bool,
      taxFormSent: json['taxFormSent'] as bool,
      yearEndReport: json['yearEndReport'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      commission: json['commission'] != null ? Commission.fromJson(json['commission'] as Map<String, dynamic>) : null,
      deal: json['deal'] != null ? Deal.fromJson(json['deal'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      processor: json['processor'] != null ? Contact.fromJson(json['processor'] as Map<String, dynamic>) : null,
      recipient: json['recipient'] != null ? Contact.fromJson(json['recipient'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'dealId': dealId,
      'commissionId': commissionId,
      'recipientId': recipientId,
      'processorId': processorId,
      'payoutStatus': payoutStatus.name,
      'payoutType': payoutType.name,
      'amount': amount,
      'grossAmount': grossAmount,
      'netAmount': netAmount,
      'taxWithheld': taxWithheld,
      'fees': fees,
      'paymentMethod': paymentMethod.name,
      'scheduledDate': scheduledDate?.toIso8601String(),
      'processedDate': processedDate?.toIso8601String(),
      'completedDate': completedDate?.toIso8601String(),
      'referenceNumber': referenceNumber,
      'trackingNumber': trackingNumber,
      'checkNumber': checkNumber,
      'wireReference': wireReference,
      'achRouting': achRouting,
      'escrowReleaseDate': escrowReleaseDate?.toIso8601String(),
      'holdReason': holdReason,
      'failureReason': failureReason,
      'retryCount': retryCount,
      'maxRetries': maxRetries,
      'nextRetryDate': nextRetryDate?.toIso8601String(),
      'priority': priority,
      'approvalRequired': approvalRequired,
      'approvedBy': approvedBy,
      'approvedAt': approvedAt?.toIso8601String(),
      'notes': notes,
      'taxFormGenerated': taxFormGenerated,
      'taxFormSent': taxFormSent,
      'yearEndReport': yearEndReport,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'commission': commission?.toJson(),
      'deal': deal?.toJson(),
      'org': org.toJson(),
      'processor': processor?.toJson(),
      'recipient': recipient?.toJson(),
    };
  }

  Payout copyWith({
    String? id,
    String? orgId,
    String? dealId,
    String? commissionId,
    String? recipientId,
    String? processorId,
    PayoutStatusUSA? payoutStatus,
    CommissionTypeUS? payoutType,
    double? amount,
    double? grossAmount,
    double? netAmount,
    double? taxWithheld,
    double? fees,
    PaymentMethodUS? paymentMethod,
    DateTime? scheduledDate,
    DateTime? processedDate,
    DateTime? completedDate,
    String? referenceNumber,
    String? trackingNumber,
    String? checkNumber,
    String? wireReference,
    String? achRouting,
    DateTime? escrowReleaseDate,
    String? holdReason,
    String? failureReason,
    int? retryCount,
    int? maxRetries,
    DateTime? nextRetryDate,
    String? priority,
    bool? approvalRequired,
    String? approvedBy,
    DateTime? approvedAt,
    String? notes,
    bool? taxFormGenerated,
    bool? taxFormSent,
    bool? yearEndReport,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Commission? commission,
    Deal? deal,
    Organization? org,
    Contact? processor,
    Contact? recipient,
  }) {
    return Payout(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      dealId: dealId ?? this.dealId,
      commissionId: commissionId ?? this.commissionId,
      recipientId: recipientId ?? this.recipientId,
      processorId: processorId ?? this.processorId,
      payoutStatus: payoutStatus ?? this.payoutStatus,
      payoutType: payoutType ?? this.payoutType,
      amount: amount ?? this.amount,
      grossAmount: grossAmount ?? this.grossAmount,
      netAmount: netAmount ?? this.netAmount,
      taxWithheld: taxWithheld ?? this.taxWithheld,
      fees: fees ?? this.fees,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      processedDate: processedDate ?? this.processedDate,
      completedDate: completedDate ?? this.completedDate,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      checkNumber: checkNumber ?? this.checkNumber,
      wireReference: wireReference ?? this.wireReference,
      achRouting: achRouting ?? this.achRouting,
      escrowReleaseDate: escrowReleaseDate ?? this.escrowReleaseDate,
      holdReason: holdReason ?? this.holdReason,
      failureReason: failureReason ?? this.failureReason,
      retryCount: retryCount ?? this.retryCount,
      maxRetries: maxRetries ?? this.maxRetries,
      nextRetryDate: nextRetryDate ?? this.nextRetryDate,
      priority: priority ?? this.priority,
      approvalRequired: approvalRequired ?? this.approvalRequired,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
      notes: notes ?? this.notes,
      taxFormGenerated: taxFormGenerated ?? this.taxFormGenerated,
      taxFormSent: taxFormSent ?? this.taxFormSent,
      yearEndReport: yearEndReport ?? this.yearEndReport,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      commission: commission ?? this.commission,
      deal: deal ?? this.deal,
      org: org ?? this.org,
      processor: processor ?? this.processor,
      recipient: recipient ?? this.recipient,
    );
  }
}
