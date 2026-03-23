
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class VacationRentalStore extends ModelStreamStore<String, VacationRental> {

  static VacationRentalStore? _instance;

  static VacationRentalStore get instance {
    _instance ??= VacationRentalStore();
    return _instance!;
  }

  VacationRentalStore() : super(VacationRental.fromJson) {
    if (_instance != null) {
        throw Exception(
            'VacationRentalStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending VacationRentalStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use VacationRentalStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getVacationRentalId(VacationRental vacationRental) => vacationRental.id;

	String? getVacationRentalOrgId(VacationRental vacationRental) => vacationRental.orgId;

	String? getVacationRentalPropertyId(VacationRental vacationRental) => vacationRental.propertyId;

	String? getVacationRentalListingId(VacationRental vacationRental) => vacationRental.listingId;

	bool? getVacationRentalIsActive(VacationRental vacationRental) => vacationRental.isActive;

	String? getVacationRentalRentalType(VacationRental vacationRental) => vacationRental.rentalType;

	bool? getVacationRentalInstantBooking(VacationRental vacationRental) => vacationRental.instantBooking;

	double? getVacationRentalBaseNightlyRate(VacationRental vacationRental) => vacationRental.baseNightlyRate;

	String? getVacationRentalCurrency(VacationRental vacationRental) => vacationRental.currency;

	double? getVacationRentalCleaningFee(VacationRental vacationRental) => vacationRental.cleaningFee;

	double? getVacationRentalSecurityDeposit(VacationRental vacationRental) => vacationRental.securityDeposit;

	double? getVacationRentalWeeklyDiscount(VacationRental vacationRental) => vacationRental.weeklyDiscount;

	double? getVacationRentalMonthlyDiscount(VacationRental vacationRental) => vacationRental.monthlyDiscount;

	String? getVacationRentalCheckInTime(VacationRental vacationRental) => vacationRental.checkInTime;

	String? getVacationRentalCheckOutTime(VacationRental vacationRental) => vacationRental.checkOutTime;

	int? getVacationRentalMinStayNights(VacationRental vacationRental) => vacationRental.minStayNights;

	int? getVacationRentalMaxStayNights(VacationRental vacationRental) => vacationRental.maxStayNights;

	int? getVacationRentalAdvanceBookingDays(VacationRental vacationRental) => vacationRental.advanceBookingDays;

	int? getVacationRentalMaxGuests(VacationRental vacationRental) => vacationRental.maxGuests;

	bool? getVacationRentalChildrenAllowed(VacationRental vacationRental) => vacationRental.childrenAllowed;

	bool? getVacationRentalPetsAllowed(VacationRental vacationRental) => vacationRental.petsAllowed;

	bool? getVacationRentalSmokingAllowed(VacationRental vacationRental) => vacationRental.smokingAllowed;

	bool? getVacationRentalEventsAllowed(VacationRental vacationRental) => vacationRental.eventsAllowed;

	String? getVacationRentalHouseRules(VacationRental vacationRental) => vacationRental.houseRules;

	String? getVacationRentalCancellationPolicy(VacationRental vacationRental) => vacationRental.cancellationPolicy;

	String? getVacationRentalCreatedBy(VacationRental vacationRental) => vacationRental.createdBy;

	DateTime? getVacationRentalCreatedAt(VacationRental vacationRental) => vacationRental.createdAt;

	DateTime? getVacationRentalUpdatedAt(VacationRental vacationRental) => vacationRental.updatedAt;

	DateTime? getVacationRentalDeletedAt(VacationRental vacationRental) => vacationRental.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
VacationRental? getByPropertyId(
    String propertyId,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getIncluding(getVacationRentalPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
VacationRental? getByListingId(
    String listingId,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getIncluding(getVacationRentalListingId, listingId, modelFilter: modelFilter, includes: includes);

  
List<VacationRental> getByOrgId(
    String orgId,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByIsActive(
    bool isActive,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByRentalType(
    String rentalType,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalRentalType, rentalType, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByInstantBooking(
    bool instantBooking,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalInstantBooking, instantBooking, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByBaseNightlyRate(
    double baseNightlyRate,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalBaseNightlyRate, baseNightlyRate, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByCurrency(
    String currency,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByCleaningFee(
    double cleaningFee,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalCleaningFee, cleaningFee, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getBySecurityDeposit(
    double securityDeposit,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalSecurityDeposit, securityDeposit, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByWeeklyDiscount(
    double weeklyDiscount,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalWeeklyDiscount, weeklyDiscount, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByMonthlyDiscount(
    double monthlyDiscount,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalMonthlyDiscount, monthlyDiscount, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByCheckInTime(
    String checkInTime,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalCheckInTime, checkInTime, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByCheckOutTime(
    String checkOutTime,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalCheckOutTime, checkOutTime, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByMinStayNights(
    int minStayNights,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalMinStayNights, minStayNights, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByMaxStayNights(
    int maxStayNights,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalMaxStayNights, maxStayNights, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByAdvanceBookingDays(
    int advanceBookingDays,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalAdvanceBookingDays, advanceBookingDays, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByMaxGuests(
    int maxGuests,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalMaxGuests, maxGuests, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByChildrenAllowed(
    bool childrenAllowed,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalChildrenAllowed, childrenAllowed, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByPetsAllowed(
    bool petsAllowed,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPetsAllowed, petsAllowed, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getBySmokingAllowed(
    bool smokingAllowed,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalSmokingAllowed, smokingAllowed, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByEventsAllowed(
    bool eventsAllowed,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalEventsAllowed, eventsAllowed, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByHouseRules(
    String houseRules,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalHouseRules, houseRules, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByCancellationPolicy(
    String cancellationPolicy,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalCancellationPolicy, cancellationPolicy, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByCreatedBy(
    String createdBy,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<VacationRental> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Listing? getListing(
    VacationRental vacationRental, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (vacationRental.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(vacationRental.listingId!, includes: includes);
        vacationRental.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    VacationRental vacationRental, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (vacationRental.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(vacationRental.orgId!, includes: includes);
        vacationRental.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    VacationRental vacationRental, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (vacationRental.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(vacationRental.propertyId!, includes: includes);
        vacationRental.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<VacationRentalPlatform> getPlatformListings(
    VacationRental vacationRental, {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}) {
    final platformListings = VacationRentalPlatformStore.instance.getByRentalId(vacationRental.$uid!, modelFilter: modelFilter, includes: includes);
    vacationRental.platformListings = platformListings;
    // setIncludedReferencesForList(platformListings, includes: includes);
    return platformListings;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<VacationRental>> getAll$({bool useCache = true, ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: VacationRentalEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<VacationRental?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getVacationRentalId,
        value: id,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<VacationRental?> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getVacationRentalPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<VacationRental?> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getVacationRentalListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<VacationRental>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getVacationRentalIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByRentalType$(
        String rentalType,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalRentalType,
        value: rentalType,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByRentalType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByInstantBooking$(
        bool instantBooking,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getVacationRentalInstantBooking,
        value: instantBooking,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByInstantBooking,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByBaseNightlyRate$(
        double baseNightlyRate,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getVacationRentalBaseNightlyRate,
        value: baseNightlyRate,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByBaseNightlyRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByCleaningFee$(
        double cleaningFee,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getVacationRentalCleaningFee,
        value: cleaningFee,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByCleaningFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getBySecurityDeposit$(
        double securityDeposit,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getVacationRentalSecurityDeposit,
        value: securityDeposit,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyBySecurityDeposit,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByWeeklyDiscount$(
        double weeklyDiscount,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getVacationRentalWeeklyDiscount,
        value: weeklyDiscount,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByWeeklyDiscount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByMonthlyDiscount$(
        double monthlyDiscount,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getVacationRentalMonthlyDiscount,
        value: monthlyDiscount,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByMonthlyDiscount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByCheckInTime$(
        String checkInTime,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalCheckInTime,
        value: checkInTime,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByCheckInTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByCheckOutTime$(
        String checkOutTime,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalCheckOutTime,
        value: checkOutTime,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByCheckOutTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByMinStayNights$(
        int minStayNights,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getVacationRentalMinStayNights,
        value: minStayNights,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByMinStayNights,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByMaxStayNights$(
        int maxStayNights,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getVacationRentalMaxStayNights,
        value: maxStayNights,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByMaxStayNights,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByAdvanceBookingDays$(
        int advanceBookingDays,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getVacationRentalAdvanceBookingDays,
        value: advanceBookingDays,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByAdvanceBookingDays,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByMaxGuests$(
        int maxGuests,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getVacationRentalMaxGuests,
        value: maxGuests,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByMaxGuests,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByChildrenAllowed$(
        bool childrenAllowed,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getVacationRentalChildrenAllowed,
        value: childrenAllowed,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByChildrenAllowed,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByPetsAllowed$(
        bool petsAllowed,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getVacationRentalPetsAllowed,
        value: petsAllowed,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByPetsAllowed,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getBySmokingAllowed$(
        bool smokingAllowed,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getVacationRentalSmokingAllowed,
        value: smokingAllowed,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyBySmokingAllowed,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByEventsAllowed$(
        bool eventsAllowed,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getVacationRentalEventsAllowed,
        value: eventsAllowed,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByEventsAllowed,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByHouseRules$(
        String houseRules,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalHouseRules,
        value: houseRules,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByHouseRules,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByCancellationPolicy$(
        String cancellationPolicy,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalCancellationPolicy,
        value: cancellationPolicy,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByCancellationPolicy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVacationRentalCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVacationRentalUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRental>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<VacationRental>? modelFilter,
        List<VacationRentalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVacationRentalDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: VacationRentalEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Listing?> getListing$(
    VacationRental vacationRental, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (vacationRental.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            vacationRental.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            vacationRental.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    VacationRental vacationRental, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (vacationRental.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            vacationRental.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            vacationRental.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    VacationRental vacationRental, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (vacationRental.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            vacationRental.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            vacationRental.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<VacationRentalPlatform>> getPlatformListings$(
    VacationRental vacationRental, {bool useCache = true, ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}) {
    return VacationRentalPlatformStore.instance.getByRentalId$(
        vacationRental.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((platformListings) {
        vacationRental.platformListings = platformListings;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
VacationRental recursiveUpsert(VacationRental vacationRental, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'VacationRental'} 
        : const {};
    if (vacationRental.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        vacationRental.listing = ListingStore.instance.recursiveUpsert(vacationRental.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (vacationRental.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        vacationRental.org = OrganizationStore.instance.recursiveUpsert(vacationRental.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (vacationRental.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        vacationRental.property = PropertyStore.instance.recursiveUpsert(vacationRental.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (vacationRental.platformListings != null && (!preventCircularSerialization || !upsertedTypes.contains('VacationRentalPlatform'))) {
        vacationRental.platformListings = VacationRentalPlatformStore.instance.recursiveListUpsert(vacationRental.platformListings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(vacationRental);
}

  List<VacationRental> recursiveListUpsert(List<VacationRental> vacationRentals, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedVacationRentals = <VacationRental>[];
    for (var vacationRental in vacationRentals) {
        updatedVacationRentals.add(recursiveUpsert(vacationRental, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedVacationRentals;
}

//   @override
//   VacationRental upsert(VacationRental item) {
//     return recursiveUpsert(item);
//   }

}


class VacationRentalInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      VacationRentalInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (vacationRental) => VacationRentalStore.instance
            .getListing$(vacationRental, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (vacationRental) => VacationRentalStore.instance
            .getListing(vacationRental, modelFilter: modelFilter, includes: includes);
      }
}

	VacationRentalInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (vacationRental) => VacationRentalStore.instance
            .getOrg$(vacationRental, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (vacationRental) => VacationRentalStore.instance
            .getOrg(vacationRental, modelFilter: modelFilter, includes: includes);
      }
}

	VacationRentalInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (vacationRental) => VacationRentalStore.instance
            .getProperty$(vacationRental, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (vacationRental) => VacationRentalStore.instance
            .getProperty(vacationRental, modelFilter: modelFilter, includes: includes);
      }
}

	VacationRentalInclude.platformListings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VacationRentalPlatform>? modelFilter,
    List<VacationRentalPlatformInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (vacationRental) => VacationRentalStore.instance
            .getPlatformListings$(vacationRental, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (vacationRental) => VacationRentalStore.instance
            .getPlatformListings(vacationRental, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum VacationRentalEndpoints implements Endpoint {

    getAll('/vacationRental', HttpMethod.post, List<VacationRental>),
	getById('/vacationRental/byId/:id', HttpMethod.post, VacationRental),
	getManyByOrgId('/vacationRental/byOrgId/:orgId', HttpMethod.post, List<VacationRental>),
	getByPropertyId('/vacationRental/byPropertyId/:propertyId', HttpMethod.post, VacationRental),
	getByListingId('/vacationRental/byListingId/:listingId', HttpMethod.post, VacationRental),
	getManyByIsActive('/vacationRental/byIsActive/:isActive', HttpMethod.post, List<VacationRental>),
	getManyByRentalType('/vacationRental/byRentalType/:rentalType', HttpMethod.post, List<VacationRental>),
	getManyByInstantBooking('/vacationRental/byInstantBooking/:instantBooking', HttpMethod.post, List<VacationRental>),
	getManyByBaseNightlyRate('/vacationRental/byBaseNightlyRate/:baseNightlyRate', HttpMethod.post, List<VacationRental>),
	getManyByCurrency('/vacationRental/byCurrency/:currency', HttpMethod.post, List<VacationRental>),
	getManyByCleaningFee('/vacationRental/byCleaningFee/:cleaningFee', HttpMethod.post, List<VacationRental>),
	getManyBySecurityDeposit('/vacationRental/bySecurityDeposit/:securityDeposit', HttpMethod.post, List<VacationRental>),
	getManyByWeeklyDiscount('/vacationRental/byWeeklyDiscount/:weeklyDiscount', HttpMethod.post, List<VacationRental>),
	getManyByMonthlyDiscount('/vacationRental/byMonthlyDiscount/:monthlyDiscount', HttpMethod.post, List<VacationRental>),
	getManyByCheckInTime('/vacationRental/byCheckInTime/:checkInTime', HttpMethod.post, List<VacationRental>),
	getManyByCheckOutTime('/vacationRental/byCheckOutTime/:checkOutTime', HttpMethod.post, List<VacationRental>),
	getManyByMinStayNights('/vacationRental/byMinStayNights/:minStayNights', HttpMethod.post, List<VacationRental>),
	getManyByMaxStayNights('/vacationRental/byMaxStayNights/:maxStayNights', HttpMethod.post, List<VacationRental>),
	getManyByAdvanceBookingDays('/vacationRental/byAdvanceBookingDays/:advanceBookingDays', HttpMethod.post, List<VacationRental>),
	getManyByMaxGuests('/vacationRental/byMaxGuests/:maxGuests', HttpMethod.post, List<VacationRental>),
	getManyByChildrenAllowed('/vacationRental/byChildrenAllowed/:childrenAllowed', HttpMethod.post, List<VacationRental>),
	getManyByPetsAllowed('/vacationRental/byPetsAllowed/:petsAllowed', HttpMethod.post, List<VacationRental>),
	getManyBySmokingAllowed('/vacationRental/bySmokingAllowed/:smokingAllowed', HttpMethod.post, List<VacationRental>),
	getManyByEventsAllowed('/vacationRental/byEventsAllowed/:eventsAllowed', HttpMethod.post, List<VacationRental>),
	getManyByHouseRules('/vacationRental/byHouseRules/:houseRules', HttpMethod.post, List<VacationRental>),
	getManyByCancellationPolicy('/vacationRental/byCancellationPolicy/:cancellationPolicy', HttpMethod.post, List<VacationRental>),
	getManyByCreatedBy('/vacationRental/byCreatedBy/:createdBy', HttpMethod.post, List<VacationRental>),
	getManyByCreatedAt('/vacationRental/byCreatedAt/:createdAt', HttpMethod.post, List<VacationRental>),
	getManyByUpdatedAt('/vacationRental/byUpdatedAt/:updatedAt', HttpMethod.post, List<VacationRental>),
	getManyByDeletedAt('/vacationRental/byDeletedAt/:deletedAt', HttpMethod.post, List<VacationRental>);

    const VacationRentalEndpoints(this.path, this.method, this.responseType);

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
