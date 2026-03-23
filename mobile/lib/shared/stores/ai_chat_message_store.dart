
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIChatMessageStore extends ModelStreamStore<String, AIChatMessage> {

  static AIChatMessageStore? _instance;

  static AIChatMessageStore get instance {
    _instance ??= AIChatMessageStore();
    return _instance!;
  }

  AIChatMessageStore() : super(AIChatMessage.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIChatMessageStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIChatMessageStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIChatMessageStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIChatMessageId(AIChatMessage aIChatMessage) => aIChatMessage.id;

	String? getAIChatMessageOrgId(AIChatMessage aIChatMessage) => aIChatMessage.orgId;

	String? getAIChatMessageSessionId(AIChatMessage aIChatMessage) => aIChatMessage.sessionId;

	String? getAIChatMessageListingId(AIChatMessage aIChatMessage) => aIChatMessage.listingId;

	String? getAIChatMessageReservationId(AIChatMessage aIChatMessage) => aIChatMessage.reservationId;

	AIChatRole? getAIChatMessageRole(AIChatMessage aIChatMessage) => aIChatMessage.role;

	String? getAIChatMessageContent(AIChatMessage aIChatMessage) => aIChatMessage.content;

	String? getAIChatMessageContentHash(AIChatMessage aIChatMessage) => aIChatMessage.contentHash;

	String? getAIChatMessageRedactedContent(AIChatMessage aIChatMessage) => aIChatMessage.redactedContent;

	bool? getAIChatMessagePiiDetected(AIChatMessage aIChatMessage) => aIChatMessage.piiDetected;

	List<String>? getAIChatMessagePiiTypes(AIChatMessage aIChatMessage) => aIChatMessage.piiTypes;

	String? getAIChatMessageLanguage(AIChatMessage aIChatMessage) => aIChatMessage.language;

	bool? getAIChatMessageIsAI(AIChatMessage aIChatMessage) => aIChatMessage.isAI;

	String? getAIChatMessageEscalationTag(AIChatMessage aIChatMessage) => aIChatMessage.escalationTag;

	String? getAIChatMessageEscalationTopic(AIChatMessage aIChatMessage) => aIChatMessage.escalationTopic;

	bool? getAIChatMessagePaymentAgreed(AIChatMessage aIChatMessage) => aIChatMessage.paymentAgreed;

	dynamic? getAIChatMessagePaymentPlan(AIChatMessage aIChatMessage) => aIChatMessage.paymentPlan;

	bool? getAIChatMessageSecurityFlag(AIChatMessage aIChatMessage) => aIChatMessage.securityFlag;

	String? getAIChatMessageSecurityReason(AIChatMessage aIChatMessage) => aIChatMessage.securityReason;

	AIChatModuleType? getAIChatMessageModuleType(AIChatMessage aIChatMessage) => aIChatMessage.moduleType;

	dynamic? getAIChatMessageMetadata(AIChatMessage aIChatMessage) => aIChatMessage.metadata;

	int? getAIChatMessageTokenCount(AIChatMessage aIChatMessage) => aIChatMessage.tokenCount;

	int? getAIChatMessageProcessingMs(AIChatMessage aIChatMessage) => aIChatMessage.processingMs;

	DateTime? getAIChatMessageCreatedAt(AIChatMessage aIChatMessage) => aIChatMessage.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIChatMessage> getByOrgId(
    String orgId,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getBySessionId(
    String sessionId,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageSessionId, sessionId, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByListingId(
    String listingId,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByReservationId(
    String reservationId,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByRole(
    AIChatRole role,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageRole, role, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByContent(
    String content,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageContent, content, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByContentHash(
    String contentHash,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageContentHash, contentHash, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByRedactedContent(
    String redactedContent,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageRedactedContent, redactedContent, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByPiiDetected(
    bool piiDetected,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessagePiiDetected, piiDetected, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByPiiTypes(
    String piiTypes,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessagePiiTypes, piiTypes, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByLanguage(
    String language,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageLanguage, language, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByIsAI(
    bool isAI,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageIsAI, isAI, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByEscalationTag(
    String escalationTag,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageEscalationTag, escalationTag, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByEscalationTopic(
    String escalationTopic,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageEscalationTopic, escalationTopic, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByPaymentAgreed(
    bool paymentAgreed,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessagePaymentAgreed, paymentAgreed, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByPaymentPlan(
    dynamic paymentPlan,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessagePaymentPlan, paymentPlan, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getBySecurityFlag(
    bool securityFlag,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageSecurityFlag, securityFlag, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getBySecurityReason(
    String securityReason,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageSecurityReason, securityReason, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByModuleType(
    AIChatModuleType moduleType,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageModuleType, moduleType, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByMetadata(
    dynamic metadata,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageMetadata, metadata, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByTokenCount(
    int tokenCount,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageTokenCount, tokenCount, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByProcessingMs(
    int processingMs,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageProcessingMs, processingMs, modelFilter: modelFilter, includes: includes);

	
List<AIChatMessage> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}
    ) =>
    getManyIncluding(getAIChatMessageCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  AIChatbotSession? getSession(
    AIChatMessage aIChatMessage, {ModelFilter? modelFilter, List<AIChatbotSessionInclude>? includes}) {
    if (aIChatMessage.sessionId == null) {
        return null;
    } else {
        final session = AIChatbotSessionStore.instance.getById(aIChatMessage.sessionId!, includes: includes);
        aIChatMessage.session = session;
        // setIncludedReferences(session, includes: includes);
        return session;
    }
}

	Organization? getOrg(
    AIChatMessage aIChatMessage, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIChatMessage.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIChatMessage.orgId!, includes: includes);
        aIChatMessage.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Listing? getListing(
    AIChatMessage aIChatMessage, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (aIChatMessage.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(aIChatMessage.listingId!, includes: includes);
        aIChatMessage.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Reservation? getReservation(
    AIChatMessage aIChatMessage, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (aIChatMessage.reservationId == null) {
        return null;
    } else {
        final reservation = ReservationStore.instance.getById(aIChatMessage.reservationId!, includes: includes);
        aIChatMessage.reservation = reservation;
        // setIncludedReferences(reservation, includes: includes);
        return reservation;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIChatMessage>> getAll$({bool useCache = true, ModelFilter<AIChatMessage>? modelFilter, List<AIChatMessageInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIChatMessageEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIChatMessage?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIChatMessageId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIChatMessage>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getBySessionId$(
        String sessionId,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageSessionId,
        value: sessionId,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyBySessionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByRole$(
        AIChatRole role,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<AIChatRole>(
        getPropVal: getAIChatMessageRole,
        value: role,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByRole,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByContent$(
        String content,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageContent,
        value: content,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByContentHash$(
        String contentHash,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageContentHash,
        value: contentHash,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByContentHash,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByRedactedContent$(
        String redactedContent,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageRedactedContent,
        value: redactedContent,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByRedactedContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByPiiDetected$(
        bool piiDetected,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAIChatMessagePiiDetected,
        value: piiDetected,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByPiiDetected,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByPiiTypes$(
        String piiTypes,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessagePiiTypes,
        value: piiTypes,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByPiiTypes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByLanguage$(
        String language,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageLanguage,
        value: language,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByLanguage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByIsAI$(
        bool isAI,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAIChatMessageIsAI,
        value: isAI,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByIsAI,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByEscalationTag$(
        String escalationTag,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageEscalationTag,
        value: escalationTag,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByEscalationTag,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByEscalationTopic$(
        String escalationTopic,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageEscalationTopic,
        value: escalationTopic,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByEscalationTopic,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByPaymentAgreed$(
        bool paymentAgreed,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAIChatMessagePaymentAgreed,
        value: paymentAgreed,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByPaymentAgreed,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByPaymentPlan$(
        dynamic paymentPlan,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIChatMessagePaymentPlan,
        value: paymentPlan,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByPaymentPlan,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getBySecurityFlag$(
        bool securityFlag,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAIChatMessageSecurityFlag,
        value: securityFlag,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyBySecurityFlag,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getBySecurityReason$(
        String securityReason,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatMessageSecurityReason,
        value: securityReason,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyBySecurityReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByModuleType$(
        AIChatModuleType moduleType,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<AIChatModuleType>(
        getPropVal: getAIChatMessageModuleType,
        value: moduleType,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByModuleType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByMetadata$(
        dynamic metadata,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIChatMessageMetadata,
        value: metadata,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByTokenCount$(
        int tokenCount,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAIChatMessageTokenCount,
        value: tokenCount,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByTokenCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByProcessingMs$(
        int processingMs,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAIChatMessageProcessingMs,
        value: processingMs,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByProcessingMs,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatMessage>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIChatMessage>? modelFilter,
        List<AIChatMessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIChatMessageCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIChatMessageEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<AIChatbotSession?> getSession$(
    AIChatMessage aIChatMessage, {bool useCache = true, ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}) {
    if (aIChatMessage.sessionId == null) {
        return Stream.value(null);
    } else {
        return AIChatbotSessionStore.instance.getBySessionId$(
            aIChatMessage.sessionId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((session) {
            aIChatMessage.session = session;
        });
    }
}

	Stream<Organization?> getOrg$(
    AIChatMessage aIChatMessage, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIChatMessage.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIChatMessage.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIChatMessage.org = org;
        });
    }
}

	Stream<Listing?> getListing$(
    AIChatMessage aIChatMessage, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (aIChatMessage.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            aIChatMessage.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            aIChatMessage.listing = listing;
        });
    }
}

	Stream<Reservation?> getReservation$(
    AIChatMessage aIChatMessage, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (aIChatMessage.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            aIChatMessage.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((reservation) {
            aIChatMessage.reservation = reservation;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AIChatMessage recursiveUpsert(AIChatMessage aIChatMessage, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIChatMessage'} 
        : const {};
    if (aIChatMessage.session != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatbotSession'))) {
        aIChatMessage.session = AIChatbotSessionStore.instance.recursiveUpsert(aIChatMessage.session!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIChatMessage.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIChatMessage.org = OrganizationStore.instance.recursiveUpsert(aIChatMessage.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIChatMessage.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        aIChatMessage.listing = ListingStore.instance.recursiveUpsert(aIChatMessage.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIChatMessage.reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        aIChatMessage.reservation = ReservationStore.instance.recursiveUpsert(aIChatMessage.reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIChatMessage);
}

  List<AIChatMessage> recursiveListUpsert(List<AIChatMessage> aIChatMessages, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIChatMessages = <AIChatMessage>[];
    for (var aIChatMessage in aIChatMessages) {
        updatedAIChatMessages.add(recursiveUpsert(aIChatMessage, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIChatMessages;
}

//   @override
//   AIChatMessage upsert(AIChatMessage item) {
//     return recursiveUpsert(item);
//   }

}


class AIChatMessageInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIChatMessageInclude.session({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatbotSession>? modelFilter,
    List<AIChatbotSessionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatMessage) => AIChatMessageStore.instance
            .getSession$(aIChatMessage, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatMessage) => AIChatMessageStore.instance
            .getSession(aIChatMessage, modelFilter: modelFilter, includes: includes);
      }
}

	AIChatMessageInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatMessage) => AIChatMessageStore.instance
            .getOrg$(aIChatMessage, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatMessage) => AIChatMessageStore.instance
            .getOrg(aIChatMessage, modelFilter: modelFilter, includes: includes);
      }
}

	AIChatMessageInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatMessage) => AIChatMessageStore.instance
            .getListing$(aIChatMessage, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatMessage) => AIChatMessageStore.instance
            .getListing(aIChatMessage, modelFilter: modelFilter, includes: includes);
      }
}

	AIChatMessageInclude.reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatMessage) => AIChatMessageStore.instance
            .getReservation$(aIChatMessage, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatMessage) => AIChatMessageStore.instance
            .getReservation(aIChatMessage, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIChatMessageEndpoints implements Endpoint {

    getAll('/aIChatMessage', HttpMethod.post, List<AIChatMessage>),
	getById('/aIChatMessage/byId/:id', HttpMethod.post, AIChatMessage),
	getManyByOrgId('/aIChatMessage/byOrgId/:orgId', HttpMethod.post, List<AIChatMessage>),
	getManyBySessionId('/aIChatMessage/bySessionId/:sessionId', HttpMethod.post, List<AIChatMessage>),
	getManyByListingId('/aIChatMessage/byListingId/:listingId', HttpMethod.post, List<AIChatMessage>),
	getManyByReservationId('/aIChatMessage/byReservationId/:reservationId', HttpMethod.post, List<AIChatMessage>),
	getManyByRole('/aIChatMessage/byRole/:role', HttpMethod.post, List<AIChatMessage>),
	getManyByContent('/aIChatMessage/byContent/:content', HttpMethod.post, List<AIChatMessage>),
	getManyByContentHash('/aIChatMessage/byContentHash/:contentHash', HttpMethod.post, List<AIChatMessage>),
	getManyByRedactedContent('/aIChatMessage/byRedactedContent/:redactedContent', HttpMethod.post, List<AIChatMessage>),
	getManyByPiiDetected('/aIChatMessage/byPiiDetected/:piiDetected', HttpMethod.post, List<AIChatMessage>),
	getManyByPiiTypes('/aIChatMessage/byPiiTypes/:piiTypes', HttpMethod.post, List<AIChatMessage>),
	getManyByLanguage('/aIChatMessage/byLanguage/:language', HttpMethod.post, List<AIChatMessage>),
	getManyByIsAI('/aIChatMessage/byIsAI/:isAI', HttpMethod.post, List<AIChatMessage>),
	getManyByEscalationTag('/aIChatMessage/byEscalationTag/:escalationTag', HttpMethod.post, List<AIChatMessage>),
	getManyByEscalationTopic('/aIChatMessage/byEscalationTopic/:escalationTopic', HttpMethod.post, List<AIChatMessage>),
	getManyByPaymentAgreed('/aIChatMessage/byPaymentAgreed/:paymentAgreed', HttpMethod.post, List<AIChatMessage>),
	getManyByPaymentPlan('/aIChatMessage/byPaymentPlan/:paymentPlan', HttpMethod.post, List<AIChatMessage>),
	getManyBySecurityFlag('/aIChatMessage/bySecurityFlag/:securityFlag', HttpMethod.post, List<AIChatMessage>),
	getManyBySecurityReason('/aIChatMessage/bySecurityReason/:securityReason', HttpMethod.post, List<AIChatMessage>),
	getManyByModuleType('/aIChatMessage/byModuleType/:moduleType', HttpMethod.post, List<AIChatMessage>),
	getManyByMetadata('/aIChatMessage/byMetadata/:metadata', HttpMethod.post, List<AIChatMessage>),
	getManyByTokenCount('/aIChatMessage/byTokenCount/:tokenCount', HttpMethod.post, List<AIChatMessage>),
	getManyByProcessingMs('/aIChatMessage/byProcessingMs/:processingMs', HttpMethod.post, List<AIChatMessage>),
	getManyByCreatedAt('/aIChatMessage/byCreatedAt/:createdAt', HttpMethod.post, List<AIChatMessage>);

    const AIChatMessageEndpoints(this.path, this.method, this.responseType);

    @override
  final String path;

  @override
  final HttpMethod method;

  final Type responseType;

  static String withPathParameter(String path, dynamic param) {
    final regex = RegExp(r':([a-zA-Z]+)');
    return path.replaceFirst(regex, param.toString());
  }
}
