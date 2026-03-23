//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'ai_chat_message.dart';
import 'ai_chat_handoff.dart';

class AIChatbotSession
    implements PrismaModel<String, AIChatbotSession>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? userId;
  String? contactId;
  String? sessionId;
  dynamic conversationHistory;
  String? intent;
  double? confidence;
  String? status;
  String? transferredTo;
  DateTime? startedAt;
  DateTime? lastActivityAt;
  DateTime? endedAt;
  int? satisfaction;
  DateTime? createdAt;
  Organization? org;
  List<AIChatMessage>? messages;
  List<AIChatHandoff>? handoffs;
  int? $messagesCount;
  int? $handoffsCount;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIChatbotSession({
    this.id,
    this.orgId,
    this.userId,
    this.contactId,
    this.sessionId,
    required this.conversationHistory,
    this.intent,
    this.confidence,
    this.status = "ACTIVE",
    this.transferredTo,
    this.startedAt,
    this.lastActivityAt,
    this.endedAt,
    this.satisfaction,
    this.createdAt,
    this.org,
    this.messages,
    this.handoffs,
    this.$messagesCount,
    this.$handoffsCount,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIChatbotSession, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "userId": (m) => m.userId,
    "contactId": (m) => m.contactId,
    "sessionId": (m) => m.sessionId,
    "conversationHistory": (m) => m.conversationHistory,
    "intent": (m) => m.intent,
    "confidence": (m) => m.confidence,
    "status": (m) => m.status,
    "transferredTo": (m) => m.transferredTo,
    "startedAt": (m) => m.startedAt,
    "lastActivityAt": (m) => m.lastActivityAt,
    "endedAt": (m) => m.endedAt,
    "satisfaction": (m) => m.satisfaction,
    "createdAt": (m) => m.createdAt,
    "org": (m) => m.org,
    "messages": (m) => m.messages,
    "handoffs": (m) => m.handoffs,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIChatbotSession) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIChatbotSession');
    }
    return propFunction as V? Function(AIChatbotSession);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIChatbotSession.fromJson(JsonMap json) => AIChatbotSession(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        userId: json['userId'] as String?,
        contactId: json['contactId'] as String?,
        sessionId: json['sessionId'] as String?,
        conversationHistory: json['conversationHistory'] as dynamic,
        intent: json['intent'] as String?,
        confidence: json['confidence']?.toDouble(),
        status: json['status'] as String?,
        transferredTo: json['transferredTo'] as String?,
        startedAt: json['startedAt'] != null
            ? DateTime.parse(json['startedAt'])
            : null,
        lastActivityAt: json['lastActivityAt'] != null
            ? DateTime.parse(json['lastActivityAt'])
            : null,
        endedAt:
            json['endedAt'] != null ? DateTime.parse(json['endedAt']) : null,
        satisfaction: int.tryParse(json['satisfaction'].toString()),
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        messages: json['messages'] != null
            ? createModels<AIChatMessage>(
                (json['messages'] as List).cast<JsonMap>(),
                AIChatMessage.fromJson)
            : null,
        handoffs: json['handoffs'] != null
            ? createModels<AIChatHandoff>(
                (json['handoffs'] as List).cast<JsonMap>(),
                AIChatHandoff.fromJson)
            : null,
        $messagesCount: json['_count']?['messages'] as int?,
        $handoffsCount: json['_count']?['handoffs'] as int?,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIChatbotSession copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? userId,
    Value<String?>? contactId,
    Value<String?>? sessionId,
    Value<dynamic>? conversationHistory,
    Value<String?>? intent,
    Value<double?>? confidence,
    Value<String?>? status,
    Value<String?>? transferredTo,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? lastActivityAt,
    Value<DateTime?>? endedAt,
    Value<int?>? satisfaction,
    Value<DateTime?>? createdAt,
    Value<Organization?>? org,
    Value<List<AIChatMessage>?>? messages,
    Value<List<AIChatHandoff>?>? handoffs,
    int? $messagesCount,
    int? $handoffsCount,
  }) {
    return AIChatbotSession(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        userId: userId != null ? userId.value : this.userId,
        contactId: contactId != null ? contactId.value : this.contactId,
        sessionId: sessionId != null ? sessionId.value : this.sessionId,
        conversationHistory: conversationHistory != null
            ? conversationHistory.value
            : this.conversationHistory,
        intent: intent != null ? intent.value : this.intent,
        confidence: confidence != null ? confidence.value : this.confidence,
        status: status != null ? status.value : this.status,
        transferredTo:
            transferredTo != null ? transferredTo.value : this.transferredTo,
        startedAt: startedAt != null ? startedAt.value : this.startedAt,
        lastActivityAt:
            lastActivityAt != null ? lastActivityAt.value : this.lastActivityAt,
        endedAt: endedAt != null ? endedAt.value : this.endedAt,
        satisfaction:
            satisfaction != null ? satisfaction.value : this.satisfaction,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        org: org != null ? org.value : this.org,
        messages: messages != null ? messages.value : this.messages,
        handoffs: handoffs != null ? handoffs.value : this.handoffs,
        $messagesCount: $messagesCount ?? this.$messagesCount,
        $handoffsCount: $handoffsCount ?? this.$handoffsCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIChatbotSession copyWithInstanceValues(AIChatbotSession aIChatbotSession) {
    return AIChatbotSession(
        id: aIChatbotSession.id ?? id,
        orgId: aIChatbotSession.orgId ?? orgId,
        userId: aIChatbotSession.userId ?? userId,
        contactId: aIChatbotSession.contactId ?? contactId,
        sessionId: aIChatbotSession.sessionId ?? sessionId,
        conversationHistory:
            aIChatbotSession.conversationHistory ?? conversationHistory,
        intent: aIChatbotSession.intent ?? intent,
        confidence: aIChatbotSession.confidence ?? confidence,
        status: aIChatbotSession.status ?? status,
        transferredTo: aIChatbotSession.transferredTo ?? transferredTo,
        startedAt: aIChatbotSession.startedAt ?? startedAt,
        lastActivityAt: aIChatbotSession.lastActivityAt ?? lastActivityAt,
        endedAt: aIChatbotSession.endedAt ?? endedAt,
        satisfaction: aIChatbotSession.satisfaction ?? satisfaction,
        createdAt: aIChatbotSession.createdAt ?? createdAt,
        org: aIChatbotSession.org ?? org,
        messages: aIChatbotSession.messages ?? messages,
        handoffs: aIChatbotSession.handoffs ?? handoffs,
        $messagesCount: aIChatbotSession.$messagesCount ?? $messagesCount,
        $handoffsCount: aIChatbotSession.$handoffsCount ?? $handoffsCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIChatbotSession mergeWithInstanceValues(AIChatbotSession aIChatbotSession) {
    return AIChatbotSession(
        id: aIChatbotSession.$assignedFields.contains('id')
            ? aIChatbotSession.id
            : id,
        orgId: aIChatbotSession.$assignedFields.contains('orgId')
            ? aIChatbotSession.orgId
            : orgId,
        userId: aIChatbotSession.$assignedFields.contains('userId')
            ? aIChatbotSession.userId
            : userId,
        contactId: aIChatbotSession.$assignedFields.contains('contactId')
            ? aIChatbotSession.contactId
            : contactId,
        sessionId: aIChatbotSession.$assignedFields.contains('sessionId')
            ? aIChatbotSession.sessionId
            : sessionId,
        conversationHistory:
            aIChatbotSession.$assignedFields.contains('conversationHistory')
                ? aIChatbotSession.conversationHistory
                : conversationHistory,
        intent: aIChatbotSession.$assignedFields.contains('intent')
            ? aIChatbotSession.intent
            : intent,
        confidence: aIChatbotSession.$assignedFields.contains('confidence')
            ? aIChatbotSession.confidence
            : confidence,
        status: aIChatbotSession.$assignedFields.contains('status')
            ? aIChatbotSession.status
            : status,
        transferredTo:
            aIChatbotSession.$assignedFields.contains('transferredTo')
                ? aIChatbotSession.transferredTo
                : transferredTo,
        startedAt: aIChatbotSession.$assignedFields.contains('startedAt')
            ? aIChatbotSession.startedAt
            : startedAt,
        lastActivityAt:
            aIChatbotSession.$assignedFields.contains('lastActivityAt')
                ? aIChatbotSession.lastActivityAt
                : lastActivityAt,
        endedAt: aIChatbotSession.$assignedFields.contains('endedAt')
            ? aIChatbotSession.endedAt
            : endedAt,
        satisfaction: aIChatbotSession.$assignedFields.contains('satisfaction')
            ? aIChatbotSession.satisfaction
            : satisfaction,
        createdAt: aIChatbotSession.$assignedFields.contains('createdAt')
            ? aIChatbotSession.createdAt
            : createdAt,
        org: aIChatbotSession.$assignedFields.contains('org')
            ? aIChatbotSession.org
            : org,
        messages: (aIChatbotSession.$assignedFields.contains('messages') &&
                aIChatbotSession.messages != null)
            ? mergeModelLists(messages, aIChatbotSession.messages)
            : messages,
        handoffs: (aIChatbotSession.$assignedFields.contains('handoffs') &&
                aIChatbotSession.handoffs != null)
            ? mergeModelLists(handoffs, aIChatbotSession.handoffs)
            : handoffs,
        $messagesCount: aIChatbotSession.$messagesCount ?? $messagesCount,
        $handoffsCount: aIChatbotSession.$handoffsCount ?? $handoffsCount);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIChatbotSession updateWithInstanceValues(AIChatbotSession aIChatbotSession) {
    if (aIChatbotSession.$assignedFields.contains('id')) {
      id = aIChatbotSession.id;
    }
    if (aIChatbotSession.$assignedFields.contains('orgId')) {
      orgId = aIChatbotSession.orgId;
    }
    if (aIChatbotSession.$assignedFields.contains('userId')) {
      userId = aIChatbotSession.userId;
    }
    if (aIChatbotSession.$assignedFields.contains('contactId')) {
      contactId = aIChatbotSession.contactId;
    }
    if (aIChatbotSession.$assignedFields.contains('sessionId')) {
      sessionId = aIChatbotSession.sessionId;
    }
    if (aIChatbotSession.$assignedFields.contains('conversationHistory')) {
      conversationHistory = aIChatbotSession.conversationHistory;
    }
    if (aIChatbotSession.$assignedFields.contains('intent')) {
      intent = aIChatbotSession.intent;
    }
    if (aIChatbotSession.$assignedFields.contains('confidence')) {
      confidence = aIChatbotSession.confidence;
    }
    if (aIChatbotSession.$assignedFields.contains('status')) {
      status = aIChatbotSession.status;
    }
    if (aIChatbotSession.$assignedFields.contains('transferredTo')) {
      transferredTo = aIChatbotSession.transferredTo;
    }
    if (aIChatbotSession.$assignedFields.contains('startedAt')) {
      startedAt = aIChatbotSession.startedAt;
    }
    if (aIChatbotSession.$assignedFields.contains('lastActivityAt')) {
      lastActivityAt = aIChatbotSession.lastActivityAt;
    }
    if (aIChatbotSession.$assignedFields.contains('endedAt')) {
      endedAt = aIChatbotSession.endedAt;
    }
    if (aIChatbotSession.$assignedFields.contains('satisfaction')) {
      satisfaction = aIChatbotSession.satisfaction;
    }
    if (aIChatbotSession.$assignedFields.contains('createdAt')) {
      createdAt = aIChatbotSession.createdAt;
    }
    if (aIChatbotSession.$assignedFields.contains('org')) {
      org = aIChatbotSession.org;
    }
    if (aIChatbotSession.$assignedFields.contains('messages') &&
        aIChatbotSession.messages != null) {
      messages = mergeModelLists(messages, aIChatbotSession.messages);
    }
    if (aIChatbotSession.$assignedFields.contains('handoffs') &&
        aIChatbotSession.handoffs != null) {
      handoffs = mergeModelLists(handoffs, aIChatbotSession.handoffs);
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
        ? {...?serializedTypes, 'AIChatbotSession'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (userId != null) 'userId': userId,
      if (contactId != null) 'contactId': contactId,
      if (sessionId != null) 'sessionId': sessionId,
      if (conversationHistory != null)
        'conversationHistory': conversationHistory,
      if (intent != null) 'intent': intent,
      if (confidence != null) 'confidence': confidence,
      if (status != null) 'status': status,
      if (transferredTo != null) 'transferredTo': transferredTo,
      if (startedAt != null) 'startedAt': startedAt?.toIso8601String(),
      if (lastActivityAt != null)
        'lastActivityAt': lastActivityAt?.toIso8601String(),
      if (endedAt != null) 'endedAt': endedAt?.toIso8601String(),
      if (satisfaction != null) 'satisfaction': satisfaction,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (org != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'org': org?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (messages != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AIChatMessage')))
        'messages': messages
            ?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if (handoffs != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('AIChatHandoff')))
        'handoffs': handoffs
            ?.map((item) => item.toJson(
                serializedTypes: serializedModels,
                preventCircularSerialization: preventCircularSerialization))
            .toList(),
      if ($messagesCount != null || $handoffsCount != null)
        '_count': {
          if ($messagesCount != null) 'messages': $messagesCount,
          if ($handoffsCount != null) 'handoffs': $handoffsCount,
        },
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIChatbotSession &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
