//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';

class AISentimentAnalysis
    implements PrismaModel<String, AISentimentAnalysis>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? contentType;
  String? contentId;
  String? contentText;
  String? sentiment;
  double? sentimentScore;
  double? confidence;
  dynamic keyPhrases;
  dynamic emotions;
  DateTime? analyzedAt;
  DateTime? createdAt;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AISentimentAnalysis({
    this.id,
    this.orgId,
    this.contentType,
    this.contentId,
    this.contentText,
    this.sentiment,
    this.sentimentScore,
    this.confidence,
    required this.keyPhrases,
    required this.emotions,
    this.analyzedAt,
    this.createdAt,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AISentimentAnalysis, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "contentType": (m) => m.contentType,
    "contentId": (m) => m.contentId,
    "contentText": (m) => m.contentText,
    "sentiment": (m) => m.sentiment,
    "sentimentScore": (m) => m.sentimentScore,
    "confidence": (m) => m.confidence,
    "keyPhrases": (m) => m.keyPhrases,
    "emotions": (m) => m.emotions,
    "analyzedAt": (m) => m.analyzedAt,
    "createdAt": (m) => m.createdAt,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AISentimentAnalysis) getPropToValueFunction<V>(
      String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception(
          'Property "$propertyName" not found in AISentimentAnalysis');
    }
    return propFunction as V? Function(AISentimentAnalysis);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AISentimentAnalysis.fromJson(JsonMap json) => AISentimentAnalysis(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        contentType: json['contentType'] as String?,
        contentId: json['contentId'] as String?,
        contentText: json['contentText'] as String?,
        sentiment: json['sentiment'] as String?,
        sentimentScore: json['sentimentScore']?.toDouble(),
        confidence: json['confidence']?.toDouble(),
        keyPhrases: json['keyPhrases'] as dynamic,
        emotions: json['emotions'] as dynamic,
        analyzedAt: json['analyzedAt'] != null
            ? DateTime.parse(json['analyzedAt'])
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
  AISentimentAnalysis copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? contentType,
    Value<String?>? contentId,
    Value<String?>? contentText,
    Value<String?>? sentiment,
    Value<double?>? sentimentScore,
    Value<double?>? confidence,
    Value<dynamic>? keyPhrases,
    Value<dynamic>? emotions,
    Value<DateTime?>? analyzedAt,
    Value<DateTime?>? createdAt,
    Value<Organization?>? org,
  }) {
    return AISentimentAnalysis(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        contentType: contentType != null ? contentType.value : this.contentType,
        contentId: contentId != null ? contentId.value : this.contentId,
        contentText: contentText != null ? contentText.value : this.contentText,
        sentiment: sentiment != null ? sentiment.value : this.sentiment,
        sentimentScore:
            sentimentScore != null ? sentimentScore.value : this.sentimentScore,
        confidence: confidence != null ? confidence.value : this.confidence,
        keyPhrases: keyPhrases != null ? keyPhrases.value : this.keyPhrases,
        emotions: emotions != null ? emotions.value : this.emotions,
        analyzedAt: analyzedAt != null ? analyzedAt.value : this.analyzedAt,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AISentimentAnalysis copyWithInstanceValues(
      AISentimentAnalysis aISentimentAnalysis) {
    return AISentimentAnalysis(
        id: aISentimentAnalysis.id ?? id,
        orgId: aISentimentAnalysis.orgId ?? orgId,
        contentType: aISentimentAnalysis.contentType ?? contentType,
        contentId: aISentimentAnalysis.contentId ?? contentId,
        contentText: aISentimentAnalysis.contentText ?? contentText,
        sentiment: aISentimentAnalysis.sentiment ?? sentiment,
        sentimentScore: aISentimentAnalysis.sentimentScore ?? sentimentScore,
        confidence: aISentimentAnalysis.confidence ?? confidence,
        keyPhrases: aISentimentAnalysis.keyPhrases ?? keyPhrases,
        emotions: aISentimentAnalysis.emotions ?? emotions,
        analyzedAt: aISentimentAnalysis.analyzedAt ?? analyzedAt,
        createdAt: aISentimentAnalysis.createdAt ?? createdAt,
        org: aISentimentAnalysis.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AISentimentAnalysis mergeWithInstanceValues(
      AISentimentAnalysis aISentimentAnalysis) {
    return AISentimentAnalysis(
        id: aISentimentAnalysis.$assignedFields.contains('id')
            ? aISentimentAnalysis.id
            : id,
        orgId: aISentimentAnalysis.$assignedFields.contains('orgId')
            ? aISentimentAnalysis.orgId
            : orgId,
        contentType: aISentimentAnalysis.$assignedFields.contains('contentType')
            ? aISentimentAnalysis.contentType
            : contentType,
        contentId: aISentimentAnalysis.$assignedFields.contains('contentId')
            ? aISentimentAnalysis.contentId
            : contentId,
        contentText: aISentimentAnalysis.$assignedFields.contains('contentText')
            ? aISentimentAnalysis.contentText
            : contentText,
        sentiment: aISentimentAnalysis.$assignedFields.contains('sentiment')
            ? aISentimentAnalysis.sentiment
            : sentiment,
        sentimentScore:
            aISentimentAnalysis.$assignedFields.contains('sentimentScore')
                ? aISentimentAnalysis.sentimentScore
                : sentimentScore,
        confidence: aISentimentAnalysis.$assignedFields.contains('confidence')
            ? aISentimentAnalysis.confidence
            : confidence,
        keyPhrases: aISentimentAnalysis.$assignedFields.contains('keyPhrases')
            ? aISentimentAnalysis.keyPhrases
            : keyPhrases,
        emotions: aISentimentAnalysis.$assignedFields.contains('emotions')
            ? aISentimentAnalysis.emotions
            : emotions,
        analyzedAt: aISentimentAnalysis.$assignedFields.contains('analyzedAt')
            ? aISentimentAnalysis.analyzedAt
            : analyzedAt,
        createdAt: aISentimentAnalysis.$assignedFields.contains('createdAt')
            ? aISentimentAnalysis.createdAt
            : createdAt,
        org: aISentimentAnalysis.$assignedFields.contains('org')
            ? aISentimentAnalysis.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AISentimentAnalysis updateWithInstanceValues(
      AISentimentAnalysis aISentimentAnalysis) {
    if (aISentimentAnalysis.$assignedFields.contains('id')) {
      id = aISentimentAnalysis.id;
    }
    if (aISentimentAnalysis.$assignedFields.contains('orgId')) {
      orgId = aISentimentAnalysis.orgId;
    }
    if (aISentimentAnalysis.$assignedFields.contains('contentType')) {
      contentType = aISentimentAnalysis.contentType;
    }
    if (aISentimentAnalysis.$assignedFields.contains('contentId')) {
      contentId = aISentimentAnalysis.contentId;
    }
    if (aISentimentAnalysis.$assignedFields.contains('contentText')) {
      contentText = aISentimentAnalysis.contentText;
    }
    if (aISentimentAnalysis.$assignedFields.contains('sentiment')) {
      sentiment = aISentimentAnalysis.sentiment;
    }
    if (aISentimentAnalysis.$assignedFields.contains('sentimentScore')) {
      sentimentScore = aISentimentAnalysis.sentimentScore;
    }
    if (aISentimentAnalysis.$assignedFields.contains('confidence')) {
      confidence = aISentimentAnalysis.confidence;
    }
    if (aISentimentAnalysis.$assignedFields.contains('keyPhrases')) {
      keyPhrases = aISentimentAnalysis.keyPhrases;
    }
    if (aISentimentAnalysis.$assignedFields.contains('emotions')) {
      emotions = aISentimentAnalysis.emotions;
    }
    if (aISentimentAnalysis.$assignedFields.contains('analyzedAt')) {
      analyzedAt = aISentimentAnalysis.analyzedAt;
    }
    if (aISentimentAnalysis.$assignedFields.contains('createdAt')) {
      createdAt = aISentimentAnalysis.createdAt;
    }
    if (aISentimentAnalysis.$assignedFields.contains('org')) {
      org = aISentimentAnalysis.org;
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
        ? {...?serializedTypes, 'AISentimentAnalysis'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (contentType != null) 'contentType': contentType,
      if (contentId != null) 'contentId': contentId,
      if (contentText != null) 'contentText': contentText,
      if (sentiment != null) 'sentiment': sentiment,
      if (sentimentScore != null) 'sentimentScore': sentimentScore,
      if (confidence != null) 'confidence': confidence,
      if (keyPhrases != null) 'keyPhrases': keyPhrases,
      if (emotions != null) 'emotions': emotions,
      if (analyzedAt != null) 'analyzedAt': analyzedAt?.toIso8601String(),
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
      other is AISentimentAnalysis &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
