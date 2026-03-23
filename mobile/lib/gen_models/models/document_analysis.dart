
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'document.dart';
import 'analysis_job.dart';
import 'organization.dart';


class DocumentAnalysis implements PrismaModel<String, DocumentAnalysis> , Id<String> {
    @override
String? id;
	String? documentId;
	String? jobId;
	String? orgId;
	String? extractedText;
	dynamic metadata;
	dynamic classification;
	double? confidence;
	int? processingTime;
	DateTime? createdAt;
	DateTime? updatedAt;
	Document? document;
	AnalysisJob? job;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    DocumentAnalysis({ this.id,
	 this.documentId,
	 this.jobId,
	 this.orgId,
	 this.extractedText,
	required this.metadata,
	required this.classification,
	 this.confidence,
	 this.processingTime,
	 this.createdAt,
	 this.updatedAt,
	 this.document,
	 this.job,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<DocumentAnalysis, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"documentId": (m) => m.documentId,

	"jobId": (m) => m.jobId,

	"orgId": (m) => m.orgId,

	"extractedText": (m) => m.extractedText,

	"metadata": (m) => m.metadata,

	"classification": (m) => m.classification,

	"confidence": (m) => m.confidence,

	"processingTime": (m) => m.processingTime,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"document": (m) => m.document,

	"job": (m) => m.job,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(DocumentAnalysis) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in DocumentAnalysis');
    }
    return propFunction as V? Function(DocumentAnalysis);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory DocumentAnalysis.fromJson(JsonMap json) =>
      DocumentAnalysis(
        id: json['id'] as String?,
	documentId: json['documentId'] as String?,
	jobId: json['jobId'] as String?,
	orgId: json['orgId'] as String?,
	extractedText: json['extractedText'] as String?,
	metadata: json['metadata'] as dynamic,
	classification: json['classification'] as dynamic,
	confidence: json['confidence']?.toDouble(),
	processingTime: int.tryParse(json['processingTime'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	document: json['document'] != null ? Document.fromJson(json['document'] as JsonMap) : null,
	job: json['job'] != null ? AnalysisJob.fromJson(json['job'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    DocumentAnalysis copyWith({
        Value<String?>? id,
		Value<String?>? documentId,
		Value<String?>? jobId,
		Value<String?>? orgId,
		Value<String?>? extractedText,
		Value<dynamic>? metadata,
		Value<dynamic>? classification,
		Value<double?>? confidence,
		Value<int?>? processingTime,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Document?>? document,
		Value<AnalysisJob?>? job,
		Value<Organization?>? org,
        }) {
        return DocumentAnalysis(
            id: id != null ? id.value : this.id,
		documentId: documentId != null ? documentId.value : this.documentId,
		jobId: jobId != null ? jobId.value : this.jobId,
		orgId: orgId != null ? orgId.value : this.orgId,
		extractedText: extractedText != null ? extractedText.value : this.extractedText,
		metadata: metadata != null ? metadata.value : this.metadata,
		classification: classification != null ? classification.value : this.classification,
		confidence: confidence != null ? confidence.value : this.confidence,
		processingTime: processingTime != null ? processingTime.value : this.processingTime,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		document: document != null ? document.value : this.document,
		job: job != null ? job.value : this.job,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    DocumentAnalysis copyWithInstanceValues(DocumentAnalysis documentAnalysis) {
        return DocumentAnalysis(
            id: documentAnalysis.id ?? id,
		documentId: documentAnalysis.documentId ?? documentId,
		jobId: documentAnalysis.jobId ?? jobId,
		orgId: documentAnalysis.orgId ?? orgId,
		extractedText: documentAnalysis.extractedText ?? extractedText,
		metadata: documentAnalysis.metadata ?? metadata,
		classification: documentAnalysis.classification ?? classification,
		confidence: documentAnalysis.confidence ?? confidence,
		processingTime: documentAnalysis.processingTime ?? processingTime,
		createdAt: documentAnalysis.createdAt ?? createdAt,
		updatedAt: documentAnalysis.updatedAt ?? updatedAt,
		document: documentAnalysis.document ?? document,
		job: documentAnalysis.job ?? job,
		org: documentAnalysis.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    DocumentAnalysis mergeWithInstanceValues(DocumentAnalysis documentAnalysis) {
        return DocumentAnalysis(
            id: documentAnalysis.$assignedFields.contains('id') ? documentAnalysis.id : id,
		documentId: documentAnalysis.$assignedFields.contains('documentId') ? documentAnalysis.documentId : documentId,
		jobId: documentAnalysis.$assignedFields.contains('jobId') ? documentAnalysis.jobId : jobId,
		orgId: documentAnalysis.$assignedFields.contains('orgId') ? documentAnalysis.orgId : orgId,
		extractedText: documentAnalysis.$assignedFields.contains('extractedText') ? documentAnalysis.extractedText : extractedText,
		metadata: documentAnalysis.$assignedFields.contains('metadata') ? documentAnalysis.metadata : metadata,
		classification: documentAnalysis.$assignedFields.contains('classification') ? documentAnalysis.classification : classification,
		confidence: documentAnalysis.$assignedFields.contains('confidence') ? documentAnalysis.confidence : confidence,
		processingTime: documentAnalysis.$assignedFields.contains('processingTime') ? documentAnalysis.processingTime : processingTime,
		createdAt: documentAnalysis.$assignedFields.contains('createdAt') ? documentAnalysis.createdAt : createdAt,
		updatedAt: documentAnalysis.$assignedFields.contains('updatedAt') ? documentAnalysis.updatedAt : updatedAt,
		document: documentAnalysis.$assignedFields.contains('document') ? documentAnalysis.document : document,
		job: documentAnalysis.$assignedFields.contains('job') ? documentAnalysis.job : job,
		org: documentAnalysis.$assignedFields.contains('org') ? documentAnalysis.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    DocumentAnalysis updateWithInstanceValues(DocumentAnalysis documentAnalysis) {
        if (documentAnalysis.$assignedFields.contains('id')) { id = documentAnalysis.id; }
		if (documentAnalysis.$assignedFields.contains('documentId')) { documentId = documentAnalysis.documentId; }
		if (documentAnalysis.$assignedFields.contains('jobId')) { jobId = documentAnalysis.jobId; }
		if (documentAnalysis.$assignedFields.contains('orgId')) { orgId = documentAnalysis.orgId; }
		if (documentAnalysis.$assignedFields.contains('extractedText')) { extractedText = documentAnalysis.extractedText; }
		if (documentAnalysis.$assignedFields.contains('metadata')) { metadata = documentAnalysis.metadata; }
		if (documentAnalysis.$assignedFields.contains('classification')) { classification = documentAnalysis.classification; }
		if (documentAnalysis.$assignedFields.contains('confidence')) { confidence = documentAnalysis.confidence; }
		if (documentAnalysis.$assignedFields.contains('processingTime')) { processingTime = documentAnalysis.processingTime; }
		if (documentAnalysis.$assignedFields.contains('createdAt')) { createdAt = documentAnalysis.createdAt; }
		if (documentAnalysis.$assignedFields.contains('updatedAt')) { updatedAt = documentAnalysis.updatedAt; }
		if (documentAnalysis.$assignedFields.contains('document')) { document = documentAnalysis.document; }
		if (documentAnalysis.$assignedFields.contains('job')) { job = documentAnalysis.job; }
		if (documentAnalysis.$assignedFields.contains('org')) { org = documentAnalysis.org; }
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
          ? {...?serializedTypes, 'DocumentAnalysis'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(documentId != null) 'documentId': documentId,
	if(jobId != null) 'jobId': jobId,
	if(orgId != null) 'orgId': orgId,
	if(extractedText != null) 'extractedText': extractedText,
	if(metadata != null) 'metadata': metadata,
	if(classification != null) 'classification': classification,
	if(confidence != null) 'confidence': confidence,
	if(processingTime != null) 'processingTime': processingTime,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(document != null && (!preventCircularSerialization || !serializedModels.contains('Document'))) 'document': document?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(job != null && (!preventCircularSerialization || !serializedModels.contains('AnalysisJob'))) 'job': job?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is DocumentAnalysis &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    