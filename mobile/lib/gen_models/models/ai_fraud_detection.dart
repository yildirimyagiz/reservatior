//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';

class AIFraudDetection
    implements PrismaModel<String, AIFraudDetection>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? entityType;
  String? entityId;
  double? riskScore;
  dynamic riskFactors;
  String? riskCategory;
  dynamic recommendedActions;
  DateTime? detectedAt;
  DateTime? reviewedAt;
  String? reviewedBy;
  String? resolution;
  DateTime? createdAt;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIFraudDetection({
    this.id,
    this.orgId,
    this.entityType,
    this.entityId,
    this.riskScore,
    required this.riskFactors,
    this.riskCategory,
    required this.recommendedActions,
    this.detectedAt,
    this.reviewedAt,
    this.reviewedBy,
    this.resolution,
    this.createdAt,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIFraudDetection, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "entityType": (m) => m.entityType,
    "entityId": (m) => m.entityId,
    "riskScore": (m) => m.riskScore,
    "riskFactors": (m) => m.riskFactors,
    "riskCategory": (m) => m.riskCategory,
    "recommendedActions": (m) => m.recommendedActions,
    "detectedAt": (m) => m.detectedAt,
    "reviewedAt": (m) => m.reviewedAt,
    "reviewedBy": (m) => m.reviewedBy,
    "resolution": (m) => m.resolution,
    "createdAt": (m) => m.createdAt,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIFraudDetection) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIFraudDetection');
    }
    return propFunction as V? Function(AIFraudDetection);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIFraudDetection.fromJson(JsonMap json) => AIFraudDetection(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        entityType: json['entityType'] as String?,
        entityId: json['entityId'] as String?,
        riskScore: json['riskScore']?.toDouble(),
        riskFactors: json['riskFactors'] as dynamic,
        riskCategory: json['riskCategory'] as String?,
        recommendedActions: json['recommendedActions'] as dynamic,
        detectedAt: json['detectedAt'] != null
            ? DateTime.parse(json['detectedAt'])
            : null,
        reviewedAt: json['reviewedAt'] != null
            ? DateTime.parse(json['reviewedAt'])
            : null,
        reviewedBy: json['reviewedBy'] as String?,
        resolution: json['resolution'] as String?,
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
  AIFraudDetection copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? entityType,
    Value<String?>? entityId,
    Value<double?>? riskScore,
    Value<dynamic>? riskFactors,
    Value<String?>? riskCategory,
    Value<dynamic>? recommendedActions,
    Value<DateTime?>? detectedAt,
    Value<DateTime?>? reviewedAt,
    Value<String?>? reviewedBy,
    Value<String?>? resolution,
    Value<DateTime?>? createdAt,
    Value<Organization?>? org,
  }) {
    return AIFraudDetection(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        entityType: entityType != null ? entityType.value : this.entityType,
        entityId: entityId != null ? entityId.value : this.entityId,
        riskScore: riskScore != null ? riskScore.value : this.riskScore,
        riskFactors: riskFactors != null ? riskFactors.value : this.riskFactors,
        riskCategory:
            riskCategory != null ? riskCategory.value : this.riskCategory,
        recommendedActions: recommendedActions != null
            ? recommendedActions.value
            : this.recommendedActions,
        detectedAt: detectedAt != null ? detectedAt.value : this.detectedAt,
        reviewedAt: reviewedAt != null ? reviewedAt.value : this.reviewedAt,
        reviewedBy: reviewedBy != null ? reviewedBy.value : this.reviewedBy,
        resolution: resolution != null ? resolution.value : this.resolution,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIFraudDetection copyWithInstanceValues(AIFraudDetection aIFraudDetection) {
    return AIFraudDetection(
        id: aIFraudDetection.id ?? id,
        orgId: aIFraudDetection.orgId ?? orgId,
        entityType: aIFraudDetection.entityType ?? entityType,
        entityId: aIFraudDetection.entityId ?? entityId,
        riskScore: aIFraudDetection.riskScore ?? riskScore,
        riskFactors: aIFraudDetection.riskFactors ?? riskFactors,
        riskCategory: aIFraudDetection.riskCategory ?? riskCategory,
        recommendedActions:
            aIFraudDetection.recommendedActions ?? recommendedActions,
        detectedAt: aIFraudDetection.detectedAt ?? detectedAt,
        reviewedAt: aIFraudDetection.reviewedAt ?? reviewedAt,
        reviewedBy: aIFraudDetection.reviewedBy ?? reviewedBy,
        resolution: aIFraudDetection.resolution ?? resolution,
        createdAt: aIFraudDetection.createdAt ?? createdAt,
        org: aIFraudDetection.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIFraudDetection mergeWithInstanceValues(AIFraudDetection aIFraudDetection) {
    return AIFraudDetection(
        id: aIFraudDetection.$assignedFields.contains('id')
            ? aIFraudDetection.id
            : id,
        orgId: aIFraudDetection.$assignedFields.contains('orgId')
            ? aIFraudDetection.orgId
            : orgId,
        entityType: aIFraudDetection.$assignedFields.contains('entityType')
            ? aIFraudDetection.entityType
            : entityType,
        entityId: aIFraudDetection.$assignedFields.contains('entityId')
            ? aIFraudDetection.entityId
            : entityId,
        riskScore: aIFraudDetection.$assignedFields.contains('riskScore')
            ? aIFraudDetection.riskScore
            : riskScore,
        riskFactors: aIFraudDetection.$assignedFields.contains('riskFactors')
            ? aIFraudDetection.riskFactors
            : riskFactors,
        riskCategory: aIFraudDetection.$assignedFields.contains('riskCategory')
            ? aIFraudDetection.riskCategory
            : riskCategory,
        recommendedActions:
            aIFraudDetection.$assignedFields.contains('recommendedActions')
                ? aIFraudDetection.recommendedActions
                : recommendedActions,
        detectedAt: aIFraudDetection.$assignedFields.contains('detectedAt')
            ? aIFraudDetection.detectedAt
            : detectedAt,
        reviewedAt: aIFraudDetection.$assignedFields.contains('reviewedAt')
            ? aIFraudDetection.reviewedAt
            : reviewedAt,
        reviewedBy: aIFraudDetection.$assignedFields.contains('reviewedBy')
            ? aIFraudDetection.reviewedBy
            : reviewedBy,
        resolution: aIFraudDetection.$assignedFields.contains('resolution')
            ? aIFraudDetection.resolution
            : resolution,
        createdAt: aIFraudDetection.$assignedFields.contains('createdAt')
            ? aIFraudDetection.createdAt
            : createdAt,
        org: aIFraudDetection.$assignedFields.contains('org')
            ? aIFraudDetection.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIFraudDetection updateWithInstanceValues(AIFraudDetection aIFraudDetection) {
    if (aIFraudDetection.$assignedFields.contains('id')) {
      id = aIFraudDetection.id;
    }
    if (aIFraudDetection.$assignedFields.contains('orgId')) {
      orgId = aIFraudDetection.orgId;
    }
    if (aIFraudDetection.$assignedFields.contains('entityType')) {
      entityType = aIFraudDetection.entityType;
    }
    if (aIFraudDetection.$assignedFields.contains('entityId')) {
      entityId = aIFraudDetection.entityId;
    }
    if (aIFraudDetection.$assignedFields.contains('riskScore')) {
      riskScore = aIFraudDetection.riskScore;
    }
    if (aIFraudDetection.$assignedFields.contains('riskFactors')) {
      riskFactors = aIFraudDetection.riskFactors;
    }
    if (aIFraudDetection.$assignedFields.contains('riskCategory')) {
      riskCategory = aIFraudDetection.riskCategory;
    }
    if (aIFraudDetection.$assignedFields.contains('recommendedActions')) {
      recommendedActions = aIFraudDetection.recommendedActions;
    }
    if (aIFraudDetection.$assignedFields.contains('detectedAt')) {
      detectedAt = aIFraudDetection.detectedAt;
    }
    if (aIFraudDetection.$assignedFields.contains('reviewedAt')) {
      reviewedAt = aIFraudDetection.reviewedAt;
    }
    if (aIFraudDetection.$assignedFields.contains('reviewedBy')) {
      reviewedBy = aIFraudDetection.reviewedBy;
    }
    if (aIFraudDetection.$assignedFields.contains('resolution')) {
      resolution = aIFraudDetection.resolution;
    }
    if (aIFraudDetection.$assignedFields.contains('createdAt')) {
      createdAt = aIFraudDetection.createdAt;
    }
    if (aIFraudDetection.$assignedFields.contains('org')) {
      org = aIFraudDetection.org;
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
        ? {...?serializedTypes, 'AIFraudDetection'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (entityType != null) 'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      if (riskScore != null) 'riskScore': riskScore,
      if (riskFactors != null) 'riskFactors': riskFactors,
      if (riskCategory != null) 'riskCategory': riskCategory,
      if (recommendedActions != null) 'recommendedActions': recommendedActions,
      if (detectedAt != null) 'detectedAt': detectedAt?.toIso8601String(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toIso8601String(),
      if (reviewedBy != null) 'reviewedBy': reviewedBy,
      if (resolution != null) 'resolution': resolution,
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
      other is AIFraudDetection &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
