import 'automation_rule.dart';
import 'organization.dart';

class AutomationExecution {
  final String id;
  final String orgId;
  final String ruleId;
  final String status;
  final DateTime executedAt;
  final int? processingTimeMs;
  final Organization org;
  final AutomationRule rule;

  const AutomationExecution({
    required this.id,
    required this.orgId,
    required this.ruleId,
    required this.status,
    required this.executedAt,
    this.processingTimeMs,
    required this.org,
    required this.rule,
  });

  factory AutomationExecution.fromJson(Map<String, dynamic> json) {
    return AutomationExecution(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      ruleId: json['ruleId'] as String,
      status: json['status'] as String,
      executedAt: DateTime.parse(json['executedAt'] as String),
      processingTimeMs: json['processingTimeMs'] as int?,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      rule: AutomationRule.fromJson(json['rule'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'ruleId': ruleId,
      'status': status,
      'executedAt': executedAt.toIso8601String(),
      'processingTimeMs': processingTimeMs,
      'org': org.toJson(),
      'rule': rule.toJson(),
    };
  }

  AutomationExecution copyWith({
    String? id,
    String? orgId,
    String? ruleId,
    String? status,
    DateTime? executedAt,
    int? processingTimeMs,
    Organization? org,
    AutomationRule? rule,
  }) {
    return AutomationExecution(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      ruleId: ruleId ?? this.ruleId,
      status: status ?? this.status,
      executedAt: executedAt ?? this.executedAt,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      org: org ?? this.org,
      rule: rule ?? this.rule,
    );
  }
}
