
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'property_type.dart';
import 'region.dart';
import 'state.dart';
import 'property_category.dart';
import 'listing_type.dart';
import 'listing_status.dart';
import 'ai_image_analysis.dart';
import 'ai_investment_analysis.dart';
import 'ai_predictive_maintenance.dart';
import 'ai_property_description.dart';
import 'ai_property_valuation.dart';
import 'appointment.dart';
import 'attachment.dart';
import 'contract.dart';
import 'deal.dart';
import 'document.dart';
import 'event.dart';
import 'facility.dart';
import 'financial_record.dart';
import 'floor_plan.dart';
import 'guest_review.dart';
import 'home_information_pack.dart';
import 'investor_property.dart';
import 'key_management.dart';
import 'lead.dart';
import 'ledger_entry.dart';
import 'listing.dart';
import 'maintenance_block.dart';
import 'maintenance_work_order.dart';
import 'mortgage_offer.dart';
import 'project.dart';
import 'location.dart';
import 'neighborhood.dart';
import 'organization.dart';
import 'property_amenity.dart';
import 'property_compliance.dart';
import 'property_disclosure.dart';
import 'property_document.dart';
import 'property_inventory.dart';
import 'property_offer.dart';
import 'property_valuation.dart';
import 'property_viewing.dart';
import 'quote.dart';
import 'task.dart';
import 'tax_depreciation.dart';
import 'tenant_application.dart';
import 'vacation_rental.dart';
import 'virtual_tour.dart';
import 'video_content.dart';
import 'agent.dart';
import 'extra_charge.dart';
import 'currency.dart';
import 'hashtag.dart';
import 'guest.dart';
import 'agency.dart';
import 'included_service.dart';
import 'pricing_rule.dart';
import 'discount.dart';
import 'property_photo.dart';
import 'analytics.dart';
import 'availability.dart';
import 'compliance_record.dart';
import 'expense.dart';
import 'favorite.dart';
import 'increase.dart';
import 'mention.dart';
import 'mortgage.dart';
import 'offer.dart';
import 'payment.dart';
import 'photo.dart';
import 'property_promotion.dart';
import 'tenant.dart';


