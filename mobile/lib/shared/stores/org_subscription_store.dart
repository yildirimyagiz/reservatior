
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class OrgSubscriptionStore extends ModelStreamStore<String, OrgSubscription> {

  static OrgSubscriptionStore? _instance;

  static OrgSubscriptionStore get instance {
    _instance ??= OrgSubscriptionStore();
    return _instance!;
  }

  OrgSubscriptionStore() : super(OrgSubscription.fromJson) {
    if (_instance != null) {
        throw Exception(
            'OrgSubscriptionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending OrgSubscriptionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use OrgSubscriptionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getOrgSubscriptionId(OrgSubscription orgSubscription) => orgSubscription.id;

	String? getOrgSubscriptionOrgId(OrgSubscription orgSubscription) => orgSubscription.orgId;

	String? getOrgSubscriptionPlanId(OrgSubscription orgSubscription) => orgSubscription.planId;

	String? getOrgSubscriptionStatus(OrgSubscription orgSubscription) => orgSubscription.status;

	String? getOrgSubscriptionStripeCustomerId(OrgSubscription orgSubscription) => orgSubscription.stripeCustomerId;

	String? getOrgSubscriptionStripeSubscriptionId(OrgSubscription orgSubscription) => orgSubscription.stripeSubscriptionId;

	DateTime? getOrgSubscriptionCurrentPeriodEnd(OrgSubscription orgSubscription) => orgSubscription.currentPeriodEnd;

	DateTime? getOrgSubscriptionCreatedAt(OrgSubscription orgSubscription) => orgSubscription.createdAt;

	DateTime? getOrgSubscriptionUpdatedAt(OrgSubscription orgSubscription) => orgSubscription.updatedAt;

	DateTime? getOrgSubscriptionDeletedAt(OrgSubscription orgSubscription) => orgSubscription.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
OrgSubscription? getByOrgId(
    String orgId,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getIncluding(getOrgSubscriptionOrgId, orgId, modelFilter: modelFilter, includes: includes);

  
List<OrgSubscription> getByPlanId(
    String planId,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getOrgSubscriptionPlanId, planId, modelFilter: modelFilter, includes: includes);

	
List<OrgSubscription> getByStatus(
    String status,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getOrgSubscriptionStatus, status, modelFilter: modelFilter, includes: includes);

	
List<OrgSubscription> getByStripeCustomerId(
    String stripeCustomerId,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getOrgSubscriptionStripeCustomerId, stripeCustomerId, modelFilter: modelFilter, includes: includes);

	
List<OrgSubscription> getByStripeSubscriptionId(
    String stripeSubscriptionId,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getOrgSubscriptionStripeSubscriptionId, stripeSubscriptionId, modelFilter: modelFilter, includes: includes);

	
List<OrgSubscription> getByCurrentPeriodEnd(
    DateTime currentPeriodEnd,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getOrgSubscriptionCurrentPeriodEnd, currentPeriodEnd, modelFilter: modelFilter, includes: includes);

	
List<OrgSubscription> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getOrgSubscriptionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<OrgSubscription> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getOrgSubscriptionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<OrgSubscription> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getOrgSubscriptionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    OrgSubscription orgSubscription, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (orgSubscription.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(orgSubscription.orgId!, includes: includes);
        orgSubscription.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Plan? getPlan(
    OrgSubscription orgSubscription, {ModelFilter? modelFilter, List<PlanInclude>? includes}) {
    if (orgSubscription.planId == null) {
        return null;
    } else {
        final plan = PlanStore.instance.getById(orgSubscription.planId!, includes: includes);
        orgSubscription.plan = plan;
        // setIncludedReferences(plan, includes: includes);
        return plan;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<OrgSubscription>> getAll$({bool useCache = true, ModelFilter<OrgSubscription>? modelFilter, List<OrgSubscriptionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: OrgSubscriptionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<OrgSubscription?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getOrgSubscriptionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<OrgSubscription?> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getOrgSubscriptionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<OrgSubscription>> getByPlanId$(
        String planId,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrgSubscriptionPlanId,
        value: planId,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getManyByPlanId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OrgSubscription>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrgSubscriptionStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OrgSubscription>> getByStripeCustomerId$(
        String stripeCustomerId,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrgSubscriptionStripeCustomerId,
        value: stripeCustomerId,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getManyByStripeCustomerId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OrgSubscription>> getByStripeSubscriptionId$(
        String stripeSubscriptionId,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOrgSubscriptionStripeSubscriptionId,
        value: stripeSubscriptionId,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getManyByStripeSubscriptionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OrgSubscription>> getByCurrentPeriodEnd$(
        DateTime currentPeriodEnd,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOrgSubscriptionCurrentPeriodEnd,
        value: currentPeriodEnd,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getManyByCurrentPeriodEnd,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OrgSubscription>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOrgSubscriptionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OrgSubscription>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOrgSubscriptionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OrgSubscription>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<OrgSubscription>? modelFilter,
        List<OrgSubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOrgSubscriptionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: OrgSubscriptionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    OrgSubscription orgSubscription, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (orgSubscription.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            orgSubscription.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            orgSubscription.org = org;
        });
    }
}

	Stream<Plan?> getPlan$(
    OrgSubscription orgSubscription, {bool useCache = true, ModelFilter<Plan>? modelFilter, List<PlanInclude>? includes}) {
    if (orgSubscription.planId == null) {
        return Stream.value(null);
    } else {
        return PlanStore.instance.getById$(
            orgSubscription.planId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((plan) {
            orgSubscription.plan = plan;
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
OrgSubscription recursiveUpsert(OrgSubscription orgSubscription, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'OrgSubscription'} 
        : const {};
    if (orgSubscription.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        orgSubscription.org = OrganizationStore.instance.recursiveUpsert(orgSubscription.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (orgSubscription.plan != null && (!preventCircularSerialization || !upsertedTypes.contains('Plan'))) {
        orgSubscription.plan = PlanStore.instance.recursiveUpsert(orgSubscription.plan!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(orgSubscription);
}

  List<OrgSubscription> recursiveListUpsert(List<OrgSubscription> orgSubscriptions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedOrgSubscriptions = <OrgSubscription>[];
    for (var orgSubscription in orgSubscriptions) {
        updatedOrgSubscriptions.add(recursiveUpsert(orgSubscription, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedOrgSubscriptions;
}

//   @override
//   OrgSubscription upsert(OrgSubscription item) {
//     return recursiveUpsert(item);
//   }

}


class OrgSubscriptionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      OrgSubscriptionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (orgSubscription) => OrgSubscriptionStore.instance
            .getOrg$(orgSubscription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (orgSubscription) => OrgSubscriptionStore.instance
            .getOrg(orgSubscription, modelFilter: modelFilter, includes: includes);
      }
}

	OrgSubscriptionInclude.plan({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Plan>? modelFilter,
    List<PlanInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (orgSubscription) => OrgSubscriptionStore.instance
            .getPlan$(orgSubscription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (orgSubscription) => OrgSubscriptionStore.instance
            .getPlan(orgSubscription, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum OrgSubscriptionEndpoints implements Endpoint {

    getAll('/orgSubscription', HttpMethod.post, List<OrgSubscription>),
	getById('/orgSubscription/byId/:id', HttpMethod.post, OrgSubscription),
	getByOrgId('/orgSubscription/byOrgId/:orgId', HttpMethod.post, OrgSubscription),
	getManyByPlanId('/orgSubscription/byPlanId/:planId', HttpMethod.post, List<OrgSubscription>),
	getManyByStatus('/orgSubscription/byStatus/:status', HttpMethod.post, List<OrgSubscription>),
	getManyByStripeCustomerId('/orgSubscription/byStripeCustomerId/:stripeCustomerId', HttpMethod.post, List<OrgSubscription>),
	getManyByStripeSubscriptionId('/orgSubscription/byStripeSubscriptionId/:stripeSubscriptionId', HttpMethod.post, List<OrgSubscription>),
	getManyByCurrentPeriodEnd('/orgSubscription/byCurrentPeriodEnd/:currentPeriodEnd', HttpMethod.post, List<OrgSubscription>),
	getManyByCreatedAt('/orgSubscription/byCreatedAt/:createdAt', HttpMethod.post, List<OrgSubscription>),
	getManyByUpdatedAt('/orgSubscription/byUpdatedAt/:updatedAt', HttpMethod.post, List<OrgSubscription>),
	getManyByDeletedAt('/orgSubscription/byDeletedAt/:deletedAt', HttpMethod.post, List<OrgSubscription>);

    const OrgSubscriptionEndpoints(this.path, this.method, this.responseType);

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
