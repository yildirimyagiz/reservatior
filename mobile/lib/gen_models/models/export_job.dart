
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'export_type.dart';
import 'export_status.dart';
import 'export_file.dart';
import 'organization.dart';


class ExportJob implements PrismaModel<String, ExportJob> , Id<String> {
    @override
String? id;
	String? orgId;
	ExportType? type;
	ExportStatus? status;
	dynamic params;
	DateTime? startedAt;
	DateTime? finishedAt;
	String? error;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<ExportFile>? files;
	Organization? org;
	int? $filesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ExportJob({ this.id,
	 this.orgId,
	 this.type,
	 this.status = ExportStatus.QUEUED,
	required this.params,
	 this.startedAt,
	 this.finishedAt,
	 this.error,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.files,
	 this.org,
	this.$filesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ExportJob, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"type": (m) => m.type,

	"status": (m) => m.status,

	"params": (m) => m.params,

	"startedAt": (m) => m.startedAt,

	"finishedAt": (m) => m.finishedAt,

	"error": (m) => m.error,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"files": (m) => m.files,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ExportJob) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ExportJob');
    }
    return propFunction as V? Function(ExportJob);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ExportJob.fromJson(JsonMap json) =>
      ExportJob(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	type: json['type'] != null ? ExportType.fromJson(json['type']) : null,
	status: json['status'] != null ? ExportStatus.fromJson(json['status']) : null,
	params: json['params'] as dynamic,
	startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
	finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt']) : null,
	error: json['error'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	files: json['files'] != null ? createModels<ExportFile>((json['files'] as List).cast<JsonMap>(), ExportFile.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$filesCount: json['_count']?['files'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ExportJob copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<ExportType?>? type,
		Value<ExportStatus?>? status,
		Value<dynamic>? params,
		Value<DateTime?>? startedAt,
		Value<DateTime?>? finishedAt,
		Value<String?>? error,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<ExportFile>?>? files,
		Value<Organization?>? org,
		int? $filesCount,
        }) {
        return ExportJob(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		type: type != null ? type.value : this.type,
		status: status != null ? status.value : this.status,
		params: params != null ? params.value : this.params,
		startedAt: startedAt != null ? startedAt.value : this.startedAt,
		finishedAt: finishedAt != null ? finishedAt.value : this.finishedAt,
		error: error != null ? error.value : this.error,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		files: files != null ? files.value : this.files,
		org: org != null ? org.value : this.org,
		$filesCount: $filesCount ?? this.$filesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ExportJob copyWithInstanceValues(ExportJob exportJob) {
        return ExportJob(
            id: exportJob.id ?? id,
		orgId: exportJob.orgId ?? orgId,
		type: exportJob.type ?? type,
		status: exportJob.status ?? status,
		params: exportJob.params ?? params,
		startedAt: exportJob.startedAt ?? startedAt,
		finishedAt: exportJob.finishedAt ?? finishedAt,
		error: exportJob.error ?? error,
		createdBy: exportJob.createdBy ?? createdBy,
		createdAt: exportJob.createdAt ?? createdAt,
		updatedAt: exportJob.updatedAt ?? updatedAt,
		deletedAt: exportJob.deletedAt ?? deletedAt,
		files: exportJob.files ?? files,
		org: exportJob.org ?? org,
		$filesCount: exportJob.$filesCount ?? $filesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ExportJob mergeWithInstanceValues(ExportJob exportJob) {
        return ExportJob(
            id: exportJob.$assignedFields.contains('id') ? exportJob.id : id,
		orgId: exportJob.$assignedFields.contains('orgId') ? exportJob.orgId : orgId,
		type: exportJob.$assignedFields.contains('type') ? exportJob.type : type,
		status: exportJob.$assignedFields.contains('status') ? exportJob.status : status,
		params: exportJob.$assignedFields.contains('params') ? exportJob.params : params,
		startedAt: exportJob.$assignedFields.contains('startedAt') ? exportJob.startedAt : startedAt,
		finishedAt: exportJob.$assignedFields.contains('finishedAt') ? exportJob.finishedAt : finishedAt,
		error: exportJob.$assignedFields.contains('error') ? exportJob.error : error,
		createdBy: exportJob.$assignedFields.contains('createdBy') ? exportJob.createdBy : createdBy,
		createdAt: exportJob.$assignedFields.contains('createdAt') ? exportJob.createdAt : createdAt,
		updatedAt: exportJob.$assignedFields.contains('updatedAt') ? exportJob.updatedAt : updatedAt,
		deletedAt: exportJob.$assignedFields.contains('deletedAt') ? exportJob.deletedAt : deletedAt,
		files: (exportJob.$assignedFields.contains('files') && exportJob.files != null) ? mergeModelLists(files, exportJob.files) : files,
		org: exportJob.$assignedFields.contains('org') ? exportJob.org : org,
		$filesCount: exportJob.$filesCount ?? $filesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ExportJob updateWithInstanceValues(ExportJob exportJob) {
        if (exportJob.$assignedFields.contains('id')) { id = exportJob.id; }
		if (exportJob.$assignedFields.contains('orgId')) { orgId = exportJob.orgId; }
		if (exportJob.$assignedFields.contains('type')) { type = exportJob.type; }
		if (exportJob.$assignedFields.contains('status')) { status = exportJob.status; }
		if (exportJob.$assignedFields.contains('params')) { params = exportJob.params; }
		if (exportJob.$assignedFields.contains('startedAt')) { startedAt = exportJob.startedAt; }
		if (exportJob.$assignedFields.contains('finishedAt')) { finishedAt = exportJob.finishedAt; }
		if (exportJob.$assignedFields.contains('error')) { error = exportJob.error; }
		if (exportJob.$assignedFields.contains('createdBy')) { createdBy = exportJob.createdBy; }
		if (exportJob.$assignedFields.contains('createdAt')) { createdAt = exportJob.createdAt; }
		if (exportJob.$assignedFields.contains('updatedAt')) { updatedAt = exportJob.updatedAt; }
		if (exportJob.$assignedFields.contains('deletedAt')) { deletedAt = exportJob.deletedAt; }
		if (exportJob.$assignedFields.contains('files') && exportJob.files != null) { files = mergeModelLists(files, exportJob.files); }
		if (exportJob.$assignedFields.contains('org')) { org = exportJob.org; }
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
          ? {...?serializedTypes, 'ExportJob'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(type != null) 'type': type?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(params != null) 'params': params,
	if(startedAt != null) 'startedAt': startedAt?.toIso8601String(),
	if(finishedAt != null) 'finishedAt': finishedAt?.toIso8601String(),
	if(error != null) 'error': error,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(files != null && (!preventCircularSerialization || !serializedModels.contains('ExportFile'))) 'files': files?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($filesCount != null) '_count': { 
		if ($filesCount != null) 'files': $filesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ExportJob &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    