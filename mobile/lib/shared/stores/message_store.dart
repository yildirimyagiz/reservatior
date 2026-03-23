
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MessageStore extends ModelStreamStore<String, Message> {

  static MessageStore? _instance;

  static MessageStore get instance {
    _instance ??= MessageStore();
    return _instance!;
  }

  MessageStore() : super(Message.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MessageStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MessageStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MessageStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMessageId(Message message) => message.id;

	String? getMessageOrgId(Message message) => message.orgId;

	String? getMessageThreadId(Message message) => message.threadId;

	MessageParticipantType? getMessageSenderType(Message message) => message.senderType;

	String? getMessageSenderUserId(Message message) => message.senderUserId;

	String? getMessageSenderContactId(Message message) => message.senderContactId;

	String? getMessageBody(Message message) => message.body;

	String? getMessageSubject(Message message) => message.subject;

	bool? getMessageIsThreadStarter(Message message) => message.isThreadStarter;

	dynamic? getMessageThreadInfo(Message message) => message.threadInfo;

	dynamic? getMessageReadStatus(Message message) => message.readStatus;

	DateTime? getMessageCreatedAt(Message message) => message.createdAt;

	DateTime? getMessageUpdatedAt(Message message) => message.updatedAt;

	DateTime? getMessageDeletedAt(Message message) => message.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Message> getByOrgId(
    String orgId,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Message> getByThreadId(
    String threadId,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageThreadId, threadId, modelFilter: modelFilter, includes: includes);

	
List<Message> getBySenderType(
    MessageParticipantType senderType,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageSenderType, senderType, modelFilter: modelFilter, includes: includes);

	
List<Message> getBySenderUserId(
    String senderUserId,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageSenderUserId, senderUserId, modelFilter: modelFilter, includes: includes);

	
List<Message> getBySenderContactId(
    String senderContactId,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageSenderContactId, senderContactId, modelFilter: modelFilter, includes: includes);

	
List<Message> getByBody(
    String body,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageBody, body, modelFilter: modelFilter, includes: includes);

	
List<Message> getBySubject(
    String subject,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageSubject, subject, modelFilter: modelFilter, includes: includes);

	
List<Message> getByIsThreadStarter(
    bool isThreadStarter,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageIsThreadStarter, isThreadStarter, modelFilter: modelFilter, includes: includes);

	
List<Message> getByThreadInfo(
    dynamic threadInfo,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageThreadInfo, threadInfo, modelFilter: modelFilter, includes: includes);

	
List<Message> getByReadStatus(
    dynamic readStatus,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageReadStatus, readStatus, modelFilter: modelFilter, includes: includes);

	
List<Message> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Message> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Message> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}
    ) =>
    getManyIncluding(getMessageDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Message message, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (message.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(message.orgId!, includes: includes);
        message.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<Attachment> getAttachments(
    Message message, {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    final attachments = AttachmentStore.instance.getByMessageId(message.$uid!, modelFilter: modelFilter, includes: includes);
    message.attachments = attachments;
    // setIncludedReferencesForList(attachments, includes: includes);
    return attachments;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Message>> getAll$({bool useCache = true, ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MessageEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Message?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMessageId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Message>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMessageOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getByThreadId$(
        String threadId,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMessageThreadId,
        value: threadId,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByThreadId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getBySenderType$(
        MessageParticipantType senderType,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<MessageParticipantType>(
        getPropVal: getMessageSenderType,
        value: senderType,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyBySenderType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getBySenderUserId$(
        String senderUserId,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMessageSenderUserId,
        value: senderUserId,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyBySenderUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getBySenderContactId$(
        String senderContactId,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMessageSenderContactId,
        value: senderContactId,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyBySenderContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getByBody$(
        String body,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMessageBody,
        value: body,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByBody,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getBySubject$(
        String subject,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMessageSubject,
        value: subject,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyBySubject,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getByIsThreadStarter$(
        bool isThreadStarter,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMessageIsThreadStarter,
        value: isThreadStarter,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByIsThreadStarter,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getByThreadInfo$(
        dynamic threadInfo,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMessageThreadInfo,
        value: threadInfo,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByThreadInfo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getByReadStatus$(
        dynamic readStatus,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMessageReadStatus,
        value: readStatus,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByReadStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMessageCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMessageUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Message>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Message>? modelFilter,
        List<MessageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMessageDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MessageEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Message message, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (message.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            message.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            message.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Attachment>> getAttachments$(
    Message message, {bool useCache = true, ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    return AttachmentStore.instance.getByMessageId$(
        message.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attachments) {
        message.attachments = attachments;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Message recursiveUpsert(Message message, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Message'} 
        : const {};
    if (message.attachments != null && (!preventCircularSerialization || !upsertedTypes.contains('Attachment'))) {
        message.attachments = AttachmentStore.instance.recursiveListUpsert(message.attachments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (message.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        message.org = OrganizationStore.instance.recursiveUpsert(message.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(message);
}

  List<Message> recursiveListUpsert(List<Message> messages, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMessages = <Message>[];
    for (var message in messages) {
        updatedMessages.add(recursiveUpsert(message, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMessages;
}

//   @override
//   Message upsert(Message item) {
//     return recursiveUpsert(item);
//   }

}


class MessageInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MessageInclude.attachments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Attachment>? modelFilter,
    List<AttachmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (message) => MessageStore.instance
            .getAttachments$(message, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (message) => MessageStore.instance
            .getAttachments(message, modelFilter: modelFilter, includes: includes);
      }
}

	MessageInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (message) => MessageStore.instance
            .getOrg$(message, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (message) => MessageStore.instance
            .getOrg(message, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MessageEndpoints implements Endpoint {

    getAll('/message', HttpMethod.post, List<Message>),
	getById('/message/byId/:id', HttpMethod.post, Message),
	getManyByOrgId('/message/byOrgId/:orgId', HttpMethod.post, List<Message>),
	getManyByThreadId('/message/byThreadId/:threadId', HttpMethod.post, List<Message>),
	getManyBySenderType('/message/bySenderType/:senderType', HttpMethod.post, List<Message>),
	getManyBySenderUserId('/message/bySenderUserId/:senderUserId', HttpMethod.post, List<Message>),
	getManyBySenderContactId('/message/bySenderContactId/:senderContactId', HttpMethod.post, List<Message>),
	getManyByBody('/message/byBody/:body', HttpMethod.post, List<Message>),
	getManyBySubject('/message/bySubject/:subject', HttpMethod.post, List<Message>),
	getManyByIsThreadStarter('/message/byIsThreadStarter/:isThreadStarter', HttpMethod.post, List<Message>),
	getManyByThreadInfo('/message/byThreadInfo/:threadInfo', HttpMethod.post, List<Message>),
	getManyByReadStatus('/message/byReadStatus/:readStatus', HttpMethod.post, List<Message>),
	getManyByCreatedAt('/message/byCreatedAt/:createdAt', HttpMethod.post, List<Message>),
	getManyByUpdatedAt('/message/byUpdatedAt/:updatedAt', HttpMethod.post, List<Message>),
	getManyByDeletedAt('/message/byDeletedAt/:deletedAt', HttpMethod.post, List<Message>);

    const MessageEndpoints(this.path, this.method, this.responseType);

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
