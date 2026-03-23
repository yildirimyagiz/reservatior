
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class CommunicationLogStore extends ModelStreamStore<String, CommunicationLog> {

  static CommunicationLogStore? _instance;

  static CommunicationLogStore get instance {
    _instance ??= CommunicationLogStore();
    return _instance!;
  }

  CommunicationLogStore() : super(CommunicationLog.fromJson) {
    if (_instance != null) {
        throw Exception(
            'CommunicationLogStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending CommunicationLogStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use CommunicationLogStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getCommunicationLogId(CommunicationLog communicationLog) => communicationLog.id;

	String? getCommunicationLogSenderId(CommunicationLog communicationLog) => communicationLog.senderId;

	String? getCommunicationLogReceiverId(CommunicationLog communicationLog) => communicationLog.receiverId;

	CommunicationType? getCommunicationLogType(CommunicationLog communicationLog) => communicationLog.type;

	String? getCommunicationLogContent(CommunicationLog communicationLog) => communicationLog.content;

	String? getCommunicationLogEntityId(CommunicationLog communicationLog) => communicationLog.entityId;

	String? getCommunicationLogEntityType(CommunicationLog communicationLog) => communicationLog.entityType;

	dynamic? getCommunicationLogMetadata(CommunicationLog communicationLog) => communicationLog.metadata;

	bool? getCommunicationLogIsRead(CommunicationLog communicationLog) => communicationLog.isRead;

	DateTime? getCommunicationLogReadAt(CommunicationLog communicationLog) => communicationLog.readAt;

	DateTime? getCommunicationLogDeliveredAt(CommunicationLog communicationLog) => communicationLog.deliveredAt;

	DateTime? getCommunicationLogDeletedAt(CommunicationLog communicationLog) => communicationLog.deletedAt;

	DateTime? getCommunicationLogTimestamp(CommunicationLog communicationLog) => communicationLog.timestamp;

	String? getCommunicationLogUserId(CommunicationLog communicationLog) => communicationLog.userId;

	String? getCommunicationLogAgencyId(CommunicationLog communicationLog) => communicationLog.agencyId;

	String? getCommunicationLogThreadId(CommunicationLog communicationLog) => communicationLog.threadId;

	String? getCommunicationLogReplyToId(CommunicationLog communicationLog) => communicationLog.replyToId;

	String? getCommunicationLogChannelId(CommunicationLog communicationLog) => communicationLog.channelId;

	String? getCommunicationLogTicketId(CommunicationLog communicationLog) => communicationLog.ticketId;

	DateTime? getCommunicationLogCreatedAt(CommunicationLog communicationLog) => communicationLog.createdAt;

	DateTime? getCommunicationLogUpdatedAt(CommunicationLog communicationLog) => communicationLog.updatedAt;

	bool? getCommunicationLogIsEdited(CommunicationLog communicationLog) => communicationLog.isEdited;

	DateTime? getCommunicationLogEditedAt(CommunicationLog communicationLog) => communicationLog.editedAt;

	String? getCommunicationLogDeletedById(CommunicationLog communicationLog) => communicationLog.deletedById;

	dynamic? getCommunicationLogReactions(CommunicationLog communicationLog) => communicationLog.reactions;

	dynamic? getCommunicationLogAttachments(CommunicationLog communicationLog) => communicationLog.attachments;

	dynamic? getCommunicationLogReadBy(CommunicationLog communicationLog) => communicationLog.readBy;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<CommunicationLog> getBySenderId(
    String senderId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogSenderId, senderId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByReceiverId(
    String receiverId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogReceiverId, receiverId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByType(
    CommunicationType type,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogType, type, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByContent(
    String content,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogContent, content, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByEntityId(
    String entityId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogEntityId, entityId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByEntityType(
    String entityType,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogEntityType, entityType, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByMetadata(
    dynamic metadata,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogMetadata, metadata, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByIsRead(
    bool isRead,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogIsRead, isRead, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByReadAt(
    DateTime readAt,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogReadAt, readAt, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByDeliveredAt(
    DateTime deliveredAt,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogDeliveredAt, deliveredAt, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByTimestamp(
    DateTime timestamp,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogTimestamp, timestamp, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByUserId(
    String userId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByAgencyId(
    String agencyId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByThreadId(
    String threadId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogThreadId, threadId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByReplyToId(
    String replyToId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogReplyToId, replyToId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByChannelId(
    String channelId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogChannelId, channelId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByTicketId(
    String ticketId,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogTicketId, ticketId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByIsEdited(
    bool isEdited,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogIsEdited, isEdited, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByEditedAt(
    DateTime editedAt,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogEditedAt, editedAt, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByDeletedById(
    String deletedById,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogDeletedById, deletedById, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByReactions(
    dynamic reactions,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogReactions, reactions, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByAttachments(
    dynamic attachments,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogAttachments, attachments, modelFilter: modelFilter, includes: includes);

	
List<CommunicationLog> getByReadBy(
    dynamic readBy,
    {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationLogReadBy, readBy, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    CommunicationLog communicationLog, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (communicationLog.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(communicationLog.agencyId!, includes: includes);
        communicationLog.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Channel? getChannel(
    CommunicationLog communicationLog, {ModelFilter? modelFilter, List<ChannelInclude>? includes}) {
    if (communicationLog.channelId == null) {
        return null;
    } else {
        final Channel = ChannelStore.instance.getById(communicationLog.channelId!, includes: includes);
        communicationLog.Channel = Channel;
        // setIncludedReferences(Channel, includes: includes);
        return Channel;
    }
}

	CommunicationLog? getReplyTo(
    CommunicationLog communicationLog, {ModelFilter? modelFilter, List<CommunicationLogInclude>? includes}) {
    if (communicationLog.replyToId == null) {
        return null;
    } else {
        final replyTo = CommunicationLogStore.instance.getById(communicationLog.replyToId!, includes: includes);
        communicationLog.replyTo = replyTo;
        // setIncludedReferences(replyTo, includes: includes);
        return replyTo;
    }
}

	Ticket? getTicket(
    CommunicationLog communicationLog, {ModelFilter? modelFilter, List<TicketInclude>? includes}) {
    if (communicationLog.ticketId == null) {
        return null;
    } else {
        final Ticket = TicketStore.instance.getById(communicationLog.ticketId!, includes: includes);
        communicationLog.Ticket = Ticket;
        // setIncludedReferences(Ticket, includes: includes);
        return Ticket;
    }
}

	User? getUser(
    CommunicationLog communicationLog, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (communicationLog.userId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(communicationLog.userId!, includes: includes);
        communicationLog.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  List<CommunicationLog> getReplies(
    CommunicationLog communicationLog, {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    final replies = CommunicationLogStore.instance.getByReplyToId(communicationLog.$uid!, modelFilter: modelFilter, includes: includes);
    communicationLog.replies = replies;
    // setIncludedReferencesForList(replies, includes: includes);
    return replies;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<CommunicationLog>> getAll$({bool useCache = true, ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: CommunicationLogEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<CommunicationLog?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getCommunicationLogId,
        value: id,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<CommunicationLog>> getBySenderId$(
        String senderId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogSenderId,
        value: senderId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyBySenderId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByReceiverId$(
        String receiverId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogReceiverId,
        value: receiverId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByReceiverId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByType$(
        CommunicationType type,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<CommunicationType>(
        getPropVal: getCommunicationLogType,
        value: type,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByContent$(
        String content,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogContent,
        value: content,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByEntityId$(
        String entityId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogEntityId,
        value: entityId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByEntityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByEntityType$(
        String entityType,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogEntityType,
        value: entityType,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByEntityType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByMetadata$(
        dynamic metadata,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCommunicationLogMetadata,
        value: metadata,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByIsRead$(
        bool isRead,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getCommunicationLogIsRead,
        value: isRead,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByIsRead,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByReadAt$(
        DateTime readAt,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationLogReadAt,
        value: readAt,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByReadAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByDeliveredAt$(
        DateTime deliveredAt,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationLogDeliveredAt,
        value: deliveredAt,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByDeliveredAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationLogDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByTimestamp$(
        DateTime timestamp,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationLogTimestamp,
        value: timestamp,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByTimestamp,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByThreadId$(
        String threadId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogThreadId,
        value: threadId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByThreadId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByReplyToId$(
        String replyToId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogReplyToId,
        value: replyToId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByReplyToId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByChannelId$(
        String channelId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogChannelId,
        value: channelId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByChannelId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByTicketId$(
        String ticketId,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogTicketId,
        value: ticketId,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByTicketId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationLogCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationLogUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByIsEdited$(
        bool isEdited,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getCommunicationLogIsEdited,
        value: isEdited,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByIsEdited,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByEditedAt$(
        DateTime editedAt,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationLogEditedAt,
        value: editedAt,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByEditedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByDeletedById$(
        String deletedById,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationLogDeletedById,
        value: deletedById,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByDeletedById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByReactions$(
        dynamic reactions,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCommunicationLogReactions,
        value: reactions,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByReactions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByAttachments$(
        dynamic attachments,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCommunicationLogAttachments,
        value: attachments,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByAttachments,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationLog>> getByReadBy$(
        dynamic readBy,
        {bool useCache = true,
        ModelFilter<CommunicationLog>? modelFilter,
        List<CommunicationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCommunicationLogReadBy,
        value: readBy,
        modelFilter: modelFilter,
        endpoint: CommunicationLogEndpoints.getManyByReadBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    CommunicationLog communicationLog, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (communicationLog.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            communicationLog.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            communicationLog.Agency = Agency;
        });
    }
}

	Stream<Channel?> getChannel$(
    CommunicationLog communicationLog, {bool useCache = true, ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}) {
    if (communicationLog.channelId == null) {
        return Stream.value(null);
    } else {
        return ChannelStore.instance.getById$(
            communicationLog.channelId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Channel) {
            communicationLog.Channel = Channel;
        });
    }
}

	Stream<CommunicationLog?> getReplyTo$(
    CommunicationLog communicationLog, {bool useCache = true, ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    if (communicationLog.replyToId == null) {
        return Stream.value(null);
    } else {
        return CommunicationLogStore.instance.getById$(
            communicationLog.replyToId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((replyTo) {
            communicationLog.replyTo = replyTo;
        });
    }
}

	Stream<Ticket?> getTicket$(
    CommunicationLog communicationLog, {bool useCache = true, ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}) {
    if (communicationLog.ticketId == null) {
        return Stream.value(null);
    } else {
        return TicketStore.instance.getById$(
            communicationLog.ticketId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Ticket) {
            communicationLog.Ticket = Ticket;
        });
    }
}

	Stream<User?> getUser$(
    CommunicationLog communicationLog, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (communicationLog.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            communicationLog.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            communicationLog.User = User;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<CommunicationLog>> getReplies$(
    CommunicationLog communicationLog, {bool useCache = true, ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    return CommunicationLogStore.instance.getByReplyToId$(
        communicationLog.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((replies) {
        communicationLog.replies = replies;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
CommunicationLog recursiveUpsert(CommunicationLog communicationLog, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'CommunicationLog'} 
        : const {};
    if (communicationLog.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        communicationLog.Agency = AgencyStore.instance.recursiveUpsert(communicationLog.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (communicationLog.Channel != null && (!preventCircularSerialization || !upsertedTypes.contains('Channel'))) {
        communicationLog.Channel = ChannelStore.instance.recursiveUpsert(communicationLog.Channel!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (communicationLog.replyTo != null && (!preventCircularSerialization || !upsertedTypes.contains('CommunicationLog'))) {
        communicationLog.replyTo = CommunicationLogStore.instance.recursiveUpsert(communicationLog.replyTo!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (communicationLog.replies != null && (!preventCircularSerialization || !upsertedTypes.contains('CommunicationLog'))) {
        communicationLog.replies = CommunicationLogStore.instance.recursiveListUpsert(communicationLog.replies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (communicationLog.Ticket != null && (!preventCircularSerialization || !upsertedTypes.contains('Ticket'))) {
        communicationLog.Ticket = TicketStore.instance.recursiveUpsert(communicationLog.Ticket!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (communicationLog.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        communicationLog.User = UserStore.instance.recursiveUpsert(communicationLog.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(communicationLog);
}

  List<CommunicationLog> recursiveListUpsert(List<CommunicationLog> communicationLogs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedCommunicationLogs = <CommunicationLog>[];
    for (var communicationLog in communicationLogs) {
        updatedCommunicationLogs.add(recursiveUpsert(communicationLog, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedCommunicationLogs;
}

//   @override
//   CommunicationLog upsert(CommunicationLog item) {
//     return recursiveUpsert(item);
//   }

}


class CommunicationLogInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      CommunicationLogInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (communicationLog) => CommunicationLogStore.instance
            .getAgency$(communicationLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (communicationLog) => CommunicationLogStore.instance
            .getAgency(communicationLog, modelFilter: modelFilter, includes: includes);
      }
}

	CommunicationLogInclude.Channel({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Channel>? modelFilter,
    List<ChannelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (communicationLog) => CommunicationLogStore.instance
            .getChannel$(communicationLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (communicationLog) => CommunicationLogStore.instance
            .getChannel(communicationLog, modelFilter: modelFilter, includes: includes);
      }
}

	CommunicationLogInclude.replyTo({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommunicationLog>? modelFilter,
    List<CommunicationLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (communicationLog) => CommunicationLogStore.instance
            .getReplyTo$(communicationLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (communicationLog) => CommunicationLogStore.instance
            .getReplyTo(communicationLog, modelFilter: modelFilter, includes: includes);
      }
}

	CommunicationLogInclude.replies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommunicationLog>? modelFilter,
    List<CommunicationLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (communicationLog) => CommunicationLogStore.instance
            .getReplies$(communicationLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (communicationLog) => CommunicationLogStore.instance
            .getReplies(communicationLog, modelFilter: modelFilter, includes: includes);
      }
}

	CommunicationLogInclude.Ticket({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Ticket>? modelFilter,
    List<TicketInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (communicationLog) => CommunicationLogStore.instance
            .getTicket$(communicationLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (communicationLog) => CommunicationLogStore.instance
            .getTicket(communicationLog, modelFilter: modelFilter, includes: includes);
      }
}

	CommunicationLogInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (communicationLog) => CommunicationLogStore.instance
            .getUser$(communicationLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (communicationLog) => CommunicationLogStore.instance
            .getUser(communicationLog, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum CommunicationLogEndpoints implements Endpoint {

    getAll('/communicationLog', HttpMethod.post, List<CommunicationLog>),
	getById('/communicationLog/byId/:id', HttpMethod.post, CommunicationLog),
	getManyBySenderId('/communicationLog/bySenderId/:senderId', HttpMethod.post, List<CommunicationLog>),
	getManyByReceiverId('/communicationLog/byReceiverId/:receiverId', HttpMethod.post, List<CommunicationLog>),
	getManyByType('/communicationLog/byType/:type', HttpMethod.post, List<CommunicationLog>),
	getManyByContent('/communicationLog/byContent/:content', HttpMethod.post, List<CommunicationLog>),
	getManyByEntityId('/communicationLog/byEntityId/:entityId', HttpMethod.post, List<CommunicationLog>),
	getManyByEntityType('/communicationLog/byEntityType/:entityType', HttpMethod.post, List<CommunicationLog>),
	getManyByMetadata('/communicationLog/byMetadata/:metadata', HttpMethod.post, List<CommunicationLog>),
	getManyByIsRead('/communicationLog/byIsRead/:isRead', HttpMethod.post, List<CommunicationLog>),
	getManyByReadAt('/communicationLog/byReadAt/:readAt', HttpMethod.post, List<CommunicationLog>),
	getManyByDeliveredAt('/communicationLog/byDeliveredAt/:deliveredAt', HttpMethod.post, List<CommunicationLog>),
	getManyByDeletedAt('/communicationLog/byDeletedAt/:deletedAt', HttpMethod.post, List<CommunicationLog>),
	getManyByTimestamp('/communicationLog/byTimestamp/:timestamp', HttpMethod.post, List<CommunicationLog>),
	getManyByUserId('/communicationLog/byUserId/:userId', HttpMethod.post, List<CommunicationLog>),
	getManyByAgencyId('/communicationLog/byAgencyId/:agencyId', HttpMethod.post, List<CommunicationLog>),
	getManyByThreadId('/communicationLog/byThreadId/:threadId', HttpMethod.post, List<CommunicationLog>),
	getManyByReplyToId('/communicationLog/byReplyToId/:replyToId', HttpMethod.post, List<CommunicationLog>),
	getManyByChannelId('/communicationLog/byChannelId/:channelId', HttpMethod.post, List<CommunicationLog>),
	getManyByTicketId('/communicationLog/byTicketId/:ticketId', HttpMethod.post, List<CommunicationLog>),
	getManyByCreatedAt('/communicationLog/byCreatedAt/:createdAt', HttpMethod.post, List<CommunicationLog>),
	getManyByUpdatedAt('/communicationLog/byUpdatedAt/:updatedAt', HttpMethod.post, List<CommunicationLog>),
	getManyByIsEdited('/communicationLog/byIsEdited/:isEdited', HttpMethod.post, List<CommunicationLog>),
	getManyByEditedAt('/communicationLog/byEditedAt/:editedAt', HttpMethod.post, List<CommunicationLog>),
	getManyByDeletedById('/communicationLog/byDeletedById/:deletedById', HttpMethod.post, List<CommunicationLog>),
	getManyByReactions('/communicationLog/byReactions/:reactions', HttpMethod.post, List<CommunicationLog>),
	getManyByAttachments('/communicationLog/byAttachments/:attachments', HttpMethod.post, List<CommunicationLog>),
	getManyByReadBy('/communicationLog/byReadBy/:readBy', HttpMethod.post, List<CommunicationLog>);

    const CommunicationLogEndpoints(this.path, this.method, this.responseType);

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
