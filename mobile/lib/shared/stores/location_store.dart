
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class LocationStore extends ModelStreamStore<String, Location> {

  static LocationStore? _instance;

  static LocationStore get instance {
    _instance ??= LocationStore();
    return _instance!;
  }

  LocationStore() : super(Location.fromJson) {
    if (_instance != null) {
        throw Exception(
            'LocationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending LocationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use LocationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getLocationId(Location location) => location.id;

	String? getLocationOrgId(Location location) => location.orgId;

	String? getLocationPropertyId(Location location) => location.propertyId;

	String? getLocationListingId(Location location) => location.listingId;

	String? getLocationDealId(Location location) => location.dealId;

	String? getLocationAddressLine1(Location location) => location.addressLine1;

	String? getLocationAddressLine2(Location location) => location.addressLine2;

	String? getLocationAddressLine3(Location location) => location.addressLine3;

	String? getLocationCity(Location location) => location.city;

	String? getLocationState(Location location) => location.state;

	String? getLocationZip(Location location) => location.zip;

	String? getLocationZipPlus4(Location location) => location.zipPlus4;

	String? getLocationCountry(Location location) => location.country;

	String? getLocationStateName(Location location) => location.stateName;

	String? getLocationStateFIPS(Location location) => location.stateFIPS;

	String? getLocationCensusTract(Location location) => location.censusTract;

	String? getLocationBlockGroup(Location location) => location.blockGroup;

	String? getLocationPrecinct(Location location) => location.precinct;

	String? getLocationSchoolDistrict(Location location) => location.schoolDistrict;

	String? getLocationCongressionalDistrict(Location location) => location.congressionalDistrict;

	double? getLocationLatitude(Location location) => location.latitude;

	double? getLocationLongitude(Location location) => location.longitude;

	LocationAccuracy? getLocationAccuracy(Location location) => location.accuracy;

	double? getLocationAltitude(Location location) => location.altitude;

	double? getLocationElevation(Location location) => location.elevation;

	GeocodingStatus? getLocationGeocodingStatus(Location location) => location.geocodingStatus;

	DateTime? getLocationGeocodedAt(Location location) => location.geocodedAt;

	MapProvider? getLocationGeocodingProvider(Location location) => location.geocodingProvider;

	double? getLocationConfidenceScore(Location location) => location.confidenceScore;

	bool? getLocationIsVerified(Location location) => location.isVerified;

	DateTime? getLocationVerifiedAt(Location location) => location.verifiedAt;

	String? getLocationVerifiedBy(Location location) => location.verifiedBy;

	bool? getLocationUspsVerified(Location location) => location.uspsVerified;

	DateTime? getLocationUspsVerifiedAt(Location location) => location.uspsVerifiedAt;

	String? getLocationDpvConfirmation(Location location) => location.dpvConfirmation;

	String? getLocationFootnotes(Location location) => location.footnotes;

	bool? getLocationIsStandardized(Location location) => location.isStandardized;

	bool? getLocationIsResidential(Location location) => location.isResidential;

	bool? getLocationIsCommercial(Location location) => location.isCommercial;

	bool? getLocationIsValid(Location location) => location.isValid;

	MarkerType? getLocationMarkerType(Location location) => location.markerType;

	MarkerIcon? getLocationMarkerIcon(Location location) => location.markerIcon;

	String? getLocationMarkerColor(Location location) => location.markerColor;

	int? getLocationMarkerSize(Location location) => location.markerSize;

	bool? getLocationIsVisible(Location location) => location.isVisible;

	int? getLocationZIndex(Location location) => location.zIndex;

	double? getLocationOpacity(Location location) => location.opacity;

	String? getLocationTitle(Location location) => location.title;

	String? getLocationDescription(Location location) => location.description;

	String? getLocationImageUrl(Location location) => location.imageUrl;

	String? getLocationLinkUrl(Location location) => location.linkUrl;

	String? getLocationCategory(Location location) => location.category;

	List<String>? getLocationTags(Location location) => location.tags;

	String? getLocationMondayOpen(Location location) => location.mondayOpen;

	String? getLocationMondayClose(Location location) => location.mondayClose;

	String? getLocationTuesdayOpen(Location location) => location.tuesdayOpen;

	String? getLocationTuesdayClose(Location location) => location.tuesdayClose;

	String? getLocationWednesdayOpen(Location location) => location.wednesdayOpen;

	String? getLocationWednesdayClose(Location location) => location.wednesdayClose;

	String? getLocationThursdayOpen(Location location) => location.thursdayOpen;

	String? getLocationThursdayClose(Location location) => location.thursdayClose;

	String? getLocationFridayOpen(Location location) => location.fridayOpen;

	String? getLocationFridayClose(Location location) => location.fridayClose;

	String? getLocationSaturdayOpen(Location location) => location.saturdayOpen;

	String? getLocationSaturdayClose(Location location) => location.saturdayClose;

	String? getLocationSundayOpen(Location location) => location.sundayOpen;

	String? getLocationSundayClose(Location location) => location.sundayClose;

	dynamic? getLocationMetadata(Location location) => location.metadata;

	String? getLocationCreatedBy(Location location) => location.createdBy;

	DateTime? getLocationCreatedAt(Location location) => location.createdAt;

	DateTime? getLocationUpdatedAt(Location location) => location.updatedAt;

	DateTime? getLocationDeletedAt(Location location) => location.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Location> getByOrgId(
    String orgId,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Location> getByPropertyId(
    String propertyId,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Location> getByListingId(
    String listingId,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Location> getByDealId(
    String dealId,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationDealId, dealId, modelFilter: modelFilter, includes: includes);

	
List<Location> getByAddressLine1(
    String addressLine1,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationAddressLine1, addressLine1, modelFilter: modelFilter, includes: includes);

	
List<Location> getByAddressLine2(
    String addressLine2,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationAddressLine2, addressLine2, modelFilter: modelFilter, includes: includes);

	
List<Location> getByAddressLine3(
    String addressLine3,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationAddressLine3, addressLine3, modelFilter: modelFilter, includes: includes);

	
List<Location> getByCity(
    String city,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationCity, city, modelFilter: modelFilter, includes: includes);

	
List<Location> getByState(
    String state,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationState, state, modelFilter: modelFilter, includes: includes);

	
List<Location> getByZip(
    String zip,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationZip, zip, modelFilter: modelFilter, includes: includes);

	
List<Location> getByZipPlus4(
    String zipPlus4,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationZipPlus4, zipPlus4, modelFilter: modelFilter, includes: includes);

	
List<Location> getByCountry(
    String country,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationCountry, country, modelFilter: modelFilter, includes: includes);

	
List<Location> getByStateName(
    String stateName,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationStateName, stateName, modelFilter: modelFilter, includes: includes);

	
List<Location> getByStateFIPS(
    String stateFIPS,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationStateFIPS, stateFIPS, modelFilter: modelFilter, includes: includes);

	
List<Location> getByCensusTract(
    String censusTract,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationCensusTract, censusTract, modelFilter: modelFilter, includes: includes);

	
List<Location> getByBlockGroup(
    String blockGroup,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationBlockGroup, blockGroup, modelFilter: modelFilter, includes: includes);

	
List<Location> getByPrecinct(
    String precinct,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationPrecinct, precinct, modelFilter: modelFilter, includes: includes);

	
List<Location> getBySchoolDistrict(
    String schoolDistrict,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationSchoolDistrict, schoolDistrict, modelFilter: modelFilter, includes: includes);

	
List<Location> getByCongressionalDistrict(
    String congressionalDistrict,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationCongressionalDistrict, congressionalDistrict, modelFilter: modelFilter, includes: includes);

	
List<Location> getByLatitude(
    double latitude,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationLatitude, latitude, modelFilter: modelFilter, includes: includes);

	
List<Location> getByLongitude(
    double longitude,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationLongitude, longitude, modelFilter: modelFilter, includes: includes);

	
List<Location> getByAccuracy(
    LocationAccuracy accuracy,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationAccuracy, accuracy, modelFilter: modelFilter, includes: includes);

	
List<Location> getByAltitude(
    double altitude,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationAltitude, altitude, modelFilter: modelFilter, includes: includes);

	
List<Location> getByElevation(
    double elevation,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationElevation, elevation, modelFilter: modelFilter, includes: includes);

	
List<Location> getByGeocodingStatus(
    GeocodingStatus geocodingStatus,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationGeocodingStatus, geocodingStatus, modelFilter: modelFilter, includes: includes);

	
List<Location> getByGeocodedAt(
    DateTime geocodedAt,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationGeocodedAt, geocodedAt, modelFilter: modelFilter, includes: includes);

	
List<Location> getByGeocodingProvider(
    MapProvider geocodingProvider,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationGeocodingProvider, geocodingProvider, modelFilter: modelFilter, includes: includes);

	
List<Location> getByConfidenceScore(
    double confidenceScore,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationConfidenceScore, confidenceScore, modelFilter: modelFilter, includes: includes);

	
List<Location> getByIsVerified(
    bool isVerified,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationIsVerified, isVerified, modelFilter: modelFilter, includes: includes);

	
List<Location> getByVerifiedAt(
    DateTime verifiedAt,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationVerifiedAt, verifiedAt, modelFilter: modelFilter, includes: includes);

	
List<Location> getByVerifiedBy(
    String verifiedBy,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationVerifiedBy, verifiedBy, modelFilter: modelFilter, includes: includes);

	
List<Location> getByUspsVerified(
    bool uspsVerified,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationUspsVerified, uspsVerified, modelFilter: modelFilter, includes: includes);

	
List<Location> getByUspsVerifiedAt(
    DateTime uspsVerifiedAt,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationUspsVerifiedAt, uspsVerifiedAt, modelFilter: modelFilter, includes: includes);

	
List<Location> getByDpvConfirmation(
    String dpvConfirmation,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationDpvConfirmation, dpvConfirmation, modelFilter: modelFilter, includes: includes);

	
List<Location> getByFootnotes(
    String footnotes,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationFootnotes, footnotes, modelFilter: modelFilter, includes: includes);

	
List<Location> getByIsStandardized(
    bool isStandardized,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationIsStandardized, isStandardized, modelFilter: modelFilter, includes: includes);

	
List<Location> getByIsResidential(
    bool isResidential,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationIsResidential, isResidential, modelFilter: modelFilter, includes: includes);

	
List<Location> getByIsCommercial(
    bool isCommercial,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationIsCommercial, isCommercial, modelFilter: modelFilter, includes: includes);

	
List<Location> getByIsValid(
    bool isValid,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationIsValid, isValid, modelFilter: modelFilter, includes: includes);

	
List<Location> getByMarkerType(
    MarkerType markerType,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationMarkerType, markerType, modelFilter: modelFilter, includes: includes);

	
List<Location> getByMarkerIcon(
    MarkerIcon markerIcon,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationMarkerIcon, markerIcon, modelFilter: modelFilter, includes: includes);

	
List<Location> getByMarkerColor(
    String markerColor,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationMarkerColor, markerColor, modelFilter: modelFilter, includes: includes);

	
List<Location> getByMarkerSize(
    int markerSize,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationMarkerSize, markerSize, modelFilter: modelFilter, includes: includes);

	
List<Location> getByIsVisible(
    bool isVisible,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationIsVisible, isVisible, modelFilter: modelFilter, includes: includes);

	
List<Location> getByZIndex(
    int zIndex,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationZIndex, zIndex, modelFilter: modelFilter, includes: includes);

	
List<Location> getByOpacity(
    double opacity,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationOpacity, opacity, modelFilter: modelFilter, includes: includes);

	
List<Location> getByTitle(
    String title,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Location> getByDescription(
    String description,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Location> getByImageUrl(
    String imageUrl,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationImageUrl, imageUrl, modelFilter: modelFilter, includes: includes);

	
List<Location> getByLinkUrl(
    String linkUrl,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationLinkUrl, linkUrl, modelFilter: modelFilter, includes: includes);

	
List<Location> getByCategory(
    String category,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationCategory, category, modelFilter: modelFilter, includes: includes);

	
List<Location> getByTags(
    String tags,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationTags, tags, modelFilter: modelFilter, includes: includes);

	
List<Location> getByMondayOpen(
    String mondayOpen,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationMondayOpen, mondayOpen, modelFilter: modelFilter, includes: includes);

	
List<Location> getByMondayClose(
    String mondayClose,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationMondayClose, mondayClose, modelFilter: modelFilter, includes: includes);

	
List<Location> getByTuesdayOpen(
    String tuesdayOpen,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationTuesdayOpen, tuesdayOpen, modelFilter: modelFilter, includes: includes);

	
List<Location> getByTuesdayClose(
    String tuesdayClose,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationTuesdayClose, tuesdayClose, modelFilter: modelFilter, includes: includes);

	
List<Location> getByWednesdayOpen(
    String wednesdayOpen,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationWednesdayOpen, wednesdayOpen, modelFilter: modelFilter, includes: includes);

	
List<Location> getByWednesdayClose(
    String wednesdayClose,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationWednesdayClose, wednesdayClose, modelFilter: modelFilter, includes: includes);

	
List<Location> getByThursdayOpen(
    String thursdayOpen,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationThursdayOpen, thursdayOpen, modelFilter: modelFilter, includes: includes);

	
List<Location> getByThursdayClose(
    String thursdayClose,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationThursdayClose, thursdayClose, modelFilter: modelFilter, includes: includes);

	
List<Location> getByFridayOpen(
    String fridayOpen,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationFridayOpen, fridayOpen, modelFilter: modelFilter, includes: includes);

	
List<Location> getByFridayClose(
    String fridayClose,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationFridayClose, fridayClose, modelFilter: modelFilter, includes: includes);

	
List<Location> getBySaturdayOpen(
    String saturdayOpen,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationSaturdayOpen, saturdayOpen, modelFilter: modelFilter, includes: includes);

	
List<Location> getBySaturdayClose(
    String saturdayClose,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationSaturdayClose, saturdayClose, modelFilter: modelFilter, includes: includes);

	
List<Location> getBySundayOpen(
    String sundayOpen,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationSundayOpen, sundayOpen, modelFilter: modelFilter, includes: includes);

	
List<Location> getBySundayClose(
    String sundayClose,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationSundayClose, sundayClose, modelFilter: modelFilter, includes: includes);

	
List<Location> getByMetadata(
    dynamic metadata,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationMetadata, metadata, modelFilter: modelFilter, includes: includes);

	
List<Location> getByCreatedBy(
    String createdBy,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Location> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Location> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Location> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}
    ) =>
    getManyIncluding(getLocationDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Location location, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (location.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(location.orgId!, includes: includes);
        location.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  Deal? getDeal(
    Location location, {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    final deal = DealStore.instance.getByLocationId(location.$uid!, modelFilter: modelFilter, includes: includes);
    location.deal = deal;
    // setIncludedReferences(deal, includes: includes);
    return deal;
}

	Listing? getListing(
    Location location, {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    final listing = ListingStore.instance.getByLocationId(location.$uid!, modelFilter: modelFilter, includes: includes);
    location.listing = listing;
    // setIncludedReferences(listing, includes: includes);
    return listing;
}

	Property? getProperty(
    Location location, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final property = PropertyStore.instance.getByLocationId(location.$uid!, modelFilter: modelFilter, includes: includes);
    location.property = property;
    // setIncludedReferences(property, includes: includes);
    return property;
}

	List<Route> getEndRoutes(
    Location location, {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}) {
    final endRoutes = RouteStore.instance.getByEndLocationId(location.$uid!, modelFilter: modelFilter, includes: includes);
    location.endRoutes = endRoutes;
    // setIncludedReferencesForList(endRoutes, includes: includes);
    return endRoutes;
}

	List<Route> getStartRoutes(
    Location location, {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}) {
    final startRoutes = RouteStore.instance.getByStartLocationId(location.$uid!, modelFilter: modelFilter, includes: includes);
    location.startRoutes = startRoutes;
    // setIncludedReferencesForList(startRoutes, includes: includes);
    return startRoutes;
}

	List<Agency> getAgencies(
    Location location, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(location.$uid!, modelFilter: modelFilter, includes: includes);
    location.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Agent> getAgents(
    Location location, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agents = AgentStore.instance.getByLocationId(location.$uid!, modelFilter: modelFilter, includes: includes);
    location.agents = agents;
    // setIncludedReferencesForList(agents, includes: includes);
    return agents;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Location>> getAll$({bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: LocationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Location?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLocationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Location>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByDealId$(
        String dealId,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationDealId,
        value: dealId,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByDealId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByAddressLine1$(
        String addressLine1,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationAddressLine1,
        value: addressLine1,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByAddressLine1,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByAddressLine2$(
        String addressLine2,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationAddressLine2,
        value: addressLine2,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByAddressLine2,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByAddressLine3$(
        String addressLine3,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationAddressLine3,
        value: addressLine3,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByAddressLine3,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByCity$(
        String city,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationCity,
        value: city,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByCity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByState$(
        String state,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationState,
        value: state,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByState,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByZip$(
        String zip,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationZip,
        value: zip,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByZip,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByZipPlus4$(
        String zipPlus4,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationZipPlus4,
        value: zipPlus4,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByZipPlus4,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByCountry$(
        String country,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationCountry,
        value: country,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByCountry,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByStateName$(
        String stateName,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationStateName,
        value: stateName,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByStateName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByStateFIPS$(
        String stateFIPS,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationStateFIPS,
        value: stateFIPS,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByStateFIPS,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByCensusTract$(
        String censusTract,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationCensusTract,
        value: censusTract,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByCensusTract,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByBlockGroup$(
        String blockGroup,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationBlockGroup,
        value: blockGroup,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByBlockGroup,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByPrecinct$(
        String precinct,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationPrecinct,
        value: precinct,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByPrecinct,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getBySchoolDistrict$(
        String schoolDistrict,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationSchoolDistrict,
        value: schoolDistrict,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyBySchoolDistrict,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByCongressionalDistrict$(
        String congressionalDistrict,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationCongressionalDistrict,
        value: congressionalDistrict,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByCongressionalDistrict,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByLatitude$(
        double latitude,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLocationLatitude,
        value: latitude,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByLatitude,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByLongitude$(
        double longitude,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLocationLongitude,
        value: longitude,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByLongitude,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByAccuracy$(
        LocationAccuracy accuracy,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<LocationAccuracy>(
        getPropVal: getLocationAccuracy,
        value: accuracy,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByAccuracy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByAltitude$(
        double altitude,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLocationAltitude,
        value: altitude,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByAltitude,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByElevation$(
        double elevation,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLocationElevation,
        value: elevation,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByElevation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByGeocodingStatus$(
        GeocodingStatus geocodingStatus,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<GeocodingStatus>(
        getPropVal: getLocationGeocodingStatus,
        value: geocodingStatus,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByGeocodingStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByGeocodedAt$(
        DateTime geocodedAt,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLocationGeocodedAt,
        value: geocodedAt,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByGeocodedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByGeocodingProvider$(
        MapProvider geocodingProvider,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<MapProvider>(
        getPropVal: getLocationGeocodingProvider,
        value: geocodingProvider,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByGeocodingProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByConfidenceScore$(
        double confidenceScore,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLocationConfidenceScore,
        value: confidenceScore,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByConfidenceScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByIsVerified$(
        bool isVerified,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLocationIsVerified,
        value: isVerified,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByIsVerified,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByVerifiedAt$(
        DateTime verifiedAt,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLocationVerifiedAt,
        value: verifiedAt,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByVerifiedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByVerifiedBy$(
        String verifiedBy,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationVerifiedBy,
        value: verifiedBy,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByVerifiedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByUspsVerified$(
        bool uspsVerified,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLocationUspsVerified,
        value: uspsVerified,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByUspsVerified,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByUspsVerifiedAt$(
        DateTime uspsVerifiedAt,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLocationUspsVerifiedAt,
        value: uspsVerifiedAt,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByUspsVerifiedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByDpvConfirmation$(
        String dpvConfirmation,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationDpvConfirmation,
        value: dpvConfirmation,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByDpvConfirmation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByFootnotes$(
        String footnotes,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationFootnotes,
        value: footnotes,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByFootnotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByIsStandardized$(
        bool isStandardized,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLocationIsStandardized,
        value: isStandardized,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByIsStandardized,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByIsResidential$(
        bool isResidential,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLocationIsResidential,
        value: isResidential,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByIsResidential,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByIsCommercial$(
        bool isCommercial,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLocationIsCommercial,
        value: isCommercial,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByIsCommercial,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByIsValid$(
        bool isValid,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLocationIsValid,
        value: isValid,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByIsValid,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByMarkerType$(
        MarkerType markerType,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<MarkerType>(
        getPropVal: getLocationMarkerType,
        value: markerType,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByMarkerType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByMarkerIcon$(
        MarkerIcon markerIcon,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<MarkerIcon>(
        getPropVal: getLocationMarkerIcon,
        value: markerIcon,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByMarkerIcon,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByMarkerColor$(
        String markerColor,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationMarkerColor,
        value: markerColor,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByMarkerColor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByMarkerSize$(
        int markerSize,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLocationMarkerSize,
        value: markerSize,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByMarkerSize,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByIsVisible$(
        bool isVisible,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLocationIsVisible,
        value: isVisible,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByIsVisible,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByZIndex$(
        int zIndex,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLocationZIndex,
        value: zIndex,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByZIndex,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByOpacity$(
        double opacity,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLocationOpacity,
        value: opacity,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByOpacity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByImageUrl$(
        String imageUrl,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationImageUrl,
        value: imageUrl,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByImageUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByLinkUrl$(
        String linkUrl,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationLinkUrl,
        value: linkUrl,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByLinkUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByCategory$(
        String category,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByTags$(
        String tags,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationTags,
        value: tags,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByTags,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByMondayOpen$(
        String mondayOpen,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationMondayOpen,
        value: mondayOpen,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByMondayOpen,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByMondayClose$(
        String mondayClose,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationMondayClose,
        value: mondayClose,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByMondayClose,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByTuesdayOpen$(
        String tuesdayOpen,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationTuesdayOpen,
        value: tuesdayOpen,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByTuesdayOpen,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByTuesdayClose$(
        String tuesdayClose,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationTuesdayClose,
        value: tuesdayClose,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByTuesdayClose,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByWednesdayOpen$(
        String wednesdayOpen,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationWednesdayOpen,
        value: wednesdayOpen,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByWednesdayOpen,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByWednesdayClose$(
        String wednesdayClose,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationWednesdayClose,
        value: wednesdayClose,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByWednesdayClose,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByThursdayOpen$(
        String thursdayOpen,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationThursdayOpen,
        value: thursdayOpen,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByThursdayOpen,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByThursdayClose$(
        String thursdayClose,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationThursdayClose,
        value: thursdayClose,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByThursdayClose,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByFridayOpen$(
        String fridayOpen,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationFridayOpen,
        value: fridayOpen,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByFridayOpen,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByFridayClose$(
        String fridayClose,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationFridayClose,
        value: fridayClose,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByFridayClose,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getBySaturdayOpen$(
        String saturdayOpen,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationSaturdayOpen,
        value: saturdayOpen,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyBySaturdayOpen,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getBySaturdayClose$(
        String saturdayClose,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationSaturdayClose,
        value: saturdayClose,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyBySaturdayClose,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getBySundayOpen$(
        String sundayOpen,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationSundayOpen,
        value: sundayOpen,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyBySundayOpen,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getBySundayClose$(
        String sundayClose,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationSundayClose,
        value: sundayClose,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyBySundayClose,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByMetadata$(
        dynamic metadata,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getLocationMetadata,
        value: metadata,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLocationCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLocationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLocationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Location>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Location>? modelFilter,
        List<LocationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLocationDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: LocationEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Location location, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (location.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            location.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            location.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<Deal?> getDeal$(
    Location location, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    return DealStore.instance.getByLocationId$(
        location.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((deal) {
        location.deal = deal;
    });

}

	Stream<Listing?> getListing$(
    Location location, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    return ListingStore.instance.getByLocationId$(
        location.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((listing) {
        location.listing = listing;
    });

}

	Stream<Property?> getProperty$(
    Location location, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getByLocationId$(
        location.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((property) {
        location.property = property;
    });

}

	Stream<List<Route>> getEndRoutes$(
    Location location, {bool useCache = true, ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}) {
    return RouteStore.instance.getByEndLocationId$(
        location.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((endRoutes) {
        location.endRoutes = endRoutes;
    });

}

	Stream<List<Route>> getStartRoutes$(
    Location location, {bool useCache = true, ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}) {
    return RouteStore.instance.getByStartLocationId$(
        location.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((startRoutes) {
        location.startRoutes = startRoutes;
    });

}

	Stream<List<Agency>> getAgencies$(
    Location location, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        location.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        location.agencies = agencies;
    });

}

	Stream<List<Agent>> getAgents$(
    Location location, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getByLocationId$(
        location.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agents) {
        location.agents = agents;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Location recursiveUpsert(Location location, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Location'} 
        : const {};
    if (location.deal != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        location.deal = DealStore.instance.recursiveUpsert(location.deal!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (location.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        location.listing = ListingStore.instance.recursiveUpsert(location.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (location.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        location.org = OrganizationStore.instance.recursiveUpsert(location.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (location.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        location.property = PropertyStore.instance.recursiveUpsert(location.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (location.endRoutes != null && (!preventCircularSerialization || !upsertedTypes.contains('Route'))) {
        location.endRoutes = RouteStore.instance.recursiveListUpsert(location.endRoutes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (location.startRoutes != null && (!preventCircularSerialization || !upsertedTypes.contains('Route'))) {
        location.startRoutes = RouteStore.instance.recursiveListUpsert(location.startRoutes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (location.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        location.agencies = AgencyStore.instance.recursiveListUpsert(location.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (location.agents != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        location.agents = AgentStore.instance.recursiveListUpsert(location.agents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(location);
}

  List<Location> recursiveListUpsert(List<Location> locations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedLocations = <Location>[];
    for (var location in locations) {
        updatedLocations.add(recursiveUpsert(location, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedLocations;
}

//   @override
//   Location upsert(Location item) {
//     return recursiveUpsert(item);
//   }

}


class LocationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      LocationInclude.deal({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (location) => LocationStore.instance
            .getDeal$(location, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (location) => LocationStore.instance
            .getDeal(location, modelFilter: modelFilter, includes: includes);
      }
}

	LocationInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (location) => LocationStore.instance
            .getListing$(location, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (location) => LocationStore.instance
            .getListing(location, modelFilter: modelFilter, includes: includes);
      }
}

	LocationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (location) => LocationStore.instance
            .getOrg$(location, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (location) => LocationStore.instance
            .getOrg(location, modelFilter: modelFilter, includes: includes);
      }
}

	LocationInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (location) => LocationStore.instance
            .getProperty$(location, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (location) => LocationStore.instance
            .getProperty(location, modelFilter: modelFilter, includes: includes);
      }
}

	LocationInclude.endRoutes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Route>? modelFilter,
    List<RouteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (location) => LocationStore.instance
            .getEndRoutes$(location, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (location) => LocationStore.instance
            .getEndRoutes(location, modelFilter: modelFilter, includes: includes);
      }
}

	LocationInclude.startRoutes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Route>? modelFilter,
    List<RouteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (location) => LocationStore.instance
            .getStartRoutes$(location, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (location) => LocationStore.instance
            .getStartRoutes(location, modelFilter: modelFilter, includes: includes);
      }
}

	LocationInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (location) => LocationStore.instance
            .getAgencies$(location, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (location) => LocationStore.instance
            .getAgencies(location, modelFilter: modelFilter, includes: includes);
      }
}

	LocationInclude.agents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (location) => LocationStore.instance
            .getAgents$(location, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (location) => LocationStore.instance
            .getAgents(location, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum LocationEndpoints implements Endpoint {

    getAll('/location', HttpMethod.post, List<Location>),
	getById('/location/byId/:id', HttpMethod.post, Location),
	getManyByOrgId('/location/byOrgId/:orgId', HttpMethod.post, List<Location>),
	getManyByPropertyId('/location/byPropertyId/:propertyId', HttpMethod.post, List<Location>),
	getManyByListingId('/location/byListingId/:listingId', HttpMethod.post, List<Location>),
	getManyByDealId('/location/byDealId/:dealId', HttpMethod.post, List<Location>),
	getManyByAddressLine1('/location/byAddressLine1/:addressLine1', HttpMethod.post, List<Location>),
	getManyByAddressLine2('/location/byAddressLine2/:addressLine2', HttpMethod.post, List<Location>),
	getManyByAddressLine3('/location/byAddressLine3/:addressLine3', HttpMethod.post, List<Location>),
	getManyByCity('/location/byCity/:city', HttpMethod.post, List<Location>),
	getManyByState('/location/byState/:state', HttpMethod.post, List<Location>),
	getManyByZip('/location/byZip/:zip', HttpMethod.post, List<Location>),
	getManyByZipPlus4('/location/byZipPlus4/:zipPlus4', HttpMethod.post, List<Location>),
	getManyByCountry('/location/byCountry/:country', HttpMethod.post, List<Location>),
	getManyByStateName('/location/byStateName/:stateName', HttpMethod.post, List<Location>),
	getManyByStateFIPS('/location/byStateFIPS/:stateFIPS', HttpMethod.post, List<Location>),
	getManyByCensusTract('/location/byCensusTract/:censusTract', HttpMethod.post, List<Location>),
	getManyByBlockGroup('/location/byBlockGroup/:blockGroup', HttpMethod.post, List<Location>),
	getManyByPrecinct('/location/byPrecinct/:precinct', HttpMethod.post, List<Location>),
	getManyBySchoolDistrict('/location/bySchoolDistrict/:schoolDistrict', HttpMethod.post, List<Location>),
	getManyByCongressionalDistrict('/location/byCongressionalDistrict/:congressionalDistrict', HttpMethod.post, List<Location>),
	getManyByLatitude('/location/byLatitude/:latitude', HttpMethod.post, List<Location>),
	getManyByLongitude('/location/byLongitude/:longitude', HttpMethod.post, List<Location>),
	getManyByAccuracy('/location/byAccuracy/:accuracy', HttpMethod.post, List<Location>),
	getManyByAltitude('/location/byAltitude/:altitude', HttpMethod.post, List<Location>),
	getManyByElevation('/location/byElevation/:elevation', HttpMethod.post, List<Location>),
	getManyByGeocodingStatus('/location/byGeocodingStatus/:geocodingStatus', HttpMethod.post, List<Location>),
	getManyByGeocodedAt('/location/byGeocodedAt/:geocodedAt', HttpMethod.post, List<Location>),
	getManyByGeocodingProvider('/location/byGeocodingProvider/:geocodingProvider', HttpMethod.post, List<Location>),
	getManyByConfidenceScore('/location/byConfidenceScore/:confidenceScore', HttpMethod.post, List<Location>),
	getManyByIsVerified('/location/byIsVerified/:isVerified', HttpMethod.post, List<Location>),
	getManyByVerifiedAt('/location/byVerifiedAt/:verifiedAt', HttpMethod.post, List<Location>),
	getManyByVerifiedBy('/location/byVerifiedBy/:verifiedBy', HttpMethod.post, List<Location>),
	getManyByUspsVerified('/location/byUspsVerified/:uspsVerified', HttpMethod.post, List<Location>),
	getManyByUspsVerifiedAt('/location/byUspsVerifiedAt/:uspsVerifiedAt', HttpMethod.post, List<Location>),
	getManyByDpvConfirmation('/location/byDpvConfirmation/:dpvConfirmation', HttpMethod.post, List<Location>),
	getManyByFootnotes('/location/byFootnotes/:footnotes', HttpMethod.post, List<Location>),
	getManyByIsStandardized('/location/byIsStandardized/:isStandardized', HttpMethod.post, List<Location>),
	getManyByIsResidential('/location/byIsResidential/:isResidential', HttpMethod.post, List<Location>),
	getManyByIsCommercial('/location/byIsCommercial/:isCommercial', HttpMethod.post, List<Location>),
	getManyByIsValid('/location/byIsValid/:isValid', HttpMethod.post, List<Location>),
	getManyByMarkerType('/location/byMarkerType/:markerType', HttpMethod.post, List<Location>),
	getManyByMarkerIcon('/location/byMarkerIcon/:markerIcon', HttpMethod.post, List<Location>),
	getManyByMarkerColor('/location/byMarkerColor/:markerColor', HttpMethod.post, List<Location>),
	getManyByMarkerSize('/location/byMarkerSize/:markerSize', HttpMethod.post, List<Location>),
	getManyByIsVisible('/location/byIsVisible/:isVisible', HttpMethod.post, List<Location>),
	getManyByZIndex('/location/byZIndex/:zIndex', HttpMethod.post, List<Location>),
	getManyByOpacity('/location/byOpacity/:opacity', HttpMethod.post, List<Location>),
	getManyByTitle('/location/byTitle/:title', HttpMethod.post, List<Location>),
	getManyByDescription('/location/byDescription/:description', HttpMethod.post, List<Location>),
	getManyByImageUrl('/location/byImageUrl/:imageUrl', HttpMethod.post, List<Location>),
	getManyByLinkUrl('/location/byLinkUrl/:linkUrl', HttpMethod.post, List<Location>),
	getManyByCategory('/location/byCategory/:category', HttpMethod.post, List<Location>),
	getManyByTags('/location/byTags/:tags', HttpMethod.post, List<Location>),
	getManyByMondayOpen('/location/byMondayOpen/:mondayOpen', HttpMethod.post, List<Location>),
	getManyByMondayClose('/location/byMondayClose/:mondayClose', HttpMethod.post, List<Location>),
	getManyByTuesdayOpen('/location/byTuesdayOpen/:tuesdayOpen', HttpMethod.post, List<Location>),
	getManyByTuesdayClose('/location/byTuesdayClose/:tuesdayClose', HttpMethod.post, List<Location>),
	getManyByWednesdayOpen('/location/byWednesdayOpen/:wednesdayOpen', HttpMethod.post, List<Location>),
	getManyByWednesdayClose('/location/byWednesdayClose/:wednesdayClose', HttpMethod.post, List<Location>),
	getManyByThursdayOpen('/location/byThursdayOpen/:thursdayOpen', HttpMethod.post, List<Location>),
	getManyByThursdayClose('/location/byThursdayClose/:thursdayClose', HttpMethod.post, List<Location>),
	getManyByFridayOpen('/location/byFridayOpen/:fridayOpen', HttpMethod.post, List<Location>),
	getManyByFridayClose('/location/byFridayClose/:fridayClose', HttpMethod.post, List<Location>),
	getManyBySaturdayOpen('/location/bySaturdayOpen/:saturdayOpen', HttpMethod.post, List<Location>),
	getManyBySaturdayClose('/location/bySaturdayClose/:saturdayClose', HttpMethod.post, List<Location>),
	getManyBySundayOpen('/location/bySundayOpen/:sundayOpen', HttpMethod.post, List<Location>),
	getManyBySundayClose('/location/bySundayClose/:sundayClose', HttpMethod.post, List<Location>),
	getManyByMetadata('/location/byMetadata/:metadata', HttpMethod.post, List<Location>),
	getManyByCreatedBy('/location/byCreatedBy/:createdBy', HttpMethod.post, List<Location>),
	getManyByCreatedAt('/location/byCreatedAt/:createdAt', HttpMethod.post, List<Location>),
	getManyByUpdatedAt('/location/byUpdatedAt/:updatedAt', HttpMethod.post, List<Location>),
	getManyByDeletedAt('/location/byDeletedAt/:deletedAt', HttpMethod.post, List<Location>);

    const LocationEndpoints(this.path, this.method, this.responseType);

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
