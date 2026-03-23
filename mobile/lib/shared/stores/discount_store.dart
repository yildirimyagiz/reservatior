
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class DiscountStore extends ModelStreamStore<String, Discount> {

  static DiscountStore? _instance;

  static DiscountStore get instance {
    _instance ??= DiscountStore();
    return _instance!;
  }

  DiscountStore() : super(Discount.fromJson) {
    if (_instance != null) {
        throw Exception(
            'DiscountStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending DiscountStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use DiscountStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  DateTime? getDiscountDeletedAt(Discount discount) => discount.deletedAt;

	String? getDiscountId(Discount discount) => discount.id;

	String? getDiscountName(Discount discount) => discount.name;

	String? getDiscountDescription(Discount discount) => discount.description;

	String? getDiscountCode(Discount discount) => discount.code;

	double? getDiscountValue(Discount discount) => discount.value;

	DiscountType? getDiscountType(Discount discount) => discount.type;

	DateTime? getDiscountStartDate(Discount discount) => discount.startDate;

	DateTime? getDiscountEndDate(Discount discount) => discount.endDate;

	int? getDiscountMaxUsage(Discount discount) => discount.maxUsage;

	int? getDiscountCurrentUsage(Discount discount) => discount.currentUsage;

	bool? getDiscountIsActive(Discount discount) => discount.isActive;

	DateTime? getDiscountCreatedAt(Discount discount) => discount.createdAt;

	DateTime? getDiscountUpdatedAt(Discount discount) => discount.updatedAt;

	String? getDiscountPropertyId(Discount discount) => discount.propertyId;

	String? getDiscountPricingRuleId(Discount discount) => discount.pricingRuleId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Discount? getByCode(
    String code,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getIncluding(getDiscountCode, code, modelFilter: modelFilter, includes: includes);

  
List<Discount> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByName(
    String name,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountName, name, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByDescription(
    String description,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByValue(
    double value,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountValue, value, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByType(
    DiscountType type,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountType, type, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByStartDate(
    DateTime startDate,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByEndDate(
    DateTime endDate,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByMaxUsage(
    int maxUsage,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountMaxUsage, maxUsage, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByCurrentUsage(
    int currentUsage,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountCurrentUsage, currentUsage, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByIsActive(
    bool isActive,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByPropertyId(
    String propertyId,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Discount> getByPricingRuleId(
    String pricingRuleId,
    {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}
    ) =>
    getManyIncluding(getDiscountPricingRuleId, pricingRuleId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  PricingRule? getPricingRule(
    Discount discount, {ModelFilter? modelFilter, List<PricingRuleInclude>? includes}) {
    if (discount.pricingRuleId == null) {
        return null;
    } else {
        final PricingRule = PricingRuleStore.instance.getById(discount.pricingRuleId!, includes: includes);
        discount.PricingRule = PricingRule;
        // setIncludedReferences(PricingRule, includes: includes);
        return PricingRule;
    }
}

	Property? getProperty(
    Discount discount, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (discount.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(discount.propertyId!, includes: includes);
        discount.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

  /// GET RELATED MODELS 

  List<Reservation> getReservation(
    Discount discount, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final Reservation = ReservationStore.instance.getBy(discount.$uid!, modelFilter: modelFilter, includes: includes);
    discount.Reservation = Reservation;
    // setIncludedReferencesForList(Reservation, includes: includes);
    return Reservation;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Discount>> getAll$({bool useCache = true, ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: DiscountEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Discount?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDiscountId,
        value: id,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Discount?> getByCode$(
        String code,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDiscountCode,
        value: code,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getByCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Discount>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDiscountDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDiscountName,
        value: name,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDiscountDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByValue$(
        double value,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getDiscountValue,
        value: value,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByType$(
        DiscountType type,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DiscountType>(
        getPropVal: getDiscountType,
        value: type,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDiscountStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDiscountEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByMaxUsage$(
        int maxUsage,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getDiscountMaxUsage,
        value: maxUsage,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByMaxUsage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByCurrentUsage$(
        int currentUsage,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getDiscountCurrentUsage,
        value: currentUsage,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByCurrentUsage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDiscountIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDiscountCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDiscountUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDiscountPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Discount>> getByPricingRuleId$(
        String pricingRuleId,
        {bool useCache = true,
        ModelFilter<Discount>? modelFilter,
        List<DiscountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDiscountPricingRuleId,
        value: pricingRuleId,
        modelFilter: modelFilter,
        endpoint: DiscountEndpoints.getManyByPricingRuleId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<PricingRule?> getPricingRule$(
    Discount discount, {bool useCache = true, ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    if (discount.pricingRuleId == null) {
        return Stream.value(null);
    } else {
        return PricingRuleStore.instance.getById$(
            discount.pricingRuleId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((PricingRule) {
            discount.PricingRule = PricingRule;
        });
    }
}

	Stream<Property?> getProperty$(
    Discount discount, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (discount.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            discount.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            discount.Property = Property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Reservation>> getReservation$(
    Discount discount, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getBy$(
        discount.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Reservation) {
        discount.Reservation = Reservation;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Discount recursiveUpsert(Discount discount, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Discount'} 
        : const {};
    if (discount.PricingRule != null && (!preventCircularSerialization || !upsertedTypes.contains('PricingRule'))) {
        discount.PricingRule = PricingRuleStore.instance.recursiveUpsert(discount.PricingRule!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (discount.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        discount.Property = PropertyStore.instance.recursiveUpsert(discount.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (discount.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        discount.Reservation = ReservationStore.instance.recursiveListUpsert(discount.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(discount);
}

  List<Discount> recursiveListUpsert(List<Discount> discounts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedDiscounts = <Discount>[];
    for (var discount in discounts) {
        updatedDiscounts.add(recursiveUpsert(discount, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedDiscounts;
}

//   @override
//   Discount upsert(Discount item) {
//     return recursiveUpsert(item);
//   }

}


class DiscountInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      DiscountInclude.PricingRule({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PricingRule>? modelFilter,
    List<PricingRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (discount) => DiscountStore.instance
            .getPricingRule$(discount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (discount) => DiscountStore.instance
            .getPricingRule(discount, modelFilter: modelFilter, includes: includes);
      }
}

	DiscountInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (discount) => DiscountStore.instance
            .getProperty$(discount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (discount) => DiscountStore.instance
            .getProperty(discount, modelFilter: modelFilter, includes: includes);
      }
}

	DiscountInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (discount) => DiscountStore.instance
            .getReservation$(discount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (discount) => DiscountStore.instance
            .getReservation(discount, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum DiscountEndpoints implements Endpoint {

    getAll('/discount', HttpMethod.post, List<Discount>),
	getManyByDeletedAt('/discount/byDeletedAt/:deletedAt', HttpMethod.post, List<Discount>),
	getById('/discount/byId/:id', HttpMethod.post, Discount),
	getManyByName('/discount/byName/:name', HttpMethod.post, List<Discount>),
	getManyByDescription('/discount/byDescription/:description', HttpMethod.post, List<Discount>),
	getByCode('/discount/byCode/:code', HttpMethod.post, Discount),
	getManyByValue('/discount/byValue/:value', HttpMethod.post, List<Discount>),
	getManyByType('/discount/byType/:type', HttpMethod.post, List<Discount>),
	getManyByStartDate('/discount/byStartDate/:startDate', HttpMethod.post, List<Discount>),
	getManyByEndDate('/discount/byEndDate/:endDate', HttpMethod.post, List<Discount>),
	getManyByMaxUsage('/discount/byMaxUsage/:maxUsage', HttpMethod.post, List<Discount>),
	getManyByCurrentUsage('/discount/byCurrentUsage/:currentUsage', HttpMethod.post, List<Discount>),
	getManyByIsActive('/discount/byIsActive/:isActive', HttpMethod.post, List<Discount>),
	getManyByCreatedAt('/discount/byCreatedAt/:createdAt', HttpMethod.post, List<Discount>),
	getManyByUpdatedAt('/discount/byUpdatedAt/:updatedAt', HttpMethod.post, List<Discount>),
	getManyByPropertyId('/discount/byPropertyId/:propertyId', HttpMethod.post, List<Discount>),
	getManyByPricingRuleId('/discount/byPricingRuleId/:pricingRuleId', HttpMethod.post, List<Discount>);

    const DiscountEndpoints(this.path, this.method, this.responseType);

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
