
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AvailabilityStore extends ModelStreamStore<String, Availability> {

  static AvailabilityStore? _instance;

  static AvailabilityStore get instance {
    _instance ??= AvailabilityStore();
    return _instance!;
  }

  AvailabilityStore() : super(Availability.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AvailabilityStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AvailabilityStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AvailabilityStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAvailabilityId(Availability availability) => availability.id;

	DateTime? getAvailabilityDate(Availability availability) => availability.date;

	bool? getAvailabilityIsBlocked(Availability availability) => availability.isBlocked;

	bool? getAvailabilityIsBooked(Availability availability) => availability.isBooked;

	String? getAvailabilityPropertyId(Availability availability) => availability.propertyId;

	String? getAvailabilityReservationId(Availability availability) => availability.reservationId;

	String? getAvailabilityPricingRuleId(Availability availability) => availability.pricingRuleId;

	int? getAvailabilityTotalUnits(Availability availability) => availability.totalUnits;

	int? getAvailabilityAvailableUnits(Availability availability) => availability.availableUnits;

	int? getAvailabilityBookedUnits(Availability availability) => availability.bookedUnits;

	int? getAvailabilityBlockedUnits(Availability availability) => availability.blockedUnits;

	dynamic? getAvailabilitySpecialPricing(Availability availability) => availability.specialPricing;

	double? getAvailabilityBasePrice(Availability availability) => availability.basePrice;

	double? getAvailabilityCurrentPrice(Availability availability) => availability.currentPrice;

	dynamic? getAvailabilityPriceSettings(Availability availability) => availability.priceSettings;

	int? getAvailabilityMinNights(Availability availability) => availability.minNights;

	int? getAvailabilityMaxNights(Availability availability) => availability.maxNights;

	int? getAvailabilityMaxGuests(Availability availability) => availability.maxGuests;

	dynamic? getAvailabilityDiscountSettings(Availability availability) => availability.discountSettings;

	double? getAvailabilityWeekendRate(Availability availability) => availability.weekendRate;

	double? getAvailabilityWeekdayRate(Availability availability) => availability.weekdayRate;

	double? getAvailabilityWeekendMultiplier(Availability availability) => availability.weekendMultiplier;

	double? getAvailabilityWeekdayMultiplier(Availability availability) => availability.weekdayMultiplier;

	double? getAvailabilitySeasonalMultiplier(Availability availability) => availability.seasonalMultiplier;

	DateTime? getAvailabilityCreatedAt(Availability availability) => availability.createdAt;

	DateTime? getAvailabilityUpdatedAt(Availability availability) => availability.updatedAt;

	DateTime? getAvailabilityDeletedAt(Availability availability) => availability.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Availability> getByDate(
    DateTime date,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityDate, date, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByIsBlocked(
    bool isBlocked,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityIsBlocked, isBlocked, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByIsBooked(
    bool isBooked,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityIsBooked, isBooked, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByPropertyId(
    String propertyId,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByReservationId(
    String reservationId,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByPricingRuleId(
    String pricingRuleId,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityPricingRuleId, pricingRuleId, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByTotalUnits(
    int totalUnits,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityTotalUnits, totalUnits, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByAvailableUnits(
    int availableUnits,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityAvailableUnits, availableUnits, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByBookedUnits(
    int bookedUnits,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityBookedUnits, bookedUnits, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByBlockedUnits(
    int blockedUnits,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityBlockedUnits, blockedUnits, modelFilter: modelFilter, includes: includes);

	
List<Availability> getBySpecialPricing(
    dynamic specialPricing,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilitySpecialPricing, specialPricing, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByBasePrice(
    double basePrice,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityBasePrice, basePrice, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByCurrentPrice(
    double currentPrice,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityCurrentPrice, currentPrice, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByPriceSettings(
    dynamic priceSettings,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityPriceSettings, priceSettings, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByMinNights(
    int minNights,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityMinNights, minNights, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByMaxNights(
    int maxNights,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityMaxNights, maxNights, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByMaxGuests(
    int maxGuests,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityMaxGuests, maxGuests, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByDiscountSettings(
    dynamic discountSettings,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityDiscountSettings, discountSettings, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByWeekendRate(
    double weekendRate,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityWeekendRate, weekendRate, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByWeekdayRate(
    double weekdayRate,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityWeekdayRate, weekdayRate, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByWeekendMultiplier(
    double weekendMultiplier,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityWeekendMultiplier, weekendMultiplier, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByWeekdayMultiplier(
    double weekdayMultiplier,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityWeekdayMultiplier, weekdayMultiplier, modelFilter: modelFilter, includes: includes);

	
List<Availability> getBySeasonalMultiplier(
    double seasonalMultiplier,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilitySeasonalMultiplier, seasonalMultiplier, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Availability> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}
    ) =>
    getManyIncluding(getAvailabilityDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  PricingRule? getPricingRule(
    Availability availability, {ModelFilter? modelFilter, List<PricingRuleInclude>? includes}) {
    if (availability.pricingRuleId == null) {
        return null;
    } else {
        final pricingRule = PricingRuleStore.instance.getById(availability.pricingRuleId!, includes: includes);
        availability.pricingRule = pricingRule;
        // setIncludedReferences(pricingRule, includes: includes);
        return pricingRule;
    }
}

	Property? getProperty(
    Availability availability, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (availability.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(availability.propertyId!, includes: includes);
        availability.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

	Reservation? getReservation(
    Availability availability, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (availability.reservationId == null) {
        return null;
    } else {
        final reservation = ReservationStore.instance.getById(availability.reservationId!, includes: includes);
        availability.reservation = reservation;
        // setIncludedReferences(reservation, includes: includes);
        return reservation;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Availability>> getAll$({bool useCache = true, ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AvailabilityEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Availability?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAvailabilityId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Availability>> getByDate$(
        DateTime date,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAvailabilityDate,
        value: date,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByIsBlocked$(
        bool isBlocked,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAvailabilityIsBlocked,
        value: isBlocked,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByIsBlocked,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByIsBooked$(
        bool isBooked,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAvailabilityIsBooked,
        value: isBooked,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByIsBooked,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAvailabilityPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAvailabilityReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByPricingRuleId$(
        String pricingRuleId,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAvailabilityPricingRuleId,
        value: pricingRuleId,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByPricingRuleId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByTotalUnits$(
        int totalUnits,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAvailabilityTotalUnits,
        value: totalUnits,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByTotalUnits,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByAvailableUnits$(
        int availableUnits,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAvailabilityAvailableUnits,
        value: availableUnits,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByAvailableUnits,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByBookedUnits$(
        int bookedUnits,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAvailabilityBookedUnits,
        value: bookedUnits,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByBookedUnits,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByBlockedUnits$(
        int blockedUnits,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAvailabilityBlockedUnits,
        value: blockedUnits,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByBlockedUnits,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getBySpecialPricing$(
        dynamic specialPricing,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAvailabilitySpecialPricing,
        value: specialPricing,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyBySpecialPricing,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByBasePrice$(
        double basePrice,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAvailabilityBasePrice,
        value: basePrice,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByBasePrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByCurrentPrice$(
        double currentPrice,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAvailabilityCurrentPrice,
        value: currentPrice,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByCurrentPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByPriceSettings$(
        dynamic priceSettings,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAvailabilityPriceSettings,
        value: priceSettings,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByPriceSettings,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByMinNights$(
        int minNights,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAvailabilityMinNights,
        value: minNights,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByMinNights,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByMaxNights$(
        int maxNights,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAvailabilityMaxNights,
        value: maxNights,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByMaxNights,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByMaxGuests$(
        int maxGuests,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAvailabilityMaxGuests,
        value: maxGuests,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByMaxGuests,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByDiscountSettings$(
        dynamic discountSettings,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAvailabilityDiscountSettings,
        value: discountSettings,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByDiscountSettings,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByWeekendRate$(
        double weekendRate,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAvailabilityWeekendRate,
        value: weekendRate,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByWeekendRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByWeekdayRate$(
        double weekdayRate,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAvailabilityWeekdayRate,
        value: weekdayRate,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByWeekdayRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByWeekendMultiplier$(
        double weekendMultiplier,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAvailabilityWeekendMultiplier,
        value: weekendMultiplier,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByWeekendMultiplier,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByWeekdayMultiplier$(
        double weekdayMultiplier,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAvailabilityWeekdayMultiplier,
        value: weekdayMultiplier,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByWeekdayMultiplier,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getBySeasonalMultiplier$(
        double seasonalMultiplier,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAvailabilitySeasonalMultiplier,
        value: seasonalMultiplier,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyBySeasonalMultiplier,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAvailabilityCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAvailabilityUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Availability>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Availability>? modelFilter,
        List<AvailabilityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAvailabilityDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AvailabilityEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<PricingRule?> getPricingRule$(
    Availability availability, {bool useCache = true, ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    if (availability.pricingRuleId == null) {
        return Stream.value(null);
    } else {
        return PricingRuleStore.instance.getById$(
            availability.pricingRuleId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((pricingRule) {
            availability.pricingRule = pricingRule;
        });
    }
}

	Stream<Property?> getProperty$(
    Availability availability, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (availability.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            availability.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            availability.property = property;
        });
    }
}

	Stream<Reservation?> getReservation$(
    Availability availability, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (availability.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            availability.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((reservation) {
            availability.reservation = reservation;
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
Availability recursiveUpsert(Availability availability, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Availability'} 
        : const {};
    if (availability.pricingRule != null && (!preventCircularSerialization || !upsertedTypes.contains('PricingRule'))) {
        availability.pricingRule = PricingRuleStore.instance.recursiveUpsert(availability.pricingRule!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (availability.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        availability.property = PropertyStore.instance.recursiveUpsert(availability.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (availability.reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        availability.reservation = ReservationStore.instance.recursiveUpsert(availability.reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(availability);
}

  List<Availability> recursiveListUpsert(List<Availability> availabilitys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAvailabilitys = <Availability>[];
    for (var availability in availabilitys) {
        updatedAvailabilitys.add(recursiveUpsert(availability, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAvailabilitys;
}

//   @override
//   Availability upsert(Availability item) {
//     return recursiveUpsert(item);
//   }

}


class AvailabilityInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AvailabilityInclude.pricingRule({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PricingRule>? modelFilter,
    List<PricingRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (availability) => AvailabilityStore.instance
            .getPricingRule$(availability, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (availability) => AvailabilityStore.instance
            .getPricingRule(availability, modelFilter: modelFilter, includes: includes);
      }
}

	AvailabilityInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (availability) => AvailabilityStore.instance
            .getProperty$(availability, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (availability) => AvailabilityStore.instance
            .getProperty(availability, modelFilter: modelFilter, includes: includes);
      }
}

	AvailabilityInclude.reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (availability) => AvailabilityStore.instance
            .getReservation$(availability, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (availability) => AvailabilityStore.instance
            .getReservation(availability, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AvailabilityEndpoints implements Endpoint {

    getAll('/availability', HttpMethod.post, List<Availability>),
	getById('/availability/byId/:id', HttpMethod.post, Availability),
	getManyByDate('/availability/byDate/:date', HttpMethod.post, List<Availability>),
	getManyByIsBlocked('/availability/byIsBlocked/:isBlocked', HttpMethod.post, List<Availability>),
	getManyByIsBooked('/availability/byIsBooked/:isBooked', HttpMethod.post, List<Availability>),
	getManyByPropertyId('/availability/byPropertyId/:propertyId', HttpMethod.post, List<Availability>),
	getManyByReservationId('/availability/byReservationId/:reservationId', HttpMethod.post, List<Availability>),
	getManyByPricingRuleId('/availability/byPricingRuleId/:pricingRuleId', HttpMethod.post, List<Availability>),
	getManyByTotalUnits('/availability/byTotalUnits/:totalUnits', HttpMethod.post, List<Availability>),
	getManyByAvailableUnits('/availability/byAvailableUnits/:availableUnits', HttpMethod.post, List<Availability>),
	getManyByBookedUnits('/availability/byBookedUnits/:bookedUnits', HttpMethod.post, List<Availability>),
	getManyByBlockedUnits('/availability/byBlockedUnits/:blockedUnits', HttpMethod.post, List<Availability>),
	getManyBySpecialPricing('/availability/bySpecialPricing/:specialPricing', HttpMethod.post, List<Availability>),
	getManyByBasePrice('/availability/byBasePrice/:basePrice', HttpMethod.post, List<Availability>),
	getManyByCurrentPrice('/availability/byCurrentPrice/:currentPrice', HttpMethod.post, List<Availability>),
	getManyByPriceSettings('/availability/byPriceSettings/:priceSettings', HttpMethod.post, List<Availability>),
	getManyByMinNights('/availability/byMinNights/:minNights', HttpMethod.post, List<Availability>),
	getManyByMaxNights('/availability/byMaxNights/:maxNights', HttpMethod.post, List<Availability>),
	getManyByMaxGuests('/availability/byMaxGuests/:maxGuests', HttpMethod.post, List<Availability>),
	getManyByDiscountSettings('/availability/byDiscountSettings/:discountSettings', HttpMethod.post, List<Availability>),
	getManyByWeekendRate('/availability/byWeekendRate/:weekendRate', HttpMethod.post, List<Availability>),
	getManyByWeekdayRate('/availability/byWeekdayRate/:weekdayRate', HttpMethod.post, List<Availability>),
	getManyByWeekendMultiplier('/availability/byWeekendMultiplier/:weekendMultiplier', HttpMethod.post, List<Availability>),
	getManyByWeekdayMultiplier('/availability/byWeekdayMultiplier/:weekdayMultiplier', HttpMethod.post, List<Availability>),
	getManyBySeasonalMultiplier('/availability/bySeasonalMultiplier/:seasonalMultiplier', HttpMethod.post, List<Availability>),
	getManyByCreatedAt('/availability/byCreatedAt/:createdAt', HttpMethod.post, List<Availability>),
	getManyByUpdatedAt('/availability/byUpdatedAt/:updatedAt', HttpMethod.post, List<Availability>),
	getManyByDeletedAt('/availability/byDeletedAt/:deletedAt', HttpMethod.post, List<Availability>);

    const AvailabilityEndpoints(this.path, this.method, this.responseType);

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
