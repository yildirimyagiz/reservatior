import 'package:reservatior/shared/enums/discount_type.dart';
import 'pricing_rule.dart';
import 'property.dart';
import 'reservation.dart';

class Discount {
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String? description;
  final String? code;
  final double value;
  final DiscountType type;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? maxUsage;
  final int currentUsage;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String propertyId;
  final String? pricingRuleId;
  final PricingRule? pricingRule;
  final Property property;
  final List<Reservation> reservation;

  const Discount({
    this.deletedAt,
    required this.id,
    required this.name,
    this.description,
    this.code,
    required this.value,
    required this.type,
    this.startDate,
    this.endDate,
    this.maxUsage,
    required this.currentUsage,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.propertyId,
    this.pricingRuleId,
    this.pricingRule,
    required this.property,
    this.reservation = const [],
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      code: json['code'] as String?,
      value: (json['value'] as num).toDouble(),
      type: (() {
        final valUpper = json['type']?.toString().toUpperCase() ?? '';
        return DiscountType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => DiscountType.PERCENTAGE,
        );
      })(),
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      maxUsage: json['maxUsage'] as int?,
      currentUsage: json['currentUsage'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      propertyId: json['propertyId'] as String,
      pricingRuleId: json['pricingRuleId'] as String?,
      pricingRule: json['PricingRule'] != null ? PricingRule.fromJson(json['PricingRule'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['Property'] as Map<String, dynamic>),
      reservation: (json['Reservation'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deletedAt': deletedAt?.toIso8601String(),
      'id': id,
      'name': name,
      'description': description,
      'code': code,
      'value': value,
      'type': type.name,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'maxUsage': maxUsage,
      'currentUsage': currentUsage,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'propertyId': propertyId,
      'pricingRuleId': pricingRuleId,
      'PricingRule': pricingRule?.toJson(),
      'Property': property.toJson(),
      'Reservation': reservation.map((e) => e.toJson()).toList(),
    };
  }

  Discount copyWith({
    DateTime? deletedAt,
    String? id,
    String? name,
    String? description,
    String? code,
    double? value,
    DiscountType? type,
    DateTime? startDate,
    DateTime? endDate,
    int? maxUsage,
    int? currentUsage,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? propertyId,
    String? pricingRuleId,
    PricingRule? pricingRule,
    Property? property,
    List<Reservation>? reservation,
  }) {
    return Discount(
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      code: code ?? this.code,
      value: value ?? this.value,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      maxUsage: maxUsage ?? this.maxUsage,
      currentUsage: currentUsage ?? this.currentUsage,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      propertyId: propertyId ?? this.propertyId,
      pricingRuleId: pricingRuleId ?? this.pricingRuleId,
      pricingRule: pricingRule ?? this.pricingRule,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
    );
  }
}
