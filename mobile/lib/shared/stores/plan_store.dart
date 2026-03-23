
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PlanStore extends ModelStreamStore<String, Plan> {

  static PlanStore? _instance;

  static PlanStore get instance {
    _instance ??= PlanStore();
    return _instance!;
  }

  PlanStore() : super(Plan.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PlanStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PlanStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PlanStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPlanId(Plan plan) => plan.id;

	String? getPlanKey(Plan plan) => plan.key;

	String? getPlanName(Plan plan) => plan.name;

	dynamic? getPlanLimits(Plan plan) => plan.limits;

	int? getPlanPriceMonthlyCents(Plan plan) => plan.priceMonthlyCents;

	DateTime? getPlanCreatedAt(Plan plan) => plan.createdAt;

	DateTime? getPlanUpdatedAt(Plan plan) => plan.updatedAt;

	DateTime? getPlanDeletedAt(Plan plan) => plan.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Plan? getByKeyField(
    String key,
    {ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}
    ) =>
    getIncluding(getPlanKey, key, modelFilter: modelFilter, includes: includes);

  
List<Plan> getByName(
    String name,
    {ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}
    ) =>
    getManyIncluding(getPlanName, name, modelFilter: modelFilter, includes: includes);

	
List<Plan> getByLimits(
    dynamic limits,
    {ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}
    ) =>
    getManyIncluding(getPlanLimits, limits, modelFilter: modelFilter, includes: includes);

	
List<Plan> getByPriceMonthlyCents(
    int priceMonthlyCents,
    {ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}
    ) =>
    getManyIncluding(getPlanPriceMonthlyCents, priceMonthlyCents, modelFilter: modelFilter, includes: includes);

	
List<Plan> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}
    ) =>
    getManyIncluding(getPlanCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Plan> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}
    ) =>
    getManyIncluding(getPlanUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Plan> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}
    ) =>
    getManyIncluding(getPlanDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  List<OrgSubscription> getOrgSubscriptions(
    Plan plan, {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}) {
    final orgSubscriptions = OrgSubscriptionStore.instance.getByPlanId(plan.$uid!, modelFilter: modelFilter, includes: includes);
    plan.orgSubscriptions = orgSubscriptions;
    // setIncludedReferencesForList(orgSubscriptions, includes: includes);
    return orgSubscriptions;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Plan>> getAll$({bool useCache = true, ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PlanEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Plan?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Plan>? modelFilter,
        List<PlanInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPlanId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PlanEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Plan?> getByKeyField$(
        String key,
        {bool useCache = true,
        ModelFilter<Plan>? modelFilter,
        List<PlanInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPlanKey,
        value: key,
        modelFilter: modelFilter,
        endpoint: PlanEndpoints.getByKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Plan>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Plan>? modelFilter,
        List<PlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPlanName,
        value: name,
        modelFilter: modelFilter,
        endpoint: PlanEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Plan>> getByLimits$(
        dynamic limits,
        {bool useCache = true,
        ModelFilter<Plan>? modelFilter,
        List<PlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPlanLimits,
        value: limits,
        modelFilter: modelFilter,
        endpoint: PlanEndpoints.getManyByLimits,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Plan>> getByPriceMonthlyCents$(
        int priceMonthlyCents,
        {bool useCache = true,
        ModelFilter<Plan>? modelFilter,
        List<PlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPlanPriceMonthlyCents,
        value: priceMonthlyCents,
        modelFilter: modelFilter,
        endpoint: PlanEndpoints.getManyByPriceMonthlyCents,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Plan>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Plan>? modelFilter,
        List<PlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPlanCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PlanEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Plan>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Plan>? modelFilter,
        List<PlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPlanUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PlanEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Plan>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Plan>? modelFilter,
        List<PlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPlanDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PlanEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  Stream<List<OrgSubscription>> getOrgSubscriptions$(
    Plan plan, {bool useCache = true, ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}) {
    return OrgSubscriptionStore.instance.getByPlanId$(
        plan.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((orgSubscriptions) {
        plan.orgSubscriptions = orgSubscriptions;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Plan recursiveUpsert(Plan plan, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Plan'} 
        : const {};
    if (plan.orgSubscriptions != null && (!preventCircularSerialization || !upsertedTypes.contains('OrgSubscription'))) {
        plan.orgSubscriptions = OrgSubscriptionStore.instance.recursiveListUpsert(plan.orgSubscriptions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(plan);
}

  List<Plan> recursiveListUpsert(List<Plan> plans, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPlans = <Plan>[];
    for (var plan in plans) {
        updatedPlans.add(recursiveUpsert(plan, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPlans;
}

//   @override
//   Plan upsert(Plan item) {
//     return recursiveUpsert(item);
//   }

}


class PlanInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PlanInclude.orgSubscriptions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<OrgSubscription>? modelFilter,
    List<OrgSubscriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (plan) => PlanStore.instance
            .getOrgSubscriptions$(plan, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (plan) => PlanStore.instance
            .getOrgSubscriptions(plan, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PlanEndpoints implements Endpoint {

    getAll('/plan', HttpMethod.post, List<Plan>),
	getById('/plan/byId/:id', HttpMethod.post, Plan),
	getByKey('/plan/byKey/:key', HttpMethod.post, Plan),
	getManyByName('/plan/byName/:name', HttpMethod.post, List<Plan>),
	getManyByLimits('/plan/byLimits/:limits', HttpMethod.post, List<Plan>),
	getManyByPriceMonthlyCents('/plan/byPriceMonthlyCents/:priceMonthlyCents', HttpMethod.post, List<Plan>),
	getManyByCreatedAt('/plan/byCreatedAt/:createdAt', HttpMethod.post, List<Plan>),
	getManyByUpdatedAt('/plan/byUpdatedAt/:updatedAt', HttpMethod.post, List<Plan>),
	getManyByDeletedAt('/plan/byDeletedAt/:deletedAt', HttpMethod.post, List<Plan>);

    const PlanEndpoints(this.path, this.method, this.responseType);

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
