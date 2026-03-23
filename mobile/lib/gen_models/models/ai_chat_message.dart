//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'ai_chat_role.dart';
import 'ai_chat_module_type.dart';
import 'ai_chatbot_session.dart';
import 'organization.dart';
import 'listing.dart';
import 'reservation.dart';

class AIChatMessage implements PrismaModel<String, AIChatMessage>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? sessionId;
  String? listingId;
  String? reservationId;
  AIChatRole? role;
  String? content;
  String? contentHash;
  String? redactedContent;
  bool? piiDetected;
  List<String>? piiTypes;
  String? language;
  bool? isAI;
  String? escalationTag;
  String? escalationTopic;
  bool? paymentAgreed;
  dynamic paymentPlan;
  bool? securityFlag;
  String? securityReason;
  AIChatModuleType? moduleType;
  dynamic metadata;
  int? tokenCount;
  int? processingMs;
  DateTime? createdAt;
  AIChatbotSession? session;
  Organization? org;
  Listing? listing;
  Reservation? reservation;
  int? $piiTypesCount;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIChatMessage({
    this.id,
    this.orgId,
    this.sessionId,
    this.listingId,
    this.reservationId,
    this.role,
    this.content,
    this.contentHash,
    this.redactedContent,
    this.piiDetected = false,
    this.piiTypes,
    this.language = "en",
    this.isAI = false,
    this.escalationTag,
    this.escalationTopic,
    this.paymentAgreed = false,
    required this.paymentPlan,
    this.securityFlag = false,
    this.securityReason,
    this.moduleType,
    required this.metadata,
    this.tokenCount,
    this.processingMs,
    this.createdAt,
    this.session,
    this.org,
    this.listing,
    this.reservation,
    this.$piiTypesCount,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIChatMessage, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "sessionId": (m) => m.sessionId,
    "listingId": (m) => m.listingId,
    "reservationId": (m) => m.reservationId,
    "role": (m) => m.role,
    "content": (m) => m.content,
    "contentHash": (m) => m.contentHash,
    "redactedContent": (m) => m.redactedContent,
    "piiDetected": (m) => m.piiDetected,
    "piiTypes": (m) => m.piiTypes,
    "language": (m) => m.language,
    "isAI": (m) => m.isAI,
    "escalationTag": (m) => m.escalationTag,
    "escalationTopic": (m) => m.escalationTopic,
    "paymentAgreed": (m) => m.paymentAgreed,
    "paymentPlan": (m) => m.paymentPlan,
    "securityFlag": (m) => m.securityFlag,
    "securityReason": (m) => m.securityReason,
    "moduleType": (m) => m.moduleType,
    "metadata": (m) => m.metadata,
    "tokenCount": (m) => m.tokenCount,
    "processingMs": (m) => m.processingMs,
    "createdAt": (m) => m.createdAt,
    "session": (m) => m.session,
    "org": (m) => m.org,
    "listing": (m) => m.listing,
    "reservation": (m) => m.reservation,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIChatMessage) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AIChatMessage');
    }
    return propFunction as V? Function(AIChatMessage);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIChatMessage.fromJson(JsonMap json) => AIChatMessage(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        sessionId: json['sessionId'] as String?,
        listingId: json['listingId'] as String?,
        reservationId: json['reservationId'] as String?,
        role: json['role'] != null ? AIChatRole.fromJson(json['role']) : null,
        content: json['content'] as String?,
        contentHash: json['contentHash'] as String?,
        redactedContent: json['redactedContent'] as String?,
        piiDetected: json['piiDetected'] as bool?,
        piiTypes: json['piiTypes'] != null
            ? (json['piiTypes'] as List<dynamic>)
                .map((e) => e.toString())
                .toList()
            : null,
        language: json['language'] as String?,
        isAI: json['isAI'] as bool?,
        escalationTag: json['escalationTag'] as String?,
        escalationTopic: json['escalationTopic'] as String?,
        paymentAgreed: json['paymentAgreed'] as bool?,
        paymentPlan: json['paymentPlan'] as dynamic,
        securityFlag: json['securityFlag'] as bool?,
        securityReason: json['securityReason'] as String?,
        moduleType: json['moduleType'] != null
            ? AIChatModuleType.fromJson(json['moduleType'])
            : null,
        metadata: json['metadata'] as dynamic,
        tokenCount: int.tryParse(json['tokenCount'].toString()),
        processingMs: int.tryParse(json['processingMs'].toString()),
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        session: json['session'] != null
            ? AIChatbotSession.fromJson(json['session'] as JsonMap)
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        listing: json['listing'] != null
            ? Listing.fromJson(json['listing'] as JsonMap)
            : null,
        reservation: json['reservation'] != null
            ? Reservation.fromJson(json['reservation'] as JsonMap)
            : null,
        $piiTypesCount: json['_count']?['piiTypes'] as int?,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIChatMessage copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? sessionId,
    Value<String?>? listingId,
    Value<String?>? reservationId,
    Value<AIChatRole?>? role,
    Value<String?>? content,
    Value<String?>? contentHash,
    Value<String?>? redactedContent,
    Value<bool?>? piiDetected,
    Value<List<String>?>? piiTypes,
    Value<String?>? language,
    Value<bool?>? isAI,
    Value<String?>? escalationTag,
    Value<String?>? escalationTopic,
    Value<bool?>? paymentAgreed,
    Value<dynamic>? paymentPlan,
    Value<bool?>? securityFlag,
    Value<String?>? securityReason,
    Value<AIChatModuleType?>? moduleType,
    Value<dynamic>? metadata,
    Value<int?>? tokenCount,
    Value<int?>? processingMs,
    Value<DateTime?>? createdAt,
    Value<AIChatbotSession?>? session,
    Value<Organization?>? org,
    Value<Listing?>? listing,
    Value<Reservation?>? reservation,
    int? $piiTypesCount,
  }) {
    return AIChatMessage(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        sessionId: sessionId != null ? sessionId.value : this.sessionId,
        listingId: listingId != null ? listingId.value : this.listingId,
        reservationId:
            reservationId != null ? reservationId.value : this.reservationId,
        role: role != null ? role.value : this.role,
        content: content != null ? content.value : this.content,
        contentHash: contentHash != null ? contentHash.value : this.contentHash,
        redactedContent: redactedContent != null
            ? redactedContent.value
            : this.redactedContent,
        piiDetected: piiDetected != null ? piiDetected.value : this.piiDetected,
        piiTypes: piiTypes != null ? piiTypes.value : this.piiTypes,
        language: language != null ? language.value : this.language,
        isAI: isAI != null ? isAI.value : this.isAI,
        escalationTag:
            escalationTag != null ? escalationTag.value : this.escalationTag,
        escalationTopic: escalationTopic != null
            ? escalationTopic.value
            : this.escalationTopic,
        paymentAgreed:
            paymentAgreed != null ? paymentAgreed.value : this.paymentAgreed,
        paymentPlan: paymentPlan != null ? paymentPlan.value : this.paymentPlan,
        securityFlag:
            securityFlag != null ? securityFlag.value : this.securityFlag,
        securityReason:
            securityReason != null ? securityReason.value : this.securityReason,
        moduleType: moduleType != null ? moduleType.value : this.moduleType,
        metadata: metadata != null ? metadata.value : this.metadata,
        tokenCount: tokenCount != null ? tokenCount.value : this.tokenCount,
        processingMs:
            processingMs != null ? processingMs.value : this.processingMs,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        session: session != null ? session.value : this.session,
        org: org != null ? org.value : this.org,
        listing: listing != null ? listing.value : this.listing,
        reservation: reservation != null ? reservation.value : this.reservation,
        $piiTypesCount: $piiTypesCount ?? this.$piiTypesCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIChatMessage copyWithInstanceValues(AIChatMessage aIChatMessage) {
    return AIChatMessage(
        id: aIChatMessage.id ?? id,
        orgId: aIChatMessage.orgId ?? orgId,
        sessionId: aIChatMessage.sessionId ?? sessionId,
        listingId: aIChatMessage.listingId ?? listingId,
        reservationId: aIChatMessage.reservationId ?? reservationId,
        role: aIChatMessage.role ?? role,
        content: aIChatMessage.content ?? content,
        contentHash: aIChatMessage.contentHash ?? contentHash,
        redactedContent: aIChatMessage.redactedContent ?? redactedContent,
        piiDetected: aIChatMessage.piiDetected ?? piiDetected,
        piiTypes: aIChatMessage.piiTypes ?? piiTypes,
        language: aIChatMessage.language ?? language,
        isAI: aIChatMessage.isAI ?? isAI,
        escalationTag: aIChatMessage.escalationTag ?? escalationTag,
        escalationTopic: aIChatMessage.escalationTopic ?? escalationTopic,
        paymentAgreed: aIChatMessage.paymentAgreed ?? paymentAgreed,
        paymentPlan: aIChatMessage.paymentPlan ?? paymentPlan,
        securityFlag: aIChatMessage.securityFlag ?? securityFlag,
        securityReason: aIChatMessage.securityReason ?? securityReason,
        moduleType: aIChatMessage.moduleType ?? moduleType,
        metadata: aIChatMessage.metadata ?? metadata,
        tokenCount: aIChatMessage.tokenCount ?? tokenCount,
        processingMs: aIChatMessage.processingMs ?? processingMs,
        createdAt: aIChatMessage.createdAt ?? createdAt,
        session: aIChatMessage.session ?? session,
        org: aIChatMessage.org ?? org,
        listing: aIChatMessage.listing ?? listing,
        reservation: aIChatMessage.reservation ?? reservation,
        $piiTypesCount: aIChatMessage.$piiTypesCount ?? $piiTypesCount);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIChatMessage mergeWithInstanceValues(AIChatMessage aIChatMessage) {
    return AIChatMessage(
        id: aIChatMessage.$assignedFields.contains('id')
            ? aIChatMessage.id
            : id,
        orgId: aIChatMessage.$assignedFields.contains('orgId')
            ? aIChatMessage.orgId
            : orgId,
        sessionId: aIChatMessage.$assignedFields.contains('sessionId')
            ? aIChatMessage.sessionId
            : sessionId,
        listingId: aIChatMessage.$assignedFields.contains('listingId')
            ? aIChatMessage.listingId
            : listingId,
        reservationId: aIChatMessage.$assignedFields.contains('reservationId')
            ? aIChatMessage.reservationId
            : reservationId,
        role: aIChatMessage.$assignedFields.contains('role')
            ? aIChatMessage.role
            : role,
        content: aIChatMessage.$assignedFields.contains('content')
            ? aIChatMessage.content
            : content,
        contentHash: aIChatMessage.$assignedFields.contains('contentHash')
            ? aIChatMessage.contentHash
            : contentHash,
        redactedContent:
            aIChatMessage.$assignedFields.contains('redactedContent')
                ? aIChatMessage.redactedContent
                : redactedContent,
        piiDetected: aIChatMessage.$assignedFields.contains('piiDetected')
            ? aIChatMessage.piiDetected
            : piiDetected,
        piiTypes: aIChatMessage.$assignedFields.contains('piiTypes')
            ? aIChatMessage.piiTypes
            : piiTypes,
        language: aIChatMessage.$assignedFields.contains('language')
            ? aIChatMessage.language
            : language,
        isAI: aIChatMessage.$assignedFields.contains('isAI')
            ? aIChatMessage.isAI
            : isAI,
        escalationTag: aIChatMessage.$assignedFields.contains('escalationTag')
            ? aIChatMessage.escalationTag
            : escalationTag,
        escalationTopic:
            aIChatMessage.$assignedFields.contains('escalationTopic')
                ? aIChatMessage.escalationTopic
                : escalationTopic,
        paymentAgreed: aIChatMessage.$assignedFields.contains('paymentAgreed')
            ? aIChatMessage.paymentAgreed
            : paymentAgreed,
        paymentPlan: aIChatMessage.$assignedFields.contains('paymentPlan')
            ? aIChatMessage.paymentPlan
            : paymentPlan,
        securityFlag: aIChatMessage.$assignedFields.contains('securityFlag')
            ? aIChatMessage.securityFlag
            : securityFlag,
        securityReason: aIChatMessage.$assignedFields.contains('securityReason')
            ? aIChatMessage.securityReason
            : securityReason,
        moduleType: aIChatMessage.$assignedFields.contains('moduleType')
            ? aIChatMessage.moduleType
            : moduleType,
        metadata: aIChatMessage.$assignedFields.contains('metadata')
            ? aIChatMessage.metadata
            : metadata,
        tokenCount: aIChatMessage.$assignedFields.contains('tokenCount')
            ? aIChatMessage.tokenCount
            : tokenCount,
        processingMs: aIChatMessage.$assignedFields.contains('processingMs')
            ? aIChatMessage.processingMs
            : processingMs,
        createdAt: aIChatMessage.$assignedFields.contains('createdAt')
            ? aIChatMessage.createdAt
            : createdAt,
        session: aIChatMessage.$assignedFields.contains('session')
            ? aIChatMessage.session
            : session,
        org: aIChatMessage.$assignedFields.contains('org')
            ? aIChatMessage.org
            : org,
        listing: aIChatMessage.$assignedFields.contains('listing')
            ? aIChatMessage.listing
            : listing,
        reservation: aIChatMessage.$assignedFields.contains('reservation')
            ? aIChatMessage.reservation
            : reservation,
        $piiTypesCount: aIChatMessage.$piiTypesCount ?? $piiTypesCount);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIChatMessage updateWithInstanceValues(AIChatMessage aIChatMessage) {
    if (aIChatMessage.$assignedFields.contains('id')) {
      id = aIChatMessage.id;
    }
    if (aIChatMessage.$assignedFields.contains('orgId')) {
      orgId = aIChatMessage.orgId;
    }
    if (aIChatMessage.$assignedFields.contains('sessionId')) {
      sessionId = aIChatMessage.sessionId;
    }
    if (aIChatMessage.$assignedFields.contains('listingId')) {
      listingId = aIChatMessage.listingId;
    }
    if (aIChatMessage.$assignedFields.contains('reservationId')) {
      reservationId = aIChatMessage.reservationId;
    }
    if (aIChatMessage.$assignedFields.contains('role')) {
      role = aIChatMessage.role;
    }
    if (aIChatMessage.$assignedFields.contains('content')) {
      content = aIChatMessage.content;
    }
    if (aIChatMessage.$assignedFields.contains('contentHash')) {
      contentHash = aIChatMessage.contentHash;
    }
    if (aIChatMessage.$assignedFields.contains('redactedContent')) {
      redactedContent = aIChatMessage.redactedContent;
    }
    if (aIChatMessage.$assignedFields.contains('piiDetected')) {
      piiDetected = aIChatMessage.piiDetected;
    }
    if (aIChatMessage.$assignedFields.contains('piiTypes')) {
      piiTypes = aIChatMessage.piiTypes;
    }
    if (aIChatMessage.$assignedFields.contains('language')) {
      language = aIChatMessage.language;
    }
    if (aIChatMessage.$assignedFields.contains('isAI')) {
      isAI = aIChatMessage.isAI;
    }
    if (aIChatMessage.$assignedFields.contains('escalationTag')) {
      escalationTag = aIChatMessage.escalationTag;
    }
    if (aIChatMessage.$assignedFields.contains('escalationTopic')) {
      escalationTopic = aIChatMessage.escalationTopic;
    }
    if (aIChatMessage.$assignedFields.contains('paymentAgreed')) {
      paymentAgreed = aIChatMessage.paymentAgreed;
    }
    if (aIChatMessage.$assignedFields.contains('paymentPlan')) {
      paymentPlan = aIChatMessage.paymentPlan;
    }
    if (aIChatMessage.$assignedFields.contains('securityFlag')) {
      securityFlag = aIChatMessage.securityFlag;
    }
    if (aIChatMessage.$assignedFields.contains('securityReason')) {
      securityReason = aIChatMessage.securityReason;
    }
    if (aIChatMessage.$assignedFields.contains('moduleType')) {
      moduleType = aIChatMessage.moduleType;
    }
    if (aIChatMessage.$assignedFields.contains('metadata')) {
      metadata = aIChatMessage.metadata;
    }
    if (aIChatMessage.$assignedFields.contains('tokenCount')) {
      tokenCount = aIChatMessage.tokenCount;
    }
    if (aIChatMessage.$assignedFields.contains('processingMs')) {
      processingMs = aIChatMessage.processingMs;
    }
    if (aIChatMessage.$assignedFields.contains('createdAt')) {
      createdAt = aIChatMessage.createdAt;
    }
    if (aIChatMessage.$assignedFields.contains('session')) {
      session = aIChatMessage.session;
    }
    if (aIChatMessage.$assignedFields.contains('org')) {
      org = aIChatMessage.org;
    }
    if (aIChatMessage.$assignedFields.contains('listing')) {
      listing = aIChatMessage.listing;
    }
    if (aIChatMessage.$assignedFields.contains('reservation')) {
      reservation = aIChatMessage.reservation;
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
        ? {...?serializedTypes, 'AIChatMessage'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (sessionId != null) 'sessionId': sessionId,
      if (listingId != null) 'listingId': listingId,
      if (reservationId != null) 'reservationId': reservationId,
      if (role != null) 'role': role?.toJson(),
      if (content != null) 'content': content,
      if (contentHash != null) 'contentHash': contentHash,
      if (redactedContent != null) 'redactedContent': redactedContent,
      if (piiDetected != null) 'piiDetected': piiDetected,
      if (piiTypes != null) 'piiTypes': piiTypes,
      if (language != null) 'language': language,
      if (isAI != null) 'isAI': isAI,
      if (escalationTag != null) 'escalationTag': escalationTag,
      if (escalationTopic != null) 'escalationTopic': escalationTopic,
      if (paymentAgreed != null) 'paymentAgreed': paymentAgreed,
      if (paymentPlan != null) 'paymentPlan': paymentPlan,
      if (securityFlag != null) 'securityFlag': securityFlag,
      if (securityReason != null) 'securityReason': securityReason,
      if (moduleType != null) 'moduleType': moduleType?.toJson(),
      if (metadata != null) 'metadata': metadata,
      if (tokenCount != null) 'tokenCount': tokenCount,
      if (processingMs != null) 'processingMs': processingMs,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
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
            preventCircularSerialization: preventCircularSerialization),
      if (listing != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Listing')))
        'listing': listing?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (reservation != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Reservation')))
        'reservation': reservation?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if ($piiTypesCount != null)
        '_count': {
          if ($piiTypesCount != null) 'piiTypes': $piiTypesCount,
        },
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIChatMessage &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
