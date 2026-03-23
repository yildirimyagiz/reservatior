//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'ai_lead_score.dart';
import 'organization.dart';

class AILeadScoring implements PrismaModel<String, AILeadScoring>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? modelName;
  String? modelVersion;
  double? accuracy;
  DateTime? lastTrainedAt;
  dynamic features;
  dynamic scoringLogic;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<AILeadScore>? scores;
  Organization? org;
  int? $scoresCount;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AILeadScoring({
    this.id,
    this.orgId,
    this.modelName,
    this.modelVersion,
    this.accuracy,
    this.lastTrainedAt,
    required this.features,
    required this.scoringLogic,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    this.scores,
    this.org,
    this.$scoresCount,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AILeadScoring, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "modelName": (m) => m.modelName,
    "modelVersion": (m) => m.modelVersion,
    "accuracy": (m) => m.accuracy,
    "lastTrainedAt": (m) => m.lastTrainedAt,
    "features": (m) => m.features,
    "scoringLogic": (m) => m.scoringLogic,
    "isActive": (m) => m.isActive,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "scores": (m) => m.scores,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AILeadScoring) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AILeadScoring');
    }
    return propFunction as V? Function(AILeadScoring);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AILeadScoring.fromJson(JsonMap json) => AILeadScoring(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        modelName: json['modelName'] as String?,
        modelVersion: json['modelVersion'] as String?,
        accuracy: json['accuracy']?.toDouble(),
        lastTrainedAt: json['lastTrainedAt'] != null
            ? DateTime.parse(json['lastTrainedAt'])
            : null,
        features: json['features'] as dynamic,
        scoringLogic: json['scoringLogic'] as dynamic,
        isActive: json['isActive'] as bool?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        scores: json['scores'] != null
            ? createModels<AILeadScore>(
                (json['scores'] as List).cast<JsonMap>(), AILeadScore.fromJson)
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $scoresCount: json['_count']?['scores'] as int?,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AILeadScoring copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? modelName,
    Value<String?>? modelVersion,
    Value<double?>? accuracy,
    Value<DateTime?>? lastTrainedAt,
    Value<dynamic>? features,
    Value<dynamic>? scoringLogic,
    Value<bool?>? isActive,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<List<AILeadScore>?>? scores,
    Value<Organization?>? org,
    int? $scoresCount,
  }) {
    return AILeadScoring(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        modelName: modelName != null ? modelName.value : this.modelName,
        modelVersion:
            modelVersion != null ? modelVersion.value : this.modelVersion,
        accuracy: accuracy != null ? accuracy.value : this.accuracy,
        lastTrainedAt:
            lastTrainedAt != null ? lastTrainedAt.value : this.lastTrainedAt,
        features: features != null ? features.value : this.features,
        scoringLogic:
            scoringLogic != null ? scoringLogic.value : this.scoringLogic,
        isActive: isActive != null ? isActive.value : this.isActive,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        scores: scores != null ? scores.value : this.scores,
        org: org != null ? org.value : this.org,
        $scoresCount: $scoresCount ?? this.$scoresCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AILeadScoring copyWithInstanceValues(AILeadScoring aILeadScoring) {
    return AILeadScoring(
        id: aILeadScoring.id ?? id,
        orgId: aILeadScoring.orgId ?? orgId,
        modelName: aILeadScoring.modelName ?? modelName,
        modelVersion: aILeadScoring.modelVersion ?? modelVersion,
        accuracy: aILeadScoring.accuracy ?? accuracy,
        lastTrainedAt: aILeadScoring.lastTrainedAt ?? lastTrainedAt,
        features: aILeadScoring.features ?? features,
        scoringLogic: aILeadScoring.scoringLogic ?? scoringLogic,
        isActive: aILeadScoring.isActive ?? isActive,
        createdAt: aILeadScoring.createdAt ?? createdAt,
        updatedAt: aILeadScoring.updatedAt ?? updatedAt,
        scores: aILeadScoring.scores ?? scores,
        org: aILeadScoring.org ?? org,
        $scoresCount: aILeadScoring.$scoresCount ?? $scoresCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AILeadScoring mergeWithInstanceValues(AILeadScoring aILeadScoring) {
    return AILeadScoring(
        id: aILeadScoring.$assignedFields.contains('id')
            ? aILeadScoring.id
            : id,
        orgId: aILeadScoring.$assignedFields.contains('orgId')
            ? aILeadScoring.orgId
            : orgId,
        modelName: aILeadScoring.$assignedFields.contains('modelName')
            ? aILeadScoring.modelName
            : modelName,
        modelVersion: aILeadScoring.$assignedFields.contains('modelVersion')
            ? aILeadScoring.modelVersion
            : modelVersion,
        accuracy: aILeadScoring.$assignedFields.contains('accuracy')
            ? aILeadScoring.accuracy
            : accuracy,
        lastTrainedAt: aILeadScoring.$assignedFields.contains('lastTrainedAt')
            ? aILeadScoring.lastTrainedAt
            : lastTrainedAt,
        features: aILeadScoring.$assignedFields.contains('features')
            ? aILeadScoring.features
            : features,
        scoringLogic: aILeadScoring.$assignedFields.contains('scoringLogic')
            ? aILeadScoring.scoringLogic
            : scoringLogic,
        isActive: aILeadScoring.$assignedFields.contains('isActive')
            ? aILeadScoring.isActive
            : isActive,
        createdAt: aILeadScoring.$assignedFields.contains('createdAt')
            ? aILeadScoring.createdAt
            : createdAt,
        updatedAt: aILeadScoring.$assignedFields.contains('updatedAt')
            ? aILeadScoring.updatedAt
            : updatedAt,
        scores: (aILeadScoring.$assignedFields.contains('scores') &&
                aILeadScoring.scores != null)
            ? mergeModelLists(scores, aILeadScoring.scores)
            : scores,
        org: aILeadScoring.$assignedFields.contains('org')
            ? aILeadScoring.org
            : org,
        $scoresCount: aILeadScoring.$scoresCount ?? $scoresCount);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AILeadScoring updateWithInstanceValues(AILeadScoring aILeadScoring) {
    if (aILeadScoring.$assignedFields.contains('id')) {
      id = aILeadScoring.id;
    }
    if (aILeadScoring.$assignedFields.contains('orgId')) {
      orgId = aILeadScoring.orgId;
    }
    if (aILeadScoring.$assignedFields.contains('modelName')) {
      modelName = aILeadScoring.modelName;
    }
    if (aILeadScoring.$assignedFields.contains('modelVersion')) {
      modelVersion = aILeadScoring.modelVersion;
    }
    if (aILeadScoring.$assignedFields.contains('accuracy')) {
      accuracy = aILeadScoring.accuracy;
    }
    if (aILeadScoring.$assignedFields.contains('lastTrainedAt')) {
      lastTrainedAt = aILeadScoring.lastTrainedAt;
    }
    if (aILeadScoring.$assignedFields.contains('features')) {
      features = aILeadScoring.features;
    }
    if (aILeadScoring.$assignedFields.contains('scoringLogic')) {
      scoringLogic = aILeadScoring.scoringLogic;
    }
    if (aILeadScoring.$assignedFields.contains('isActive')) {
      isActive = aILeadScoring.isActive;
    }
    if (aILeadScoring.$assignedFields.contains('createdAt')) {
      createdAt = aILeadScoring.createdAt;
    }
    if (aILeadScoring.$assignedFields.contains('updatedAt')) {
      updatedAt = aILeadScoring.updatedAt;
    }
    if (aILeadScoring.$assignedFields.contains('scores') &&
        aILeadScoring.scores != null) {
      scores = mergeModelLists(scores, aILeadScoring.scores);
    }
    if (aILeadScoring.$assignedFields.contains('org')) {
      org = aILeadScoring.org;
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
        ? {...?serializedTypes, 'AILeadScoring'}
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
      if (scoringLogic != null) 'scoringLogic': scoringLogic,
      if (isActive != null) 'isActive': isActive,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (scores != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AILeadScore')))
        'scores': scores
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
      if ($scoresCount != null)
        '_count': {
          if ($scoresCount != null) 'scores': $scoresCount,
        },
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AILeadScoring &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
