//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'ai_chatbot_session.dart';
import 'organization.dart';

class AIChatHandoff implements PrismaModel<String, AIChatHandoff>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? sessionId;
  String? handoffReason;
  String? handoffTo;
  DateTime? handoffAt;
  DateTime? resolvedAt;
  String? resolvedBy;
  String? notes;
  DateTime? deletedAt;
  AIChatbotSession? session;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIChatHandoff({
    this.id,
    this.orgId,
    this.sessionId,
    this.handoffReason,
    this.handoffTo,
    this.handoffAt,
    this.resolvedAt,
    this.resolvedBy,
    this.notes,
    this.deletedAt,
    this.session,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIChatHandoff, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "sessionId": (m) => m.sessionId,
    "handoffReason": (m) => m.handoffReason,
    "handoffTo": (m) => m.handoffTo,
    "handoffAt": (m) => m.handoffAt,
    "resolvedAt": (m) => m.resolvedAt,
    "resolvedBy": (m) => m.resolvedBy,
    "notes": (m) => m.notes,
    "deletedAt": (m) => m.deletedAt,
    "session": (m) => m.session,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIChatHandoff) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIChatHandoff');
    }
    return propFunction as V? Function(AIChatHandoff);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIChatHandoff.fromJson(JsonMap json) => AIChatHandoff(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        sessionId: json['sessionId'] as String?,
        handoffReason: json['handoffReason'] as String?,
        handoffTo: json['handoffTo'] as String?,
        handoffAt: json['handoffAt'] != null
            ? DateTime.parse(json['handoffAt'])
            : null,
        resolvedAt: json['resolvedAt'] != null
            ? DateTime.parse(json['resolvedAt'])
            : null,
        resolvedBy: json['resolvedBy'] as String?,
        notes: json['notes'] as String?,
        deletedAt: json['deletedAt'] != null
            ? DateTime.parse(json['deletedAt'])
            : null,
        session: json['session'] != null
            ? AIChatbotSession.fromJson(json['session'] as JsonMap)
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIChatHandoff copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? sessionId,
    Value<String?>? handoffReason,
    Value<String?>? handoffTo,
    Value<DateTime?>? handoffAt,
    Value<DateTime?>? resolvedAt,
    Value<String?>? resolvedBy,
    Value<String?>? notes,
    Value<DateTime?>? deletedAt,
    Value<AIChatbotSession?>? session,
    Value<Organization?>? org,
  }) {
    return AIChatHandoff(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        sessionId: sessionId != null ? sessionId.value : this.sessionId,
        handoffReason:
            handoffReason != null ? handoffReason.value : this.handoffReason,
        handoffTo: handoffTo != null ? handoffTo.value : this.handoffTo,
        handoffAt: handoffAt != null ? handoffAt.value : this.handoffAt,
        resolvedAt: resolvedAt != null ? resolvedAt.value : this.resolvedAt,
        resolvedBy: resolvedBy != null ? resolvedBy.value : this.resolvedBy,
        notes: notes != null ? notes.value : this.notes,
        deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
        session: session != null ? session.value : this.session,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIChatHandoff copyWithInstanceValues(AIChatHandoff aIChatHandoff) {
    return AIChatHandoff(
        id: aIChatHandoff.id ?? id,
        orgId: aIChatHandoff.orgId ?? orgId,
        sessionId: aIChatHandoff.sessionId ?? sessionId,
        handoffReason: aIChatHandoff.handoffReason ?? handoffReason,
        handoffTo: aIChatHandoff.handoffTo ?? handoffTo,
        handoffAt: aIChatHandoff.handoffAt ?? handoffAt,
        resolvedAt: aIChatHandoff.resolvedAt ?? resolvedAt,
        resolvedBy: aIChatHandoff.resolvedBy ?? resolvedBy,
        notes: aIChatHandoff.notes ?? notes,
        deletedAt: aIChatHandoff.deletedAt ?? deletedAt,
        session: aIChatHandoff.session ?? session,
        org: aIChatHandoff.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIChatHandoff mergeWithInstanceValues(AIChatHandoff aIChatHandoff) {
    return AIChatHandoff(
        id: aIChatHandoff.$assignedFields.contains('id')
            ? aIChatHandoff.id
            : id,
        orgId: aIChatHandoff.$assignedFields.contains('orgId')
            ? aIChatHandoff.orgId
            : orgId,
        sessionId: aIChatHandoff.$assignedFields.contains('sessionId')
            ? aIChatHandoff.sessionId
            : sessionId,
        handoffReason: aIChatHandoff.$assignedFields.contains('handoffReason')
            ? aIChatHandoff.handoffReason
            : handoffReason,
        handoffTo: aIChatHandoff.$assignedFields.contains('handoffTo')
            ? aIChatHandoff.handoffTo
            : handoffTo,
        handoffAt: aIChatHandoff.$assignedFields.contains('handoffAt')
            ? aIChatHandoff.handoffAt
            : handoffAt,
        resolvedAt: aIChatHandoff.$assignedFields.contains('resolvedAt')
            ? aIChatHandoff.resolvedAt
            : resolvedAt,
        resolvedBy: aIChatHandoff.$assignedFields.contains('resolvedBy')
            ? aIChatHandoff.resolvedBy
            : resolvedBy,
        notes: aIChatHandoff.$assignedFields.contains('notes')
            ? aIChatHandoff.notes
            : notes,
        deletedAt: aIChatHandoff.$assignedFields.contains('deletedAt')
            ? aIChatHandoff.deletedAt
            : deletedAt,
        session: aIChatHandoff.$assignedFields.contains('session')
            ? aIChatHandoff.session
            : session,
        org: aIChatHandoff.$assignedFields.contains('org')
            ? aIChatHandoff.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIChatHandoff updateWithInstanceValues(AIChatHandoff aIChatHandoff) {
    if (aIChatHandoff.$assignedFields.contains('id')) {
      id = aIChatHandoff.id;
    }
    if (aIChatHandoff.$assignedFields.contains('orgId')) {
      orgId = aIChatHandoff.orgId;
    }
    if (aIChatHandoff.$assignedFields.contains('sessionId')) {
      sessionId = aIChatHandoff.sessionId;
    }
    if (aIChatHandoff.$assignedFields.contains('handoffReason')) {
      handoffReason = aIChatHandoff.handoffReason;
    }
    if (aIChatHandoff.$assignedFields.contains('handoffTo')) {
      handoffTo = aIChatHandoff.handoffTo;
    }
    if (aIChatHandoff.$assignedFields.contains('handoffAt')) {
      handoffAt = aIChatHandoff.handoffAt;
    }
    if (aIChatHandoff.$assignedFields.contains('resolvedAt')) {
      resolvedAt = aIChatHandoff.resolvedAt;
    }
    if (aIChatHandoff.$assignedFields.contains('resolvedBy')) {
      resolvedBy = aIChatHandoff.resolvedBy;
    }
    if (aIChatHandoff.$assignedFields.contains('notes')) {
      notes = aIChatHandoff.notes;
    }
    if (aIChatHandoff.$assignedFields.contains('deletedAt')) {
      deletedAt = aIChatHandoff.deletedAt;
    }
    if (aIChatHandoff.$assignedFields.contains('session')) {
      session = aIChatHandoff.session;
    }
    if (aIChatHandoff.$assignedFields.contains('org')) {
      org = aIChatHandoff.org;
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
        ? {...?serializedTypes, 'AIChatHandoff'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (sessionId != null) 'sessionId': sessionId,
      if (handoffReason != null) 'handoffReason': handoffReason,
      if (handoffTo != null) 'handoffTo': handoffTo,
      if (handoffAt != null) 'handoffAt': handoffAt?.toIso8601String(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toIso8601String(),
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      if (notes != null) 'notes': notes,
      if (deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
      if (session != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AIChatbotSession')))
        'session': session?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
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
      other is AIChatHandoff &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
