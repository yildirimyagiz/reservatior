
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class PerformanceAlert implements PrismaModel<String, PerformanceAlert> , Id<String> {
    @override
String? id;
	String? orgId;
	String? alertType;
	String? severity;
	String? metricName;
	double? threshold;
	double? actualValue;
	String? description;
	dynamic affectedServices;
	String? status;
	DateTime? acknowledgedAt;
	String? acknowledgedBy;
	DateTime? resolvedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PerformanceAlert({ this.id,
	 this.orgId,
	 this.alertType,
	 this.severity,
	 this.metricName,
	 this.threshold,
	 this.actualValue,
	 this.description,
	required this.affectedServices,
	 this.status = "ACTIVE",
	 this.acknowledgedAt,
	 this.acknowledgedBy,
	 this.resolvedAt,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PerformanceAlert, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"alertType": (m) => m.alertType,

	"severity": (m) => m.severity,

	"metricName": (m) => m.metricName,

	"threshold": (m) => m.threshold,

	"actualValue": (m) => m.actualValue,

	"description": (m) => m.description,

	"affectedServices": (m) => m.affectedServices,

	"status": (m) => m.status,

	"acknowledgedAt": (m) => m.acknowledgedAt,

	"acknowledgedBy": (m) => m.acknowledgedBy,

	"resolvedAt": (m) => m.resolvedAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PerformanceAlert) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PerformanceAlert');
    }
    return propFunction as V? Function(PerformanceAlert);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PerformanceAlert.fromJson(JsonMap json) =>
      PerformanceAlert(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	alertType: json['alertType'] as String?,
	severity: json['severity'] as String?,
	metricName: json['metricName'] as String?,
	threshold: json['threshold']?.toDouble(),
	actualValue: json['actualValue']?.toDouble(),
	description: json['description'] as String?,
	affectedServices: json['affectedServices'] as dynamic,
	status: json['status'] as String?,
	acknowledgedAt: json['acknowledgedAt'] != null ? DateTime.parse(json['acknowledgedAt']) : null,
	acknowledgedBy: json['acknowledgedBy'] as String?,
	resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PerformanceAlert copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? alertType,
		Value<String?>? severity,
		Value<String?>? metricName,
		Value<double?>? threshold,
		Value<double?>? actualValue,
		Value<String?>? description,
		Value<dynamic>? affectedServices,
		Value<String?>? status,
		Value<DateTime?>? acknowledgedAt,
		Value<String?>? acknowledgedBy,
		Value<DateTime?>? resolvedAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
        }) {
        return PerformanceAlert(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		alertType: alertType != null ? alertType.value : this.alertType,
		severity: severity != null ? severity.value : this.severity,
		metricName: metricName != null ? metricName.value : this.metricName,
		threshold: threshold != null ? threshold.value : this.threshold,
		actualValue: actualValue != null ? actualValue.value : this.actualValue,
		description: description != null ? description.value : this.description,
		affectedServices: affectedServices != null ? affectedServices.value : this.affectedServices,
		status: status != null ? status.value : this.status,
		acknowledgedAt: acknowledgedAt != null ? acknowledgedAt.value : this.acknowledgedAt,
		acknowledgedBy: acknowledgedBy != null ? acknowledgedBy.value : this.acknowledgedBy,
		resolvedAt: resolvedAt != null ? resolvedAt.value : this.resolvedAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PerformanceAlert copyWithInstanceValues(PerformanceAlert performanceAlert) {
        return PerformanceAlert(
            id: performanceAlert.id ?? id,
		orgId: performanceAlert.orgId ?? orgId,
		alertType: performanceAlert.alertType ?? alertType,
		severity: performanceAlert.severity ?? severity,
		metricName: performanceAlert.metricName ?? metricName,
		threshold: performanceAlert.threshold ?? threshold,
		actualValue: performanceAlert.actualValue ?? actualValue,
		description: performanceAlert.description ?? description,
		affectedServices: performanceAlert.affectedServices ?? affectedServices,
		status: performanceAlert.status ?? status,
		acknowledgedAt: performanceAlert.acknowledgedAt ?? acknowledgedAt,
		acknowledgedBy: performanceAlert.acknowledgedBy ?? acknowledgedBy,
		resolvedAt: performanceAlert.resolvedAt ?? resolvedAt,
		createdAt: performanceAlert.createdAt ?? createdAt,
		updatedAt: performanceAlert.updatedAt ?? updatedAt,
		org: performanceAlert.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PerformanceAlert mergeWithInstanceValues(PerformanceAlert performanceAlert) {
        return PerformanceAlert(
            id: performanceAlert.$assignedFields.contains('id') ? performanceAlert.id : id,
		orgId: performanceAlert.$assignedFields.contains('orgId') ? performanceAlert.orgId : orgId,
		alertType: performanceAlert.$assignedFields.contains('alertType') ? performanceAlert.alertType : alertType,
		severity: performanceAlert.$assignedFields.contains('severity') ? performanceAlert.severity : severity,
		metricName: performanceAlert.$assignedFields.contains('metricName') ? performanceAlert.metricName : metricName,
		threshold: performanceAlert.$assignedFields.contains('threshold') ? performanceAlert.threshold : threshold,
		actualValue: performanceAlert.$assignedFields.contains('actualValue') ? performanceAlert.actualValue : actualValue,
		description: performanceAlert.$assignedFields.contains('description') ? performanceAlert.description : description,
		affectedServices: performanceAlert.$assignedFields.contains('affectedServices') ? performanceAlert.affectedServices : affectedServices,
		status: performanceAlert.$assignedFields.contains('status') ? performanceAlert.status : status,
		acknowledgedAt: performanceAlert.$assignedFields.contains('acknowledgedAt') ? performanceAlert.acknowledgedAt : acknowledgedAt,
		acknowledgedBy: performanceAlert.$assignedFields.contains('acknowledgedBy') ? performanceAlert.acknowledgedBy : acknowledgedBy,
		resolvedAt: performanceAlert.$assignedFields.contains('resolvedAt') ? performanceAlert.resolvedAt : resolvedAt,
		createdAt: performanceAlert.$assignedFields.contains('createdAt') ? performanceAlert.createdAt : createdAt,
		updatedAt: performanceAlert.$assignedFields.contains('updatedAt') ? performanceAlert.updatedAt : updatedAt,
		org: performanceAlert.$assignedFields.contains('org') ? performanceAlert.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PerformanceAlert updateWithInstanceValues(PerformanceAlert performanceAlert) {
        if (performanceAlert.$assignedFields.contains('id')) { id = performanceAlert.id; }
		if (performanceAlert.$assignedFields.contains('orgId')) { orgId = performanceAlert.orgId; }
		if (performanceAlert.$assignedFields.contains('alertType')) { alertType = performanceAlert.alertType; }
		if (performanceAlert.$assignedFields.contains('severity')) { severity = performanceAlert.severity; }
		if (performanceAlert.$assignedFields.contains('metricName')) { metricName = performanceAlert.metricName; }
		if (performanceAlert.$assignedFields.contains('threshold')) { threshold = performanceAlert.threshold; }
		if (performanceAlert.$assignedFields.contains('actualValue')) { actualValue = performanceAlert.actualValue; }
		if (performanceAlert.$assignedFields.contains('description')) { description = performanceAlert.description; }
		if (performanceAlert.$assignedFields.contains('affectedServices')) { affectedServices = performanceAlert.affectedServices; }
		if (performanceAlert.$assignedFields.contains('status')) { status = performanceAlert.status; }
		if (performanceAlert.$assignedFields.contains('acknowledgedAt')) { acknowledgedAt = performanceAlert.acknowledgedAt; }
		if (performanceAlert.$assignedFields.contains('acknowledgedBy')) { acknowledgedBy = performanceAlert.acknowledgedBy; }
		if (performanceAlert.$assignedFields.contains('resolvedAt')) { resolvedAt = performanceAlert.resolvedAt; }
		if (performanceAlert.$assignedFields.contains('createdAt')) { createdAt = performanceAlert.createdAt; }
		if (performanceAlert.$assignedFields.contains('updatedAt')) { updatedAt = performanceAlert.updatedAt; }
		if (performanceAlert.$assignedFields.contains('org')) { org = performanceAlert.org; }
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
          ? {...?serializedTypes, 'PerformanceAlert'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(alertType != null) 'alertType': alertType,
	if(severity != null) 'severity': severity,
	if(metricName != null) 'metricName': metricName,
	if(threshold != null) 'threshold': threshold,
	if(actualValue != null) 'actualValue': actualValue,
	if(description != null) 'description': description,
	if(affectedServices != null) 'affectedServices': affectedServices,
	if(status != null) 'status': status,
	if(acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toIso8601String(),
	if(acknowledgedBy != null) 'acknowledgedBy': acknowledgedBy,
	if(resolvedAt != null) 'resolvedAt': resolvedAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PerformanceAlert &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    