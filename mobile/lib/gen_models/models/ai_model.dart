//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'ai_model_deployment.dart';
import 'ai_prediction.dart';

class AIModel implements PrismaModel<String, AIModel>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? modelName;
  String? modelVersion;
  String? modelType;
  String? provider;
  String? endpointUrl;
  String? apiKey;
  String? status;
  double? accuracy;
  DateTime? lastTrainedAt;
  dynamic config;
  dynamic metadata;
  DateTime? createdAt;
  DateTime? updatedAt;
  Organization? org;
  List<AIModelDeployment>? deployments;
  List<AIPrediction>? predictions;
  int? $deploymentsCount;
  int? $predictionsCount;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIModel({
    this.id,
    this.orgId,
    this.modelName,
    this.modelVersion,
    this.modelType,
    this.provider,
    this.endpointUrl,
    this.apiKey,
    this.status = "ACTIVE",
    this.accuracy,
    this.lastTrainedAt,
    required this.config,
    required this.metadata,
    this.createdAt,
    this.updatedAt,
    this.org,
    this.deployments,
    this.predictions,
    this.$deploymentsCount,
    this.$predictionsCount,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIModel, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "modelName": (m) => m.modelName,
    "modelVersion": (m) => m.modelVersion,
    "modelType": (m) => m.modelType,
    "provider": (m) => m.provider,
    "endpointUrl": (m) => m.endpointUrl,
    "apiKey": (m) => m.apiKey,
    "status": (m) => m.status,
    "accuracy": (m) => m.accuracy,
    "lastTrainedAt": (m) => m.lastTrainedAt,
    "config": (m) => m.config,
    "metadata": (m) => m.metadata,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "org": (m) => m.org,
    "deployments": (m) => m.deployments,
    "predictions": (m) => m.predictions,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIModel) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIModel');
    }
    return propFunction as V? Function(AIModel);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIModel.fromJson(JsonMap json) => AIModel(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        modelName: json['modelName'] as String?,
        modelVersion: json['modelVersion'] as String?,
        modelType: json['modelType'] as String?,
        provider: json['provider'] as String?,
        endpointUrl: json['endpointUrl'] as String?,
        apiKey: json['apiKey'] as String?,
        status: json['status'] as String?,
        accuracy: json['accuracy']?.toDouble(),
        lastTrainedAt: json['lastTrainedAt'] != null
            ? DateTime.parse(json['lastTrainedAt'])
            : null,
        config: json['config'] as dynamic,
        metadata: json['metadata'] as dynamic,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        deployments: json['deployments'] != null
            ? createModels<AIModelDeployment>(
                (json['deployments'] as List).cast<JsonMap>(),
                AIModelDeployment.fromJson)
            : null,
        predictions: json['predictions'] != null
            ? createModels<AIPrediction>(
                (json['predictions'] as List).cast<JsonMap>(),
                AIPrediction.fromJson)
            : null,
        $deploymentsCount: json['_count']?['deployments'] as int?,
        $predictionsCount: json['_count']?['predictions'] as int?,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIModel copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? modelName,
    Value<String?>? modelVersion,
    Value<String?>? modelType,
    Value<String?>? provider,
    Value<String?>? endpointUrl,
    Value<String?>? apiKey,
    Value<String?>? status,
    Value<double?>? accuracy,
    Value<DateTime?>? lastTrainedAt,
    Value<dynamic>? config,
    Value<dynamic>? metadata,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<Organization?>? org,
    Value<List<AIModelDeployment>?>? deployments,
    Value<List<AIPrediction>?>? predictions,
    int? $deploymentsCount,
    int? $predictionsCount,
  }) {
    return AIModel(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        modelName: modelName != null ? modelName.value : this.modelName,
        modelVersion:
            modelVersion != null ? modelVersion.value : this.modelVersion,
        modelType: modelType != null ? modelType.value : this.modelType,
        provider: provider != null ? provider.value : this.provider,
        endpointUrl: endpointUrl != null ? endpointUrl.value : this.endpointUrl,
        apiKey: apiKey != null ? apiKey.value : this.apiKey,
        status: status != null ? status.value : this.status,
        accuracy: accuracy != null ? accuracy.value : this.accuracy,
        lastTrainedAt:
            lastTrainedAt != null ? lastTrainedAt.value : this.lastTrainedAt,
        config: config != null ? config.value : this.config,
        metadata: metadata != null ? metadata.value : this.metadata,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        org: org != null ? org.value : this.org,
        deployments: deployments != null ? deployments.value : this.deployments,
        predictions: predictions != null ? predictions.value : this.predictions,
        $deploymentsCount: $deploymentsCount ?? this.$deploymentsCount,
        $predictionsCount: $predictionsCount ?? this.$predictionsCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIModel copyWithInstanceValues(AIModel aIModel) {
    return AIModel(
        id: aIModel.id ?? id,
        orgId: aIModel.orgId ?? orgId,
        modelName: aIModel.modelName ?? modelName,
        modelVersion: aIModel.modelVersion ?? modelVersion,
        modelType: aIModel.modelType ?? modelType,
        provider: aIModel.provider ?? provider,
        endpointUrl: aIModel.endpointUrl ?? endpointUrl,
        apiKey: aIModel.apiKey ?? apiKey,
        status: aIModel.status ?? status,
        accuracy: aIModel.accuracy ?? accuracy,
        lastTrainedAt: aIModel.lastTrainedAt ?? lastTrainedAt,
        config: aIModel.config ?? config,
        metadata: aIModel.metadata ?? metadata,
        createdAt: aIModel.createdAt ?? createdAt,
        updatedAt: aIModel.updatedAt ?? updatedAt,
        org: aIModel.org ?? org,
        deployments: aIModel.deployments ?? deployments,
        predictions: aIModel.predictions ?? predictions,
        $deploymentsCount: aIModel.$deploymentsCount ?? $deploymentsCount,
        $predictionsCount: aIModel.$predictionsCount ?? $predictionsCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIModel mergeWithInstanceValues(AIModel aIModel) {
    return AIModel(
        id: aIModel.$assignedFields.contains('id') ? aIModel.id : id,
        orgId:
            aIModel.$assignedFields.contains('orgId') ? aIModel.orgId : orgId,
        modelName: aIModel.$assignedFields.contains('modelName')
            ? aIModel.modelName
            : modelName,
        modelVersion: aIModel.$assignedFields.contains('modelVersion')
            ? aIModel.modelVersion
            : modelVersion,
        modelType: aIModel.$assignedFields.contains('modelType')
            ? aIModel.modelType
            : modelType,
        provider: aIModel.$assignedFields.contains('provider')
            ? aIModel.provider
            : provider,
        endpointUrl: aIModel.$assignedFields.contains('endpointUrl')
            ? aIModel.endpointUrl
            : endpointUrl,
        apiKey: aIModel.$assignedFields.contains('apiKey')
            ? aIModel.apiKey
            : apiKey,
        status: aIModel.$assignedFields.contains('status')
            ? aIModel.status
            : status,
        accuracy: aIModel.$assignedFields.contains('accuracy')
            ? aIModel.accuracy
            : accuracy,
        lastTrainedAt: aIModel.$assignedFields.contains('lastTrainedAt')
            ? aIModel.lastTrainedAt
            : lastTrainedAt,
        config: aIModel.$assignedFields.contains('config')
            ? aIModel.config
            : config,
        metadata: aIModel.$assignedFields.contains('metadata')
            ? aIModel.metadata
            : metadata,
        createdAt: aIModel.$assignedFields.contains('createdAt')
            ? aIModel.createdAt
            : createdAt,
        updatedAt: aIModel.$assignedFields.contains('updatedAt')
            ? aIModel.updatedAt
            : updatedAt,
        org: aIModel.$assignedFields.contains('org') ? aIModel.org : org,
        deployments: (aIModel.$assignedFields.contains('deployments') &&
                aIModel.deployments != null)
            ? mergeModelLists(deployments, aIModel.deployments)
            : deployments,
        predictions: (aIModel.$assignedFields.contains('predictions') &&
                aIModel.predictions != null)
            ? mergeModelLists(predictions, aIModel.predictions)
            : predictions,
        $deploymentsCount: aIModel.$deploymentsCount ?? $deploymentsCount,
        $predictionsCount: aIModel.$predictionsCount ?? $predictionsCount);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIModel updateWithInstanceValues(AIModel aIModel) {
    if (aIModel.$assignedFields.contains('id')) {
      id = aIModel.id;
    }
    if (aIModel.$assignedFields.contains('orgId')) {
      orgId = aIModel.orgId;
    }
    if (aIModel.$assignedFields.contains('modelName')) {
      modelName = aIModel.modelName;
    }
    if (aIModel.$assignedFields.contains('modelVersion')) {
      modelVersion = aIModel.modelVersion;
    }
    if (aIModel.$assignedFields.contains('modelType')) {
      modelType = aIModel.modelType;
    }
    if (aIModel.$assignedFields.contains('provider')) {
      provider = aIModel.provider;
    }
    if (aIModel.$assignedFields.contains('endpointUrl')) {
      endpointUrl = aIModel.endpointUrl;
    }
    if (aIModel.$assignedFields.contains('apiKey')) {
      apiKey = aIModel.apiKey;
    }
    if (aIModel.$assignedFields.contains('status')) {
      status = aIModel.status;
    }
    if (aIModel.$assignedFields.contains('accuracy')) {
      accuracy = aIModel.accuracy;
    }
    if (aIModel.$assignedFields.contains('lastTrainedAt')) {
      lastTrainedAt = aIModel.lastTrainedAt;
    }
    if (aIModel.$assignedFields.contains('config')) {
      config = aIModel.config;
    }
    if (aIModel.$assignedFields.contains('metadata')) {
      metadata = aIModel.metadata;
    }
    if (aIModel.$assignedFields.contains('createdAt')) {
      createdAt = aIModel.createdAt;
    }
    if (aIModel.$assignedFields.contains('updatedAt')) {
      updatedAt = aIModel.updatedAt;
    }
    if (aIModel.$assignedFields.contains('org')) {
      org = aIModel.org;
    }
    if (aIModel.$assignedFields.contains('deployments') &&
        aIModel.deployments != null) {
      deployments = mergeModelLists(deployments, aIModel.deployments);
    }
    if (aIModel.$assignedFields.contains('predictions') &&
        aIModel.predictions != null) {
      predictions = mergeModelLists(predictions, aIModel.predictions);
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
        ? {...?serializedTypes, 'AIModel'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (modelName != null) 'modelName': modelName,
      if (modelVersion != null) 'modelVersion': modelVersion,
      if (modelType != null) 'modelType': modelType,
      if (provider != null) 'provider': provider,
      if (endpointUrl != null) 'endpointUrl': endpointUrl,
      if (apiKey != null) 'apiKey': apiKey,
      if (status != null) 'status': status,
      if (accuracy != null) 'accuracy': accuracy,
      if (lastTrainedAt != null)
        'lastTrainedAt': lastTrainedAt?.toIso8601String(),
      if (config != null) 'config': config,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (org != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'org': org?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (deployments != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AIModelDeployment')))
        'deployments': deployments
            ?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (predictions != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AIPrediction')))
        'predictions': predictions
            ?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if ($deploymentsCount != null || $predictionsCount != null)
        '_count': {
          if ($deploymentsCount != null) 'deployments': $deploymentsCount,
          if ($predictionsCount != null) 'predictions': $predictionsCount,
        },
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIModel &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
