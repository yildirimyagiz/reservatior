//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';

class AIRecommendation
    implements PrismaModel<String, AIRecommendation>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? userType;
  String? userId;
  String? sessionId;
  dynamic recommendedProperties;
  String? recommendationType;
  dynamic userPreferences;
  dynamic reasoning;
  DateTime? generatedAt;
  DateTime? expiresAt;
  DateTime? createdAt;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIRecommendation({
    this.id,
    this.orgId,
    this.userType,
    this.userId,
    this.sessionId,
    required this.recommendedProperties,
    this.recommendationType,
    required this.userPreferences,
    required this.reasoning,
    this.generatedAt,
    this.expiresAt,
    this.createdAt,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIRecommendation, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "userType": (m) => m.userType,
    "userId": (m) => m.userId,
    "sessionId": (m) => m.sessionId,
    "recommendedProperties": (m) => m.recommendedProperties,
    "recommendationType": (m) => m.recommendationType,
    "userPreferences": (m) => m.userPreferences,
    "reasoning": (m) => m.reasoning,
    "generatedAt": (m) => m.generatedAt,
    "expiresAt": (m) => m.expiresAt,
    "createdAt": (m) => m.createdAt,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIRecommendation) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIRecommendation');
    }
    return propFunction as V? Function(AIRecommendation);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIRecommendation.fromJson(JsonMap json) => AIRecommendation(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        userType: json['userType'] as String?,
        userId: json['userId'] as String?,
        sessionId: json['sessionId'] as String?,
        recommendedProperties: json['recommendedProperties'] as dynamic,
        recommendationType: json['recommendationType'] as String?,
        userPreferences: json['userPreferences'] as dynamic,
        reasoning: json['reasoning'] as dynamic,
        generatedAt: json['generatedAt'] != null
            ? DateTime.parse(json['generatedAt'])
            : null,
        expiresAt: json['expiresAt'] != null
            ? DateTime.parse(json['expiresAt'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIRecommendation copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? userType,
    Value<String?>? userId,
    Value<String?>? sessionId,
    Value<dynamic>? recommendedProperties,
    Value<String?>? recommendationType,
    Value<dynamic>? userPreferences,
    Value<dynamic>? reasoning,
    Value<DateTime?>? generatedAt,
    Value<DateTime?>? expiresAt,
    Value<DateTime?>? createdAt,
    Value<Organization?>? org,
  }) {
    return AIRecommendation(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        userType: userType != null ? userType.value : this.userType,
        userId: userId != null ? userId.value : this.userId,
        sessionId: sessionId != null ? sessionId.value : this.sessionId,
        recommendedProperties: recommendedProperties != null
            ? recommendedProperties.value
            : this.recommendedProperties,
        recommendationType: recommendationType != null
            ? recommendationType.value
            : this.recommendationType,
        userPreferences: userPreferences != null
            ? userPreferences.value
            : this.userPreferences,
        reasoning: reasoning != null ? reasoning.value : this.reasoning,
        generatedAt: generatedAt != null ? generatedAt.value : this.generatedAt,
        expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIRecommendation copyWithInstanceValues(AIRecommendation aIRecommendation) {
    return AIRecommendation(
        id: aIRecommendation.id ?? id,
        orgId: aIRecommendation.orgId ?? orgId,
        userType: aIRecommendation.userType ?? userType,
        userId: aIRecommendation.userId ?? userId,
        sessionId: aIRecommendation.sessionId ?? sessionId,
        recommendedProperties:
            aIRecommendation.recommendedProperties ?? recommendedProperties,
        recommendationType:
            aIRecommendation.recommendationType ?? recommendationType,
        userPreferences: aIRecommendation.userPreferences ?? userPreferences,
        reasoning: aIRecommendation.reasoning ?? reasoning,
        generatedAt: aIRecommendation.generatedAt ?? generatedAt,
        expiresAt: aIRecommendation.expiresAt ?? expiresAt,
        createdAt: aIRecommendation.createdAt ?? createdAt,
        org: aIRecommendation.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIRecommendation mergeWithInstanceValues(AIRecommendation aIRecommendation) {
    return AIRecommendation(
        id: aIRecommendation.$assignedFields.contains('id')
            ? aIRecommendation.id
            : id,
        orgId: aIRecommendation.$assignedFields.contains('orgId')
            ? aIRecommendation.orgId
            : orgId,
        userType: aIRecommendation.$assignedFields.contains('userType')
            ? aIRecommendation.userType
            : userType,
        userId: aIRecommendation.$assignedFields.contains('userId')
            ? aIRecommendation.userId
            : userId,
        sessionId: aIRecommendation.$assignedFields.contains('sessionId')
            ? aIRecommendation.sessionId
            : sessionId,
        recommendedProperties:
            aIRecommendation.$assignedFields.contains('recommendedProperties')
                ? aIRecommendation.recommendedProperties
                : recommendedProperties,
        recommendationType:
            aIRecommendation.$assignedFields.contains('recommendationType')
                ? aIRecommendation.recommendationType
                : recommendationType,
        userPreferences:
            aIRecommendation.$assignedFields.contains('userPreferences')
                ? aIRecommendation.userPreferences
                : userPreferences,
        reasoning: aIRecommendation.$assignedFields.contains('reasoning')
            ? aIRecommendation.reasoning
            : reasoning,
        generatedAt: aIRecommendation.$assignedFields.contains('generatedAt')
            ? aIRecommendation.generatedAt
            : generatedAt,
        expiresAt: aIRecommendation.$assignedFields.contains('expiresAt')
            ? aIRecommendation.expiresAt
            : expiresAt,
        createdAt: aIRecommendation.$assignedFields.contains('createdAt')
            ? aIRecommendation.createdAt
            : createdAt,
        org: aIRecommendation.$assignedFields.contains('org')
            ? aIRecommendation.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIRecommendation updateWithInstanceValues(AIRecommendation aIRecommendation) {
    if (aIRecommendation.$assignedFields.contains('id')) {
      id = aIRecommendation.id;
    }
    if (aIRecommendation.$assignedFields.contains('orgId')) {
      orgId = aIRecommendation.orgId;
    }
    if (aIRecommendation.$assignedFields.contains('userType')) {
      userType = aIRecommendation.userType;
    }
    if (aIRecommendation.$assignedFields.contains('userId')) {
      userId = aIRecommendation.userId;
    }
    if (aIRecommendation.$assignedFields.contains('sessionId')) {
      sessionId = aIRecommendation.sessionId;
    }
    if (aIRecommendation.$assignedFields.contains('recommendedProperties')) {
      recommendedProperties = aIRecommendation.recommendedProperties;
    }
    if (aIRecommendation.$assignedFields.contains('recommendationType')) {
      recommendationType = aIRecommendation.recommendationType;
    }
    if (aIRecommendation.$assignedFields.contains('userPreferences')) {
      userPreferences = aIRecommendation.userPreferences;
    }
    if (aIRecommendation.$assignedFields.contains('reasoning')) {
      reasoning = aIRecommendation.reasoning;
    }
    if (aIRecommendation.$assignedFields.contains('generatedAt')) {
      generatedAt = aIRecommendation.generatedAt;
    }
    if (aIRecommendation.$assignedFields.contains('expiresAt')) {
      expiresAt = aIRecommendation.expiresAt;
    }
    if (aIRecommendation.$assignedFields.contains('createdAt')) {
      createdAt = aIRecommendation.createdAt;
    }
    if (aIRecommendation.$assignedFields.contains('org')) {
      org = aIRecommendation.org;
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
        ? {...?serializedTypes, 'AIRecommendation'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (userType != null) 'userType': userType,
      if (userId != null) 'userId': userId,
      if (sessionId != null) 'sessionId': sessionId,
      if (recommendedProperties != null)
        'recommendedProperties': recommendedProperties,
      if (recommendationType != null) 'recommendationType': recommendationType,
      if (userPreferences != null) 'userPreferences': userPreferences,
      if (reasoning != null) 'reasoning': reasoning,
      if (generatedAt != null) 'generatedAt': generatedAt?.toIso8601String(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
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
      other is AIRecommendation &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
