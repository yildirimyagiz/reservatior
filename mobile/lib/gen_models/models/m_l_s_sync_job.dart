
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'sync_status.dart';
import 'm_l_s_connection.dart';
import 'organization.dart';


class MLSSyncJob implements PrismaModel<String, MLSSyncJob> , Id<String> {
    @override
String? id;
	String? orgId;
	String? connectionId;
	SyncStatus? status;
	DateTime? startedAt;
	DateTime? finishedAt;
	String? error;
	dynamic stats;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	MLSConnection? connection;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MLSSyncJob({ this.id,
	 this.orgId,
	 this.connectionId,
	 this.status = SyncStatus.IDLE,
	 this.startedAt,
	 this.finishedAt,
	 this.error,
	required this.stats,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.connection,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MLSSyncJob, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"connectionId": (m) => m.connectionId,

	"status": (m) => m.status,

	"startedAt": (m) => m.startedAt,

	"finishedAt": (m) => m.finishedAt,

	"error": (m) => m.error,

	"stats": (m) => m.stats,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"connection": (m) => m.connection,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MLSSyncJob) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MLSSyncJob');
    }
    return propFunction as V? Function(MLSSyncJob);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MLSSyncJob.fromJson(JsonMap json) =>
      MLSSyncJob(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	connectionId: json['connectionId'] as String?,
	status: json['status'] != null ? SyncStatus.fromJson(json['status']) : null,
	startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
	finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt']) : null,
	error: json['error'] as String?,
	stats: json['stats'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	connection: json['connection'] != null ? MLSConnection.fromJson(json['connection'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MLSSyncJob copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? connectionId,
		Value<SyncStatus?>? status,
		Value<DateTime?>? startedAt,
		Value<DateTime?>? finishedAt,
		Value<String?>? error,
		Value<dynamic>? stats,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<MLSConnection?>? connection,
		Value<Organization?>? org,
        }) {
        return MLSSyncJob(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		connectionId: connectionId != null ? connectionId.value : this.connectionId,
		status: status != null ? status.value : this.status,
		startedAt: startedAt != null ? startedAt.value : this.startedAt,
		finishedAt: finishedAt != null ? finishedAt.value : this.finishedAt,
		error: error != null ? error.value : this.error,
		stats: stats != null ? stats.value : this.stats,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		connection: connection != null ? connection.value : this.connection,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MLSSyncJob copyWithInstanceValues(MLSSyncJob mLSSyncJob) {
        return MLSSyncJob(
            id: mLSSyncJob.id ?? id,
		orgId: mLSSyncJob.orgId ?? orgId,
		connectionId: mLSSyncJob.connectionId ?? connectionId,
		status: mLSSyncJob.status ?? status,
		startedAt: mLSSyncJob.startedAt ?? startedAt,
		finishedAt: mLSSyncJob.finishedAt ?? finishedAt,
		error: mLSSyncJob.error ?? error,
		stats: mLSSyncJob.stats ?? stats,
		createdAt: mLSSyncJob.createdAt ?? createdAt,
		updatedAt: mLSSyncJob.updatedAt ?? updatedAt,
		deletedAt: mLSSyncJob.deletedAt ?? deletedAt,
		connection: mLSSyncJob.connection ?? connection,
		org: mLSSyncJob.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MLSSyncJob mergeWithInstanceValues(MLSSyncJob mLSSyncJob) {
        return MLSSyncJob(
            id: mLSSyncJob.$assignedFields.contains('id') ? mLSSyncJob.id : id,
		orgId: mLSSyncJob.$assignedFields.contains('orgId') ? mLSSyncJob.orgId : orgId,
		connectionId: mLSSyncJob.$assignedFields.contains('connectionId') ? mLSSyncJob.connectionId : connectionId,
		status: mLSSyncJob.$assignedFields.contains('status') ? mLSSyncJob.status : status,
		startedAt: mLSSyncJob.$assignedFields.contains('startedAt') ? mLSSyncJob.startedAt : startedAt,
		finishedAt: mLSSyncJob.$assignedFields.contains('finishedAt') ? mLSSyncJob.finishedAt : finishedAt,
		error: mLSSyncJob.$assignedFields.contains('error') ? mLSSyncJob.error : error,
		stats: mLSSyncJob.$assignedFields.contains('stats') ? mLSSyncJob.stats : stats,
		createdAt: mLSSyncJob.$assignedFields.contains('createdAt') ? mLSSyncJob.createdAt : createdAt,
		updatedAt: mLSSyncJob.$assignedFields.contains('updatedAt') ? mLSSyncJob.updatedAt : updatedAt,
		deletedAt: mLSSyncJob.$assignedFields.contains('deletedAt') ? mLSSyncJob.deletedAt : deletedAt,
		connection: mLSSyncJob.$assignedFields.contains('connection') ? mLSSyncJob.connection : connection,
		org: mLSSyncJob.$assignedFields.contains('org') ? mLSSyncJob.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MLSSyncJob updateWithInstanceValues(MLSSyncJob mLSSyncJob) {
        if (mLSSyncJob.$assignedFields.contains('id')) { id = mLSSyncJob.id; }
		if (mLSSyncJob.$assignedFields.contains('orgId')) { orgId = mLSSyncJob.orgId; }
		if (mLSSyncJob.$assignedFields.contains('connectionId')) { connectionId = mLSSyncJob.connectionId; }
		if (mLSSyncJob.$assignedFields.contains('status')) { status = mLSSyncJob.status; }
		if (mLSSyncJob.$assignedFields.contains('startedAt')) { startedAt = mLSSyncJob.startedAt; }
		if (mLSSyncJob.$assignedFields.contains('finishedAt')) { finishedAt = mLSSyncJob.finishedAt; }
		if (mLSSyncJob.$assignedFields.contains('error')) { error = mLSSyncJob.error; }
		if (mLSSyncJob.$assignedFields.contains('stats')) { stats = mLSSyncJob.stats; }
		if (mLSSyncJob.$assignedFields.contains('createdAt')) { createdAt = mLSSyncJob.createdAt; }
		if (mLSSyncJob.$assignedFields.contains('updatedAt')) { updatedAt = mLSSyncJob.updatedAt; }
		if (mLSSyncJob.$assignedFields.contains('deletedAt')) { deletedAt = mLSSyncJob.deletedAt; }
		if (mLSSyncJob.$assignedFields.contains('connection')) { connection = mLSSyncJob.connection; }
		if (mLSSyncJob.$assignedFields.contains('org')) { org = mLSSyncJob.org; }
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
          ? {...?serializedTypes, 'MLSSyncJob'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(connectionId != null) 'connectionId': connectionId,
	if(status != null) 'status': status?.toJson(),
	if(startedAt != null) 'startedAt': startedAt?.toIso8601String(),
	if(finishedAt != null) 'finishedAt': finishedAt?.toIso8601String(),
	if(error != null) 'error': error,
	if(stats != null) 'stats': stats,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(connection != null && (!preventCircularSerialization || !serializedModels.contains('MLSConnection'))) 'connection': connection?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MLSSyncJob &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    