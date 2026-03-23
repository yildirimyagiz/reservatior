
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'export_status.dart';


class Job implements PrismaModel<String, Job> , Id<String> {
    @override
String? id;
	String? orgId;
	String? type;
	dynamic payload;
	ExportStatus? status;
	DateTime? runAt;
	int? attempts;
	String? lastError;
	DateTime? lockedAt;
	String? lockedBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Job({ this.id,
	 this.orgId,
	 this.type,
	required this.payload,
	 this.status = ExportStatus.QUEUED,
	 this.runAt,
	 this.attempts = 0,
	 this.lastError,
	 this.lockedAt,
	 this.lockedBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Job, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"type": (m) => m.type,

	"payload": (m) => m.payload,

	"status": (m) => m.status,

	"runAt": (m) => m.runAt,

	"attempts": (m) => m.attempts,

	"lastError": (m) => m.lastError,

	"lockedAt": (m) => m.lockedAt,

	"lockedBy": (m) => m.lockedBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Job) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Job');
    }
    return propFunction as V? Function(Job);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Job.fromJson(JsonMap json) =>
      Job(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	type: json['type'] as String?,
	payload: json['payload'] as dynamic,
	status: json['status'] != null ? ExportStatus.fromJson(json['status']) : null,
	runAt: json['runAt'] != null ? DateTime.parse(json['runAt']) : null,
	attempts: int.tryParse(json['attempts'].toString()),
	lastError: json['lastError'] as String?,
	lockedAt: json['lockedAt'] != null ? DateTime.parse(json['lockedAt']) : null,
	lockedBy: json['lockedBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Job copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? type,
		Value<dynamic>? payload,
		Value<ExportStatus?>? status,
		Value<DateTime?>? runAt,
		Value<int?>? attempts,
		Value<String?>? lastError,
		Value<DateTime?>? lockedAt,
		Value<String?>? lockedBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
        }) {
        return Job(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		type: type != null ? type.value : this.type,
		payload: payload != null ? payload.value : this.payload,
		status: status != null ? status.value : this.status,
		runAt: runAt != null ? runAt.value : this.runAt,
		attempts: attempts != null ? attempts.value : this.attempts,
		lastError: lastError != null ? lastError.value : this.lastError,
		lockedAt: lockedAt != null ? lockedAt.value : this.lockedAt,
		lockedBy: lockedBy != null ? lockedBy.value : this.lockedBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Job copyWithInstanceValues(Job job) {
        return Job(
            id: job.id ?? id,
		orgId: job.orgId ?? orgId,
		type: job.type ?? type,
		payload: job.payload ?? payload,
		status: job.status ?? status,
		runAt: job.runAt ?? runAt,
		attempts: job.attempts ?? attempts,
		lastError: job.lastError ?? lastError,
		lockedAt: job.lockedAt ?? lockedAt,
		lockedBy: job.lockedBy ?? lockedBy,
		createdAt: job.createdAt ?? createdAt,
		updatedAt: job.updatedAt ?? updatedAt,
		deletedAt: job.deletedAt ?? deletedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Job mergeWithInstanceValues(Job job) {
        return Job(
            id: job.$assignedFields.contains('id') ? job.id : id,
		orgId: job.$assignedFields.contains('orgId') ? job.orgId : orgId,
		type: job.$assignedFields.contains('type') ? job.type : type,
		payload: job.$assignedFields.contains('payload') ? job.payload : payload,
		status: job.$assignedFields.contains('status') ? job.status : status,
		runAt: job.$assignedFields.contains('runAt') ? job.runAt : runAt,
		attempts: job.$assignedFields.contains('attempts') ? job.attempts : attempts,
		lastError: job.$assignedFields.contains('lastError') ? job.lastError : lastError,
		lockedAt: job.$assignedFields.contains('lockedAt') ? job.lockedAt : lockedAt,
		lockedBy: job.$assignedFields.contains('lockedBy') ? job.lockedBy : lockedBy,
		createdAt: job.$assignedFields.contains('createdAt') ? job.createdAt : createdAt,
		updatedAt: job.$assignedFields.contains('updatedAt') ? job.updatedAt : updatedAt,
		deletedAt: job.$assignedFields.contains('deletedAt') ? job.deletedAt : deletedAt
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Job updateWithInstanceValues(Job job) {
        if (job.$assignedFields.contains('id')) { id = job.id; }
		if (job.$assignedFields.contains('orgId')) { orgId = job.orgId; }
		if (job.$assignedFields.contains('type')) { type = job.type; }
		if (job.$assignedFields.contains('payload')) { payload = job.payload; }
		if (job.$assignedFields.contains('status')) { status = job.status; }
		if (job.$assignedFields.contains('runAt')) { runAt = job.runAt; }
		if (job.$assignedFields.contains('attempts')) { attempts = job.attempts; }
		if (job.$assignedFields.contains('lastError')) { lastError = job.lastError; }
		if (job.$assignedFields.contains('lockedAt')) { lockedAt = job.lockedAt; }
		if (job.$assignedFields.contains('lockedBy')) { lockedBy = job.lockedBy; }
		if (job.$assignedFields.contains('createdAt')) { createdAt = job.createdAt; }
		if (job.$assignedFields.contains('updatedAt')) { updatedAt = job.updatedAt; }
		if (job.$assignedFields.contains('deletedAt')) { deletedAt = job.deletedAt; }
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
          ? {...?serializedTypes, 'Job'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(type != null) 'type': type,
	if(payload != null) 'payload': payload,
	if(status != null) 'status': status?.toJson(),
	if(runAt != null) 'runAt': runAt?.toIso8601String(),
	if(attempts != null) 'attempts': attempts,
	if(lastError != null) 'lastError': lastError,
	if(lockedAt != null) 'lockedAt': lockedAt?.toIso8601String(),
	if(lockedBy != null) 'lockedBy': lockedBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String()
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Job &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    