//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'ai_property_valuation.dart';
import 'organization.dart';

class AIValuationModel
    implements PrismaModel<String, AIValuationModel>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? modelName;
  String? modelVersion;
  double? accuracy;
  DateTime? lastTrainedAt;
  dynamic features;
  dynamic hyperparameters;
  dynamic trainingMetrics;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<AIPropertyValuation>? valuations;
  Organization? org;
  int? $valuationsCount;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIValuationModel({
    this.id,
    this.orgId,
    this.modelName,
    this.modelVersion,
    this.accuracy,
    this.lastTrainedAt,
    required this.features,
    required this.hyperparameters,
    required this.trainingMetrics,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    this.valuations,
    this.org,
    this.$valuationsCount,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIValuationModel, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "modelName": (m) => m.modelName,
    "modelVersion": (m) => m.modelVersion,
    "accuracy": (m) => m.accuracy,
    "lastTrainedAt": (m) => m.lastTrainedAt,
    "features": (m) => m.features,
    "hyperparameters": (m) => m.hyperparameters,
    "trainingMetrics": (m) => m.trainingMetrics,
    "isActive": (m) => m.isActive,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "valuations": (m) => m.valuations,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIValuationModel) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIValuationModel');
    }
    return propFunction as V? Function(AIValuationModel);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIValuationModel.fromJson(JsonMap json) => AIValuationModel(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        modelName: json['modelName'] as String?,
        modelVersion: json['modelVersion'] as String?,
        accuracy: json['accuracy']?.toDouble(),
        lastTrainedAt: json['lastTrainedAt'] != null
            ? DateTime.parse(json['lastTrainedAt'])
            : null,
        features: json['features'] as dynamic,
        hyperparameters: json['hyperparameters'] as dynamic,
        trainingMetrics: json['trainingMetrics'] as dynamic,
        isActive: json['isActive'] as bool?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        valuations: json['valuations'] != null
            ? createModels<AIPropertyValuation>(
                (json['valuations'] as List).cast<JsonMap>(),
                AIPropertyValuation.fromJson)
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $valuationsCount: json['_count']?['valuations'] as int?,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIValuationModel copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? modelName,
    Value<String?>? modelVersion,
    Value<double?>? accuracy,
    Value<DateTime?>? lastTrainedAt,
    Value<dynamic>? features,
    Value<dynamic>? hyperparameters,
    Value<dynamic>? trainingMetrics,
    Value<bool?>? isActive,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<List<AIPropertyValuation>?>? valuations,
    Value<Organization?>? org,
    int? $valuationsCount,
  }) {
    return AIValuationModel(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        modelName: modelName != null ? modelName.value : this.modelName,
        modelVersion:
            modelVersion != null ? modelVersion.value : this.modelVersion,
        accuracy: accuracy != null ? accuracy.value : this.accuracy,
        lastTrainedAt:
            lastTrainedAt != null ? lastTrainedAt.value : this.lastTrainedAt,
        features: features != null ? features.value : this.features,
        hyperparameters: hyperparameters != null
            ? hyperparameters.value
            : this.hyperparameters,
        trainingMetrics: trainingMetrics != null
            ? trainingMetrics.value
            : this.trainingMetrics,
        isActive: isActive != null ? isActive.value : this.isActive,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        valuations: valuations != null ? valuations.value : this.valuations,
        org: org != null ? org.value : this.org,
        $valuationsCount: $valuationsCount ?? this.$valuationsCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIValuationModel copyWithInstanceValues(AIValuationModel aIValuationModel) {
    return AIValuationModel(
        id: aIValuationModel.id ?? id,
        orgId: aIValuationModel.orgId ?? orgId,
        modelName: aIValuationModel.modelName ?? modelName,
        modelVersion: aIValuationModel.modelVersion ?? modelVersion,
        accuracy: aIValuationModel.accuracy ?? accuracy,
        lastTrainedAt: aIValuationModel.lastTrainedAt ?? lastTrainedAt,
        features: aIValuationModel.features ?? features,
        hyperparameters: aIValuationModel.hyperparameters ?? hyperparameters,
        trainingMetrics: aIValuationModel.trainingMetrics ?? trainingMetrics,
        isActive: aIValuationModel.isActive ?? isActive,
        createdAt: aIValuationModel.createdAt ?? createdAt,
        updatedAt: aIValuationModel.updatedAt ?? updatedAt,
        valuations: aIValuationModel.valuations ?? valuations,
        org: aIValuationModel.org ?? org,
        $valuationsCount:
            aIValuationModel.$valuationsCount ?? $valuationsCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIValuationModel mergeWithInstanceValues(AIValuationModel aIValuationModel) {
    return AIValuationModel(
        id: aIValuationModel.$assignedFields.contains('id')
            ? aIValuationModel.id
            : id,
        orgId: aIValuationModel.$assignedFields.contains('orgId')
            ? aIValuationModel.orgId
            : orgId,
        modelName: aIValuationModel.$assignedFields.contains('modelName')
            ? aIValuationModel.modelName
            : modelName,
        modelVersion: aIValuationModel.$assignedFields.contains('modelVersion')
            ? aIValuationModel.modelVersion
            : modelVersion,
        accuracy: aIValuationModel.$assignedFields.contains('accuracy')
            ? aIValuationModel.accuracy
            : accuracy,
        lastTrainedAt:
            aIValuationModel.$assignedFields.contains('lastTrainedAt')
                ? aIValuationModel.lastTrainedAt
                : lastTrainedAt,
        features: aIValuationModel.$assignedFields.contains('features')
            ? aIValuationModel.features
            : features,
        hyperparameters:
            aIValuationModel.$assignedFields.contains('hyperparameters')
                ? aIValuationModel.hyperparameters
                : hyperparameters,
        trainingMetrics:
            aIValuationModel.$assignedFields.contains('trainingMetrics')
                ? aIValuationModel.trainingMetrics
                : trainingMetrics,
        isActive: aIValuationModel.$assignedFields.contains('isActive')
            ? aIValuationModel.isActive
            : isActive,
        createdAt: aIValuationModel.$assignedFields.contains('createdAt')
            ? aIValuationModel.createdAt
            : createdAt,
        updatedAt: aIValuationModel.$assignedFields.contains('updatedAt')
            ? aIValuationModel.updatedAt
            : updatedAt,
        valuations: (aIValuationModel.$assignedFields.contains('valuations') &&
                aIValuationModel.valuations != null)
            ? mergeModelLists(valuations, aIValuationModel.valuations)
            : valuations,
        org: aIValuationModel.$assignedFields.contains('org')
            ? aIValuationModel.org
            : org,
        $valuationsCount:
            aIValuationModel.$valuationsCount ?? $valuationsCount);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIValuationModel updateWithInstanceValues(AIValuationModel aIValuationModel) {
    if (aIValuationModel.$assignedFields.contains('id')) {
      id = aIValuationModel.id;
    }
    if (aIValuationModel.$assignedFields.contains('orgId')) {
      orgId = aIValuationModel.orgId;
    }
    if (aIValuationModel.$assignedFields.contains('modelName')) {
      modelName = aIValuationModel.modelName;
    }
    if (aIValuationModel.$assignedFields.contains('modelVersion')) {
      modelVersion = aIValuationModel.modelVersion;
    }
    if (aIValuationModel.$assignedFields.contains('accuracy')) {
      accuracy = aIValuationModel.accuracy;
    }
    if (aIValuationModel.$assignedFields.contains('lastTrainedAt')) {
      lastTrainedAt = aIValuationModel.lastTrainedAt;
    }
    if (aIValuationModel.$assignedFields.contains('features')) {
      features = aIValuationModel.features;
    }
    if (aIValuationModel.$assignedFields.contains('hyperparameters')) {
      hyperparameters = aIValuationModel.hyperparameters;
    }
    if (aIValuationModel.$assignedFields.contains('trainingMetrics')) {
      trainingMetrics = aIValuationModel.trainingMetrics;
    }
    if (aIValuationModel.$assignedFields.contains('isActive')) {
      isActive = aIValuationModel.isActive;
    }
    if (aIValuationModel.$assignedFields.contains('createdAt')) {
      createdAt = aIValuationModel.createdAt;
    }
    if (aIValuationModel.$assignedFields.contains('updatedAt')) {
      updatedAt = aIValuationModel.updatedAt;
    }
    if (aIValuationModel.$assignedFields.contains('valuations') &&
        aIValuationModel.valuations != null) {
      valuations = mergeModelLists(valuations, aIValuationModel.valuations);
    }
    if (aIValuationModel.$assignedFields.contains('org')) {
      org = aIValuationModel.org;
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
        ? {...?serializedTypes, 'AIValuationModel'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (modelName != null) 'modelName': modelName,
      if (modelVersion != null) 'modelVersion': modelVersion,
      if (accuracy != null) 'accuracy': accuracy,
      if (lastTrainedAt != null)
        'lastTrainedAt': lastTrainedAt?.toIso8601String(),
      if (features != null) 'features': features,
      if (hyperparameters != null) 'hyperparameters': hyperparameters,
      if (trainingMetrics != null) 'trainingMetrics': trainingMetrics,
      if (isActive != null) 'isActive': isActive,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (valuations != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AIPropertyValuation')))
        'valuations': valuations
            ?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (org != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'org': org?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if ($valuationsCount != null)
        '_count': {
          if ($valuationsCount != null) 'valuations': $valuationsCount,
        },
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIValuationModel &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
