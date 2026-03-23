
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'automation_rule.dart';


class AutomationExecution implements PrismaModel<String, AutomationExecution> , Id<String> {
    @override
String? id;
	String? orgId;
	String? ruleId;
	dynamic triggerEvent;
	dynamic executionData;
	String? status;
	DateTime? executedAt;
	int? processingTimeMs;
	Organization? org;
	AutomationRule? rule;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AutomationExecution({ this.id,
	 this.orgId,
	 this.ruleId,
	required this.triggerEvent,
	required this.executionData,
	 this.status = "COMPLETED",
	 this.executedAt,
	 this.processingTimeMs,
	 this.org,
	 this.rule,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AutomationExecution, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"ruleId": (m) => m.ruleId,

	"triggerEvent": (m) => m.triggerEvent,

	"executionData": (m) => m.executionData,

	"status": (m) => m.status,

	"executedAt": (m) => m.executedAt,

	"processingTimeMs": (m) => m.processingTimeMs,

	"org": (m) => m.org,

	"rule": (m) => m.rule,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AutomationExecution) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AutomationExecution');
    }
    return propFunction as V? Function(AutomationExecution);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AutomationExecution.fromJson(JsonMap json) =>
      AutomationExecution(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	ruleId: json['ruleId'] as String?,
	triggerEvent: json['triggerEvent'] as dynamic,
	executionData: json['executionData'] as dynamic,
	status: json['status'] as String?,
	executedAt: json['executedAt'] != null ? DateTime.parse(json['executedAt']) : null,
	processingTimeMs: int.tryParse(json['processingTimeMs'].toString()),
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	rule: json['rule'] != null ? AutomationRule.fromJson(json['rule'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AutomationExecution copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? ruleId,
		Value<dynamic>? triggerEvent,
		Value<dynamic>? executionData,
		Value<String?>? status,
		Value<DateTime?>? executedAt,
		Value<int?>? processingTimeMs,
		Value<Organization?>? org,
		Value<AutomationRule?>? rule,
        }) {
        return AutomationExecution(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		ruleId: ruleId != null ? ruleId.value : this.ruleId,
		triggerEvent: triggerEvent != null ? triggerEvent.value : this.triggerEvent,
		executionData: executionData != null ? executionData.value : this.executionData,
		status: status != null ? status.value : this.status,
		executedAt: executedAt != null ? executedAt.value : this.executedAt,
		processingTimeMs: processingTimeMs != null ? processingTimeMs.value : this.processingTimeMs,
		org: org != null ? org.value : this.org,
		rule: rule != null ? rule.value : this.rule
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AutomationExecution copyWithInstanceValues(AutomationExecution automationExecution) {
        return AutomationExecution(
            id: automationExecution.id ?? id,
		orgId: automationExecution.orgId ?? orgId,
		ruleId: automationExecution.ruleId ?? ruleId,
		triggerEvent: automationExecution.triggerEvent ?? triggerEvent,
		executionData: automationExecution.executionData ?? executionData,
		status: automationExecution.status ?? status,
		executedAt: automationExecution.executedAt ?? executedAt,
		processingTimeMs: automationExecution.processingTimeMs ?? processingTimeMs,
		org: automationExecution.org ?? org,
		rule: automationExecution.rule ?? rule
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AutomationExecution mergeWithInstanceValues(AutomationExecution automationExecution) {
        return AutomationExecution(
            id: automationExecution.$assignedFields.contains('id') ? automationExecution.id : id,
		orgId: automationExecution.$assignedFields.contains('orgId') ? automationExecution.orgId : orgId,
		ruleId: automationExecution.$assignedFields.contains('ruleId') ? automationExecution.ruleId : ruleId,
		triggerEvent: automationExecution.$assignedFields.contains('triggerEvent') ? automationExecution.triggerEvent : triggerEvent,
		executionData: automationExecution.$assignedFields.contains('executionData') ? automationExecution.executionData : executionData,
		status: automationExecution.$assignedFields.contains('status') ? automationExecution.status : status,
		executedAt: automationExecution.$assignedFields.contains('executedAt') ? automationExecution.executedAt : executedAt,
		processingTimeMs: automationExecution.$assignedFields.contains('processingTimeMs') ? automationExecution.processingTimeMs : processingTimeMs,
		org: automationExecution.$assignedFields.contains('org') ? automationExecution.org : org,
		rule: automationExecution.$assignedFields.contains('rule') ? automationExecution.rule : rule
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AutomationExecution updateWithInstanceValues(AutomationExecution automationExecution) {
        if (automationExecution.$assignedFields.contains('id')) { id = automationExecution.id; }
		if (automationExecution.$assignedFields.contains('orgId')) { orgId = automationExecution.orgId; }
		if (automationExecution.$assignedFields.contains('ruleId')) { ruleId = automationExecution.ruleId; }
		if (automationExecution.$assignedFields.contains('triggerEvent')) { triggerEvent = automationExecution.triggerEvent; }
		if (automationExecution.$assignedFields.contains('executionData')) { executionData = automationExecution.executionData; }
		if (automationExecution.$assignedFields.contains('status')) { status = automationExecution.status; }
		if (automationExecution.$assignedFields.contains('executedAt')) { executedAt = automationExecution.executedAt; }
		if (automationExecution.$assignedFields.contains('processingTimeMs')) { processingTimeMs = automationExecution.processingTimeMs; }
		if (automationExecution.$assignedFields.contains('org')) { org = automationExecution.org; }
		if (automationExecution.$assignedFields.contains('rule')) { rule = automationExecution.rule; }
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
          ? {...?serializedTypes, 'AutomationExecution'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(ruleId != null) 'ruleId': ruleId,
	if(triggerEvent != null) 'triggerEvent': triggerEvent,
	if(executionData != null) 'executionData': executionData,
	if(status != null) 'status': status,
	if(executedAt != null) 'executedAt': executedAt?.toIso8601String(),
	if(processingTimeMs != null) 'processingTimeMs': processingTimeMs,
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(rule != null && (!preventCircularSerialization || !serializedModels.contains('AutomationRule'))) 'rule': rule?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AutomationExecution &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    