
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AgentPerformanceStore extends ModelStreamStore<String, AgentPerformance> {

  static AgentPerformanceStore? _instance;

  static AgentPerformanceStore get instance {
    _instance ??= AgentPerformanceStore();
    return _instance!;
  }

  AgentPerformanceStore() : super(AgentPerformance.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AgentPerformanceStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AgentPerformanceStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AgentPerformanceStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAgentPerformanceId(AgentPerformance agentPerformance) => agentPerformance.id;

	String? getAgentPerformanceUserId(AgentPerformance agentPerformance) => agentPerformance.userId;

	String? getAgentPerformancePeriod(AgentPerformance agentPerformance) => agentPerformance.period;

	DateTime? getAgentPerformanceStartDate(AgentPerformance agentPerformance) => agentPerformance.startDate;

	DateTime? getAgentPerformanceEndDate(AgentPerformance agentPerformance) => agentPerformance.endDate;

	int? getAgentPerformanceLeadsGenerated(AgentPerformance agentPerformance) => agentPerformance.leadsGenerated;

	int? getAgentPerformanceShowingsCompleted(AgentPerformance agentPerformance) => agentPerformance.showingsCompleted;

	int? getAgentPerformanceOffersSubmitted(AgentPerformance agentPerformance) => agentPerformance.offersSubmitted;

	int? getAgentPerformanceDealsClosed(AgentPerformance agentPerformance) => agentPerformance.dealsClosed;

	double? getAgentPerformanceCommissionEarned(AgentPerformance agentPerformance) => agentPerformance.commissionEarned;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AgentPerformance> getByUserId(
    String userId,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<AgentPerformance> getByPeriod(
    String period,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformancePeriod, period, modelFilter: modelFilter, includes: includes);

	
List<AgentPerformance> getByStartDate(
    DateTime startDate,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<AgentPerformance> getByEndDate(
    DateTime endDate,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<AgentPerformance> getByLeadsGenerated(
    int leadsGenerated,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceLeadsGenerated, leadsGenerated, modelFilter: modelFilter, includes: includes);

	
List<AgentPerformance> getByShowingsCompleted(
    int showingsCompleted,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceShowingsCompleted, showingsCompleted, modelFilter: modelFilter, includes: includes);

	
List<AgentPerformance> getByOffersSubmitted(
    int offersSubmitted,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceOffersSubmitted, offersSubmitted, modelFilter: modelFilter, includes: includes);

	
List<AgentPerformance> getByDealsClosed(
    int dealsClosed,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceDealsClosed, dealsClosed, modelFilter: modelFilter, includes: includes);

	
List<AgentPerformance> getByCommissionEarned(
    double commissionEarned,
    {ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}
    ) =>
    getManyIncluding(getAgentPerformanceCommissionEarned, commissionEarned, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getUser(
    AgentPerformance agentPerformance, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (agentPerformance.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(agentPerformance.userId!, includes: includes);
        agentPerformance.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AgentPerformance>> getAll$({bool useCache = true, ModelFilter<AgentPerformance>? modelFilter, List<AgentPerformanceInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AgentPerformanceEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AgentPerformance?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAgentPerformanceId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AgentPerformance>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentPerformanceUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentPerformance>> getByPeriod$(
        String period,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAgentPerformancePeriod,
        value: period,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByPeriod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentPerformance>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentPerformanceStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentPerformance>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAgentPerformanceEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentPerformance>> getByLeadsGenerated$(
        int leadsGenerated,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgentPerformanceLeadsGenerated,
        value: leadsGenerated,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByLeadsGenerated,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentPerformance>> getByShowingsCompleted$(
        int showingsCompleted,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgentPerformanceShowingsCompleted,
        value: showingsCompleted,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByShowingsCompleted,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentPerformance>> getByOffersSubmitted$(
        int offersSubmitted,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgentPerformanceOffersSubmitted,
        value: offersSubmitted,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByOffersSubmitted,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentPerformance>> getByDealsClosed$(
        int dealsClosed,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAgentPerformanceDealsClosed,
        value: dealsClosed,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByDealsClosed,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AgentPerformance>> getByCommissionEarned$(
        double commissionEarned,
        {bool useCache = true,
        ModelFilter<AgentPerformance>? modelFilter,
        List<AgentPerformanceInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAgentPerformanceCommissionEarned,
        value: commissionEarned,
        modelFilter: modelFilter,
        endpoint: AgentPerformanceEndpoints.getManyByCommissionEarned,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getUser$(
    AgentPerformance agentPerformance, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (agentPerformance.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            agentPerformance.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            agentPerformance.user = user;
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
AgentPerformance recursiveUpsert(AgentPerformance agentPerformance, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AgentPerformance'} 
        : const {};
    if (agentPerformance.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        agentPerformance.user = UserStore.instance.recursiveUpsert(agentPerformance.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(agentPerformance);
}

  List<AgentPerformance> recursiveListUpsert(List<AgentPerformance> agentPerformances, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAgentPerformances = <AgentPerformance>[];
    for (var agentPerformance in agentPerformances) {
        updatedAgentPerformances.add(recursiveUpsert(agentPerformance, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAgentPerformances;
}

//   @override
//   AgentPerformance upsert(AgentPerformance item) {
//     return recursiveUpsert(item);
//   }

}


class AgentPerformanceInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AgentPerformanceInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (agentPerformance) => AgentPerformanceStore.instance
            .getUser$(agentPerformance, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (agentPerformance) => AgentPerformanceStore.instance
            .getUser(agentPerformance, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AgentPerformanceEndpoints implements Endpoint {

    getAll('/agentPerformance', HttpMethod.post, List<AgentPerformance>),
	getById('/agentPerformance/byId/:id', HttpMethod.post, AgentPerformance),
	getManyByUserId('/agentPerformance/byUserId/:userId', HttpMethod.post, List<AgentPerformance>),
	getManyByPeriod('/agentPerformance/byPeriod/:period', HttpMethod.post, List<AgentPerformance>),
	getManyByStartDate('/agentPerformance/byStartDate/:startDate', HttpMethod.post, List<AgentPerformance>),
	getManyByEndDate('/agentPerformance/byEndDate/:endDate', HttpMethod.post, List<AgentPerformance>),
	getManyByLeadsGenerated('/agentPerformance/byLeadsGenerated/:leadsGenerated', HttpMethod.post, List<AgentPerformance>),
	getManyByShowingsCompleted('/agentPerformance/byShowingsCompleted/:showingsCompleted', HttpMethod.post, List<AgentPerformance>),
	getManyByOffersSubmitted('/agentPerformance/byOffersSubmitted/:offersSubmitted', HttpMethod.post, List<AgentPerformance>),
	getManyByDealsClosed('/agentPerformance/byDealsClosed/:dealsClosed', HttpMethod.post, List<AgentPerformance>),
	getManyByCommissionEarned('/agentPerformance/byCommissionEarned/:commissionEarned', HttpMethod.post, List<AgentPerformance>);

    const AgentPerformanceEndpoints(this.path, this.method, this.responseType);

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
