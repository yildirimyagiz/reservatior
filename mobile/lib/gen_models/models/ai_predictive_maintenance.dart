//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';

class AIPredictiveMaintenance
    implements PrismaModel<String, AIPredictiveMaintenance>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? propertyId;
  String? componentType;
  double? failureProbability;
  DateTime? predictedFailureDate;
  String? riskLevel;
  double? estimatedCost;
  dynamic contributingFactors;
  DateTime? lastInspectionDate;
  String? recommendedAction;
  DateTime? generatedAt;
  DateTime? createdAt;
  Organization? org;
  Property? property;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIPredictiveMaintenance({
    this.id,
    this.orgId,
    this.propertyId,
    this.componentType,
    this.failureProbability,
    this.predictedFailureDate,
    this.riskLevel,
    this.estimatedCost,
    required this.contributingFactors,
    this.lastInspectionDate,
    this.recommendedAction,
    this.generatedAt,
    this.createdAt,
    this.org,
    this.property,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIPredictiveMaintenance, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "propertyId": (m) => m.propertyId,
    "componentType": (m) => m.componentType,
    "failureProbability": (m) => m.failureProbability,
    "predictedFailureDate": (m) => m.predictedFailureDate,
    "riskLevel": (m) => m.riskLevel,
    "estimatedCost": (m) => m.estimatedCost,
    "contributingFactors": (m) => m.contributingFactors,
    "lastInspectionDate": (m) => m.lastInspectionDate,
    "recommendedAction": (m) => m.recommendedAction,
    "generatedAt": (m) => m.generatedAt,
    "createdAt": (m) => m.createdAt,
    "org": (m) => m.org,
    "property": (m) => m.property,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIPredictiveMaintenance) getPropToValueFunction<V>(
      String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception(
          'Property "$propertyName" not found in AIPredictiveMaintenance');
    }
    return propFunction as V? Function(AIPredictiveMaintenance);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIPredictiveMaintenance.fromJson(JsonMap json) =>
      AIPredictiveMaintenance(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        propertyId: json['propertyId'] as String?,
        componentType: json['componentType'] as String?,
        failureProbability: json['failureProbability']?.toDouble(),
        predictedFailureDate: json['predictedFailureDate'] != null
            ? DateTime.parse(json['predictedFailureDate'])
            : null,
        riskLevel: json['riskLevel'] as String?,
        estimatedCost: json['estimatedCost'] as double?,
        contributingFactors: json['contributingFactors'] as dynamic,
        lastInspectionDate: json['lastInspectionDate'] != null
            ? DateTime.parse(json['lastInspectionDate'])
            : null,
        recommendedAction: json['recommendedAction'] as String?,
        generatedAt: json['generatedAt'] != null
            ? DateTime.parse(json['generatedAt'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        property: json['property'] != null
            ? Property.fromJson(json['property'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIPredictiveMaintenance copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? propertyId,
    Value<String?>? componentType,
    Value<double?>? failureProbability,
    Value<DateTime?>? predictedFailureDate,
    Value<String?>? riskLevel,
    Value<double?>? estimatedCost,
    Value<dynamic>? contributingFactors,
    Value<DateTime?>? lastInspectionDate,
    Value<String?>? recommendedAction,
    Value<DateTime?>? generatedAt,
    Value<DateTime?>? createdAt,
    Value<Organization?>? org,
    Value<Property?>? property,
  }) {
    return AIPredictiveMaintenance(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        propertyId: propertyId != null ? propertyId.value : this.propertyId,
        componentType:
            componentType != null ? componentType.value : this.componentType,
        failureProbability: failureProbability != null
            ? failureProbability.value
            : this.failureProbability,
        predictedFailureDate: predictedFailureDate != null
            ? predictedFailureDate.value
            : this.predictedFailureDate,
        riskLevel: riskLevel != null ? riskLevel.value : this.riskLevel,
        estimatedCost:
            estimatedCost != null ? estimatedCost.value : this.estimatedCost,
        contributingFactors: contributingFactors != null
            ? contributingFactors.value
            : this.contributingFactors,
        lastInspectionDate: lastInspectionDate != null
            ? lastInspectionDate.value
            : this.lastInspectionDate,
        recommendedAction: recommendedAction != null
            ? recommendedAction.value
            : this.recommendedAction,
        generatedAt: generatedAt != null ? generatedAt.value : this.generatedAt,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        org: org != null ? org.value : this.org,
        property: property != null ? property.value : this.property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIPredictiveMaintenance copyWithInstanceValues(
      AIPredictiveMaintenance aIPredictiveMaintenance) {
    return AIPredictiveMaintenance(
        id: aIPredictiveMaintenance.id ?? id,
        orgId: aIPredictiveMaintenance.orgId ?? orgId,
        propertyId: aIPredictiveMaintenance.propertyId ?? propertyId,
        componentType: aIPredictiveMaintenance.componentType ?? componentType,
        failureProbability:
            aIPredictiveMaintenance.failureProbability ?? failureProbability,
        predictedFailureDate: aIPredictiveMaintenance.predictedFailureDate ??
            predictedFailureDate,
        riskLevel: aIPredictiveMaintenance.riskLevel ?? riskLevel,
        estimatedCost: aIPredictiveMaintenance.estimatedCost ?? estimatedCost,
        contributingFactors:
            aIPredictiveMaintenance.contributingFactors ?? contributingFactors,
        lastInspectionDate:
            aIPredictiveMaintenance.lastInspectionDate ?? lastInspectionDate,
        recommendedAction:
            aIPredictiveMaintenance.recommendedAction ?? recommendedAction,
        generatedAt: aIPredictiveMaintenance.generatedAt ?? generatedAt,
        createdAt: aIPredictiveMaintenance.createdAt ?? createdAt,
        org: aIPredictiveMaintenance.org ?? org,
        property: aIPredictiveMaintenance.property ?? property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIPredictiveMaintenance mergeWithInstanceValues(
      AIPredictiveMaintenance aIPredictiveMaintenance) {
    return AIPredictiveMaintenance(
        id: aIPredictiveMaintenance.$assignedFields.contains('id')
            ? aIPredictiveMaintenance.id
            : id,
        orgId: aIPredictiveMaintenance.$assignedFields.contains('orgId')
            ? aIPredictiveMaintenance.orgId
            : orgId,
        propertyId: aIPredictiveMaintenance.$assignedFields.contains('propertyId')
            ? aIPredictiveMaintenance.propertyId
            : propertyId,
        componentType: aIPredictiveMaintenance.$assignedFields.contains('componentType')
            ? aIPredictiveMaintenance.componentType
            : componentType,
        failureProbability: aIPredictiveMaintenance.$assignedFields.contains('failureProbability')
            ? aIPredictiveMaintenance.failureProbability
            : failureProbability,
        predictedFailureDate:
            aIPredictiveMaintenance.$assignedFields.contains('predictedFailureDate')
                ? aIPredictiveMaintenance.predictedFailureDate
                : predictedFailureDate,
        riskLevel: aIPredictiveMaintenance.$assignedFields.contains('riskLevel')
            ? aIPredictiveMaintenance.riskLevel
            : riskLevel,
        estimatedCost: aIPredictiveMaintenance.$assignedFields.contains('estimatedCost')
            ? aIPredictiveMaintenance.estimatedCost
            : estimatedCost,
        contributingFactors:
            aIPredictiveMaintenance.$assignedFields.contains('contributingFactors')
                ? aIPredictiveMaintenance.contributingFactors
                : contributingFactors,
        lastInspectionDate: aIPredictiveMaintenance.$assignedFields.contains('lastInspectionDate')
            ? aIPredictiveMaintenance.lastInspectionDate
            : lastInspectionDate,
        recommendedAction: aIPredictiveMaintenance.$assignedFields.contains('recommendedAction')
            ? aIPredictiveMaintenance.recommendedAction
            : recommendedAction,
        generatedAt: aIPredictiveMaintenance.$assignedFields.contains('generatedAt')
            ? aIPredictiveMaintenance.generatedAt
            : generatedAt,
        createdAt: aIPredictiveMaintenance.$assignedFields.contains('createdAt') ? aIPredictiveMaintenance.createdAt : createdAt,
        org: aIPredictiveMaintenance.$assignedFields.contains('org') ? aIPredictiveMaintenance.org : org,
        property: aIPredictiveMaintenance.$assignedFields.contains('property') ? aIPredictiveMaintenance.property : property);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIPredictiveMaintenance updateWithInstanceValues(
      AIPredictiveMaintenance aIPredictiveMaintenance) {
    if (aIPredictiveMaintenance.$assignedFields.contains('id')) {
      id = aIPredictiveMaintenance.id;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('orgId')) {
      orgId = aIPredictiveMaintenance.orgId;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('propertyId')) {
      propertyId = aIPredictiveMaintenance.propertyId;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('componentType')) {
      componentType = aIPredictiveMaintenance.componentType;
    }
    if (aIPredictiveMaintenance.$assignedFields
        .contains('failureProbability')) {
      failureProbability = aIPredictiveMaintenance.failureProbability;
    }
    if (aIPredictiveMaintenance.$assignedFields
        .contains('predictedFailureDate')) {
      predictedFailureDate = aIPredictiveMaintenance.predictedFailureDate;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('riskLevel')) {
      riskLevel = aIPredictiveMaintenance.riskLevel;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('estimatedCost')) {
      estimatedCost = aIPredictiveMaintenance.estimatedCost;
    }
    if (aIPredictiveMaintenance.$assignedFields
        .contains('contributingFactors')) {
      contributingFactors = aIPredictiveMaintenance.contributingFactors;
    }
    if (aIPredictiveMaintenance.$assignedFields
        .contains('lastInspectionDate')) {
      lastInspectionDate = aIPredictiveMaintenance.lastInspectionDate;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('recommendedAction')) {
      recommendedAction = aIPredictiveMaintenance.recommendedAction;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('generatedAt')) {
      generatedAt = aIPredictiveMaintenance.generatedAt;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('createdAt')) {
      createdAt = aIPredictiveMaintenance.createdAt;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('org')) {
      org = aIPredictiveMaintenance.org;
    }
    if (aIPredictiveMaintenance.$assignedFields.contains('property')) {
      property = aIPredictiveMaintenance.property;
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
        ? {...?serializedTypes, 'AIPredictiveMaintenance'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (componentType != null) 'componentType': componentType,
      if (failureProbability != null) 'failureProbability': failureProbability,
      if (predictedFailureDate != null)
        'predictedFailureDate': predictedFailureDate?.toIso8601String(),
      if (riskLevel != null) 'riskLevel': riskLevel,
      if (estimatedCost != null) 'estimatedCost': estimatedCost,
      if (contributingFactors != null)
        'contributingFactors': contributingFactors,
      if (lastInspectionDate != null)
        'lastInspectionDate': lastInspectionDate?.toIso8601String(),
      if (recommendedAction != null) 'recommendedAction': recommendedAction,
      if (generatedAt != null) 'generatedAt': generatedAt?.toIso8601String(),
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (org != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'org': org?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (property != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Property')))
        'property': property?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization)
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIPredictiveMaintenance &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
