
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ClientRelationshipStore extends ModelStreamStore<String, ClientRelationship> {

  static ClientRelationshipStore? _instance;

  static ClientRelationshipStore get instance {
    _instance ??= ClientRelationshipStore();
    return _instance!;
  }

  ClientRelationshipStore() : super(ClientRelationship.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ClientRelationshipStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ClientRelationshipStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ClientRelationshipStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getClientRelationshipId(ClientRelationship clientRelationship) => clientRelationship.id;

	String? getClientRelationshipAgentId(ClientRelationship clientRelationship) => clientRelationship.agentId;

	String? getClientRelationshipClientId(ClientRelationship clientRelationship) => clientRelationship.clientId;

	RelationshipStatus? getClientRelationshipStatus(ClientRelationship clientRelationship) => clientRelationship.status;

	DateTime? getClientRelationshipFirstContact(ClientRelationship clientRelationship) => clientRelationship.firstContact;

	DateTime? getClientRelationshipLastContact(ClientRelationship clientRelationship) => clientRelationship.lastContact;

	String? getClientRelationshipContactFrequency(ClientRelationship clientRelationship) => clientRelationship.contactFrequency;

	NotificationChannel? getClientRelationshipPreferredChannel(ClientRelationship clientRelationship) => clientRelationship.preferredChannel;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ClientRelationship> getByAgentId(
    String agentId,
    {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}
    ) =>
    getManyIncluding(getClientRelationshipAgentId, agentId, modelFilter: modelFilter, includes: includes);

	
List<ClientRelationship> getByClientId(
    String clientId,
    {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}
    ) =>
    getManyIncluding(getClientRelationshipClientId, clientId, modelFilter: modelFilter, includes: includes);

	
List<ClientRelationship> getByStatus(
    RelationshipStatus status,
    {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}
    ) =>
    getManyIncluding(getClientRelationshipStatus, status, modelFilter: modelFilter, includes: includes);

	
List<ClientRelationship> getByFirstContact(
    DateTime firstContact,
    {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}
    ) =>
    getManyIncluding(getClientRelationshipFirstContact, firstContact, modelFilter: modelFilter, includes: includes);

	
List<ClientRelationship> getByLastContact(
    DateTime lastContact,
    {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}
    ) =>
    getManyIncluding(getClientRelationshipLastContact, lastContact, modelFilter: modelFilter, includes: includes);

	
List<ClientRelationship> getByContactFrequency(
    String contactFrequency,
    {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}
    ) =>
    getManyIncluding(getClientRelationshipContactFrequency, contactFrequency, modelFilter: modelFilter, includes: includes);

	
List<ClientRelationship> getByPreferredChannel(
    NotificationChannel preferredChannel,
    {ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}
    ) =>
    getManyIncluding(getClientRelationshipPreferredChannel, preferredChannel, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getAgent(
    ClientRelationship clientRelationship, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (clientRelationship.agentId == null) {
        return null;
    } else {
        final agent = UserStore.instance.getById(clientRelationship.agentId!, includes: includes);
        clientRelationship.agent = agent;
        // setIncludedReferences(agent, includes: includes);
        return agent;
    }
}

	Contact? getClient(
    ClientRelationship clientRelationship, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (clientRelationship.clientId == null) {
        return null;
    } else {
        final client = ContactStore.instance.getById(clientRelationship.clientId!, includes: includes);
        clientRelationship.client = client;
        // setIncludedReferences(client, includes: includes);
        return client;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ClientRelationship>> getAll$({bool useCache = true, ModelFilter<ClientRelationship>? modelFilter, List<ClientRelationshipInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ClientRelationshipEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ClientRelationship?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ClientRelationship>? modelFilter,
        List<ClientRelationshipInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getClientRelationshipId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ClientRelationshipEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ClientRelationship>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<ClientRelationship>? modelFilter,
        List<ClientRelationshipInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getClientRelationshipAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: ClientRelationshipEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ClientRelationship>> getByClientId$(
        String clientId,
        {bool useCache = true,
        ModelFilter<ClientRelationship>? modelFilter,
        List<ClientRelationshipInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getClientRelationshipClientId,
        value: clientId,
        modelFilter: modelFilter,
        endpoint: ClientRelationshipEndpoints.getManyByClientId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ClientRelationship>> getByStatus$(
        RelationshipStatus status,
        {bool useCache = true,
        ModelFilter<ClientRelationship>? modelFilter,
        List<ClientRelationshipInclude>? includes}) {
    final items$ = getManyByFieldValue$<RelationshipStatus>(
        getPropVal: getClientRelationshipStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ClientRelationshipEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ClientRelationship>> getByFirstContact$(
        DateTime firstContact,
        {bool useCache = true,
        ModelFilter<ClientRelationship>? modelFilter,
        List<ClientRelationshipInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getClientRelationshipFirstContact,
        value: firstContact,
        modelFilter: modelFilter,
        endpoint: ClientRelationshipEndpoints.getManyByFirstContact,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ClientRelationship>> getByLastContact$(
        DateTime lastContact,
        {bool useCache = true,
        ModelFilter<ClientRelationship>? modelFilter,
        List<ClientRelationshipInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getClientRelationshipLastContact,
        value: lastContact,
        modelFilter: modelFilter,
        endpoint: ClientRelationshipEndpoints.getManyByLastContact,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ClientRelationship>> getByContactFrequency$(
        String contactFrequency,
        {bool useCache = true,
        ModelFilter<ClientRelationship>? modelFilter,
        List<ClientRelationshipInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getClientRelationshipContactFrequency,
        value: contactFrequency,
        modelFilter: modelFilter,
        endpoint: ClientRelationshipEndpoints.getManyByContactFrequency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ClientRelationship>> getByPreferredChannel$(
        NotificationChannel preferredChannel,
        {bool useCache = true,
        ModelFilter<ClientRelationship>? modelFilter,
        List<ClientRelationshipInclude>? includes}) {
    final items$ = getManyByFieldValue$<NotificationChannel>(
        getPropVal: getClientRelationshipPreferredChannel,
        value: preferredChannel,
        modelFilter: modelFilter,
        endpoint: ClientRelationshipEndpoints.getManyByPreferredChannel,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getAgent$(
    ClientRelationship clientRelationship, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (clientRelationship.agentId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            clientRelationship.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((agent) {
            clientRelationship.agent = agent;
        });
    }
}

	Stream<Contact?> getClient$(
    ClientRelationship clientRelationship, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (clientRelationship.clientId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            clientRelationship.clientId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((client) {
            clientRelationship.client = client;
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
ClientRelationship recursiveUpsert(ClientRelationship clientRelationship, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ClientRelationship'} 
        : const {};
    if (clientRelationship.agent != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        clientRelationship.agent = UserStore.instance.recursiveUpsert(clientRelationship.agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (clientRelationship.client != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        clientRelationship.client = ContactStore.instance.recursiveUpsert(clientRelationship.client!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(clientRelationship);
}

  List<ClientRelationship> recursiveListUpsert(List<ClientRelationship> clientRelationships, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedClientRelationships = <ClientRelationship>[];
    for (var clientRelationship in clientRelationships) {
        updatedClientRelationships.add(recursiveUpsert(clientRelationship, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedClientRelationships;
}

//   @override
//   ClientRelationship upsert(ClientRelationship item) {
//     return recursiveUpsert(item);
//   }

}


class ClientRelationshipInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ClientRelationshipInclude.agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (clientRelationship) => ClientRelationshipStore.instance
            .getAgent$(clientRelationship, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (clientRelationship) => ClientRelationshipStore.instance
            .getAgent(clientRelationship, modelFilter: modelFilter, includes: includes);
      }
}

	ClientRelationshipInclude.client({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (clientRelationship) => ClientRelationshipStore.instance
            .getClient$(clientRelationship, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (clientRelationship) => ClientRelationshipStore.instance
            .getClient(clientRelationship, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ClientRelationshipEndpoints implements Endpoint {

    getAll('/clientRelationship', HttpMethod.post, List<ClientRelationship>),
	getById('/clientRelationship/byId/:id', HttpMethod.post, ClientRelationship),
	getManyByAgentId('/clientRelationship/byAgentId/:agentId', HttpMethod.post, List<ClientRelationship>),
	getManyByClientId('/clientRelationship/byClientId/:clientId', HttpMethod.post, List<ClientRelationship>),
	getManyByStatus('/clientRelationship/byStatus/:status', HttpMethod.post, List<ClientRelationship>),
	getManyByFirstContact('/clientRelationship/byFirstContact/:firstContact', HttpMethod.post, List<ClientRelationship>),
	getManyByLastContact('/clientRelationship/byLastContact/:lastContact', HttpMethod.post, List<ClientRelationship>),
	getManyByContactFrequency('/clientRelationship/byContactFrequency/:contactFrequency', HttpMethod.post, List<ClientRelationship>),
	getManyByPreferredChannel('/clientRelationship/byPreferredChannel/:preferredChannel', HttpMethod.post, List<ClientRelationship>);

    const ClientRelationshipEndpoints(this.path, this.method, this.responseType);

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