class Property implements PrismaModel<String, Property> , Id<String> {
    @override
String? id;
	String? orgId;
	PropertyType? type;
	String? name;
	Region? region;
	String? currency;
	String? addressLine1;
	String? addressLine2;
	String? city;
	String? state;
	String? zip;
	String? country;
	double? lat;
	double? lng;
	String? neighborhoodId;
	int? bedrooms;
	double? bathrooms;
	double? areaSqm;
	int? yearBuilt;
	String? notes;
	String? locationId;
	State? stateCode;
	PropertyCategory? propertyCategory;
	ListingType? listingType;
	ListingStatus? listingStatus;
	double? listingPrice;
	double? originalPrice;
	dynamic priceHistory;
	String? schoolDistrict;
	double? hoaFee;
	String? hoaFeeFrequency;
	double? propertyTaxRate;
	double? lastAssessmentValue;
	int? lastAssessmentYear;
	String? floodZone;
	String? zoningCode;
	double? lotSizeAcres;
	double? frontageFeet;
	double? depthFeet;
	String? basementType;
	double? basementFinishedSqFt;
	String? garageType;
	int? garageCapacity;
	int? parkingSpaces;
	String? parkingType;
	String? poolType;
	String? heatingType;
	String? coolingType;
	String? fireplaceType;
	int? fireplaceCount;
	String? viewType;
	String? waterfrontType;
	double? waterfrontFeet;
	String? constructionType;
	String? roofType;
	int? roofYear;
	String? sidingType;
	String? zipPlus4;
	String? countyFIPS;
	String? censusTract;
	String? mlsArea;
	String? propertyClass;
	String? buildingClass;
	int? totalRooms;
	double? livingAreaSqFt;
	double? lotSizeSqFt;
	int? stories;
	int? unitsPerBuilding;
	double? assessedValue;
	double? marketValue;
	double? propertyTax;
	double? insuranceAmount;
	double? mortgageBalance;
	double? lienAmount;
	String? electricityProvider;
	String? gasProvider;
	String? waterProvider;
	String? internetProvider;
	String? trashService;
	String? mlsNumber;
	String? mlsStatus;
	int? daysOnMarket;
	double? pricePerSqFt;
	double? rentalYield;
	int? yearRenovated;
	String? energyRating;
	List<String>? accessibilityFeatures;
	List<String>? smartHomeFeatures;
	List<String>? securityFeatures;
	List<String>? outdoorFeatures;
	String? zoningDescription;
	String? landUse;
	String? buildingRestrictions;
	String? futureDevelopment;
	bool? leadPaintCompliance;
	DateTime? moldInspectionDate;
	DateTime? asbestosInspectionDate;
	DateTime? radonTestDate;
	DateTime? pestControlDate;
	DateTime? fireInspectionDate;
	DateTime? elevatorInspectionDate;
	DateTime? poolInspectionDate;
	DateTime? lastCodeComplianceDate;
	bool? accessibilityCompliance;
	List<String>? environmentalHazards;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<AIImageAnalysis>? aiImageAnalyses;
	List<AIInvestmentAnalysis>? aiInvestments;
	List<AIPredictiveMaintenance>? aiMaintenance;
	List<AIPropertyDescription>? aiDescriptions;
	List<AIPropertyValuation>? aiValuations;
	List<Appointment>? appointments;
	List<Attachment>? attachments;
	List<Contract>? contracts;
	List<Deal>? deals;
	List<Document>? generalDocuments;
	List<Event>? events;
	List<Facility>? facilities;
	List<FinancialRecord>? financialRecords;
	List<FloorPlan>? floorPlans;
	List<GuestReview>? guestReviews;
	HomeInformationPack? homeInformationPack;
	List<InvestorProperty>? investorProperties;
	List<KeyManagement>? keys;
	List<Lead>? leads;
	List<LedgerEntry>? ledger;
	List<Listing>? listings;
	List<MaintenanceBlock>? maintenanceBlocks;
	List<MaintenanceWorkOrder>? workOrders;
	List<MortgageOffer>? mortgageOffers;
	List<Project>? projects;
	Location? location;
	Neighborhood? neighborhood;
	Organization? org;
	List<PropertyAmenity>? amenities;
	List<PropertyCompliance>? compliance;
	PropertyDisclosure? propertyDisclosure;
	List<PropertyDocument>? documents;
	List<PropertyInventory>? inventories;
	List<PropertyOffer>? propertyOffers;
	List<PropertyValuation>? valuations;
	List<PropertyViewing>? viewings;
	List<Quote>? quotes;
	List<Task>? tasks;
	List<TaxDepreciation>? taxDepreciations;
	List<TenantApplication>? tenantApplications;
	VacationRental? vacationRental;
	List<VirtualTour>? virtualTours;
	List<VideoContent>? videoContents;
	List<Agent>? agents;
	List<ExtraCharge>? extraCharges;
	List<Currency>? currencies;
	List<Hashtag>? hashtags;
	List<Guest>? guests;
	List<Agency>? agencies;
	List<IncludedService>? includedServices;
	List<PricingRule>? pricingRules;
	List<Discount>? discounts;
	List<PropertyPhoto>? propertyPhotos;
	List<Analytics>? analytics;
	List<Availability>? availabilities;
	List<ComplianceRecord>? complianceRecords;
	List<Expense>? expenses;
	List<Favorite>? favorites;
	List<Increase>? increases;
	List<Mention>? mentions;
	List<Mortgage>? mortgages;
	List<Offer>? offers;
	List<Payment>? payments;
	List<Photo>? photos;
	List<PropertyPromotion>? propertyPromotions;
	List<Tenant>? tenants;
	List<IncludedService>? includedServiceRelations;
	int? $accessibilityFeaturesCount;
	int? $smartHomeFeaturesCount;
	int? $securityFeaturesCount;
	int? $outdoorFeaturesCount;
	int? $environmentalHazardsCount;
	int? $aiImageAnalysesCount;
	int? $aiInvestmentsCount;
	int? $aiMaintenanceCount;
	int? $aiDescriptionsCount;
	int? $aiValuationsCount;
	int? $appointmentsCount;
	int? $attachmentsCount;
	int? $contractsCount;
	int? $dealsCount;
	int? $generalDocumentsCount;
	int? $eventsCount;
	int? $facilitiesCount;
	int? $financialRecordsCount;
	int? $floorPlansCount;
	int? $guestReviewsCount;
	int? $investorPropertiesCount;
	int? $keysCount;
	int? $leadsCount;
	int? $ledgerCount;
	int? $listingsCount;
	int? $maintenanceBlocksCount;
	int? $workOrdersCount;
	int? $mortgageOffersCount;
	int? $projectsCount;
	int? $amenitiesCount;
	int? $complianceCount;
	int? $documentsCount;
	int? $inventoriesCount;
	int? $propertyOffersCount;
	int? $valuationsCount;
	int? $viewingsCount;
	int? $quotesCount;
	int? $tasksCount;
	int? $taxDepreciationsCount;
	int? $tenantApplicationsCount;
	int? $virtualToursCount;
	int? $videoContentsCount;
	int? $agentsCount;
	int? $extraChargesCount;
	int? $currenciesCount;
	int? $hashtagsCount;
	int? $guestsCount;
	int? $agenciesCount;
	int? $includedServicesCount;
	int? $pricingRulesCount;
	int? $discountsCount;
	int? $propertyPhotosCount;
	int? $analyticsCount;
	int? $availabilitiesCount;
	int? $complianceRecordsCount;
	int? $expensesCount;
	int? $favoritesCount;
	int? $increasesCount;
	int? $mentionsCount;
	int? $mortgagesCount;
	int? $offersCount;
	int? $paymentsCount;
	int? $photosCount;
	int? $propertyPromotionsCount;
	int? $tenantsCount;
	int? $includedServiceRelationsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Property({ this.id,
	 this.orgId,
	 this.type = PropertyType.DETACHED_HOUSE,
	 this.name,
	 this.region,
	 this.currency,
	 this.addressLine1,
	 this.addressLine2,
	 this.city,
	 this.state,
	 this.zip,
	 this.country,
	 this.lat,
	 this.lng,
	 this.neighborhoodId,
	 this.bedrooms,
	 this.bathrooms,
	 this.areaSqm,
	 this.yearBuilt,
	 this.notes,
	 this.locationId,
	 this.stateCode,
	 this.propertyCategory = PropertyCategory.RESIDENTIAL,
	 this.listingType = ListingType.SALE,
	 this.listingStatus = ListingStatus.AVAILABLE,
	 this.listingPrice,
	 this.originalPrice,
	required this.priceHistory,
	 this.schoolDistrict,
	 this.hoaFee,
	 this.hoaFeeFrequency,
	 this.propertyTaxRate,
	 this.lastAssessmentValue,
	 this.lastAssessmentYear,
	 this.floodZone,
	 this.zoningCode,
	 this.lotSizeAcres,
	 this.frontageFeet,
	 this.depthFeet,
	 this.basementType,
	 this.basementFinishedSqFt,
	 this.garageType,
	 this.garageCapacity,
	 this.parkingSpaces,
	 this.parkingType,
	 this.poolType,
	 this.heatingType,
	 this.coolingType,
	 this.fireplaceType,
	 this.fireplaceCount,
	 this.viewType,
	 this.waterfrontType,
	 this.waterfrontFeet,
	 this.constructionType,
	 this.roofType,
	 this.roofYear,
	 this.sidingType,
	 this.zipPlus4,
	 this.countyFIPS,
	 this.censusTract,
	 this.mlsArea,
	 this.propertyClass,
	 this.buildingClass,
	 this.totalRooms,
	 this.livingAreaSqFt,
	 this.lotSizeSqFt,
	 this.stories,
	 this.unitsPerBuilding,
	 this.assessedValue,
	 this.marketValue,
	 this.propertyTax,
	 this.insuranceAmount,
	 this.mortgageBalance,
	 this.lienAmount,
	 this.electricityProvider,
	 this.gasProvider,
	 this.waterProvider,
	 this.internetProvider,
	 this.trashService,
	 this.mlsNumber,
	 this.mlsStatus,
	 this.daysOnMarket,
	 this.pricePerSqFt,
	 this.rentalYield,
	 this.yearRenovated,
	 this.energyRating,
	 this.accessibilityFeatures,
	 this.smartHomeFeatures,
	 this.securityFeatures,
	 this.outdoorFeatures,
	 this.zoningDescription,
	 this.landUse,
	 this.buildingRestrictions,
	 this.futureDevelopment,
	 this.leadPaintCompliance = false,
	 this.moldInspectionDate,
	 this.asbestosInspectionDate,
	 this.radonTestDate,
	 this.pestControlDate,
	 this.fireInspectionDate,
	 this.elevatorInspectionDate,
	 this.poolInspectionDate,
	 this.lastCodeComplianceDate,
	 this.accessibilityCompliance = false,
	 this.environmentalHazards,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.aiImageAnalyses,
	 this.aiInvestments,
	 this.aiMaintenance,
	 this.aiDescriptions,
	 this.aiValuations,
	 this.appointments,
	 this.attachments,
	 this.contracts,
	 this.deals,
	 this.generalDocuments,
	 this.events,
	 this.facilities,
	 this.financialRecords,
	 this.floorPlans,
	 this.guestReviews,
	 this.homeInformationPack,
	 this.investorProperties,
	 this.keys,
	 this.leads,
	 this.ledger,
	 this.listings,
	 this.maintenanceBlocks,
	 this.workOrders,
	 this.mortgageOffers,
	 this.projects,
	 this.location,
	 this.neighborhood,
	 this.org,
	 this.amenities,
	 this.compliance,
	 this.propertyDisclosure,
	 this.documents,
	 this.inventories,
	 this.propertyOffers,
	 this.valuations,
	 this.viewings,
	 this.quotes,
	 this.tasks,
	 this.taxDepreciations,
	 this.tenantApplications,
	 this.vacationRental,
	 this.virtualTours,
	 this.videoContents,
	 this.agents,
	 this.extraCharges,
	 this.currencies,
	 this.hashtags,
	 this.guests,
	 this.agencies,
	 this.includedServices,
	 this.pricingRules,
	 this.discounts,
	 this.propertyPhotos,
	 this.analytics,
	 this.availabilities,
	 this.complianceRecords,
	 this.expenses,
	 this.favorites,
	 this.increases,
	 this.mentions,
	 this.mortgages,
	 this.offers,
	 this.payments,
	 this.photos,
	 this.propertyPromotions,
	 this.tenants,
	 this.includedServiceRelations,
	this.$accessibilityFeaturesCount,
	this.$smartHomeFeaturesCount,
	this.$securityFeaturesCount,
	this.$outdoorFeaturesCount,
	this.$environmentalHazardsCount,
	this.$aiImageAnalysesCount,
	this.$aiInvestmentsCount,
	this.$aiMaintenanceCount,
	this.$aiDescriptionsCount,
	this.$aiValuationsCount,
	this.$appointmentsCount,
	this.$attachmentsCount,
	this.$contractsCount,
	this.$dealsCount,
	this.$generalDocumentsCount,
	this.$eventsCount,
	this.$facilitiesCount,
	this.$financialRecordsCount,
	this.$floorPlansCount,
	this.$guestReviewsCount,
	this.$investorPropertiesCount,
	this.$keysCount,
	this.$leadsCount,
	this.$ledgerCount,
	this.$listingsCount,
	this.$maintenanceBlocksCount,
	this.$workOrdersCount,
	this.$mortgageOffersCount,
	this.$projectsCount,
	this.$amenitiesCount,
	this.$complianceCount,
	this.$documentsCount,
	this.$inventoriesCount,
	this.$propertyOffersCount,
	this.$valuationsCount,
	this.$viewingsCount,
	this.$quotesCount,
	this.$tasksCount,
	this.$taxDepreciationsCount,
	this.$tenantApplicationsCount,
	this.$virtualToursCount,
	this.$videoContentsCount,
	this.$agentsCount,
	this.$extraChargesCount,
	this.$currenciesCount,
	this.$hashtagsCount,
	this.$guestsCount,
	this.$agenciesCount,
	this.$includedServicesCount,
	this.$pricingRulesCount,
	this.$discountsCount,
	this.$propertyPhotosCount,
	this.$analyticsCount,
	this.$availabilitiesCount,
	this.$complianceRecordsCount,
	this.$expensesCount,
	this.$favoritesCount,
	this.$increasesCount,
	this.$mentionsCount,
	this.$mortgagesCount,
	this.$offersCount,
	this.$paymentsCount,
	this.$photosCount,
	this.$propertyPromotionsCount,
	this.$tenantsCount,
	this.$includedServiceRelationsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Property, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"type": (m) => m.type,

	"name": (m) => m.name,

	"region": (m) => m.region,

	"currency": (m) => m.currency,

	"addressLine1": (m) => m.addressLine1,

	"addressLine2": (m) => m.addressLine2,

	"city": (m) => m.city,

	"state": (m) => m.state,

	"zip": (m) => m.zip,

	"country": (m) => m.country,

	"lat": (m) => m.lat,

	"lng": (m) => m.lng,

	"neighborhoodId": (m) => m.neighborhoodId,

	"bedrooms": (m) => m.bedrooms,

	"bathrooms": (m) => m.bathrooms,

	"areaSqm": (m) => m.areaSqm,

	"yearBuilt": (m) => m.yearBuilt,

	"notes": (m) => m.notes,

	"locationId": (m) => m.locationId,

	"stateCode": (m) => m.stateCode,

	"propertyCategory": (m) => m.propertyCategory,

	"listingType": (m) => m.listingType,

	"listingStatus": (m) => m.listingStatus,

	"listingPrice": (m) => m.listingPrice,

	"originalPrice": (m) => m.originalPrice,

	"priceHistory": (m) => m.priceHistory,

	"schoolDistrict": (m) => m.schoolDistrict,

	"hoaFee": (m) => m.hoaFee,

	"hoaFeeFrequency": (m) => m.hoaFeeFrequency,

	"propertyTaxRate": (m) => m.propertyTaxRate,

	"lastAssessmentValue": (m) => m.lastAssessmentValue,

	"lastAssessmentYear": (m) => m.lastAssessmentYear,

	"floodZone": (m) => m.floodZone,

	"zoningCode": (m) => m.zoningCode,

	"lotSizeAcres": (m) => m.lotSizeAcres,

	"frontageFeet": (m) => m.frontageFeet,

	"depthFeet": (m) => m.depthFeet,

	"basementType": (m) => m.basementType,

	"basementFinishedSqFt": (m) => m.basementFinishedSqFt,

	"garageType": (m) => m.garageType,

	"garageCapacity": (m) => m.garageCapacity,

	"parkingSpaces": (m) => m.parkingSpaces,

	"parkingType": (m) => m.parkingType,

	"poolType": (m) => m.poolType,

	"heatingType": (m) => m.heatingType,

	"coolingType": (m) => m.coolingType,

	"fireplaceType": (m) => m.fireplaceType,

	"fireplaceCount": (m) => m.fireplaceCount,

	"viewType": (m) => m.viewType,

	"waterfrontType": (m) => m.waterfrontType,

	"waterfrontFeet": (m) => m.waterfrontFeet,

	"constructionType": (m) => m.constructionType,

	"roofType": (m) => m.roofType,

	"roofYear": (m) => m.roofYear,

	"sidingType": (m) => m.sidingType,

	"zipPlus4": (m) => m.zipPlus4,

	"countyFIPS": (m) => m.countyFIPS,

	"censusTract": (m) => m.censusTract,

	"mlsArea": (m) => m.mlsArea,

	"propertyClass": (m) => m.propertyClass,

	"buildingClass": (m) => m.buildingClass,

	"totalRooms": (m) => m.totalRooms,

	"livingAreaSqFt": (m) => m.livingAreaSqFt,

	"lotSizeSqFt": (m) => m.lotSizeSqFt,

	"stories": (m) => m.stories,

	"unitsPerBuilding": (m) => m.unitsPerBuilding,

	"assessedValue": (m) => m.assessedValue,

	"marketValue": (m) => m.marketValue,

	"propertyTax": (m) => m.propertyTax,

	"insuranceAmount": (m) => m.insuranceAmount,

	"mortgageBalance": (m) => m.mortgageBalance,

	"lienAmount": (m) => m.lienAmount,

	"electricityProvider": (m) => m.electricityProvider,

	"gasProvider": (m) => m.gasProvider,

	"waterProvider": (m) => m.waterProvider,

	"internetProvider": (m) => m.internetProvider,

	"trashService": (m) => m.trashService,

	"mlsNumber": (m) => m.mlsNumber,

	"mlsStatus": (m) => m.mlsStatus,

	"daysOnMarket": (m) => m.daysOnMarket,

	"pricePerSqFt": (m) => m.pricePerSqFt,

	"rentalYield": (m) => m.rentalYield,

	"yearRenovated": (m) => m.yearRenovated,

	"energyRating": (m) => m.energyRating,

	"accessibilityFeatures": (m) => m.accessibilityFeatures,

	"smartHomeFeatures": (m) => m.smartHomeFeatures,

	"securityFeatures": (m) => m.securityFeatures,

	"outdoorFeatures": (m) => m.outdoorFeatures,

	"zoningDescription": (m) => m.zoningDescription,

	"landUse": (m) => m.landUse,

	"buildingRestrictions": (m) => m.buildingRestrictions,

	"futureDevelopment": (m) => m.futureDevelopment,

	"leadPaintCompliance": (m) => m.leadPaintCompliance,

	"moldInspectionDate": (m) => m.moldInspectionDate,

	"asbestosInspectionDate": (m) => m.asbestosInspectionDate,

	"radonTestDate": (m) => m.radonTestDate,

	"pestControlDate": (m) => m.pestControlDate,

	"fireInspectionDate": (m) => m.fireInspectionDate,

	"elevatorInspectionDate": (m) => m.elevatorInspectionDate,

	"poolInspectionDate": (m) => m.poolInspectionDate,

	"lastCodeComplianceDate": (m) => m.lastCodeComplianceDate,

	"accessibilityCompliance": (m) => m.accessibilityCompliance,

	"environmentalHazards": (m) => m.environmentalHazards,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"aiImageAnalyses": (m) => m.aiImageAnalyses,

	"aiInvestments": (m) => m.aiInvestments,

	"aiMaintenance": (m) => m.aiMaintenance,

	"aiDescriptions": (m) => m.aiDescriptions,

	"aiValuations": (m) => m.aiValuations,

	"appointments": (m) => m.appointments,

	"attachments": (m) => m.attachments,

	"contracts": (m) => m.contracts,

	"deals": (m) => m.deals,

	"generalDocuments": (m) => m.generalDocuments,

	"events": (m) => m.events,

	"facilities": (m) => m.facilities,

	"financialRecords": (m) => m.financialRecords,

	"floorPlans": (m) => m.floorPlans,

	"guestReviews": (m) => m.guestReviews,

	"homeInformationPack": (m) => m.homeInformationPack,

	"investorProperties": (m) => m.investorProperties,

	"keys": (m) => m.keys,

	"leads": (m) => m.leads,

	"ledger": (m) => m.ledger,

	"listings": (m) => m.listings,

	"maintenanceBlocks": (m) => m.maintenanceBlocks,

	"workOrders": (m) => m.workOrders,

	"mortgageOffers": (m) => m.mortgageOffers,

	"projects": (m) => m.projects,

	"location": (m) => m.location,

	"neighborhood": (m) => m.neighborhood,

	"org": (m) => m.org,

	"amenities": (m) => m.amenities,

	"compliance": (m) => m.compliance,

	"propertyDisclosure": (m) => m.propertyDisclosure,

	"documents": (m) => m.documents,

	"inventories": (m) => m.inventories,

	"propertyOffers": (m) => m.propertyOffers,

	"valuations": (m) => m.valuations,

	"viewings": (m) => m.viewings,

	"quotes": (m) => m.quotes,

	"tasks": (m) => m.tasks,

	"taxDepreciations": (m) => m.taxDepreciations,

	"tenantApplications": (m) => m.tenantApplications,

	"vacationRental": (m) => m.vacationRental,

	"virtualTours": (m) => m.virtualTours,

	"videoContents": (m) => m.videoContents,

	"agents": (m) => m.agents,

	"extraCharges": (m) => m.extraCharges,

	"currencies": (m) => m.currencies,

	"hashtags": (m) => m.hashtags,

	"guests": (m) => m.guests,

	"agencies": (m) => m.agencies,

	"includedServices": (m) => m.includedServices,

	"pricingRules": (m) => m.pricingRules,

	"discounts": (m) => m.discounts,

	"propertyPhotos": (m) => m.propertyPhotos,

	"analytics": (m) => m.analytics,

	"availabilities": (m) => m.availabilities,

	"complianceRecords": (m) => m.complianceRecords,

	"expenses": (m) => m.expenses,

	"favorites": (m) => m.favorites,

	"increases": (m) => m.increases,

	"mentions": (m) => m.mentions,

	"mortgages": (m) => m.mortgages,

	"offers": (m) => m.offers,

	"payments": (m) => m.payments,

	"photos": (m) => m.photos,

	"propertyPromotions": (m) => m.propertyPromotions,

	"tenants": (m) => m.tenants,

	"includedServiceRelations": (m) => m.includedServiceRelations,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Property) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Property');
    }
    return propFunction as V? Function(Property);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Property.fromJson(JsonMap json) =>
      Property(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	type: json['type'] != null ? PropertyType.fromJson(json['type']) : null,
	name: json['name'] as String?,
	region: json['region'] != null ? Region.fromJson(json['region']) : null,
	currency: json['currency'] as String?,
	addressLine1: json['addressLine1'] as String?,
	addressLine2: json['addressLine2'] as String?,
	city: json['city'] as String?,
	state: json['state'] as String?,
	zip: json['zip'] as String?,
	country: json['country'] as String?,
	lat: json['lat']?.toDouble(),
	lng: json['lng']?.toDouble(),
	neighborhoodId: json['neighborhoodId'] as String?,
	bedrooms: int.tryParse(json['bedrooms'].toString()),
	bathrooms: json['bathrooms']?.toDouble(),
	areaSqm: json['areaSqm']?.toDouble(),
	yearBuilt: int.tryParse(json['yearBuilt'].toString()),
	notes: json['notes'] as String?,
	locationId: json['locationId'] as String?,
	stateCode: json['stateCode'] != null ? State.fromJson(json['stateCode']) : null,
	propertyCategory: json['propertyCategory'] != null ? PropertyCategory.fromJson(json['propertyCategory']) : null,
	listingType: json['listingType'] != null ? ListingType.fromJson(json['listingType']) : null,
	listingStatus: json['listingStatus'] != null ? ListingStatus.fromJson(json['listingStatus']) : null,
	listingPrice: json['listingPrice'] as double?,
	originalPrice: json['originalPrice'] as double?,
	priceHistory: json['priceHistory'] as dynamic,
	schoolDistrict: json['schoolDistrict'] as String?,
	hoaFee: json['hoaFee'] as double?,
	hoaFeeFrequency: json['hoaFeeFrequency'] as String?,
	propertyTaxRate: json['propertyTaxRate']?.toDouble(),
	lastAssessmentValue: json['lastAssessmentValue'] as double?,
	lastAssessmentYear: int.tryParse(json['lastAssessmentYear'].toString()),
	floodZone: json['floodZone'] as String?,
	zoningCode: json['zoningCode'] as String?,
	lotSizeAcres: json['lotSizeAcres']?.toDouble(),
	frontageFeet: json['frontageFeet']?.toDouble(),
	depthFeet: json['depthFeet']?.toDouble(),
	basementType: json['basementType'] as String?,
	basementFinishedSqFt: json['basementFinishedSqFt']?.toDouble(),
	garageType: json['garageType'] as String?,
	garageCapacity: int.tryParse(json['garageCapacity'].toString()),
	parkingSpaces: int.tryParse(json['parkingSpaces'].toString()),
	parkingType: json['parkingType'] as String?,
	poolType: json['poolType'] as String?,
	heatingType: json['heatingType'] as String?,
	coolingType: json['coolingType'] as String?,
	fireplaceType: json['fireplaceType'] as String?,
	fireplaceCount: int.tryParse(json['fireplaceCount'].toString()),
	viewType: json['viewType'] as String?,
	waterfrontType: json['waterfrontType'] as String?,
	waterfrontFeet: json['waterfrontFeet']?.toDouble(),
	constructionType: json['constructionType'] as String?,
	roofType: json['roofType'] as String?,
	roofYear: int.tryParse(json['roofYear'].toString()),
	sidingType: json['sidingType'] as String?,
	zipPlus4: json['zipPlus4'] as String?,
	countyFIPS: json['countyFIPS'] as String?,
	censusTract: json['censusTract'] as String?,
	mlsArea: json['mlsArea'] as String?,
	propertyClass: json['propertyClass'] as String?,
	buildingClass: json['buildingClass'] as String?,
	totalRooms: int.tryParse(json['totalRooms'].toString()),
	livingAreaSqFt: json['livingAreaSqFt']?.toDouble(),
	lotSizeSqFt: json['lotSizeSqFt']?.toDouble(),
	stories: int.tryParse(json['stories'].toString()),
	unitsPerBuilding: int.tryParse(json['unitsPerBuilding'].toString()),
	assessedValue: json['assessedValue'] as double?,
	marketValue: json['marketValue'] as double?,
	propertyTax: json['propertyTax'] as double?,
	insuranceAmount: json['insuranceAmount'] as double?,
	mortgageBalance: json['mortgageBalance'] as double?,
	lienAmount: json['lienAmount'] as double?,
	electricityProvider: json['electricityProvider'] as String?,
	gasProvider: json['gasProvider'] as String?,
	waterProvider: json['waterProvider'] as String?,
	internetProvider: json['internetProvider'] as String?,
	trashService: json['trashService'] as String?,
	mlsNumber: json['mlsNumber'] as String?,
	mlsStatus: json['mlsStatus'] as String?,
	daysOnMarket: int.tryParse(json['daysOnMarket'].toString()),
	pricePerSqFt: json['pricePerSqFt']?.toDouble(),
	rentalYield: json['rentalYield']?.toDouble(),
	yearRenovated: int.tryParse(json['yearRenovated'].toString()),
	energyRating: json['energyRating'] as String?,
	accessibilityFeatures: json['accessibilityFeatures'] != null ? (json['accessibilityFeatures'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	smartHomeFeatures: json['smartHomeFeatures'] != null ? (json['smartHomeFeatures'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	securityFeatures: json['securityFeatures'] != null ? (json['securityFeatures'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	outdoorFeatures: json['outdoorFeatures'] != null ? (json['outdoorFeatures'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	zoningDescription: json['zoningDescription'] as String?,
	landUse: json['landUse'] as String?,
	buildingRestrictions: json['buildingRestrictions'] as String?,
	futureDevelopment: json['futureDevelopment'] as String?,
	leadPaintCompliance: json['leadPaintCompliance'] as bool?,
	moldInspectionDate: json['moldInspectionDate'] != null ? DateTime.parse(json['moldInspectionDate']) : null,
	asbestosInspectionDate: json['asbestosInspectionDate'] != null ? DateTime.parse(json['asbestosInspectionDate']) : null,
	radonTestDate: json['radonTestDate'] != null ? DateTime.parse(json['radonTestDate']) : null,
	pestControlDate: json['pestControlDate'] != null ? DateTime.parse(json['pestControlDate']) : null,
	fireInspectionDate: json['fireInspectionDate'] != null ? DateTime.parse(json['fireInspectionDate']) : null,
	elevatorInspectionDate: json['elevatorInspectionDate'] != null ? DateTime.parse(json['elevatorInspectionDate']) : null,
	poolInspectionDate: json['poolInspectionDate'] != null ? DateTime.parse(json['poolInspectionDate']) : null,
	lastCodeComplianceDate: json['lastCodeComplianceDate'] != null ? DateTime.parse(json['lastCodeComplianceDate']) : null,
	accessibilityCompliance: json['accessibilityCompliance'] as bool?,
	environmentalHazards: json['environmentalHazards'] != null ? (json['environmentalHazards'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	aiImageAnalyses: json['aiImageAnalyses'] != null ? createModels<AIImageAnalysis>((json['aiImageAnalyses'] as List).cast<JsonMap>(), AIImageAnalysis.fromJson) : null,
	aiInvestments: json['aiInvestments'] != null ? createModels<AIInvestmentAnalysis>((json['aiInvestments'] as List).cast<JsonMap>(), AIInvestmentAnalysis.fromJson) : null,
	aiMaintenance: json['aiMaintenance'] != null ? createModels<AIPredictiveMaintenance>((json['aiMaintenance'] as List).cast<JsonMap>(), AIPredictiveMaintenance.fromJson) : null,
	aiDescriptions: json['aiDescriptions'] != null ? createModels<AIPropertyDescription>((json['aiDescriptions'] as List).cast<JsonMap>(), AIPropertyDescription.fromJson) : null,
	aiValuations: json['aiValuations'] != null ? createModels<AIPropertyValuation>((json['aiValuations'] as List).cast<JsonMap>(), AIPropertyValuation.fromJson) : null,
	appointments: json['appointments'] != null ? createModels<Appointment>((json['appointments'] as List).cast<JsonMap>(), Appointment.fromJson) : null,
	attachments: json['attachments'] != null ? createModels<Attachment>((json['attachments'] as List).cast<JsonMap>(), Attachment.fromJson) : null,
	contracts: json['contracts'] != null ? createModels<Contract>((json['contracts'] as List).cast<JsonMap>(), Contract.fromJson) : null,
	deals: json['deals'] != null ? createModels<Deal>((json['deals'] as List).cast<JsonMap>(), Deal.fromJson) : null,
	generalDocuments: json['generalDocuments'] != null ? createModels<Document>((json['generalDocuments'] as List).cast<JsonMap>(), Document.fromJson) : null,
	events: json['events'] != null ? createModels<Event>((json['events'] as List).cast<JsonMap>(), Event.fromJson) : null,
	facilities: json['facilities'] != null ? createModels<Facility>((json['facilities'] as List).cast<JsonMap>(), Facility.fromJson) : null,
	financialRecords: json['financialRecords'] != null ? createModels<FinancialRecord>((json['financialRecords'] as List).cast<JsonMap>(), FinancialRecord.fromJson) : null,
	floorPlans: json['floorPlans'] != null ? createModels<FloorPlan>((json['floorPlans'] as List).cast<JsonMap>(), FloorPlan.fromJson) : null,
	guestReviews: json['guestReviews'] != null ? createModels<GuestReview>((json['guestReviews'] as List).cast<JsonMap>(), GuestReview.fromJson) : null,
	homeInformationPack: json['homeInformationPack'] != null ? HomeInformationPack.fromJson(json['homeInformationPack'] as JsonMap) : null,
	investorProperties: json['investorProperties'] != null ? createModels<InvestorProperty>((json['investorProperties'] as List).cast<JsonMap>(), InvestorProperty.fromJson) : null,
	keys: json['keys'] != null ? createModels<KeyManagement>((json['keys'] as List).cast<JsonMap>(), KeyManagement.fromJson) : null,
	leads: json['leads'] != null ? createModels<Lead>((json['leads'] as List).cast<JsonMap>(), Lead.fromJson) : null,
	ledger: json['ledger'] != null ? createModels<LedgerEntry>((json['ledger'] as List).cast<JsonMap>(), LedgerEntry.fromJson) : null,
	listings: json['listings'] != null ? createModels<Listing>((json['listings'] as List).cast<JsonMap>(), Listing.fromJson) : null,
	maintenanceBlocks: json['maintenanceBlocks'] != null ? createModels<MaintenanceBlock>((json['maintenanceBlocks'] as List).cast<JsonMap>(), MaintenanceBlock.fromJson) : null,
	workOrders: json['workOrders'] != null ? createModels<MaintenanceWorkOrder>((json['workOrders'] as List).cast<JsonMap>(), MaintenanceWorkOrder.fromJson) : null,
	mortgageOffers: json['mortgageOffers'] != null ? createModels<MortgageOffer>((json['mortgageOffers'] as List).cast<JsonMap>(), MortgageOffer.fromJson) : null,
	projects: json['projects'] != null ? createModels<Project>((json['projects'] as List).cast<JsonMap>(), Project.fromJson) : null,
	location: json['location'] != null ? Location.fromJson(json['location'] as JsonMap) : null,
	neighborhood: json['neighborhood'] != null ? Neighborhood.fromJson(json['neighborhood'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	amenities: json['amenities'] != null ? createModels<PropertyAmenity>((json['amenities'] as List).cast<JsonMap>(), PropertyAmenity.fromJson) : null,
	compliance: json['compliance'] != null ? createModels<PropertyCompliance>((json['compliance'] as List).cast<JsonMap>(), PropertyCompliance.fromJson) : null,
	propertyDisclosure: json['propertyDisclosure'] != null ? PropertyDisclosure.fromJson(json['propertyDisclosure'] as JsonMap) : null,
	documents: json['documents'] != null ? createModels<PropertyDocument>((json['documents'] as List).cast<JsonMap>(), PropertyDocument.fromJson) : null,
	inventories: json['inventories'] != null ? createModels<PropertyInventory>((json['inventories'] as List).cast<JsonMap>(), PropertyInventory.fromJson) : null,
	propertyOffers: json['propertyOffers'] != null ? createModels<PropertyOffer>((json['propertyOffers'] as List).cast<JsonMap>(), PropertyOffer.fromJson) : null,
	valuations: json['valuations'] != null ? createModels<PropertyValuation>((json['valuations'] as List).cast<JsonMap>(), PropertyValuation.fromJson) : null,
	viewings: json['viewings'] != null ? createModels<PropertyViewing>((json['viewings'] as List).cast<JsonMap>(), PropertyViewing.fromJson) : null,
	quotes: json['quotes'] != null ? createModels<Quote>((json['quotes'] as List).cast<JsonMap>(), Quote.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	taxDepreciations: json['taxDepreciations'] != null ? createModels<TaxDepreciation>((json['taxDepreciations'] as List).cast<JsonMap>(), TaxDepreciation.fromJson) : null,
	tenantApplications: json['tenantApplications'] != null ? createModels<TenantApplication>((json['tenantApplications'] as List).cast<JsonMap>(), TenantApplication.fromJson) : null,
	vacationRental: json['vacationRental'] != null ? VacationRental.fromJson(json['vacationRental'] as JsonMap) : null,
	virtualTours: json['virtualTours'] != null ? createModels<VirtualTour>((json['virtualTours'] as List).cast<JsonMap>(), VirtualTour.fromJson) : null,
	videoContents: json['videoContents'] != null ? createModels<VideoContent>((json['videoContents'] as List).cast<JsonMap>(), VideoContent.fromJson) : null,
	agents: json['agents'] != null ? createModels<Agent>((json['agents'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	extraCharges: json['extraCharges'] != null ? createModels<ExtraCharge>((json['extraCharges'] as List).cast<JsonMap>(), ExtraCharge.fromJson) : null,
	currencies: json['currencies'] != null ? createModels<Currency>((json['currencies'] as List).cast<JsonMap>(), Currency.fromJson) : null,
	hashtags: json['hashtags'] != null ? createModels<Hashtag>((json['hashtags'] as List).cast<JsonMap>(), Hashtag.fromJson) : null,
	guests: json['guests'] != null ? createModels<Guest>((json['guests'] as List).cast<JsonMap>(), Guest.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	includedServices: json['includedServices'] != null ? createModels<IncludedService>((json['includedServices'] as List).cast<JsonMap>(), IncludedService.fromJson) : null,
	pricingRules: json['pricingRules'] != null ? createModels<PricingRule>((json['pricingRules'] as List).cast<JsonMap>(), PricingRule.fromJson) : null,
	discounts: json['discounts'] != null ? createModels<Discount>((json['discounts'] as List).cast<JsonMap>(), Discount.fromJson) : null,
	propertyPhotos: json['propertyPhotos'] != null ? createModels<PropertyPhoto>((json['propertyPhotos'] as List).cast<JsonMap>(), PropertyPhoto.fromJson) : null,
	analytics: json['analytics'] != null ? createModels<Analytics>((json['analytics'] as List).cast<JsonMap>(), Analytics.fromJson) : null,
	availabilities: json['availabilities'] != null ? createModels<Availability>((json['availabilities'] as List).cast<JsonMap>(), Availability.fromJson) : null,
	complianceRecords: json['complianceRecords'] != null ? createModels<ComplianceRecord>((json['complianceRecords'] as List).cast<JsonMap>(), ComplianceRecord.fromJson) : null,
	expenses: json['expenses'] != null ? createModels<Expense>((json['expenses'] as List).cast<JsonMap>(), Expense.fromJson) : null,
	favorites: json['favorites'] != null ? createModels<Favorite>((json['favorites'] as List).cast<JsonMap>(), Favorite.fromJson) : null,
	increases: json['increases'] != null ? createModels<Increase>((json['increases'] as List).cast<JsonMap>(), Increase.fromJson) : null,
	mentions: json['mentions'] != null ? createModels<Mention>((json['mentions'] as List).cast<JsonMap>(), Mention.fromJson) : null,
	mortgages: json['mortgages'] != null ? createModels<Mortgage>((json['mortgages'] as List).cast<JsonMap>(), Mortgage.fromJson) : null,
	offers: json['offers'] != null ? createModels<Offer>((json['offers'] as List).cast<JsonMap>(), Offer.fromJson) : null,
	payments: json['payments'] != null ? createModels<Payment>((json['payments'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	photos: json['photos'] != null ? createModels<Photo>((json['photos'] as List).cast<JsonMap>(), Photo.fromJson) : null,
	propertyPromotions: json['propertyPromotions'] != null ? createModels<PropertyPromotion>((json['propertyPromotions'] as List).cast<JsonMap>(), PropertyPromotion.fromJson) : null,
	tenants: json['tenants'] != null ? createModels<Tenant>((json['tenants'] as List).cast<JsonMap>(), Tenant.fromJson) : null,
	includedServiceRelations: json['includedServiceRelations'] != null ? createModels<IncludedService>((json['includedServiceRelations'] as List).cast<JsonMap>(), IncludedService.fromJson) : null,
	$accessibilityFeaturesCount: json['_count']?['accessibilityFeatures'] as int?,
	$smartHomeFeaturesCount: json['_count']?['smartHomeFeatures'] as int?,
	$securityFeaturesCount: json['_count']?['securityFeatures'] as int?,
	$outdoorFeaturesCount: json['_count']?['outdoorFeatures'] as int?,
	$environmentalHazardsCount: json['_count']?['environmentalHazards'] as int?,
	$aiImageAnalysesCount: json['_count']?['aiImageAnalyses'] as int?,
	$aiInvestmentsCount: json['_count']?['aiInvestments'] as int?,
	$aiMaintenanceCount: json['_count']?['aiMaintenance'] as int?,
	$aiDescriptionsCount: json['_count']?['aiDescriptions'] as int?,
	$aiValuationsCount: json['_count']?['aiValuations'] as int?,
	$appointmentsCount: json['_count']?['appointments'] as int?,
	$attachmentsCount: json['_count']?['attachments'] as int?,
	$contractsCount: json['_count']?['contracts'] as int?,
	$dealsCount: json['_count']?['deals'] as int?,
	$generalDocumentsCount: json['_count']?['generalDocuments'] as int?,
	$eventsCount: json['_count']?['events'] as int?,
	$facilitiesCount: json['_count']?['facilities'] as int?,
	$financialRecordsCount: json['_count']?['financialRecords'] as int?,
	$floorPlansCount: json['_count']?['floorPlans'] as int?,
	$guestReviewsCount: json['_count']?['guestReviews'] as int?,
	$investorPropertiesCount: json['_count']?['investorProperties'] as int?,
	$keysCount: json['_count']?['keys'] as int?,
	$leadsCount: json['_count']?['leads'] as int?,
	$ledgerCount: json['_count']?['ledger'] as int?,
	$listingsCount: json['_count']?['listings'] as int?,
	$maintenanceBlocksCount: json['_count']?['maintenanceBlocks'] as int?,
	$workOrdersCount: json['_count']?['workOrders'] as int?,
	$mortgageOffersCount: json['_count']?['mortgageOffers'] as int?,
	$projectsCount: json['_count']?['projects'] as int?,
	$amenitiesCount: json['_count']?['amenities'] as int?,
	$complianceCount: json['_count']?['compliance'] as int?,
	$documentsCount: json['_count']?['documents'] as int?,
	$inventoriesCount: json['_count']?['inventories'] as int?,
	$propertyOffersCount: json['_count']?['propertyOffers'] as int?,
	$valuationsCount: json['_count']?['valuations'] as int?,
	$viewingsCount: json['_count']?['viewings'] as int?,
	$quotesCount: json['_count']?['quotes'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$taxDepreciationsCount: json['_count']?['taxDepreciations'] as int?,
	$tenantApplicationsCount: json['_count']?['tenantApplications'] as int?,
	$virtualToursCount: json['_count']?['virtualTours'] as int?,
	$videoContentsCount: json['_count']?['videoContents'] as int?,
	$agentsCount: json['_count']?['agents'] as int?,
	$extraChargesCount: json['_count']?['extraCharges'] as int?,
	$currenciesCount: json['_count']?['currencies'] as int?,
	$hashtagsCount: json['_count']?['hashtags'] as int?,
	$guestsCount: json['_count']?['guests'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$includedServicesCount: json['_count']?['includedServices'] as int?,
	$pricingRulesCount: json['_count']?['pricingRules'] as int?,
	$discountsCount: json['_count']?['discounts'] as int?,
	$propertyPhotosCount: json['_count']?['propertyPhotos'] as int?,
	$analyticsCount: json['_count']?['analytics'] as int?,
	$availabilitiesCount: json['_count']?['availabilities'] as int?,
	$complianceRecordsCount: json['_count']?['complianceRecords'] as int?,
	$expensesCount: json['_count']?['expenses'] as int?,
	$favoritesCount: json['_count']?['favorites'] as int?,
	$increasesCount: json['_count']?['increases'] as int?,
	$mentionsCount: json['_count']?['mentions'] as int?,
	$mortgagesCount: json['_count']?['mortgages'] as int?,
	$offersCount: json['_count']?['offers'] as int?,
	$paymentsCount: json['_count']?['payments'] as int?,
	$photosCount: json['_count']?['photos'] as int?,
	$propertyPromotionsCount: json['_count']?['propertyPromotions'] as int?,
	$tenantsCount: json['_count']?['tenants'] as int?,
	$includedServiceRelationsCount: json['_count']?['includedServiceRelations'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Property copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<PropertyType?>? type,
		Value<String?>? name,
		Value<Region?>? region,
		Value<String?>? currency,
		Value<String?>? addressLine1,
		Value<String?>? addressLine2,
		Value<String?>? city,
		Value<String?>? state,
		Value<String?>? zip,
		Value<String?>? country,
		Value<double?>? lat,
		Value<double?>? lng,
		Value<String?>? neighborhoodId,
		Value<int?>? bedrooms,
		Value<double?>? bathrooms,
		Value<double?>? areaSqm,
		Value<int?>? yearBuilt,
		Value<String?>? notes,
		Value<String?>? locationId,
		Value<State?>? stateCode,
		Value<PropertyCategory?>? propertyCategory,
		Value<ListingType?>? listingType,
		Value<ListingStatus?>? listingStatus,
		Value<double?>? listingPrice,
		Value<double?>? originalPrice,
		Value<dynamic>? priceHistory,
		Value<String?>? schoolDistrict,
		Value<double?>? hoaFee,
		Value<String?>? hoaFeeFrequency,
		Value<double?>? propertyTaxRate,
		Value<double?>? lastAssessmentValue,
		Value<int?>? lastAssessmentYear,
		Value<String?>? floodZone,
		Value<String?>? zoningCode,
		Value<double?>? lotSizeAcres,
		Value<double?>? frontageFeet,
		Value<double?>? depthFeet,
		Value<String?>? basementType,
		Value<double?>? basementFinishedSqFt,
		Value<String?>? garageType,
		Value<int?>? garageCapacity,
		Value<int?>? parkingSpaces,
		Value<String?>? parkingType,
		Value<String?>? poolType,
		Value<String?>? heatingType,
		Value<String?>? coolingType,
		Value<String?>? fireplaceType,
		Value<int?>? fireplaceCount,
		Value<String?>? viewType,
		Value<String?>? waterfrontType,
		Value<double?>? waterfrontFeet,
		Value<String?>? constructionType,
		Value<String?>? roofType,
		Value<int?>? roofYear,
		Value<String?>? sidingType,
		Value<String?>? zipPlus4,
		Value<String?>? countyFIPS,
		Value<String?>? censusTract,
		Value<String?>? mlsArea,
		Value<String?>? propertyClass,
		Value<String?>? buildingClass,
		Value<int?>? totalRooms,
		Value<double?>? livingAreaSqFt,
		Value<double?>? lotSizeSqFt,
		Value<int?>? stories,
		Value<int?>? unitsPerBuilding,
		Value<double?>? assessedValue,
		Value<double?>? marketValue,
		Value<double?>? propertyTax,
		Value<double?>? insuranceAmount,
		Value<double?>? mortgageBalance,
		Value<double?>? lienAmount,
		Value<String?>? electricityProvider,
		Value<String?>? gasProvider,
		Value<String?>? waterProvider,
		Value<String?>? internetProvider,
		Value<String?>? trashService,
		Value<String?>? mlsNumber,
		Value<String?>? mlsStatus,
		Value<int?>? daysOnMarket,
		Value<double?>? pricePerSqFt,
		Value<double?>? rentalYield,
		Value<int?>? yearRenovated,
		Value<String?>? energyRating,
		Value<List<String>?>? accessibilityFeatures,
		Value<List<String>?>? smartHomeFeatures,
		Value<List<String>?>? securityFeatures,
		Value<List<String>?>? outdoorFeatures,
		Value<String?>? zoningDescription,
		Value<String?>? landUse,
		Value<String?>? buildingRestrictions,
		Value<String?>? futureDevelopment,
		Value<bool?>? leadPaintCompliance,
		Value<DateTime?>? moldInspectionDate,
		Value<DateTime?>? asbestosInspectionDate,
		Value<DateTime?>? radonTestDate,
		Value<DateTime?>? pestControlDate,
		Value<DateTime?>? fireInspectionDate,
		Value<DateTime?>? elevatorInspectionDate,
		Value<DateTime?>? poolInspectionDate,
		Value<DateTime?>? lastCodeComplianceDate,
		Value<bool?>? accessibilityCompliance,
		Value<List<String>?>? environmentalHazards,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<AIImageAnalysis>?>? aiImageAnalyses,
		Value<List<AIInvestmentAnalysis>?>? aiInvestments,
		Value<List<AIPredictiveMaintenance>?>? aiMaintenance,
		Value<List<AIPropertyDescription>?>? aiDescriptions,
		Value<List<AIPropertyValuation>?>? aiValuations,
		Value<List<Appointment>?>? appointments,
		Value<List<Attachment>?>? attachments,
		Value<List<Contract>?>? contracts,
		Value<List<Deal>?>? deals,
		Value<List<Document>?>? generalDocuments,
		Value<List<Event>?>? events,
		Value<List<Facility>?>? facilities,
		Value<List<FinancialRecord>?>? financialRecords,
		Value<List<FloorPlan>?>? floorPlans,
		Value<List<GuestReview>?>? guestReviews,
		Value<HomeInformationPack?>? homeInformationPack,
		Value<List<InvestorProperty>?>? investorProperties,
		Value<List<KeyManagement>?>? keys,
		Value<List<Lead>?>? leads,
		Value<List<LedgerEntry>?>? ledger,
		Value<List<Listing>?>? listings,
		Value<List<MaintenanceBlock>?>? maintenanceBlocks,
		Value<List<MaintenanceWorkOrder>?>? workOrders,
		Value<List<MortgageOffer>?>? mortgageOffers,
		Value<List<Project>?>? projects,
		Value<Location?>? location,
		Value<Neighborhood?>? neighborhood,
		Value<Organization?>? org,
		Value<List<PropertyAmenity>?>? amenities,
		Value<List<PropertyCompliance>?>? compliance,
		Value<PropertyDisclosure?>? propertyDisclosure,
		Value<List<PropertyDocument>?>? documents,
		Value<List<PropertyInventory>?>? inventories,
		Value<List<PropertyOffer>?>? propertyOffers,
		Value<List<PropertyValuation>?>? valuations,
		Value<List<PropertyViewing>?>? viewings,
		Value<List<Quote>?>? quotes,
		Value<List<Task>?>? tasks,
		Value<List<TaxDepreciation>?>? taxDepreciations,
		Value<List<TenantApplication>?>? tenantApplications,
		Value<VacationRental?>? vacationRental,
		Value<List<VirtualTour>?>? virtualTours,
		Value<List<VideoContent>?>? videoContents,
		Value<List<Agent>?>? agents,
		Value<List<ExtraCharge>?>? extraCharges,
		Value<List<Currency>?>? currencies,
		Value<List<Hashtag>?>? hashtags,
		Value<List<Guest>?>? guests,
		Value<List<Agency>?>? agencies,
		Value<List<IncludedService>?>? includedServices,
		Value<List<PricingRule>?>? pricingRules,
		Value<List<Discount>?>? discounts,
		Value<List<PropertyPhoto>?>? propertyPhotos,
		Value<List<Analytics>?>? analytics,
		Value<List<Availability>?>? availabilities,
		Value<List<ComplianceRecord>?>? complianceRecords,
		Value<List<Expense>?>? expenses,
		Value<List<Favorite>?>? favorites,
		Value<List<Increase>?>? increases,
		Value<List<Mention>?>? mentions,
		Value<List<Mortgage>?>? mortgages,
		Value<List<Offer>?>? offers,
		Value<List<Payment>?>? payments,
		Value<List<Photo>?>? photos,
		Value<List<PropertyPromotion>?>? propertyPromotions,
		Value<List<Tenant>?>? tenants,
		Value<List<IncludedService>?>? includedServiceRelations,
		int? $accessibilityFeaturesCount,
		int? $smartHomeFeaturesCount,
		int? $securityFeaturesCount,
		int? $outdoorFeaturesCount,
		int? $environmentalHazardsCount,
		int? $aiImageAnalysesCount,
		int? $aiInvestmentsCount,
		int? $aiMaintenanceCount,
		int? $aiDescriptionsCount,
		int? $aiValuationsCount,
		int? $appointmentsCount,
		int? $attachmentsCount,
		int? $contractsCount,
		int? $dealsCount,
		int? $generalDocumentsCount,
		int? $eventsCount,
		int? $facilitiesCount,
		int? $financialRecordsCount,
		int? $floorPlansCount,
		int? $guestReviewsCount,
		int? $investorPropertiesCount,
		int? $keysCount,
		int? $leadsCount,
		int? $ledgerCount,
		int? $listingsCount,
		int? $maintenanceBlocksCount,
		int? $workOrdersCount,
		int? $mortgageOffersCount,
		int? $projectsCount,
		int? $amenitiesCount,
		int? $complianceCount,
		int? $documentsCount,
		int? $inventoriesCount,
		int? $propertyOffersCount,
		int? $valuationsCount,
		int? $viewingsCount,
		int? $quotesCount,
		int? $tasksCount,
		int? $taxDepreciationsCount,
		int? $tenantApplicationsCount,
		int? $virtualToursCount,
		int? $videoContentsCount,
		int? $agentsCount,
		int? $extraChargesCount,
		int? $currenciesCount,
		int? $hashtagsCount,
		int? $guestsCount,
		int? $agenciesCount,
		int? $includedServicesCount,
		int? $pricingRulesCount,
		int? $discountsCount,
		int? $propertyPhotosCount,
		int? $analyticsCount,
		int? $availabilitiesCount,
		int? $complianceRecordsCount,
		int? $expensesCount,
		int? $favoritesCount,
		int? $increasesCount,
		int? $mentionsCount,
		int? $mortgagesCount,
		int? $offersCount,
		int? $paymentsCount,
		int? $photosCount,
		int? $propertyPromotionsCount,
		int? $tenantsCount,
		int? $includedServiceRelationsCount,
        }) {
        return Property(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		type: type != null ? type.value : this.type,
		name: name != null ? name.value : this.name,
		region: region != null ? region.value : this.region,
		currency: currency != null ? currency.value : this.currency,
		addressLine1: addressLine1 != null ? addressLine1.value : this.addressLine1,
		addressLine2: addressLine2 != null ? addressLine2.value : this.addressLine2,
		city: city != null ? city.value : this.city,
		state: state != null ? state.value : this.state,
		zip: zip != null ? zip.value : this.zip,
		country: country != null ? country.value : this.country,
		lat: lat != null ? lat.value : this.lat,
		lng: lng != null ? lng.value : this.lng,
		neighborhoodId: neighborhoodId != null ? neighborhoodId.value : this.neighborhoodId,
		bedrooms: bedrooms != null ? bedrooms.value : this.bedrooms,
		bathrooms: bathrooms != null ? bathrooms.value : this.bathrooms,
		areaSqm: areaSqm != null ? areaSqm.value : this.areaSqm,
		yearBuilt: yearBuilt != null ? yearBuilt.value : this.yearBuilt,
		notes: notes != null ? notes.value : this.notes,
		locationId: locationId != null ? locationId.value : this.locationId,
		stateCode: stateCode != null ? stateCode.value : this.stateCode,
		propertyCategory: propertyCategory != null ? propertyCategory.value : this.propertyCategory,
		listingType: listingType != null ? listingType.value : this.listingType,
		listingStatus: listingStatus != null ? listingStatus.value : this.listingStatus,
		listingPrice: listingPrice != null ? listingPrice.value : this.listingPrice,
		originalPrice: originalPrice != null ? originalPrice.value : this.originalPrice,
		priceHistory: priceHistory != null ? priceHistory.value : this.priceHistory,
		schoolDistrict: schoolDistrict != null ? schoolDistrict.value : this.schoolDistrict,
		hoaFee: hoaFee != null ? hoaFee.value : this.hoaFee,
		hoaFeeFrequency: hoaFeeFrequency != null ? hoaFeeFrequency.value : this.hoaFeeFrequency,
		propertyTaxRate: propertyTaxRate != null ? propertyTaxRate.value : this.propertyTaxRate,
		lastAssessmentValue: lastAssessmentValue != null ? lastAssessmentValue.value : this.lastAssessmentValue,
		lastAssessmentYear: lastAssessmentYear != null ? lastAssessmentYear.value : this.lastAssessmentYear,
		floodZone: floodZone != null ? floodZone.value : this.floodZone,
		zoningCode: zoningCode != null ? zoningCode.value : this.zoningCode,
		lotSizeAcres: lotSizeAcres != null ? lotSizeAcres.value : this.lotSizeAcres,
		frontageFeet: frontageFeet != null ? frontageFeet.value : this.frontageFeet,
		depthFeet: depthFeet != null ? depthFeet.value : this.depthFeet,
		basementType: basementType != null ? basementType.value : this.basementType,
		basementFinishedSqFt: basementFinishedSqFt != null ? basementFinishedSqFt.value : this.basementFinishedSqFt,
		garageType: garageType != null ? garageType.value : this.garageType,
		garageCapacity: garageCapacity != null ? garageCapacity.value : this.garageCapacity,
		parkingSpaces: parkingSpaces != null ? parkingSpaces.value : this.parkingSpaces,
		parkingType: parkingType != null ? parkingType.value : this.parkingType,
		poolType: poolType != null ? poolType.value : this.poolType,
		heatingType: heatingType != null ? heatingType.value : this.heatingType,
		coolingType: coolingType != null ? coolingType.value : this.coolingType,
		fireplaceType: fireplaceType != null ? fireplaceType.value : this.fireplaceType,
		fireplaceCount: fireplaceCount != null ? fireplaceCount.value : this.fireplaceCount,
		viewType: viewType != null ? viewType.value : this.viewType,
		waterfrontType: waterfrontType != null ? waterfrontType.value : this.waterfrontType,
		waterfrontFeet: waterfrontFeet != null ? waterfrontFeet.value : this.waterfrontFeet,
		constructionType: constructionType != null ? constructionType.value : this.constructionType,
		roofType: roofType != null ? roofType.value : this.roofType,
		roofYear: roofYear != null ? roofYear.value : this.roofYear,
		sidingType: sidingType != null ? sidingType.value : this.sidingType,
		zipPlus4: zipPlus4 != null ? zipPlus4.value : this.zipPlus4,
		countyFIPS: countyFIPS != null ? countyFIPS.value : this.countyFIPS,
		censusTract: censusTract != null ? censusTract.value : this.censusTract,
		mlsArea: mlsArea != null ? mlsArea.value : this.mlsArea,
		propertyClass: propertyClass != null ? propertyClass.value : this.propertyClass,
		buildingClass: buildingClass != null ? buildingClass.value : this.buildingClass,
		totalRooms: totalRooms != null ? totalRooms.value : this.totalRooms,
		livingAreaSqFt: livingAreaSqFt != null ? livingAreaSqFt.value : this.livingAreaSqFt,
		lotSizeSqFt: lotSizeSqFt != null ? lotSizeSqFt.value : this.lotSizeSqFt,
		stories: stories != null ? stories.value : this.stories,
		unitsPerBuilding: unitsPerBuilding != null ? unitsPerBuilding.value : this.unitsPerBuilding,
		assessedValue: assessedValue != null ? assessedValue.value : this.assessedValue,
		marketValue: marketValue != null ? marketValue.value : this.marketValue,
		propertyTax: propertyTax != null ? propertyTax.value : this.propertyTax,
		insuranceAmount: insuranceAmount != null ? insuranceAmount.value : this.insuranceAmount,
		mortgageBalance: mortgageBalance != null ? mortgageBalance.value : this.mortgageBalance,
		lienAmount: lienAmount != null ? lienAmount.value : this.lienAmount,
		electricityProvider: electricityProvider != null ? electricityProvider.value : this.electricityProvider,
		gasProvider: gasProvider != null ? gasProvider.value : this.gasProvider,
		waterProvider: waterProvider != null ? waterProvider.value : this.waterProvider,
		internetProvider: internetProvider != null ? internetProvider.value : this.internetProvider,
		trashService: trashService != null ? trashService.value : this.trashService,
		mlsNumber: mlsNumber != null ? mlsNumber.value : this.mlsNumber,
		mlsStatus: mlsStatus != null ? mlsStatus.value : this.mlsStatus,
		daysOnMarket: daysOnMarket != null ? daysOnMarket.value : this.daysOnMarket,
		pricePerSqFt: pricePerSqFt != null ? pricePerSqFt.value : this.pricePerSqFt,
		rentalYield: rentalYield != null ? rentalYield.value : this.rentalYield,
		yearRenovated: yearRenovated != null ? yearRenovated.value : this.yearRenovated,
		energyRating: energyRating != null ? energyRating.value : this.energyRating,
		accessibilityFeatures: accessibilityFeatures != null ? accessibilityFeatures.value : this.accessibilityFeatures,
		smartHomeFeatures: smartHomeFeatures != null ? smartHomeFeatures.value : this.smartHomeFeatures,
		securityFeatures: securityFeatures != null ? securityFeatures.value : this.securityFeatures,
		outdoorFeatures: outdoorFeatures != null ? outdoorFeatures.value : this.outdoorFeatures,
		zoningDescription: zoningDescription != null ? zoningDescription.value : this.zoningDescription,
		landUse: landUse != null ? landUse.value : this.landUse,
		buildingRestrictions: buildingRestrictions != null ? buildingRestrictions.value : this.buildingRestrictions,
		futureDevelopment: futureDevelopment != null ? futureDevelopment.value : this.futureDevelopment,
		leadPaintCompliance: leadPaintCompliance != null ? leadPaintCompliance.value : this.leadPaintCompliance,
		moldInspectionDate: moldInspectionDate != null ? moldInspectionDate.value : this.moldInspectionDate,
		asbestosInspectionDate: asbestosInspectionDate != null ? asbestosInspectionDate.value : this.asbestosInspectionDate,
		radonTestDate: radonTestDate != null ? radonTestDate.value : this.radonTestDate,
		pestControlDate: pestControlDate != null ? pestControlDate.value : this.pestControlDate,
		fireInspectionDate: fireInspectionDate != null ? fireInspectionDate.value : this.fireInspectionDate,
		elevatorInspectionDate: elevatorInspectionDate != null ? elevatorInspectionDate.value : this.elevatorInspectionDate,
		poolInspectionDate: poolInspectionDate != null ? poolInspectionDate.value : this.poolInspectionDate,
		lastCodeComplianceDate: lastCodeComplianceDate != null ? lastCodeComplianceDate.value : this.lastCodeComplianceDate,
		accessibilityCompliance: accessibilityCompliance != null ? accessibilityCompliance.value : this.accessibilityCompliance,
		environmentalHazards: environmentalHazards != null ? environmentalHazards.value : this.environmentalHazards,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		aiImageAnalyses: aiImageAnalyses != null ? aiImageAnalyses.value : this.aiImageAnalyses,
		aiInvestments: aiInvestments != null ? aiInvestments.value : this.aiInvestments,
		aiMaintenance: aiMaintenance != null ? aiMaintenance.value : this.aiMaintenance,
		aiDescriptions: aiDescriptions != null ? aiDescriptions.value : this.aiDescriptions,
		aiValuations: aiValuations != null ? aiValuations.value : this.aiValuations,
		appointments: appointments != null ? appointments.value : this.appointments,
		attachments: attachments != null ? attachments.value : this.attachments,
		contracts: contracts != null ? contracts.value : this.contracts,
		deals: deals != null ? deals.value : this.deals,
		generalDocuments: generalDocuments != null ? generalDocuments.value : this.generalDocuments,
		events: events != null ? events.value : this.events,
		facilities: facilities != null ? facilities.value : this.facilities,
		financialRecords: financialRecords != null ? financialRecords.value : this.financialRecords,
		floorPlans: floorPlans != null ? floorPlans.value : this.floorPlans,
		guestReviews: guestReviews != null ? guestReviews.value : this.guestReviews,
		homeInformationPack: homeInformationPack != null ? homeInformationPack.value : this.homeInformationPack,
		investorProperties: investorProperties != null ? investorProperties.value : this.investorProperties,
		keys: keys != null ? keys.value : this.keys,
		leads: leads != null ? leads.value : this.leads,
		ledger: ledger != null ? ledger.value : this.ledger,
		listings: listings != null ? listings.value : this.listings,
		maintenanceBlocks: maintenanceBlocks != null ? maintenanceBlocks.value : this.maintenanceBlocks,
		workOrders: workOrders != null ? workOrders.value : this.workOrders,
		mortgageOffers: mortgageOffers != null ? mortgageOffers.value : this.mortgageOffers,
		projects: projects != null ? projects.value : this.projects,
		location: location != null ? location.value : this.location,
		neighborhood: neighborhood != null ? neighborhood.value : this.neighborhood,
		org: org != null ? org.value : this.org,
		amenities: amenities != null ? amenities.value : this.amenities,
		compliance: compliance != null ? compliance.value : this.compliance,
		propertyDisclosure: propertyDisclosure != null ? propertyDisclosure.value : this.propertyDisclosure,
		documents: documents != null ? documents.value : this.documents,
		inventories: inventories != null ? inventories.value : this.inventories,
		propertyOffers: propertyOffers != null ? propertyOffers.value : this.propertyOffers,
		valuations: valuations != null ? valuations.value : this.valuations,
		viewings: viewings != null ? viewings.value : this.viewings,
		quotes: quotes != null ? quotes.value : this.quotes,
		tasks: tasks != null ? tasks.value : this.tasks,
		taxDepreciations: taxDepreciations != null ? taxDepreciations.value : this.taxDepreciations,
		tenantApplications: tenantApplications != null ? tenantApplications.value : this.tenantApplications,
		vacationRental: vacationRental != null ? vacationRental.value : this.vacationRental,
		virtualTours: virtualTours != null ? virtualTours.value : this.virtualTours,
		videoContents: videoContents != null ? videoContents.value : this.videoContents,
		agents: agents != null ? agents.value : this.agents,
		extraCharges: extraCharges != null ? extraCharges.value : this.extraCharges,
		currencies: currencies != null ? currencies.value : this.currencies,
		hashtags: hashtags != null ? hashtags.value : this.hashtags,
		guests: guests != null ? guests.value : this.guests,
		agencies: agencies != null ? agencies.value : this.agencies,
		includedServices: includedServices != null ? includedServices.value : this.includedServices,
		pricingRules: pricingRules != null ? pricingRules.value : this.pricingRules,
		discounts: discounts != null ? discounts.value : this.discounts,
		propertyPhotos: propertyPhotos != null ? propertyPhotos.value : this.propertyPhotos,
		analytics: analytics != null ? analytics.value : this.analytics,
		availabilities: availabilities != null ? availabilities.value : this.availabilities,
		complianceRecords: complianceRecords != null ? complianceRecords.value : this.complianceRecords,
		expenses: expenses != null ? expenses.value : this.expenses,
		favorites: favorites != null ? favorites.value : this.favorites,
		increases: increases != null ? increases.value : this.increases,
		mentions: mentions != null ? mentions.value : this.mentions,
		mortgages: mortgages != null ? mortgages.value : this.mortgages,
		offers: offers != null ? offers.value : this.offers,
		payments: payments != null ? payments.value : this.payments,
		photos: photos != null ? photos.value : this.photos,
		propertyPromotions: propertyPromotions != null ? propertyPromotions.value : this.propertyPromotions,
		tenants: tenants != null ? tenants.value : this.tenants,
		includedServiceRelations: includedServiceRelations != null ? includedServiceRelations.value : this.includedServiceRelations,
		$accessibilityFeaturesCount: $accessibilityFeaturesCount ?? this.$accessibilityFeaturesCount,
		$smartHomeFeaturesCount: $smartHomeFeaturesCount ?? this.$smartHomeFeaturesCount,
		$securityFeaturesCount: $securityFeaturesCount ?? this.$securityFeaturesCount,
		$outdoorFeaturesCount: $outdoorFeaturesCount ?? this.$outdoorFeaturesCount,
		$environmentalHazardsCount: $environmentalHazardsCount ?? this.$environmentalHazardsCount,
		$aiImageAnalysesCount: $aiImageAnalysesCount ?? this.$aiImageAnalysesCount,
		$aiInvestmentsCount: $aiInvestmentsCount ?? this.$aiInvestmentsCount,
		$aiMaintenanceCount: $aiMaintenanceCount ?? this.$aiMaintenanceCount,
		$aiDescriptionsCount: $aiDescriptionsCount ?? this.$aiDescriptionsCount,
		$aiValuationsCount: $aiValuationsCount ?? this.$aiValuationsCount,
		$appointmentsCount: $appointmentsCount ?? this.$appointmentsCount,
		$attachmentsCount: $attachmentsCount ?? this.$attachmentsCount,
		$contractsCount: $contractsCount ?? this.$contractsCount,
		$dealsCount: $dealsCount ?? this.$dealsCount,
		$generalDocumentsCount: $generalDocumentsCount ?? this.$generalDocumentsCount,
		$eventsCount: $eventsCount ?? this.$eventsCount,
		$facilitiesCount: $facilitiesCount ?? this.$facilitiesCount,
		$financialRecordsCount: $financialRecordsCount ?? this.$financialRecordsCount,
		$floorPlansCount: $floorPlansCount ?? this.$floorPlansCount,
		$guestReviewsCount: $guestReviewsCount ?? this.$guestReviewsCount,
		$investorPropertiesCount: $investorPropertiesCount ?? this.$investorPropertiesCount,
		$keysCount: $keysCount ?? this.$keysCount,
		$leadsCount: $leadsCount ?? this.$leadsCount,
		$ledgerCount: $ledgerCount ?? this.$ledgerCount,
		$listingsCount: $listingsCount ?? this.$listingsCount,
		$maintenanceBlocksCount: $maintenanceBlocksCount ?? this.$maintenanceBlocksCount,
		$workOrdersCount: $workOrdersCount ?? this.$workOrdersCount,
		$mortgageOffersCount: $mortgageOffersCount ?? this.$mortgageOffersCount,
		$projectsCount: $projectsCount ?? this.$projectsCount,
		$amenitiesCount: $amenitiesCount ?? this.$amenitiesCount,
		$complianceCount: $complianceCount ?? this.$complianceCount,
		$documentsCount: $documentsCount ?? this.$documentsCount,
		$inventoriesCount: $inventoriesCount ?? this.$inventoriesCount,
		$propertyOffersCount: $propertyOffersCount ?? this.$propertyOffersCount,
		$valuationsCount: $valuationsCount ?? this.$valuationsCount,
		$viewingsCount: $viewingsCount ?? this.$viewingsCount,
		$quotesCount: $quotesCount ?? this.$quotesCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$taxDepreciationsCount: $taxDepreciationsCount ?? this.$taxDepreciationsCount,
		$tenantApplicationsCount: $tenantApplicationsCount ?? this.$tenantApplicationsCount,
		$virtualToursCount: $virtualToursCount ?? this.$virtualToursCount,
		$videoContentsCount: $videoContentsCount ?? this.$videoContentsCount,
		$agentsCount: $agentsCount ?? this.$agentsCount,
		$extraChargesCount: $extraChargesCount ?? this.$extraChargesCount,
		$currenciesCount: $currenciesCount ?? this.$currenciesCount,
		$hashtagsCount: $hashtagsCount ?? this.$hashtagsCount,
		$guestsCount: $guestsCount ?? this.$guestsCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$includedServicesCount: $includedServicesCount ?? this.$includedServicesCount,
		$pricingRulesCount: $pricingRulesCount ?? this.$pricingRulesCount,
		$discountsCount: $discountsCount ?? this.$discountsCount,
		$propertyPhotosCount: $propertyPhotosCount ?? this.$propertyPhotosCount,
		$analyticsCount: $analyticsCount ?? this.$analyticsCount,
		$availabilitiesCount: $availabilitiesCount ?? this.$availabilitiesCount,
		$complianceRecordsCount: $complianceRecordsCount ?? this.$complianceRecordsCount,
		$expensesCount: $expensesCount ?? this.$expensesCount,
		$favoritesCount: $favoritesCount ?? this.$favoritesCount,
		$increasesCount: $increasesCount ?? this.$increasesCount,
		$mentionsCount: $mentionsCount ?? this.$mentionsCount,
		$mortgagesCount: $mortgagesCount ?? this.$mortgagesCount,
		$offersCount: $offersCount ?? this.$offersCount,
		$paymentsCount: $paymentsCount ?? this.$paymentsCount,
		$photosCount: $photosCount ?? this.$photosCount,
		$propertyPromotionsCount: $propertyPromotionsCount ?? this.$propertyPromotionsCount,
		$tenantsCount: $tenantsCount ?? this.$tenantsCount,
		$includedServiceRelationsCount: $includedServiceRelationsCount ?? this.$includedServiceRelationsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Property copyWithInstanceValues(Property property) {
        return Property(
            id: property.id ?? id,
		orgId: property.orgId ?? orgId,
		type: property.type ?? type,
		name: property.name ?? name,
		region: property.region ?? region,
		currency: property.currency ?? currency,
		addressLine1: property.addressLine1 ?? addressLine1,
		addressLine2: property.addressLine2 ?? addressLine2,
		city: property.city ?? city,
		state: property.state ?? state,
		zip: property.zip ?? zip,
		country: property.country ?? country,
		lat: property.lat ?? lat,
		lng: property.lng ?? lng,
		neighborhoodId: property.neighborhoodId ?? neighborhoodId,
		bedrooms: property.bedrooms ?? bedrooms,
		bathrooms: property.bathrooms ?? bathrooms,
		areaSqm: property.areaSqm ?? areaSqm,
		yearBuilt: property.yearBuilt ?? yearBuilt,
		notes: property.notes ?? notes,
		locationId: property.locationId ?? locationId,
		stateCode: property.stateCode ?? stateCode,
		propertyCategory: property.propertyCategory ?? propertyCategory,
		listingType: property.listingType ?? listingType,
		listingStatus: property.listingStatus ?? listingStatus,
		listingPrice: property.listingPrice ?? listingPrice,
		originalPrice: property.originalPrice ?? originalPrice,
		priceHistory: property.priceHistory ?? priceHistory,
		schoolDistrict: property.schoolDistrict ?? schoolDistrict,
		hoaFee: property.hoaFee ?? hoaFee,
		hoaFeeFrequency: property.hoaFeeFrequency ?? hoaFeeFrequency,
		propertyTaxRate: property.propertyTaxRate ?? propertyTaxRate,
		lastAssessmentValue: property.lastAssessmentValue ?? lastAssessmentValue,
		lastAssessmentYear: property.lastAssessmentYear ?? lastAssessmentYear,
		floodZone: property.floodZone ?? floodZone,
		zoningCode: property.zoningCode ?? zoningCode,
		lotSizeAcres: property.lotSizeAcres ?? lotSizeAcres,
		frontageFeet: property.frontageFeet ?? frontageFeet,
		depthFeet: property.depthFeet ?? depthFeet,
		basementType: property.basementType ?? basementType,
		basementFinishedSqFt: property.basementFinishedSqFt ?? basementFinishedSqFt,
		garageType: property.garageType ?? garageType,
		garageCapacity: property.garageCapacity ?? garageCapacity,
		parkingSpaces: property.parkingSpaces ?? parkingSpaces,
		parkingType: property.parkingType ?? parkingType,
		poolType: property.poolType ?? poolType,
		heatingType: property.heatingType ?? heatingType,
		coolingType: property.coolingType ?? coolingType,
		fireplaceType: property.fireplaceType ?? fireplaceType,
		fireplaceCount: property.fireplaceCount ?? fireplaceCount,
		viewType: property.viewType ?? viewType,
		waterfrontType: property.waterfrontType ?? waterfrontType,
		waterfrontFeet: property.waterfrontFeet ?? waterfrontFeet,
		constructionType: property.constructionType ?? constructionType,
		roofType: property.roofType ?? roofType,
		roofYear: property.roofYear ?? roofYear,
		sidingType: property.sidingType ?? sidingType,
		zipPlus4: property.zipPlus4 ?? zipPlus4,
		countyFIPS: property.countyFIPS ?? countyFIPS,
		censusTract: property.censusTract ?? censusTract,
		mlsArea: property.mlsArea ?? mlsArea,
		propertyClass: property.propertyClass ?? propertyClass,
		buildingClass: property.buildingClass ?? buildingClass,
		totalRooms: property.totalRooms ?? totalRooms,
		livingAreaSqFt: property.livingAreaSqFt ?? livingAreaSqFt,
		lotSizeSqFt: property.lotSizeSqFt ?? lotSizeSqFt,
		stories: property.stories ?? stories,
		unitsPerBuilding: property.unitsPerBuilding ?? unitsPerBuilding,
		assessedValue: property.assessedValue ?? assessedValue,
		marketValue: property.marketValue ?? marketValue,
		propertyTax: property.propertyTax ?? propertyTax,
		insuranceAmount: property.insuranceAmount ?? insuranceAmount,
		mortgageBalance: property.mortgageBalance ?? mortgageBalance,
		lienAmount: property.lienAmount ?? lienAmount,
		electricityProvider: property.electricityProvider ?? electricityProvider,
		gasProvider: property.gasProvider ?? gasProvider,
		waterProvider: property.waterProvider ?? waterProvider,
		internetProvider: property.internetProvider ?? internetProvider,
		trashService: property.trashService ?? trashService,
		mlsNumber: property.mlsNumber ?? mlsNumber,
		mlsStatus: property.mlsStatus ?? mlsStatus,
		daysOnMarket: property.daysOnMarket ?? daysOnMarket,
		pricePerSqFt: property.pricePerSqFt ?? pricePerSqFt,
		rentalYield: property.rentalYield ?? rentalYield,
		yearRenovated: property.yearRenovated ?? yearRenovated,
		energyRating: property.energyRating ?? energyRating,
		accessibilityFeatures: property.accessibilityFeatures ?? accessibilityFeatures,
		smartHomeFeatures: property.smartHomeFeatures ?? smartHomeFeatures,
		securityFeatures: property.securityFeatures ?? securityFeatures,
		outdoorFeatures: property.outdoorFeatures ?? outdoorFeatures,
		zoningDescription: property.zoningDescription ?? zoningDescription,
		landUse: property.landUse ?? landUse,
		buildingRestrictions: property.buildingRestrictions ?? buildingRestrictions,
		futureDevelopment: property.futureDevelopment ?? futureDevelopment,
		leadPaintCompliance: property.leadPaintCompliance ?? leadPaintCompliance,
		moldInspectionDate: property.moldInspectionDate ?? moldInspectionDate,
		asbestosInspectionDate: property.asbestosInspectionDate ?? asbestosInspectionDate,
		radonTestDate: property.radonTestDate ?? radonTestDate,
		pestControlDate: property.pestControlDate ?? pestControlDate,
		fireInspectionDate: property.fireInspectionDate ?? fireInspectionDate,
		elevatorInspectionDate: property.elevatorInspectionDate ?? elevatorInspectionDate,
		poolInspectionDate: property.poolInspectionDate ?? poolInspectionDate,
		lastCodeComplianceDate: property.lastCodeComplianceDate ?? lastCodeComplianceDate,
		accessibilityCompliance: property.accessibilityCompliance ?? accessibilityCompliance,
		environmentalHazards: property.environmentalHazards ?? environmentalHazards,
		createdBy: property.createdBy ?? createdBy,
		createdAt: property.createdAt ?? createdAt,
		updatedAt: property.updatedAt ?? updatedAt,
		deletedAt: property.deletedAt ?? deletedAt,
		aiImageAnalyses: property.aiImageAnalyses ?? aiImageAnalyses,
		aiInvestments: property.aiInvestments ?? aiInvestments,
		aiMaintenance: property.aiMaintenance ?? aiMaintenance,
		aiDescriptions: property.aiDescriptions ?? aiDescriptions,
		aiValuations: property.aiValuations ?? aiValuations,
		appointments: property.appointments ?? appointments,
		attachments: property.attachments ?? attachments,
		contracts: property.contracts ?? contracts,
		deals: property.deals ?? deals,
		generalDocuments: property.generalDocuments ?? generalDocuments,
		events: property.events ?? events,
		facilities: property.facilities ?? facilities,
		financialRecords: property.financialRecords ?? financialRecords,
		floorPlans: property.floorPlans ?? floorPlans,
		guestReviews: property.guestReviews ?? guestReviews,
		homeInformationPack: property.homeInformationPack ?? homeInformationPack,
		investorProperties: property.investorProperties ?? investorProperties,
		keys: property.keys ?? keys,
		leads: property.leads ?? leads,
		ledger: property.ledger ?? ledger,
		listings: property.listings ?? listings,
		maintenanceBlocks: property.maintenanceBlocks ?? maintenanceBlocks,
		workOrders: property.workOrders ?? workOrders,
		mortgageOffers: property.mortgageOffers ?? mortgageOffers,
		projects: property.projects ?? projects,
		location: property.location ?? location,
		neighborhood: property.neighborhood ?? neighborhood,
		org: property.org ?? org,
		amenities: property.amenities ?? amenities,
		compliance: property.compliance ?? compliance,
		propertyDisclosure: property.propertyDisclosure ?? propertyDisclosure,
		documents: property.documents ?? documents,
		inventories: property.inventories ?? inventories,
		propertyOffers: property.propertyOffers ?? propertyOffers,
		valuations: property.valuations ?? valuations,
		viewings: property.viewings ?? viewings,
		quotes: property.quotes ?? quotes,
		tasks: property.tasks ?? tasks,
		taxDepreciations: property.taxDepreciations ?? taxDepreciations,
		tenantApplications: property.tenantApplications ?? tenantApplications,
		vacationRental: property.vacationRental ?? vacationRental,
		virtualTours: property.virtualTours ?? virtualTours,
		videoContents: property.videoContents ?? videoContents,
		agents: property.agents ?? agents,
		extraCharges: property.extraCharges ?? extraCharges,
		currencies: property.currencies ?? currencies,
		hashtags: property.hashtags ?? hashtags,
		guests: property.guests ?? guests,
		agencies: property.agencies ?? agencies,
		includedServices: property.includedServices ?? includedServices,
		pricingRules: property.pricingRules ?? pricingRules,
		discounts: property.discounts ?? discounts,
		propertyPhotos: property.propertyPhotos ?? propertyPhotos,
		analytics: property.analytics ?? analytics,
		availabilities: property.availabilities ?? availabilities,
		complianceRecords: property.complianceRecords ?? complianceRecords,
		expenses: property.expenses ?? expenses,
		favorites: property.favorites ?? favorites,
		increases: property.increases ?? increases,
		mentions: property.mentions ?? mentions,
		mortgages: property.mortgages ?? mortgages,
		offers: property.offers ?? offers,
		payments: property.payments ?? payments,
		photos: property.photos ?? photos,
		propertyPromotions: property.propertyPromotions ?? propertyPromotions,
		tenants: property.tenants ?? tenants,
		includedServiceRelations: property.includedServiceRelations ?? includedServiceRelations,
		$accessibilityFeaturesCount: property.$accessibilityFeaturesCount ?? $accessibilityFeaturesCount,
		$smartHomeFeaturesCount: property.$smartHomeFeaturesCount ?? $smartHomeFeaturesCount,
		$securityFeaturesCount: property.$securityFeaturesCount ?? $securityFeaturesCount,
		$outdoorFeaturesCount: property.$outdoorFeaturesCount ?? $outdoorFeaturesCount,
		$environmentalHazardsCount: property.$environmentalHazardsCount ?? $environmentalHazardsCount,
		$aiImageAnalysesCount: property.$aiImageAnalysesCount ?? $aiImageAnalysesCount,
		$aiInvestmentsCount: property.$aiInvestmentsCount ?? $aiInvestmentsCount,
		$aiMaintenanceCount: property.$aiMaintenanceCount ?? $aiMaintenanceCount,
		$aiDescriptionsCount: property.$aiDescriptionsCount ?? $aiDescriptionsCount,
		$aiValuationsCount: property.$aiValuationsCount ?? $aiValuationsCount,
		$appointmentsCount: property.$appointmentsCount ?? $appointmentsCount,
		$attachmentsCount: property.$attachmentsCount ?? $attachmentsCount,
		$contractsCount: property.$contractsCount ?? $contractsCount,
		$dealsCount: property.$dealsCount ?? $dealsCount,
		$generalDocumentsCount: property.$generalDocumentsCount ?? $generalDocumentsCount,
		$eventsCount: property.$eventsCount ?? $eventsCount,
		$facilitiesCount: property.$facilitiesCount ?? $facilitiesCount,
		$financialRecordsCount: property.$financialRecordsCount ?? $financialRecordsCount,
		$floorPlansCount: property.$floorPlansCount ?? $floorPlansCount,
		$guestReviewsCount: property.$guestReviewsCount ?? $guestReviewsCount,
		$investorPropertiesCount: property.$investorPropertiesCount ?? $investorPropertiesCount,
		$keysCount: property.$keysCount ?? $keysCount,
		$leadsCount: property.$leadsCount ?? $leadsCount,
		$ledgerCount: property.$ledgerCount ?? $ledgerCount,
		$listingsCount: property.$listingsCount ?? $listingsCount,
		$maintenanceBlocksCount: property.$maintenanceBlocksCount ?? $maintenanceBlocksCount,
		$workOrdersCount: property.$workOrdersCount ?? $workOrdersCount,
		$mortgageOffersCount: property.$mortgageOffersCount ?? $mortgageOffersCount,
		$projectsCount: property.$projectsCount ?? $projectsCount,
		$amenitiesCount: property.$amenitiesCount ?? $amenitiesCount,
		$complianceCount: property.$complianceCount ?? $complianceCount,
		$documentsCount: property.$documentsCount ?? $documentsCount,
		$inventoriesCount: property.$inventoriesCount ?? $inventoriesCount,
		$propertyOffersCount: property.$propertyOffersCount ?? $propertyOffersCount,
		$valuationsCount: property.$valuationsCount ?? $valuationsCount,
		$viewingsCount: property.$viewingsCount ?? $viewingsCount,
		$quotesCount: property.$quotesCount ?? $quotesCount,
		$tasksCount: property.$tasksCount ?? $tasksCount,
		$taxDepreciationsCount: property.$taxDepreciationsCount ?? $taxDepreciationsCount,
		$tenantApplicationsCount: property.$tenantApplicationsCount ?? $tenantApplicationsCount,
		$virtualToursCount: property.$virtualToursCount ?? $virtualToursCount,
		$videoContentsCount: property.$videoContentsCount ?? $videoContentsCount,
		$agentsCount: property.$agentsCount ?? $agentsCount,
		$extraChargesCount: property.$extraChargesCount ?? $extraChargesCount,
		$currenciesCount: property.$currenciesCount ?? $currenciesCount,
		$hashtagsCount: property.$hashtagsCount ?? $hashtagsCount,
		$guestsCount: property.$guestsCount ?? $guestsCount,
		$agenciesCount: property.$agenciesCount ?? $agenciesCount,
		$includedServicesCount: property.$includedServicesCount ?? $includedServicesCount,
		$pricingRulesCount: property.$pricingRulesCount ?? $pricingRulesCount,
		$discountsCount: property.$discountsCount ?? $discountsCount,
		$propertyPhotosCount: property.$propertyPhotosCount ?? $propertyPhotosCount,
		$analyticsCount: property.$analyticsCount ?? $analyticsCount,
		$availabilitiesCount: property.$availabilitiesCount ?? $availabilitiesCount,
		$complianceRecordsCount: property.$complianceRecordsCount ?? $complianceRecordsCount,
		$expensesCount: property.$expensesCount ?? $expensesCount,
		$favoritesCount: property.$favoritesCount ?? $favoritesCount,
		$increasesCount: property.$increasesCount ?? $increasesCount,
		$mentionsCount: property.$mentionsCount ?? $mentionsCount,
		$mortgagesCount: property.$mortgagesCount ?? $mortgagesCount,
		$offersCount: property.$offersCount ?? $offersCount,
		$paymentsCount: property.$paymentsCount ?? $paymentsCount,
		$photosCount: property.$photosCount ?? $photosCount,
		$propertyPromotionsCount: property.$propertyPromotionsCount ?? $propertyPromotionsCount,
		$tenantsCount: property.$tenantsCount ?? $tenantsCount,
		$includedServiceRelationsCount: property.$includedServiceRelationsCount ?? $includedServiceRelationsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Property mergeWithInstanceValues(Property property) {
        return Property(
            id: property.$assignedFields.contains('id') ? property.id : id,
		orgId: property.$assignedFields.contains('orgId') ? property.orgId : orgId,
		type: property.$assignedFields.contains('type') ? property.type : type,
		name: property.$assignedFields.contains('name') ? property.name : name,
		region: property.$assignedFields.contains('region') ? property.region : region,
		currency: property.$assignedFields.contains('currency') ? property.currency : currency,
		addressLine1: property.$assignedFields.contains('addressLine1') ? property.addressLine1 : addressLine1,
		addressLine2: property.$assignedFields.contains('addressLine2') ? property.addressLine2 : addressLine2,
		city: property.$assignedFields.contains('city') ? property.city : city,
		state: property.$assignedFields.contains('state') ? property.state : state,
		zip: property.$assignedFields.contains('zip') ? property.zip : zip,
		country: property.$assignedFields.contains('country') ? property.country : country,
		lat: property.$assignedFields.contains('lat') ? property.lat : lat,
		lng: property.$assignedFields.contains('lng') ? property.lng : lng,
		neighborhoodId: property.$assignedFields.contains('neighborhoodId') ? property.neighborhoodId : neighborhoodId,
		bedrooms: property.$assignedFields.contains('bedrooms') ? property.bedrooms : bedrooms,
		bathrooms: property.$assignedFields.contains('bathrooms') ? property.bathrooms : bathrooms,
		areaSqm: property.$assignedFields.contains('areaSqm') ? property.areaSqm : areaSqm,
		yearBuilt: property.$assignedFields.contains('yearBuilt') ? property.yearBuilt : yearBuilt,
		notes: property.$assignedFields.contains('notes') ? property.notes : notes,
		locationId: property.$assignedFields.contains('locationId') ? property.locationId : locationId,
		stateCode: property.$assignedFields.contains('stateCode') ? property.stateCode : stateCode,
		propertyCategory: property.$assignedFields.contains('propertyCategory') ? property.propertyCategory : propertyCategory,
		listingType: property.$assignedFields.contains('listingType') ? property.listingType : listingType,
		listingStatus: property.$assignedFields.contains('listingStatus') ? property.listingStatus : listingStatus,
		listingPrice: property.$assignedFields.contains('listingPrice') ? property.listingPrice : listingPrice,
		originalPrice: property.$assignedFields.contains('originalPrice') ? property.originalPrice : originalPrice,
		priceHistory: property.$assignedFields.contains('priceHistory') ? property.priceHistory : priceHistory,
		schoolDistrict: property.$assignedFields.contains('schoolDistrict') ? property.schoolDistrict : schoolDistrict,
		hoaFee: property.$assignedFields.contains('hoaFee') ? property.hoaFee : hoaFee,
		hoaFeeFrequency: property.$assignedFields.contains('hoaFeeFrequency') ? property.hoaFeeFrequency : hoaFeeFrequency,
		propertyTaxRate: property.$assignedFields.contains('propertyTaxRate') ? property.propertyTaxRate : propertyTaxRate,
		lastAssessmentValue: property.$assignedFields.contains('lastAssessmentValue') ? property.lastAssessmentValue : lastAssessmentValue,
		lastAssessmentYear: property.$assignedFields.contains('lastAssessmentYear') ? property.lastAssessmentYear : lastAssessmentYear,
		floodZone: property.$assignedFields.contains('floodZone') ? property.floodZone : floodZone,
		zoningCode: property.$assignedFields.contains('zoningCode') ? property.zoningCode : zoningCode,
		lotSizeAcres: property.$assignedFields.contains('lotSizeAcres') ? property.lotSizeAcres : lotSizeAcres,
		frontageFeet: property.$assignedFields.contains('frontageFeet') ? property.frontageFeet : frontageFeet,
		depthFeet: property.$assignedFields.contains('depthFeet') ? property.depthFeet : depthFeet,
		basementType: property.$assignedFields.contains('basementType') ? property.basementType : basementType,
		basementFinishedSqFt: property.$assignedFields.contains('basementFinishedSqFt') ? property.basementFinishedSqFt : basementFinishedSqFt,
		garageType: property.$assignedFields.contains('garageType') ? property.garageType : garageType,
		garageCapacity: property.$assignedFields.contains('garageCapacity') ? property.garageCapacity : garageCapacity,
		parkingSpaces: property.$assignedFields.contains('parkingSpaces') ? property.parkingSpaces : parkingSpaces,
		parkingType: property.$assignedFields.contains('parkingType') ? property.parkingType : parkingType,
		poolType: property.$assignedFields.contains('poolType') ? property.poolType : poolType,
		heatingType: property.$assignedFields.contains('heatingType') ? property.heatingType : heatingType,
		coolingType: property.$assignedFields.contains('coolingType') ? property.coolingType : coolingType,
		fireplaceType: property.$assignedFields.contains('fireplaceType') ? property.fireplaceType : fireplaceType,
		fireplaceCount: property.$assignedFields.contains('fireplaceCount') ? property.fireplaceCount : fireplaceCount,
		viewType: property.$assignedFields.contains('viewType') ? property.viewType : viewType,
		waterfrontType: property.$assignedFields.contains('waterfrontType') ? property.waterfrontType : waterfrontType,
		waterfrontFeet: property.$assignedFields.contains('waterfrontFeet') ? property.waterfrontFeet : waterfrontFeet,
		constructionType: property.$assignedFields.contains('constructionType') ? property.constructionType : constructionType,
		roofType: property.$assignedFields.contains('roofType') ? property.roofType : roofType,
		roofYear: property.$assignedFields.contains('roofYear') ? property.roofYear : roofYear,
		sidingType: property.$assignedFields.contains('sidingType') ? property.sidingType : sidingType,
		zipPlus4: property.$assignedFields.contains('zipPlus4') ? property.zipPlus4 : zipPlus4,
		countyFIPS: property.$assignedFields.contains('countyFIPS') ? property.countyFIPS : countyFIPS,
		censusTract: property.$assignedFields.contains('censusTract') ? property.censusTract : censusTract,
		mlsArea: property.$assignedFields.contains('mlsArea') ? property.mlsArea : mlsArea,
		propertyClass: property.$assignedFields.contains('propertyClass') ? property.propertyClass : propertyClass,
		buildingClass: property.$assignedFields.contains('buildingClass') ? property.buildingClass : buildingClass,
		totalRooms: property.$assignedFields.contains('totalRooms') ? property.totalRooms : totalRooms,
		livingAreaSqFt: property.$assignedFields.contains('livingAreaSqFt') ? property.livingAreaSqFt : livingAreaSqFt,
		lotSizeSqFt: property.$assignedFields.contains('lotSizeSqFt') ? property.lotSizeSqFt : lotSizeSqFt,
		stories: property.$assignedFields.contains('stories') ? property.stories : stories,
		unitsPerBuilding: property.$assignedFields.contains('unitsPerBuilding') ? property.unitsPerBuilding : unitsPerBuilding,
		assessedValue: property.$assignedFields.contains('assessedValue') ? property.assessedValue : assessedValue,
		marketValue: property.$assignedFields.contains('marketValue') ? property.marketValue : marketValue,
		propertyTax: property.$assignedFields.contains('propertyTax') ? property.propertyTax : propertyTax,
		insuranceAmount: property.$assignedFields.contains('insuranceAmount') ? property.insuranceAmount : insuranceAmount,
		mortgageBalance: property.$assignedFields.contains('mortgageBalance') ? property.mortgageBalance : mortgageBalance,
		lienAmount: property.$assignedFields.contains('lienAmount') ? property.lienAmount : lienAmount,
		electricityProvider: property.$assignedFields.contains('electricityProvider') ? property.electricityProvider : electricityProvider,
		gasProvider: property.$assignedFields.contains('gasProvider') ? property.gasProvider : gasProvider,
		waterProvider: property.$assignedFields.contains('waterProvider') ? property.waterProvider : waterProvider,
		internetProvider: property.$assignedFields.contains('internetProvider') ? property.internetProvider : internetProvider,
		trashService: property.$assignedFields.contains('trashService') ? property.trashService : trashService,
		mlsNumber: property.$assignedFields.contains('mlsNumber') ? property.mlsNumber : mlsNumber,
		mlsStatus: property.$assignedFields.contains('mlsStatus') ? property.mlsStatus : mlsStatus,
		daysOnMarket: property.$assignedFields.contains('daysOnMarket') ? property.daysOnMarket : daysOnMarket,
		pricePerSqFt: property.$assignedFields.contains('pricePerSqFt') ? property.pricePerSqFt : pricePerSqFt,
		rentalYield: property.$assignedFields.contains('rentalYield') ? property.rentalYield : rentalYield,
		yearRenovated: property.$assignedFields.contains('yearRenovated') ? property.yearRenovated : yearRenovated,
		energyRating: property.$assignedFields.contains('energyRating') ? property.energyRating : energyRating,
		accessibilityFeatures: property.$assignedFields.contains('accessibilityFeatures') ? property.accessibilityFeatures : accessibilityFeatures,
		smartHomeFeatures: property.$assignedFields.contains('smartHomeFeatures') ? property.smartHomeFeatures : smartHomeFeatures,
		securityFeatures: property.$assignedFields.contains('securityFeatures') ? property.securityFeatures : securityFeatures,
		outdoorFeatures: property.$assignedFields.contains('outdoorFeatures') ? property.outdoorFeatures : outdoorFeatures,
		zoningDescription: property.$assignedFields.contains('zoningDescription') ? property.zoningDescription : zoningDescription,
		landUse: property.$assignedFields.contains('landUse') ? property.landUse : landUse,
		buildingRestrictions: property.$assignedFields.contains('buildingRestrictions') ? property.buildingRestrictions : buildingRestrictions,
		futureDevelopment: property.$assignedFields.contains('futureDevelopment') ? property.futureDevelopment : futureDevelopment,
		leadPaintCompliance: property.$assignedFields.contains('leadPaintCompliance') ? property.leadPaintCompliance : leadPaintCompliance,
		moldInspectionDate: property.$assignedFields.contains('moldInspectionDate') ? property.moldInspectionDate : moldInspectionDate,
		asbestosInspectionDate: property.$assignedFields.contains('asbestosInspectionDate') ? property.asbestosInspectionDate : asbestosInspectionDate,
		radonTestDate: property.$assignedFields.contains('radonTestDate') ? property.radonTestDate : radonTestDate,
		pestControlDate: property.$assignedFields.contains('pestControlDate') ? property.pestControlDate : pestControlDate,
		fireInspectionDate: property.$assignedFields.contains('fireInspectionDate') ? property.fireInspectionDate : fireInspectionDate,
		elevatorInspectionDate: property.$assignedFields.contains('elevatorInspectionDate') ? property.elevatorInspectionDate : elevatorInspectionDate,
		poolInspectionDate: property.$assignedFields.contains('poolInspectionDate') ? property.poolInspectionDate : poolInspectionDate,
		lastCodeComplianceDate: property.$assignedFields.contains('lastCodeComplianceDate') ? property.lastCodeComplianceDate : lastCodeComplianceDate,
		accessibilityCompliance: property.$assignedFields.contains('accessibilityCompliance') ? property.accessibilityCompliance : accessibilityCompliance,
		environmentalHazards: property.$assignedFields.contains('environmentalHazards') ? property.environmentalHazards : environmentalHazards,
		createdBy: property.$assignedFields.contains('createdBy') ? property.createdBy : createdBy,
		createdAt: property.$assignedFields.contains('createdAt') ? property.createdAt : createdAt,
		updatedAt: property.$assignedFields.contains('updatedAt') ? property.updatedAt : updatedAt,
		deletedAt: property.$assignedFields.contains('deletedAt') ? property.deletedAt : deletedAt,
		aiImageAnalyses: (property.$assignedFields.contains('aiImageAnalyses') && property.aiImageAnalyses != null) ? mergeModelLists(aiImageAnalyses, property.aiImageAnalyses) : aiImageAnalyses,
		aiInvestments: (property.$assignedFields.contains('aiInvestments') && property.aiInvestments != null) ? mergeModelLists(aiInvestments, property.aiInvestments) : aiInvestments,
		aiMaintenance: (property.$assignedFields.contains('aiMaintenance') && property.aiMaintenance != null) ? mergeModelLists(aiMaintenance, property.aiMaintenance) : aiMaintenance,
		aiDescriptions: (property.$assignedFields.contains('aiDescriptions') && property.aiDescriptions != null) ? mergeModelLists(aiDescriptions, property.aiDescriptions) : aiDescriptions,
		aiValuations: (property.$assignedFields.contains('aiValuations') && property.aiValuations != null) ? mergeModelLists(aiValuations, property.aiValuations) : aiValuations,
		appointments: (property.$assignedFields.contains('appointments') && property.appointments != null) ? mergeModelLists(appointments, property.appointments) : appointments,
		attachments: (property.$assignedFields.contains('attachments') && property.attachments != null) ? mergeModelLists(attachments, property.attachments) : attachments,
		contracts: (property.$assignedFields.contains('contracts') && property.contracts != null) ? mergeModelLists(contracts, property.contracts) : contracts,
		deals: (property.$assignedFields.contains('deals') && property.deals != null) ? mergeModelLists(deals, property.deals) : deals,
		generalDocuments: (property.$assignedFields.contains('generalDocuments') && property.generalDocuments != null) ? mergeModelLists(generalDocuments, property.generalDocuments) : generalDocuments,
		events: (property.$assignedFields.contains('events') && property.events != null) ? mergeModelLists(events, property.events) : events,
		facilities: (property.$assignedFields.contains('facilities') && property.facilities != null) ? mergeModelLists(facilities, property.facilities) : facilities,
		financialRecords: (property.$assignedFields.contains('financialRecords') && property.financialRecords != null) ? mergeModelLists(financialRecords, property.financialRecords) : financialRecords,
		floorPlans: (property.$assignedFields.contains('floorPlans') && property.floorPlans != null) ? mergeModelLists(floorPlans, property.floorPlans) : floorPlans,
		guestReviews: (property.$assignedFields.contains('guestReviews') && property.guestReviews != null) ? mergeModelLists(guestReviews, property.guestReviews) : guestReviews,
		homeInformationPack: property.$assignedFields.contains('homeInformationPack') ? property.homeInformationPack : homeInformationPack,
		investorProperties: (property.$assignedFields.contains('investorProperties') && property.investorProperties != null) ? mergeModelLists(investorProperties, property.investorProperties) : investorProperties,
		keys: (property.$assignedFields.contains('keys') && property.keys != null) ? mergeModelLists(keys, property.keys) : keys,
		leads: (property.$assignedFields.contains('leads') && property.leads != null) ? mergeModelLists(leads, property.leads) : leads,
		ledger: (property.$assignedFields.contains('ledger') && property.ledger != null) ? mergeModelLists(ledger, property.ledger) : ledger,
		listings: (property.$assignedFields.contains('listings') && property.listings != null) ? mergeModelLists(listings, property.listings) : listings,
		maintenanceBlocks: (property.$assignedFields.contains('maintenanceBlocks') && property.maintenanceBlocks != null) ? mergeModelLists(maintenanceBlocks, property.maintenanceBlocks) : maintenanceBlocks,
		workOrders: (property.$assignedFields.contains('workOrders') && property.workOrders != null) ? mergeModelLists(workOrders, property.workOrders) : workOrders,
		mortgageOffers: (property.$assignedFields.contains('mortgageOffers') && property.mortgageOffers != null) ? mergeModelLists(mortgageOffers, property.mortgageOffers) : mortgageOffers,
		projects: (property.$assignedFields.contains('projects') && property.projects != null) ? mergeModelLists(projects, property.projects) : projects,
		location: property.$assignedFields.contains('location') ? property.location : location,
		neighborhood: property.$assignedFields.contains('neighborhood') ? property.neighborhood : neighborhood,
		org: property.$assignedFields.contains('org') ? property.org : org,
		amenities: (property.$assignedFields.contains('amenities') && property.amenities != null) ? mergeModelLists(amenities, property.amenities) : amenities,
		compliance: (property.$assignedFields.contains('compliance') && property.compliance != null) ? mergeModelLists(compliance, property.compliance) : compliance,
		propertyDisclosure: property.$assignedFields.contains('propertyDisclosure') ? property.propertyDisclosure : propertyDisclosure,
		documents: (property.$assignedFields.contains('documents') && property.documents != null) ? mergeModelLists(documents, property.documents) : documents,
		inventories: (property.$assignedFields.contains('inventories') && property.inventories != null) ? mergeModelLists(inventories, property.inventories) : inventories,
		propertyOffers: (property.$assignedFields.contains('propertyOffers') && property.propertyOffers != null) ? mergeModelLists(propertyOffers, property.propertyOffers) : propertyOffers,
		valuations: (property.$assignedFields.contains('valuations') && property.valuations != null) ? mergeModelLists(valuations, property.valuations) : valuations,
		viewings: (property.$assignedFields.contains('viewings') && property.viewings != null) ? mergeModelLists(viewings, property.viewings) : viewings,
		quotes: (property.$assignedFields.contains('quotes') && property.quotes != null) ? mergeModelLists(quotes, property.quotes) : quotes,
		tasks: (property.$assignedFields.contains('tasks') && property.tasks != null) ? mergeModelLists(tasks, property.tasks) : tasks,
		taxDepreciations: (property.$assignedFields.contains('taxDepreciations') && property.taxDepreciations != null) ? mergeModelLists(taxDepreciations, property.taxDepreciations) : taxDepreciations,
		tenantApplications: (property.$assignedFields.contains('tenantApplications') && property.tenantApplications != null) ? mergeModelLists(tenantApplications, property.tenantApplications) : tenantApplications,
		vacationRental: property.$assignedFields.contains('vacationRental') ? property.vacationRental : vacationRental,
		virtualTours: (property.$assignedFields.contains('virtualTours') && property.virtualTours != null) ? mergeModelLists(virtualTours, property.virtualTours) : virtualTours,
		videoContents: (property.$assignedFields.contains('videoContents') && property.videoContents != null) ? mergeModelLists(videoContents, property.videoContents) : videoContents,
		agents: (property.$assignedFields.contains('agents') && property.agents != null) ? mergeModelLists(agents, property.agents) : agents,
		extraCharges: (property.$assignedFields.contains('extraCharges') && property.extraCharges != null) ? mergeModelLists(extraCharges, property.extraCharges) : extraCharges,
		currencies: (property.$assignedFields.contains('currencies') && property.currencies != null) ? mergeModelLists(currencies, property.currencies) : currencies,
		hashtags: (property.$assignedFields.contains('hashtags') && property.hashtags != null) ? mergeModelLists(hashtags, property.hashtags) : hashtags,
		guests: (property.$assignedFields.contains('guests') && property.guests != null) ? mergeModelLists(guests, property.guests) : guests,
		agencies: (property.$assignedFields.contains('agencies') && property.agencies != null) ? mergeModelLists(agencies, property.agencies) : agencies,
		includedServices: (property.$assignedFields.contains('includedServices') && property.includedServices != null) ? mergeModelLists(includedServices, property.includedServices) : includedServices,
		pricingRules: (property.$assignedFields.contains('pricingRules') && property.pricingRules != null) ? mergeModelLists(pricingRules, property.pricingRules) : pricingRules,
		discounts: (property.$assignedFields.contains('discounts') && property.discounts != null) ? mergeModelLists(discounts, property.discounts) : discounts,
		propertyPhotos: (property.$assignedFields.contains('propertyPhotos') && property.propertyPhotos != null) ? mergeModelLists(propertyPhotos, property.propertyPhotos) : propertyPhotos,
		analytics: (property.$assignedFields.contains('analytics') && property.analytics != null) ? mergeModelLists(analytics, property.analytics) : analytics,
		availabilities: (property.$assignedFields.contains('availabilities') && property.availabilities != null) ? mergeModelLists(availabilities, property.availabilities) : availabilities,
		complianceRecords: (property.$assignedFields.contains('complianceRecords') && property.complianceRecords != null) ? mergeModelLists(complianceRecords, property.complianceRecords) : complianceRecords,
		expenses: (property.$assignedFields.contains('expenses') && property.expenses != null) ? mergeModelLists(expenses, property.expenses) : expenses,
		favorites: (property.$assignedFields.contains('favorites') && property.favorites != null) ? mergeModelLists(favorites, property.favorites) : favorites,
		increases: (property.$assignedFields.contains('increases') && property.increases != null) ? mergeModelLists(increases, property.increases) : increases,
		mentions: (property.$assignedFields.contains('mentions') && property.mentions != null) ? mergeModelLists(mentions, property.mentions) : mentions,
		mortgages: (property.$assignedFields.contains('mortgages') && property.mortgages != null) ? mergeModelLists(mortgages, property.mortgages) : mortgages,
		offers: (property.$assignedFields.contains('offers') && property.offers != null) ? mergeModelLists(offers, property.offers) : offers,
		payments: (property.$assignedFields.contains('payments') && property.payments != null) ? mergeModelLists(payments, property.payments) : payments,
		photos: (property.$assignedFields.contains('photos') && property.photos != null) ? mergeModelLists(photos, property.photos) : photos,
		propertyPromotions: (property.$assignedFields.contains('propertyPromotions') && property.propertyPromotions != null) ? mergeModelLists(propertyPromotions, property.propertyPromotions) : propertyPromotions,
		tenants: (property.$assignedFields.contains('tenants') && property.tenants != null) ? mergeModelLists(tenants, property.tenants) : tenants,
		includedServiceRelations: (property.$assignedFields.contains('includedServiceRelations') && property.includedServiceRelations != null) ? mergeModelLists(includedServiceRelations, property.includedServiceRelations) : includedServiceRelations,
		$accessibilityFeaturesCount: property.$accessibilityFeaturesCount ?? $accessibilityFeaturesCount,
		$smartHomeFeaturesCount: property.$smartHomeFeaturesCount ?? $smartHomeFeaturesCount,
		$securityFeaturesCount: property.$securityFeaturesCount ?? $securityFeaturesCount,
		$outdoorFeaturesCount: property.$outdoorFeaturesCount ?? $outdoorFeaturesCount,
		$environmentalHazardsCount: property.$environmentalHazardsCount ?? $environmentalHazardsCount,
		$aiImageAnalysesCount: property.$aiImageAnalysesCount ?? $aiImageAnalysesCount,
		$aiInvestmentsCount: property.$aiInvestmentsCount ?? $aiInvestmentsCount,
		$aiMaintenanceCount: property.$aiMaintenanceCount ?? $aiMaintenanceCount,
		$aiDescriptionsCount: property.$aiDescriptionsCount ?? $aiDescriptionsCount,
		$aiValuationsCount: property.$aiValuationsCount ?? $aiValuationsCount,
		$appointmentsCount: property.$appointmentsCount ?? $appointmentsCount,
		$attachmentsCount: property.$attachmentsCount ?? $attachmentsCount,
		$contractsCount: property.$contractsCount ?? $contractsCount,
		$dealsCount: property.$dealsCount ?? $dealsCount,
		$generalDocumentsCount: property.$generalDocumentsCount ?? $generalDocumentsCount,
		$eventsCount: property.$eventsCount ?? $eventsCount,
		$facilitiesCount: property.$facilitiesCount ?? $facilitiesCount,
		$financialRecordsCount: property.$financialRecordsCount ?? $financialRecordsCount,
		$floorPlansCount: property.$floorPlansCount ?? $floorPlansCount,
		$guestReviewsCount: property.$guestReviewsCount ?? $guestReviewsCount,
		$investorPropertiesCount: property.$investorPropertiesCount ?? $investorPropertiesCount,
		$keysCount: property.$keysCount ?? $keysCount,
		$leadsCount: property.$leadsCount ?? $leadsCount,
		$ledgerCount: property.$ledgerCount ?? $ledgerCount,
		$listingsCount: property.$listingsCount ?? $listingsCount,
		$maintenanceBlocksCount: property.$maintenanceBlocksCount ?? $maintenanceBlocksCount,
		$workOrdersCount: property.$workOrdersCount ?? $workOrdersCount,
		$mortgageOffersCount: property.$mortgageOffersCount ?? $mortgageOffersCount,
		$projectsCount: property.$projectsCount ?? $projectsCount,
		$amenitiesCount: property.$amenitiesCount ?? $amenitiesCount,
		$complianceCount: property.$complianceCount ?? $complianceCount,
		$documentsCount: property.$documentsCount ?? $documentsCount,
		$inventoriesCount: property.$inventoriesCount ?? $inventoriesCount,
		$propertyOffersCount: property.$propertyOffersCount ?? $propertyOffersCount,
		$valuationsCount: property.$valuationsCount ?? $valuationsCount,
		$viewingsCount: property.$viewingsCount ?? $viewingsCount,
		$quotesCount: property.$quotesCount ?? $quotesCount,
		$tasksCount: property.$tasksCount ?? $tasksCount,
		$taxDepreciationsCount: property.$taxDepreciationsCount ?? $taxDepreciationsCount,
		$tenantApplicationsCount: property.$tenantApplicationsCount ?? $tenantApplicationsCount,
		$virtualToursCount: property.$virtualToursCount ?? $virtualToursCount,
		$videoContentsCount: property.$videoContentsCount ?? $videoContentsCount,
		$agentsCount: property.$agentsCount ?? $agentsCount,
		$extraChargesCount: property.$extraChargesCount ?? $extraChargesCount,
		$currenciesCount: property.$currenciesCount ?? $currenciesCount,
		$hashtagsCount: property.$hashtagsCount ?? $hashtagsCount,
		$guestsCount: property.$guestsCount ?? $guestsCount,
		$agenciesCount: property.$agenciesCount ?? $agenciesCount,
		$includedServicesCount: property.$includedServicesCount ?? $includedServicesCount,
		$pricingRulesCount: property.$pricingRulesCount ?? $pricingRulesCount,
		$discountsCount: property.$discountsCount ?? $discountsCount,
		$propertyPhotosCount: property.$propertyPhotosCount ?? $propertyPhotosCount,
		$analyticsCount: property.$analyticsCount ?? $analyticsCount,
		$availabilitiesCount: property.$availabilitiesCount ?? $availabilitiesCount,
		$complianceRecordsCount: property.$complianceRecordsCount ?? $complianceRecordsCount,
		$expensesCount: property.$expensesCount ?? $expensesCount,
		$favoritesCount: property.$favoritesCount ?? $favoritesCount,
		$increasesCount: property.$increasesCount ?? $increasesCount,
		$mentionsCount: property.$mentionsCount ?? $mentionsCount,
		$mortgagesCount: property.$mortgagesCount ?? $mortgagesCount,
		$offersCount: property.$offersCount ?? $offersCount,
		$paymentsCount: property.$paymentsCount ?? $paymentsCount,
		$photosCount: property.$photosCount ?? $photosCount,
		$propertyPromotionsCount: property.$propertyPromotionsCount ?? $propertyPromotionsCount,
		$tenantsCount: property.$tenantsCount ?? $tenantsCount,
		$includedServiceRelationsCount: property.$includedServiceRelationsCount ?? $includedServiceRelationsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Property updateWithInstanceValues(Property property) {
        if (property.$assignedFields.contains('id')) { id = property.id; }
		if (property.$assignedFields.contains('orgId')) { orgId = property.orgId; }
		if (property.$assignedFields.contains('type')) { type = property.type; }
		if (property.$assignedFields.contains('name')) { name = property.name; }
		if (property.$assignedFields.contains('region')) { region = property.region; }
		if (property.$assignedFields.contains('currency')) { currency = property.currency; }
		if (property.$assignedFields.contains('addressLine1')) { addressLine1 = property.addressLine1; }
		if (property.$assignedFields.contains('addressLine2')) { addressLine2 = property.addressLine2; }
		if (property.$assignedFields.contains('city')) { city = property.city; }
		if (property.$assignedFields.contains('state')) { state = property.state; }
		if (property.$assignedFields.contains('zip')) { zip = property.zip; }
		if (property.$assignedFields.contains('country')) { country = property.country; }
		if (property.$assignedFields.contains('lat')) { lat = property.lat; }
		if (property.$assignedFields.contains('lng')) { lng = property.lng; }
		if (property.$assignedFields.contains('neighborhoodId')) { neighborhoodId = property.neighborhoodId; }
		if (property.$assignedFields.contains('bedrooms')) { bedrooms = property.bedrooms; }
		if (property.$assignedFields.contains('bathrooms')) { bathrooms = property.bathrooms; }
		if (property.$assignedFields.contains('areaSqm')) { areaSqm = property.areaSqm; }
		if (property.$assignedFields.contains('yearBuilt')) { yearBuilt = property.yearBuilt; }
		if (property.$assignedFields.contains('notes')) { notes = property.notes; }
		if (property.$assignedFields.contains('locationId')) { locationId = property.locationId; }
		if (property.$assignedFields.contains('stateCode')) { stateCode = property.stateCode; }
		if (property.$assignedFields.contains('propertyCategory')) { propertyCategory = property.propertyCategory; }
		if (property.$assignedFields.contains('listingType')) { listingType = property.listingType; }
		if (property.$assignedFields.contains('listingStatus')) { listingStatus = property.listingStatus; }
		if (property.$assignedFields.contains('listingPrice')) { listingPrice = property.listingPrice; }
		if (property.$assignedFields.contains('originalPrice')) { originalPrice = property.originalPrice; }
		if (property.$assignedFields.contains('priceHistory')) { priceHistory = property.priceHistory; }
		if (property.$assignedFields.contains('schoolDistrict')) { schoolDistrict = property.schoolDistrict; }
		if (property.$assignedFields.contains('hoaFee')) { hoaFee = property.hoaFee; }
		if (property.$assignedFields.contains('hoaFeeFrequency')) { hoaFeeFrequency = property.hoaFeeFrequency; }
		if (property.$assignedFields.contains('propertyTaxRate')) { propertyTaxRate = property.propertyTaxRate; }
		if (property.$assignedFields.contains('lastAssessmentValue')) { lastAssessmentValue = property.lastAssessmentValue; }
		if (property.$assignedFields.contains('lastAssessmentYear')) { lastAssessmentYear = property.lastAssessmentYear; }
		if (property.$assignedFields.contains('floodZone')) { floodZone = property.floodZone; }
		if (property.$assignedFields.contains('zoningCode')) { zoningCode = property.zoningCode; }
		if (property.$assignedFields.contains('lotSizeAcres')) { lotSizeAcres = property.lotSizeAcres; }
		if (property.$assignedFields.contains('frontageFeet')) { frontageFeet = property.frontageFeet; }
		if (property.$assignedFields.contains('depthFeet')) { depthFeet = property.depthFeet; }
		if (property.$assignedFields.contains('basementType')) { basementType = property.basementType; }
		if (property.$assignedFields.contains('basementFinishedSqFt')) { basementFinishedSqFt = property.basementFinishedSqFt; }
		if (property.$assignedFields.contains('garageType')) { garageType = property.garageType; }
		if (property.$assignedFields.contains('garageCapacity')) { garageCapacity = property.garageCapacity; }
		if (property.$assignedFields.contains('parkingSpaces')) { parkingSpaces = property.parkingSpaces; }
		if (property.$assignedFields.contains('parkingType')) { parkingType = property.parkingType; }
		if (property.$assignedFields.contains('poolType')) { poolType = property.poolType; }
		if (property.$assignedFields.contains('heatingType')) { heatingType = property.heatingType; }
		if (property.$assignedFields.contains('coolingType')) { coolingType = property.coolingType; }
		if (property.$assignedFields.contains('fireplaceType')) { fireplaceType = property.fireplaceType; }
		if (property.$assignedFields.contains('fireplaceCount')) { fireplaceCount = property.fireplaceCount; }
		if (property.$assignedFields.contains('viewType')) { viewType = property.viewType; }
		if (property.$assignedFields.contains('waterfrontType')) { waterfrontType = property.waterfrontType; }
		if (property.$assignedFields.contains('waterfrontFeet')) { waterfrontFeet = property.waterfrontFeet; }
		if (property.$assignedFields.contains('constructionType')) { constructionType = property.constructionType; }
		if (property.$assignedFields.contains('roofType')) { roofType = property.roofType; }
		if (property.$assignedFields.contains('roofYear')) { roofYear = property.roofYear; }
		if (property.$assignedFields.contains('sidingType')) { sidingType = property.sidingType; }
		if (property.$assignedFields.contains('zipPlus4')) { zipPlus4 = property.zipPlus4; }
		if (property.$assignedFields.contains('countyFIPS')) { countyFIPS = property.countyFIPS; }
		if (property.$assignedFields.contains('censusTract')) { censusTract = property.censusTract; }
		if (property.$assignedFields.contains('mlsArea')) { mlsArea = property.mlsArea; }
		if (property.$assignedFields.contains('propertyClass')) { propertyClass = property.propertyClass; }
		if (property.$assignedFields.contains('buildingClass')) { buildingClass = property.buildingClass; }
		if (property.$assignedFields.contains('totalRooms')) { totalRooms = property.totalRooms; }
		if (property.$assignedFields.contains('livingAreaSqFt')) { livingAreaSqFt = property.livingAreaSqFt; }
		if (property.$assignedFields.contains('lotSizeSqFt')) { lotSizeSqFt = property.lotSizeSqFt; }
		if (property.$assignedFields.contains('stories')) { stories = property.stories; }
		if (property.$assignedFields.contains('unitsPerBuilding')) { unitsPerBuilding = property.unitsPerBuilding; }
		if (property.$assignedFields.contains('assessedValue')) { assessedValue = property.assessedValue; }
		if (property.$assignedFields.contains('marketValue')) { marketValue = property.marketValue; }
		if (property.$assignedFields.contains('propertyTax')) { propertyTax = property.propertyTax; }
		if (property.$assignedFields.contains('insuranceAmount')) { insuranceAmount = property.insuranceAmount; }
		if (property.$assignedFields.contains('mortgageBalance')) { mortgageBalance = property.mortgageBalance; }
		if (property.$assignedFields.contains('lienAmount')) { lienAmount = property.lienAmount; }
		if (property.$assignedFields.contains('electricityProvider')) { electricityProvider = property.electricityProvider; }
		if (property.$assignedFields.contains('gasProvider')) { gasProvider = property.gasProvider; }
		if (property.$assignedFields.contains('waterProvider')) { waterProvider = property.waterProvider; }
		if (property.$assignedFields.contains('internetProvider')) { internetProvider = property.internetProvider; }
		if (property.$assignedFields.contains('trashService')) { trashService = property.trashService; }
		if (property.$assignedFields.contains('mlsNumber')) { mlsNumber = property.mlsNumber; }
		if (property.$assignedFields.contains('mlsStatus')) { mlsStatus = property.mlsStatus; }
		if (property.$assignedFields.contains('daysOnMarket')) { daysOnMarket = property.daysOnMarket; }
		if (property.$assignedFields.contains('pricePerSqFt')) { pricePerSqFt = property.pricePerSqFt; }
		if (property.$assignedFields.contains('rentalYield')) { rentalYield = property.rentalYield; }
		if (property.$assignedFields.contains('yearRenovated')) { yearRenovated = property.yearRenovated; }
		if (property.$assignedFields.contains('energyRating')) { energyRating = property.energyRating; }
		if (property.$assignedFields.contains('accessibilityFeatures')) { accessibilityFeatures = property.accessibilityFeatures; }
		if (property.$assignedFields.contains('smartHomeFeatures')) { smartHomeFeatures = property.smartHomeFeatures; }
		if (property.$assignedFields.contains('securityFeatures')) { securityFeatures = property.securityFeatures; }
		if (property.$assignedFields.contains('outdoorFeatures')) { outdoorFeatures = property.outdoorFeatures; }
		if (property.$assignedFields.contains('zoningDescription')) { zoningDescription = property.zoningDescription; }
		if (property.$assignedFields.contains('landUse')) { landUse = property.landUse; }
		if (property.$assignedFields.contains('buildingRestrictions')) { buildingRestrictions = property.buildingRestrictions; }
		if (property.$assignedFields.contains('futureDevelopment')) { futureDevelopment = property.futureDevelopment; }
		if (property.$assignedFields.contains('leadPaintCompliance')) { leadPaintCompliance = property.leadPaintCompliance; }
		if (property.$assignedFields.contains('moldInspectionDate')) { moldInspectionDate = property.moldInspectionDate; }
		if (property.$assignedFields.contains('asbestosInspectionDate')) { asbestosInspectionDate = property.asbestosInspectionDate; }
		if (property.$assignedFields.contains('radonTestDate')) { radonTestDate = property.radonTestDate; }
		if (property.$assignedFields.contains('pestControlDate')) { pestControlDate = property.pestControlDate; }
		if (property.$assignedFields.contains('fireInspectionDate')) { fireInspectionDate = property.fireInspectionDate; }
		if (property.$assignedFields.contains('elevatorInspectionDate')) { elevatorInspectionDate = property.elevatorInspectionDate; }
		if (property.$assignedFields.contains('poolInspectionDate')) { poolInspectionDate = property.poolInspectionDate; }
		if (property.$assignedFields.contains('lastCodeComplianceDate')) { lastCodeComplianceDate = property.lastCodeComplianceDate; }
		if (property.$assignedFields.contains('accessibilityCompliance')) { accessibilityCompliance = property.accessibilityCompliance; }
		if (property.$assignedFields.contains('environmentalHazards')) { environmentalHazards = property.environmentalHazards; }
		if (property.$assignedFields.contains('createdBy')) { createdBy = property.createdBy; }
		if (property.$assignedFields.contains('createdAt')) { createdAt = property.createdAt; }
		if (property.$assignedFields.contains('updatedAt')) { updatedAt = property.updatedAt; }
		if (property.$assignedFields.contains('deletedAt')) { deletedAt = property.deletedAt; }
		if (property.$assignedFields.contains('aiImageAnalyses') && property.aiImageAnalyses != null) { aiImageAnalyses = mergeModelLists(aiImageAnalyses, property.aiImageAnalyses); }
		if (property.$assignedFields.contains('aiInvestments') && property.aiInvestments != null) { aiInvestments = mergeModelLists(aiInvestments, property.aiInvestments); }
		if (property.$assignedFields.contains('aiMaintenance') && property.aiMaintenance != null) { aiMaintenance = mergeModelLists(aiMaintenance, property.aiMaintenance); }
		if (property.$assignedFields.contains('aiDescriptions') && property.aiDescriptions != null) { aiDescriptions = mergeModelLists(aiDescriptions, property.aiDescriptions); }
		if (property.$assignedFields.contains('aiValuations') && property.aiValuations != null) { aiValuations = mergeModelLists(aiValuations, property.aiValuations); }
		if (property.$assignedFields.contains('appointments') && property.appointments != null) { appointments = mergeModelLists(appointments, property.appointments); }
		if (property.$assignedFields.contains('attachments') && property.attachments != null) { attachments = mergeModelLists(attachments, property.attachments); }
		if (property.$assignedFields.contains('contracts') && property.contracts != null) { contracts = mergeModelLists(contracts, property.contracts); }
		if (property.$assignedFields.contains('deals') && property.deals != null) { deals = mergeModelLists(deals, property.deals); }
		if (property.$assignedFields.contains('generalDocuments') && property.generalDocuments != null) { generalDocuments = mergeModelLists(generalDocuments, property.generalDocuments); }
		if (property.$assignedFields.contains('events') && property.events != null) { events = mergeModelLists(events, property.events); }
		if (property.$assignedFields.contains('facilities') && property.facilities != null) { facilities = mergeModelLists(facilities, property.facilities); }
		if (property.$assignedFields.contains('financialRecords') && property.financialRecords != null) { financialRecords = mergeModelLists(financialRecords, property.financialRecords); }
		if (property.$assignedFields.contains('floorPlans') && property.floorPlans != null) { floorPlans = mergeModelLists(floorPlans, property.floorPlans); }
		if (property.$assignedFields.contains('guestReviews') && property.guestReviews != null) { guestReviews = mergeModelLists(guestReviews, property.guestReviews); }
		if (property.$assignedFields.contains('homeInformationPack')) { homeInformationPack = property.homeInformationPack; }
		if (property.$assignedFields.contains('investorProperties') && property.investorProperties != null) { investorProperties = mergeModelLists(investorProperties, property.investorProperties); }
		if (property.$assignedFields.contains('keys') && property.keys != null) { keys = mergeModelLists(keys, property.keys); }
		if (property.$assignedFields.contains('leads') && property.leads != null) { leads = mergeModelLists(leads, property.leads); }
		if (property.$assignedFields.contains('ledger') && property.ledger != null) { ledger = mergeModelLists(ledger, property.ledger); }
		if (property.$assignedFields.contains('listings') && property.listings != null) { listings = mergeModelLists(listings, property.listings); }
		if (property.$assignedFields.contains('maintenanceBlocks') && property.maintenanceBlocks != null) { maintenanceBlocks = mergeModelLists(maintenanceBlocks, property.maintenanceBlocks); }
		if (property.$assignedFields.contains('workOrders') && property.workOrders != null) { workOrders = mergeModelLists(workOrders, property.workOrders); }
		if (property.$assignedFields.contains('mortgageOffers') && property.mortgageOffers != null) { mortgageOffers = mergeModelLists(mortgageOffers, property.mortgageOffers); }
		if (property.$assignedFields.contains('projects') && property.projects != null) { projects = mergeModelLists(projects, property.projects); }
		if (property.$assignedFields.contains('location')) { location = property.location; }
		if (property.$assignedFields.contains('neighborhood')) { neighborhood = property.neighborhood; }
		if (property.$assignedFields.contains('org')) { org = property.org; }
		if (property.$assignedFields.contains('amenities') && property.amenities != null) { amenities = mergeModelLists(amenities, property.amenities); }
		if (property.$assignedFields.contains('compliance') && property.compliance != null) { compliance = mergeModelLists(compliance, property.compliance); }
		if (property.$assignedFields.contains('propertyDisclosure')) { propertyDisclosure = property.propertyDisclosure; }
		if (property.$assignedFields.contains('documents') && property.documents != null) { documents = mergeModelLists(documents, property.documents); }
		if (property.$assignedFields.contains('inventories') && property.inventories != null) { inventories = mergeModelLists(inventories, property.inventories); }
		if (property.$assignedFields.contains('propertyOffers') && property.propertyOffers != null) { propertyOffers = mergeModelLists(propertyOffers, property.propertyOffers); }
		if (property.$assignedFields.contains('valuations') && property.valuations != null) { valuations = mergeModelLists(valuations, property.valuations); }
		if (property.$assignedFields.contains('viewings') && property.viewings != null) { viewings = mergeModelLists(viewings, property.viewings); }
		if (property.$assignedFields.contains('quotes') && property.quotes != null) { quotes = mergeModelLists(quotes, property.quotes); }
		if (property.$assignedFields.contains('tasks') && property.tasks != null) { tasks = mergeModelLists(tasks, property.tasks); }
		if (property.$assignedFields.contains('taxDepreciations') && property.taxDepreciations != null) { taxDepreciations = mergeModelLists(taxDepreciations, property.taxDepreciations); }
		if (property.$assignedFields.contains('tenantApplications') && property.tenantApplications != null) { tenantApplications = mergeModelLists(tenantApplications, property.tenantApplications); }
		if (property.$assignedFields.contains('vacationRental')) { vacationRental = property.vacationRental; }
		if (property.$assignedFields.contains('virtualTours') && property.virtualTours != null) { virtualTours = mergeModelLists(virtualTours, property.virtualTours); }
		if (property.$assignedFields.contains('videoContents') && property.videoContents != null) { videoContents = mergeModelLists(videoContents, property.videoContents); }
		if (property.$assignedFields.contains('agents') && property.agents != null) { agents = mergeModelLists(agents, property.agents); }
		if (property.$assignedFields.contains('extraCharges') && property.extraCharges != null) { extraCharges = mergeModelLists(extraCharges, property.extraCharges); }
		if (property.$assignedFields.contains('currencies') && property.currencies != null) { currencies = mergeModelLists(currencies, property.currencies); }
		if (property.$assignedFields.contains('hashtags') && property.hashtags != null) { hashtags = mergeModelLists(hashtags, property.hashtags); }
		if (property.$assignedFields.contains('guests') && property.guests != null) { guests = mergeModelLists(guests, property.guests); }
		if (property.$assignedFields.contains('agencies') && property.agencies != null) { agencies = mergeModelLists(agencies, property.agencies); }
		if (property.$assignedFields.contains('includedServices') && property.includedServices != null) { includedServices = mergeModelLists(includedServices, property.includedServices); }
		if (property.$assignedFields.contains('pricingRules') && property.pricingRules != null) { pricingRules = mergeModelLists(pricingRules, property.pricingRules); }
		if (property.$assignedFields.contains('discounts') && property.discounts != null) { discounts = mergeModelLists(discounts, property.discounts); }
		if (property.$assignedFields.contains('propertyPhotos') && property.propertyPhotos != null) { propertyPhotos = mergeModelLists(propertyPhotos, property.propertyPhotos); }
		if (property.$assignedFields.contains('analytics') && property.analytics != null) { analytics = mergeModelLists(analytics, property.analytics); }
		if (property.$assignedFields.contains('availabilities') && property.availabilities != null) { availabilities = mergeModelLists(availabilities, property.availabilities); }
		if (property.$assignedFields.contains('complianceRecords') && property.complianceRecords != null) { complianceRecords = mergeModelLists(complianceRecords, property.complianceRecords); }
		if (property.$assignedFields.contains('expenses') && property.expenses != null) { expenses = mergeModelLists(expenses, property.expenses); }
		if (property.$assignedFields.contains('favorites') && property.favorites != null) { favorites = mergeModelLists(favorites, property.favorites); }
		if (property.$assignedFields.contains('increases') && property.increases != null) { increases = mergeModelLists(increases, property.increases); }
		if (property.$assignedFields.contains('mentions') && property.mentions != null) { mentions = mergeModelLists(mentions, property.mentions); }
		if (property.$assignedFields.contains('mortgages') && property.mortgages != null) { mortgages = mergeModelLists(mortgages, property.mortgages); }
		if (property.$assignedFields.contains('offers') && property.offers != null) { offers = mergeModelLists(offers, property.offers); }
		if (property.$assignedFields.contains('payments') && property.payments != null) { payments = mergeModelLists(payments, property.payments); }
		if (property.$assignedFields.contains('photos') && property.photos != null) { photos = mergeModelLists(photos, property.photos); }
		if (property.$assignedFields.contains('propertyPromotions') && property.propertyPromotions != null) { propertyPromotions = mergeModelLists(propertyPromotions, property.propertyPromotions); }
		if (property.$assignedFields.contains('tenants') && property.tenants != null) { tenants = mergeModelLists(tenants, property.tenants); }
		if (property.$assignedFields.contains('includedServiceRelations') && property.includedServiceRelations != null) { includedServiceRelations = mergeModelLists(includedServiceRelations, property.includedServiceRelations); }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'Property'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(type != null) 'type': type?.toJson(),
	if(name != null) 'name': name,
	if(region != null) 'region': region?.toJson(),
	if(currency != null) 'currency': currency,
	if(addressLine1 != null) 'addressLine1': addressLine1,
	if(addressLine2 != null) 'addressLine2': addressLine2,
	if(city != null) 'city': city,
	if(state != null) 'state': state,
	if(zip != null) 'zip': zip,
	if(country != null) 'country': country,
	if(lat != null) 'lat': lat,
	if(lng != null) 'lng': lng,
	if(neighborhoodId != null) 'neighborhoodId': neighborhoodId,
	if(bedrooms != null) 'bedrooms': bedrooms,
	if(bathrooms != null) 'bathrooms': bathrooms,
	if(areaSqm != null) 'areaSqm': areaSqm,
	if(yearBuilt != null) 'yearBuilt': yearBuilt,
	if(notes != null) 'notes': notes,
	if(locationId != null) 'locationId': locationId,
	if(stateCode != null) 'stateCode': stateCode?.toJson(),
	if(propertyCategory != null) 'propertyCategory': propertyCategory?.toJson(),
	if(listingType != null) 'listingType': listingType?.toJson(),
	if(listingStatus != null) 'listingStatus': listingStatus?.toJson(),
	if(listingPrice != null) 'listingPrice': listingPrice,
	if(originalPrice != null) 'originalPrice': originalPrice,
	if(priceHistory != null) 'priceHistory': priceHistory,
	if(schoolDistrict != null) 'schoolDistrict': schoolDistrict,
	if(hoaFee != null) 'hoaFee': hoaFee,
	if(hoaFeeFrequency != null) 'hoaFeeFrequency': hoaFeeFrequency,
	if(propertyTaxRate != null) 'propertyTaxRate': propertyTaxRate,
	if(lastAssessmentValue != null) 'lastAssessmentValue': lastAssessmentValue,
	if(lastAssessmentYear != null) 'lastAssessmentYear': lastAssessmentYear,
	if(floodZone != null) 'floodZone': floodZone,
	if(zoningCode != null) 'zoningCode': zoningCode,
	if(lotSizeAcres != null) 'lotSizeAcres': lotSizeAcres,
	if(frontageFeet != null) 'frontageFeet': frontageFeet,
	if(depthFeet != null) 'depthFeet': depthFeet,
	if(basementType != null) 'basementType': basementType,
	if(basementFinishedSqFt != null) 'basementFinishedSqFt': basementFinishedSqFt,
	if(garageType != null) 'garageType': garageType,
	if(garageCapacity != null) 'garageCapacity': garageCapacity,
	if(parkingSpaces != null) 'parkingSpaces': parkingSpaces,
	if(parkingType != null) 'parkingType': parkingType,
	if(poolType != null) 'poolType': poolType,
	if(heatingType != null) 'heatingType': heatingType,
	if(coolingType != null) 'coolingType': coolingType,
	if(fireplaceType != null) 'fireplaceType': fireplaceType,
	if(fireplaceCount != null) 'fireplaceCount': fireplaceCount,
	if(viewType != null) 'viewType': viewType,
	if(waterfrontType != null) 'waterfrontType': waterfrontType,
	if(waterfrontFeet != null) 'waterfrontFeet': waterfrontFeet,
	if(constructionType != null) 'constructionType': constructionType,
	if(roofType != null) 'roofType': roofType,
	if(roofYear != null) 'roofYear': roofYear,
	if(sidingType != null) 'sidingType': sidingType,
	if(zipPlus4 != null) 'zipPlus4': zipPlus4,
	if(countyFIPS != null) 'countyFIPS': countyFIPS,
	if(censusTract != null) 'censusTract': censusTract,
	if(mlsArea != null) 'mlsArea': mlsArea,
	if(propertyClass != null) 'propertyClass': propertyClass,
	if(buildingClass != null) 'buildingClass': buildingClass,
	if(totalRooms != null) 'totalRooms': totalRooms,
	if(livingAreaSqFt != null) 'livingAreaSqFt': livingAreaSqFt,
	if(lotSizeSqFt != null) 'lotSizeSqFt': lotSizeSqFt,
	if(stories != null) 'stories': stories,
	if(unitsPerBuilding != null) 'unitsPerBuilding': unitsPerBuilding,
	if(assessedValue != null) 'assessedValue': assessedValue,
	if(marketValue != null) 'marketValue': marketValue,
	if(propertyTax != null) 'propertyTax': propertyTax,
	if(insuranceAmount != null) 'insuranceAmount': insuranceAmount,
	if(mortgageBalance != null) 'mortgageBalance': mortgageBalance,
	if(lienAmount != null) 'lienAmount': lienAmount,
	if(electricityProvider != null) 'electricityProvider': electricityProvider,
	if(gasProvider != null) 'gasProvider': gasProvider,
	if(waterProvider != null) 'waterProvider': waterProvider,
	if(internetProvider != null) 'internetProvider': internetProvider,
	if(trashService != null) 'trashService': trashService,
	if(mlsNumber != null) 'mlsNumber': mlsNumber,
	if(mlsStatus != null) 'mlsStatus': mlsStatus,
	if(daysOnMarket != null) 'daysOnMarket': daysOnMarket,
	if(pricePerSqFt != null) 'pricePerSqFt': pricePerSqFt,
	if(rentalYield != null) 'rentalYield': rentalYield,
	if(yearRenovated != null) 'yearRenovated': yearRenovated,
	if(energyRating != null) 'energyRating': energyRating,
	if(accessibilityFeatures != null) 'accessibilityFeatures': accessibilityFeatures,
	if(smartHomeFeatures != null) 'smartHomeFeatures': smartHomeFeatures,
	if(securityFeatures != null) 'securityFeatures': securityFeatures,
	if(outdoorFeatures != null) 'outdoorFeatures': outdoorFeatures,
	if(zoningDescription != null) 'zoningDescription': zoningDescription,
	if(landUse != null) 'landUse': landUse,
	if(buildingRestrictions != null) 'buildingRestrictions': buildingRestrictions,
	if(futureDevelopment != null) 'futureDevelopment': futureDevelopment,
	if(leadPaintCompliance != null) 'leadPaintCompliance': leadPaintCompliance,
	if(moldInspectionDate != null) 'moldInspectionDate': moldInspectionDate?.toIso8601String(),
	if(asbestosInspectionDate != null) 'asbestosInspectionDate': asbestosInspectionDate?.toIso8601String(),
	if(radonTestDate != null) 'radonTestDate': radonTestDate?.toIso8601String(),
	if(pestControlDate != null) 'pestControlDate': pestControlDate?.toIso8601String(),
	if(fireInspectionDate != null) 'fireInspectionDate': fireInspectionDate?.toIso8601String(),
	if(elevatorInspectionDate != null) 'elevatorInspectionDate': elevatorInspectionDate?.toIso8601String(),
	if(poolInspectionDate != null) 'poolInspectionDate': poolInspectionDate?.toIso8601String(),
	if(lastCodeComplianceDate != null) 'lastCodeComplianceDate': lastCodeComplianceDate?.toIso8601String(),
	if(accessibilityCompliance != null) 'accessibilityCompliance': accessibilityCompliance,
	if(environmentalHazards != null) 'environmentalHazards': environmentalHazards,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(aiImageAnalyses != null && (!preventCircularSerialization || !serializedModels.contains('AIImageAnalysis'))) 'aiImageAnalyses': aiImageAnalyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiInvestments != null && (!preventCircularSerialization || !serializedModels.contains('AIInvestmentAnalysis'))) 'aiInvestments': aiInvestments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiMaintenance != null && (!preventCircularSerialization || !serializedModels.contains('AIPredictiveMaintenance'))) 'aiMaintenance': aiMaintenance?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiDescriptions != null && (!preventCircularSerialization || !serializedModels.contains('AIPropertyDescription'))) 'aiDescriptions': aiDescriptions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiValuations != null && (!preventCircularSerialization || !serializedModels.contains('AIPropertyValuation'))) 'aiValuations': aiValuations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(appointments != null && (!preventCircularSerialization || !serializedModels.contains('Appointment'))) 'appointments': appointments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(attachments != null && (!preventCircularSerialization || !serializedModels.contains('Attachment'))) 'attachments': attachments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(contracts != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contracts': contracts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(deals != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'deals': deals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(generalDocuments != null && (!preventCircularSerialization || !serializedModels.contains('Document'))) 'generalDocuments': generalDocuments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(events != null && (!preventCircularSerialization || !serializedModels.contains('Event'))) 'events': events?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(facilities != null && (!preventCircularSerialization || !serializedModels.contains('Facility'))) 'facilities': facilities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(financialRecords != null && (!preventCircularSerialization || !serializedModels.contains('FinancialRecord'))) 'financialRecords': financialRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(floorPlans != null && (!preventCircularSerialization || !serializedModels.contains('FloorPlan'))) 'floorPlans': floorPlans?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(guestReviews != null && (!preventCircularSerialization || !serializedModels.contains('GuestReview'))) 'guestReviews': guestReviews?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(homeInformationPack != null && (!preventCircularSerialization || !serializedModels.contains('HomeInformationPack'))) 'homeInformationPack': homeInformationPack?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(investorProperties != null && (!preventCircularSerialization || !serializedModels.contains('InvestorProperty'))) 'investorProperties': investorProperties?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(keys != null && (!preventCircularSerialization || !serializedModels.contains('KeyManagement'))) 'keys': keys?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leads != null && (!preventCircularSerialization || !serializedModels.contains('Lead'))) 'leads': leads?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(ledger != null && (!preventCircularSerialization || !serializedModels.contains('LedgerEntry'))) 'ledger': ledger?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(listings != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listings': listings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(maintenanceBlocks != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceBlock'))) 'maintenanceBlocks': maintenanceBlocks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(workOrders != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceWorkOrder'))) 'workOrders': workOrders?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mortgageOffers != null && (!preventCircularSerialization || !serializedModels.contains('MortgageOffer'))) 'mortgageOffers': mortgageOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(projects != null && (!preventCircularSerialization || !serializedModels.contains('Project'))) 'projects': projects?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(location != null && (!preventCircularSerialization || !serializedModels.contains('Location'))) 'location': location?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(neighborhood != null && (!preventCircularSerialization || !serializedModels.contains('Neighborhood'))) 'neighborhood': neighborhood?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(amenities != null && (!preventCircularSerialization || !serializedModels.contains('PropertyAmenity'))) 'amenities': amenities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(compliance != null && (!preventCircularSerialization || !serializedModels.contains('PropertyCompliance'))) 'compliance': compliance?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyDisclosure != null && (!preventCircularSerialization || !serializedModels.contains('PropertyDisclosure'))) 'propertyDisclosure': propertyDisclosure?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(documents != null && (!preventCircularSerialization || !serializedModels.contains('PropertyDocument'))) 'documents': documents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(inventories != null && (!preventCircularSerialization || !serializedModels.contains('PropertyInventory'))) 'inventories': inventories?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyOffers != null && (!preventCircularSerialization || !serializedModels.contains('PropertyOffer'))) 'propertyOffers': propertyOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(valuations != null && (!preventCircularSerialization || !serializedModels.contains('PropertyValuation'))) 'valuations': valuations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(viewings != null && (!preventCircularSerialization || !serializedModels.contains('PropertyViewing'))) 'viewings': viewings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(quotes != null && (!preventCircularSerialization || !serializedModels.contains('Quote'))) 'quotes': quotes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(taxDepreciations != null && (!preventCircularSerialization || !serializedModels.contains('TaxDepreciation'))) 'taxDepreciations': taxDepreciations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenantApplications != null && (!preventCircularSerialization || !serializedModels.contains('TenantApplication'))) 'tenantApplications': tenantApplications?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(vacationRental != null && (!preventCircularSerialization || !serializedModels.contains('VacationRental'))) 'vacationRental': vacationRental?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(virtualTours != null && (!preventCircularSerialization || !serializedModels.contains('VirtualTour'))) 'virtualTours': virtualTours?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(videoContents != null && (!preventCircularSerialization || !serializedModels.contains('VideoContent'))) 'videoContents': videoContents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agents != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agents': agents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(extraCharges != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'extraCharges': extraCharges?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(currencies != null && (!preventCircularSerialization || !serializedModels.contains('Currency'))) 'currencies': currencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(hashtags != null && (!preventCircularSerialization || !serializedModels.contains('Hashtag'))) 'hashtags': hashtags?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(guests != null && (!preventCircularSerialization || !serializedModels.contains('Guest'))) 'guests': guests?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(includedServices != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'includedServices': includedServices?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(pricingRules != null && (!preventCircularSerialization || !serializedModels.contains('PricingRule'))) 'pricingRules': pricingRules?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(discounts != null && (!preventCircularSerialization || !serializedModels.contains('Discount'))) 'discounts': discounts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyPhotos != null && (!preventCircularSerialization || !serializedModels.contains('PropertyPhoto'))) 'propertyPhotos': propertyPhotos?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(analytics != null && (!preventCircularSerialization || !serializedModels.contains('Analytics'))) 'analytics': analytics?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(availabilities != null && (!preventCircularSerialization || !serializedModels.contains('Availability'))) 'availabilities': availabilities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(complianceRecords != null && (!preventCircularSerialization || !serializedModels.contains('ComplianceRecord'))) 'complianceRecords': complianceRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(expenses != null && (!preventCircularSerialization || !serializedModels.contains('Expense'))) 'expenses': expenses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(favorites != null && (!preventCircularSerialization || !serializedModels.contains('Favorite'))) 'favorites': favorites?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(increases != null && (!preventCircularSerialization || !serializedModels.contains('Increase'))) 'increases': increases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mentions != null && (!preventCircularSerialization || !serializedModels.contains('Mention'))) 'mentions': mentions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mortgages != null && (!preventCircularSerialization || !serializedModels.contains('Mortgage'))) 'mortgages': mortgages?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(offers != null && (!preventCircularSerialization || !serializedModels.contains('Offer'))) 'offers': offers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(payments != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'payments': payments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(photos != null && (!preventCircularSerialization || !serializedModels.contains('Photo'))) 'photos': photos?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyPromotions != null && (!preventCircularSerialization || !serializedModels.contains('PropertyPromotion'))) 'propertyPromotions': propertyPromotions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenants != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'tenants': tenants?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(includedServiceRelations != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'includedServiceRelations': includedServiceRelations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($accessibilityFeaturesCount != null || $smartHomeFeaturesCount != null || $securityFeaturesCount != null || $outdoorFeaturesCount != null || $environmentalHazardsCount != null || $aiImageAnalysesCount != null || $aiInvestmentsCount != null || $aiMaintenanceCount != null || $aiDescriptionsCount != null || $aiValuationsCount != null || $appointmentsCount != null || $attachmentsCount != null || $contractsCount != null || $dealsCount != null || $generalDocumentsCount != null || $eventsCount != null || $facilitiesCount != null || $financialRecordsCount != null || $floorPlansCount != null || $guestReviewsCount != null || $investorPropertiesCount != null || $keysCount != null || $leadsCount != null || $ledgerCount != null || $listingsCount != null || $maintenanceBlocksCount != null || $workOrdersCount != null || $mortgageOffersCount != null || $projectsCount != null || $amenitiesCount != null || $complianceCount != null || $documentsCount != null || $inventoriesCount != null || $propertyOffersCount != null || $valuationsCount != null || $viewingsCount != null || $quotesCount != null || $tasksCount != null || $taxDepreciationsCount != null || $tenantApplicationsCount != null || $virtualToursCount != null || $videoContentsCount != null || $agentsCount != null || $extraChargesCount != null || $currenciesCount != null || $hashtagsCount != null || $guestsCount != null || $agenciesCount != null || $includedServicesCount != null || $pricingRulesCount != null || $discountsCount != null || $propertyPhotosCount != null || $analyticsCount != null || $availabilitiesCount != null || $complianceRecordsCount != null || $expensesCount != null || $favoritesCount != null || $increasesCount != null || $mentionsCount != null || $mortgagesCount != null || $offersCount != null || $paymentsCount != null || $photosCount != null || $propertyPromotionsCount != null || $tenantsCount != null || $includedServiceRelationsCount != null) '_count': { 
		if ($accessibilityFeaturesCount != null) 'accessibilityFeatures': $accessibilityFeaturesCount, 
		if ($smartHomeFeaturesCount != null) 'smartHomeFeatures': $smartHomeFeaturesCount, 
		if ($securityFeaturesCount != null) 'securityFeatures': $securityFeaturesCount, 
		if ($outdoorFeaturesCount != null) 'outdoorFeatures': $outdoorFeaturesCount, 
		if ($environmentalHazardsCount != null) 'environmentalHazards': $environmentalHazardsCount, 
		if ($aiImageAnalysesCount != null) 'aiImageAnalyses': $aiImageAnalysesCount, 
		if ($aiInvestmentsCount != null) 'aiInvestments': $aiInvestmentsCount, 
		if ($aiMaintenanceCount != null) 'aiMaintenance': $aiMaintenanceCount, 
		if ($aiDescriptionsCount != null) 'aiDescriptions': $aiDescriptionsCount, 
		if ($aiValuationsCount != null) 'aiValuations': $aiValuationsCount, 
		if ($appointmentsCount != null) 'appointments': $appointmentsCount, 
		if ($attachmentsCount != null) 'attachments': $attachmentsCount, 
		if ($contractsCount != null) 'contracts': $contractsCount, 
		if ($dealsCount != null) 'deals': $dealsCount, 
		if ($generalDocumentsCount != null) 'generalDocuments': $generalDocumentsCount, 
		if ($eventsCount != null) 'events': $eventsCount, 
		if ($facilitiesCount != null) 'facilities': $facilitiesCount, 
		if ($financialRecordsCount != null) 'financialRecords': $financialRecordsCount, 
		if ($floorPlansCount != null) 'floorPlans': $floorPlansCount, 
		if ($guestReviewsCount != null) 'guestReviews': $guestReviewsCount, 
		if ($investorPropertiesCount != null) 'investorProperties': $investorPropertiesCount, 
		if ($keysCount != null) 'keys': $keysCount, 
		if ($leadsCount != null) 'leads': $leadsCount, 
		if ($ledgerCount != null) 'ledger': $ledgerCount, 
		if ($listingsCount != null) 'listings': $listingsCount, 
		if ($maintenanceBlocksCount != null) 'maintenanceBlocks': $maintenanceBlocksCount, 
		if ($workOrdersCount != null) 'workOrders': $workOrdersCount, 
		if ($mortgageOffersCount != null) 'mortgageOffers': $mortgageOffersCount, 
		if ($projectsCount != null) 'projects': $projectsCount, 
		if ($amenitiesCount != null) 'amenities': $amenitiesCount, 
		if ($complianceCount != null) 'compliance': $complianceCount, 
		if ($documentsCount != null) 'documents': $documentsCount, 
		if ($inventoriesCount != null) 'inventories': $inventoriesCount, 
		if ($propertyOffersCount != null) 'propertyOffers': $propertyOffersCount, 
		if ($valuationsCount != null) 'valuations': $valuationsCount, 
		if ($viewingsCount != null) 'viewings': $viewingsCount, 
		if ($quotesCount != null) 'quotes': $quotesCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($taxDepreciationsCount != null) 'taxDepreciations': $taxDepreciationsCount, 
		if ($tenantApplicationsCount != null) 'tenantApplications': $tenantApplicationsCount, 
		if ($virtualToursCount != null) 'virtualTours': $virtualToursCount, 
		if ($videoContentsCount != null) 'videoContents': $videoContentsCount, 
		if ($agentsCount != null) 'agents': $agentsCount, 
		if ($extraChargesCount != null) 'extraCharges': $extraChargesCount, 
		if ($currenciesCount != null) 'currencies': $currenciesCount, 
		if ($hashtagsCount != null) 'hashtags': $hashtagsCount, 
		if ($guestsCount != null) 'guests': $guestsCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($includedServicesCount != null) 'includedServices': $includedServicesCount, 
		if ($pricingRulesCount != null) 'pricingRules': $pricingRulesCount, 
		if ($discountsCount != null) 'discounts': $discountsCount, 
		if ($propertyPhotosCount != null) 'propertyPhotos': $propertyPhotosCount, 
		if ($analyticsCount != null) 'analytics': $analyticsCount, 
		if ($availabilitiesCount != null) 'availabilities': $availabilitiesCount, 
		if ($complianceRecordsCount != null) 'complianceRecords': $complianceRecordsCount, 
		if ($expensesCount != null) 'expenses': $expensesCount, 
		if ($favoritesCount != null) 'favorites': $favoritesCount, 
		if ($increasesCount != null) 'increases': $increasesCount, 
		if ($mentionsCount != null) 'mentions': $mentionsCount, 
		if ($mortgagesCount != null) 'mortgages': $mortgagesCount, 
		if ($offersCount != null) 'offers': $offersCount, 
		if ($paymentsCount != null) 'payments': $paymentsCount, 
		if ($photosCount != null) 'photos': $photosCount, 
		if ($propertyPromotionsCount != null) 'propertyPromotions': $propertyPromotionsCount, 
		if ($tenantsCount != null) 'tenants': $tenantsCount, 
		if ($includedServiceRelationsCount != null) 'includedServiceRelations': $includedServiceRelationsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Property &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    