
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyStore extends ModelStreamStore<String, Property> {

  static PropertyStore? _instance;

  static PropertyStore get instance {
    _instance ??= PropertyStore();
    return _instance!;
  }

  PropertyStore() : super(Property.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyId(Property property) => property.id;

	String? getPropertyOrgId(Property property) => property.orgId;

	PropertyType? getPropertyType(Property property) => property.type;

	String? getPropertyName(Property property) => property.name;

	Region? getPropertyRegion(Property property) => property.region;

	String? getPropertyCurrency(Property property) => property.currency;

	String? getPropertyAddressLine1(Property property) => property.addressLine1;

	String? getPropertyAddressLine2(Property property) => property.addressLine2;

	String? getPropertyCity(Property property) => property.city;

	String? getPropertyState(Property property) => property.state;

	String? getPropertyZip(Property property) => property.zip;

	String? getPropertyCountry(Property property) => property.country;

	double? getPropertyLat(Property property) => property.lat;

	double? getPropertyLng(Property property) => property.lng;

	String? getPropertyNeighborhoodId(Property property) => property.neighborhoodId;

	int? getPropertyBedrooms(Property property) => property.bedrooms;

	double? getPropertyBathrooms(Property property) => property.bathrooms;

	double? getPropertyAreaSqm(Property property) => property.areaSqm;

	int? getPropertyYearBuilt(Property property) => property.yearBuilt;

	String? getPropertyNotes(Property property) => property.notes;

	String? getPropertyLocationId(Property property) => property.locationId;

	State? getPropertyStateCode(Property property) => property.stateCode;

	PropertyCategory? getPropertyPropertyCategory(Property property) => property.propertyCategory;

	ListingType? getPropertyListingType(Property property) => property.listingType;

	ListingStatus? getPropertyListingStatus(Property property) => property.listingStatus;

	double? getPropertyListingPrice(Property property) => property.listingPrice;

	double? getPropertyOriginalPrice(Property property) => property.originalPrice;

	dynamic? getPropertyPriceHistory(Property property) => property.priceHistory;

	String? getPropertySchoolDistrict(Property property) => property.schoolDistrict;

	double? getPropertyHoaFee(Property property) => property.hoaFee;

	String? getPropertyHoaFeeFrequency(Property property) => property.hoaFeeFrequency;

	double? getPropertyPropertyTaxRate(Property property) => property.propertyTaxRate;

	double? getPropertyLastAssessmentValue(Property property) => property.lastAssessmentValue;

	int? getPropertyLastAssessmentYear(Property property) => property.lastAssessmentYear;

	String? getPropertyFloodZone(Property property) => property.floodZone;

	String? getPropertyZoningCode(Property property) => property.zoningCode;

	double? getPropertyLotSizeAcres(Property property) => property.lotSizeAcres;

	double? getPropertyFrontageFeet(Property property) => property.frontageFeet;

	double? getPropertyDepthFeet(Property property) => property.depthFeet;

	String? getPropertyBasementType(Property property) => property.basementType;

	double? getPropertyBasementFinishedSqFt(Property property) => property.basementFinishedSqFt;

	String? getPropertyGarageType(Property property) => property.garageType;

	int? getPropertyGarageCapacity(Property property) => property.garageCapacity;

	int? getPropertyParkingSpaces(Property property) => property.parkingSpaces;

	String? getPropertyParkingType(Property property) => property.parkingType;

	String? getPropertyPoolType(Property property) => property.poolType;

	String? getPropertyHeatingType(Property property) => property.heatingType;

	String? getPropertyCoolingType(Property property) => property.coolingType;

	String? getPropertyFireplaceType(Property property) => property.fireplaceType;

	int? getPropertyFireplaceCount(Property property) => property.fireplaceCount;

	String? getPropertyViewType(Property property) => property.viewType;

	String? getPropertyWaterfrontType(Property property) => property.waterfrontType;

	double? getPropertyWaterfrontFeet(Property property) => property.waterfrontFeet;

	String? getPropertyConstructionType(Property property) => property.constructionType;

	String? getPropertyRoofType(Property property) => property.roofType;

	int? getPropertyRoofYear(Property property) => property.roofYear;

	String? getPropertySidingType(Property property) => property.sidingType;

	String? getPropertyZipPlus4(Property property) => property.zipPlus4;

	String? getPropertyCountyFIPS(Property property) => property.countyFIPS;

	String? getPropertyCensusTract(Property property) => property.censusTract;

	String? getPropertyMlsArea(Property property) => property.mlsArea;

	String? getPropertyPropertyClass(Property property) => property.propertyClass;

	String? getPropertyBuildingClass(Property property) => property.buildingClass;

	int? getPropertyTotalRooms(Property property) => property.totalRooms;

	double? getPropertyLivingAreaSqFt(Property property) => property.livingAreaSqFt;

	double? getPropertyLotSizeSqFt(Property property) => property.lotSizeSqFt;

	int? getPropertyStories(Property property) => property.stories;

	int? getPropertyUnitsPerBuilding(Property property) => property.unitsPerBuilding;

	double? getPropertyAssessedValue(Property property) => property.assessedValue;

	double? getPropertyMarketValue(Property property) => property.marketValue;

	double? getPropertyPropertyTax(Property property) => property.propertyTax;

	double? getPropertyInsuranceAmount(Property property) => property.insuranceAmount;

	double? getPropertyMortgageBalance(Property property) => property.mortgageBalance;

	double? getPropertyLienAmount(Property property) => property.lienAmount;

	String? getPropertyElectricityProvider(Property property) => property.electricityProvider;

	String? getPropertyGasProvider(Property property) => property.gasProvider;

	String? getPropertyWaterProvider(Property property) => property.waterProvider;

	String? getPropertyInternetProvider(Property property) => property.internetProvider;

	String? getPropertyTrashService(Property property) => property.trashService;

	String? getPropertyMlsNumber(Property property) => property.mlsNumber;

	String? getPropertyMlsStatus(Property property) => property.mlsStatus;

	int? getPropertyDaysOnMarket(Property property) => property.daysOnMarket;

	double? getPropertyPricePerSqFt(Property property) => property.pricePerSqFt;

	double? getPropertyRentalYield(Property property) => property.rentalYield;

	int? getPropertyYearRenovated(Property property) => property.yearRenovated;

	String? getPropertyEnergyRating(Property property) => property.energyRating;

	List<String>? getPropertyAccessibilityFeatures(Property property) => property.accessibilityFeatures;

	List<String>? getPropertySmartHomeFeatures(Property property) => property.smartHomeFeatures;

	List<String>? getPropertySecurityFeatures(Property property) => property.securityFeatures;

	List<String>? getPropertyOutdoorFeatures(Property property) => property.outdoorFeatures;

	String? getPropertyZoningDescription(Property property) => property.zoningDescription;

	String? getPropertyLandUse(Property property) => property.landUse;

	String? getPropertyBuildingRestrictions(Property property) => property.buildingRestrictions;

	String? getPropertyFutureDevelopment(Property property) => property.futureDevelopment;

	bool? getPropertyLeadPaintCompliance(Property property) => property.leadPaintCompliance;

	DateTime? getPropertyMoldInspectionDate(Property property) => property.moldInspectionDate;

	DateTime? getPropertyAsbestosInspectionDate(Property property) => property.asbestosInspectionDate;

	DateTime? getPropertyRadonTestDate(Property property) => property.radonTestDate;

	DateTime? getPropertyPestControlDate(Property property) => property.pestControlDate;

	DateTime? getPropertyFireInspectionDate(Property property) => property.fireInspectionDate;

	DateTime? getPropertyElevatorInspectionDate(Property property) => property.elevatorInspectionDate;

	DateTime? getPropertyPoolInspectionDate(Property property) => property.poolInspectionDate;

	DateTime? getPropertyLastCodeComplianceDate(Property property) => property.lastCodeComplianceDate;

	bool? getPropertyAccessibilityCompliance(Property property) => property.accessibilityCompliance;

	List<String>? getPropertyEnvironmentalHazards(Property property) => property.environmentalHazards;

	String? getPropertyCreatedBy(Property property) => property.createdBy;

	DateTime? getPropertyCreatedAt(Property property) => property.createdAt;

	DateTime? getPropertyUpdatedAt(Property property) => property.updatedAt;

	DateTime? getPropertyDeletedAt(Property property) => property.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Property? getByLocationId(
    String locationId,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getIncluding(getPropertyLocationId, locationId, modelFilter: modelFilter, includes: includes);

  
List<Property> getByOrgId(
    String orgId,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Property> getByType(
    PropertyType type,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyType, type, modelFilter: modelFilter, includes: includes);

	
List<Property> getByName(
    String name,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyName, name, modelFilter: modelFilter, includes: includes);

	
List<Property> getByRegion(
    Region region,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyRegion, region, modelFilter: modelFilter, includes: includes);

	
List<Property> getByCurrency(
    String currency,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Property> getByAddressLine1(
    String addressLine1,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAddressLine1, addressLine1, modelFilter: modelFilter, includes: includes);

	
List<Property> getByAddressLine2(
    String addressLine2,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAddressLine2, addressLine2, modelFilter: modelFilter, includes: includes);

	
List<Property> getByCity(
    String city,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCity, city, modelFilter: modelFilter, includes: includes);

	
List<Property> getByState(
    String state,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyState, state, modelFilter: modelFilter, includes: includes);

	
List<Property> getByZip(
    String zip,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyZip, zip, modelFilter: modelFilter, includes: includes);

	
List<Property> getByCountry(
    String country,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCountry, country, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLat(
    double lat,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLat, lat, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLng(
    double lng,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLng, lng, modelFilter: modelFilter, includes: includes);

	
List<Property> getByNeighborhoodId(
    String neighborhoodId,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyNeighborhoodId, neighborhoodId, modelFilter: modelFilter, includes: includes);

	
List<Property> getByBedrooms(
    int bedrooms,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyBedrooms, bedrooms, modelFilter: modelFilter, includes: includes);

	
List<Property> getByBathrooms(
    double bathrooms,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyBathrooms, bathrooms, modelFilter: modelFilter, includes: includes);

	
List<Property> getByAreaSqm(
    double areaSqm,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAreaSqm, areaSqm, modelFilter: modelFilter, includes: includes);

	
List<Property> getByYearBuilt(
    int yearBuilt,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyYearBuilt, yearBuilt, modelFilter: modelFilter, includes: includes);

	
List<Property> getByNotes(
    String notes,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Property> getByStateCode(
    State stateCode,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyStateCode, stateCode, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPropertyCategory(
    PropertyCategory propertyCategory,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPropertyCategory, propertyCategory, modelFilter: modelFilter, includes: includes);

	
List<Property> getByListingType(
    ListingType listingType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyListingType, listingType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByListingStatus(
    ListingStatus listingStatus,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyListingStatus, listingStatus, modelFilter: modelFilter, includes: includes);

	
List<Property> getByListingPrice(
    double listingPrice,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyListingPrice, listingPrice, modelFilter: modelFilter, includes: includes);

	
List<Property> getByOriginalPrice(
    double originalPrice,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOriginalPrice, originalPrice, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPriceHistory(
    dynamic priceHistory,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPriceHistory, priceHistory, modelFilter: modelFilter, includes: includes);

	
List<Property> getBySchoolDistrict(
    String schoolDistrict,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertySchoolDistrict, schoolDistrict, modelFilter: modelFilter, includes: includes);

	
List<Property> getByHoaFee(
    double hoaFee,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyHoaFee, hoaFee, modelFilter: modelFilter, includes: includes);

	
List<Property> getByHoaFeeFrequency(
    String hoaFeeFrequency,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyHoaFeeFrequency, hoaFeeFrequency, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPropertyTaxRate(
    double propertyTaxRate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPropertyTaxRate, propertyTaxRate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLastAssessmentValue(
    double lastAssessmentValue,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLastAssessmentValue, lastAssessmentValue, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLastAssessmentYear(
    int lastAssessmentYear,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLastAssessmentYear, lastAssessmentYear, modelFilter: modelFilter, includes: includes);

	
List<Property> getByFloodZone(
    String floodZone,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyFloodZone, floodZone, modelFilter: modelFilter, includes: includes);

	
List<Property> getByZoningCode(
    String zoningCode,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyZoningCode, zoningCode, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLotSizeAcres(
    double lotSizeAcres,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLotSizeAcres, lotSizeAcres, modelFilter: modelFilter, includes: includes);

	
List<Property> getByFrontageFeet(
    double frontageFeet,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyFrontageFeet, frontageFeet, modelFilter: modelFilter, includes: includes);

	
List<Property> getByDepthFeet(
    double depthFeet,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDepthFeet, depthFeet, modelFilter: modelFilter, includes: includes);

	
List<Property> getByBasementType(
    String basementType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyBasementType, basementType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByBasementFinishedSqFt(
    double basementFinishedSqFt,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyBasementFinishedSqFt, basementFinishedSqFt, modelFilter: modelFilter, includes: includes);

	
List<Property> getByGarageType(
    String garageType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyGarageType, garageType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByGarageCapacity(
    int garageCapacity,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyGarageCapacity, garageCapacity, modelFilter: modelFilter, includes: includes);

	
List<Property> getByParkingSpaces(
    int parkingSpaces,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyParkingSpaces, parkingSpaces, modelFilter: modelFilter, includes: includes);

	
List<Property> getByParkingType(
    String parkingType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyParkingType, parkingType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPoolType(
    String poolType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPoolType, poolType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByHeatingType(
    String heatingType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyHeatingType, heatingType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByCoolingType(
    String coolingType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCoolingType, coolingType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByFireplaceType(
    String fireplaceType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyFireplaceType, fireplaceType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByFireplaceCount(
    int fireplaceCount,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyFireplaceCount, fireplaceCount, modelFilter: modelFilter, includes: includes);

	
List<Property> getByViewType(
    String viewType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewType, viewType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByWaterfrontType(
    String waterfrontType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyWaterfrontType, waterfrontType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByWaterfrontFeet(
    double waterfrontFeet,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyWaterfrontFeet, waterfrontFeet, modelFilter: modelFilter, includes: includes);

	
List<Property> getByConstructionType(
    String constructionType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyConstructionType, constructionType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByRoofType(
    String roofType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyRoofType, roofType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByRoofYear(
    int roofYear,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyRoofYear, roofYear, modelFilter: modelFilter, includes: includes);

	
List<Property> getBySidingType(
    String sidingType,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertySidingType, sidingType, modelFilter: modelFilter, includes: includes);

	
List<Property> getByZipPlus4(
    String zipPlus4,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyZipPlus4, zipPlus4, modelFilter: modelFilter, includes: includes);

	
List<Property> getByCountyFIPS(
    String countyFIPS,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCountyFIPS, countyFIPS, modelFilter: modelFilter, includes: includes);

	
List<Property> getByCensusTract(
    String censusTract,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCensusTract, censusTract, modelFilter: modelFilter, includes: includes);

	
List<Property> getByMlsArea(
    String mlsArea,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyMlsArea, mlsArea, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPropertyClass(
    String propertyClass,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPropertyClass, propertyClass, modelFilter: modelFilter, includes: includes);

	
List<Property> getByBuildingClass(
    String buildingClass,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyBuildingClass, buildingClass, modelFilter: modelFilter, includes: includes);

	
List<Property> getByTotalRooms(
    int totalRooms,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyTotalRooms, totalRooms, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLivingAreaSqFt(
    double livingAreaSqFt,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLivingAreaSqFt, livingAreaSqFt, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLotSizeSqFt(
    double lotSizeSqFt,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLotSizeSqFt, lotSizeSqFt, modelFilter: modelFilter, includes: includes);

	
List<Property> getByStories(
    int stories,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyStories, stories, modelFilter: modelFilter, includes: includes);

	
List<Property> getByUnitsPerBuilding(
    int unitsPerBuilding,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyUnitsPerBuilding, unitsPerBuilding, modelFilter: modelFilter, includes: includes);

	
List<Property> getByAssessedValue(
    double assessedValue,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAssessedValue, assessedValue, modelFilter: modelFilter, includes: includes);

	
List<Property> getByMarketValue(
    double marketValue,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyMarketValue, marketValue, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPropertyTax(
    double propertyTax,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPropertyTax, propertyTax, modelFilter: modelFilter, includes: includes);

	
List<Property> getByInsuranceAmount(
    double insuranceAmount,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInsuranceAmount, insuranceAmount, modelFilter: modelFilter, includes: includes);

	
List<Property> getByMortgageBalance(
    double mortgageBalance,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyMortgageBalance, mortgageBalance, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLienAmount(
    double lienAmount,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLienAmount, lienAmount, modelFilter: modelFilter, includes: includes);

	
List<Property> getByElectricityProvider(
    String electricityProvider,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyElectricityProvider, electricityProvider, modelFilter: modelFilter, includes: includes);

	
List<Property> getByGasProvider(
    String gasProvider,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyGasProvider, gasProvider, modelFilter: modelFilter, includes: includes);

	
List<Property> getByWaterProvider(
    String waterProvider,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyWaterProvider, waterProvider, modelFilter: modelFilter, includes: includes);

	
List<Property> getByInternetProvider(
    String internetProvider,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyInternetProvider, internetProvider, modelFilter: modelFilter, includes: includes);

	
List<Property> getByTrashService(
    String trashService,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyTrashService, trashService, modelFilter: modelFilter, includes: includes);

	
List<Property> getByMlsNumber(
    String mlsNumber,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyMlsNumber, mlsNumber, modelFilter: modelFilter, includes: includes);

	
List<Property> getByMlsStatus(
    String mlsStatus,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyMlsStatus, mlsStatus, modelFilter: modelFilter, includes: includes);

	
List<Property> getByDaysOnMarket(
    int daysOnMarket,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDaysOnMarket, daysOnMarket, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPricePerSqFt(
    double pricePerSqFt,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPricePerSqFt, pricePerSqFt, modelFilter: modelFilter, includes: includes);

	
List<Property> getByRentalYield(
    double rentalYield,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyRentalYield, rentalYield, modelFilter: modelFilter, includes: includes);

	
List<Property> getByYearRenovated(
    int yearRenovated,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyYearRenovated, yearRenovated, modelFilter: modelFilter, includes: includes);

	
List<Property> getByEnergyRating(
    String energyRating,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyEnergyRating, energyRating, modelFilter: modelFilter, includes: includes);

	
List<Property> getByAccessibilityFeatures(
    String accessibilityFeatures,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAccessibilityFeatures, accessibilityFeatures, modelFilter: modelFilter, includes: includes);

	
List<Property> getBySmartHomeFeatures(
    String smartHomeFeatures,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertySmartHomeFeatures, smartHomeFeatures, modelFilter: modelFilter, includes: includes);

	
List<Property> getBySecurityFeatures(
    String securityFeatures,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertySecurityFeatures, securityFeatures, modelFilter: modelFilter, includes: includes);

	
List<Property> getByOutdoorFeatures(
    String outdoorFeatures,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyOutdoorFeatures, outdoorFeatures, modelFilter: modelFilter, includes: includes);

	
List<Property> getByZoningDescription(
    String zoningDescription,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyZoningDescription, zoningDescription, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLandUse(
    String landUse,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLandUse, landUse, modelFilter: modelFilter, includes: includes);

	
List<Property> getByBuildingRestrictions(
    String buildingRestrictions,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyBuildingRestrictions, buildingRestrictions, modelFilter: modelFilter, includes: includes);

	
List<Property> getByFutureDevelopment(
    String futureDevelopment,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyFutureDevelopment, futureDevelopment, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLeadPaintCompliance(
    bool leadPaintCompliance,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLeadPaintCompliance, leadPaintCompliance, modelFilter: modelFilter, includes: includes);

	
List<Property> getByMoldInspectionDate(
    DateTime moldInspectionDate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyMoldInspectionDate, moldInspectionDate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByAsbestosInspectionDate(
    DateTime asbestosInspectionDate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAsbestosInspectionDate, asbestosInspectionDate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByRadonTestDate(
    DateTime radonTestDate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyRadonTestDate, radonTestDate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPestControlDate(
    DateTime pestControlDate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPestControlDate, pestControlDate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByFireInspectionDate(
    DateTime fireInspectionDate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyFireInspectionDate, fireInspectionDate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByElevatorInspectionDate(
    DateTime elevatorInspectionDate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyElevatorInspectionDate, elevatorInspectionDate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByPoolInspectionDate(
    DateTime poolInspectionDate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPoolInspectionDate, poolInspectionDate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByLastCodeComplianceDate(
    DateTime lastCodeComplianceDate,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyLastCodeComplianceDate, lastCodeComplianceDate, modelFilter: modelFilter, includes: includes);

	
List<Property> getByAccessibilityCompliance(
    bool accessibilityCompliance,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAccessibilityCompliance, accessibilityCompliance, modelFilter: modelFilter, includes: includes);

	
List<Property> getByEnvironmentalHazards(
    String environmentalHazards,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyEnvironmentalHazards, environmentalHazards, modelFilter: modelFilter, includes: includes);

	
List<Property> getByCreatedBy(
    String createdBy,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Property> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Property> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Property> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Location? getLocation(
    Property property, {ModelFilter? modelFilter, List<LocationInclude>? includes}) {
    if (property.locationId == null) {
        return null;
    } else {
        final location = LocationStore.instance.getById(property.locationId!, includes: includes);
        property.location = location;
        // setIncludedReferences(location, includes: includes);
        return location;
    }
}

	Neighborhood? getNeighborhood(
    Property property, {ModelFilter? modelFilter, List<NeighborhoodInclude>? includes}) {
    if (property.neighborhoodId == null) {
        return null;
    } else {
        final neighborhood = NeighborhoodStore.instance.getById(property.neighborhoodId!, includes: includes);
        property.neighborhood = neighborhood;
        // setIncludedReferences(neighborhood, includes: includes);
        return neighborhood;
    }
}

	Organization? getOrg(
    Property property, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (property.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(property.orgId!, includes: includes);
        property.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<AIImageAnalysis> getAiImageAnalyses(
    Property property, {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}) {
    final aiImageAnalyses = AIImageAnalysisStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.aiImageAnalyses = aiImageAnalyses;
    // setIncludedReferencesForList(aiImageAnalyses, includes: includes);
    return aiImageAnalyses;
}

	List<AIInvestmentAnalysis> getAiInvestments(
    Property property, {ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}) {
    final aiInvestments = AIInvestmentAnalysisStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.aiInvestments = aiInvestments;
    // setIncludedReferencesForList(aiInvestments, includes: includes);
    return aiInvestments;
}

	List<AIPredictiveMaintenance> getAiMaintenance(
    Property property, {ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}) {
    final aiMaintenance = AIPredictiveMaintenanceStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.aiMaintenance = aiMaintenance;
    // setIncludedReferencesForList(aiMaintenance, includes: includes);
    return aiMaintenance;
}

	List<AIPropertyDescription> getAiDescriptions(
    Property property, {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}) {
    final aiDescriptions = AIPropertyDescriptionStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.aiDescriptions = aiDescriptions;
    // setIncludedReferencesForList(aiDescriptions, includes: includes);
    return aiDescriptions;
}

	List<AIPropertyValuation> getAiValuations(
    Property property, {ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}) {
    final aiValuations = AIPropertyValuationStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.aiValuations = aiValuations;
    // setIncludedReferencesForList(aiValuations, includes: includes);
    return aiValuations;
}

	List<Appointment> getAppointments(
    Property property, {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    final appointments = AppointmentStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.appointments = appointments;
    // setIncludedReferencesForList(appointments, includes: includes);
    return appointments;
}

	List<Attachment> getAttachments(
    Property property, {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    final attachments = AttachmentStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.attachments = attachments;
    // setIncludedReferencesForList(attachments, includes: includes);
    return attachments;
}

	List<Contract> getContracts(
    Property property, {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    final contracts = ContractStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.contracts = contracts;
    // setIncludedReferencesForList(contracts, includes: includes);
    return contracts;
}

	List<Deal> getDeals(
    Property property, {ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    final deals = DealStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.deals = deals;
    // setIncludedReferencesForList(deals, includes: includes);
    return deals;
}

	List<Document> getGeneralDocuments(
    Property property, {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    final generalDocuments = DocumentStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.generalDocuments = generalDocuments;
    // setIncludedReferencesForList(generalDocuments, includes: includes);
    return generalDocuments;
}

	List<Event> getEvents(
    Property property, {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}) {
    final events = EventStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.events = events;
    // setIncludedReferencesForList(events, includes: includes);
    return events;
}

	List<Facility> getFacilities(
    Property property, {ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    final facilities = FacilityStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.facilities = facilities;
    // setIncludedReferencesForList(facilities, includes: includes);
    return facilities;
}

	List<FinancialRecord> getFinancialRecords(
    Property property, {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    final financialRecords = FinancialRecordStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.financialRecords = financialRecords;
    // setIncludedReferencesForList(financialRecords, includes: includes);
    return financialRecords;
}

	List<FloorPlan> getFloorPlans(
    Property property, {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}) {
    final floorPlans = FloorPlanStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.floorPlans = floorPlans;
    // setIncludedReferencesForList(floorPlans, includes: includes);
    return floorPlans;
}

	List<GuestReview> getGuestReviews(
    Property property, {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}) {
    final guestReviews = GuestReviewStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.guestReviews = guestReviews;
    // setIncludedReferencesForList(guestReviews, includes: includes);
    return guestReviews;
}

	HomeInformationPack? getHomeInformationPack(
    Property property, {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}) {
    final homeInformationPack = HomeInformationPackStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.homeInformationPack = homeInformationPack;
    // setIncludedReferences(homeInformationPack, includes: includes);
    return homeInformationPack;
}

	List<InvestorProperty> getInvestorProperties(
    Property property, {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}) {
    final investorProperties = InvestorPropertyStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.investorProperties = investorProperties;
    // setIncludedReferencesForList(investorProperties, includes: includes);
    return investorProperties;
}

	List<KeyManagement> getKeys(
    Property property, {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}) {
    final keys = KeyManagementStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.keys = keys;
    // setIncludedReferencesForList(keys, includes: includes);
    return keys;
}

	List<Lead> getLeads(
    Property property, {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final leads = LeadStore.instance.getByInterestedPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.leads = leads;
    // setIncludedReferencesForList(leads, includes: includes);
    return leads;
}

	List<LedgerEntry> getLedger(
    Property property, {ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}) {
    final ledger = LedgerEntryStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.ledger = ledger;
    // setIncludedReferencesForList(ledger, includes: includes);
    return ledger;
}

	List<Listing> getListings(
    Property property, {ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    final listings = ListingStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.listings = listings;
    // setIncludedReferencesForList(listings, includes: includes);
    return listings;
}

	List<MaintenanceBlock> getMaintenanceBlocks(
    Property property, {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}) {
    final maintenanceBlocks = MaintenanceBlockStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.maintenanceBlocks = maintenanceBlocks;
    // setIncludedReferencesForList(maintenanceBlocks, includes: includes);
    return maintenanceBlocks;
}

	List<MaintenanceWorkOrder> getWorkOrders(
    Property property, {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    final workOrders = MaintenanceWorkOrderStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.workOrders = workOrders;
    // setIncludedReferencesForList(workOrders, includes: includes);
    return workOrders;
}

	List<MortgageOffer> getMortgageOffers(
    Property property, {ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}) {
    final mortgageOffers = MortgageOfferStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.mortgageOffers = mortgageOffers;
    // setIncludedReferencesForList(mortgageOffers, includes: includes);
    return mortgageOffers;
}

	List<Project> getProjects(
    Property property, {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    final projects = ProjectStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.projects = projects;
    // setIncludedReferencesForList(projects, includes: includes);
    return projects;
}

	List<PropertyAmenity> getAmenities(
    Property property, {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}) {
    final amenities = PropertyAmenityStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.amenities = amenities;
    // setIncludedReferencesForList(amenities, includes: includes);
    return amenities;
}

	List<PropertyCompliance> getCompliance(
    Property property, {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    final compliance = PropertyComplianceStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.compliance = compliance;
    // setIncludedReferencesForList(compliance, includes: includes);
    return compliance;
}

	PropertyDisclosure? getPropertyDisclosure(
    Property property, {ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}) {
    final propertyDisclosure = PropertyDisclosureStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.propertyDisclosure = propertyDisclosure;
    // setIncludedReferences(propertyDisclosure, includes: includes);
    return propertyDisclosure;
}

	List<PropertyDocument> getDocuments(
    Property property, {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}) {
    final documents = PropertyDocumentStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.documents = documents;
    // setIncludedReferencesForList(documents, includes: includes);
    return documents;
}

	List<PropertyInventory> getInventories(
    Property property, {ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}) {
    final inventories = PropertyInventoryStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.inventories = inventories;
    // setIncludedReferencesForList(inventories, includes: includes);
    return inventories;
}

	List<PropertyOffer> getPropertyOffers(
    Property property, {ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    final propertyOffers = PropertyOfferStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.propertyOffers = propertyOffers;
    // setIncludedReferencesForList(propertyOffers, includes: includes);
    return propertyOffers;
}

	List<PropertyValuation> getValuations(
    Property property, {ModelFilter<PropertyValuation>? modelFilter, List<PropertyValuationInclude>? includes}) {
    final valuations = PropertyValuationStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.valuations = valuations;
    // setIncludedReferencesForList(valuations, includes: includes);
    return valuations;
}

	List<PropertyViewing> getViewings(
    Property property, {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    final viewings = PropertyViewingStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.viewings = viewings;
    // setIncludedReferencesForList(viewings, includes: includes);
    return viewings;
}

	List<Quote> getQuotes(
    Property property, {ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    final quotes = QuoteStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.quotes = quotes;
    // setIncludedReferencesForList(quotes, includes: includes);
    return quotes;
}

	List<Task> getTasks(
    Property property, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<TaxDepreciation> getTaxDepreciations(
    Property property, {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}) {
    final taxDepreciations = TaxDepreciationStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.taxDepreciations = taxDepreciations;
    // setIncludedReferencesForList(taxDepreciations, includes: includes);
    return taxDepreciations;
}

	List<TenantApplication> getTenantApplications(
    Property property, {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    final tenantApplications = TenantApplicationStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.tenantApplications = tenantApplications;
    // setIncludedReferencesForList(tenantApplications, includes: includes);
    return tenantApplications;
}

	VacationRental? getVacationRental(
    Property property, {ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}) {
    final vacationRental = VacationRentalStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.vacationRental = vacationRental;
    // setIncludedReferences(vacationRental, includes: includes);
    return vacationRental;
}

	List<VirtualTour> getVirtualTours(
    Property property, {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}) {
    final virtualTours = VirtualTourStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.virtualTours = virtualTours;
    // setIncludedReferencesForList(virtualTours, includes: includes);
    return virtualTours;
}

	List<VideoContent> getVideoContents(
    Property property, {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    final videoContents = VideoContentStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.videoContents = videoContents;
    // setIncludedReferencesForList(videoContents, includes: includes);
    return videoContents;
}

	List<Agent> getAgents(
    Property property, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agents = AgentStore.instance.getBy(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.agents = agents;
    // setIncludedReferencesForList(agents, includes: includes);
    return agents;
}

	List<ExtraCharge> getExtraCharges(
    Property property, {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    final extraCharges = ExtraChargeStore.instance.getBy(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.extraCharges = extraCharges;
    // setIncludedReferencesForList(extraCharges, includes: includes);
    return extraCharges;
}

	List<Currency> getCurrencies(
    Property property, {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    final currencies = CurrencyStore.instance.getBy(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.currencies = currencies;
    // setIncludedReferencesForList(currencies, includes: includes);
    return currencies;
}

	List<Hashtag> getHashtags(
    Property property, {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}) {
    final hashtags = HashtagStore.instance.getBy(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.hashtags = hashtags;
    // setIncludedReferencesForList(hashtags, includes: includes);
    return hashtags;
}

	List<Guest> getGuests(
    Property property, {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}) {
    final guests = GuestStore.instance.getBy(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.guests = guests;
    // setIncludedReferencesForList(guests, includes: includes);
    return guests;
}

	List<Agency> getAgencies(
    Property property, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<IncludedService> getIncludedServices(
    Property property, {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    final includedServices = IncludedServiceStore.instance.getBy(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.includedServices = includedServices;
    // setIncludedReferencesForList(includedServices, includes: includes);
    return includedServices;
}

	List<PricingRule> getPricingRules(
    Property property, {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    final pricingRules = PricingRuleStore.instance.getByListingId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.pricingRules = pricingRules;
    // setIncludedReferencesForList(pricingRules, includes: includes);
    return pricingRules;
}

	List<Discount> getDiscounts(
    Property property, {ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}) {
    final discounts = DiscountStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.discounts = discounts;
    // setIncludedReferencesForList(discounts, includes: includes);
    return discounts;
}

	List<PropertyPhoto> getPropertyPhotos(
    Property property, {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}) {
    final propertyPhotos = PropertyPhotoStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.propertyPhotos = propertyPhotos;
    // setIncludedReferencesForList(propertyPhotos, includes: includes);
    return propertyPhotos;
}

	List<Analytics> getAnalytics(
    Property property, {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    final analytics = AnalyticsStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.analytics = analytics;
    // setIncludedReferencesForList(analytics, includes: includes);
    return analytics;
}

	List<Availability> getAvailabilities(
    Property property, {ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}) {
    final availabilities = AvailabilityStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.availabilities = availabilities;
    // setIncludedReferencesForList(availabilities, includes: includes);
    return availabilities;
}

	List<ComplianceRecord> getComplianceRecords(
    Property property, {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    final complianceRecords = ComplianceRecordStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.complianceRecords = complianceRecords;
    // setIncludedReferencesForList(complianceRecords, includes: includes);
    return complianceRecords;
}

	List<Expense> getExpenses(
    Property property, {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    final expenses = ExpenseStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.expenses = expenses;
    // setIncludedReferencesForList(expenses, includes: includes);
    return expenses;
}

	List<Favorite> getFavorites(
    Property property, {ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}) {
    final favorites = FavoriteStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.favorites = favorites;
    // setIncludedReferencesForList(favorites, includes: includes);
    return favorites;
}

	List<Increase> getIncreases(
    Property property, {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}) {
    final increases = IncreaseStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.increases = increases;
    // setIncludedReferencesForList(increases, includes: includes);
    return increases;
}

	List<Mention> getMentions(
    Property property, {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    final mentions = MentionStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.mentions = mentions;
    // setIncludedReferencesForList(mentions, includes: includes);
    return mentions;
}

	List<Mortgage> getMortgages(
    Property property, {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}) {
    final mortgages = MortgageStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.mortgages = mortgages;
    // setIncludedReferencesForList(mortgages, includes: includes);
    return mortgages;
}

	List<Offer> getOffers(
    Property property, {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    final offers = OfferStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.offers = offers;
    // setIncludedReferencesForList(offers, includes: includes);
    return offers;
}

	List<Payment> getPayments(
    Property property, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final payments = PaymentStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.payments = payments;
    // setIncludedReferencesForList(payments, includes: includes);
    return payments;
}

	List<Photo> getPhotos(
    Property property, {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    final photos = PhotoStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.photos = photos;
    // setIncludedReferencesForList(photos, includes: includes);
    return photos;
}

	List<PropertyPromotion> getPropertyPromotions(
    Property property, {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    final propertyPromotions = PropertyPromotionStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.propertyPromotions = propertyPromotions;
    // setIncludedReferencesForList(propertyPromotions, includes: includes);
    return propertyPromotions;
}

	List<Tenant> getTenants(
    Property property, {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    final tenants = TenantStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.tenants = tenants;
    // setIncludedReferencesForList(tenants, includes: includes);
    return tenants;
}

	List<IncludedService> getIncludedServiceRelations(
    Property property, {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    final includedServiceRelations = IncludedServiceStore.instance.getByPropertyId(property.$uid!, modelFilter: modelFilter, includes: includes);
    property.includedServiceRelations = includedServiceRelations;
    // setIncludedReferencesForList(includedServiceRelations, includes: includes);
    return includedServiceRelations;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Property>> getAll$({bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Property?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Property?> getByLocationId$(
        String locationId,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyLocationId,
        value: locationId,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getByLocationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Property>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByType$(
        PropertyType type,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<PropertyType>(
        getPropVal: getPropertyType,
        value: type,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyName,
        value: name,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByRegion$(
        Region region,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<Region>(
        getPropVal: getPropertyRegion,
        value: region,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByRegion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByAddressLine1$(
        String addressLine1,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyAddressLine1,
        value: addressLine1,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByAddressLine1,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByAddressLine2$(
        String addressLine2,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyAddressLine2,
        value: addressLine2,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByAddressLine2,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByCity$(
        String city,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyCity,
        value: city,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByCity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByState$(
        String state,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyState,
        value: state,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByState,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByZip$(
        String zip,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyZip,
        value: zip,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByZip,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByCountry$(
        String country,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyCountry,
        value: country,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByCountry,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLat$(
        double lat,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyLat,
        value: lat,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLat,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLng$(
        double lng,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyLng,
        value: lng,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLng,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByNeighborhoodId$(
        String neighborhoodId,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyNeighborhoodId,
        value: neighborhoodId,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByNeighborhoodId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByBedrooms$(
        int bedrooms,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyBedrooms,
        value: bedrooms,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByBedrooms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByBathrooms$(
        double bathrooms,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyBathrooms,
        value: bathrooms,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByBathrooms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByAreaSqm$(
        double areaSqm,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyAreaSqm,
        value: areaSqm,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByAreaSqm,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByYearBuilt$(
        int yearBuilt,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyYearBuilt,
        value: yearBuilt,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByYearBuilt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByStateCode$(
        State stateCode,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<State>(
        getPropVal: getPropertyStateCode,
        value: stateCode,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByStateCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPropertyCategory$(
        PropertyCategory propertyCategory,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<PropertyCategory>(
        getPropVal: getPropertyPropertyCategory,
        value: propertyCategory,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPropertyCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByListingType$(
        ListingType listingType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<ListingType>(
        getPropVal: getPropertyListingType,
        value: listingType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByListingType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByListingStatus$(
        ListingStatus listingStatus,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<ListingStatus>(
        getPropVal: getPropertyListingStatus,
        value: listingStatus,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByListingStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByListingPrice$(
        double listingPrice,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyListingPrice,
        value: listingPrice,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByListingPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByOriginalPrice$(
        double originalPrice,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyOriginalPrice,
        value: originalPrice,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByOriginalPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPriceHistory$(
        dynamic priceHistory,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyPriceHistory,
        value: priceHistory,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPriceHistory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getBySchoolDistrict$(
        String schoolDistrict,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertySchoolDistrict,
        value: schoolDistrict,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyBySchoolDistrict,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByHoaFee$(
        double hoaFee,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyHoaFee,
        value: hoaFee,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByHoaFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByHoaFeeFrequency$(
        String hoaFeeFrequency,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyHoaFeeFrequency,
        value: hoaFeeFrequency,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByHoaFeeFrequency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPropertyTaxRate$(
        double propertyTaxRate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyPropertyTaxRate,
        value: propertyTaxRate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPropertyTaxRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLastAssessmentValue$(
        double lastAssessmentValue,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyLastAssessmentValue,
        value: lastAssessmentValue,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLastAssessmentValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLastAssessmentYear$(
        int lastAssessmentYear,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyLastAssessmentYear,
        value: lastAssessmentYear,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLastAssessmentYear,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByFloodZone$(
        String floodZone,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyFloodZone,
        value: floodZone,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByFloodZone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByZoningCode$(
        String zoningCode,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyZoningCode,
        value: zoningCode,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByZoningCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLotSizeAcres$(
        double lotSizeAcres,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyLotSizeAcres,
        value: lotSizeAcres,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLotSizeAcres,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByFrontageFeet$(
        double frontageFeet,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyFrontageFeet,
        value: frontageFeet,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByFrontageFeet,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByDepthFeet$(
        double depthFeet,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyDepthFeet,
        value: depthFeet,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByDepthFeet,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByBasementType$(
        String basementType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyBasementType,
        value: basementType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByBasementType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByBasementFinishedSqFt$(
        double basementFinishedSqFt,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyBasementFinishedSqFt,
        value: basementFinishedSqFt,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByBasementFinishedSqFt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByGarageType$(
        String garageType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyGarageType,
        value: garageType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByGarageType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByGarageCapacity$(
        int garageCapacity,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyGarageCapacity,
        value: garageCapacity,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByGarageCapacity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByParkingSpaces$(
        int parkingSpaces,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyParkingSpaces,
        value: parkingSpaces,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByParkingSpaces,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByParkingType$(
        String parkingType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyParkingType,
        value: parkingType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByParkingType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPoolType$(
        String poolType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPoolType,
        value: poolType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPoolType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByHeatingType$(
        String heatingType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyHeatingType,
        value: heatingType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByHeatingType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByCoolingType$(
        String coolingType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyCoolingType,
        value: coolingType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByCoolingType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByFireplaceType$(
        String fireplaceType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyFireplaceType,
        value: fireplaceType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByFireplaceType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByFireplaceCount$(
        int fireplaceCount,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyFireplaceCount,
        value: fireplaceCount,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByFireplaceCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByViewType$(
        String viewType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewType,
        value: viewType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByViewType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByWaterfrontType$(
        String waterfrontType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyWaterfrontType,
        value: waterfrontType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByWaterfrontType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByWaterfrontFeet$(
        double waterfrontFeet,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyWaterfrontFeet,
        value: waterfrontFeet,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByWaterfrontFeet,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByConstructionType$(
        String constructionType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyConstructionType,
        value: constructionType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByConstructionType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByRoofType$(
        String roofType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyRoofType,
        value: roofType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByRoofType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByRoofYear$(
        int roofYear,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyRoofYear,
        value: roofYear,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByRoofYear,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getBySidingType$(
        String sidingType,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertySidingType,
        value: sidingType,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyBySidingType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByZipPlus4$(
        String zipPlus4,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyZipPlus4,
        value: zipPlus4,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByZipPlus4,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByCountyFIPS$(
        String countyFIPS,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyCountyFIPS,
        value: countyFIPS,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByCountyFIPS,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByCensusTract$(
        String censusTract,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyCensusTract,
        value: censusTract,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByCensusTract,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByMlsArea$(
        String mlsArea,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyMlsArea,
        value: mlsArea,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByMlsArea,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPropertyClass$(
        String propertyClass,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPropertyClass,
        value: propertyClass,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPropertyClass,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByBuildingClass$(
        String buildingClass,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyBuildingClass,
        value: buildingClass,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByBuildingClass,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByTotalRooms$(
        int totalRooms,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyTotalRooms,
        value: totalRooms,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByTotalRooms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLivingAreaSqFt$(
        double livingAreaSqFt,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyLivingAreaSqFt,
        value: livingAreaSqFt,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLivingAreaSqFt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLotSizeSqFt$(
        double lotSizeSqFt,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyLotSizeSqFt,
        value: lotSizeSqFt,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLotSizeSqFt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByStories$(
        int stories,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyStories,
        value: stories,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByStories,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByUnitsPerBuilding$(
        int unitsPerBuilding,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyUnitsPerBuilding,
        value: unitsPerBuilding,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByUnitsPerBuilding,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByAssessedValue$(
        double assessedValue,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyAssessedValue,
        value: assessedValue,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByAssessedValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByMarketValue$(
        double marketValue,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyMarketValue,
        value: marketValue,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByMarketValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPropertyTax$(
        double propertyTax,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyPropertyTax,
        value: propertyTax,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPropertyTax,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByInsuranceAmount$(
        double insuranceAmount,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyInsuranceAmount,
        value: insuranceAmount,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByInsuranceAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByMortgageBalance$(
        double mortgageBalance,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyMortgageBalance,
        value: mortgageBalance,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByMortgageBalance,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLienAmount$(
        double lienAmount,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyLienAmount,
        value: lienAmount,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLienAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByElectricityProvider$(
        String electricityProvider,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyElectricityProvider,
        value: electricityProvider,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByElectricityProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByGasProvider$(
        String gasProvider,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyGasProvider,
        value: gasProvider,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByGasProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByWaterProvider$(
        String waterProvider,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyWaterProvider,
        value: waterProvider,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByWaterProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByInternetProvider$(
        String internetProvider,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyInternetProvider,
        value: internetProvider,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByInternetProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByTrashService$(
        String trashService,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyTrashService,
        value: trashService,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByTrashService,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByMlsNumber$(
        String mlsNumber,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyMlsNumber,
        value: mlsNumber,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByMlsNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByMlsStatus$(
        String mlsStatus,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyMlsStatus,
        value: mlsStatus,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByMlsStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByDaysOnMarket$(
        int daysOnMarket,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyDaysOnMarket,
        value: daysOnMarket,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByDaysOnMarket,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPricePerSqFt$(
        double pricePerSqFt,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyPricePerSqFt,
        value: pricePerSqFt,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPricePerSqFt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByRentalYield$(
        double rentalYield,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyRentalYield,
        value: rentalYield,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByRentalYield,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByYearRenovated$(
        int yearRenovated,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyYearRenovated,
        value: yearRenovated,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByYearRenovated,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByEnergyRating$(
        String energyRating,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyEnergyRating,
        value: energyRating,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByEnergyRating,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByAccessibilityFeatures$(
        String accessibilityFeatures,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyAccessibilityFeatures,
        value: accessibilityFeatures,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByAccessibilityFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getBySmartHomeFeatures$(
        String smartHomeFeatures,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertySmartHomeFeatures,
        value: smartHomeFeatures,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyBySmartHomeFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getBySecurityFeatures$(
        String securityFeatures,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertySecurityFeatures,
        value: securityFeatures,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyBySecurityFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByOutdoorFeatures$(
        String outdoorFeatures,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyOutdoorFeatures,
        value: outdoorFeatures,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByOutdoorFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByZoningDescription$(
        String zoningDescription,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyZoningDescription,
        value: zoningDescription,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByZoningDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLandUse$(
        String landUse,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyLandUse,
        value: landUse,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLandUse,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByBuildingRestrictions$(
        String buildingRestrictions,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyBuildingRestrictions,
        value: buildingRestrictions,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByBuildingRestrictions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByFutureDevelopment$(
        String futureDevelopment,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyFutureDevelopment,
        value: futureDevelopment,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByFutureDevelopment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLeadPaintCompliance$(
        bool leadPaintCompliance,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPropertyLeadPaintCompliance,
        value: leadPaintCompliance,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLeadPaintCompliance,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByMoldInspectionDate$(
        DateTime moldInspectionDate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyMoldInspectionDate,
        value: moldInspectionDate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByMoldInspectionDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByAsbestosInspectionDate$(
        DateTime asbestosInspectionDate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyAsbestosInspectionDate,
        value: asbestosInspectionDate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByAsbestosInspectionDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByRadonTestDate$(
        DateTime radonTestDate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyRadonTestDate,
        value: radonTestDate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByRadonTestDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPestControlDate$(
        DateTime pestControlDate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPestControlDate,
        value: pestControlDate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPestControlDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByFireInspectionDate$(
        DateTime fireInspectionDate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyFireInspectionDate,
        value: fireInspectionDate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByFireInspectionDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByElevatorInspectionDate$(
        DateTime elevatorInspectionDate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyElevatorInspectionDate,
        value: elevatorInspectionDate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByElevatorInspectionDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByPoolInspectionDate$(
        DateTime poolInspectionDate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPoolInspectionDate,
        value: poolInspectionDate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByPoolInspectionDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByLastCodeComplianceDate$(
        DateTime lastCodeComplianceDate,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyLastCodeComplianceDate,
        value: lastCodeComplianceDate,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByLastCodeComplianceDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByAccessibilityCompliance$(
        bool accessibilityCompliance,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPropertyAccessibilityCompliance,
        value: accessibilityCompliance,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByAccessibilityCompliance,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByEnvironmentalHazards$(
        String environmentalHazards,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyEnvironmentalHazards,
        value: environmentalHazards,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByEnvironmentalHazards,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Property>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Property>? modelFilter,
        List<PropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PropertyEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Location?> getLocation$(
    Property property, {bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    if (property.locationId == null) {
        return Stream.value(null);
    } else {
        return LocationStore.instance.getById$(
            property.locationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((location) {
            property.location = location;
        });
    }
}

	Stream<Neighborhood?> getNeighborhood$(
    Property property, {bool useCache = true, ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}) {
    if (property.neighborhoodId == null) {
        return Stream.value(null);
    } else {
        return NeighborhoodStore.instance.getById$(
            property.neighborhoodId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((neighborhood) {
            property.neighborhood = neighborhood;
        });
    }
}

	Stream<Organization?> getOrg$(
    Property property, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (property.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            property.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            property.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AIImageAnalysis>> getAiImageAnalyses$(
    Property property, {bool useCache = true, ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}) {
    return AIImageAnalysisStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiImageAnalyses) {
        property.aiImageAnalyses = aiImageAnalyses;
    });

}

	Stream<List<AIInvestmentAnalysis>> getAiInvestments$(
    Property property, {bool useCache = true, ModelFilter<AIInvestmentAnalysis>? modelFilter, List<AIInvestmentAnalysisInclude>? includes}) {
    return AIInvestmentAnalysisStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiInvestments) {
        property.aiInvestments = aiInvestments;
    });

}

	Stream<List<AIPredictiveMaintenance>> getAiMaintenance$(
    Property property, {bool useCache = true, ModelFilter<AIPredictiveMaintenance>? modelFilter, List<AIPredictiveMaintenanceInclude>? includes}) {
    return AIPredictiveMaintenanceStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiMaintenance) {
        property.aiMaintenance = aiMaintenance;
    });

}

	Stream<List<AIPropertyDescription>> getAiDescriptions$(
    Property property, {bool useCache = true, ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}) {
    return AIPropertyDescriptionStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiDescriptions) {
        property.aiDescriptions = aiDescriptions;
    });

}

	Stream<List<AIPropertyValuation>> getAiValuations$(
    Property property, {bool useCache = true, ModelFilter<AIPropertyValuation>? modelFilter, List<AIPropertyValuationInclude>? includes}) {
    return AIPropertyValuationStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiValuations) {
        property.aiValuations = aiValuations;
    });

}

	Stream<List<Appointment>> getAppointments$(
    Property property, {bool useCache = true, ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    return AppointmentStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((appointments) {
        property.appointments = appointments;
    });

}

	Stream<List<Attachment>> getAttachments$(
    Property property, {bool useCache = true, ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    return AttachmentStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attachments) {
        property.attachments = attachments;
    });

}

	Stream<List<Contract>> getContracts$(
    Property property, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    return ContractStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((contracts) {
        property.contracts = contracts;
    });

}

	Stream<List<Deal>> getDeals$(
    Property property, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    return DealStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((deals) {
        property.deals = deals;
    });

}

	Stream<List<Document>> getGeneralDocuments$(
    Property property, {bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    return DocumentStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((generalDocuments) {
        property.generalDocuments = generalDocuments;
    });

}

	Stream<List<Event>> getEvents$(
    Property property, {bool useCache = true, ModelFilter<Event>? modelFilter, List<EventInclude>? includes}) {
    return EventStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((events) {
        property.events = events;
    });

}

	Stream<List<Facility>> getFacilities$(
    Property property, {bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    return FacilityStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((facilities) {
        property.facilities = facilities;
    });

}

	Stream<List<FinancialRecord>> getFinancialRecords$(
    Property property, {bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    return FinancialRecordStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((financialRecords) {
        property.financialRecords = financialRecords;
    });

}

	Stream<List<FloorPlan>> getFloorPlans$(
    Property property, {bool useCache = true, ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}) {
    return FloorPlanStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((floorPlans) {
        property.floorPlans = floorPlans;
    });

}

	Stream<List<GuestReview>> getGuestReviews$(
    Property property, {bool useCache = true, ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}) {
    return GuestReviewStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((guestReviews) {
        property.guestReviews = guestReviews;
    });

}

	Stream<HomeInformationPack?> getHomeInformationPack$(
    Property property, {bool useCache = true, ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}) {
    return HomeInformationPackStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((homeInformationPack) {
        property.homeInformationPack = homeInformationPack;
    });

}

	Stream<List<InvestorProperty>> getInvestorProperties$(
    Property property, {bool useCache = true, ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}) {
    return InvestorPropertyStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((investorProperties) {
        property.investorProperties = investorProperties;
    });

}

	Stream<List<KeyManagement>> getKeys$(
    Property property, {bool useCache = true, ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}) {
    return KeyManagementStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((keys) {
        property.keys = keys;
    });

}

	Stream<List<Lead>> getLeads$(
    Property property, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    return LeadStore.instance.getByInterestedPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leads) {
        property.leads = leads;
    });

}

	Stream<List<LedgerEntry>> getLedger$(
    Property property, {bool useCache = true, ModelFilter<LedgerEntry>? modelFilter, List<LedgerEntryInclude>? includes}) {
    return LedgerEntryStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((ledger) {
        property.ledger = ledger;
    });

}

	Stream<List<Listing>> getListings$(
    Property property, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    return ListingStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((listings) {
        property.listings = listings;
    });

}

	Stream<List<MaintenanceBlock>> getMaintenanceBlocks$(
    Property property, {bool useCache = true, ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}) {
    return MaintenanceBlockStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((maintenanceBlocks) {
        property.maintenanceBlocks = maintenanceBlocks;
    });

}

	Stream<List<MaintenanceWorkOrder>> getWorkOrders$(
    Property property, {bool useCache = true, ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    return MaintenanceWorkOrderStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((workOrders) {
        property.workOrders = workOrders;
    });

}

	Stream<List<MortgageOffer>> getMortgageOffers$(
    Property property, {bool useCache = true, ModelFilter<MortgageOffer>? modelFilter, List<MortgageOfferInclude>? includes}) {
    return MortgageOfferStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mortgageOffers) {
        property.mortgageOffers = mortgageOffers;
    });

}

	Stream<List<Project>> getProjects$(
    Property property, {bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    return ProjectStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((projects) {
        property.projects = projects;
    });

}

	Stream<List<PropertyAmenity>> getAmenities$(
    Property property, {bool useCache = true, ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}) {
    return PropertyAmenityStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((amenities) {
        property.amenities = amenities;
    });

}

	Stream<List<PropertyCompliance>> getCompliance$(
    Property property, {bool useCache = true, ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    return PropertyComplianceStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((compliance) {
        property.compliance = compliance;
    });

}

	Stream<PropertyDisclosure?> getPropertyDisclosure$(
    Property property, {bool useCache = true, ModelFilter<PropertyDisclosure>? modelFilter, List<PropertyDisclosureInclude>? includes}) {
    return PropertyDisclosureStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyDisclosure) {
        property.propertyDisclosure = propertyDisclosure;
    });

}

	Stream<List<PropertyDocument>> getDocuments$(
    Property property, {bool useCache = true, ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}) {
    return PropertyDocumentStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((documents) {
        property.documents = documents;
    });

}

	Stream<List<PropertyInventory>> getInventories$(
    Property property, {bool useCache = true, ModelFilter<PropertyInventory>? modelFilter, List<PropertyInventoryInclude>? includes}) {
    return PropertyInventoryStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((inventories) {
        property.inventories = inventories;
    });

}

	Stream<List<PropertyOffer>> getPropertyOffers$(
    Property property, {bool useCache = true, ModelFilter<PropertyOffer>? modelFilter, List<PropertyOfferInclude>? includes}) {
    return PropertyOfferStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyOffers) {
        property.propertyOffers = propertyOffers;
    });

}

	Stream<List<PropertyValuation>> getValuations$(
    Property property, {bool useCache = true, ModelFilter<PropertyValuation>? modelFilter, List<PropertyValuationInclude>? includes}) {
    return PropertyValuationStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((valuations) {
        property.valuations = valuations;
    });

}

	Stream<List<PropertyViewing>> getViewings$(
    Property property, {bool useCache = true, ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    return PropertyViewingStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((viewings) {
        property.viewings = viewings;
    });

}

	Stream<List<Quote>> getQuotes$(
    Property property, {bool useCache = true, ModelFilter<Quote>? modelFilter, List<QuoteInclude>? includes}) {
    return QuoteStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((quotes) {
        property.quotes = quotes;
    });

}

	Stream<List<Task>> getTasks$(
    Property property, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        property.tasks = tasks;
    });

}

	Stream<List<TaxDepreciation>> getTaxDepreciations$(
    Property property, {bool useCache = true, ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}) {
    return TaxDepreciationStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((taxDepreciations) {
        property.taxDepreciations = taxDepreciations;
    });

}

	Stream<List<TenantApplication>> getTenantApplications$(
    Property property, {bool useCache = true, ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    return TenantApplicationStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenantApplications) {
        property.tenantApplications = tenantApplications;
    });

}

	Stream<VacationRental?> getVacationRental$(
    Property property, {bool useCache = true, ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}) {
    return VacationRentalStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((vacationRental) {
        property.vacationRental = vacationRental;
    });

}

	Stream<List<VirtualTour>> getVirtualTours$(
    Property property, {bool useCache = true, ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}) {
    return VirtualTourStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((virtualTours) {
        property.virtualTours = virtualTours;
    });

}

	Stream<List<VideoContent>> getVideoContents$(
    Property property, {bool useCache = true, ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    return VideoContentStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((videoContents) {
        property.videoContents = videoContents;
    });

}

	Stream<List<Agent>> getAgents$(
    Property property, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getBy$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agents) {
        property.agents = agents;
    });

}

	Stream<List<ExtraCharge>> getExtraCharges$(
    Property property, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    return ExtraChargeStore.instance.getBy$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((extraCharges) {
        property.extraCharges = extraCharges;
    });

}

	Stream<List<Currency>> getCurrencies$(
    Property property, {bool useCache = true, ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    return CurrencyStore.instance.getBy$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((currencies) {
        property.currencies = currencies;
    });

}

	Stream<List<Hashtag>> getHashtags$(
    Property property, {bool useCache = true, ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}) {
    return HashtagStore.instance.getBy$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((hashtags) {
        property.hashtags = hashtags;
    });

}

	Stream<List<Guest>> getGuests$(
    Property property, {bool useCache = true, ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}) {
    return GuestStore.instance.getBy$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((guests) {
        property.guests = guests;
    });

}

	Stream<List<Agency>> getAgencies$(
    Property property, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        property.agencies = agencies;
    });

}

	Stream<List<IncludedService>> getIncludedServices$(
    Property property, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    return IncludedServiceStore.instance.getBy$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((includedServices) {
        property.includedServices = includedServices;
    });

}

	Stream<List<PricingRule>> getPricingRules$(
    Property property, {bool useCache = true, ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    return PricingRuleStore.instance.getByListingId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((pricingRules) {
        property.pricingRules = pricingRules;
    });

}

	Stream<List<Discount>> getDiscounts$(
    Property property, {bool useCache = true, ModelFilter<Discount>? modelFilter, List<DiscountInclude>? includes}) {
    return DiscountStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((discounts) {
        property.discounts = discounts;
    });

}

	Stream<List<PropertyPhoto>> getPropertyPhotos$(
    Property property, {bool useCache = true, ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}) {
    return PropertyPhotoStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyPhotos) {
        property.propertyPhotos = propertyPhotos;
    });

}

	Stream<List<Analytics>> getAnalytics$(
    Property property, {bool useCache = true, ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    return AnalyticsStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analytics) {
        property.analytics = analytics;
    });

}

	Stream<List<Availability>> getAvailabilities$(
    Property property, {bool useCache = true, ModelFilter<Availability>? modelFilter, List<AvailabilityInclude>? includes}) {
    return AvailabilityStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((availabilities) {
        property.availabilities = availabilities;
    });

}

	Stream<List<ComplianceRecord>> getComplianceRecords$(
    Property property, {bool useCache = true, ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    return ComplianceRecordStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((complianceRecords) {
        property.complianceRecords = complianceRecords;
    });

}

	Stream<List<Expense>> getExpenses$(
    Property property, {bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    return ExpenseStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((expenses) {
        property.expenses = expenses;
    });

}

	Stream<List<Favorite>> getFavorites$(
    Property property, {bool useCache = true, ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}) {
    return FavoriteStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((favorites) {
        property.favorites = favorites;
    });

}

	Stream<List<Increase>> getIncreases$(
    Property property, {bool useCache = true, ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}) {
    return IncreaseStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((increases) {
        property.increases = increases;
    });

}

	Stream<List<Mention>> getMentions$(
    Property property, {bool useCache = true, ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    return MentionStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mentions) {
        property.mentions = mentions;
    });

}

	Stream<List<Mortgage>> getMortgages$(
    Property property, {bool useCache = true, ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}) {
    return MortgageStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mortgages) {
        property.mortgages = mortgages;
    });

}

	Stream<List<Offer>> getOffers$(
    Property property, {bool useCache = true, ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    return OfferStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((offers) {
        property.offers = offers;
    });

}

	Stream<List<Payment>> getPayments$(
    Property property, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((payments) {
        property.payments = payments;
    });

}

	Stream<List<Photo>> getPhotos$(
    Property property, {bool useCache = true, ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    return PhotoStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((photos) {
        property.photos = photos;
    });

}

	Stream<List<PropertyPromotion>> getPropertyPromotions$(
    Property property, {bool useCache = true, ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    return PropertyPromotionStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyPromotions) {
        property.propertyPromotions = propertyPromotions;
    });

}

	Stream<List<Tenant>> getTenants$(
    Property property, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    return TenantStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenants) {
        property.tenants = tenants;
    });

}

	Stream<List<IncludedService>> getIncludedServiceRelations$(
    Property property, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    return IncludedServiceStore.instance.getByPropertyId$(
        property.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((includedServiceRelations) {
        property.includedServiceRelations = includedServiceRelations;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Property recursiveUpsert(Property property, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Property'} 
        : const {};
    if (property.aiImageAnalyses != null && (!preventCircularSerialization || !upsertedTypes.contains('AIImageAnalysis'))) {
        property.aiImageAnalyses = AIImageAnalysisStore.instance.recursiveListUpsert(property.aiImageAnalyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.aiInvestments != null && (!preventCircularSerialization || !upsertedTypes.contains('AIInvestmentAnalysis'))) {
        property.aiInvestments = AIInvestmentAnalysisStore.instance.recursiveListUpsert(property.aiInvestments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.aiMaintenance != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPredictiveMaintenance'))) {
        property.aiMaintenance = AIPredictiveMaintenanceStore.instance.recursiveListUpsert(property.aiMaintenance!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.aiDescriptions != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPropertyDescription'))) {
        property.aiDescriptions = AIPropertyDescriptionStore.instance.recursiveListUpsert(property.aiDescriptions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.aiValuations != null && (!preventCircularSerialization || !upsertedTypes.contains('AIPropertyValuation'))) {
        property.aiValuations = AIPropertyValuationStore.instance.recursiveListUpsert(property.aiValuations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.appointments != null && (!preventCircularSerialization || !upsertedTypes.contains('Appointment'))) {
        property.appointments = AppointmentStore.instance.recursiveListUpsert(property.appointments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.attachments != null && (!preventCircularSerialization || !upsertedTypes.contains('Attachment'))) {
        property.attachments = AttachmentStore.instance.recursiveListUpsert(property.attachments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.contracts != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        property.contracts = ContractStore.instance.recursiveListUpsert(property.contracts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.deals != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        property.deals = DealStore.instance.recursiveListUpsert(property.deals!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.generalDocuments != null && (!preventCircularSerialization || !upsertedTypes.contains('Document'))) {
        property.generalDocuments = DocumentStore.instance.recursiveListUpsert(property.generalDocuments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.events != null && (!preventCircularSerialization || !upsertedTypes.contains('Event'))) {
        property.events = EventStore.instance.recursiveListUpsert(property.events!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.facilities != null && (!preventCircularSerialization || !upsertedTypes.contains('Facility'))) {
        property.facilities = FacilityStore.instance.recursiveListUpsert(property.facilities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.financialRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('FinancialRecord'))) {
        property.financialRecords = FinancialRecordStore.instance.recursiveListUpsert(property.financialRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.floorPlans != null && (!preventCircularSerialization || !upsertedTypes.contains('FloorPlan'))) {
        property.floorPlans = FloorPlanStore.instance.recursiveListUpsert(property.floorPlans!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.guestReviews != null && (!preventCircularSerialization || !upsertedTypes.contains('GuestReview'))) {
        property.guestReviews = GuestReviewStore.instance.recursiveListUpsert(property.guestReviews!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.homeInformationPack != null && (!preventCircularSerialization || !upsertedTypes.contains('HomeInformationPack'))) {
        property.homeInformationPack = HomeInformationPackStore.instance.recursiveUpsert(property.homeInformationPack!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.investorProperties != null && (!preventCircularSerialization || !upsertedTypes.contains('InvestorProperty'))) {
        property.investorProperties = InvestorPropertyStore.instance.recursiveListUpsert(property.investorProperties!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.keys != null && (!preventCircularSerialization || !upsertedTypes.contains('KeyManagement'))) {
        property.keys = KeyManagementStore.instance.recursiveListUpsert(property.keys!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.leads != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        property.leads = LeadStore.instance.recursiveListUpsert(property.leads!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.ledger != null && (!preventCircularSerialization || !upsertedTypes.contains('LedgerEntry'))) {
        property.ledger = LedgerEntryStore.instance.recursiveListUpsert(property.ledger!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.listings != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        property.listings = ListingStore.instance.recursiveListUpsert(property.listings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.maintenanceBlocks != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceBlock'))) {
        property.maintenanceBlocks = MaintenanceBlockStore.instance.recursiveListUpsert(property.maintenanceBlocks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.workOrders != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceWorkOrder'))) {
        property.workOrders = MaintenanceWorkOrderStore.instance.recursiveListUpsert(property.workOrders!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.mortgageOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('MortgageOffer'))) {
        property.mortgageOffers = MortgageOfferStore.instance.recursiveListUpsert(property.mortgageOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.projects != null && (!preventCircularSerialization || !upsertedTypes.contains('Project'))) {
        property.projects = ProjectStore.instance.recursiveListUpsert(property.projects!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.location != null && (!preventCircularSerialization || !upsertedTypes.contains('Location'))) {
        property.location = LocationStore.instance.recursiveUpsert(property.location!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.neighborhood != null && (!preventCircularSerialization || !upsertedTypes.contains('Neighborhood'))) {
        property.neighborhood = NeighborhoodStore.instance.recursiveUpsert(property.neighborhood!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        property.org = OrganizationStore.instance.recursiveUpsert(property.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.amenities != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyAmenity'))) {
        property.amenities = PropertyAmenityStore.instance.recursiveListUpsert(property.amenities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.compliance != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyCompliance'))) {
        property.compliance = PropertyComplianceStore.instance.recursiveListUpsert(property.compliance!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.propertyDisclosure != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyDisclosure'))) {
        property.propertyDisclosure = PropertyDisclosureStore.instance.recursiveUpsert(property.propertyDisclosure!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.documents != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyDocument'))) {
        property.documents = PropertyDocumentStore.instance.recursiveListUpsert(property.documents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.inventories != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyInventory'))) {
        property.inventories = PropertyInventoryStore.instance.recursiveListUpsert(property.inventories!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.propertyOffers != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyOffer'))) {
        property.propertyOffers = PropertyOfferStore.instance.recursiveListUpsert(property.propertyOffers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.valuations != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyValuation'))) {
        property.valuations = PropertyValuationStore.instance.recursiveListUpsert(property.valuations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.viewings != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyViewing'))) {
        property.viewings = PropertyViewingStore.instance.recursiveListUpsert(property.viewings!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.quotes != null && (!preventCircularSerialization || !upsertedTypes.contains('Quote'))) {
        property.quotes = QuoteStore.instance.recursiveListUpsert(property.quotes!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        property.tasks = TaskStore.instance.recursiveListUpsert(property.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.taxDepreciations != null && (!preventCircularSerialization || !upsertedTypes.contains('TaxDepreciation'))) {
        property.taxDepreciations = TaxDepreciationStore.instance.recursiveListUpsert(property.taxDepreciations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.tenantApplications != null && (!preventCircularSerialization || !upsertedTypes.contains('TenantApplication'))) {
        property.tenantApplications = TenantApplicationStore.instance.recursiveListUpsert(property.tenantApplications!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.vacationRental != null && (!preventCircularSerialization || !upsertedTypes.contains('VacationRental'))) {
        property.vacationRental = VacationRentalStore.instance.recursiveUpsert(property.vacationRental!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.virtualTours != null && (!preventCircularSerialization || !upsertedTypes.contains('VirtualTour'))) {
        property.virtualTours = VirtualTourStore.instance.recursiveListUpsert(property.virtualTours!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.videoContents != null && (!preventCircularSerialization || !upsertedTypes.contains('VideoContent'))) {
        property.videoContents = VideoContentStore.instance.recursiveListUpsert(property.videoContents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.agents != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        property.agents = AgentStore.instance.recursiveListUpsert(property.agents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.extraCharges != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        property.extraCharges = ExtraChargeStore.instance.recursiveListUpsert(property.extraCharges!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.currencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Currency'))) {
        property.currencies = CurrencyStore.instance.recursiveListUpsert(property.currencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.hashtags != null && (!preventCircularSerialization || !upsertedTypes.contains('Hashtag'))) {
        property.hashtags = HashtagStore.instance.recursiveListUpsert(property.hashtags!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.guests != null && (!preventCircularSerialization || !upsertedTypes.contains('Guest'))) {
        property.guests = GuestStore.instance.recursiveListUpsert(property.guests!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        property.agencies = AgencyStore.instance.recursiveListUpsert(property.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.includedServices != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        property.includedServices = IncludedServiceStore.instance.recursiveListUpsert(property.includedServices!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.pricingRules != null && (!preventCircularSerialization || !upsertedTypes.contains('PricingRule'))) {
        property.pricingRules = PricingRuleStore.instance.recursiveListUpsert(property.pricingRules!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.discounts != null && (!preventCircularSerialization || !upsertedTypes.contains('Discount'))) {
        property.discounts = DiscountStore.instance.recursiveListUpsert(property.discounts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.propertyPhotos != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyPhoto'))) {
        property.propertyPhotos = PropertyPhotoStore.instance.recursiveListUpsert(property.propertyPhotos!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.analytics != null && (!preventCircularSerialization || !upsertedTypes.contains('Analytics'))) {
        property.analytics = AnalyticsStore.instance.recursiveListUpsert(property.analytics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.availabilities != null && (!preventCircularSerialization || !upsertedTypes.contains('Availability'))) {
        property.availabilities = AvailabilityStore.instance.recursiveListUpsert(property.availabilities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.complianceRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('ComplianceRecord'))) {
        property.complianceRecords = ComplianceRecordStore.instance.recursiveListUpsert(property.complianceRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.expenses != null && (!preventCircularSerialization || !upsertedTypes.contains('Expense'))) {
        property.expenses = ExpenseStore.instance.recursiveListUpsert(property.expenses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.favorites != null && (!preventCircularSerialization || !upsertedTypes.contains('Favorite'))) {
        property.favorites = FavoriteStore.instance.recursiveListUpsert(property.favorites!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.increases != null && (!preventCircularSerialization || !upsertedTypes.contains('Increase'))) {
        property.increases = IncreaseStore.instance.recursiveListUpsert(property.increases!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.mentions != null && (!preventCircularSerialization || !upsertedTypes.contains('Mention'))) {
        property.mentions = MentionStore.instance.recursiveListUpsert(property.mentions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.mortgages != null && (!preventCircularSerialization || !upsertedTypes.contains('Mortgage'))) {
        property.mortgages = MortgageStore.instance.recursiveListUpsert(property.mortgages!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.offers != null && (!preventCircularSerialization || !upsertedTypes.contains('Offer'))) {
        property.offers = OfferStore.instance.recursiveListUpsert(property.offers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.payments != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        property.payments = PaymentStore.instance.recursiveListUpsert(property.payments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.photos != null && (!preventCircularSerialization || !upsertedTypes.contains('Photo'))) {
        property.photos = PhotoStore.instance.recursiveListUpsert(property.photos!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.propertyPromotions != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyPromotion'))) {
        property.propertyPromotions = PropertyPromotionStore.instance.recursiveListUpsert(property.propertyPromotions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.tenants != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        property.tenants = TenantStore.instance.recursiveListUpsert(property.tenants!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (property.includedServiceRelations != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        property.includedServiceRelations = IncludedServiceStore.instance.recursiveListUpsert(property.includedServiceRelations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(property);
}

  List<Property> recursiveListUpsert(List<Property> propertys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertys = <Property>[];
    for (var property in propertys) {
        updatedPropertys.add(recursiveUpsert(property, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertys;
}

//   @override
//   Property upsert(Property item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyInclude.aiImageAnalyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIImageAnalysis>? modelFilter,
    List<AIImageAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAiImageAnalyses$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAiImageAnalyses(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.aiInvestments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIInvestmentAnalysis>? modelFilter,
    List<AIInvestmentAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAiInvestments$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAiInvestments(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.aiMaintenance({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPredictiveMaintenance>? modelFilter,
    List<AIPredictiveMaintenanceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAiMaintenance$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAiMaintenance(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.aiDescriptions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPropertyDescription>? modelFilter,
    List<AIPropertyDescriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAiDescriptions$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAiDescriptions(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.aiValuations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIPropertyValuation>? modelFilter,
    List<AIPropertyValuationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAiValuations$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAiValuations(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.appointments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Appointment>? modelFilter,
    List<AppointmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAppointments$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAppointments(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.attachments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Attachment>? modelFilter,
    List<AttachmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAttachments$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAttachments(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.contracts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getContracts$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getContracts(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.deals({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getDeals$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getDeals(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.generalDocuments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Document>? modelFilter,
    List<DocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getGeneralDocuments$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getGeneralDocuments(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.events({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Event>? modelFilter,
    List<EventInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getEvents$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getEvents(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.facilities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Facility>? modelFilter,
    List<FacilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getFacilities$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getFacilities(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.financialRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FinancialRecord>? modelFilter,
    List<FinancialRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getFinancialRecords$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getFinancialRecords(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.floorPlans({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FloorPlan>? modelFilter,
    List<FloorPlanInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getFloorPlans$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getFloorPlans(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.guestReviews({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<GuestReview>? modelFilter,
    List<GuestReviewInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getGuestReviews$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getGuestReviews(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.homeInformationPack({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<HomeInformationPack>? modelFilter,
    List<HomeInformationPackInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getHomeInformationPack$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getHomeInformationPack(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.investorProperties({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<InvestorProperty>? modelFilter,
    List<InvestorPropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getInvestorProperties$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getInvestorProperties(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.keys({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<KeyManagement>? modelFilter,
    List<KeyManagementInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getKeys$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getKeys(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.leads({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getLeads$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getLeads(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.ledger({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LedgerEntry>? modelFilter,
    List<LedgerEntryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getLedger$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getLedger(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.listings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getListings$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getListings(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.maintenanceBlocks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceBlock>? modelFilter,
    List<MaintenanceBlockInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getMaintenanceBlocks$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getMaintenanceBlocks(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.workOrders({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceWorkOrder>? modelFilter,
    List<MaintenanceWorkOrderInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getWorkOrders$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getWorkOrders(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.mortgageOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MortgageOffer>? modelFilter,
    List<MortgageOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getMortgageOffers$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getMortgageOffers(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.projects({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Project>? modelFilter,
    List<ProjectInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getProjects$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getProjects(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.location({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Location>? modelFilter,
    List<LocationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getLocation$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getLocation(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.neighborhood({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Neighborhood>? modelFilter,
    List<NeighborhoodInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getNeighborhood$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getNeighborhood(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getOrg$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getOrg(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.amenities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyAmenity>? modelFilter,
    List<PropertyAmenityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAmenities$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAmenities(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.compliance({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyCompliance>? modelFilter,
    List<PropertyComplianceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getCompliance$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getCompliance(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.propertyDisclosure({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyDisclosure>? modelFilter,
    List<PropertyDisclosureInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getPropertyDisclosure$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getPropertyDisclosure(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.documents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyDocument>? modelFilter,
    List<PropertyDocumentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getDocuments$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getDocuments(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.inventories({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyInventory>? modelFilter,
    List<PropertyInventoryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getInventories$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getInventories(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.propertyOffers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyOffer>? modelFilter,
    List<PropertyOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getPropertyOffers$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getPropertyOffers(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.valuations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyValuation>? modelFilter,
    List<PropertyValuationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getValuations$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getValuations(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.viewings({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyViewing>? modelFilter,
    List<PropertyViewingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getViewings$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getViewings(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.quotes({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Quote>? modelFilter,
    List<QuoteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getQuotes$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getQuotes(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getTasks$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getTasks(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.taxDepreciations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TaxDepreciation>? modelFilter,
    List<TaxDepreciationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getTaxDepreciations$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getTaxDepreciations(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.tenantApplications({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TenantApplication>? modelFilter,
    List<TenantApplicationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getTenantApplications$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getTenantApplications(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.vacationRental({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VacationRental>? modelFilter,
    List<VacationRentalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getVacationRental$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getVacationRental(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.virtualTours({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VirtualTour>? modelFilter,
    List<VirtualTourInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getVirtualTours$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getVirtualTours(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.videoContents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VideoContent>? modelFilter,
    List<VideoContentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getVideoContents$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getVideoContents(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.agents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAgents$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAgents(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.extraCharges({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getExtraCharges$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getExtraCharges(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.currencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Currency>? modelFilter,
    List<CurrencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getCurrencies$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getCurrencies(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.hashtags({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Hashtag>? modelFilter,
    List<HashtagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getHashtags$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getHashtags(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.guests({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Guest>? modelFilter,
    List<GuestInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getGuests$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getGuests(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAgencies$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAgencies(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.includedServices({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getIncludedServices$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getIncludedServices(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.pricingRules({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PricingRule>? modelFilter,
    List<PricingRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getPricingRules$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getPricingRules(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.discounts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Discount>? modelFilter,
    List<DiscountInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getDiscounts$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getDiscounts(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.propertyPhotos({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyPhoto>? modelFilter,
    List<PropertyPhotoInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getPropertyPhotos$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getPropertyPhotos(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.analytics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Analytics>? modelFilter,
    List<AnalyticsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAnalytics$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAnalytics(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.availabilities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Availability>? modelFilter,
    List<AvailabilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getAvailabilities$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getAvailabilities(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.complianceRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ComplianceRecord>? modelFilter,
    List<ComplianceRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getComplianceRecords$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getComplianceRecords(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.expenses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Expense>? modelFilter,
    List<ExpenseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getExpenses$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getExpenses(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.favorites({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Favorite>? modelFilter,
    List<FavoriteInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getFavorites$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getFavorites(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.increases({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Increase>? modelFilter,
    List<IncreaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getIncreases$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getIncreases(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.mentions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Mention>? modelFilter,
    List<MentionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getMentions$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getMentions(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.mortgages({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Mortgage>? modelFilter,
    List<MortgageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getMortgages$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getMortgages(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.offers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Offer>? modelFilter,
    List<OfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getOffers$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getOffers(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.payments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getPayments$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getPayments(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.photos({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Photo>? modelFilter,
    List<PhotoInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getPhotos$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getPhotos(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.propertyPromotions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyPromotion>? modelFilter,
    List<PropertyPromotionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getPropertyPromotions$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getPropertyPromotions(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.tenants({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getTenants$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getTenants(property, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyInclude.includedServiceRelations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (property) => PropertyStore.instance
            .getIncludedServiceRelations$(property, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (property) => PropertyStore.instance
            .getIncludedServiceRelations(property, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyEndpoints implements Endpoint {

    getAll('/property', HttpMethod.post, List<Property>),
	getById('/property/byId/:id', HttpMethod.post, Property),
	getManyByOrgId('/property/byOrgId/:orgId', HttpMethod.post, List<Property>),
	getManyByType('/property/byType/:type', HttpMethod.post, List<Property>),
	getManyByName('/property/byName/:name', HttpMethod.post, List<Property>),
	getManyByRegion('/property/byRegion/:region', HttpMethod.post, List<Property>),
	getManyByCurrency('/property/byCurrency/:currency', HttpMethod.post, List<Property>),
	getManyByAddressLine1('/property/byAddressLine1/:addressLine1', HttpMethod.post, List<Property>),
	getManyByAddressLine2('/property/byAddressLine2/:addressLine2', HttpMethod.post, List<Property>),
	getManyByCity('/property/byCity/:city', HttpMethod.post, List<Property>),
	getManyByState('/property/byState/:state', HttpMethod.post, List<Property>),
	getManyByZip('/property/byZip/:zip', HttpMethod.post, List<Property>),
	getManyByCountry('/property/byCountry/:country', HttpMethod.post, List<Property>),
	getManyByLat('/property/byLat/:lat', HttpMethod.post, List<Property>),
	getManyByLng('/property/byLng/:lng', HttpMethod.post, List<Property>),
	getManyByNeighborhoodId('/property/byNeighborhoodId/:neighborhoodId', HttpMethod.post, List<Property>),
	getManyByBedrooms('/property/byBedrooms/:bedrooms', HttpMethod.post, List<Property>),
	getManyByBathrooms('/property/byBathrooms/:bathrooms', HttpMethod.post, List<Property>),
	getManyByAreaSqm('/property/byAreaSqm/:areaSqm', HttpMethod.post, List<Property>),
	getManyByYearBuilt('/property/byYearBuilt/:yearBuilt', HttpMethod.post, List<Property>),
	getManyByNotes('/property/byNotes/:notes', HttpMethod.post, List<Property>),
	getByLocationId('/property/byLocationId/:locationId', HttpMethod.post, Property),
	getManyByStateCode('/property/byStateCode/:stateCode', HttpMethod.post, List<Property>),
	getManyByPropertyCategory('/property/byPropertyCategory/:propertyCategory', HttpMethod.post, List<Property>),
	getManyByListingType('/property/byListingType/:listingType', HttpMethod.post, List<Property>),
	getManyByListingStatus('/property/byListingStatus/:listingStatus', HttpMethod.post, List<Property>),
	getManyByListingPrice('/property/byListingPrice/:listingPrice', HttpMethod.post, List<Property>),
	getManyByOriginalPrice('/property/byOriginalPrice/:originalPrice', HttpMethod.post, List<Property>),
	getManyByPriceHistory('/property/byPriceHistory/:priceHistory', HttpMethod.post, List<Property>),
	getManyBySchoolDistrict('/property/bySchoolDistrict/:schoolDistrict', HttpMethod.post, List<Property>),
	getManyByHoaFee('/property/byHoaFee/:hoaFee', HttpMethod.post, List<Property>),
	getManyByHoaFeeFrequency('/property/byHoaFeeFrequency/:hoaFeeFrequency', HttpMethod.post, List<Property>),
	getManyByPropertyTaxRate('/property/byPropertyTaxRate/:propertyTaxRate', HttpMethod.post, List<Property>),
	getManyByLastAssessmentValue('/property/byLastAssessmentValue/:lastAssessmentValue', HttpMethod.post, List<Property>),
	getManyByLastAssessmentYear('/property/byLastAssessmentYear/:lastAssessmentYear', HttpMethod.post, List<Property>),
	getManyByFloodZone('/property/byFloodZone/:floodZone', HttpMethod.post, List<Property>),
	getManyByZoningCode('/property/byZoningCode/:zoningCode', HttpMethod.post, List<Property>),
	getManyByLotSizeAcres('/property/byLotSizeAcres/:lotSizeAcres', HttpMethod.post, List<Property>),
	getManyByFrontageFeet('/property/byFrontageFeet/:frontageFeet', HttpMethod.post, List<Property>),
	getManyByDepthFeet('/property/byDepthFeet/:depthFeet', HttpMethod.post, List<Property>),
	getManyByBasementType('/property/byBasementType/:basementType', HttpMethod.post, List<Property>),
	getManyByBasementFinishedSqFt('/property/byBasementFinishedSqFt/:basementFinishedSqFt', HttpMethod.post, List<Property>),
	getManyByGarageType('/property/byGarageType/:garageType', HttpMethod.post, List<Property>),
	getManyByGarageCapacity('/property/byGarageCapacity/:garageCapacity', HttpMethod.post, List<Property>),
	getManyByParkingSpaces('/property/byParkingSpaces/:parkingSpaces', HttpMethod.post, List<Property>),
	getManyByParkingType('/property/byParkingType/:parkingType', HttpMethod.post, List<Property>),
	getManyByPoolType('/property/byPoolType/:poolType', HttpMethod.post, List<Property>),
	getManyByHeatingType('/property/byHeatingType/:heatingType', HttpMethod.post, List<Property>),
	getManyByCoolingType('/property/byCoolingType/:coolingType', HttpMethod.post, List<Property>),
	getManyByFireplaceType('/property/byFireplaceType/:fireplaceType', HttpMethod.post, List<Property>),
	getManyByFireplaceCount('/property/byFireplaceCount/:fireplaceCount', HttpMethod.post, List<Property>),
	getManyByViewType('/property/byViewType/:viewType', HttpMethod.post, List<Property>),
	getManyByWaterfrontType('/property/byWaterfrontType/:waterfrontType', HttpMethod.post, List<Property>),
	getManyByWaterfrontFeet('/property/byWaterfrontFeet/:waterfrontFeet', HttpMethod.post, List<Property>),
	getManyByConstructionType('/property/byConstructionType/:constructionType', HttpMethod.post, List<Property>),
	getManyByRoofType('/property/byRoofType/:roofType', HttpMethod.post, List<Property>),
	getManyByRoofYear('/property/byRoofYear/:roofYear', HttpMethod.post, List<Property>),
	getManyBySidingType('/property/bySidingType/:sidingType', HttpMethod.post, List<Property>),
	getManyByZipPlus4('/property/byZipPlus4/:zipPlus4', HttpMethod.post, List<Property>),
	getManyByCountyFIPS('/property/byCountyFIPS/:countyFIPS', HttpMethod.post, List<Property>),
	getManyByCensusTract('/property/byCensusTract/:censusTract', HttpMethod.post, List<Property>),
	getManyByMlsArea('/property/byMlsArea/:mlsArea', HttpMethod.post, List<Property>),
	getManyByPropertyClass('/property/byPropertyClass/:propertyClass', HttpMethod.post, List<Property>),
	getManyByBuildingClass('/property/byBuildingClass/:buildingClass', HttpMethod.post, List<Property>),
	getManyByTotalRooms('/property/byTotalRooms/:totalRooms', HttpMethod.post, List<Property>),
	getManyByLivingAreaSqFt('/property/byLivingAreaSqFt/:livingAreaSqFt', HttpMethod.post, List<Property>),
	getManyByLotSizeSqFt('/property/byLotSizeSqFt/:lotSizeSqFt', HttpMethod.post, List<Property>),
	getManyByStories('/property/byStories/:stories', HttpMethod.post, List<Property>),
	getManyByUnitsPerBuilding('/property/byUnitsPerBuilding/:unitsPerBuilding', HttpMethod.post, List<Property>),
	getManyByAssessedValue('/property/byAssessedValue/:assessedValue', HttpMethod.post, List<Property>),
	getManyByMarketValue('/property/byMarketValue/:marketValue', HttpMethod.post, List<Property>),
	getManyByPropertyTax('/property/byPropertyTax/:propertyTax', HttpMethod.post, List<Property>),
	getManyByInsuranceAmount('/property/byInsuranceAmount/:insuranceAmount', HttpMethod.post, List<Property>),
	getManyByMortgageBalance('/property/byMortgageBalance/:mortgageBalance', HttpMethod.post, List<Property>),
	getManyByLienAmount('/property/byLienAmount/:lienAmount', HttpMethod.post, List<Property>),
	getManyByElectricityProvider('/property/byElectricityProvider/:electricityProvider', HttpMethod.post, List<Property>),
	getManyByGasProvider('/property/byGasProvider/:gasProvider', HttpMethod.post, List<Property>),
	getManyByWaterProvider('/property/byWaterProvider/:waterProvider', HttpMethod.post, List<Property>),
	getManyByInternetProvider('/property/byInternetProvider/:internetProvider', HttpMethod.post, List<Property>),
	getManyByTrashService('/property/byTrashService/:trashService', HttpMethod.post, List<Property>),
	getManyByMlsNumber('/property/byMlsNumber/:mlsNumber', HttpMethod.post, List<Property>),
	getManyByMlsStatus('/property/byMlsStatus/:mlsStatus', HttpMethod.post, List<Property>),
	getManyByDaysOnMarket('/property/byDaysOnMarket/:daysOnMarket', HttpMethod.post, List<Property>),
	getManyByPricePerSqFt('/property/byPricePerSqFt/:pricePerSqFt', HttpMethod.post, List<Property>),
	getManyByRentalYield('/property/byRentalYield/:rentalYield', HttpMethod.post, List<Property>),
	getManyByYearRenovated('/property/byYearRenovated/:yearRenovated', HttpMethod.post, List<Property>),
	getManyByEnergyRating('/property/byEnergyRating/:energyRating', HttpMethod.post, List<Property>),
	getManyByAccessibilityFeatures('/property/byAccessibilityFeatures/:accessibilityFeatures', HttpMethod.post, List<Property>),
	getManyBySmartHomeFeatures('/property/bySmartHomeFeatures/:smartHomeFeatures', HttpMethod.post, List<Property>),
	getManyBySecurityFeatures('/property/bySecurityFeatures/:securityFeatures', HttpMethod.post, List<Property>),
	getManyByOutdoorFeatures('/property/byOutdoorFeatures/:outdoorFeatures', HttpMethod.post, List<Property>),
	getManyByZoningDescription('/property/byZoningDescription/:zoningDescription', HttpMethod.post, List<Property>),
	getManyByLandUse('/property/byLandUse/:landUse', HttpMethod.post, List<Property>),
	getManyByBuildingRestrictions('/property/byBuildingRestrictions/:buildingRestrictions', HttpMethod.post, List<Property>),
	getManyByFutureDevelopment('/property/byFutureDevelopment/:futureDevelopment', HttpMethod.post, List<Property>),
	getManyByLeadPaintCompliance('/property/byLeadPaintCompliance/:leadPaintCompliance', HttpMethod.post, List<Property>),
	getManyByMoldInspectionDate('/property/byMoldInspectionDate/:moldInspectionDate', HttpMethod.post, List<Property>),
	getManyByAsbestosInspectionDate('/property/byAsbestosInspectionDate/:asbestosInspectionDate', HttpMethod.post, List<Property>),
	getManyByRadonTestDate('/property/byRadonTestDate/:radonTestDate', HttpMethod.post, List<Property>),
	getManyByPestControlDate('/property/byPestControlDate/:pestControlDate', HttpMethod.post, List<Property>),
	getManyByFireInspectionDate('/property/byFireInspectionDate/:fireInspectionDate', HttpMethod.post, List<Property>),
	getManyByElevatorInspectionDate('/property/byElevatorInspectionDate/:elevatorInspectionDate', HttpMethod.post, List<Property>),
	getManyByPoolInspectionDate('/property/byPoolInspectionDate/:poolInspectionDate', HttpMethod.post, List<Property>),
	getManyByLastCodeComplianceDate('/property/byLastCodeComplianceDate/:lastCodeComplianceDate', HttpMethod.post, List<Property>),
	getManyByAccessibilityCompliance('/property/byAccessibilityCompliance/:accessibilityCompliance', HttpMethod.post, List<Property>),
	getManyByEnvironmentalHazards('/property/byEnvironmentalHazards/:environmentalHazards', HttpMethod.post, List<Property>),
	getManyByCreatedBy('/property/byCreatedBy/:createdBy', HttpMethod.post, List<Property>),
	getManyByCreatedAt('/property/byCreatedAt/:createdAt', HttpMethod.post, List<Property>),
	getManyByUpdatedAt('/property/byUpdatedAt/:updatedAt', HttpMethod.post, List<Property>),
	getManyByDeletedAt('/property/byDeletedAt/:deletedAt', HttpMethod.post, List<Property>);

    const PropertyEndpoints(this.path, this.method, this.responseType);

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
