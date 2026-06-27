import 'package:reservatior/shared/enums/expense_status.dart';
import 'package:reservatior/shared/enums/expense_type.dart';
import 'agency.dart';
import 'currency.dart';
import 'extra_charge.dart';
import 'facility.dart';
import 'included_service.dart';
import 'payment.dart';
import 'property.dart';
import 'tenant.dart';

class Expense {
  final String id;
  final String? propertyId;
  final String? tenantId;
  final String? agencyId;
  final ExpenseType type;
  final double amount;
  final String currencyId;
  final DateTime? dueDate;
  final DateTime? paidDate;
  final ExpenseStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? facilityId;
  final String? includedServiceId;
  final String? extraChargeId;
  final Agency? agency;
  final Currency currency;
  final ExtraCharge? extraCharge;
  final Facility? facility;
  final IncludedService? includedService;
  final Property? property;
  final Tenant? tenant;
  final List<Payment> payment;

  const Expense({
    required this.id,
    this.propertyId,
    this.tenantId,
    this.agencyId,
    required this.type,
    required this.amount,
    required this.currencyId,
    this.dueDate,
    this.paidDate,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.facilityId,
    this.includedServiceId,
    this.extraChargeId,
    this.agency,
    required this.currency,
    this.extraCharge,
    this.facility,
    this.includedService,
    this.property,
    this.tenant,
    this.payment = const [],
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String?,
      tenantId: json['tenantId'] as String?,
      agencyId: json['agencyId'] as String?,
      type: ExpenseType.values.firstWhere((v) => v.name == json['type']),
      amount: (json['amount'] as num).toDouble(),
      currencyId: json['currencyId'] as String,
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      paidDate: json['paidDate'] != null ? DateTime.parse(json['paidDate'] as String) : null,
      status: ExpenseStatus.values.firstWhere((v) => v.name == json['status']),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      facilityId: json['facilityId'] as String?,
      includedServiceId: json['includedServiceId'] as String?,
      extraChargeId: json['extraChargeId'] as String?,
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      currency: Currency.fromJson(json['Currency'] as Map<String, dynamic>),
      extraCharge: json['ExtraCharge'] != null ? ExtraCharge.fromJson(json['ExtraCharge'] as Map<String, dynamic>) : null,
      facility: json['Facility'] != null ? Facility.fromJson(json['Facility'] as Map<String, dynamic>) : null,
      includedService: json['IncludedService'] != null ? IncludedService.fromJson(json['IncludedService'] as Map<String, dynamic>) : null,
      property: json['Property'] != null ? Property.fromJson(json['Property'] as Map<String, dynamic>) : null,
      tenant: json['Tenant'] != null ? Tenant.fromJson(json['Tenant'] as Map<String, dynamic>) : null,
      payment: (json['Payment'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'tenantId': tenantId,
      'agencyId': agencyId,
      'type': type.name,
      'amount': amount,
      'currencyId': currencyId,
      'dueDate': dueDate?.toIso8601String(),
      'paidDate': paidDate?.toIso8601String(),
      'status': status.name,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'facilityId': facilityId,
      'includedServiceId': includedServiceId,
      'extraChargeId': extraChargeId,
      'Agency': agency?.toJson(),
      'Currency': currency.toJson(),
      'ExtraCharge': extraCharge?.toJson(),
      'Facility': facility?.toJson(),
      'IncludedService': includedService?.toJson(),
      'Property': property?.toJson(),
      'Tenant': tenant?.toJson(),
      'Payment': payment.map((e) => e.toJson()).toList(),
    };
  }

  Expense copyWith({
    String? id,
    String? propertyId,
    String? tenantId,
    String? agencyId,
    ExpenseType? type,
    double? amount,
    String? currencyId,
    DateTime? dueDate,
    DateTime? paidDate,
    ExpenseStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? facilityId,
    String? includedServiceId,
    String? extraChargeId,
    Agency? agency,
    Currency? currency,
    ExtraCharge? extraCharge,
    Facility? facility,
    IncludedService? includedService,
    Property? property,
    Tenant? tenant,
    List<Payment>? payment,
  }) {
    return Expense(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      tenantId: tenantId ?? this.tenantId,
      agencyId: agencyId ?? this.agencyId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currencyId: currencyId ?? this.currencyId,
      dueDate: dueDate ?? this.dueDate,
      paidDate: paidDate ?? this.paidDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      facilityId: facilityId ?? this.facilityId,
      includedServiceId: includedServiceId ?? this.includedServiceId,
      extraChargeId: extraChargeId ?? this.extraChargeId,
      agency: agency ?? this.agency,
      currency: currency ?? this.currency,
      extraCharge: extraCharge ?? this.extraCharge,
      facility: facility ?? this.facility,
      includedService: includedService ?? this.includedService,
      property: property ?? this.property,
      tenant: tenant ?? this.tenant,
      payment: payment ?? this.payment,
    );
  }
}
