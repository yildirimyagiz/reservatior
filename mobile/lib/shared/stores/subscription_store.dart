
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SubscriptionStore extends ModelStreamStore<String, Subscription> {

  static SubscriptionStore? _instance;

  static SubscriptionStore get instance {
    _instance ??= SubscriptionStore();
    return _instance!;
  }

  SubscriptionStore() : super(Subscription.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SubscriptionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SubscriptionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SubscriptionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSubscriptionId(Subscription subscription) => subscription.id;

	String? getSubscriptionOrgId(Subscription subscription) => subscription.orgId;

	String? getSubscriptionUserId(Subscription subscription) => subscription.userId;

	String? getSubscriptionName(Subscription subscription) => subscription.name;

	MembershipType? getSubscriptionType(Subscription subscription) => subscription.type;

	double? getSubscriptionPrice(Subscription subscription) => subscription.price;

	String? getSubscriptionCurrency(Subscription subscription) => subscription.currency;

	String? getSubscriptionBillingCycle(Subscription subscription) => subscription.billingCycle;

	int? getSubscriptionMaxProperties(Subscription subscription) => subscription.maxProperties;

	int? getSubscriptionMaxListings(Subscription subscription) => subscription.maxListings;

	int? getSubscriptionFeaturedListings(Subscription subscription) => subscription.featuredListings;

	bool? getSubscriptionPrioritySupport(Subscription subscription) => subscription.prioritySupport;

	bool? getSubscriptionApiAccess(Subscription subscription) => subscription.apiAccess;

	double? getSubscriptionCommissionDiscount(Subscription subscription) => subscription.commissionDiscount;

	double? getSubscriptionLoyaltyMultiplier(Subscription subscription) => subscription.loyaltyMultiplier;

	bool? getSubscriptionIsActive(Subscription subscription) => subscription.isActive;

	dynamic? getSubscriptionUserSubscriptions(Subscription subscription) => subscription.userSubscriptions;

	String? getSubscriptionCreatedBy(Subscription subscription) => subscription.createdBy;

	DateTime? getSubscriptionCreatedAt(Subscription subscription) => subscription.createdAt;

	DateTime? getSubscriptionUpdatedAt(Subscription subscription) => subscription.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Subscription> getByOrgId(
    String orgId,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByUserId(
    String userId,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByName(
    String name,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionName, name, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByType(
    MembershipType type,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionType, type, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByPrice(
    double price,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionPrice, price, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByCurrency(
    String currency,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByBillingCycle(
    String billingCycle,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionBillingCycle, billingCycle, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByMaxProperties(
    int maxProperties,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionMaxProperties, maxProperties, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByMaxListings(
    int maxListings,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionMaxListings, maxListings, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByFeaturedListings(
    int featuredListings,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionFeaturedListings, featuredListings, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByPrioritySupport(
    bool prioritySupport,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionPrioritySupport, prioritySupport, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByApiAccess(
    bool apiAccess,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionApiAccess, apiAccess, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByCommissionDiscount(
    double commissionDiscount,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionCommissionDiscount, commissionDiscount, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByLoyaltyMultiplier(
    double loyaltyMultiplier,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionLoyaltyMultiplier, loyaltyMultiplier, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByIsActive(
    bool isActive,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByUserSubscriptions(
    dynamic userSubscriptions,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionUserSubscriptions, userSubscriptions, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByCreatedBy(
    String createdBy,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Subscription> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}
    ) =>
    getManyIncluding(getSubscriptionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Subscription subscription, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (subscription.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(subscription.orgId!, includes: includes);
        subscription.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<PricingRule> getPricingRules(
    Subscription subscription, {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    final pricingRules = PricingRuleStore.instance.getBy(subscription.$uid!, modelFilter: modelFilter, includes: includes);
    subscription.pricingRules = pricingRules;
    // setIncludedReferencesForList(pricingRules, includes: includes);
    return pricingRules;
}

	List<Agent> getAgents(
    Subscription subscription, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agents = AgentStore.instance.getBy(subscription.$uid!, modelFilter: modelFilter, includes: includes);
    subscription.agents = agents;
    // setIncludedReferencesForList(agents, includes: includes);
    return agents;
}

	List<Agency> getAgencies(
    Subscription subscription, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(subscription.$uid!, modelFilter: modelFilter, includes: includes);
    subscription.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Payment> getPayments(
    Subscription subscription, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final payments = PaymentStore.instance.getBySubscriptionId(subscription.$uid!, modelFilter: modelFilter, includes: includes);
    subscription.payments = payments;
    // setIncludedReferencesForList(payments, includes: includes);
    return payments;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Subscription>> getAll$({bool useCache = true, ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SubscriptionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Subscription?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSubscriptionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Subscription>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSubscriptionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSubscriptionUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSubscriptionName,
        value: name,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByType$(
        MembershipType type,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<MembershipType>(
        getPropVal: getSubscriptionType,
        value: type,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByPrice$(
        double price,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getSubscriptionPrice,
        value: price,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSubscriptionCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByBillingCycle$(
        String billingCycle,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSubscriptionBillingCycle,
        value: billingCycle,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByBillingCycle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByMaxProperties$(
        int maxProperties,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getSubscriptionMaxProperties,
        value: maxProperties,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByMaxProperties,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByMaxListings$(
        int maxListings,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getSubscriptionMaxListings,
        value: maxListings,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByMaxListings,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByFeaturedListings$(
        int featuredListings,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getSubscriptionFeaturedListings,
        value: featuredListings,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByFeaturedListings,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByPrioritySupport$(
        bool prioritySupport,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getSubscriptionPrioritySupport,
        value: prioritySupport,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByPrioritySupport,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByApiAccess$(
        bool apiAccess,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getSubscriptionApiAccess,
        value: apiAccess,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByApiAccess,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByCommissionDiscount$(
        double commissionDiscount,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getSubscriptionCommissionDiscount,
        value: commissionDiscount,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByCommissionDiscount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByLoyaltyMultiplier$(
        double loyaltyMultiplier,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getSubscriptionLoyaltyMultiplier,
        value: loyaltyMultiplier,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByLoyaltyMultiplier,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getSubscriptionIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByUserSubscriptions$(
        dynamic userSubscriptions,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getSubscriptionUserSubscriptions,
        value: userSubscriptions,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByUserSubscriptions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSubscriptionCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSubscriptionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Subscription>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Subscription>? modelFilter,
        List<SubscriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSubscriptionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: SubscriptionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Subscription subscription, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (subscription.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            subscription.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            subscription.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<PricingRule>> getPricingRules$(
    Subscription subscription, {bool useCache = true, ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    return PricingRuleStore.instance.getBy$(
        subscription.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((pricingRules) {
        subscription.pricingRules = pricingRules;
    });

}

	Stream<List<Agent>> getAgents$(
    Subscription subscription, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getBy$(
        subscription.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agents) {
        subscription.agents = agents;
    });

}

	Stream<List<Agency>> getAgencies$(
    Subscription subscription, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        subscription.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        subscription.agencies = agencies;
    });

}

	Stream<List<Payment>> getPayments$(
    Subscription subscription, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getBySubscriptionId$(
        subscription.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((payments) {
        subscription.payments = payments;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Subscription recursiveUpsert(Subscription subscription, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Subscription'} 
        : const {};
    if (subscription.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        subscription.org = OrganizationStore.instance.recursiveUpsert(subscription.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (subscription.pricingRules != null && (!preventCircularSerialization || !upsertedTypes.contains('PricingRule'))) {
        subscription.pricingRules = PricingRuleStore.instance.recursiveListUpsert(subscription.pricingRules!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (subscription.agents != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        subscription.agents = AgentStore.instance.recursiveListUpsert(subscription.agents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (subscription.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        subscription.agencies = AgencyStore.instance.recursiveListUpsert(subscription.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (subscription.payments != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        subscription.payments = PaymentStore.instance.recursiveListUpsert(subscription.payments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(subscription);
}

  List<Subscription> recursiveListUpsert(List<Subscription> subscriptions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSubscriptions = <Subscription>[];
    for (var subscription in subscriptions) {
        updatedSubscriptions.add(recursiveUpsert(subscription, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSubscriptions;
}

//   @override
//   Subscription upsert(Subscription item) {
//     return recursiveUpsert(item);
//   }

}


class SubscriptionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SubscriptionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (subscription) => SubscriptionStore.instance
            .getOrg$(subscription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (subscription) => SubscriptionStore.instance
            .getOrg(subscription, modelFilter: modelFilter, includes: includes);
      }
}

	SubscriptionInclude.pricingRules({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PricingRule>? modelFilter,
    List<PricingRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (subscription) => SubscriptionStore.instance
            .getPricingRules$(subscription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (subscription) => SubscriptionStore.instance
            .getPricingRules(subscription, modelFilter: modelFilter, includes: includes);
      }
}

	SubscriptionInclude.agents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (subscription) => SubscriptionStore.instance
            .getAgents$(subscription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (subscription) => SubscriptionStore.instance
            .getAgents(subscription, modelFilter: modelFilter, includes: includes);
      }
}

	SubscriptionInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (subscription) => SubscriptionStore.instance
            .getAgencies$(subscription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (subscription) => SubscriptionStore.instance
            .getAgencies(subscription, modelFilter: modelFilter, includes: includes);
      }
}

	SubscriptionInclude.payments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (subscription) => SubscriptionStore.instance
            .getPayments$(subscription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (subscription) => SubscriptionStore.instance
            .getPayments(subscription, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SubscriptionEndpoints implements Endpoint {

    getAll('/subscription', HttpMethod.post, List<Subscription>),
	getById('/subscription/byId/:id', HttpMethod.post, Subscription),
	getManyByOrgId('/subscription/byOrgId/:orgId', HttpMethod.post, List<Subscription>),
	getManyByUserId('/subscription/byUserId/:userId', HttpMethod.post, List<Subscription>),
	getManyByName('/subscription/byName/:name', HttpMethod.post, List<Subscription>),
	getManyByType('/subscription/byType/:type', HttpMethod.post, List<Subscription>),
	getManyByPrice('/subscription/byPrice/:price', HttpMethod.post, List<Subscription>),
	getManyByCurrency('/subscription/byCurrency/:currency', HttpMethod.post, List<Subscription>),
	getManyByBillingCycle('/subscription/byBillingCycle/:billingCycle', HttpMethod.post, List<Subscription>),
	getManyByMaxProperties('/subscription/byMaxProperties/:maxProperties', HttpMethod.post, List<Subscription>),
	getManyByMaxListings('/subscription/byMaxListings/:maxListings', HttpMethod.post, List<Subscription>),
	getManyByFeaturedListings('/subscription/byFeaturedListings/:featuredListings', HttpMethod.post, List<Subscription>),
	getManyByPrioritySupport('/subscription/byPrioritySupport/:prioritySupport', HttpMethod.post, List<Subscription>),
	getManyByApiAccess('/subscription/byApiAccess/:apiAccess', HttpMethod.post, List<Subscription>),
	getManyByCommissionDiscount('/subscription/byCommissionDiscount/:commissionDiscount', HttpMethod.post, List<Subscription>),
	getManyByLoyaltyMultiplier('/subscription/byLoyaltyMultiplier/:loyaltyMultiplier', HttpMethod.post, List<Subscription>),
	getManyByIsActive('/subscription/byIsActive/:isActive', HttpMethod.post, List<Subscription>),
	getManyByUserSubscriptions('/subscription/byUserSubscriptions/:userSubscriptions', HttpMethod.post, List<Subscription>),
	getManyByCreatedBy('/subscription/byCreatedBy/:createdBy', HttpMethod.post, List<Subscription>),
	getManyByCreatedAt('/subscription/byCreatedAt/:createdAt', HttpMethod.post, List<Subscription>),
	getManyByUpdatedAt('/subscription/byUpdatedAt/:updatedAt', HttpMethod.post, List<Subscription>);

    const SubscriptionEndpoints(this.path, this.method, this.responseType);

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
