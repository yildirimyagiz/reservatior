//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'ai_model.dart';
import 'organization.dart';

class AIModelDeployment
    implements PrismaModel<String, AIModelDeployment>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? modelId;
  String? deploymentId;
  String? environment;
  String? status;
  DateTime? deployedAt;
  DateTime? lastHealthCheck;
  dynamic config;
  dynamic metrics;
  DateTime? createdAt;
  DateTime? updatedAt;
  AIModel? model;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIModelDeployment({
    this.id,
    this.orgId,
    this.modelId,
    this.deploymentId,
    this.environment,
    this.status = "DEPLOYED",
    this.deployedAt,
    this.lastHealthCheck,
    required this.config,
    required this.metrics,
    this.createdAt,
    this.updatedAt,
    this.model,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIModelDeployment, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "modelId": (m) => m.modelId,
    "deploymentId": (m) => m.deploymentId,
    "environment": (m) => m.environment,
    "status": (m) => m.status,
    "deployedAt": (m) => m.deployedAt,
    "lastHealthCheck": (m) => m.lastHealthCheck,
    "config": (m) => m.config,
    "metrics": (m) => m.metrics,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "model": (m) => m.model,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIModelDeployment) getPropToValueFunction<V>(
      String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception(
          'Property "$propertyName" not found in AIModelDeployment');
    }
    return propFunction as V? Function(AIModelDeployment);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIModelDeployment.fromJson(JsonMap json) => AIModelDeployment(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        modelId: json['modelId'] as String?,
        deploymentId: json['deploymentId'] as String?,
        environment: json['environment'] as String?,
        status: json['status'] as String?,
        deployedAt: json['deployedAt'] != null
            ? DateTime.parse(json['deployedAt'])
            : null,
        lastHealthCheck: json['lastHealthCheck'] != null
            ? DateTime.parse(json['lastHealthCheck'])
            : null,
        config: json['config'] as dynamic,
        metrics: json['metrics'] as dynamic,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
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
  AIModelDeployment copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? modelId,
    Value<String?>? deploymentId,
    Value<String?>? environment,
    Value<String?>? status,
    Value<DateTime?>? deployedAt,
    Value<DateTime?>? lastHealthCheck,
    Value<dynamic>? config,
    Value<dynamic>? metrics,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<AIModel?>? model,
    Value<Organization?>? org,
  }) {
    return AIModelDeployment(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        modelId: modelId != null ? modelId.value : this.modelId,
        deploymentId:
            deploymentId != null ? deploymentId.value : this.deploymentId,
        environment: environment != null ? environment.value : this.environment,
        status: status != null ? status.value : this.status,
        deployedAt: deployedAt != null ? deployedAt.value : this.deployedAt,
        lastHealthCheck: lastHealthCheck != null
            ? lastHealthCheck.value
            : this.lastHealthCheck,
        config: config != null ? config.value : this.config,
        metrics: metrics != null ? metrics.value : this.metrics,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        model: model != null ? model.value : this.model,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIModelDeployment copyWithInstanceValues(
      AIModelDeployment aIModelDeployment) {
    return AIModelDeployment(
        id: aIModelDeployment.id ?? id,
        orgId: aIModelDeployment.orgId ?? orgId,
        modelId: aIModelDeployment.modelId ?? modelId,
        deploymentId: aIModelDeployment.deploymentId ?? deploymentId,
        environment: aIModelDeployment.environment ?? environment,
        status: aIModelDeployment.status ?? status,
        deployedAt: aIModelDeployment.deployedAt ?? deployedAt,
        lastHealthCheck: aIModelDeployment.lastHealthCheck ?? lastHealthCheck,
        config: aIModelDeployment.config ?? config,
        metrics: aIModelDeployment.metrics ?? metrics,
        createdAt: aIModelDeployment.createdAt ?? createdAt,
        updatedAt: aIModelDeployment.updatedAt ?? updatedAt,
        model: aIModelDeployment.model ?? model,
        org: aIModelDeployment.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIModelDeployment mergeWithInstanceValues(
      AIModelDeployment aIModelDeployment) {
    return AIModelDeployment(
        id: aIModelDeployment.$assignedFields.contains('id')
            ? aIModelDeployment.id
            : id,
        orgId: aIModelDeployment.$assignedFields.contains('orgId')
            ? aIModelDeployment.orgId
            : orgId,
        modelId: aIModelDeployment.$assignedFields.contains('modelId')
            ? aIModelDeployment.modelId
            : modelId,
        deploymentId: aIModelDeployment.$assignedFields.contains('deploymentId')
            ? aIModelDeployment.deploymentId
            : deploymentId,
        environment: aIModelDeployment.$assignedFields.contains('environment')
            ? aIModelDeployment.environment
            : environment,
        status: aIModelDeployment.$assignedFields.contains('status')
            ? aIModelDeployment.status
            : status,
        deployedAt: aIModelDeployment.$assignedFields.contains('deployedAt')
            ? aIModelDeployment.deployedAt
            : deployedAt,
        lastHealthCheck:
            aIModelDeployment.$assignedFields.contains('lastHealthCheck')
                ? aIModelDeployment.lastHealthCheck
                : lastHealthCheck,
        config: aIModelDeployment.$assignedFields.contains('config')
            ? aIModelDeployment.config
            : config,
        metrics: aIModelDeployment.$assignedFields.contains('metrics')
            ? aIModelDeployment.metrics
            : metrics,
        createdAt: aIModelDeployment.$assignedFields.contains('createdAt')
            ? aIModelDeployment.createdAt
            : createdAt,
        updatedAt: aIModelDeployment.$assignedFields.contains('updatedAt')
            ? aIModelDeployment.updatedAt
            : updatedAt,
        model: aIModelDeployment.$assignedFields.contains('model')
            ? aIModelDeployment.model
            : model,
        org: aIModelDeployment.$assignedFields.contains('org')
            ? aIModelDeployment.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIModelDeployment updateWithInstanceValues(
      AIModelDeployment aIModelDeployment) {
    if (aIModelDeployment.$assignedFields.contains('id')) {
      id = aIModelDeployment.id;
    }
    if (aIModelDeployment.$assignedFields.contains('orgId')) {
      orgId = aIModelDeployment.orgId;
    }
    if (aIModelDeployment.$assignedFields.contains('modelId')) {
      modelId = aIModelDeployment.modelId;
    }
    if (aIModelDeployment.$assignedFields.contains('deploymentId')) {
      deploymentId = aIModelDeployment.deploymentId;
    }
    if (aIModelDeployment.$assignedFields.contains('environment')) {
      environment = aIModelDeployment.environment;
    }
    if (aIModelDeployment.$assignedFields.contains('status')) {
      status = aIModelDeployment.status;
    }
    if (aIModelDeployment.$assignedFields.contains('deployedAt')) {
      deployedAt = aIModelDeployment.deployedAt;
    }
    if (aIModelDeployment.$assignedFields.contains('lastHealthCheck')) {
      lastHealthCheck = aIModelDeployment.lastHealthCheck;
    }
    if (aIModelDeployment.$assignedFields.contains('config')) {
      config = aIModelDeployment.config;
    }
    if (aIModelDeployment.$assignedFields.contains('metrics')) {
      metrics = aIModelDeployment.metrics;
    }
    if (aIModelDeployment.$assignedFields.contains('createdAt')) {
      createdAt = aIModelDeployment.createdAt;
    }
    if (aIModelDeployment.$assignedFields.contains('updatedAt')) {
      updatedAt = aIModelDeployment.updatedAt;
    }
    if (aIModelDeployment.$assignedFields.contains('model')) {
      model = aIModelDeployment.model;
    }
    if (aIModelDeployment.$assignedFields.contains('org')) {
      org = aIModelDeployment.org;
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
        ? {...?serializedTypes, 'AIModelDeployment'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (modelId != null) 'modelId': modelId,
      if (deploymentId != null) 'deploymentId': deploymentId,
      if (environment != null) 'environment': environment,
      if (status != null) 'status': status,
      if (deployedAt != null) 'deployedAt': deployedAt?.toIso8601String(),
      if (lastHealthCheck != null)
        'lastHealthCheck': lastHealthCheck?.toIso8601String(),
      if (config != null) 'config': config,
      if (metrics != null) 'metrics': metrics,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
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
      other is AIModelDeployment &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
