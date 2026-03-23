
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AgentTeamStore extends ModelStreamStore<String, AgentTeam> {

  static AgentTeamStore? _instance;

  static AgentTeamStore get instance {
    _instance ??= AgentTeamStore();
    return _instance!;
  }

  AgentTeamStore() : super(AgentTeam.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AgentTeamStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AgentTeamStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AgentTeamStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAgentTeamId(AgentTeam agentTeam) => agentTeam.id;

	String? getAgentTeamOrgId(AgentTeam agentTeam) => agentTeam.orgId;

	String? getAgentTeamName(AgentTeam agentTeam) => agentTeam.name;

	String? getAgentTeamLeaderId(AgentTeam agentTeam) => agentTeam.leaderId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AgentTeam> getByOrgId(
    String orgId,
    {ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}
    ) =>
    getManyIncluding(getAgentTeamOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AgentTeam> getByName(
    String name,
    {ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}
    ) =>
    getManyIncluding(getAgentTeamName, name, modelFilter: modelFilter, includes: includes);

	
List<AgentTeam> getByLeaderId(
    String leaderId,
    {ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}
    ) =>
    getManyIncluding(getAgentTeamLeaderId, leaderId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getLeader(
    AgentTeam agentTeam, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (agentTeam.leaderId == null) {
        return null;
    } else {
        final leader = UserStore.instance.getById(agentTeam.leaderId!, includes: includes);
        agentTeam.leader = leader;
        // setIncludedReferences(leader, includes: includes);
        return leader;
    }
}

	Organization? getOrg(
    AgentTeam agentTeam, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (agentTeam.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(agentTeam.orgId!, includes: includes);
        agentTeam.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<AgentTeamMember> getMembers(
    AgentTeam agentTeam, {ModelFilter<AgentTeamMember>? modelFilter, List<AgentTeamMemberInclude>? includes}) {
    final members = AgentTeamMemberStore.instance.getByTeamId(agentTeam.$uid!, modelFilter: modelFilter, includes: includes);
    agentTeam.members = members;
    // setIncludedReferencesForList(members, includes: includes);
    return members;
}

	List<Lead> getLeads(
    AgentTeam agentTeam, {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final leads = LeadStore.instance.getByAgentTeamId(agentTeam.$uid!, modelFilter: modelFilter, includes: includes);
    agentTeam.leads = leads;
    // setIncludedReferencesForList(leads, includes: includes);
    return leads;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AgentTeam>> getAll$({bool useCache = true, ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AgentTeamEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AgentTeam?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AgentTeam>? modelFilter,
        List<AgentTeamInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgentTeamId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AgentTeamEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AgentTeam>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AgentTeam>? modelFilter,
        List<AgentTeamInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentTeamOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AgentTeamEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentTeam>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<AgentTeam>? modelFilter,
        List<AgentTeamInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentTeamName,
        value: name,
        modelFilter: modelFilter,
        endpoint: AgentTeamEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentTeam>> getByLeaderId$(
        String leaderId,
        {bool useCache = true,
        ModelFilter<AgentTeam>? modelFilter,
        List<AgentTeamInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentTeamLeaderId,
        value: leaderId,
        modelFilter: modelFilter,
        endpoint: AgentTeamEndpoints.getManyByLeaderId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getLeader$(
    AgentTeam agentTeam, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (agentTeam.leaderId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            agentTeam.leaderId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((leader) {
            agentTeam.leader = leader;
        });
    }
}

	Stream<Organization?> getOrg$(
    AgentTeam agentTeam, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (agentTeam.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            agentTeam.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            agentTeam.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AgentTeamMember>> getMembers$(
    AgentTeam agentTeam, {bool useCache = true, ModelFilter<AgentTeamMember>? modelFilter, List<AgentTeamMemberInclude>? includes}) {
    return AgentTeamMemberStore.instance.getByTeamId$(
        agentTeam.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((members) {
        agentTeam.members = members;
    });

}

	Stream<List<Lead>> getLeads$(
    AgentTeam agentTeam, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    return LeadStore.instance.getByAgentTeamId$(
        agentTeam.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leads) {
        agentTeam.leads = leads;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AgentTeam recursiveUpsert(AgentTeam agentTeam, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AgentTeam'} 
        : const {};
    if (agentTeam.leader != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        agentTeam.leader = UserStore.instance.recursiveUpsert(agentTeam.leader!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agentTeam.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        agentTeam.org = OrganizationStore.instance.recursiveUpsert(agentTeam.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agentTeam.members != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentTeamMember'))) {
        agentTeam.members = AgentTeamMemberStore.instance.recursiveListUpsert(agentTeam.members!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agentTeam.leads != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        agentTeam.leads = LeadStore.instance.recursiveListUpsert(agentTeam.leads!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(agentTeam);
}

  List<AgentTeam> recursiveListUpsert(List<AgentTeam> agentTeams, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAgentTeams = <AgentTeam>[];
    for (var agentTeam in agentTeams) {
        updatedAgentTeams.add(recursiveUpsert(agentTeam, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAgentTeams;
}

//   @override
//   AgentTeam upsert(AgentTeam item) {
//     return recursiveUpsert(item);
//   }

}


class AgentTeamInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AgentTeamInclude.leader({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentTeam) => AgentTeamStore.instance
            .getLeader$(agentTeam, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentTeam) => AgentTeamStore.instance
            .getLeader(agentTeam, modelFilter: modelFilter, includes: includes);
      }
}

	AgentTeamInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentTeam) => AgentTeamStore.instance
            .getOrg$(agentTeam, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentTeam) => AgentTeamStore.instance
            .getOrg(agentTeam, modelFilter: modelFilter, includes: includes);
      }
}

	AgentTeamInclude.members({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentTeamMember>? modelFilter,
    List<AgentTeamMemberInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentTeam) => AgentTeamStore.instance
            .getMembers$(agentTeam, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentTeam) => AgentTeamStore.instance
            .getMembers(agentTeam, modelFilter: modelFilter, includes: includes);
      }
}

	AgentTeamInclude.leads({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentTeam) => AgentTeamStore.instance
            .getLeads$(agentTeam, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentTeam) => AgentTeamStore.instance
            .getLeads(agentTeam, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AgentTeamEndpoints implements Endpoint {

    getAll('/agentTeam', HttpMethod.post, List<AgentTeam>),
	getById('/agentTeam/byId/:id', HttpMethod.post, AgentTeam),
	getManyByOrgId('/agentTeam/byOrgId/:orgId', HttpMethod.post, List<AgentTeam>),
	getManyByName('/agentTeam/byName/:name', HttpMethod.post, List<AgentTeam>),
	getManyByLeaderId('/agentTeam/byLeaderId/:leaderId', HttpMethod.post, List<AgentTeam>);

    const AgentTeamEndpoints(this.path, this.method, this.responseType);

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
