
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class HealthCheck implements PrismaModel<String, HealthCheck> , Id<String> {
    @override
String? id;
	String? orgId;
	String? serviceName;
	String? componentName;
	String? status;
	int? responseTime;
	dynamic details;
	String? errorMessage;
	DateTime? checkedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    HealthCheck({ this.id,
	 this.orgId,
	 this.serviceName,
	 this.componentName,
	 this.status,
	 this.responseTime,
	required this.details,
	 this.errorMessage,
	 this.checkedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<HealthCheck, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"serviceName": (m) => m.serviceName,

	"componentName": (m) => m.componentName,

	"status": (m) => m.status,

	"responseTime": (m) => m.responseTime,

	"details": (m) => m.details,

	"errorMessage": (m) => m.errorMessage,

	"checkedAt": (m) => m.checkedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(HealthCheck) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in HealthCheck');
    }
    return propFunction as V? Function(HealthCheck);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory HealthCheck.fromJson(JsonMap json) =>
      HealthCheck(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	serviceName: json['serviceName'] as String?,
	componentName: json['componentName'] as String?,
	status: json['status'] as String?,
	responseTime: int.tryParse(json['responseTime'].toString()),
	details: json['details'] as dynamic,
	errorMessage: json['errorMessage'] as String?,
	checkedAt: json['checkedAt'] != null ? DateTime.parse(json['checkedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    HealthCheck copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? serviceName,
		Value<String?>? componentName,
		Value<String?>? status,
		Value<int?>? responseTime,
		Value<dynamic>? details,
		Value<String?>? errorMessage,
		Value<DateTime?>? checkedAt,
		Value<Organization?>? org,
        }) {
        return HealthCheck(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		serviceName: serviceName != null ? serviceName.value : this.serviceName,
		componentName: componentName != null ? componentName.value : this.componentName,
		status: status != null ? status.value : this.status,
		responseTime: responseTime != null ? responseTime.value : this.responseTime,
		details: details != null ? details.value : this.details,
		errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
		checkedAt: checkedAt != null ? checkedAt.value : this.checkedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    HealthCheck copyWithInstanceValues(HealthCheck healthCheck) {
        return HealthCheck(
            id: healthCheck.id ?? id,
		orgId: healthCheck.orgId ?? orgId,
		serviceName: healthCheck.serviceName ?? serviceName,
		componentName: healthCheck.componentName ?? componentName,
		status: healthCheck.status ?? status,
		responseTime: healthCheck.responseTime ?? responseTime,
		details: healthCheck.details ?? details,
		errorMessage: healthCheck.errorMessage ?? errorMessage,
		checkedAt: healthCheck.checkedAt ?? checkedAt,
		org: healthCheck.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    HealthCheck mergeWithInstanceValues(HealthCheck healthCheck) {
        return HealthCheck(
            id: healthCheck.$assignedFields.contains('id') ? healthCheck.id : id,
		orgId: healthCheck.$assignedFields.contains('orgId') ? healthCheck.orgId : orgId,
		serviceName: healthCheck.$assignedFields.contains('serviceName') ? healthCheck.serviceName : serviceName,
		componentName: healthCheck.$assignedFields.contains('componentName') ? healthCheck.componentName : componentName,
		status: healthCheck.$assignedFields.contains('status') ? healthCheck.status : status,
		responseTime: healthCheck.$assignedFields.contains('responseTime') ? healthCheck.responseTime : responseTime,
		details: healthCheck.$assignedFields.contains('details') ? healthCheck.details : details,
		errorMessage: healthCheck.$assignedFields.contains('errorMessage') ? healthCheck.errorMessage : errorMessage,
		checkedAt: healthCheck.$assignedFields.contains('checkedAt') ? healthCheck.checkedAt : checkedAt,
		org: healthCheck.$assignedFields.contains('org') ? healthCheck.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    HealthCheck updateWithInstanceValues(HealthCheck healthCheck) {
        if (healthCheck.$assignedFields.contains('id')) { id = healthCheck.id; }
		if (healthCheck.$assignedFields.contains('orgId')) { orgId = healthCheck.orgId; }
		if (healthCheck.$assignedFields.contains('serviceName')) { serviceName = healthCheck.serviceName; }
		if (healthCheck.$assignedFields.contains('componentName')) { componentName = healthCheck.componentName; }
		if (healthCheck.$assignedFields.contains('status')) { status = healthCheck.status; }
		if (healthCheck.$assignedFields.contains('responseTime')) { responseTime = healthCheck.responseTime; }
		if (healthCheck.$assignedFields.contains('details')) { details = healthCheck.details; }
		if (healthCheck.$assignedFields.contains('errorMessage')) { errorMessage = healthCheck.errorMessage; }
		if (healthCheck.$assignedFields.contains('checkedAt')) { checkedAt = healthCheck.checkedAt; }
		if (healthCheck.$assignedFields.contains('org')) { org = healthCheck.org; }
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
          ? {...?serializedTypes, 'HealthCheck'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(serviceName != null) 'serviceName': serviceName,
	if(componentName != null) 'componentName': componentName,
	if(status != null) 'status': status,
	if(responseTime != null) 'responseTime': responseTime,
	if(details != null) 'details': details,
	if(errorMessage != null) 'errorMessage': errorMessage,
	if(checkedAt != null) 'checkedAt': checkedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is HealthCheck &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    