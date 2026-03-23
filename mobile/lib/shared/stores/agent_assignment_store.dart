
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AgentAssignmentStore extends ModelStreamStore<String, AgentAssignment> {

  static AgentAssignmentStore? _instance;

  static AgentAssignmentStore get instance {
    _instance ??= AgentAssignmentStore();
    return _instance!;
  }

  AgentAssignmentStore() : super(AgentAssignment.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AgentAssignmentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AgentAssignmentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AgentAssignmentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAgentAssignmentId(AgentAssignment agentAssignment) => agentAssignment.id;

	String? getAgentAssignmentOrgId(AgentAssignment agentAssignment) => agentAssignment.orgId;

	String? getAgentAssignmentListingId(AgentAssignment agentAssignment) => agentAssignment.listingId;

	String? getAgentAssignmentAgentUserId(AgentAssignment agentAssignment) => agentAssignment.agentUserId;

	String? getAgentAssignmentAgencyOrgId(AgentAssignment agentAssignment) => agentAssignment.agencyOrgId;

	int? getAgentAssignmentCommissionBps(AgentAssignment agentAssignment) => agentAssignment.commissionBps;

	DateTime? getAgentAssignmentCreatedAt(AgentAssignment agentAssignment) => agentAssignment.createdAt;

	DateTime? getAgentAssignmentUpdatedAt(AgentAssignment agentAssignment) => agentAssignment.updatedAt;

	DateTime? getAgentAssignmentDeletedAt(AgentAssignment agentAssignment) => agentAssignment.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AgentAssignment> getByOrgId(
    String orgId,
    {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAssignmentOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AgentAssignment> getByListingId(
    String listingId,
    {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAssignmentListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<AgentAssignment> getByAgentUserId(
    String agentUserId,
    {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAssignmentAgentUserId, agentUserId, modelFilter: modelFilter, includes: includes);

	
List<AgentAssignment> getByAgencyOrgId(
    String agencyOrgId,
    {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAssignmentAgencyOrgId, agencyOrgId, modelFilter: modelFilter, includes: includes);

	
List<AgentAssignment> getByCommissionBps(
    int commissionBps,
    {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAssignmentCommissionBps, commissionBps, modelFilter: modelFilter, includes: includes);

	
List<AgentAssignment> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAssignmentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AgentAssignment> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAssignmentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<AgentAssignment> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}
    ) =>
    getManyIncluding(getAgentAssignmentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getAgent(
    AgentAssignment agentAssignment, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (agentAssignment.agentUserId == null) {
        return null;
    } else {
        final agent = UserStore.instance.getById(agentAssignment.agentUserId!, includes: includes);
        agentAssignment.agent = agent;
        // setIncludedReferences(agent, includes: includes);
        return agent;
    }
}

	Listing? getListing(
    AgentAssignment agentAssignment, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (agentAssignment.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(agentAssignment.listingId!, includes: includes);
        agentAssignment.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    AgentAssignment agentAssignment, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (agentAssignment.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(agentAssignment.orgId!, includes: includes);
        agentAssignment.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AgentAssignment>> getAll$({bool useCache = true, ModelFilter<AgentAssignment>? modelFilter, List<AgentAssignmentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AgentAssignmentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AgentAssignment?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgentAssignmentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AgentAssignment>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentAssignmentOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentAssignment>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentAssignmentListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentAssignment>> getByAgentUserId$(
        String agentUserId,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentAssignmentAgentUserId,
        value: agentUserId,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getManyByAgentUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentAssignment>> getByAgencyOrgId$(
        String agencyOrgId,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentAssignmentAgencyOrgId,
        value: agencyOrgId,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getManyByAgencyOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentAssignment>> getByCommissionBps$(
        int commissionBps,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgentAssignmentCommissionBps,
        value: commissionBps,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getManyByCommissionBps,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentAssignment>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentAssignmentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentAssignment>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentAssignmentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentAssignment>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<AgentAssignment>? modelFilter,
        List<AgentAssignmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentAssignmentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AgentAssignmentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getAgent$(
    AgentAssignment agentAssignment, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (agentAssignment.agentUserId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            agentAssignment.agentUserId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((agent) {
            agentAssignment.agent = agent;
        });
    }
}

	Stream<Listing?> getListing$(
    AgentAssignment agentAssignment, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (agentAssignment.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            agentAssignment.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            agentAssignment.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    AgentAssignment agentAssignment, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (agentAssignment.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            agentAssignment.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            agentAssignment.org = org;
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
AgentAssignment recursiveUpsert(AgentAssignment agentAssignment, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AgentAssignment'} 
        : const {};
    if (agentAssignment.agent != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        agentAssignment.agent = UserStore.instance.recursiveUpsert(agentAssignment.agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agentAssignment.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        agentAssignment.listing = ListingStore.instance.recursiveUpsert(agentAssignment.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (agentAssignment.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        agentAssignment.org = OrganizationStore.instance.recursiveUpsert(agentAssignment.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(agentAssignment);
}

  List<AgentAssignment> recursiveListUpsert(List<AgentAssignment> agentAssignments, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAgentAssignments = <AgentAssignment>[];
    for (var agentAssignment in agentAssignments) {
        updatedAgentAssignments.add(recursiveUpsert(agentAssignment, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAgentAssignments;
}

//   @override
//   AgentAssignment upsert(AgentAssignment item) {
//     return recursiveUpsert(item);
//   }

}


class AgentAssignmentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AgentAssignmentInclude.agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentAssignment) => AgentAssignmentStore.instance
            .getAgent$(agentAssignment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentAssignment) => AgentAssignmentStore.instance
            .getAgent(agentAssignment, modelFilter: modelFilter, includes: includes);
      }
}

	AgentAssignmentInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentAssignment) => AgentAssignmentStore.instance
            .getListing$(agentAssignment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentAssignment) => AgentAssignmentStore.instance
            .getListing(agentAssignment, modelFilter: modelFilter, includes: includes);
      }
}

	AgentAssignmentInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentAssignment) => AgentAssignmentStore.instance
            .getOrg$(agentAssignment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentAssignment) => AgentAssignmentStore.instance
            .getOrg(agentAssignment, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AgentAssignmentEndpoints implements Endpoint {

    getAll('/agentAssignment', HttpMethod.post, List<AgentAssignment>),
	getById('/agentAssignment/byId/:id', HttpMethod.post, AgentAssignment),
	getManyByOrgId('/agentAssignment/byOrgId/:orgId', HttpMethod.post, List<AgentAssignment>),
	getManyByListingId('/agentAssignment/byListingId/:listingId', HttpMethod.post, List<AgentAssignment>),
	getManyByAgentUserId('/agentAssignment/byAgentUserId/:agentUserId', HttpMethod.post, List<AgentAssignment>),
	getManyByAgencyOrgId('/agentAssignment/byAgencyOrgId/:agencyOrgId', HttpMethod.post, List<AgentAssignment>),
	getManyByCommissionBps('/agentAssignment/byCommissionBps/:commissionBps', HttpMethod.post, List<AgentAssignment>),
	getManyByCreatedAt('/agentAssignment/byCreatedAt/:createdAt', HttpMethod.post, List<AgentAssignment>),
	getManyByUpdatedAt('/agentAssignment/byUpdatedAt/:updatedAt', HttpMethod.post, List<AgentAssignment>),
	getManyByDeletedAt('/agentAssignment/byDeletedAt/:deletedAt', HttpMethod.post, List<AgentAssignment>);

    const AgentAssignmentEndpoints(this.path, this.method, this.responseType);

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
