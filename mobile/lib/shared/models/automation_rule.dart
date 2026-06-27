import 'automation_execution.dart';
import 'organization.dart';

class AutomationRule {
  final String id;
  final String orgId;
  final String ruleName;
  final String ruleType;
  final String triggerType;
  final bool isActive;
  final DateTime? lastExecutedAt;
  final int executionCount;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AutomationExecution> executions;
  final Organization org;

  const AutomationRule({
    required this.id,
    required this.orgId,
    required this.ruleName,
    required this.ruleType,
    required this.triggerType,
    required this.isActive,
    this.lastExecutedAt,
    required this.executionCount,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.executions = const [],
    required this.org,
  });

  factory AutomationRule.fromJson(Map<String, dynamic> json) {
    return AutomationRule(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      ruleName: json['ruleName'] as String,
      ruleType: json['ruleType'] as String,
      triggerType: json['triggerType'] as String,
      isActive: json['isActive'] as bool,
      lastExecutedAt: json['lastExecutedAt'] != null ? DateTime.parse(json['lastExecutedAt'] as String) : null,
      executionCount: json['executionCount'] as int,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      executions: (json['executions'] as List<dynamic>?)?.map((e) => AutomationExecution.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'ruleName': ruleName,
      'ruleType': ruleType,
      'triggerType': triggerType,
      'isActive': isActive,
      'lastExecutedAt': lastExecutedAt?.toIso8601String(),
      'executionCount': executionCount,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'executions': executions.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
    };
  }

  AutomationRule copyWith({
    String? id,
    String? orgId,
    String? ruleName,
    String? ruleType,
    String? triggerType,
    bool? isActive,
    DateTime? lastExecutedAt,
    int? executionCount,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<AutomationExecution>? executions,
    Organization? org,
  }) {
    return AutomationRule(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      ruleName: ruleName ?? this.ruleName,
      ruleType: ruleType ?? this.ruleType,
      triggerType: triggerType ?? this.triggerType,
      isActive: isActive ?? this.isActive,
      lastExecutedAt: lastExecutedAt ?? this.lastExecutedAt,
      executionCount: executionCount ?? this.executionCount,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      executions: executions ?? this.executions,
      org: org ?? this.org,
    );
  }
}
