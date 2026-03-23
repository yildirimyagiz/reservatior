//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';

class AIPropertyDescription
    implements PrismaModel<String, AIPropertyDescription>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? propertyId;
  String? generatedDescription;
  String? originalDescription;
  String? tone;
  String? targetAudience;
  dynamic keyFeatures;
  dynamic seoKeywords;
  double? qualityScore;
  DateTime? generatedAt;
  bool? isApproved;
  String? approvedBy;
  DateTime? approvedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Organization? org;
  Property? property;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIPropertyDescription({
    this.id,
    this.orgId,
    this.propertyId,
    this.generatedDescription,
    this.originalDescription,
    this.tone,
    this.targetAudience,
    required this.keyFeatures,
    required this.seoKeywords,
    this.qualityScore,
    this.generatedAt,
    this.isApproved = false,
    this.approvedBy,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    this.org,
    this.property,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIPropertyDescription, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "propertyId": (m) => m.propertyId,
    "generatedDescription": (m) => m.generatedDescription,
    "originalDescription": (m) => m.originalDescription,
    "tone": (m) => m.tone,
    "targetAudience": (m) => m.targetAudience,
    "keyFeatures": (m) => m.keyFeatures,
    "seoKeywords": (m) => m.seoKeywords,
    "qualityScore": (m) => m.qualityScore,
    "generatedAt": (m) => m.generatedAt,
    "isApproved": (m) => m.isApproved,
    "approvedBy": (m) => m.approvedBy,
    "approvedAt": (m) => m.approvedAt,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "org": (m) => m.org,
    "property": (m) => m.property,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIPropertyDescription) getPropToValueFunction<V>(
      String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception(
          'Property "$propertyName" not found in AIPropertyDescription');
    }
    return propFunction as V? Function(AIPropertyDescription);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIPropertyDescription.fromJson(JsonMap json) => AIPropertyDescription(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        propertyId: json['propertyId'] as String?,
        generatedDescription: json['generatedDescription'] as String?,
        originalDescription: json['originalDescription'] as String?,
        tone: json['tone'] as String?,
        targetAudience: json['targetAudience'] as String?,
        keyFeatures: json['keyFeatures'] as dynamic,
        seoKeywords: json['seoKeywords'] as dynamic,
        qualityScore: json['qualityScore']?.toDouble(),
        generatedAt: json['generatedAt'] != null
            ? DateTime.parse(json['generatedAt'])
            : null,
        isApproved: json['isApproved'] as bool?,
        approvedBy: json['approvedBy'] as String?,
        approvedAt: json['approvedAt'] != null
            ? DateTime.parse(json['approvedAt'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
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
  AIPropertyDescription copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? propertyId,
    Value<String?>? generatedDescription,
    Value<String?>? originalDescription,
    Value<String?>? tone,
    Value<String?>? targetAudience,
    Value<dynamic>? keyFeatures,
    Value<dynamic>? seoKeywords,
    Value<double?>? qualityScore,
    Value<DateTime?>? generatedAt,
    Value<bool?>? isApproved,
    Value<String?>? approvedBy,
    Value<DateTime?>? approvedAt,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<Organization?>? org,
    Value<Property?>? property,
  }) {
    return AIPropertyDescription(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        propertyId: propertyId != null ? propertyId.value : this.propertyId,
        generatedDescription: generatedDescription != null
            ? generatedDescription.value
            : this.generatedDescription,
        originalDescription: originalDescription != null
            ? originalDescription.value
            : this.originalDescription,
        tone: tone != null ? tone.value : this.tone,
        targetAudience:
            targetAudience != null ? targetAudience.value : this.targetAudience,
        keyFeatures: keyFeatures != null ? keyFeatures.value : this.keyFeatures,
        seoKeywords: seoKeywords != null ? seoKeywords.value : this.seoKeywords,
        qualityScore:
            qualityScore != null ? qualityScore.value : this.qualityScore,
        generatedAt: generatedAt != null ? generatedAt.value : this.generatedAt,
        isApproved: isApproved != null ? isApproved.value : this.isApproved,
        approvedBy: approvedBy != null ? approvedBy.value : this.approvedBy,
        approvedAt: approvedAt != null ? approvedAt.value : this.approvedAt,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        org: org != null ? org.value : this.org,
        property: property != null ? property.value : this.property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIPropertyDescription copyWithInstanceValues(
      AIPropertyDescription aIPropertyDescription) {
    return AIPropertyDescription(
        id: aIPropertyDescription.id ?? id,
        orgId: aIPropertyDescription.orgId ?? orgId,
        propertyId: aIPropertyDescription.propertyId ?? propertyId,
        generatedDescription:
            aIPropertyDescription.generatedDescription ?? generatedDescription,
        originalDescription:
            aIPropertyDescription.originalDescription ?? originalDescription,
        tone: aIPropertyDescription.tone ?? tone,
        targetAudience: aIPropertyDescription.targetAudience ?? targetAudience,
        keyFeatures: aIPropertyDescription.keyFeatures ?? keyFeatures,
        seoKeywords: aIPropertyDescription.seoKeywords ?? seoKeywords,
        qualityScore: aIPropertyDescription.qualityScore ?? qualityScore,
        generatedAt: aIPropertyDescription.generatedAt ?? generatedAt,
        isApproved: aIPropertyDescription.isApproved ?? isApproved,
        approvedBy: aIPropertyDescription.approvedBy ?? approvedBy,
        approvedAt: aIPropertyDescription.approvedAt ?? approvedAt,
        createdAt: aIPropertyDescription.createdAt ?? createdAt,
        updatedAt: aIPropertyDescription.updatedAt ?? updatedAt,
        org: aIPropertyDescription.org ?? org,
        property: aIPropertyDescription.property ?? property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIPropertyDescription mergeWithInstanceValues(
      AIPropertyDescription aIPropertyDescription) {
    return AIPropertyDescription(
        id: aIPropertyDescription.$assignedFields.contains('id')
            ? aIPropertyDescription.id
            : id,
        orgId: aIPropertyDescription.$assignedFields.contains('orgId')
            ? aIPropertyDescription.orgId
            : orgId,
        propertyId: aIPropertyDescription.$assignedFields.contains('propertyId')
            ? aIPropertyDescription.propertyId
            : propertyId,
        generatedDescription:
            aIPropertyDescription.$assignedFields.contains('generatedDescription')
                ? aIPropertyDescription.generatedDescription
                : generatedDescription,
        originalDescription:
            aIPropertyDescription.$assignedFields.contains('originalDescription')
                ? aIPropertyDescription.originalDescription
                : originalDescription,
        tone: aIPropertyDescription.$assignedFields.contains('tone')
            ? aIPropertyDescription.tone
            : tone,
        targetAudience: aIPropertyDescription.$assignedFields.contains('targetAudience')
            ? aIPropertyDescription.targetAudience
            : targetAudience,
        keyFeatures: aIPropertyDescription.$assignedFields.contains('keyFeatures')
            ? aIPropertyDescription.keyFeatures
            : keyFeatures,
        seoKeywords: aIPropertyDescription.$assignedFields.contains('seoKeywords')
            ? aIPropertyDescription.seoKeywords
            : seoKeywords,
        qualityScore: aIPropertyDescription.$assignedFields.contains('qualityScore')
            ? aIPropertyDescription.qualityScore
            : qualityScore,
        generatedAt: aIPropertyDescription.$assignedFields.contains('generatedAt')
            ? aIPropertyDescription.generatedAt
            : generatedAt,
        isApproved: aIPropertyDescription.$assignedFields.contains('isApproved')
            ? aIPropertyDescription.isApproved
            : isApproved,
        approvedBy: aIPropertyDescription.$assignedFields.contains('approvedBy')
            ? aIPropertyDescription.approvedBy
            : approvedBy,
        approvedAt: aIPropertyDescription.$assignedFields.contains('approvedAt') ? aIPropertyDescription.approvedAt : approvedAt,
        createdAt: aIPropertyDescription.$assignedFields.contains('createdAt') ? aIPropertyDescription.createdAt : createdAt,
        updatedAt: aIPropertyDescription.$assignedFields.contains('updatedAt') ? aIPropertyDescription.updatedAt : updatedAt,
        org: aIPropertyDescription.$assignedFields.contains('org') ? aIPropertyDescription.org : org,
        property: aIPropertyDescription.$assignedFields.contains('property') ? aIPropertyDescription.property : property);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIPropertyDescription updateWithInstanceValues(
      AIPropertyDescription aIPropertyDescription) {
    if (aIPropertyDescription.$assignedFields.contains('id')) {
      id = aIPropertyDescription.id;
    }
    if (aIPropertyDescription.$assignedFields.contains('orgId')) {
      orgId = aIPropertyDescription.orgId;
    }
    if (aIPropertyDescription.$assignedFields.contains('propertyId')) {
      propertyId = aIPropertyDescription.propertyId;
    }
    if (aIPropertyDescription.$assignedFields
        .contains('generatedDescription')) {
      generatedDescription = aIPropertyDescription.generatedDescription;
    }
    if (aIPropertyDescription.$assignedFields.contains('originalDescription')) {
      originalDescription = aIPropertyDescription.originalDescription;
    }
    if (aIPropertyDescription.$assignedFields.contains('tone')) {
      tone = aIPropertyDescription.tone;
    }
    if (aIPropertyDescription.$assignedFields.contains('targetAudience')) {
      targetAudience = aIPropertyDescription.targetAudience;
    }
    if (aIPropertyDescription.$assignedFields.contains('keyFeatures')) {
      keyFeatures = aIPropertyDescription.keyFeatures;
    }
    if (aIPropertyDescription.$assignedFields.contains('seoKeywords')) {
      seoKeywords = aIPropertyDescription.seoKeywords;
    }
    if (aIPropertyDescription.$assignedFields.contains('qualityScore')) {
      qualityScore = aIPropertyDescription.qualityScore;
    }
    if (aIPropertyDescription.$assignedFields.contains('generatedAt')) {
      generatedAt = aIPropertyDescription.generatedAt;
    }
    if (aIPropertyDescription.$assignedFields.contains('isApproved')) {
      isApproved = aIPropertyDescription.isApproved;
    }
    if (aIPropertyDescription.$assignedFields.contains('approvedBy')) {
      approvedBy = aIPropertyDescription.approvedBy;
    }
    if (aIPropertyDescription.$assignedFields.contains('approvedAt')) {
      approvedAt = aIPropertyDescription.approvedAt;
    }
    if (aIPropertyDescription.$assignedFields.contains('createdAt')) {
      createdAt = aIPropertyDescription.createdAt;
    }
    if (aIPropertyDescription.$assignedFields.contains('updatedAt')) {
      updatedAt = aIPropertyDescription.updatedAt;
    }
    if (aIPropertyDescription.$assignedFields.contains('org')) {
      org = aIPropertyDescription.org;
    }
    if (aIPropertyDescription.$assignedFields.contains('property')) {
      property = aIPropertyDescription.property;
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
        ? {...?serializedTypes, 'AIPropertyDescription'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (generatedDescription != null)
        'generatedDescription': generatedDescription,
      if (originalDescription != null)
        'originalDescription': originalDescription,
      if (tone != null) 'tone': tone,
      if (targetAudience != null) 'targetAudience': targetAudience,
      if (keyFeatures != null) 'keyFeatures': keyFeatures,
      if (seoKeywords != null) 'seoKeywords': seoKeywords,
      if (qualityScore != null) 'qualityScore': qualityScore,
      if (generatedAt != null) 'generatedAt': generatedAt?.toIso8601String(),
      if (isApproved != null) 'isApproved': isApproved,
      if (approvedBy != null) 'approvedBy': approvedBy,
      if (approvedAt != null) 'approvedAt': approvedAt?.toIso8601String(),
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
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
      other is AIPropertyDescription &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
