
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class IntegrationLog implements PrismaModel<String, IntegrationLog> , Id<String> {
    @override
String? id;
	String? orgId;
	String? integrationType;
	String? operation;
	dynamic requestData;
	dynamic responseData;
	int? statusCode;
	bool? success;
	String? errorMessage;
	int? processingTimeMs;
	String? externalId;
	String? correlationId;
	DateTime? createdAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    IntegrationLog({ this.id,
	 this.orgId,
	 this.integrationType,
	 this.operation,
	required this.requestData,
	required this.responseData,
	 this.statusCode,
	 this.success,
	 this.errorMessage,
	 this.processingTimeMs,
	 this.externalId,
	 this.correlationId,
	 this.createdAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<IntegrationLog, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"integrationType": (m) => m.integrationType,

	"operation": (m) => m.operation,

	"requestData": (m) => m.requestData,

	"responseData": (m) => m.responseData,

	"statusCode": (m) => m.statusCode,

	"success": (m) => m.success,

	"errorMessage": (m) => m.errorMessage,

	"processingTimeMs": (m) => m.processingTimeMs,

	"externalId": (m) => m.externalId,

	"correlationId": (m) => m.correlationId,

	"createdAt": (m) => m.createdAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(IntegrationLog) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in IntegrationLog');
    }
    return propFunction as V? Function(IntegrationLog);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory IntegrationLog.fromJson(JsonMap json) =>
      IntegrationLog(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	integrationType: json['integrationType'] as String?,
	operation: json['operation'] as String?,
	requestData: json['requestData'] as dynamic,
	responseData: json['responseData'] as dynamic,
	statusCode: int.tryParse(json['statusCode'].toString()),
	success: json['success'] as bool?,
	errorMessage: json['errorMessage'] as String?,
	processingTimeMs: int.tryParse(json['processingTimeMs'].toString()),
	externalId: json['externalId'] as String?,
	correlationId: json['correlationId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    IntegrationLog copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? integrationType,
		Value<String?>? operation,
		Value<dynamic>? requestData,
		Value<dynamic>? responseData,
		Value<int?>? statusCode,
		Value<bool?>? success,
		Value<String?>? errorMessage,
		Value<int?>? processingTimeMs,
		Value<String?>? externalId,
		Value<String?>? correlationId,
		Value<DateTime?>? createdAt,
		Value<Organization?>? org,
        }) {
        return IntegrationLog(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		integrationType: integrationType != null ? integrationType.value : this.integrationType,
		operation: operation != null ? operation.value : this.operation,
		requestData: requestData != null ? requestData.value : this.requestData,
		responseData: responseData != null ? responseData.value : this.responseData,
		statusCode: statusCode != null ? statusCode.value : this.statusCode,
		success: success != null ? success.value : this.success,
		errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
		processingTimeMs: processingTimeMs != null ? processingTimeMs.value : this.processingTimeMs,
		externalId: externalId != null ? externalId.value : this.externalId,
		correlationId: correlationId != null ? correlationId.value : this.correlationId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    IntegrationLog copyWithInstanceValues(IntegrationLog integrationLog) {
        return IntegrationLog(
            id: integrationLog.id ?? id,
		orgId: integrationLog.orgId ?? orgId,
		integrationType: integrationLog.integrationType ?? integrationType,
		operation: integrationLog.operation ?? operation,
		requestData: integrationLog.requestData ?? requestData,
		responseData: integrationLog.responseData ?? responseData,
		statusCode: integrationLog.statusCode ?? statusCode,
		success: integrationLog.success ?? success,
		errorMessage: integrationLog.errorMessage ?? errorMessage,
		processingTimeMs: integrationLog.processingTimeMs ?? processingTimeMs,
		externalId: integrationLog.externalId ?? externalId,
		correlationId: integrationLog.correlationId ?? correlationId,
		createdAt: integrationLog.createdAt ?? createdAt,
		org: integrationLog.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    IntegrationLog mergeWithInstanceValues(IntegrationLog integrationLog) {
        return IntegrationLog(
            id: integrationLog.$assignedFields.contains('id') ? integrationLog.id : id,
		orgId: integrationLog.$assignedFields.contains('orgId') ? integrationLog.orgId : orgId,
		integrationType: integrationLog.$assignedFields.contains('integrationType') ? integrationLog.integrationType : integrationType,
		operation: integrationLog.$assignedFields.contains('operation') ? integrationLog.operation : operation,
		requestData: integrationLog.$assignedFields.contains('requestData') ? integrationLog.requestData : requestData,
		responseData: integrationLog.$assignedFields.contains('responseData') ? integrationLog.responseData : responseData,
		statusCode: integrationLog.$assignedFields.contains('statusCode') ? integrationLog.statusCode : statusCode,
		success: integrationLog.$assignedFields.contains('success') ? integrationLog.success : success,
		errorMessage: integrationLog.$assignedFields.contains('errorMessage') ? integrationLog.errorMessage : errorMessage,
		processingTimeMs: integrationLog.$assignedFields.contains('processingTimeMs') ? integrationLog.processingTimeMs : processingTimeMs,
		externalId: integrationLog.$assignedFields.contains('externalId') ? integrationLog.externalId : externalId,
		correlationId: integrationLog.$assignedFields.contains('correlationId') ? integrationLog.correlationId : correlationId,
		createdAt: integrationLog.$assignedFields.contains('createdAt') ? integrationLog.createdAt : createdAt,
		org: integrationLog.$assignedFields.contains('org') ? integrationLog.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    IntegrationLog updateWithInstanceValues(IntegrationLog integrationLog) {
        if (integrationLog.$assignedFields.contains('id')) { id = integrationLog.id; }
		if (integrationLog.$assignedFields.contains('orgId')) { orgId = integrationLog.orgId; }
		if (integrationLog.$assignedFields.contains('integrationType')) { integrationType = integrationLog.integrationType; }
		if (integrationLog.$assignedFields.contains('operation')) { operation = integrationLog.operation; }
		if (integrationLog.$assignedFields.contains('requestData')) { requestData = integrationLog.requestData; }
		if (integrationLog.$assignedFields.contains('responseData')) { responseData = integrationLog.responseData; }
		if (integrationLog.$assignedFields.contains('statusCode')) { statusCode = integrationLog.statusCode; }
		if (integrationLog.$assignedFields.contains('success')) { success = integrationLog.success; }
		if (integrationLog.$assignedFields.contains('errorMessage')) { errorMessage = integrationLog.errorMessage; }
		if (integrationLog.$assignedFields.contains('processingTimeMs')) { processingTimeMs = integrationLog.processingTimeMs; }
		if (integrationLog.$assignedFields.contains('externalId')) { externalId = integrationLog.externalId; }
		if (integrationLog.$assignedFields.contains('correlationId')) { correlationId = integrationLog.correlationId; }
		if (integrationLog.$assignedFields.contains('createdAt')) { createdAt = integrationLog.createdAt; }
		if (integrationLog.$assignedFields.contains('org')) { org = integrationLog.org; }
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
          ? {...?serializedTypes, 'IntegrationLog'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(integrationType != null) 'integrationType': integrationType,
	if(operation != null) 'operation': operation,
	if(requestData != null) 'requestData': requestData,
	if(responseData != null) 'responseData': responseData,
	if(statusCode != null) 'statusCode': statusCode,
	if(success != null) 'success': success,
	if(errorMessage != null) 'errorMessage': errorMessage,
	if(processingTimeMs != null) 'processingTimeMs': processingTimeMs,
	if(externalId != null) 'externalId': externalId,
	if(correlationId != null) 'correlationId': correlationId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is IntegrationLog &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    