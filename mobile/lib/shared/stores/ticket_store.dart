
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class TicketStore extends ModelStreamStore<String, Ticket> {

  static TicketStore? _instance;

  static TicketStore get instance {
    _instance ??= TicketStore();
    return _instance!;
  }

  TicketStore() : super(Ticket.fromJson) {
    if (_instance != null) {
        throw Exception(
            'TicketStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending TicketStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use TicketStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getTicketId(Ticket ticket) => ticket.id;

	String? getTicketCuid(Ticket ticket) => ticket.cuid;

	String? getTicketSubject(Ticket ticket) => ticket.subject;

	String? getTicketDescription(Ticket ticket) => ticket.description;

	TicketStatus? getTicketStatus(Ticket ticket) => ticket.status;

	DateTime? getTicketCreatedAt(Ticket ticket) => ticket.createdAt;

	DateTime? getTicketUpdatedAt(Ticket ticket) => ticket.updatedAt;

	DateTime? getTicketClosedAt(Ticket ticket) => ticket.closedAt;

	DateTime? getTicketDeletedAt(Ticket ticket) => ticket.deletedAt;

	String? getTicketUserId(Ticket ticket) => ticket.userId;

	String? getTicketAgentId(Ticket ticket) => ticket.agentId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Ticket? getByCuid(
    String cuid,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getIncluding(getTicketCuid, cuid, modelFilter: modelFilter, includes: includes);

  
List<Ticket> getBySubject(
    String subject,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketSubject, subject, modelFilter: modelFilter, includes: includes);

	
List<Ticket> getByDescription(
    String description,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Ticket> getByStatus(
    TicketStatus status,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Ticket> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Ticket> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Ticket> getByClosedAt(
    DateTime closedAt,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketClosedAt, closedAt, modelFilter: modelFilter, includes: includes);

	
List<Ticket> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Ticket> getByUserId(
    String userId,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Ticket> getByAgentId(
    String agentId,
    {ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}
    ) =>
    getManyIncluding(getTicketAgentId, agentId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getAgent(
    Ticket ticket, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (ticket.agentId == null) {
        return null;
    } else {
        final Agent = UserStore.instance.getById(ticket.agentId!, includes: includes);
        ticket.Agent = Agent;
        // setIncludedReferences(Agent, includes: includes);
        return Agent;
    }
}

	User? getUser(
    Ticket ticket, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (ticket.userId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(ticket.userId!, includes: includes);
        ticket.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  List<CommunicationLog> getCommunicationLogs(
    Ticket ticket, {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    final CommunicationLogs = CommunicationLogStore.instance.getByTicketId(ticket.$uid!, modelFilter: modelFilter, includes: includes);
    ticket.CommunicationLogs = CommunicationLogs;
    // setIncludedReferencesForList(CommunicationLogs, includes: includes);
    return CommunicationLogs;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Ticket>> getAll$({bool useCache = true, ModelFilter<Ticket>? modelFilter, List<TicketInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: TicketEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Ticket?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTicketId,
        value: id,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Ticket?> getByCuid$(
        String cuid,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTicketCuid,
        value: cuid,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getByCuid,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Ticket>> getBySubject$(
        String subject,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTicketSubject,
        value: subject,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyBySubject,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Ticket>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTicketDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Ticket>> getByStatus$(
        TicketStatus status,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<TicketStatus>(
        getPropVal: getTicketStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Ticket>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTicketCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Ticket>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTicketUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Ticket>> getByClosedAt$(
        DateTime closedAt,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTicketClosedAt,
        value: closedAt,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyByClosedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Ticket>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTicketDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Ticket>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTicketUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Ticket>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<Ticket>? modelFilter,
        List<TicketInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTicketAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: TicketEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getAgent$(
    Ticket ticket, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (ticket.agentId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            ticket.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agent) {
            ticket.Agent = Agent;
        });
    }
}

	Stream<User?> getUser$(
    Ticket ticket, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (ticket.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            ticket.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            ticket.User = User;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<CommunicationLog>> getCommunicationLogs$(
    Ticket ticket, {bool useCache = true, ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    return CommunicationLogStore.instance.getByTicketId$(
        ticket.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((CommunicationLogs) {
        ticket.CommunicationLogs = CommunicationLogs;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Ticket recursiveUpsert(Ticket ticket, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Ticket'} 
        : const {};
    if (ticket.CommunicationLogs != null && (!preventCircularSerialization || !upsertedTypes.contains('CommunicationLog'))) {
        ticket.CommunicationLogs = CommunicationLogStore.instance.recursiveListUpsert(ticket.CommunicationLogs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (ticket.Agent != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        ticket.Agent = UserStore.instance.recursiveUpsert(ticket.Agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (ticket.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        ticket.User = UserStore.instance.recursiveUpsert(ticket.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(ticket);
}

  List<Ticket> recursiveListUpsert(List<Ticket> tickets, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedTickets = <Ticket>[];
    for (var ticket in tickets) {
        updatedTickets.add(recursiveUpsert(ticket, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedTickets;
}

//   @override
//   Ticket upsert(Ticket item) {
//     return recursiveUpsert(item);
//   }

}


class TicketInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      TicketInclude.CommunicationLogs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommunicationLog>? modelFilter,
    List<CommunicationLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ticket) => TicketStore.instance
            .getCommunicationLogs$(ticket, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ticket) => TicketStore.instance
            .getCommunicationLogs(ticket, modelFilter: modelFilter, includes: includes);
      }
}

	TicketInclude.Agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ticket) => TicketStore.instance
            .getAgent$(ticket, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ticket) => TicketStore.instance
            .getAgent(ticket, modelFilter: modelFilter, includes: includes);
      }
}

	TicketInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ticket) => TicketStore.instance
            .getUser$(ticket, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ticket) => TicketStore.instance
            .getUser(ticket, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum TicketEndpoints implements Endpoint {

    getAll('/ticket', HttpMethod.post, List<Ticket>),
	getById('/ticket/byId/:id', HttpMethod.post, Ticket),
	getByCuid('/ticket/byCuid/:cuid', HttpMethod.post, Ticket),
	getManyBySubject('/ticket/bySubject/:subject', HttpMethod.post, List<Ticket>),
	getManyByDescription('/ticket/byDescription/:description', HttpMethod.post, List<Ticket>),
	getManyByStatus('/ticket/byStatus/:status', HttpMethod.post, List<Ticket>),
	getManyByCreatedAt('/ticket/byCreatedAt/:createdAt', HttpMethod.post, List<Ticket>),
	getManyByUpdatedAt('/ticket/byUpdatedAt/:updatedAt', HttpMethod.post, List<Ticket>),
	getManyByClosedAt('/ticket/byClosedAt/:closedAt', HttpMethod.post, List<Ticket>),
	getManyByDeletedAt('/ticket/byDeletedAt/:deletedAt', HttpMethod.post, List<Ticket>),
	getManyByUserId('/ticket/byUserId/:userId', HttpMethod.post, List<Ticket>),
	getManyByAgentId('/ticket/byAgentId/:agentId', HttpMethod.post, List<Ticket>);

    const TicketEndpoints(this.path, this.method, this.responseType);

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
