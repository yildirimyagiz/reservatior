
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'rental_platform.dart';
import 'sync_status.dart';
import 'sync_direction.dart';
import 'api_integration.dart';
import 'organization.dart';


class RentalSyncJob implements PrismaModel<String, RentalSyncJob> , Id<String> {
    @override
String? id;
	String? orgId;
	String? integrationId;
	RentalPlatform? platform;
	SyncStatus? status;
	String? jobType;
	SyncDirection? direction;
	DateTime? startedAt;
	DateTime? finishedAt;
	String? error;
	dynamic stats;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	ApiIntegration? integration;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    RentalSyncJob({ this.id,
	 this.orgId,
	 this.integrationId,
	 this.platform,
	 this.status = SyncStatus.IDLE,
	 this.jobType,
	 this.direction,
	 this.startedAt,
	 this.finishedAt,
	 this.error,
	required this.stats,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.integration,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<RentalSyncJob, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"integrationId": (m) => m.integrationId,

	"platform": (m) => m.platform,

	"status": (m) => m.status,

	"jobType": (m) => m.jobType,

	"direction": (m) => m.direction,

	"startedAt": (m) => m.startedAt,

	"finishedAt": (m) => m.finishedAt,

	"error": (m) => m.error,

	"stats": (m) => m.stats,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"integration": (m) => m.integration,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(RentalSyncJob) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in RentalSyncJob');
    }
    return propFunction as V? Function(RentalSyncJob);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory RentalSyncJob.fromJson(JsonMap json) =>
      RentalSyncJob(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	integrationId: json['integrationId'] as String?,
	platform: json['platform'] != null ? RentalPlatform.fromJson(json['platform']) : null,
	status: json['status'] != null ? SyncStatus.fromJson(json['status']) : null,
	jobType: json['jobType'] as String?,
	direction: json['direction'] != null ? SyncDirection.fromJson(json['direction']) : null,
	startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
	finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt']) : null,
	error: json['error'] as String?,
	stats: json['stats'] as dynamic,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	integration: json['integration'] != null ? ApiIntegration.fromJson(json['integration'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    RentalSyncJob copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? integrationId,
		Value<RentalPlatform?>? platform,
		Value<SyncStatus?>? status,
		Value<String?>? jobType,
		Value<SyncDirection?>? direction,
		Value<DateTime?>? startedAt,
		Value<DateTime?>? finishedAt,
		Value<String?>? error,
		Value<dynamic>? stats,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<ApiIntegration?>? integration,
		Value<Organization?>? org,
        }) {
        return RentalSyncJob(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		integrationId: integrationId != null ? integrationId.value : this.integrationId,
		platform: platform != null ? platform.value : this.platform,
		status: status != null ? status.value : this.status,
		jobType: jobType != null ? jobType.value : this.jobType,
		direction: direction != null ? direction.value : this.direction,
		startedAt: startedAt != null ? startedAt.value : this.startedAt,
		finishedAt: finishedAt != null ? finishedAt.value : this.finishedAt,
		error: error != null ? error.value : this.error,
		stats: stats != null ? stats.value : this.stats,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		integration: integration != null ? integration.value : this.integration,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    RentalSyncJob copyWithInstanceValues(RentalSyncJob rentalSyncJob) {
        return RentalSyncJob(
            id: rentalSyncJob.id ?? id,
		orgId: rentalSyncJob.orgId ?? orgId,
		integrationId: rentalSyncJob.integrationId ?? integrationId,
		platform: rentalSyncJob.platform ?? platform,
		status: rentalSyncJob.status ?? status,
		jobType: rentalSyncJob.jobType ?? jobType,
		direction: rentalSyncJob.direction ?? direction,
		startedAt: rentalSyncJob.startedAt ?? startedAt,
		finishedAt: rentalSyncJob.finishedAt ?? finishedAt,
		error: rentalSyncJob.error ?? error,
		stats: rentalSyncJob.stats ?? stats,
		createdBy: rentalSyncJob.createdBy ?? createdBy,
		createdAt: rentalSyncJob.createdAt ?? createdAt,
		updatedAt: rentalSyncJob.updatedAt ?? updatedAt,
		deletedAt: rentalSyncJob.deletedAt ?? deletedAt,
		integration: rentalSyncJob.integration ?? integration,
		org: rentalSyncJob.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    RentalSyncJob mergeWithInstanceValues(RentalSyncJob rentalSyncJob) {
        return RentalSyncJob(
            id: rentalSyncJob.$assignedFields.contains('id') ? rentalSyncJob.id : id,
		orgId: rentalSyncJob.$assignedFields.contains('orgId') ? rentalSyncJob.orgId : orgId,
		integrationId: rentalSyncJob.$assignedFields.contains('integrationId') ? rentalSyncJob.integrationId : integrationId,
		platform: rentalSyncJob.$assignedFields.contains('platform') ? rentalSyncJob.platform : platform,
		status: rentalSyncJob.$assignedFields.contains('status') ? rentalSyncJob.status : status,
		jobType: rentalSyncJob.$assignedFields.contains('jobType') ? rentalSyncJob.jobType : jobType,
		direction: rentalSyncJob.$assignedFields.contains('direction') ? rentalSyncJob.direction : direction,
		startedAt: rentalSyncJob.$assignedFields.contains('startedAt') ? rentalSyncJob.startedAt : startedAt,
		finishedAt: rentalSyncJob.$assignedFields.contains('finishedAt') ? rentalSyncJob.finishedAt : finishedAt,
		error: rentalSyncJob.$assignedFields.contains('error') ? rentalSyncJob.error : error,
		stats: rentalSyncJob.$assignedFields.contains('stats') ? rentalSyncJob.stats : stats,
		createdBy: rentalSyncJob.$assignedFields.contains('createdBy') ? rentalSyncJob.createdBy : createdBy,
		createdAt: rentalSyncJob.$assignedFields.contains('createdAt') ? rentalSyncJob.createdAt : createdAt,
		updatedAt: rentalSyncJob.$assignedFields.contains('updatedAt') ? rentalSyncJob.updatedAt : updatedAt,
		deletedAt: rentalSyncJob.$assignedFields.contains('deletedAt') ? rentalSyncJob.deletedAt : deletedAt,
		integration: rentalSyncJob.$assignedFields.contains('integration') ? rentalSyncJob.integration : integration,
		org: rentalSyncJob.$assignedFields.contains('org') ? rentalSyncJob.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    RentalSyncJob updateWithInstanceValues(RentalSyncJob rentalSyncJob) {
        if (rentalSyncJob.$assignedFields.contains('id')) { id = rentalSyncJob.id; }
		if (rentalSyncJob.$assignedFields.contains('orgId')) { orgId = rentalSyncJob.orgId; }
		if (rentalSyncJob.$assignedFields.contains('integrationId')) { integrationId = rentalSyncJob.integrationId; }
		if (rentalSyncJob.$assignedFields.contains('platform')) { platform = rentalSyncJob.platform; }
		if (rentalSyncJob.$assignedFields.contains('status')) { status = rentalSyncJob.status; }
		if (rentalSyncJob.$assignedFields.contains('jobType')) { jobType = rentalSyncJob.jobType; }
		if (rentalSyncJob.$assignedFields.contains('direction')) { direction = rentalSyncJob.direction; }
		if (rentalSyncJob.$assignedFields.contains('startedAt')) { startedAt = rentalSyncJob.startedAt; }
		if (rentalSyncJob.$assignedFields.contains('finishedAt')) { finishedAt = rentalSyncJob.finishedAt; }
		if (rentalSyncJob.$assignedFields.contains('error')) { error = rentalSyncJob.error; }
		if (rentalSyncJob.$assignedFields.contains('stats')) { stats = rentalSyncJob.stats; }
		if (rentalSyncJob.$assignedFields.contains('createdBy')) { createdBy = rentalSyncJob.createdBy; }
		if (rentalSyncJob.$assignedFields.contains('createdAt')) { createdAt = rentalSyncJob.createdAt; }
		if (rentalSyncJob.$assignedFields.contains('updatedAt')) { updatedAt = rentalSyncJob.updatedAt; }
		if (rentalSyncJob.$assignedFields.contains('deletedAt')) { deletedAt = rentalSyncJob.deletedAt; }
		if (rentalSyncJob.$assignedFields.contains('integration')) { integration = rentalSyncJob.integration; }
		if (rentalSyncJob.$assignedFields.contains('org')) { org = rentalSyncJob.org; }
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
          ? {...?serializedTypes, 'RentalSyncJob'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(integrationId != null) 'integrationId': integrationId,
	if(platform != null) 'platform': platform?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(jobType != null) 'jobType': jobType,
	if(direction != null) 'direction': direction?.toJson(),
	if(startedAt != null) 'startedAt': startedAt?.toIso8601String(),
	if(finishedAt != null) 'finishedAt': finishedAt?.toIso8601String(),
	if(error != null) 'error': error,
	if(stats != null) 'stats': stats,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(integration != null && (!preventCircularSerialization || !serializedModels.contains('ApiIntegration'))) 'integration': integration?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is RentalSyncJob &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    