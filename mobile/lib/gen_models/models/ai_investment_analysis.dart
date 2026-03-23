//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';

class AIInvestmentAnalysis
    implements PrismaModel<String, AIInvestmentAnalysis>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? propertyId;
  String? analysisType;
  String? timeHorizon;
  dynamic projectedReturns;
  dynamic cashFlowProjection;
  dynamic riskMetrics;
  dynamic keyAssumptions;
  dynamic sensitivityAnalysis;
  double? confidence;
  DateTime? generatedAt;
  DateTime? createdAt;
  Organization? org;
  Property? property;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIInvestmentAnalysis({
    this.id,
    this.orgId,
    this.propertyId,
    this.analysisType,
    this.timeHorizon,
    required this.projectedReturns,
    required this.cashFlowProjection,
    required this.riskMetrics,
    required this.keyAssumptions,
    required this.sensitivityAnalysis,
    this.confidence,
    this.generatedAt,
    this.createdAt,
    this.org,
    this.property,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIInvestmentAnalysis, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "propertyId": (m) => m.propertyId,
    "analysisType": (m) => m.analysisType,
    "timeHorizon": (m) => m.timeHorizon,
    "projectedReturns": (m) => m.projectedReturns,
    "cashFlowProjection": (m) => m.cashFlowProjection,
    "riskMetrics": (m) => m.riskMetrics,
    "keyAssumptions": (m) => m.keyAssumptions,
    "sensitivityAnalysis": (m) => m.sensitivityAnalysis,
    "confidence": (m) => m.confidence,
    "generatedAt": (m) => m.generatedAt,
    "createdAt": (m) => m.createdAt,
    "org": (m) => m.org,
    "property": (m) => m.property,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIInvestmentAnalysis) getPropToValueFunction<V>(
      String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception(
          'Property "$propertyName" not found in AIInvestmentAnalysis');
    }
    return propFunction as V? Function(AIInvestmentAnalysis);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIInvestmentAnalysis.fromJson(JsonMap json) => AIInvestmentAnalysis(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        propertyId: json['propertyId'] as String?,
        analysisType: json['analysisType'] as String?,
        timeHorizon: json['timeHorizon'] as String?,
        projectedReturns: json['projectedReturns'] as dynamic,
        cashFlowProjection: json['cashFlowProjection'] as dynamic,
        riskMetrics: json['riskMetrics'] as dynamic,
        keyAssumptions: json['keyAssumptions'] as dynamic,
        sensitivityAnalysis: json['sensitivityAnalysis'] as dynamic,
        confidence: json['confidence']?.toDouble(),
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
  AIInvestmentAnalysis copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? propertyId,
    Value<String?>? analysisType,
    Value<String?>? timeHorizon,
    Value<dynamic>? projectedReturns,
    Value<dynamic>? cashFlowProjection,
    Value<dynamic>? riskMetrics,
    Value<dynamic>? keyAssumptions,
    Value<dynamic>? sensitivityAnalysis,
    Value<double?>? confidence,
    Value<DateTime?>? generatedAt,
    Value<DateTime?>? createdAt,
    Value<Organization?>? org,
    Value<Property?>? property,
  }) {
    return AIInvestmentAnalysis(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        propertyId: propertyId != null ? propertyId.value : this.propertyId,
        analysisType:
            analysisType != null ? analysisType.value : this.analysisType,
        timeHorizon: timeHorizon != null ? timeHorizon.value : this.timeHorizon,
        projectedReturns: projectedReturns != null
            ? projectedReturns.value
            : this.projectedReturns,
        cashFlowProjection: cashFlowProjection != null
            ? cashFlowProjection.value
            : this.cashFlowProjection,
        riskMetrics: riskMetrics != null ? riskMetrics.value : this.riskMetrics,
        keyAssumptions:
            keyAssumptions != null ? keyAssumptions.value : this.keyAssumptions,
        sensitivityAnalysis: sensitivityAnalysis != null
            ? sensitivityAnalysis.value
            : this.sensitivityAnalysis,
        confidence: confidence != null ? confidence.value : this.confidence,
        generatedAt: generatedAt != null ? generatedAt.value : this.generatedAt,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        org: org != null ? org.value : this.org,
        property: property != null ? property.value : this.property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIInvestmentAnalysis copyWithInstanceValues(
      AIInvestmentAnalysis aIInvestmentAnalysis) {
    return AIInvestmentAnalysis(
        id: aIInvestmentAnalysis.id ?? id,
        orgId: aIInvestmentAnalysis.orgId ?? orgId,
        propertyId: aIInvestmentAnalysis.propertyId ?? propertyId,
        analysisType: aIInvestmentAnalysis.analysisType ?? analysisType,
        timeHorizon: aIInvestmentAnalysis.timeHorizon ?? timeHorizon,
        projectedReturns:
            aIInvestmentAnalysis.projectedReturns ?? projectedReturns,
        cashFlowProjection:
            aIInvestmentAnalysis.cashFlowProjection ?? cashFlowProjection,
        riskMetrics: aIInvestmentAnalysis.riskMetrics ?? riskMetrics,
        keyAssumptions: aIInvestmentAnalysis.keyAssumptions ?? keyAssumptions,
        sensitivityAnalysis:
            aIInvestmentAnalysis.sensitivityAnalysis ?? sensitivityAnalysis,
        confidence: aIInvestmentAnalysis.confidence ?? confidence,
        generatedAt: aIInvestmentAnalysis.generatedAt ?? generatedAt,
        createdAt: aIInvestmentAnalysis.createdAt ?? createdAt,
        org: aIInvestmentAnalysis.org ?? org,
        property: aIInvestmentAnalysis.property ?? property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIInvestmentAnalysis mergeWithInstanceValues(
      AIInvestmentAnalysis aIInvestmentAnalysis) {
    return AIInvestmentAnalysis(
        id: aIInvestmentAnalysis.$assignedFields.contains('id')
            ? aIInvestmentAnalysis.id
            : id,
        orgId: aIInvestmentAnalysis.$assignedFields.contains('orgId')
            ? aIInvestmentAnalysis.orgId
            : orgId,
        propertyId: aIInvestmentAnalysis.$assignedFields.contains('propertyId')
            ? aIInvestmentAnalysis.propertyId
            : propertyId,
        analysisType: aIInvestmentAnalysis.$assignedFields.contains('analysisType')
            ? aIInvestmentAnalysis.analysisType
            : analysisType,
        timeHorizon: aIInvestmentAnalysis.$assignedFields.contains('timeHorizon')
            ? aIInvestmentAnalysis.timeHorizon
            : timeHorizon,
        projectedReturns: aIInvestmentAnalysis.$assignedFields.contains('projectedReturns')
            ? aIInvestmentAnalysis.projectedReturns
            : projectedReturns,
        cashFlowProjection:
            aIInvestmentAnalysis.$assignedFields.contains('cashFlowProjection')
                ? aIInvestmentAnalysis.cashFlowProjection
                : cashFlowProjection,
        riskMetrics: aIInvestmentAnalysis.$assignedFields.contains('riskMetrics')
            ? aIInvestmentAnalysis.riskMetrics
            : riskMetrics,
        keyAssumptions: aIInvestmentAnalysis.$assignedFields.contains('keyAssumptions')
            ? aIInvestmentAnalysis.keyAssumptions
            : keyAssumptions,
        sensitivityAnalysis:
            aIInvestmentAnalysis.$assignedFields.contains('sensitivityAnalysis')
                ? aIInvestmentAnalysis.sensitivityAnalysis
                : sensitivityAnalysis,
        confidence: aIInvestmentAnalysis.$assignedFields.contains('confidence')
            ? aIInvestmentAnalysis.confidence
            : confidence,
        generatedAt: aIInvestmentAnalysis.$assignedFields.contains('generatedAt')
            ? aIInvestmentAnalysis.generatedAt
            : generatedAt,
        createdAt: aIInvestmentAnalysis.$assignedFields.contains('createdAt')
            ? aIInvestmentAnalysis.createdAt
            : createdAt,
        org: aIInvestmentAnalysis.$assignedFields.contains('org') ? aIInvestmentAnalysis.org : org,
        property: aIInvestmentAnalysis.$assignedFields.contains('property') ? aIInvestmentAnalysis.property : property);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIInvestmentAnalysis updateWithInstanceValues(
      AIInvestmentAnalysis aIInvestmentAnalysis) {
    if (aIInvestmentAnalysis.$assignedFields.contains('id')) {
      id = aIInvestmentAnalysis.id;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('orgId')) {
      orgId = aIInvestmentAnalysis.orgId;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('propertyId')) {
      propertyId = aIInvestmentAnalysis.propertyId;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('analysisType')) {
      analysisType = aIInvestmentAnalysis.analysisType;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('timeHorizon')) {
      timeHorizon = aIInvestmentAnalysis.timeHorizon;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('projectedReturns')) {
      projectedReturns = aIInvestmentAnalysis.projectedReturns;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('cashFlowProjection')) {
      cashFlowProjection = aIInvestmentAnalysis.cashFlowProjection;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('riskMetrics')) {
      riskMetrics = aIInvestmentAnalysis.riskMetrics;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('keyAssumptions')) {
      keyAssumptions = aIInvestmentAnalysis.keyAssumptions;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('sensitivityAnalysis')) {
      sensitivityAnalysis = aIInvestmentAnalysis.sensitivityAnalysis;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('confidence')) {
      confidence = aIInvestmentAnalysis.confidence;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('generatedAt')) {
      generatedAt = aIInvestmentAnalysis.generatedAt;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('createdAt')) {
      createdAt = aIInvestmentAnalysis.createdAt;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('org')) {
      org = aIInvestmentAnalysis.org;
    }
    if (aIInvestmentAnalysis.$assignedFields.contains('property')) {
      property = aIInvestmentAnalysis.property;
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
        ? {...?serializedTypes, 'AIInvestmentAnalysis'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (analysisType != null) 'analysisType': analysisType,
      if (timeHorizon != null) 'timeHorizon': timeHorizon,
      if (projectedReturns != null) 'projectedReturns': projectedReturns,
      if (cashFlowProjection != null) 'cashFlowProjection': cashFlowProjection,
      if (riskMetrics != null) 'riskMetrics': riskMetrics,
      if (keyAssumptions != null) 'keyAssumptions': keyAssumptions,
      if (sensitivityAnalysis != null)
        'sensitivityAnalysis': sensitivityAnalysis,
      if (confidence != null) 'confidence': confidence,
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
      other is AIInvestmentAnalysis &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
