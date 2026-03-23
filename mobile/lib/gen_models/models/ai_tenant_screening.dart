//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';

class AITenantScreening
    implements PrismaModel<String, AITenantScreening>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? applicationId;
  double? overallScore;
  String? riskAssessment;
  double? creditScore;
  double? incomeStability;
  double? rentalHistory;
  double? backgroundCheck;
  dynamic riskFactors;
  dynamic recommendations;
  DateTime? screenedAt;
  String? reviewedBy;
  String? finalDecision;
  DateTime? createdAt;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AITenantScreening({
    this.id,
    this.orgId,
    this.applicationId,
    this.overallScore,
    this.riskAssessment,
    this.creditScore,
    this.incomeStability,
    this.rentalHistory,
    this.backgroundCheck,
    required this.riskFactors,
    required this.recommendations,
    this.screenedAt,
    this.reviewedBy,
    this.finalDecision,
    this.createdAt,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AITenantScreening, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "applicationId": (m) => m.applicationId,
    "overallScore": (m) => m.overallScore,
    "riskAssessment": (m) => m.riskAssessment,
    "creditScore": (m) => m.creditScore,
    "incomeStability": (m) => m.incomeStability,
    "rentalHistory": (m) => m.rentalHistory,
    "backgroundCheck": (m) => m.backgroundCheck,
    "riskFactors": (m) => m.riskFactors,
    "recommendations": (m) => m.recommendations,
    "screenedAt": (m) => m.screenedAt,
    "reviewedBy": (m) => m.reviewedBy,
    "finalDecision": (m) => m.finalDecision,
    "createdAt": (m) => m.createdAt,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AITenantScreening) getPropToValueFunction<V>(
      String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception(
          'Property "$propertyName" not found in AITenantScreening');
    }
    return propFunction as V? Function(AITenantScreening);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AITenantScreening.fromJson(JsonMap json) => AITenantScreening(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        applicationId: json['applicationId'] as String?,
        overallScore: json['overallScore']?.toDouble(),
        riskAssessment: json['riskAssessment'] as String?,
        creditScore: json['creditScore']?.toDouble(),
        incomeStability: json['incomeStability']?.toDouble(),
        rentalHistory: json['rentalHistory']?.toDouble(),
        backgroundCheck: json['backgroundCheck']?.toDouble(),
        riskFactors: json['riskFactors'] as dynamic,
        recommendations: json['recommendations'] as dynamic,
        screenedAt: json['screenedAt'] != null
            ? DateTime.parse(json['screenedAt'])
            : null,
        reviewedBy: json['reviewedBy'] as String?,
        finalDecision: json['finalDecision'] as String?,
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
  AITenantScreening copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? applicationId,
    Value<double?>? overallScore,
    Value<String?>? riskAssessment,
    Value<double?>? creditScore,
    Value<double?>? incomeStability,
    Value<double?>? rentalHistory,
    Value<double?>? backgroundCheck,
    Value<dynamic>? riskFactors,
    Value<dynamic>? recommendations,
    Value<DateTime?>? screenedAt,
    Value<String?>? reviewedBy,
    Value<String?>? finalDecision,
    Value<DateTime?>? createdAt,
    Value<Organization?>? org,
  }) {
    return AITenantScreening(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        applicationId:
            applicationId != null ? applicationId.value : this.applicationId,
        overallScore:
            overallScore != null ? overallScore.value : this.overallScore,
        riskAssessment:
            riskAssessment != null ? riskAssessment.value : this.riskAssessment,
        creditScore: creditScore != null ? creditScore.value : this.creditScore,
        incomeStability: incomeStability != null
            ? incomeStability.value
            : this.incomeStability,
        rentalHistory:
            rentalHistory != null ? rentalHistory.value : this.rentalHistory,
        backgroundCheck: backgroundCheck != null
            ? backgroundCheck.value
            : this.backgroundCheck,
        riskFactors: riskFactors != null ? riskFactors.value : this.riskFactors,
        recommendations: recommendations != null
            ? recommendations.value
            : this.recommendations,
        screenedAt: screenedAt != null ? screenedAt.value : this.screenedAt,
        reviewedBy: reviewedBy != null ? reviewedBy.value : this.reviewedBy,
        finalDecision:
            finalDecision != null ? finalDecision.value : this.finalDecision,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AITenantScreening copyWithInstanceValues(
      AITenantScreening aITenantScreening) {
    return AITenantScreening(
        id: aITenantScreening.id ?? id,
        orgId: aITenantScreening.orgId ?? orgId,
        applicationId: aITenantScreening.applicationId ?? applicationId,
        overallScore: aITenantScreening.overallScore ?? overallScore,
        riskAssessment: aITenantScreening.riskAssessment ?? riskAssessment,
        creditScore: aITenantScreening.creditScore ?? creditScore,
        incomeStability: aITenantScreening.incomeStability ?? incomeStability,
        rentalHistory: aITenantScreening.rentalHistory ?? rentalHistory,
        backgroundCheck: aITenantScreening.backgroundCheck ?? backgroundCheck,
        riskFactors: aITenantScreening.riskFactors ?? riskFactors,
        recommendations: aITenantScreening.recommendations ?? recommendations,
        screenedAt: aITenantScreening.screenedAt ?? screenedAt,
        reviewedBy: aITenantScreening.reviewedBy ?? reviewedBy,
        finalDecision: aITenantScreening.finalDecision ?? finalDecision,
        createdAt: aITenantScreening.createdAt ?? createdAt,
        org: aITenantScreening.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AITenantScreening mergeWithInstanceValues(
      AITenantScreening aITenantScreening) {
    return AITenantScreening(
        id: aITenantScreening.$assignedFields.contains('id')
            ? aITenantScreening.id
            : id,
        orgId: aITenantScreening.$assignedFields.contains('orgId')
            ? aITenantScreening.orgId
            : orgId,
        applicationId: aITenantScreening.$assignedFields.contains('applicationId')
            ? aITenantScreening.applicationId
            : applicationId,
        overallScore: aITenantScreening.$assignedFields.contains('overallScore')
            ? aITenantScreening.overallScore
            : overallScore,
        riskAssessment:
            aITenantScreening.$assignedFields.contains('riskAssessment')
                ? aITenantScreening.riskAssessment
                : riskAssessment,
        creditScore: aITenantScreening.$assignedFields.contains('creditScore')
            ? aITenantScreening.creditScore
            : creditScore,
        incomeStability:
            aITenantScreening.$assignedFields.contains('incomeStability')
                ? aITenantScreening.incomeStability
                : incomeStability,
        rentalHistory: aITenantScreening.$assignedFields.contains('rentalHistory')
            ? aITenantScreening.rentalHistory
            : rentalHistory,
        backgroundCheck:
            aITenantScreening.$assignedFields.contains('backgroundCheck')
                ? aITenantScreening.backgroundCheck
                : backgroundCheck,
        riskFactors: aITenantScreening.$assignedFields.contains('riskFactors')
            ? aITenantScreening.riskFactors
            : riskFactors,
        recommendations:
            aITenantScreening.$assignedFields.contains('recommendations')
                ? aITenantScreening.recommendations
                : recommendations,
        screenedAt: aITenantScreening.$assignedFields.contains('screenedAt')
            ? aITenantScreening.screenedAt
            : screenedAt,
        reviewedBy: aITenantScreening.$assignedFields.contains('reviewedBy')
            ? aITenantScreening.reviewedBy
            : reviewedBy,
        finalDecision: aITenantScreening.$assignedFields.contains('finalDecision')
            ? aITenantScreening.finalDecision
            : finalDecision,
        createdAt: aITenantScreening.$assignedFields.contains('createdAt')
            ? aITenantScreening.createdAt
            : createdAt,
        org: aITenantScreening.$assignedFields.contains('org')
            ? aITenantScreening.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AITenantScreening updateWithInstanceValues(
      AITenantScreening aITenantScreening) {
    if (aITenantScreening.$assignedFields.contains('id')) {
      id = aITenantScreening.id;
    }
    if (aITenantScreening.$assignedFields.contains('orgId')) {
      orgId = aITenantScreening.orgId;
    }
    if (aITenantScreening.$assignedFields.contains('applicationId')) {
      applicationId = aITenantScreening.applicationId;
    }
    if (aITenantScreening.$assignedFields.contains('overallScore')) {
      overallScore = aITenantScreening.overallScore;
    }
    if (aITenantScreening.$assignedFields.contains('riskAssessment')) {
      riskAssessment = aITenantScreening.riskAssessment;
    }
    if (aITenantScreening.$assignedFields.contains('creditScore')) {
      creditScore = aITenantScreening.creditScore;
    }
    if (aITenantScreening.$assignedFields.contains('incomeStability')) {
      incomeStability = aITenantScreening.incomeStability;
    }
    if (aITenantScreening.$assignedFields.contains('rentalHistory')) {
      rentalHistory = aITenantScreening.rentalHistory;
    }
    if (aITenantScreening.$assignedFields.contains('backgroundCheck')) {
      backgroundCheck = aITenantScreening.backgroundCheck;
    }
    if (aITenantScreening.$assignedFields.contains('riskFactors')) {
      riskFactors = aITenantScreening.riskFactors;
    }
    if (aITenantScreening.$assignedFields.contains('recommendations')) {
      recommendations = aITenantScreening.recommendations;
    }
    if (aITenantScreening.$assignedFields.contains('screenedAt')) {
      screenedAt = aITenantScreening.screenedAt;
    }
    if (aITenantScreening.$assignedFields.contains('reviewedBy')) {
      reviewedBy = aITenantScreening.reviewedBy;
    }
    if (aITenantScreening.$assignedFields.contains('finalDecision')) {
      finalDecision = aITenantScreening.finalDecision;
    }
    if (aITenantScreening.$assignedFields.contains('createdAt')) {
      createdAt = aITenantScreening.createdAt;
    }
    if (aITenantScreening.$assignedFields.contains('org')) {
      org = aITenantScreening.org;
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
        ? {...?serializedTypes, 'AITenantScreening'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (applicationId != null) 'applicationId': applicationId,
      if (overallScore != null) 'overallScore': overallScore,
      if (riskAssessment != null) 'riskAssessment': riskAssessment,
      if (creditScore != null) 'creditScore': creditScore,
      if (incomeStability != null) 'incomeStability': incomeStability,
      if (rentalHistory != null) 'rentalHistory': rentalHistory,
      if (backgroundCheck != null) 'backgroundCheck': backgroundCheck,
      if (riskFactors != null) 'riskFactors': riskFactors,
      if (recommendations != null) 'recommendations': recommendations,
      if (screenedAt != null) 'screenedAt': screenedAt?.toIso8601String(),
      if (reviewedBy != null) 'reviewedBy': reviewedBy,
      if (finalDecision != null) 'finalDecision': finalDecision,
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
      other is AITenantScreening &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
