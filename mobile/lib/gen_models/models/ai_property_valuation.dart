//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'ai_valuation_model.dart';
import 'organization.dart';
import 'property.dart';

class AIPropertyValuation
    implements PrismaModel<String, AIPropertyValuation>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? modelId;
  String? propertyId;
  double? predictedValue;
  double? confidenceScore;
  DateTime? valuationDate;
  dynamic inputFeatures;
  dynamic comparableSales;
  dynamic marketTrends;
  String? status;
  DateTime? createdAt;
  AIValuationModel? model;
  Organization? org;
  Property? property;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIPropertyValuation({
    this.id,
    this.orgId,
    this.modelId,
    this.propertyId,
    this.predictedValue,
    this.confidenceScore,
    this.valuationDate,
    required this.inputFeatures,
    required this.comparableSales,
    required this.marketTrends,
    this.status = "COMPLETED",
    this.createdAt,
    this.model,
    this.org,
    this.property,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIPropertyValuation, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "modelId": (m) => m.modelId,
    "propertyId": (m) => m.propertyId,
    "predictedValue": (m) => m.predictedValue,
    "confidenceScore": (m) => m.confidenceScore,
    "valuationDate": (m) => m.valuationDate,
    "inputFeatures": (m) => m.inputFeatures,
    "comparableSales": (m) => m.comparableSales,
    "marketTrends": (m) => m.marketTrends,
    "status": (m) => m.status,
    "createdAt": (m) => m.createdAt,
    "model": (m) => m.model,
    "org": (m) => m.org,
    "property": (m) => m.property,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIPropertyValuation) getPropToValueFunction<V>(
      String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception(
          'Property "$propertyName" not found in AIPropertyValuation');
    }
    return propFunction as V? Function(AIPropertyValuation);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIPropertyValuation.fromJson(JsonMap json) => AIPropertyValuation(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        modelId: json['modelId'] as String?,
        propertyId: json['propertyId'] as String?,
        predictedValue: json['predictedValue'] as double?,
        confidenceScore: json['confidenceScore']?.toDouble(),
        valuationDate: json['valuationDate'] != null
            ? DateTime.parse(json['valuationDate'])
            : null,
        inputFeatures: json['inputFeatures'] as dynamic,
        comparableSales: json['comparableSales'] as dynamic,
        marketTrends: json['marketTrends'] as dynamic,
        status: json['status'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        model: json['model'] != null
            ? AIValuationModel.fromJson(json['model'] as JsonMap)
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
  AIPropertyValuation copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? modelId,
    Value<String?>? propertyId,
    Value<double?>? predictedValue,
    Value<double?>? confidenceScore,
    Value<DateTime?>? valuationDate,
    Value<dynamic>? inputFeatures,
    Value<dynamic>? comparableSales,
    Value<dynamic>? marketTrends,
    Value<String?>? status,
    Value<DateTime?>? createdAt,
    Value<AIValuationModel?>? model,
    Value<Organization?>? org,
    Value<Property?>? property,
  }) {
    return AIPropertyValuation(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        modelId: modelId != null ? modelId.value : this.modelId,
        propertyId: propertyId != null ? propertyId.value : this.propertyId,
        predictedValue:
            predictedValue != null ? predictedValue.value : this.predictedValue,
        confidenceScore: confidenceScore != null
            ? confidenceScore.value
            : this.confidenceScore,
        valuationDate:
            valuationDate != null ? valuationDate.value : this.valuationDate,
        inputFeatures:
            inputFeatures != null ? inputFeatures.value : this.inputFeatures,
        comparableSales: comparableSales != null
            ? comparableSales.value
            : this.comparableSales,
        marketTrends:
            marketTrends != null ? marketTrends.value : this.marketTrends,
        status: status != null ? status.value : this.status,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        model: model != null ? model.value : this.model,
        org: org != null ? org.value : this.org,
        property: property != null ? property.value : this.property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIPropertyValuation copyWithInstanceValues(
      AIPropertyValuation aIPropertyValuation) {
    return AIPropertyValuation(
        id: aIPropertyValuation.id ?? id,
        orgId: aIPropertyValuation.orgId ?? orgId,
        modelId: aIPropertyValuation.modelId ?? modelId,
        propertyId: aIPropertyValuation.propertyId ?? propertyId,
        predictedValue: aIPropertyValuation.predictedValue ?? predictedValue,
        confidenceScore: aIPropertyValuation.confidenceScore ?? confidenceScore,
        valuationDate: aIPropertyValuation.valuationDate ?? valuationDate,
        inputFeatures: aIPropertyValuation.inputFeatures ?? inputFeatures,
        comparableSales: aIPropertyValuation.comparableSales ?? comparableSales,
        marketTrends: aIPropertyValuation.marketTrends ?? marketTrends,
        status: aIPropertyValuation.status ?? status,
        createdAt: aIPropertyValuation.createdAt ?? createdAt,
        model: aIPropertyValuation.model ?? model,
        org: aIPropertyValuation.org ?? org,
        property: aIPropertyValuation.property ?? property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIPropertyValuation mergeWithInstanceValues(
      AIPropertyValuation aIPropertyValuation) {
    return AIPropertyValuation(
        id: aIPropertyValuation.$assignedFields.contains('id')
            ? aIPropertyValuation.id
            : id,
        orgId: aIPropertyValuation.$assignedFields.contains('orgId')
            ? aIPropertyValuation.orgId
            : orgId,
        modelId: aIPropertyValuation.$assignedFields.contains('modelId')
            ? aIPropertyValuation.modelId
            : modelId,
        propertyId: aIPropertyValuation.$assignedFields.contains('propertyId')
            ? aIPropertyValuation.propertyId
            : propertyId,
        predictedValue:
            aIPropertyValuation.$assignedFields.contains('predictedValue')
                ? aIPropertyValuation.predictedValue
                : predictedValue,
        confidenceScore:
            aIPropertyValuation.$assignedFields.contains('confidenceScore')
                ? aIPropertyValuation.confidenceScore
                : confidenceScore,
        valuationDate:
            aIPropertyValuation.$assignedFields.contains('valuationDate')
                ? aIPropertyValuation.valuationDate
                : valuationDate,
        inputFeatures:
            aIPropertyValuation.$assignedFields.contains('inputFeatures')
                ? aIPropertyValuation.inputFeatures
                : inputFeatures,
        comparableSales:
            aIPropertyValuation.$assignedFields.contains('comparableSales')
                ? aIPropertyValuation.comparableSales
                : comparableSales,
        marketTrends: aIPropertyValuation.$assignedFields.contains('marketTrends')
            ? aIPropertyValuation.marketTrends
            : marketTrends,
        status: aIPropertyValuation.$assignedFields.contains('status')
            ? aIPropertyValuation.status
            : status,
        createdAt: aIPropertyValuation.$assignedFields.contains('createdAt')
            ? aIPropertyValuation.createdAt
            : createdAt,
        model: aIPropertyValuation.$assignedFields.contains('model')
            ? aIPropertyValuation.model
            : model,
        org: aIPropertyValuation.$assignedFields.contains('org')
            ? aIPropertyValuation.org
            : org,
        property: aIPropertyValuation.$assignedFields.contains('property')
            ? aIPropertyValuation.property
            : property);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIPropertyValuation updateWithInstanceValues(
      AIPropertyValuation aIPropertyValuation) {
    if (aIPropertyValuation.$assignedFields.contains('id')) {
      id = aIPropertyValuation.id;
    }
    if (aIPropertyValuation.$assignedFields.contains('orgId')) {
      orgId = aIPropertyValuation.orgId;
    }
    if (aIPropertyValuation.$assignedFields.contains('modelId')) {
      modelId = aIPropertyValuation.modelId;
    }
    if (aIPropertyValuation.$assignedFields.contains('propertyId')) {
      propertyId = aIPropertyValuation.propertyId;
    }
    if (aIPropertyValuation.$assignedFields.contains('predictedValue')) {
      predictedValue = aIPropertyValuation.predictedValue;
    }
    if (aIPropertyValuation.$assignedFields.contains('confidenceScore')) {
      confidenceScore = aIPropertyValuation.confidenceScore;
    }
    if (aIPropertyValuation.$assignedFields.contains('valuationDate')) {
      valuationDate = aIPropertyValuation.valuationDate;
    }
    if (aIPropertyValuation.$assignedFields.contains('inputFeatures')) {
      inputFeatures = aIPropertyValuation.inputFeatures;
    }
    if (aIPropertyValuation.$assignedFields.contains('comparableSales')) {
      comparableSales = aIPropertyValuation.comparableSales;
    }
    if (aIPropertyValuation.$assignedFields.contains('marketTrends')) {
      marketTrends = aIPropertyValuation.marketTrends;
    }
    if (aIPropertyValuation.$assignedFields.contains('status')) {
      status = aIPropertyValuation.status;
    }
    if (aIPropertyValuation.$assignedFields.contains('createdAt')) {
      createdAt = aIPropertyValuation.createdAt;
    }
    if (aIPropertyValuation.$assignedFields.contains('model')) {
      model = aIPropertyValuation.model;
    }
    if (aIPropertyValuation.$assignedFields.contains('org')) {
      org = aIPropertyValuation.org;
    }
    if (aIPropertyValuation.$assignedFields.contains('property')) {
      property = aIPropertyValuation.property;
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
        ? {...?serializedTypes, 'AIPropertyValuation'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (modelId != null) 'modelId': modelId,
      if (propertyId != null) 'propertyId': propertyId,
      if (predictedValue != null) 'predictedValue': predictedValue,
      if (confidenceScore != null) 'confidenceScore': confidenceScore,
      if (valuationDate != null)
        'valuationDate': valuationDate?.toIso8601String(),
      if (inputFeatures != null) 'inputFeatures': inputFeatures,
      if (comparableSales != null) 'comparableSales': comparableSales,
      if (marketTrends != null) 'marketTrends': marketTrends,
      if (status != null) 'status': status,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (model != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AIValuationModel')))
        'model': model?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
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
      other is AIPropertyValuation &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
