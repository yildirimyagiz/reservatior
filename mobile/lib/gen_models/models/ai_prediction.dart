//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'ai_model.dart';
import 'organization.dart';

class AIPrediction implements PrismaModel<String, AIPrediction>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? modelId;
  String? requestId;
  String? batchId;
  String? modelType;
  dynamic inputData;
  dynamic outputData;
  dynamic result;
  double? confidence;
  int? processingTimeMs;
  int? processingTime;
  String? status;
  bool? success;
  String? errorMessage;
  String? userId;
  String? propertyId;
  dynamic metadata;
  DateTime? createdAt;
  AIModel? model;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIPrediction({
    this.id,
    this.orgId,
    this.modelId,
    this.requestId,
    this.batchId,
    this.modelType,
    required this.inputData,
    required this.outputData,
    required this.result,
    this.confidence,
    this.processingTimeMs,
    this.processingTime,
    this.status = "COMPLETED",
    this.success = true,
    this.errorMessage,
    this.userId,
    this.propertyId,
    required this.metadata,
    this.createdAt,
    this.model,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIPrediction, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "modelId": (m) => m.modelId,
    "requestId": (m) => m.requestId,
    "batchId": (m) => m.batchId,
    "modelType": (m) => m.modelType,
    "inputData": (m) => m.inputData,
    "outputData": (m) => m.outputData,
    "result": (m) => m.result,
    "confidence": (m) => m.confidence,
    "processingTimeMs": (m) => m.processingTimeMs,
    "processingTime": (m) => m.processingTime,
    "status": (m) => m.status,
    "success": (m) => m.success,
    "errorMessage": (m) => m.errorMessage,
    "userId": (m) => m.userId,
    "propertyId": (m) => m.propertyId,
    "metadata": (m) => m.metadata,
    "createdAt": (m) => m.createdAt,
    "model": (m) => m.model,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIPrediction) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIPrediction');
    }
    return propFunction as V? Function(AIPrediction);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIPrediction.fromJson(JsonMap json) => AIPrediction(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        modelId: json['modelId'] as String?,
        requestId: json['requestId'] as String?,
        batchId: json['batchId'] as String?,
        modelType: json['modelType'] as String?,
        inputData: json['inputData'] as dynamic,
        outputData: json['outputData'] as dynamic,
        result: json['result'] as dynamic,
        confidence: json['confidence']?.toDouble(),
        processingTimeMs: int.tryParse(json['processingTimeMs'].toString()),
        processingTime: int.tryParse(json['processingTime'].toString()),
        status: json['status'] as String?,
        success: json['success'] as bool?,
        errorMessage: json['errorMessage'] as String?,
        userId: json['userId'] as String?,
        propertyId: json['propertyId'] as String?,
        metadata: json['metadata'] as dynamic,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        model: json['model'] != null
            ? AIModel.fromJson(json['model'] as JsonMap)
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIPrediction copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? modelId,
    Value<String?>? requestId,
    Value<String?>? batchId,
    Value<String?>? modelType,
    Value<dynamic>? inputData,
    Value<dynamic>? outputData,
    Value<dynamic>? result,
    Value<double?>? confidence,
    Value<int?>? processingTimeMs,
    Value<int?>? processingTime,
    Value<String?>? status,
    Value<bool?>? success,
    Value<String?>? errorMessage,
    Value<String?>? userId,
    Value<String?>? propertyId,
    Value<dynamic>? metadata,
    Value<DateTime?>? createdAt,
    Value<AIModel?>? model,
    Value<Organization?>? org,
  }) {
    return AIPrediction(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        modelId: modelId != null ? modelId.value : this.modelId,
        requestId: requestId != null ? requestId.value : this.requestId,
        batchId: batchId != null ? batchId.value : this.batchId,
        modelType: modelType != null ? modelType.value : this.modelType,
        inputData: inputData != null ? inputData.value : this.inputData,
        outputData: outputData != null ? outputData.value : this.outputData,
        result: result != null ? result.value : this.result,
        confidence: confidence != null ? confidence.value : this.confidence,
        processingTimeMs: processingTimeMs != null
            ? processingTimeMs.value
            : this.processingTimeMs,
        processingTime:
            processingTime != null ? processingTime.value : this.processingTime,
        status: status != null ? status.value : this.status,
        success: success != null ? success.value : this.success,
        errorMessage:
            errorMessage != null ? errorMessage.value : this.errorMessage,
        userId: userId != null ? userId.value : this.userId,
        propertyId: propertyId != null ? propertyId.value : this.propertyId,
        metadata: metadata != null ? metadata.value : this.metadata,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        model: model != null ? model.value : this.model,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIPrediction copyWithInstanceValues(AIPrediction aIPrediction) {
    return AIPrediction(
        id: aIPrediction.id ?? id,
        orgId: aIPrediction.orgId ?? orgId,
        modelId: aIPrediction.modelId ?? modelId,
        requestId: aIPrediction.requestId ?? requestId,
        batchId: aIPrediction.batchId ?? batchId,
        modelType: aIPrediction.modelType ?? modelType,
        inputData: aIPrediction.inputData ?? inputData,
        outputData: aIPrediction.outputData ?? outputData,
        result: aIPrediction.result ?? result,
        confidence: aIPrediction.confidence ?? confidence,
        processingTimeMs: aIPrediction.processingTimeMs ?? processingTimeMs,
        processingTime: aIPrediction.processingTime ?? processingTime,
        status: aIPrediction.status ?? status,
        success: aIPrediction.success ?? success,
        errorMessage: aIPrediction.errorMessage ?? errorMessage,
        userId: aIPrediction.userId ?? userId,
        propertyId: aIPrediction.propertyId ?? propertyId,
        metadata: aIPrediction.metadata ?? metadata,
        createdAt: aIPrediction.createdAt ?? createdAt,
        model: aIPrediction.model ?? model,
        org: aIPrediction.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIPrediction mergeWithInstanceValues(AIPrediction aIPrediction) {
    return AIPrediction(
        id: aIPrediction.$assignedFields.contains('id') ? aIPrediction.id : id,
        orgId: aIPrediction.$assignedFields.contains('orgId')
            ? aIPrediction.orgId
            : orgId,
        modelId: aIPrediction.$assignedFields.contains('modelId')
            ? aIPrediction.modelId
            : modelId,
        requestId: aIPrediction.$assignedFields.contains('requestId')
            ? aIPrediction.requestId
            : requestId,
        batchId: aIPrediction.$assignedFields.contains('batchId')
            ? aIPrediction.batchId
            : batchId,
        modelType: aIPrediction.$assignedFields.contains('modelType')
            ? aIPrediction.modelType
            : modelType,
        inputData: aIPrediction.$assignedFields.contains('inputData')
            ? aIPrediction.inputData
            : inputData,
        outputData: aIPrediction.$assignedFields.contains('outputData')
            ? aIPrediction.outputData
            : outputData,
        result: aIPrediction.$assignedFields.contains('result')
            ? aIPrediction.result
            : result,
        confidence: aIPrediction.$assignedFields.contains('confidence')
            ? aIPrediction.confidence
            : confidence,
        processingTimeMs:
            aIPrediction.$assignedFields.contains('processingTimeMs')
                ? aIPrediction.processingTimeMs
                : processingTimeMs,
        processingTime: aIPrediction.$assignedFields.contains('processingTime')
            ? aIPrediction.processingTime
            : processingTime,
        status: aIPrediction.$assignedFields.contains('status')
            ? aIPrediction.status
            : status,
        success: aIPrediction.$assignedFields.contains('success')
            ? aIPrediction.success
            : success,
        errorMessage: aIPrediction.$assignedFields.contains('errorMessage')
            ? aIPrediction.errorMessage
            : errorMessage,
        userId: aIPrediction.$assignedFields.contains('userId')
            ? aIPrediction.userId
            : userId,
        propertyId: aIPrediction.$assignedFields.contains('propertyId')
            ? aIPrediction.propertyId
            : propertyId,
        metadata: aIPrediction.$assignedFields.contains('metadata')
            ? aIPrediction.metadata
            : metadata,
        createdAt: aIPrediction.$assignedFields.contains('createdAt')
            ? aIPrediction.createdAt
            : createdAt,
        model: aIPrediction.$assignedFields.contains('model')
            ? aIPrediction.model
            : model,
        org: aIPrediction.$assignedFields.contains('org')
            ? aIPrediction.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIPrediction updateWithInstanceValues(AIPrediction aIPrediction) {
    if (aIPrediction.$assignedFields.contains('id')) {
      id = aIPrediction.id;
    }
    if (aIPrediction.$assignedFields.contains('orgId')) {
      orgId = aIPrediction.orgId;
    }
    if (aIPrediction.$assignedFields.contains('modelId')) {
      modelId = aIPrediction.modelId;
    }
    if (aIPrediction.$assignedFields.contains('requestId')) {
      requestId = aIPrediction.requestId;
    }
    if (aIPrediction.$assignedFields.contains('batchId')) {
      batchId = aIPrediction.batchId;
    }
    if (aIPrediction.$assignedFields.contains('modelType')) {
      modelType = aIPrediction.modelType;
    }
    if (aIPrediction.$assignedFields.contains('inputData')) {
      inputData = aIPrediction.inputData;
    }
    if (aIPrediction.$assignedFields.contains('outputData')) {
      outputData = aIPrediction.outputData;
    }
    if (aIPrediction.$assignedFields.contains('result')) {
      result = aIPrediction.result;
    }
    if (aIPrediction.$assignedFields.contains('confidence')) {
      confidence = aIPrediction.confidence;
    }
    if (aIPrediction.$assignedFields.contains('processingTimeMs')) {
      processingTimeMs = aIPrediction.processingTimeMs;
    }
    if (aIPrediction.$assignedFields.contains('processingTime')) {
      processingTime = aIPrediction.processingTime;
    }
    if (aIPrediction.$assignedFields.contains('status')) {
      status = aIPrediction.status;
    }
    if (aIPrediction.$assignedFields.contains('success')) {
      success = aIPrediction.success;
    }
    if (aIPrediction.$assignedFields.contains('errorMessage')) {
      errorMessage = aIPrediction.errorMessage;
    }
    if (aIPrediction.$assignedFields.contains('userId')) {
      userId = aIPrediction.userId;
    }
    if (aIPrediction.$assignedFields.contains('propertyId')) {
      propertyId = aIPrediction.propertyId;
    }
    if (aIPrediction.$assignedFields.contains('metadata')) {
      metadata = aIPrediction.metadata;
    }
    if (aIPrediction.$assignedFields.contains('createdAt')) {
      createdAt = aIPrediction.createdAt;
    }
    if (aIPrediction.$assignedFields.contains('model')) {
      model = aIPrediction.model;
    }
    if (aIPrediction.$assignedFields.contains('org')) {
      org = aIPrediction.org;
    }
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
        ? {...?serializedTypes, 'AIPrediction'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (modelId != null) 'modelId': modelId,
      if (requestId != null) 'requestId': requestId,
      if (batchId != null) 'batchId': batchId,
      if (modelType != null) 'modelType': modelType,
      if (inputData != null) 'inputData': inputData,
      if (outputData != null) 'outputData': outputData,
      if (result != null) 'result': result,
      if (confidence != null) 'confidence': confidence,
      if (processingTimeMs != null) 'processingTimeMs': processingTimeMs,
      if (processingTime != null) 'processingTime': processingTime,
      if (status != null) 'status': status,
      if (success != null) 'success': success,
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (userId != null) 'userId': userId,
      if (propertyId != null) 'propertyId': propertyId,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (model != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AIModel')))
        'model': model?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (org != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'org': org?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization)
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIPrediction &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
