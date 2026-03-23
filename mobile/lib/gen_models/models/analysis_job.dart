
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'document.dart';
import 'organization.dart';
import 'document_analysis.dart';


class AnalysisJob implements PrismaModel<String, AnalysisJob> , Id<String> {
    @override
String? id;
	String? documentId;
	String? orgId;
	String? status;
	String? type;
	String? priority;
	DateTime? startedAt;
	DateTime? completedAt;
	int? processingTime;
	String? errorMessage;
	dynamic parameters;
	DateTime? createdAt;
	DateTime? updatedAt;
	Document? document;
	Organization? org;
	List<DocumentAnalysis>? analyses;
	int? $analysesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AnalysisJob({ this.id,
	 this.documentId,
	 this.orgId,
	 this.status = "QUEUED",
	 this.type,
	 this.priority = "normal",
	 this.startedAt,
	 this.completedAt,
	 this.processingTime,
	 this.errorMessage,
	required this.parameters,
	 this.createdAt,
	 this.updatedAt,
	 this.document,
	 this.org,
	 this.analyses,
	this.$analysesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AnalysisJob, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"documentId": (m) => m.documentId,

	"orgId": (m) => m.orgId,

	"status": (m) => m.status,

	"type": (m) => m.type,

	"priority": (m) => m.priority,

	"startedAt": (m) => m.startedAt,

	"completedAt": (m) => m.completedAt,

	"processingTime": (m) => m.processingTime,

	"errorMessage": (m) => m.errorMessage,

	"parameters": (m) => m.parameters,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"document": (m) => m.document,

	"org": (m) => m.org,

	"analyses": (m) => m.analyses,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AnalysisJob) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AnalysisJob');
    }
    return propFunction as V? Function(AnalysisJob);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AnalysisJob.fromJson(JsonMap json) =>
      AnalysisJob(
        id: json['id'] as String?,
	documentId: json['documentId'] as String?,
	orgId: json['orgId'] as String?,
	status: json['status'] as String?,
	type: json['type'] as String?,
	priority: json['priority'] as String?,
	startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
	completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
	processingTime: int.tryParse(json['processingTime'].toString()),
	errorMessage: json['errorMessage'] as String?,
	parameters: json['parameters'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	document: json['document'] != null ? Document.fromJson(json['document'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	analyses: json['analyses'] != null ? createModels<DocumentAnalysis>((json['analyses'] as List).cast<JsonMap>(), DocumentAnalysis.fromJson) : null,
	$analysesCount: json['_count']?['analyses'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AnalysisJob copyWith({
        Value<String?>? id,
		Value<String?>? documentId,
		Value<String?>? orgId,
		Value<String?>? status,
		Value<String?>? type,
		Value<String?>? priority,
		Value<DateTime?>? startedAt,
		Value<DateTime?>? completedAt,
		Value<int?>? processingTime,
		Value<String?>? errorMessage,
		Value<dynamic>? parameters,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Document?>? document,
		Value<Organization?>? org,
		Value<List<DocumentAnalysis>?>? analyses,
		int? $analysesCount,
        }) {
        return AnalysisJob(
            id: id != null ? id.value : this.id,
		documentId: documentId != null ? documentId.value : this.documentId,
		orgId: orgId != null ? orgId.value : this.orgId,
		status: status != null ? status.value : this.status,
		type: type != null ? type.value : this.type,
		priority: priority != null ? priority.value : this.priority,
		startedAt: startedAt != null ? startedAt.value : this.startedAt,
		completedAt: completedAt != null ? completedAt.value : this.completedAt,
		processingTime: processingTime != null ? processingTime.value : this.processingTime,
		errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
		parameters: parameters != null ? parameters.value : this.parameters,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		document: document != null ? document.value : this.document,
		org: org != null ? org.value : this.org,
		analyses: analyses != null ? analyses.value : this.analyses,
		$analysesCount: $analysesCount ?? this.$analysesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AnalysisJob copyWithInstanceValues(AnalysisJob analysisJob) {
        return AnalysisJob(
            id: analysisJob.id ?? id,
		documentId: analysisJob.documentId ?? documentId,
		orgId: analysisJob.orgId ?? orgId,
		status: analysisJob.status ?? status,
		type: analysisJob.type ?? type,
		priority: analysisJob.priority ?? priority,
		startedAt: analysisJob.startedAt ?? startedAt,
		completedAt: analysisJob.completedAt ?? completedAt,
		processingTime: analysisJob.processingTime ?? processingTime,
		errorMessage: analysisJob.errorMessage ?? errorMessage,
		parameters: analysisJob.parameters ?? parameters,
		createdAt: analysisJob.createdAt ?? createdAt,
		updatedAt: analysisJob.updatedAt ?? updatedAt,
		document: analysisJob.document ?? document,
		org: analysisJob.org ?? org,
		analyses: analysisJob.analyses ?? analyses,
		$analysesCount: analysisJob.$analysesCount ?? $analysesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AnalysisJob mergeWithInstanceValues(AnalysisJob analysisJob) {
        return AnalysisJob(
            id: analysisJob.$assignedFields.contains('id') ? analysisJob.id : id,
		documentId: analysisJob.$assignedFields.contains('documentId') ? analysisJob.documentId : documentId,
		orgId: analysisJob.$assignedFields.contains('orgId') ? analysisJob.orgId : orgId,
		status: analysisJob.$assignedFields.contains('status') ? analysisJob.status : status,
		type: analysisJob.$assignedFields.contains('type') ? analysisJob.type : type,
		priority: analysisJob.$assignedFields.contains('priority') ? analysisJob.priority : priority,
		startedAt: analysisJob.$assignedFields.contains('startedAt') ? analysisJob.startedAt : startedAt,
		completedAt: analysisJob.$assignedFields.contains('completedAt') ? analysisJob.completedAt : completedAt,
		processingTime: analysisJob.$assignedFields.contains('processingTime') ? analysisJob.processingTime : processingTime,
		errorMessage: analysisJob.$assignedFields.contains('errorMessage') ? analysisJob.errorMessage : errorMessage,
		parameters: analysisJob.$assignedFields.contains('parameters') ? analysisJob.parameters : parameters,
		createdAt: analysisJob.$assignedFields.contains('createdAt') ? analysisJob.createdAt : createdAt,
		updatedAt: analysisJob.$assignedFields.contains('updatedAt') ? analysisJob.updatedAt : updatedAt,
		document: analysisJob.$assignedFields.contains('document') ? analysisJob.document : document,
		org: analysisJob.$assignedFields.contains('org') ? analysisJob.org : org,
		analyses: (analysisJob.$assignedFields.contains('analyses') && analysisJob.analyses != null) ? mergeModelLists(analyses, analysisJob.analyses) : analyses,
		$analysesCount: analysisJob.$analysesCount ?? $analysesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AnalysisJob updateWithInstanceValues(AnalysisJob analysisJob) {
        if (analysisJob.$assignedFields.contains('id')) { id = analysisJob.id; }
		if (analysisJob.$assignedFields.contains('documentId')) { documentId = analysisJob.documentId; }
		if (analysisJob.$assignedFields.contains('orgId')) { orgId = analysisJob.orgId; }
		if (analysisJob.$assignedFields.contains('status')) { status = analysisJob.status; }
		if (analysisJob.$assignedFields.contains('type')) { type = analysisJob.type; }
		if (analysisJob.$assignedFields.contains('priority')) { priority = analysisJob.priority; }
		if (analysisJob.$assignedFields.contains('startedAt')) { startedAt = analysisJob.startedAt; }
		if (analysisJob.$assignedFields.contains('completedAt')) { completedAt = analysisJob.completedAt; }
		if (analysisJob.$assignedFields.contains('processingTime')) { processingTime = analysisJob.processingTime; }
		if (analysisJob.$assignedFields.contains('errorMessage')) { errorMessage = analysisJob.errorMessage; }
		if (analysisJob.$assignedFields.contains('parameters')) { parameters = analysisJob.parameters; }
		if (analysisJob.$assignedFields.contains('createdAt')) { createdAt = analysisJob.createdAt; }
		if (analysisJob.$assignedFields.contains('updatedAt')) { updatedAt = analysisJob.updatedAt; }
		if (analysisJob.$assignedFields.contains('document')) { document = analysisJob.document; }
		if (analysisJob.$assignedFields.contains('org')) { org = analysisJob.org; }
		if (analysisJob.$assignedFields.contains('analyses') && analysisJob.analyses != null) { analyses = mergeModelLists(analyses, analysisJob.analyses); }
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
          ? {...?serializedTypes, 'AnalysisJob'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(documentId != null) 'documentId': documentId,
	if(orgId != null) 'orgId': orgId,
	if(status != null) 'status': status,
	if(type != null) 'type': type,
	if(priority != null) 'priority': priority,
	if(startedAt != null) 'startedAt': startedAt?.toIso8601String(),
	if(completedAt != null) 'completedAt': completedAt?.toIso8601String(),
	if(processingTime != null) 'processingTime': processingTime,
	if(errorMessage != null) 'errorMessage': errorMessage,
	if(parameters != null) 'parameters': parameters,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(document != null && (!preventCircularSerialization || !serializedModels.contains('Document'))) 'document': document?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(analyses != null && (!preventCircularSerialization || !serializedModels.contains('DocumentAnalysis'))) 'analyses': analyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($analysesCount != null) '_count': { 
		if ($analysesCount != null) 'analyses': $analysesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AnalysisJob &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    