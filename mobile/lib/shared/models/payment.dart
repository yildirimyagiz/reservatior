import 'package:reservatior/shared/enums/payment_status.dart';
import 'commission_rule.dart';
import 'currency.dart';
import 'expense.dart';
import 'extra_charge.dart';
import 'included_service.dart';
import 'lease.dart';
import 'property.dart';
import 'reservation.dart';
import 'subscription.dart';
import 'tenant.dart';

class Payment {
  final String id;
  final String tenantId;
  final String? leaseId;
  final double amount;
  final String type;
  final String currencyId;
  final DateTime paymentDate;
  final DateTime dueDate;
  final PaymentStatus status;
  final String? paymentMethod;
  final String? reference;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? stripePaymentIntentId;
  final String? stripePaymentMethodId;
  final String? stripeClientSecret;
  final String? stripeStatus;
  final String? stripeError;
  final String? propertyId;
  final String? expenseId;
  final String? reservationId;
  final String? subscriptionId;
  final String? commissionRuleId;
  final String? includedServiceId;
  final String? extraChargeId;
  final CommissionRule? commissionRule;
  final Currency currency;
  final Expense? expense;
  final ExtraCharge? extraCharge;
  final IncludedService? includedService;
  final Lease? lease;
  final Property? property;
  final Reservation? reservation;
  final Subscription? subscription;
  final Tenant tenant;

