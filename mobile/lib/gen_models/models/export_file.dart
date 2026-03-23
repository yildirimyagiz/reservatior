
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'export_job.dart';
import 'organization.dart';


class ExportFile implements PrismaModel<String, ExportFile> , Id<String> {
    @override
String? id;
	String? orgId;
	String? exportJobId;
	String? fileName;
	String? storageKey;
	String? mimeType;
	int? sizeBytes;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	ExportJob? exportJob;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ExportFile({ this.id,
	 this.orgId,
	 this.exportJobId,
	 this.fileName,
	 this.storageKey,
	 this.mimeType,
	 this.sizeBytes,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.exportJob,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ExportFile, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"exportJobId": (m) => m.exportJobId,

	"fileName": (m) => m.fileName,

	"storageKey": (m) => m.storageKey,

	"mimeType": (m) => m.mimeType,

	"sizeBytes": (m) => m.sizeBytes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"exportJob": (m) => m.exportJob,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ExportFile) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ExportFile');
    }
    return propFunction as V? Function(ExportFile);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ExportFile.fromJson(JsonMap json) =>
      ExportFile(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	exportJobId: json['exportJobId'] as String?,
	fileName: json['fileName'] as String?,
	storageKey: json['storageKey'] as String?,
	mimeType: json['mimeType'] as String?,
	sizeBytes: int.tryParse(json['sizeBytes'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	exportJob: json['exportJob'] != null ? ExportJob.fromJson(json['exportJob'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ExportFile copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? exportJobId,
		Value<String?>? fileName,
		Value<String?>? storageKey,
		Value<String?>? mimeType,
		Value<int?>? sizeBytes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<ExportJob?>? exportJob,
		Value<Organization?>? org,
        }) {
        return ExportFile(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		exportJobId: exportJobId != null ? exportJobId.value : this.exportJobId,
		fileName: fileName != null ? fileName.value : this.fileName,
		storageKey: storageKey != null ? storageKey.value : this.storageKey,
		mimeType: mimeType != null ? mimeType.value : this.mimeType,
		sizeBytes: sizeBytes != null ? sizeBytes.value : this.sizeBytes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		exportJob: exportJob != null ? exportJob.value : this.exportJob,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ExportFile copyWithInstanceValues(ExportFile exportFile) {
        return ExportFile(
            id: exportFile.id ?? id,
		orgId: exportFile.orgId ?? orgId,
		exportJobId: exportFile.exportJobId ?? exportJobId,
		fileName: exportFile.fileName ?? fileName,
		storageKey: exportFile.storageKey ?? storageKey,
		mimeType: exportFile.mimeType ?? mimeType,
		sizeBytes: exportFile.sizeBytes ?? sizeBytes,
		createdAt: exportFile.createdAt ?? createdAt,
		updatedAt: exportFile.updatedAt ?? updatedAt,
		deletedAt: exportFile.deletedAt ?? deletedAt,
		exportJob: exportFile.exportJob ?? exportJob,
		org: exportFile.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ExportFile mergeWithInstanceValues(ExportFile exportFile) {
        return ExportFile(
            id: exportFile.$assignedFields.contains('id') ? exportFile.id : id,
		orgId: exportFile.$assignedFields.contains('orgId') ? exportFile.orgId : orgId,
		exportJobId: exportFile.$assignedFields.contains('exportJobId') ? exportFile.exportJobId : exportJobId,
		fileName: exportFile.$assignedFields.contains('fileName') ? exportFile.fileName : fileName,
		storageKey: exportFile.$assignedFields.contains('storageKey') ? exportFile.storageKey : storageKey,
		mimeType: exportFile.$assignedFields.contains('mimeType') ? exportFile.mimeType : mimeType,
		sizeBytes: exportFile.$assignedFields.contains('sizeBytes') ? exportFile.sizeBytes : sizeBytes,
		createdAt: exportFile.$assignedFields.contains('createdAt') ? exportFile.createdAt : createdAt,
		updatedAt: exportFile.$assignedFields.contains('updatedAt') ? exportFile.updatedAt : updatedAt,
		deletedAt: exportFile.$assignedFields.contains('deletedAt') ? exportFile.deletedAt : deletedAt,
		exportJob: exportFile.$assignedFields.contains('exportJob') ? exportFile.exportJob : exportJob,
		org: exportFile.$assignedFields.contains('org') ? exportFile.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ExportFile updateWithInstanceValues(ExportFile exportFile) {
        if (exportFile.$assignedFields.contains('id')) { id = exportFile.id; }
		if (exportFile.$assignedFields.contains('orgId')) { orgId = exportFile.orgId; }
		if (exportFile.$assignedFields.contains('exportJobId')) { exportJobId = exportFile.exportJobId; }
		if (exportFile.$assignedFields.contains('fileName')) { fileName = exportFile.fileName; }
		if (exportFile.$assignedFields.contains('storageKey')) { storageKey = exportFile.storageKey; }
		if (exportFile.$assignedFields.contains('mimeType')) { mimeType = exportFile.mimeType; }
		if (exportFile.$assignedFields.contains('sizeBytes')) { sizeBytes = exportFile.sizeBytes; }
		if (exportFile.$assignedFields.contains('createdAt')) { createdAt = exportFile.createdAt; }
		if (exportFile.$assignedFields.contains('updatedAt')) { updatedAt = exportFile.updatedAt; }
		if (exportFile.$assignedFields.contains('deletedAt')) { deletedAt = exportFile.deletedAt; }
		if (exportFile.$assignedFields.contains('exportJob')) { exportJob = exportFile.exportJob; }
		if (exportFile.$assignedFields.contains('org')) { org = exportFile.org; }
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
          ? {...?serializedTypes, 'ExportFile'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(exportJobId != null) 'exportJobId': exportJobId,
	if(fileName != null) 'fileName': fileName,
	if(storageKey != null) 'storageKey': storageKey,
	if(mimeType != null) 'mimeType': mimeType,
	if(sizeBytes != null) 'sizeBytes': sizeBytes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(exportJob != null && (!preventCircularSerialization || !serializedModels.contains('ExportJob'))) 'exportJob': exportJob?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ExportFile &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    