//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'lead.dart';
import 'ai_lead_scoring.dart';
import 'organization.dart';

class AILeadScore implements PrismaModel<String, AILeadScore>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? modelId;
  String? leadId;
  double? score;
  dynamic scoreBreakdown;
  double? confidence;
  DateTime? scoredAt;
  dynamic featuresUsed;
  String? status;
  DateTime? createdAt;
  Lead? lead;
  AILeadScoring? model;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AILeadScore({
    this.id,
    this.orgId,
    this.modelId,
    this.leadId,
    this.score,
    required this.scoreBreakdown,
    this.confidence,
    this.scoredAt,
    required this.featuresUsed,
    this.status = "ACTIVE",
    this.createdAt,
    this.lead,
    this.model,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AILeadScore, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "modelId": (m) => m.modelId,
    "leadId": (m) => m.leadId,
    "score": (m) => m.score,
    "scoreBreakdown": (m) => m.scoreBreakdown,
    "confidence": (m) => m.confidence,
    "scoredAt": (m) => m.scoredAt,
    "featuresUsed": (m) => m.featuresUsed,
    "status": (m) => m.status,
    "createdAt": (m) => m.createdAt,
    "lead": (m) => m.lead,
    "model": (m) => m.model,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AILeadScore) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AILeadScore');
    }
    return propFunction as V? Function(AILeadScore);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AILeadScore.fromJson(JsonMap json) => AILeadScore(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        modelId: json['modelId'] as String?,
        leadId: json['leadId'] as String?,
        score: json['score']?.toDouble(),
        scoreBreakdown: json['scoreBreakdown'] as dynamic,
        confidence: json['confidence']?.toDouble(),
        scoredAt:
            json['scoredAt'] != null ? DateTime.parse(json['scoredAt']) : null,
        featuresUsed: json['featuresUsed'] as dynamic,
        status: json['status'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        lead: json['lead'] != null
            ? Lead.fromJson(json['lead'] as JsonMap)
            : null,
        model: json['model'] != null
            ? AILeadScoring.fromJson(json['model'] as JsonMap)
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AILeadScore copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? modelId,
    Value<String?>? leadId,
    Value<double?>? score,
    Value<dynamic>? scoreBreakdown,
    Value<double?>? confidence,
    Value<DateTime?>? scoredAt,
    Value<dynamic>? featuresUsed,
    Value<String?>? status,
    Value<DateTime?>? createdAt,
    Value<Lead?>? lead,
    Value<AILeadScoring?>? model,
    Value<Organization?>? org,
  }) {
    return AILeadScore(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        modelId: modelId != null ? modelId.value : this.modelId,
        leadId: leadId != null ? leadId.value : this.leadId,
        score: score != null ? score.value : this.score,
        scoreBreakdown:
            scoreBreakdown != null ? scoreBreakdown.value : this.scoreBreakdown,
        confidence: confidence != null ? confidence.value : this.confidence,
        scoredAt: scoredAt != null ? scoredAt.value : this.scoredAt,
        featuresUsed:
            featuresUsed != null ? featuresUsed.value : this.featuresUsed,
        status: status != null ? status.value : this.status,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        lead: lead != null ? lead.value : this.lead,
        model: model != null ? model.value : this.model,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AILeadScore copyWithInstanceValues(AILeadScore aILeadScore) {
    return AILeadScore(
        id: aILeadScore.id ?? id,
        orgId: aILeadScore.orgId ?? orgId,
        modelId: aILeadScore.modelId ?? modelId,
        leadId: aILeadScore.leadId ?? leadId,
        score: aILeadScore.score ?? score,
        scoreBreakdown: aILeadScore.scoreBreakdown ?? scoreBreakdown,
        confidence: aILeadScore.confidence ?? confidence,
        scoredAt: aILeadScore.scoredAt ?? scoredAt,
        featuresUsed: aILeadScore.featuresUsed ?? featuresUsed,
        status: aILeadScore.status ?? status,
        createdAt: aILeadScore.createdAt ?? createdAt,
        lead: aILeadScore.lead ?? lead,
        model: aILeadScore.model ?? model,
        org: aILeadScore.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AILeadScore mergeWithInstanceValues(AILeadScore aILeadScore) {
    return AILeadScore(
        id: aILeadScore.$assignedFields.contains('id') ? aILeadScore.id : id,
        orgId: aILeadScore.$assignedFields.contains('orgId')
            ? aILeadScore.orgId
            : orgId,
        modelId: aILeadScore.$assignedFields.contains('modelId')
            ? aILeadScore.modelId
            : modelId,
        leadId: aILeadScore.$assignedFields.contains('leadId')
            ? aILeadScore.leadId
            : leadId,
        score: aILeadScore.$assignedFields.contains('score')
            ? aILeadScore.score
            : score,
        scoreBreakdown: aILeadScore.$assignedFields.contains('scoreBreakdown')
            ? aILeadScore.scoreBreakdown
            : scoreBreakdown,
        confidence: aILeadScore.$assignedFields.contains('confidence')
            ? aILeadScore.confidence
            : confidence,
        scoredAt: aILeadScore.$assignedFields.contains('scoredAt')
            ? aILeadScore.scoredAt
            : scoredAt,
        featuresUsed: aILeadScore.$assignedFields.contains('featuresUsed')
            ? aILeadScore.featuresUsed
            : featuresUsed,
        status: aILeadScore.$assignedFields.contains('status')
            ? aILeadScore.status
            : status,
        createdAt: aILeadScore.$assignedFields.contains('createdAt')
            ? aILeadScore.createdAt
            : createdAt,
        lead: aILeadScore.$assignedFields.contains('lead')
            ? aILeadScore.lead
            : lead,
        model: aILeadScore.$assignedFields.contains('model')
            ? aILeadScore.model
            : model,
        org: aILeadScore.$assignedFields.contains('org')
            ? aILeadScore.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AILeadScore updateWithInstanceValues(AILeadScore aILeadScore) {
    if (aILeadScore.$assignedFields.contains('id')) {
      id = aILeadScore.id;
    }
    if (aILeadScore.$assignedFields.contains('orgId')) {
      orgId = aILeadScore.orgId;
    }
    if (aILeadScore.$assignedFields.contains('modelId')) {
      modelId = aILeadScore.modelId;
    }
    if (aILeadScore.$assignedFields.contains('leadId')) {
      leadId = aILeadScore.leadId;
    }
    if (aILeadScore.$assignedFields.contains('score')) {
      score = aILeadScore.score;
    }
    if (aILeadScore.$assignedFields.contains('scoreBreakdown')) {
      scoreBreakdown = aILeadScore.scoreBreakdown;
    }
    if (aILeadScore.$assignedFields.contains('confidence')) {
      confidence = aILeadScore.confidence;
    }
    if (aILeadScore.$assignedFields.contains('scoredAt')) {
      scoredAt = aILeadScore.scoredAt;
    }
    if (aILeadScore.$assignedFields.contains('featuresUsed')) {
      featuresUsed = aILeadScore.featuresUsed;
    }
    if (aILeadScore.$assignedFields.contains('status')) {
      status = aILeadScore.status;
    }
    if (aILeadScore.$assignedFields.contains('createdAt')) {
      createdAt = aILeadScore.createdAt;
    }
    if (aILeadScore.$assignedFields.contains('lead')) {
      lead = aILeadScore.lead;
    }
    if (aILeadScore.$assignedFields.contains('model')) {
      model = aILeadScore.model;
    }
    if (aILeadScore.$assignedFields.contains('org')) {
      org = aILeadScore.org;
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
        ? {...?serializedTypes, 'AILeadScore'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (modelId != null) 'modelId': modelId,
      if (leadId != null) 'leadId': leadId,
      if (score != null) 'score': score,
      if (scoreBreakdown != null) 'scoreBreakdown': scoreBreakdown,
      if (confidence != null) 'confidence': confidence,
      if (scoredAt != null) 'scoredAt': scoredAt?.toIso8601String(),
      if (featuresUsed != null) 'featuresUsed': featuresUsed,
      if (status != null) 'status': status,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (lead != null &&
          (!preventCircularSerialization || !serializedModels.contains('Lead')))
        'lead': lead?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (model != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AILeadScoring')))
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
      other is AILeadScore &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
