
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';


class AutomationTask implements PrismaModel<String, AutomationTask> , Id<String> {
    @override
String? id;
	String? taskType;
	String? persona;
	String? command;
	String? status;
	String? schedule;
	DateTime? lastRun;
	DateTime? nextRun;
	dynamic configuration;
	dynamic result;
	String? error;
	DateTime? createdAt;
	DateTime? updatedAt;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AutomationTask({ this.id,
	 this.taskType,
	 this.persona,
	 this.command,
	 this.status,
	 this.schedule,
	 this.lastRun,
	 this.nextRun,
	required this.configuration,
	required this.result,
	 this.error,
	 this.createdAt,
	 this.updatedAt,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AutomationTask, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"taskType": (m) => m.taskType,

	"persona": (m) => m.persona,

	"command": (m) => m.command,

	"status": (m) => m.status,

	"schedule": (m) => m.schedule,

	"lastRun": (m) => m.lastRun,

	"nextRun": (m) => m.nextRun,

	"configuration": (m) => m.configuration,

	"result": (m) => m.result,

	"error": (m) => m.error,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AutomationTask) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AutomationTask');
    }
    return propFunction as V? Function(AutomationTask);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AutomationTask.fromJson(JsonMap json) =>
      AutomationTask(
        id: json['id'] as String?,
	taskType: json['taskType'] as String?,
	persona: json['persona'] as String?,
	command: json['command'] as String?,
	status: json['status'] as String?,
	schedule: json['schedule'] as String?,
	lastRun: json['lastRun'] != null ? DateTime.parse(json['lastRun']) : null,
	nextRun: json['nextRun'] != null ? DateTime.parse(json['nextRun']) : null,
	configuration: json['configuration'] as dynamic,
	result: json['result'] as dynamic,
	error: json['error'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AutomationTask copyWith({
        Value<String?>? id,
		Value<String?>? taskType,
		Value<String?>? persona,
		Value<String?>? command,
		Value<String?>? status,
		Value<String?>? schedule,
		Value<DateTime?>? lastRun,
		Value<DateTime?>? nextRun,
		Value<dynamic>? configuration,
		Value<dynamic>? result,
		Value<String?>? error,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
        }) {
        return AutomationTask(
            id: id != null ? id.value : this.id,
		taskType: taskType != null ? taskType.value : this.taskType,
		persona: persona != null ? persona.value : this.persona,
		command: command != null ? command.value : this.command,
		status: status != null ? status.value : this.status,
		schedule: schedule != null ? schedule.value : this.schedule,
		lastRun: lastRun != null ? lastRun.value : this.lastRun,
		nextRun: nextRun != null ? nextRun.value : this.nextRun,
		configuration: configuration != null ? configuration.value : this.configuration,
		result: result != null ? result.value : this.result,
		error: error != null ? error.value : this.error,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AutomationTask copyWithInstanceValues(AutomationTask automationTask) {
        return AutomationTask(
            id: automationTask.id ?? id,
		taskType: automationTask.taskType ?? taskType,
		persona: automationTask.persona ?? persona,
		command: automationTask.command ?? command,
		status: automationTask.status ?? status,
		schedule: automationTask.schedule ?? schedule,
		lastRun: automationTask.lastRun ?? lastRun,
		nextRun: automationTask.nextRun ?? nextRun,
		configuration: automationTask.configuration ?? configuration,
		result: automationTask.result ?? result,
		error: automationTask.error ?? error,
		createdAt: automationTask.createdAt ?? createdAt,
		updatedAt: automationTask.updatedAt ?? updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AutomationTask mergeWithInstanceValues(AutomationTask automationTask) {
        return AutomationTask(
            id: automationTask.$assignedFields.contains('id') ? automationTask.id : id,
		taskType: automationTask.$assignedFields.contains('taskType') ? automationTask.taskType : taskType,
		persona: automationTask.$assignedFields.contains('persona') ? automationTask.persona : persona,
		command: automationTask.$assignedFields.contains('command') ? automationTask.command : command,
		status: automationTask.$assignedFields.contains('status') ? automationTask.status : status,
		schedule: automationTask.$assignedFields.contains('schedule') ? automationTask.schedule : schedule,
		lastRun: automationTask.$assignedFields.contains('lastRun') ? automationTask.lastRun : lastRun,
		nextRun: automationTask.$assignedFields.contains('nextRun') ? automationTask.nextRun : nextRun,
		configuration: automationTask.$assignedFields.contains('configuration') ? automationTask.configuration : configuration,
		result: automationTask.$assignedFields.contains('result') ? automationTask.result : result,
		error: automationTask.$assignedFields.contains('error') ? automationTask.error : error,
		createdAt: automationTask.$assignedFields.contains('createdAt') ? automationTask.createdAt : createdAt,
		updatedAt: automationTask.$assignedFields.contains('updatedAt') ? automationTask.updatedAt : updatedAt
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AutomationTask updateWithInstanceValues(AutomationTask automationTask) {
        if (automationTask.$assignedFields.contains('id')) { id = automationTask.id; }
		if (automationTask.$assignedFields.contains('taskType')) { taskType = automationTask.taskType; }
		if (automationTask.$assignedFields.contains('persona')) { persona = automationTask.persona; }
		if (automationTask.$assignedFields.contains('command')) { command = automationTask.command; }
		if (automationTask.$assignedFields.contains('status')) { status = automationTask.status; }
		if (automationTask.$assignedFields.contains('schedule')) { schedule = automationTask.schedule; }
		if (automationTask.$assignedFields.contains('lastRun')) { lastRun = automationTask.lastRun; }
		if (automationTask.$assignedFields.contains('nextRun')) { nextRun = automationTask.nextRun; }
		if (automationTask.$assignedFields.contains('configuration')) { configuration = automationTask.configuration; }
		if (automationTask.$assignedFields.contains('result')) { result = automationTask.result; }
		if (automationTask.$assignedFields.contains('error')) { error = automationTask.error; }
		if (automationTask.$assignedFields.contains('createdAt')) { createdAt = automationTask.createdAt; }
		if (automationTask.$assignedFields.contains('updatedAt')) { updatedAt = automationTask.updatedAt; }
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
          ? {...?serializedTypes, 'AutomationTask'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(taskType != null) 'taskType': taskType,
	if(persona != null) 'persona': persona,
	if(command != null) 'command': command,
	if(status != null) 'status': status,
	if(schedule != null) 'schedule': schedule,
	if(lastRun != null) 'lastRun': lastRun?.toIso8601String(),
	if(nextRun != null) 'nextRun': nextRun?.toIso8601String(),
	if(configuration != null) 'configuration': configuration,
	if(result != null) 'result': result,
	if(error != null) 'error': error,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String()
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AutomationTask &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    