  const Payment({
    required this.id,
    required this.tenantId,
    this.leaseId,
    required this.amount,
    required this.type,
    required this.currencyId,
    required this.paymentDate,
    required this.dueDate,
    required this.status,
    this.paymentMethod,
    this.reference,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.stripePaymentIntentId,
    this.stripePaymentMethodId,
    this.stripeClientSecret,
    this.stripeStatus,
    this.stripeError,
    this.propertyId,
    this.expenseId,
    this.reservationId,
    this.subscriptionId,
    this.commissionRuleId,
    this.includedServiceId,
    this.extraChargeId,
    this.commissionRule,
    required this.currency,
    this.expense,
    this.extraCharge,
    this.includedService,
    this.lease,
    this.property,
    this.reservation,
    this.subscription,
    required this.tenant,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String,
      leaseId: json['leaseId'] as String?,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      currencyId: json['currencyId'] as String,
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: PaymentStatus.values.firstWhere((v) => v.name == json['status']),
      paymentMethod: json['paymentMethod'] as String?,
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      stripePaymentIntentId: json['stripePaymentIntentId'] as String?,
      stripePaymentMethodId: json['stripePaymentMethodId'] as String?,
      stripeClientSecret: json['stripeClientSecret'] as String?,
      stripeStatus: json['stripeStatus'] as String?,
      stripeError: json['stripeError'] as String?,
      propertyId: json['propertyId'] as String?,
      expenseId: json['expenseId'] as String?,
      reservationId: json['reservationId'] as String?,
      subscriptionId: json['subscriptionId'] as String?,
      commissionRuleId: json['commissionRuleId'] as String?,
      includedServiceId: json['includedServiceId'] as String?,
      extraChargeId: json['extraChargeId'] as String?,
      commissionRule: json['CommissionRule'] != null ? CommissionRule.fromJson(json['CommissionRule'] as Map<String, dynamic>) : null,
      currency: Currency.fromJson(json['Currency'] as Map<String, dynamic>),
      expense: json['Expense'] != null ? Expense.fromJson(json['Expense'] as Map<String, dynamic>) : null,
      extraCharge: json['ExtraCharge'] != null ? ExtraCharge.fromJson(json['ExtraCharge'] as Map<String, dynamic>) : null,
      includedService: json['IncludedService'] != null ? IncludedService.fromJson(json['IncludedService'] as Map<String, dynamic>) : null,
      lease: json['Lease'] != null ? Lease.fromJson(json['Lease'] as Map<String, dynamic>) : null,
      property: json['Property'] != null ? Property.fromJson(json['Property'] as Map<String, dynamic>) : null,
      reservation: json['Reservation'] != null ? Reservation.fromJson(json['Reservation'] as Map<String, dynamic>) : null,
      subscription: json['Subscription'] != null ? Subscription.fromJson(json['Subscription'] as Map<String, dynamic>) : null,
      tenant: Tenant.fromJson(json['Tenant'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenantId': tenantId,
      'leaseId': leaseId,
      'amount': amount,
      'type': type,
      'currencyId': currencyId,
      'paymentDate': paymentDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'paymentMethod': paymentMethod,
      'reference': reference,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'stripePaymentIntentId': stripePaymentIntentId,
      'stripePaymentMethodId': stripePaymentMethodId,
      'stripeClientSecret': stripeClientSecret,
      'stripeStatus': stripeStatus,
      'stripeError': stripeError,
      'propertyId': propertyId,
      'expenseId': expenseId,
      'reservationId': reservationId,
      'subscriptionId': subscriptionId,
      'commissionRuleId': commissionRuleId,
      'includedServiceId': includedServiceId,
      'extraChargeId': extraChargeId,
      'CommissionRule': commissionRule?.toJson(),
      'Currency': currency.toJson(),
      'Expense': expense?.toJson(),
      'ExtraCharge': extraCharge?.toJson(),
      'IncludedService': includedService?.toJson(),
      'Lease': lease?.toJson(),
      'Property': property?.toJson(),
      'Reservation': reservation?.toJson(),
      'Subscription': subscription?.toJson(),
      'Tenant': tenant.toJson(),
    };
  }

  Payment copyWith({
    String? id,
    String? tenantId,
    String? leaseId,
    double? amount,
    String? type,
    String? currencyId,
    DateTime? paymentDate,
    DateTime? dueDate,
    PaymentStatus? status,
    String? paymentMethod,
    String? reference,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? stripePaymentIntentId,
    String? stripePaymentMethodId,
    String? stripeClientSecret,
    String? stripeStatus,
    String? stripeError,
    String? propertyId,
    String? expenseId,
    String? reservationId,
    String? subscriptionId,
    String? commissionRuleId,
    String? includedServiceId,
    String? extraChargeId,
    CommissionRule? commissionRule,
    Currency? currency,
    Expense? expense,
    ExtraCharge? extraCharge,
    IncludedService? includedService,
    Lease? lease,
    Property? property,
    Reservation? reservation,
    Subscription? subscription,
    Tenant? tenant,
  }) {
    return Payment(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      leaseId: leaseId ?? this.leaseId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      currencyId: currencyId ?? this.currencyId,
      paymentDate: paymentDate ?? this.paymentDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      stripePaymentIntentId: stripePaymentIntentId ?? this.stripePaymentIntentId,
      stripePaymentMethodId: stripePaymentMethodId ?? this.stripePaymentMethodId,
      stripeClientSecret: stripeClientSecret ?? this.stripeClientSecret,
      stripeStatus: stripeStatus ?? this.stripeStatus,
      stripeError: stripeError ?? this.stripeError,
      propertyId: propertyId ?? this.propertyId,
      expenseId: expenseId ?? this.expenseId,
      reservationId: reservationId ?? this.reservationId,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      commissionRuleId: commissionRuleId ?? this.commissionRuleId,
      includedServiceId: includedServiceId ?? this.includedServiceId,
      extraChargeId: extraChargeId ?? this.extraChargeId,
      commissionRule: commissionRule ?? this.commissionRule,
      currency: currency ?? this.currency,
      expense: expense ?? this.expense,
      extraCharge: extraCharge ?? this.extraCharge,
      includedService: includedService ?? this.includedService,
      lease: lease ?? this.lease,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
      subscription: subscription ?? this.subscription,
      tenant: tenant ?? this.tenant,
    );
  }
}
