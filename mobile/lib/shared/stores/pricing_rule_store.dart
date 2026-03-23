
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PricingRuleStore extends ModelStreamStore<String, PricingRule> {

  static PricingRuleStore? _instance;

  static PricingRuleStore get instance {
    _instance ??= PricingRuleStore();
    return _instance!;
  }

  PricingRuleStore() : super(PricingRule.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PricingRuleStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PricingRuleStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PricingRuleStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPricingRuleId(PricingRule pricingRule) => pricingRule.id;

	String? getPricingRuleListingId(PricingRule pricingRule) => pricingRule.listingId;

	String? getPricingRuleName(PricingRule pricingRule) => pricingRule.name;

	String? getPricingRuleDescription(PricingRule pricingRule) => pricingRule.description;

	String? getPricingRuleRuleType(PricingRule pricingRule) => pricingRule.ruleType;

	dynamic? getPricingRuleConditions(PricingRule pricingRule) => pricingRule.conditions;

	dynamic? getPricingRuleActions(PricingRule pricingRule) => pricingRule.actions;

	int? getPricingRulePriority(PricingRule pricingRule) => pricingRule.priority;

	bool? getPricingRuleIsActive(PricingRule pricingRule) => pricingRule.isActive;

	DateTime? getPricingRuleCreatedAt(PricingRule pricingRule) => pricingRule.createdAt;

	DateTime? getPricingRuleUpdatedAt(PricingRule pricingRule) => pricingRule.updatedAt;

	DateTime? getPricingRuleDeletedAt(PricingRule pricingRule) => pricingRule.deletedAt;

	double? getPricingRuleBasePrice(PricingRule pricingRule) => pricingRule.basePrice;

	String? getPricingRuleStrategy(PricingRule pricingRule) => pricingRule.strategy;

	DateTime? getPricingRuleStartDate(PricingRule pricingRule) => pricingRule.startDate;

	DateTime? getPricingRuleEndDate(PricingRule pricingRule) => pricingRule.endDate;

	int? getPricingRuleMinNights(PricingRule pricingRule) => pricingRule.minNights;

	int? getPricingRuleMaxNights(PricingRule pricingRule) => pricingRule.maxNights;

	dynamic? getPricingRuleWeekdayPrices(PricingRule pricingRule) => pricingRule.weekdayPrices;

	dynamic? getPricingRuleTaxRules(PricingRule pricingRule) => pricingRule.taxRules;

	dynamic? getPricingRuleDiscountRules(PricingRule pricingRule) => pricingRule.discountRules;

	String? getPricingRuleCurrencyId(PricingRule pricingRule) => pricingRule.currencyId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PricingRule> getByListingId(
    String listingId,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByName(
    String name,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleName, name, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByDescription(
    String description,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleDescription, description, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByRuleType(
    String ruleType,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleRuleType, ruleType, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByConditions(
    dynamic conditions,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleConditions, conditions, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByActions(
    dynamic actions,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleActions, actions, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByPriority(
    int priority,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRulePriority, priority, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByIsActive(
    bool isActive,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByBasePrice(
    double basePrice,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleBasePrice, basePrice, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByStrategy(
    String strategy,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleStrategy, strategy, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByStartDate(
    DateTime startDate,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByEndDate(
    DateTime endDate,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByMinNights(
    int minNights,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleMinNights, minNights, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByMaxNights(
    int maxNights,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleMaxNights, maxNights, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByWeekdayPrices(
    dynamic weekdayPrices,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleWeekdayPrices, weekdayPrices, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByTaxRules(
    dynamic taxRules,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleTaxRules, taxRules, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByDiscountRules(
    dynamic discountRules,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleDiscountRules, discountRules, modelFilter: modelFilter, includes: includes);

	
List<PricingRule> getByCurrencyId(
    String currencyId,
    {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}
    ) =>
    getManyIncluding(getPricingRuleCurrencyId, currencyId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Currency? getCurrency(
    PricingRule pricingRule, {ModelFilter? modelFilter, List<CurrencyInclude>? includes}) {
    if (pricingRule.currencyId == null) {
        return null;
    } else {
        final currency = CurrencyStore.instance.getById(pricingRule.currencyId!, includes: includes);
        pricingRule.currency = currency;
        // setIncludedReferences(currency, includes: includes);
        return currency;
    }
}

	Property? getProperty(
    PricingRule pricingRule, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (pricingRule.listingId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(pricingRule.listingId!, includes: includes);
        pricingRule.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Listing? getListing(
    PricingRule pricingRule, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (pricingRule.listingId == null) {
        return null;
    } else {
        final Listing = ListingStore.instance.getById(pricingRule.listingId!, includes: includes);
        pricingRule.Listing = Listing;
        // setIncludedReferences(Listing, includes: includes);
        return Listing;
    }
}

  /// GET RELATED MODELS 

  List<Availability> getAvailability(
    PricingRule pricingRule, {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}) {
    final Availability = AvailabilityStore.instance.getByPricingRuleId(pricingRule.$uid!, modelFilter: modelFilter, includes: includes);
    pricingRule.Availability = Availability;
    // setIncludedReferencesForList(Availability, includes: includes);
    return Availability;
}

	List<Discount> getDiscounts(
    PricingRule pricingRule, {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}) {
    final Discounts = DiscountStore.instance.getByPricingRuleId(pricingRule.$uid!, modelFilter: modelFilter, includes: includes);
    pricingRule.Discounts = Discounts;
    // setIncludedReferencesForList(Discounts, includes: includes);
    return Discounts;
}

	List<Reservation> getReservation(
    PricingRule pricingRule, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final Reservation = ReservationStore.instance.getBy(pricingRule.$uid!, modelFilter: modelFilter, includes: includes);
    pricingRule.Reservation = Reservation;
    // setIncludedReferencesForList(Reservation, includes: includes);
    return Reservation;
}

	List<Subscription> getSubscriptions(
    PricingRule pricingRule, {ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    final Subscriptions = SubscriptionStore.instance.getBy(pricingRule.$uid!, modelFilter: modelFilter, includes: includes);
    pricingRule.Subscriptions = Subscriptions;
    // setIncludedReferencesForList(Subscriptions, includes: includes);
    return Subscriptions;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PricingRule>> getAll$({bool useCache = true, ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PricingRuleEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PricingRule?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPricingRuleId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PricingRule>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPricingRuleListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPricingRuleName,
        value: name,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPricingRuleDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByRuleType$(
        String ruleType,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPricingRuleRuleType,
        value: ruleType,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByRuleType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByConditions$(
        dynamic conditions,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPricingRuleConditions,
        value: conditions,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByConditions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByActions$(
        dynamic actions,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPricingRuleActions,
        value: actions,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByActions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByPriority$(
        int priority,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPricingRulePriority,
        value: priority,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByPriority,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPricingRuleIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPricingRuleCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPricingRuleUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPricingRuleDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByBasePrice$(
        double basePrice,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPricingRuleBasePrice,
        value: basePrice,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByBasePrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByStrategy$(
        String strategy,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPricingRuleStrategy,
        value: strategy,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByStrategy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPricingRuleStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPricingRuleEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByMinNights$(
        int minNights,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPricingRuleMinNights,
        value: minNights,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByMinNights,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByMaxNights$(
        int maxNights,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPricingRuleMaxNights,
        value: maxNights,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByMaxNights,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByWeekdayPrices$(
        dynamic weekdayPrices,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPricingRuleWeekdayPrices,
        value: weekdayPrices,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByWeekdayPrices,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByTaxRules$(
        dynamic taxRules,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPricingRuleTaxRules,
        value: taxRules,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByTaxRules,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByDiscountRules$(
        dynamic discountRules,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPricingRuleDiscountRules,
        value: discountRules,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByDiscountRules,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PricingRule>> getByCurrencyId$(
        String currencyId,
        {bool useCache = true,
        ModelFilter<PricingRule>? modelFilter,
        List<PricingRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPricingRuleCurrencyId,
        value: currencyId,
        modelFilter: modelFilter,
        endpoint: PricingRuleEndpoints.getManyByCurrencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Currency?> getCurrency$(
    PricingRule pricingRule, {bool useCache = true, ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    if (pricingRule.currencyId == null) {
        return Stream.value(null);
    } else {
        return CurrencyStore.instance.getById$(
            pricingRule.currencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((currency) {
            pricingRule.currency = currency;
        });
    }
}

	Stream<Property?> getProperty$(
    PricingRule pricingRule, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (pricingRule.listingId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            pricingRule.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            pricingRule.Property = Property;
        });
    }
}

	Stream<Listing?> getListing$(
    PricingRule pricingRule, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (pricingRule.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            pricingRule.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Listing) {
            pricingRule.Listing = Listing;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Availability>> getAvailability$(
    PricingRule pricingRule, {bool useCache = true, ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}) {
    return AvailabilityStore.instance.getByPricingRuleId$(
        pricingRule.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Availability) {
        pricingRule.Availability = Availability;
    });

}

	Stream<List<Discount>> getDiscounts$(
    PricingRule pricingRule, {bool useCache = true, ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}) {
    return DiscountStore.instance.getByPricingRuleId$(
        pricingRule.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Discounts) {
        pricingRule.Discounts = Discounts;
    });

}

	Stream<List<Reservation>> getReservation$(
    PricingRule pricingRule, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getBy$(
        pricingRule.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Reservation) {
        pricingRule.Reservation = Reservation;
    });

}

	Stream<List<Subscription>> getSubscriptions$(
    PricingRule pricingRule, {bool useCache = true, ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    return SubscriptionStore.instance.getBy$(
        pricingRule.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Subscriptions) {
        pricingRule.Subscriptions = Subscriptions;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
PricingRule recursiveUpsert(PricingRule pricingRule, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PricingRule'} 
        : const {};
    if (pricingRule.Availability != null && (!preventCircularSerialization || !upsertedTypes.contains('Availability'))) {
        pricingRule.Availability = AvailabilityStore.instance.recursiveListUpsert(pricingRule.Availability!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (pricingRule.Discounts != null && (!preventCircularSerialization || !upsertedTypes.contains('Discount'))) {
        pricingRule.Discounts = DiscountStore.instance.recursiveListUpsert(pricingRule.Discounts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (pricingRule.currency != null && (!preventCircularSerialization || !upsertedTypes.contains('Currency'))) {
        pricingRule.currency = CurrencyStore.instance.recursiveUpsert(pricingRule.currency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (pricingRule.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        pricingRule.Property = PropertyStore.instance.recursiveUpsert(pricingRule.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (pricingRule.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        pricingRule.Reservation = ReservationStore.instance.recursiveListUpsert(pricingRule.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (pricingRule.Subscriptions != null && (!preventCircularSerialization || !upsertedTypes.contains('Subscription'))) {
        pricingRule.Subscriptions = SubscriptionStore.instance.recursiveListUpsert(pricingRule.Subscriptions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (pricingRule.Listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        pricingRule.Listing = ListingStore.instance.recursiveUpsert(pricingRule.Listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(pricingRule);
}

  List<PricingRule> recursiveListUpsert(List<PricingRule> pricingRules, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPricingRules = <PricingRule>[];
    for (var pricingRule in pricingRules) {
        updatedPricingRules.add(recursiveUpsert(pricingRule, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPricingRules;
}

//   @override
//   PricingRule upsert(PricingRule item) {
//     return recursiveUpsert(item);
//   }

}


class PricingRuleInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PricingRuleInclude.Availability({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Availability>? modelFilter,
    List<AvailabilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (pricingRule) => PricingRuleStore.instance
            .getAvailability$(pricingRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (pricingRule) => PricingRuleStore.instance
            .getAvailability(pricingRule, modelFilter: modelFilter, includes: includes);
      }
}

	PricingRuleInclude.Discounts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Discount>? modelFilter,
    List<DiscountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (pricingRule) => PricingRuleStore.instance
            .getDiscounts$(pricingRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (pricingRule) => PricingRuleStore.instance
            .getDiscounts(pricingRule, modelFilter: modelFilter, includes: includes);
      }
}

	PricingRuleInclude.currency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Currency>? modelFilter,
    List<CurrencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (pricingRule) => PricingRuleStore.instance
            .getCurrency$(pricingRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (pricingRule) => PricingRuleStore.instance
            .getCurrency(pricingRule, modelFilter: modelFilter, includes: includes);
      }
}

	PricingRuleInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (pricingRule) => PricingRuleStore.instance
            .getProperty$(pricingRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (pricingRule) => PricingRuleStore.instance
            .getProperty(pricingRule, modelFilter: modelFilter, includes: includes);
      }
}

	PricingRuleInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (pricingRule) => PricingRuleStore.instance
            .getReservation$(pricingRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (pricingRule) => PricingRuleStore.instance
            .getReservation(pricingRule, modelFilter: modelFilter, includes: includes);
      }
}

	PricingRuleInclude.Subscriptions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Subscription>? modelFilter,
    List<SubscriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (pricingRule) => PricingRuleStore.instance
            .getSubscriptions$(pricingRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (pricingRule) => PricingRuleStore.instance
            .getSubscriptions(pricingRule, modelFilter: modelFilter, includes: includes);
      }
}

	PricingRuleInclude.Listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (pricingRule) => PricingRuleStore.instance
            .getListing$(pricingRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (pricingRule) => PricingRuleStore.instance
            .getListing(pricingRule, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PricingRuleEndpoints implements Endpoint {

    getAll('/pricingRule', HttpMethod.post, List<PricingRule>),
	getById('/pricingRule/byId/:id', HttpMethod.post, PricingRule),
	getManyByListingId('/pricingRule/byListingId/:listingId', HttpMethod.post, List<PricingRule>),
	getManyByName('/pricingRule/byName/:name', HttpMethod.post, List<PricingRule>),
	getManyByDescription('/pricingRule/byDescription/:description', HttpMethod.post, List<PricingRule>),
	getManyByRuleType('/pricingRule/byRuleType/:ruleType', HttpMethod.post, List<PricingRule>),
	getManyByConditions('/pricingRule/byConditions/:conditions', HttpMethod.post, List<PricingRule>),
	getManyByActions('/pricingRule/byActions/:actions', HttpMethod.post, List<PricingRule>),
	getManyByPriority('/pricingRule/byPriority/:priority', HttpMethod.post, List<PricingRule>),
	getManyByIsActive('/pricingRule/byIsActive/:isActive', HttpMethod.post, List<PricingRule>),
	getManyByCreatedAt('/pricingRule/byCreatedAt/:createdAt', HttpMethod.post, List<PricingRule>),
	getManyByUpdatedAt('/pricingRule/byUpdatedAt/:updatedAt', HttpMethod.post, List<PricingRule>),
	getManyByDeletedAt('/pricingRule/byDeletedAt/:deletedAt', HttpMethod.post, List<PricingRule>),
	getManyByBasePrice('/pricingRule/byBasePrice/:basePrice', HttpMethod.post, List<PricingRule>),
	getManyByStrategy('/pricingRule/byStrategy/:strategy', HttpMethod.post, List<PricingRule>),
	getManyByStartDate('/pricingRule/byStartDate/:startDate', HttpMethod.post, List<PricingRule>),
	getManyByEndDate('/pricingRule/byEndDate/:endDate', HttpMethod.post, List<PricingRule>),
	getManyByMinNights('/pricingRule/byMinNights/:minNights', HttpMethod.post, List<PricingRule>),
	getManyByMaxNights('/pricingRule/byMaxNights/:maxNights', HttpMethod.post, List<PricingRule>),
	getManyByWeekdayPrices('/pricingRule/byWeekdayPrices/:weekdayPrices', HttpMethod.post, List<PricingRule>),
	getManyByTaxRules('/pricingRule/byTaxRules/:taxRules', HttpMethod.post, List<PricingRule>),
	getManyByDiscountRules('/pricingRule/byDiscountRules/:discountRules', HttpMethod.post, List<PricingRule>),
	getManyByCurrencyId('/pricingRule/byCurrencyId/:currencyId', HttpMethod.post, List<PricingRule>);

    const PricingRuleEndpoints(this.path, this.method, this.responseType);

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
