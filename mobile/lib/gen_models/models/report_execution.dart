
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'report.dart';


class ReportExecution implements PrismaModel<String, ReportExecution> , Id<String> {
    @override
String? id;
	String? orgId;
	String? reportId;
	DateTime? executedAt;
	String? executedBy;
	String? status;
	String? resultUrl;
	String? errorMessage;
	dynamic parameters;
	DateTime? createdAt;
	Organization? org;
	Report? report;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ReportExecution({ this.id,
	 this.orgId,
	 this.reportId,
	 this.executedAt,
	 this.executedBy,
	 this.status,
	 this.resultUrl,
	 this.errorMessage,
	required this.parameters,
	 this.createdAt,
	 this.org,
	 this.report,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ReportExecution, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"reportId": (m) => m.reportId,

	"executedAt": (m) => m.executedAt,

	"executedBy": (m) => m.executedBy,

	"status": (m) => m.status,

	"resultUrl": (m) => m.resultUrl,

	"errorMessage": (m) => m.errorMessage,

	"parameters": (m) => m.parameters,

	"createdAt": (m) => m.createdAt,

	"org": (m) => m.org,

	"report": (m) => m.report,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ReportExecution) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ReportExecution');
    }
    return propFunction as V? Function(ReportExecution);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ReportExecution.fromJson(JsonMap json) =>
      ReportExecution(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	reportId: json['reportId'] as String?,
	executedAt: json['executedAt'] != null ? DateTime.parse(json['executedAt']) : null,
	executedBy: json['executedBy'] as String?,
	status: json['status'] as String?,
	resultUrl: json['resultUrl'] as String?,
	errorMessage: json['errorMessage'] as String?,
	parameters: json['parameters'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	report: json['report'] != null ? Report.fromJson(json['report'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ReportExecution copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? reportId,
		Value<DateTime?>? executedAt,
		Value<String?>? executedBy,
		Value<String?>? status,
		Value<String?>? resultUrl,
		Value<String?>? errorMessage,
		Value<dynamic>? parameters,
		Value<DateTime?>? createdAt,
		Value<Organization?>? org,
		Value<Report?>? report,
        }) {
        return ReportExecution(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		reportId: reportId != null ? reportId.value : this.reportId,
		executedAt: executedAt != null ? executedAt.value : this.executedAt,
		executedBy: executedBy != null ? executedBy.value : this.executedBy,
		status: status != null ? status.value : this.status,
		resultUrl: resultUrl != null ? resultUrl.value : this.resultUrl,
		errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
		parameters: parameters != null ? parameters.value : this.parameters,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		org: org != null ? org.value : this.org,
		report: report != null ? report.value : this.report
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ReportExecution copyWithInstanceValues(ReportExecution reportExecution) {
        return ReportExecution(
            id: reportExecution.id ?? id,
		orgId: reportExecution.orgId ?? orgId,
		reportId: reportExecution.reportId ?? reportId,
		executedAt: reportExecution.executedAt ?? executedAt,
		executedBy: reportExecution.executedBy ?? executedBy,
		status: reportExecution.status ?? status,
		resultUrl: reportExecution.resultUrl ?? resultUrl,
		errorMessage: reportExecution.errorMessage ?? errorMessage,
		parameters: reportExecution.parameters ?? parameters,
		createdAt: reportExecution.createdAt ?? createdAt,
		org: reportExecution.org ?? org,
		report: reportExecution.report ?? report
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ReportExecution mergeWithInstanceValues(ReportExecution reportExecution) {
        return ReportExecution(
            id: reportExecution.$assignedFields.contains('id') ? reportExecution.id : id,
		orgId: reportExecution.$assignedFields.contains('orgId') ? reportExecution.orgId : orgId,
		reportId: reportExecution.$assignedFields.contains('reportId') ? reportExecution.reportId : reportId,
		executedAt: reportExecution.$assignedFields.contains('executedAt') ? reportExecution.executedAt : executedAt,
		executedBy: reportExecution.$assignedFields.contains('executedBy') ? reportExecution.executedBy : executedBy,
		status: reportExecution.$assignedFields.contains('status') ? reportExecution.status : status,
		resultUrl: reportExecution.$assignedFields.contains('resultUrl') ? reportExecution.resultUrl : resultUrl,
		errorMessage: reportExecution.$assignedFields.contains('errorMessage') ? reportExecution.errorMessage : errorMessage,
		parameters: reportExecution.$assignedFields.contains('parameters') ? reportExecution.parameters : parameters,
		createdAt: reportExecution.$assignedFields.contains('createdAt') ? reportExecution.createdAt : createdAt,
		org: reportExecution.$assignedFields.contains('org') ? reportExecution.org : org,
		report: reportExecution.$assignedFields.contains('report') ? reportExecution.report : report
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ReportExecution updateWithInstanceValues(ReportExecution reportExecution) {
        if (reportExecution.$assignedFields.contains('id')) { id = reportExecution.id; }
		if (reportExecution.$assignedFields.contains('orgId')) { orgId = reportExecution.orgId; }
		if (reportExecution.$assignedFields.contains('reportId')) { reportId = reportExecution.reportId; }
		if (reportExecution.$assignedFields.contains('executedAt')) { executedAt = reportExecution.executedAt; }
		if (reportExecution.$assignedFields.contains('executedBy')) { executedBy = reportExecution.executedBy; }
		if (reportExecution.$assignedFields.contains('status')) { status = reportExecution.status; }
		if (reportExecution.$assignedFields.contains('resultUrl')) { resultUrl = reportExecution.resultUrl; }
		if (reportExecution.$assignedFields.contains('errorMessage')) { errorMessage = reportExecution.errorMessage; }
		if (reportExecution.$assignedFields.contains('parameters')) { parameters = reportExecution.parameters; }
		if (reportExecution.$assignedFields.contains('createdAt')) { createdAt = reportExecution.createdAt; }
		if (reportExecution.$assignedFields.contains('org')) { org = reportExecution.org; }
		if (reportExecution.$assignedFields.contains('report')) { report = reportExecution.report; }
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
          ? {...?serializedTypes, 'ReportExecution'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(reportId != null) 'reportId': reportId,
	if(executedAt != null) 'executedAt': executedAt?.toIso8601String(),
	if(executedBy != null) 'executedBy': executedBy,
	if(status != null) 'status': status,
	if(resultUrl != null) 'resultUrl': resultUrl,
	if(errorMessage != null) 'errorMessage': errorMessage,
	if(parameters != null) 'parameters': parameters,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(report != null && (!preventCircularSerialization || !serializedModels.contains('Report'))) 'report': report?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ReportExecution &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    