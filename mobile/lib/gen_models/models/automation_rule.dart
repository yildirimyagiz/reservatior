
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'automation_execution.dart';
import 'organization.dart';


class AutomationRule implements PrismaModel<String, AutomationRule> , Id<String> {
    @override
String? id;
	String? orgId;
	String? ruleName;
	String? ruleType;
	String? triggerType;
	dynamic triggerConfig;
	dynamic conditions;
	dynamic actions;
	bool? isActive;
	DateTime? lastExecutedAt;
	int? executionCount;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	List<AutomationExecution>? executions;
	Organization? org;
	int? $executionsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AutomationRule({ this.id,
	 this.orgId,
	 this.ruleName,
	 this.ruleType,
	 this.triggerType,
	required this.triggerConfig,
	required this.conditions,
	required this.actions,
	 this.isActive = true,
	 this.lastExecutedAt,
	 this.executionCount = 0,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.executions,
	 this.org,
	this.$executionsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AutomationRule, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"ruleName": (m) => m.ruleName,

	"ruleType": (m) => m.ruleType,

	"triggerType": (m) => m.triggerType,

	"triggerConfig": (m) => m.triggerConfig,

	"conditions": (m) => m.conditions,

	"actions": (m) => m.actions,

	"isActive": (m) => m.isActive,

	"lastExecutedAt": (m) => m.lastExecutedAt,

	"executionCount": (m) => m.executionCount,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"executions": (m) => m.executions,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AutomationRule) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AutomationRule');
    }
    return propFunction as V? Function(AutomationRule);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AutomationRule.fromJson(JsonMap json) =>
      AutomationRule(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	ruleName: json['ruleName'] as String?,
	ruleType: json['ruleType'] as String?,
	triggerType: json['triggerType'] as String?,
	triggerConfig: json['triggerConfig'] as dynamic,
	conditions: json['conditions'] as dynamic,
	actions: json['actions'] as dynamic,
	isActive: json['isActive'] as bool?,
	lastExecutedAt: json['lastExecutedAt'] != null ? DateTime.parse(json['lastExecutedAt']) : null,
	executionCount: int.tryParse(json['executionCount'].toString()),
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	executions: json['executions'] != null ? createModels<AutomationExecution>((json['executions'] as List).cast<JsonMap>(), AutomationExecution.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$executionsCount: json['_count']?['executions'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AutomationRule copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? ruleName,
		Value<String?>? ruleType,
		Value<String?>? triggerType,
		Value<dynamic>? triggerConfig,
		Value<dynamic>? conditions,
		Value<dynamic>? actions,
		Value<bool?>? isActive,
		Value<DateTime?>? lastExecutedAt,
		Value<int?>? executionCount,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<List<AutomationExecution>?>? executions,
		Value<Organization?>? org,
		int? $executionsCount,
        }) {
        return AutomationRule(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		ruleName: ruleName != null ? ruleName.value : this.ruleName,
		ruleType: ruleType != null ? ruleType.value : this.ruleType,
		triggerType: triggerType != null ? triggerType.value : this.triggerType,
		triggerConfig: triggerConfig != null ? triggerConfig.value : this.triggerConfig,
		conditions: conditions != null ? conditions.value : this.conditions,
		actions: actions != null ? actions.value : this.actions,
		isActive: isActive != null ? isActive.value : this.isActive,
		lastExecutedAt: lastExecutedAt != null ? lastExecutedAt.value : this.lastExecutedAt,
		executionCount: executionCount != null ? executionCount.value : this.executionCount,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		executions: executions != null ? executions.value : this.executions,
		org: org != null ? org.value : this.org,
		$executionsCount: $executionsCount ?? this.$executionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AutomationRule copyWithInstanceValues(AutomationRule automationRule) {
        return AutomationRule(
            id: automationRule.id ?? id,
		orgId: automationRule.orgId ?? orgId,
		ruleName: automationRule.ruleName ?? ruleName,
		ruleType: automationRule.ruleType ?? ruleType,
		triggerType: automationRule.triggerType ?? triggerType,
		triggerConfig: automationRule.triggerConfig ?? triggerConfig,
		conditions: automationRule.conditions ?? conditions,
		actions: automationRule.actions ?? actions,
		isActive: automationRule.isActive ?? isActive,
		lastExecutedAt: automationRule.lastExecutedAt ?? lastExecutedAt,
		executionCount: automationRule.executionCount ?? executionCount,
		createdBy: automationRule.createdBy ?? createdBy,
		createdAt: automationRule.createdAt ?? createdAt,
		updatedAt: automationRule.updatedAt ?? updatedAt,
		executions: automationRule.executions ?? executions,
		org: automationRule.org ?? org,
		$executionsCount: automationRule.$executionsCount ?? $executionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AutomationRule mergeWithInstanceValues(AutomationRule automationRule) {
        return AutomationRule(
            id: automationRule.$assignedFields.contains('id') ? automationRule.id : id,
		orgId: automationRule.$assignedFields.contains('orgId') ? automationRule.orgId : orgId,
		ruleName: automationRule.$assignedFields.contains('ruleName') ? automationRule.ruleName : ruleName,
		ruleType: automationRule.$assignedFields.contains('ruleType') ? automationRule.ruleType : ruleType,
		triggerType: automationRule.$assignedFields.contains('triggerType') ? automationRule.triggerType : triggerType,
		triggerConfig: automationRule.$assignedFields.contains('triggerConfig') ? automationRule.triggerConfig : triggerConfig,
		conditions: automationRule.$assignedFields.contains('conditions') ? automationRule.conditions : conditions,
		actions: automationRule.$assignedFields.contains('actions') ? automationRule.actions : actions,
		isActive: automationRule.$assignedFields.contains('isActive') ? automationRule.isActive : isActive,
		lastExecutedAt: automationRule.$assignedFields.contains('lastExecutedAt') ? automationRule.lastExecutedAt : lastExecutedAt,
		executionCount: automationRule.$assignedFields.contains('executionCount') ? automationRule.executionCount : executionCount,
		createdBy: automationRule.$assignedFields.contains('createdBy') ? automationRule.createdBy : createdBy,
		createdAt: automationRule.$assignedFields.contains('createdAt') ? automationRule.createdAt : createdAt,
		updatedAt: automationRule.$assignedFields.contains('updatedAt') ? automationRule.updatedAt : updatedAt,
		executions: (automationRule.$assignedFields.contains('executions') && automationRule.executions != null) ? mergeModelLists(executions, automationRule.executions) : executions,
		org: automationRule.$assignedFields.contains('org') ? automationRule.org : org,
		$executionsCount: automationRule.$executionsCount ?? $executionsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AutomationRule updateWithInstanceValues(AutomationRule automationRule) {
        if (automationRule.$assignedFields.contains('id')) { id = automationRule.id; }
		if (automationRule.$assignedFields.contains('orgId')) { orgId = automationRule.orgId; }
		if (automationRule.$assignedFields.contains('ruleName')) { ruleName = automationRule.ruleName; }
		if (automationRule.$assignedFields.contains('ruleType')) { ruleType = automationRule.ruleType; }
		if (automationRule.$assignedFields.contains('triggerType')) { triggerType = automationRule.triggerType; }
		if (automationRule.$assignedFields.contains('triggerConfig')) { triggerConfig = automationRule.triggerConfig; }
		if (automationRule.$assignedFields.contains('conditions')) { conditions = automationRule.conditions; }
		if (automationRule.$assignedFields.contains('actions')) { actions = automationRule.actions; }
		if (automationRule.$assignedFields.contains('isActive')) { isActive = automationRule.isActive; }
		if (automationRule.$assignedFields.contains('lastExecutedAt')) { lastExecutedAt = automationRule.lastExecutedAt; }
		if (automationRule.$assignedFields.contains('executionCount')) { executionCount = automationRule.executionCount; }
		if (automationRule.$assignedFields.contains('createdBy')) { createdBy = automationRule.createdBy; }
		if (automationRule.$assignedFields.contains('createdAt')) { createdAt = automationRule.createdAt; }
		if (automationRule.$assignedFields.contains('updatedAt')) { updatedAt = automationRule.updatedAt; }
		if (automationRule.$assignedFields.contains('executions') && automationRule.executions != null) { executions = mergeModelLists(executions, automationRule.executions); }
		if (automationRule.$assignedFields.contains('org')) { org = automationRule.org; }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'AutomationRule'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(ruleName != null) 'ruleName': ruleName,
	if(ruleType != null) 'ruleType': ruleType,
	if(triggerType != null) 'triggerType': triggerType,
	if(triggerConfig != null) 'triggerConfig': triggerConfig,
	if(conditions != null) 'conditions': conditions,
	if(actions != null) 'actions': actions,
	if(isActive != null) 'isActive': isActive,
	if(lastExecutedAt != null) 'lastExecutedAt': lastExecutedAt?.toIso8601String(),
	if(executionCount != null) 'executionCount': executionCount,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(executions != null && (!preventCircularSerialization || !serializedModels.contains('AutomationExecution'))) 'executions': executions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($executionsCount != null) '_count': { 
		if ($executionsCount != null) 'executions': $executionsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AutomationRule &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    