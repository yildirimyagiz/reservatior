
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ExternalRentalListingStore extends ModelStreamStore<String, ExternalRentalListing> {

  static ExternalRentalListingStore? _instance;

  static ExternalRentalListingStore get instance {
    _instance ??= ExternalRentalListingStore();
    return _instance!;
  }

  ExternalRentalListingStore() : super(ExternalRentalListing.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ExternalRentalListingStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ExternalRentalListingStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ExternalRentalListingStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getExternalRentalListingId(ExternalRentalListing externalRentalListing) => externalRentalListing.id;

	String? getExternalRentalListingOrgId(ExternalRentalListing externalRentalListing) => externalRentalListing.orgId;

	String? getExternalRentalListingIntegrationId(ExternalRentalListing externalRentalListing) => externalRentalListing.integrationId;

	RentalPlatform? getExternalRentalListingPlatform(ExternalRentalListing externalRentalListing) => externalRentalListing.platform;

	String? getExternalRentalListingExternalId(ExternalRentalListing externalRentalListing) => externalRentalListing.externalId;

	String? getExternalRentalListingExternalUrl(ExternalRentalListing externalRentalListing) => externalRentalListing.externalUrl;

	String? getExternalRentalListingTitle(ExternalRentalListing externalRentalListing) => externalRentalListing.title;

	String? getExternalRentalListingDescription(ExternalRentalListing externalRentalListing) => externalRentalListing.description;

	RentalStatus? getExternalRentalListingStatus(ExternalRentalListing externalRentalListing) => externalRentalListing.status;

	String? getExternalRentalListingAddress(ExternalRentalListing externalRentalListing) => externalRentalListing.address;

	String? getExternalRentalListingCity(ExternalRentalListing externalRentalListing) => externalRentalListing.city;

	String? getExternalRentalListingState(ExternalRentalListing externalRentalListing) => externalRentalListing.state;

	String? getExternalRentalListingZip(ExternalRentalListing externalRentalListing) => externalRentalListing.zip;

	String? getExternalRentalListingCountry(ExternalRentalListing externalRentalListing) => externalRentalListing.country;

	double? getExternalRentalListingLatitude(ExternalRentalListing externalRentalListing) => externalRentalListing.latitude;

	double? getExternalRentalListingLongitude(ExternalRentalListing externalRentalListing) => externalRentalListing.longitude;

	double? getExternalRentalListingNightlyRate(ExternalRentalListing externalRentalListing) => externalRentalListing.nightlyRate;

	String? getExternalRentalListingCurrency(ExternalRentalListing externalRentalListing) => externalRentalListing.currency;

	double? getExternalRentalListingCleaningFee(ExternalRentalListing externalRentalListing) => externalRentalListing.cleaningFee;

	double? getExternalRentalListingServiceFee(ExternalRentalListing externalRentalListing) => externalRentalListing.serviceFee;

	String? getExternalRentalListingCheckInTime(ExternalRentalListing externalRentalListing) => externalRentalListing.checkInTime;

	String? getExternalRentalListingCheckOutTime(ExternalRentalListing externalRentalListing) => externalRentalListing.checkOutTime;

	int? getExternalRentalListingMinStay(ExternalRentalListing externalRentalListing) => externalRentalListing.minStay;

	int? getExternalRentalListingMaxStay(ExternalRentalListing externalRentalListing) => externalRentalListing.maxStay;

	int? getExternalRentalListingBedrooms(ExternalRentalListing externalRentalListing) => externalRentalListing.bedrooms;

	double? getExternalRentalListingBathrooms(ExternalRentalListing externalRentalListing) => externalRentalListing.bathrooms;

	int? getExternalRentalListingMaxGuests(ExternalRentalListing externalRentalListing) => externalRentalListing.maxGuests;

	List<String>? getExternalRentalListingAmenities(ExternalRentalListing externalRentalListing) => externalRentalListing.amenities;

	dynamic? getExternalRentalListingRawData(ExternalRentalListing externalRentalListing) => externalRentalListing.rawData;

	DateTime? getExternalRentalListingLastSyncedAt(ExternalRentalListing externalRentalListing) => externalRentalListing.lastSyncedAt;

	bool? getExternalRentalListingIsActive(ExternalRentalListing externalRentalListing) => externalRentalListing.isActive;

	String? getExternalRentalListingCreatedBy(ExternalRentalListing externalRentalListing) => externalRentalListing.createdBy;

	DateTime? getExternalRentalListingCreatedAt(ExternalRentalListing externalRentalListing) => externalRentalListing.createdAt;

	DateTime? getExternalRentalListingUpdatedAt(ExternalRentalListing externalRentalListing) => externalRentalListing.updatedAt;

	DateTime? getExternalRentalListingDeletedAt(ExternalRentalListing externalRentalListing) => externalRentalListing.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ExternalRentalListing> getByOrgId(
    String orgId,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByIntegrationId(
    String integrationId,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingIntegrationId, integrationId, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByPlatform(
    RentalPlatform platform,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingPlatform, platform, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByExternalId(
    String externalId,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingExternalId, externalId, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByExternalUrl(
    String externalUrl,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingExternalUrl, externalUrl, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByTitle(
    String title,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingTitle, title, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByDescription(
    String description,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingDescription, description, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByStatus(
    RentalStatus status,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingStatus, status, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByAddress(
    String address,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingAddress, address, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByCity(
    String city,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingCity, city, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByState(
    String state,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingState, state, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByZip(
    String zip,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingZip, zip, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByCountry(
    String country,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingCountry, country, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByLatitude(
    double latitude,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingLatitude, latitude, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByLongitude(
    double longitude,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingLongitude, longitude, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByNightlyRate(
    double nightlyRate,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingNightlyRate, nightlyRate, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByCurrency(
    String currency,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByCleaningFee(
    double cleaningFee,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingCleaningFee, cleaningFee, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByServiceFee(
    double serviceFee,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingServiceFee, serviceFee, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByCheckInTime(
    String checkInTime,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingCheckInTime, checkInTime, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByCheckOutTime(
    String checkOutTime,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingCheckOutTime, checkOutTime, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByMinStay(
    int minStay,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingMinStay, minStay, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByMaxStay(
    int maxStay,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingMaxStay, maxStay, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByBedrooms(
    int bedrooms,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingBedrooms, bedrooms, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByBathrooms(
    double bathrooms,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingBathrooms, bathrooms, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByMaxGuests(
    int maxGuests,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingMaxGuests, maxGuests, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByAmenities(
    String amenities,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingAmenities, amenities, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByRawData(
    dynamic rawData,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingRawData, rawData, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByLastSyncedAt(
    DateTime lastSyncedAt,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingLastSyncedAt, lastSyncedAt, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByIsActive(
    bool isActive,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByCreatedBy(
    String createdBy,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ExternalRentalListing> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}
    ) =>
    getManyIncluding(getExternalRentalListingDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  ApiIntegration? getIntegration(
    ExternalRentalListing externalRentalListing, {ModelFilter? modelFilter, List<ApiIntegrationInclude>? includes}) {
    if (externalRentalListing.integrationId == null) {
        return null;
    } else {
        final integration = ApiIntegrationStore.instance.getById(externalRentalListing.integrationId!, includes: includes);
        externalRentalListing.integration = integration;
        // setIncludedReferences(integration, includes: includes);
        return integration;
    }
}

	Organization? getOrg(
    ExternalRentalListing externalRentalListing, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (externalRentalListing.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(externalRentalListing.orgId!, includes: includes);
        externalRentalListing.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ExternalRentalListing>> getAll$({bool useCache = true, ModelFilter<ExternalRentalListing>? modelFilter, List<ExternalRentalListingInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ExternalRentalListingEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ExternalRentalListing?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getExternalRentalListingId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ExternalRentalListing>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByIntegrationId$(
        String integrationId,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingIntegrationId,
        value: integrationId,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByIntegrationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByPlatform$(
        RentalPlatform platform,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<RentalPlatform>(
        getPropVal: getExternalRentalListingPlatform,
        value: platform,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByPlatform,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByExternalId$(
        String externalId,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingExternalId,
        value: externalId,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByExternalId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByExternalUrl$(
        String externalUrl,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingExternalUrl,
        value: externalUrl,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByExternalUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByStatus$(
        RentalStatus status,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<RentalStatus>(
        getPropVal: getExternalRentalListingStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByAddress$(
        String address,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingAddress,
        value: address,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByCity$(
        String city,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingCity,
        value: city,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByCity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByState$(
        String state,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingState,
        value: state,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByState,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByZip$(
        String zip,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingZip,
        value: zip,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByZip,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByCountry$(
        String country,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingCountry,
        value: country,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByCountry,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByLatitude$(
        double latitude,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExternalRentalListingLatitude,
        value: latitude,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByLatitude,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByLongitude$(
        double longitude,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExternalRentalListingLongitude,
        value: longitude,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByLongitude,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByNightlyRate$(
        double nightlyRate,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExternalRentalListingNightlyRate,
        value: nightlyRate,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByNightlyRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByCleaningFee$(
        double cleaningFee,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExternalRentalListingCleaningFee,
        value: cleaningFee,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByCleaningFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByServiceFee$(
        double serviceFee,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExternalRentalListingServiceFee,
        value: serviceFee,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByServiceFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByCheckInTime$(
        String checkInTime,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingCheckInTime,
        value: checkInTime,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByCheckInTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByCheckOutTime$(
        String checkOutTime,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingCheckOutTime,
        value: checkOutTime,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByCheckOutTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByMinStay$(
        int minStay,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getExternalRentalListingMinStay,
        value: minStay,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByMinStay,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByMaxStay$(
        int maxStay,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getExternalRentalListingMaxStay,
        value: maxStay,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByMaxStay,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByBedrooms$(
        int bedrooms,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getExternalRentalListingBedrooms,
        value: bedrooms,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByBedrooms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByBathrooms$(
        double bathrooms,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExternalRentalListingBathrooms,
        value: bathrooms,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByBathrooms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByMaxGuests$(
        int maxGuests,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getExternalRentalListingMaxGuests,
        value: maxGuests,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByMaxGuests,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByAmenities$(
        String amenities,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingAmenities,
        value: amenities,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByAmenities,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByRawData$(
        dynamic rawData,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getExternalRentalListingRawData,
        value: rawData,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByRawData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByLastSyncedAt$(
        DateTime lastSyncedAt,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExternalRentalListingLastSyncedAt,
        value: lastSyncedAt,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByLastSyncedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getExternalRentalListingIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExternalRentalListingCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExternalRentalListingCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExternalRentalListingUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExternalRentalListing>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ExternalRentalListing>? modelFilter,
        List<ExternalRentalListingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExternalRentalListingDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ExternalRentalListingEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<ApiIntegration?> getIntegration$(
    ExternalRentalListing externalRentalListing, {bool useCache = true, ModelFilter<ApiIntegration>? modelFilter, List<ApiIntegrationInclude>? includes}) {
    if (externalRentalListing.integrationId == null) {
        return Stream.value(null);
    } else {
        return ApiIntegrationStore.instance.getById$(
            externalRentalListing.integrationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((integration) {
            externalRentalListing.integration = integration;
        });
    }
}

	Stream<Organization?> getOrg$(
    ExternalRentalListing externalRentalListing, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (externalRentalListing.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            externalRentalListing.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            externalRentalListing.org = org;
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
ExternalRentalListing recursiveUpsert(ExternalRentalListing externalRentalListing, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ExternalRentalListing'} 
        : const {};
    if (externalRentalListing.integration != null && (!preventCircularSerialization || !upsertedTypes.contains('ApiIntegration'))) {
        externalRentalListing.integration = ApiIntegrationStore.instance.recursiveUpsert(externalRentalListing.integration!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (externalRentalListing.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        externalRentalListing.org = OrganizationStore.instance.recursiveUpsert(externalRentalListing.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(externalRentalListing);
}

  List<ExternalRentalListing> recursiveListUpsert(List<ExternalRentalListing> externalRentalListings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedExternalRentalListings = <ExternalRentalListing>[];
    for (var externalRentalListing in externalRentalListings) {
        updatedExternalRentalListings.add(recursiveUpsert(externalRentalListing, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedExternalRentalListings;
}

//   @override
//   ExternalRentalListing upsert(ExternalRentalListing item) {
//     return recursiveUpsert(item);
//   }

}


class ExternalRentalListingInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ExternalRentalListingInclude.integration({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ApiIntegration>? modelFilter,
    List<ApiIntegrationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (externalRentalListing) => ExternalRentalListingStore.instance
            .getIntegration$(externalRentalListing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (externalRentalListing) => ExternalRentalListingStore.instance
            .getIntegration(externalRentalListing, modelFilter: modelFilter, includes: includes);
      }
}

	ExternalRentalListingInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (externalRentalListing) => ExternalRentalListingStore.instance
            .getOrg$(externalRentalListing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (externalRentalListing) => ExternalRentalListingStore.instance
            .getOrg(externalRentalListing, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ExternalRentalListingEndpoints implements Endpoint {

    getAll('/externalRentalListing', HttpMethod.post, List<ExternalRentalListing>),
	getById('/externalRentalListing/byId/:id', HttpMethod.post, ExternalRentalListing),
	getManyByOrgId('/externalRentalListing/byOrgId/:orgId', HttpMethod.post, List<ExternalRentalListing>),
	getManyByIntegrationId('/externalRentalListing/byIntegrationId/:integrationId', HttpMethod.post, List<ExternalRentalListing>),
	getManyByPlatform('/externalRentalListing/byPlatform/:platform', HttpMethod.post, List<ExternalRentalListing>),
	getManyByExternalId('/externalRentalListing/byExternalId/:externalId', HttpMethod.post, List<ExternalRentalListing>),
	getManyByExternalUrl('/externalRentalListing/byExternalUrl/:externalUrl', HttpMethod.post, List<ExternalRentalListing>),
	getManyByTitle('/externalRentalListing/byTitle/:title', HttpMethod.post, List<ExternalRentalListing>),
	getManyByDescription('/externalRentalListing/byDescription/:description', HttpMethod.post, List<ExternalRentalListing>),
	getManyByStatus('/externalRentalListing/byStatus/:status', HttpMethod.post, List<ExternalRentalListing>),
	getManyByAddress('/externalRentalListing/byAddress/:address', HttpMethod.post, List<ExternalRentalListing>),
	getManyByCity('/externalRentalListing/byCity/:city', HttpMethod.post, List<ExternalRentalListing>),
	getManyByState('/externalRentalListing/byState/:state', HttpMethod.post, List<ExternalRentalListing>),
	getManyByZip('/externalRentalListing/byZip/:zip', HttpMethod.post, List<ExternalRentalListing>),
	getManyByCountry('/externalRentalListing/byCountry/:country', HttpMethod.post, List<ExternalRentalListing>),
	getManyByLatitude('/externalRentalListing/byLatitude/:latitude', HttpMethod.post, List<ExternalRentalListing>),
	getManyByLongitude('/externalRentalListing/byLongitude/:longitude', HttpMethod.post, List<ExternalRentalListing>),
	getManyByNightlyRate('/externalRentalListing/byNightlyRate/:nightlyRate', HttpMethod.post, List<ExternalRentalListing>),
	getManyByCurrency('/externalRentalListing/byCurrency/:currency', HttpMethod.post, List<ExternalRentalListing>),
	getManyByCleaningFee('/externalRentalListing/byCleaningFee/:cleaningFee', HttpMethod.post, List<ExternalRentalListing>),
	getManyByServiceFee('/externalRentalListing/byServiceFee/:serviceFee', HttpMethod.post, List<ExternalRentalListing>),
	getManyByCheckInTime('/externalRentalListing/byCheckInTime/:checkInTime', HttpMethod.post, List<ExternalRentalListing>),
	getManyByCheckOutTime('/externalRentalListing/byCheckOutTime/:checkOutTime', HttpMethod.post, List<ExternalRentalListing>),
	getManyByMinStay('/externalRentalListing/byMinStay/:minStay', HttpMethod.post, List<ExternalRentalListing>),
	getManyByMaxStay('/externalRentalListing/byMaxStay/:maxStay', HttpMethod.post, List<ExternalRentalListing>),
	getManyByBedrooms('/externalRentalListing/byBedrooms/:bedrooms', HttpMethod.post, List<ExternalRentalListing>),
	getManyByBathrooms('/externalRentalListing/byBathrooms/:bathrooms', HttpMethod.post, List<ExternalRentalListing>),
	getManyByMaxGuests('/externalRentalListing/byMaxGuests/:maxGuests', HttpMethod.post, List<ExternalRentalListing>),
	getManyByAmenities('/externalRentalListing/byAmenities/:amenities', HttpMethod.post, List<ExternalRentalListing>),
	getManyByRawData('/externalRentalListing/byRawData/:rawData', HttpMethod.post, List<ExternalRentalListing>),
	getManyByLastSyncedAt('/externalRentalListing/byLastSyncedAt/:lastSyncedAt', HttpMethod.post, List<ExternalRentalListing>),
	getManyByIsActive('/externalRentalListing/byIsActive/:isActive', HttpMethod.post, List<ExternalRentalListing>),
	getManyByCreatedBy('/externalRentalListing/byCreatedBy/:createdBy', HttpMethod.post, List<ExternalRentalListing>),
	getManyByCreatedAt('/externalRentalListing/byCreatedAt/:createdAt', HttpMethod.post, List<ExternalRentalListing>),
	getManyByUpdatedAt('/externalRentalListing/byUpdatedAt/:updatedAt', HttpMethod.post, List<ExternalRentalListing>),
	getManyByDeletedAt('/externalRentalListing/byDeletedAt/:deletedAt', HttpMethod.post, List<ExternalRentalListing>);

    const ExternalRentalListingEndpoints(this.path, this.method, this.responseType);

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
