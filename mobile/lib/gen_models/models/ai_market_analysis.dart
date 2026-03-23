//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';

class AIMarketAnalysis
    implements PrismaModel<String, AIMarketAnalysis>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? analysisType;
  String? location;
  String? analysisPeriod;
  dynamic dataPoints;
  dynamic predictions;
  dynamic insights;
  double? confidence;
  DateTime? generatedAt;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIMarketAnalysis({
    this.id,
    this.orgId,
    this.analysisType,
    this.location,
    this.analysisPeriod,
    required this.dataPoints,
    required this.predictions,
    required this.insights,
    this.confidence,
    this.generatedAt,
    this.status = "COMPLETED",
    this.createdAt,
    this.updatedAt,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIMarketAnalysis, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "analysisType": (m) => m.analysisType,
    "location": (m) => m.location,
    "analysisPeriod": (m) => m.analysisPeriod,
    "dataPoints": (m) => m.dataPoints,
    "predictions": (m) => m.predictions,
    "insights": (m) => m.insights,
    "confidence": (m) => m.confidence,
    "generatedAt": (m) => m.generatedAt,
    "status": (m) => m.status,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIMarketAnalysis) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIMarketAnalysis');
    }
    return propFunction as V? Function(AIMarketAnalysis);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIMarketAnalysis.fromJson(JsonMap json) => AIMarketAnalysis(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        analysisType: json['analysisType'] as String?,
        location: json['location'] as String?,
        analysisPeriod: json['analysisPeriod'] as String?,
        dataPoints: json['dataPoints'] as dynamic,
        predictions: json['predictions'] as dynamic,
        insights: json['insights'] as dynamic,
        confidence: json['confidence']?.toDouble(),
        generatedAt: json['generatedAt'] != null
            ? DateTime.parse(json['generatedAt'])
            : null,
        status: json['status'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIMarketAnalysis copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? analysisType,
    Value<String?>? location,
    Value<String?>? analysisPeriod,
    Value<dynamic>? dataPoints,
    Value<dynamic>? predictions,
    Value<dynamic>? insights,
    Value<double?>? confidence,
    Value<DateTime?>? generatedAt,
    Value<String?>? status,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<Organization?>? org,
  }) {
    return AIMarketAnalysis(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        analysisType:
            analysisType != null ? analysisType.value : this.analysisType,
        location: location != null ? location.value : this.location,
        analysisPeriod:
            analysisPeriod != null ? analysisPeriod.value : this.analysisPeriod,
        dataPoints: dataPoints != null ? dataPoints.value : this.dataPoints,
        predictions: predictions != null ? predictions.value : this.predictions,
        insights: insights != null ? insights.value : this.insights,
        confidence: confidence != null ? confidence.value : this.confidence,
        generatedAt: generatedAt != null ? generatedAt.value : this.generatedAt,
        status: status != null ? status.value : this.status,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIMarketAnalysis copyWithInstanceValues(AIMarketAnalysis aIMarketAnalysis) {
    return AIMarketAnalysis(
        id: aIMarketAnalysis.id ?? id,
        orgId: aIMarketAnalysis.orgId ?? orgId,
        analysisType: aIMarketAnalysis.analysisType ?? analysisType,
        location: aIMarketAnalysis.location ?? location,
        analysisPeriod: aIMarketAnalysis.analysisPeriod ?? analysisPeriod,
        dataPoints: aIMarketAnalysis.dataPoints ?? dataPoints,
        predictions: aIMarketAnalysis.predictions ?? predictions,
        insights: aIMarketAnalysis.insights ?? insights,
        confidence: aIMarketAnalysis.confidence ?? confidence,
        generatedAt: aIMarketAnalysis.generatedAt ?? generatedAt,
        status: aIMarketAnalysis.status ?? status,
        createdAt: aIMarketAnalysis.createdAt ?? createdAt,
        updatedAt: aIMarketAnalysis.updatedAt ?? updatedAt,
        org: aIMarketAnalysis.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIMarketAnalysis mergeWithInstanceValues(AIMarketAnalysis aIMarketAnalysis) {
    return AIMarketAnalysis(
        id: aIMarketAnalysis.$assignedFields.contains('id')
            ? aIMarketAnalysis.id
            : id,
        orgId: aIMarketAnalysis.$assignedFields.contains('orgId')
            ? aIMarketAnalysis.orgId
            : orgId,
        analysisType: aIMarketAnalysis.$assignedFields.contains('analysisType')
            ? aIMarketAnalysis.analysisType
            : analysisType,
        location: aIMarketAnalysis.$assignedFields.contains('location')
            ? aIMarketAnalysis.location
            : location,
        analysisPeriod:
            aIMarketAnalysis.$assignedFields.contains('analysisPeriod')
                ? aIMarketAnalysis.analysisPeriod
                : analysisPeriod,
        dataPoints: aIMarketAnalysis.$assignedFields.contains('dataPoints')
            ? aIMarketAnalysis.dataPoints
            : dataPoints,
        predictions: aIMarketAnalysis.$assignedFields.contains('predictions')
            ? aIMarketAnalysis.predictions
            : predictions,
        insights: aIMarketAnalysis.$assignedFields.contains('insights')
            ? aIMarketAnalysis.insights
            : insights,
        confidence: aIMarketAnalysis.$assignedFields.contains('confidence')
            ? aIMarketAnalysis.confidence
            : confidence,
        generatedAt: aIMarketAnalysis.$assignedFields.contains('generatedAt')
            ? aIMarketAnalysis.generatedAt
            : generatedAt,
        status: aIMarketAnalysis.$assignedFields.contains('status')
            ? aIMarketAnalysis.status
            : status,
        createdAt: aIMarketAnalysis.$assignedFields.contains('createdAt')
            ? aIMarketAnalysis.createdAt
            : createdAt,
        updatedAt: aIMarketAnalysis.$assignedFields.contains('updatedAt')
            ? aIMarketAnalysis.updatedAt
            : updatedAt,
        org: aIMarketAnalysis.$assignedFields.contains('org')
            ? aIMarketAnalysis.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIMarketAnalysis updateWithInstanceValues(AIMarketAnalysis aIMarketAnalysis) {
    if (aIMarketAnalysis.$assignedFields.contains('id')) {
      id = aIMarketAnalysis.id;
    }
    if (aIMarketAnalysis.$assignedFields.contains('orgId')) {
      orgId = aIMarketAnalysis.orgId;
    }
    if (aIMarketAnalysis.$assignedFields.contains('analysisType')) {
      analysisType = aIMarketAnalysis.analysisType;
    }
    if (aIMarketAnalysis.$assignedFields.contains('location')) {
      location = aIMarketAnalysis.location;
    }
    if (aIMarketAnalysis.$assignedFields.contains('analysisPeriod')) {
      analysisPeriod = aIMarketAnalysis.analysisPeriod;
    }
    if (aIMarketAnalysis.$assignedFields.contains('dataPoints')) {
      dataPoints = aIMarketAnalysis.dataPoints;
    }
    if (aIMarketAnalysis.$assignedFields.contains('predictions')) {
      predictions = aIMarketAnalysis.predictions;
    }
    if (aIMarketAnalysis.$assignedFields.contains('insights')) {
      insights = aIMarketAnalysis.insights;
    }
    if (aIMarketAnalysis.$assignedFields.contains('confidence')) {
      confidence = aIMarketAnalysis.confidence;
    }
    if (aIMarketAnalysis.$assignedFields.contains('generatedAt')) {
      generatedAt = aIMarketAnalysis.generatedAt;
    }
    if (aIMarketAnalysis.$assignedFields.contains('status')) {
      status = aIMarketAnalysis.status;
    }
    if (aIMarketAnalysis.$assignedFields.contains('createdAt')) {
      createdAt = aIMarketAnalysis.createdAt;
    }
    if (aIMarketAnalysis.$assignedFields.contains('updatedAt')) {
      updatedAt = aIMarketAnalysis.updatedAt;
    }
    if (aIMarketAnalysis.$assignedFields.contains('org')) {
      org = aIMarketAnalysis.org;
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
        ? {...?serializedTypes, 'AIMarketAnalysis'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (analysisType != null) 'analysisType': analysisType,
      if (location != null) 'location': location,
      if (analysisPeriod != null) 'analysisPeriod': analysisPeriod,
      if (dataPoints != null) 'dataPoints': dataPoints,
      if (predictions != null) 'predictions': predictions,
      if (insights != null) 'insights': insights,
      if (confidence != null) 'confidence': confidence,
      if (generatedAt != null) 'generatedAt': generatedAt?.toIso8601String(),
      if (status != null) 'status': status,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
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
      other is AIMarketAnalysis &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
