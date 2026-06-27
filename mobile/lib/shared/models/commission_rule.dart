import 'package:reservatior/shared/enums/commission_rule_type.dart';
import 'payment.dart';
import 'reference_source.dart';

class CommissionRule {
  final String id;
  final String providerId;
  final CommissionRuleType ruleType;
  final DateTime? startDate;
  final DateTime? endDate;
  final double commission;
  final int? minVolume;
  final int? maxVolume;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final ReferenceSource provider;
  final List<Payment> payment;

  const CommissionRule({
    required this.id,
    required this.providerId,
    required this.ruleType,
    this.startDate,
    this.endDate,
    required this.commission,
    this.minVolume,
    this.maxVolume,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.provider,
    this.payment = const [],
  });

  factory CommissionRule.fromJson(Map<String, dynamic> json) {
    return CommissionRule(
      id: json['id'] as String,
      providerId: json['providerId'] as String,
      ruleType: CommissionRuleType.values.firstWhere((v) => v.name == json['ruleType']),
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      commission: (json['commission'] as num).toDouble(),
      minVolume: json['minVolume'] as int?,
      maxVolume: json['maxVolume'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      provider: ReferenceSource.fromJson(json['provider'] as Map<String, dynamic>),
      payment: (json['Payment'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'providerId': providerId,
      'ruleType': ruleType.name,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'commission': commission,
      'minVolume': minVolume,
      'maxVolume': maxVolume,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'provider': provider.toJson(),
      'Payment': payment.map((e) => e.toJson()).toList(),
    };
  }

  CommissionRule copyWith({
    String? id,
    String? providerId,
    CommissionRuleType? ruleType,
    DateTime? startDate,
    DateTime? endDate,
    double? commission,
    int? minVolume,
    int? maxVolume,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    ReferenceSource? provider,
    List<Payment>? payment,
  }) {
    return CommissionRule(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      ruleType: ruleType ?? this.ruleType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      commission: commission ?? this.commission,
      minVolume: minVolume ?? this.minVolume,
      maxVolume: maxVolume ?? this.maxVolume,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      provider: provider ?? this.provider,
      payment: payment ?? this.payment,
    );
  }
}
