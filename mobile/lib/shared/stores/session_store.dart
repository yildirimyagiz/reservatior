
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SessionStore extends ModelStreamStore<String, Session> {

  static SessionStore? _instance;

  static SessionStore get instance {
    _instance ??= SessionStore();
    return _instance!;
  }

  SessionStore() : super(Session.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SessionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SessionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SessionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSessionId(Session session) => session.id;

	String? getSessionUserId(Session session) => session.userId;

	String? getSessionTokenHash(Session session) => session.tokenHash;

	DateTime? getSessionExpiresAt(Session session) => session.expiresAt;

	String? getSessionIp(Session session) => session.ip;

	String? getSessionUserAgent(Session session) => session.userAgent;

	DateTime? getSessionCreatedAt(Session session) => session.createdAt;

	DateTime? getSessionUpdatedAt(Session session) => session.updatedAt;

	DateTime? getSessionDeletedAt(Session session) => session.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Session? getByTokenHash(
    String tokenHash,
    {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}
    ) =>
    getIncluding(getSessionTokenHash, tokenHash, modelFilter: modelFilter, includes: includes);

  
List<Session> getByUserId(
    String userId,
    {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}
    ) =>
    getManyIncluding(getSessionUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Session> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}
    ) =>
    getManyIncluding(getSessionExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<Session> getByIp(
    String ip,
    {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}
    ) =>
    getManyIncluding(getSessionIp, ip, modelFilter: modelFilter, includes: includes);

	
List<Session> getByUserAgent(
    String userAgent,
    {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}
    ) =>
    getManyIncluding(getSessionUserAgent, userAgent, modelFilter: modelFilter, includes: includes);

	
List<Session> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}
    ) =>
    getManyIncluding(getSessionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Session> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}
    ) =>
    getManyIncluding(getSessionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Session> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}
    ) =>
    getManyIncluding(getSessionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getUser(
    Session session, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (session.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(session.userId!, includes: includes);
        session.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Session>> getAll$({bool useCache = true, ModelFilter<Session>? modelFilter, List<SessionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SessionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Session?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSessionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Session?> getByTokenHash$(
        String tokenHash,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSessionTokenHash,
        value: tokenHash,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getByTokenHash,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Session>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSessionUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Session>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSessionExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Session>> getByIp$(
        String ip,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSessionIp,
        value: ip,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getManyByIp,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Session>> getByUserAgent$(
        String userAgent,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSessionUserAgent,
        value: userAgent,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getManyByUserAgent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Session>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSessionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Session>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSessionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Session>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Session>? modelFilter,
        List<SessionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSessionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: SessionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getUser$(
    Session session, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (session.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            session.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            session.user = user;
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
Session recursiveUpsert(Session session, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Session'} 
        : const {};
    if (session.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        session.user = UserStore.instance.recursiveUpsert(session.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(session);
}

  List<Session> recursiveListUpsert(List<Session> sessions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSessions = <Session>[];
    for (var session in sessions) {
        updatedSessions.add(recursiveUpsert(session, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSessions;
}

//   @override
//   Session upsert(Session item) {
//     return recursiveUpsert(item);
//   }

}


class SessionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SessionInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (session) => SessionStore.instance
            .getUser$(session, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (session) => SessionStore.instance
            .getUser(session, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SessionEndpoints implements Endpoint {

    getAll('/session', HttpMethod.post, List<Session>),
	getById('/session/byId/:id', HttpMethod.post, Session),
	getManyByUserId('/session/byUserId/:userId', HttpMethod.post, List<Session>),
	getByTokenHash('/session/byTokenHash/:tokenHash', HttpMethod.post, Session),
	getManyByExpiresAt('/session/byExpiresAt/:expiresAt', HttpMethod.post, List<Session>),
	getManyByIp('/session/byIp/:ip', HttpMethod.post, List<Session>),
	getManyByUserAgent('/session/byUserAgent/:userAgent', HttpMethod.post, List<Session>),
	getManyByCreatedAt('/session/byCreatedAt/:createdAt', HttpMethod.post, List<Session>),
	getManyByUpdatedAt('/session/byUpdatedAt/:updatedAt', HttpMethod.post, List<Session>),
	getManyByDeletedAt('/session/byDeletedAt/:deletedAt', HttpMethod.post, List<Session>);

    const SessionEndpoints(this.path, this.method, this.responseType);

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
