import 'expense.dart';
import 'payment.dart';
import 'pricing_rule.dart';
import 'property.dart';
import 'reservation.dart';
import 'tax_record.dart';
import 'user.dart';

class Currency {
  final String id;
  final String code;
  final String name;
  final String symbol;
  final double exchangeRate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Expense> expense;
  final List<Payment> payment;
  final List<PricingRule> pricingRule;
  final List<Property> property;
  final List<Reservation> reservation;
  final List<TaxRecord> taxRecord;
  final List<User> users;

  const Currency({
    required this.id,
    required this.code,
    required this.name,
    required this.symbol,
    required this.exchangeRate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.expense = const [],
    this.payment = const [],
    this.pricingRule = const [],
    this.property = const [],
    this.reservation = const [],
    this.taxRecord = const [],
    this.users = const [],
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      exchangeRate: (json['exchangeRate'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      expense: (json['Expense'] as List<dynamic>?)?.map((e) => Expense.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      payment: (json['Payment'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      pricingRule: (json['PricingRule'] as List<dynamic>?)?.map((e) => PricingRule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      property: (json['Property'] as List<dynamic>?)?.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reservation: (json['Reservation'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      taxRecord: (json['TaxRecord'] as List<dynamic>?)?.map((e) => TaxRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      users: (json['users'] as List<dynamic>?)?.map((e) => User.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'symbol': symbol,
      'exchangeRate': exchangeRate,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'Expense': expense.map((e) => e.toJson()).toList(),
      'Payment': payment.map((e) => e.toJson()).toList(),
      'PricingRule': pricingRule.map((e) => e.toJson()).toList(),
      'Property': property.map((e) => e.toJson()).toList(),
      'Reservation': reservation.map((e) => e.toJson()).toList(),
      'TaxRecord': taxRecord.map((e) => e.toJson()).toList(),
      'users': users.map((e) => e.toJson()).toList(),
    };
  }

  Currency copyWith({
    String? id,
    String? code,
    String? name,
    String? symbol,
    double? exchangeRate,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Expense>? expense,
    List<Payment>? payment,
    List<PricingRule>? pricingRule,
    List<Property>? property,
    List<Reservation>? reservation,
    List<TaxRecord>? taxRecord,
    List<User>? users,
  }) {
    return Currency(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      expense: expense ?? this.expense,
      payment: payment ?? this.payment,
      pricingRule: pricingRule ?? this.pricingRule,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
      taxRecord: taxRecord ?? this.taxRecord,
      users: users ?? this.users,
    );
  }
}
