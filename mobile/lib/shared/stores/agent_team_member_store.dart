
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AgentTeamMemberStore extends ModelStreamStore<String, AgentTeamMember> {

  static AgentTeamMemberStore? _instance;

  static AgentTeamMemberStore get instance {
    _instance ??= AgentTeamMemberStore();
    return _instance!;
  }

  AgentTeamMemberStore() : super(AgentTeamMember.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AgentTeamMemberStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AgentTeamMemberStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AgentTeamMemberStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAgentTeamMemberId(AgentTeamMember agentTeamMember) => agentTeamMember.id;

	String? getAgentTeamMemberTeamId(AgentTeamMember agentTeamMember) => agentTeamMember.teamId;

	String? getAgentTeamMemberUserId(AgentTeamMember agentTeamMember) => agentTeamMember.userId;

	String? getAgentTeamMemberRole(AgentTeamMember agentTeamMember) => agentTeamMember.role;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AgentTeamMember> getByTeamId(
    String teamId,
    {ModelFilter<AgentTeamMember>? modelFilter, List<AgentTeamMemberInclude>? includes}
    ) =>
    getManyIncluding(getAgentTeamMemberTeamId, teamId, modelFilter: modelFilter, includes: includes);

	
List<AgentTeamMember> getByUserId(
    String userId,
    {ModelFilter<AgentTeamMember>? modelFilter, List<AgentTeamMemberInclude>? includes}
    ) =>
    getManyIncluding(getAgentTeamMemberUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<AgentTeamMember> getByRole(
    String role,
    {ModelFilter<AgentTeamMember>? modelFilter, List<AgentTeamMemberInclude>? includes}
    ) =>
    getManyIncluding(getAgentTeamMemberRole, role, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  AgentTeam? getTeam(
    AgentTeamMember agentTeamMember, {ModelFilter? modelFilter, List<AgentTeamInclude>? includes}) {
    if (agentTeamMember.teamId == null) {
        return null;
    } else {
        final team = AgentTeamStore.instance.getById(agentTeamMember.teamId!, includes: includes);
        agentTeamMember.team = team;
        // setIncludedReferences(team, includes: includes);
        return team;
    }
}

	User? getUser(
    AgentTeamMember agentTeamMember, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (agentTeamMember.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(agentTeamMember.userId!, includes: includes);
        agentTeamMember.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AgentTeamMember>> getAll$({bool useCache = true, ModelFilter<AgentTeamMember>? modelFilter, List<AgentTeamMemberInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AgentTeamMemberEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AgentTeamMember?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AgentTeamMember>? modelFilter,
        List<AgentTeamMemberInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgentTeamMemberId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AgentTeamMemberEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AgentTeamMember>> getByTeamId$(
        String teamId,
        {bool useCache = true,
        ModelFilter<AgentTeamMember>? modelFilter,
        List<AgentTeamMemberInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentTeamMemberTeamId,
        value: teamId,
        modelFilter: modelFilter,
        endpoint: AgentTeamMemberEndpoints.getManyByTeamId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentTeamMember>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<AgentTeamMember>? modelFilter,
        List<AgentTeamMemberInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentTeamMemberUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AgentTeamMemberEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentTeamMember>> getByRole$(
        String role,
        {bool useCache = true,
        ModelFilter<AgentTeamMember>? modelFilter,
        List<AgentTeamMemberInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentTeamMemberRole,
        value: role,
        modelFilter: modelFilter,
        endpoint: AgentTeamMemberEndpoints.getManyByRole,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<AgentTeam?> getTeam$(
    AgentTeamMember agentTeamMember, {bool useCache = true, ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}) {
    if (agentTeamMember.teamId == null) {
        return Stream.value(null);
    } else {
        return AgentTeamStore.instance.getById$(
            agentTeamMember.teamId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((team) {
            agentTeamMember.team = team;
        });
    }
}

	Stream<User?> getUser$(
    AgentTeamMember agentTeamMember, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (agentTeamMember.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            agentTeamMember.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            agentTeamMember.user = user;
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
AgentTeamMember recursiveUpsert(AgentTeamMember agentTeamMember, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AgentTeamMember'} 
        : const {};
    if (agentTeamMember.team != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentTeam'))) {
        agentTeamMember.team = AgentTeamStore.instance.recursiveUpsert(agentTeamMember.team!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agentTeamMember.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        agentTeamMember.user = UserStore.instance.recursiveUpsert(agentTeamMember.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(agentTeamMember);
}

  List<AgentTeamMember> recursiveListUpsert(List<AgentTeamMember> agentTeamMembers, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAgentTeamMembers = <AgentTeamMember>[];
    for (var agentTeamMember in agentTeamMembers) {
        updatedAgentTeamMembers.add(recursiveUpsert(agentTeamMember, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAgentTeamMembers;
}

//   @override
//   AgentTeamMember upsert(AgentTeamMember item) {
//     return recursiveUpsert(item);
//   }

}


class AgentTeamMemberInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AgentTeamMemberInclude.team({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentTeam>? modelFilter,
    List<AgentTeamInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentTeamMember) => AgentTeamMemberStore.instance
            .getTeam$(agentTeamMember, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentTeamMember) => AgentTeamMemberStore.instance
            .getTeam(agentTeamMember, modelFilter: modelFilter, includes: includes);
      }
}

	AgentTeamMemberInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentTeamMember) => AgentTeamMemberStore.instance
            .getUser$(agentTeamMember, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentTeamMember) => AgentTeamMemberStore.instance
            .getUser(agentTeamMember, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AgentTeamMemberEndpoints implements Endpoint {

    getAll('/agentTeamMember', HttpMethod.post, List<AgentTeamMember>),
	getById('/agentTeamMember/byId/:id', HttpMethod.post, AgentTeamMember),
	getManyByTeamId('/agentTeamMember/byTeamId/:teamId', HttpMethod.post, List<AgentTeamMember>),
	getManyByUserId('/agentTeamMember/byUserId/:userId', HttpMethod.post, List<AgentTeamMember>),
	getManyByRole('/agentTeamMember/byRole/:role', HttpMethod.post, List<AgentTeamMember>);

    const AgentTeamMemberEndpoints(this.path, this.method, this.responseType);

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
