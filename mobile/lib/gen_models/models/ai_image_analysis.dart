//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property_photo.dart';
import 'property.dart';

class AIImageAnalysis
    implements PrismaModel<String, AIImageAnalysis>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? propertyId;
  String? photoId;
  String? analysisType;
  dynamic detectedRooms;
  double? qualityScore;
  dynamic styleTags;
  dynamic colorPalette;
  double? lightingQuality;
  dynamic recommendations;
  DateTime? analyzedAt;
  double? confidence;
  DateTime? createdAt;
  Organization? org;
  PropertyPhoto? photo;
  Property? property;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIImageAnalysis({
    this.id,
    this.orgId,
    this.propertyId,
    this.photoId,
    this.analysisType,
    required this.detectedRooms,
    this.qualityScore,
    required this.styleTags,
    required this.colorPalette,
    this.lightingQuality,
    required this.recommendations,
    this.analyzedAt,
    this.confidence,
    this.createdAt,
    this.org,
    this.photo,
    this.property,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIImageAnalysis, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "propertyId": (m) => m.propertyId,
    "photoId": (m) => m.photoId,
    "analysisType": (m) => m.analysisType,
    "detectedRooms": (m) => m.detectedRooms,
    "qualityScore": (m) => m.qualityScore,
    "styleTags": (m) => m.styleTags,
    "colorPalette": (m) => m.colorPalette,
    "lightingQuality": (m) => m.lightingQuality,
    "recommendations": (m) => m.recommendations,
    "analyzedAt": (m) => m.analyzedAt,
    "confidence": (m) => m.confidence,
    "createdAt": (m) => m.createdAt,
    "org": (m) => m.org,
    "photo": (m) => m.photo,
    "property": (m) => m.property,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIImageAnalysis) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIImageAnalysis');
    }
    return propFunction as V? Function(AIImageAnalysis);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIImageAnalysis.fromJson(JsonMap json) => AIImageAnalysis(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        propertyId: json['propertyId'] as String?,
        photoId: json['photoId'] as String?,
        analysisType: json['analysisType'] as String?,
        detectedRooms: json['detectedRooms'] as dynamic,
        qualityScore: json['qualityScore']?.toDouble(),
        styleTags: json['styleTags'] as dynamic,
        colorPalette: json['colorPalette'] as dynamic,
        lightingQuality: json['lightingQuality']?.toDouble(),
        recommendations: json['recommendations'] as dynamic,
        analyzedAt: json['analyzedAt'] != null
            ? DateTime.parse(json['analyzedAt'])
            : null,
        confidence: json['confidence']?.toDouble(),
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        photo: json['photo'] != null
            ? PropertyPhoto.fromJson(json['photo'] as JsonMap)
            : null,
        property: json['property'] != null
            ? Property.fromJson(json['property'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIImageAnalysis copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? propertyId,
    Value<String?>? photoId,
    Value<String?>? analysisType,
    Value<dynamic>? detectedRooms,
    Value<double?>? qualityScore,
    Value<dynamic>? styleTags,
    Value<dynamic>? colorPalette,
    Value<double?>? lightingQuality,
    Value<dynamic>? recommendations,
    Value<DateTime?>? analyzedAt,
    Value<double?>? confidence,
    Value<DateTime?>? createdAt,
    Value<Organization?>? org,
    Value<PropertyPhoto?>? photo,
    Value<Property?>? property,
  }) {
    return AIImageAnalysis(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        propertyId: propertyId != null ? propertyId.value : this.propertyId,
        photoId: photoId != null ? photoId.value : this.photoId,
        analysisType:
            analysisType != null ? analysisType.value : this.analysisType,
        detectedRooms:
            detectedRooms != null ? detectedRooms.value : this.detectedRooms,
        qualityScore:
            qualityScore != null ? qualityScore.value : this.qualityScore,
        styleTags: styleTags != null ? styleTags.value : this.styleTags,
        colorPalette:
            colorPalette != null ? colorPalette.value : this.colorPalette,
        lightingQuality: lightingQuality != null
            ? lightingQuality.value
            : this.lightingQuality,
        recommendations: recommendations != null
            ? recommendations.value
            : this.recommendations,
        analyzedAt: analyzedAt != null ? analyzedAt.value : this.analyzedAt,
        confidence: confidence != null ? confidence.value : this.confidence,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        org: org != null ? org.value : this.org,
        photo: photo != null ? photo.value : this.photo,
        property: property != null ? property.value : this.property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIImageAnalysis copyWithInstanceValues(AIImageAnalysis aIImageAnalysis) {
    return AIImageAnalysis(
        id: aIImageAnalysis.id ?? id,
        orgId: aIImageAnalysis.orgId ?? orgId,
        propertyId: aIImageAnalysis.propertyId ?? propertyId,
        photoId: aIImageAnalysis.photoId ?? photoId,
        analysisType: aIImageAnalysis.analysisType ?? analysisType,
        detectedRooms: aIImageAnalysis.detectedRooms ?? detectedRooms,
        qualityScore: aIImageAnalysis.qualityScore ?? qualityScore,
        styleTags: aIImageAnalysis.styleTags ?? styleTags,
        colorPalette: aIImageAnalysis.colorPalette ?? colorPalette,
        lightingQuality: aIImageAnalysis.lightingQuality ?? lightingQuality,
        recommendations: aIImageAnalysis.recommendations ?? recommendations,
        analyzedAt: aIImageAnalysis.analyzedAt ?? analyzedAt,
        confidence: aIImageAnalysis.confidence ?? confidence,
        createdAt: aIImageAnalysis.createdAt ?? createdAt,
        org: aIImageAnalysis.org ?? org,
        photo: aIImageAnalysis.photo ?? photo,
        property: aIImageAnalysis.property ?? property);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIImageAnalysis mergeWithInstanceValues(AIImageAnalysis aIImageAnalysis) {
    return AIImageAnalysis(
        id: aIImageAnalysis.$assignedFields.contains('id')
            ? aIImageAnalysis.id
            : id,
        orgId: aIImageAnalysis.$assignedFields.contains('orgId')
            ? aIImageAnalysis.orgId
            : orgId,
        propertyId: aIImageAnalysis.$assignedFields.contains('propertyId')
            ? aIImageAnalysis.propertyId
            : propertyId,
        photoId: aIImageAnalysis.$assignedFields.contains('photoId')
            ? aIImageAnalysis.photoId
            : photoId,
        analysisType: aIImageAnalysis.$assignedFields.contains('analysisType')
            ? aIImageAnalysis.analysisType
            : analysisType,
        detectedRooms: aIImageAnalysis.$assignedFields.contains('detectedRooms')
            ? aIImageAnalysis.detectedRooms
            : detectedRooms,
        qualityScore: aIImageAnalysis.$assignedFields.contains('qualityScore')
            ? aIImageAnalysis.qualityScore
            : qualityScore,
        styleTags: aIImageAnalysis.$assignedFields.contains('styleTags')
            ? aIImageAnalysis.styleTags
            : styleTags,
        colorPalette: aIImageAnalysis.$assignedFields.contains('colorPalette')
            ? aIImageAnalysis.colorPalette
            : colorPalette,
        lightingQuality:
            aIImageAnalysis.$assignedFields.contains('lightingQuality')
                ? aIImageAnalysis.lightingQuality
                : lightingQuality,
        recommendations:
            aIImageAnalysis.$assignedFields.contains('recommendations')
                ? aIImageAnalysis.recommendations
                : recommendations,
        analyzedAt: aIImageAnalysis.$assignedFields.contains('analyzedAt')
            ? aIImageAnalysis.analyzedAt
            : analyzedAt,
        confidence: aIImageAnalysis.$assignedFields.contains('confidence')
            ? aIImageAnalysis.confidence
            : confidence,
        createdAt: aIImageAnalysis.$assignedFields.contains('createdAt')
            ? aIImageAnalysis.createdAt
            : createdAt,
        org: aIImageAnalysis.$assignedFields.contains('org')
            ? aIImageAnalysis.org
            : org,
        photo: aIImageAnalysis.$assignedFields.contains('photo')
            ? aIImageAnalysis.photo
            : photo,
        property: aIImageAnalysis.$assignedFields.contains('property')
            ? aIImageAnalysis.property
            : property);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIImageAnalysis updateWithInstanceValues(AIImageAnalysis aIImageAnalysis) {
    if (aIImageAnalysis.$assignedFields.contains('id')) {
      id = aIImageAnalysis.id;
    }
    if (aIImageAnalysis.$assignedFields.contains('orgId')) {
      orgId = aIImageAnalysis.orgId;
    }
    if (aIImageAnalysis.$assignedFields.contains('propertyId')) {
      propertyId = aIImageAnalysis.propertyId;
    }
    if (aIImageAnalysis.$assignedFields.contains('photoId')) {
      photoId = aIImageAnalysis.photoId;
    }
    if (aIImageAnalysis.$assignedFields.contains('analysisType')) {
      analysisType = aIImageAnalysis.analysisType;
    }
    if (aIImageAnalysis.$assignedFields.contains('detectedRooms')) {
      detectedRooms = aIImageAnalysis.detectedRooms;
    }
    if (aIImageAnalysis.$assignedFields.contains('qualityScore')) {
      qualityScore = aIImageAnalysis.qualityScore;
    }
    if (aIImageAnalysis.$assignedFields.contains('styleTags')) {
      styleTags = aIImageAnalysis.styleTags;
    }
    if (aIImageAnalysis.$assignedFields.contains('colorPalette')) {
      colorPalette = aIImageAnalysis.colorPalette;
    }
    if (aIImageAnalysis.$assignedFields.contains('lightingQuality')) {
      lightingQuality = aIImageAnalysis.lightingQuality;
    }
    if (aIImageAnalysis.$assignedFields.contains('recommendations')) {
      recommendations = aIImageAnalysis.recommendations;
    }
    if (aIImageAnalysis.$assignedFields.contains('analyzedAt')) {
      analyzedAt = aIImageAnalysis.analyzedAt;
    }
    if (aIImageAnalysis.$assignedFields.contains('confidence')) {
      confidence = aIImageAnalysis.confidence;
    }
    if (aIImageAnalysis.$assignedFields.contains('createdAt')) {
      createdAt = aIImageAnalysis.createdAt;
    }
    if (aIImageAnalysis.$assignedFields.contains('org')) {
      org = aIImageAnalysis.org;
    }
    if (aIImageAnalysis.$assignedFields.contains('photo')) {
      photo = aIImageAnalysis.photo;
    }
    if (aIImageAnalysis.$assignedFields.contains('property')) {
      property = aIImageAnalysis.property;
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
        ? {...?serializedTypes, 'AIImageAnalysis'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (photoId != null) 'photoId': photoId,
      if (analysisType != null) 'analysisType': analysisType,
      if (detectedRooms != null) 'detectedRooms': detectedRooms,
      if (qualityScore != null) 'qualityScore': qualityScore,
      if (styleTags != null) 'styleTags': styleTags,
      if (colorPalette != null) 'colorPalette': colorPalette,
      if (lightingQuality != null) 'lightingQuality': lightingQuality,
      if (recommendations != null) 'recommendations': recommendations,
      if (analyzedAt != null) 'analyzedAt': analyzedAt?.toIso8601String(),
      if (confidence != null) 'confidence': confidence,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (org != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'org': org?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (photo != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('PropertyPhoto')))
        'photo': photo?.toJson(
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
      other is AIImageAnalysis &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
