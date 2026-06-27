import 'package:reservatior/shared/enums/listing_status.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/enums/listing_type.dart';
import 'package:reservatior/shared/enums/org_type.dart';
import 'package:reservatior/shared/enums/property_category.dart';
import 'package:reservatior/shared/enums/property_type.dart';
import 'package:reservatior/shared/enums/region.dart';
import 'package:reservatior/shared/enums/us_state.dart';
import 'agency.dart';
import 'agent.dart';
import 'ai_image_analysis.dart';
import 'ai_investment_analysis.dart';
import 'ai_predictive_maintenance.dart';
import 'ai_property_description.dart';
import 'ai_property_valuation.dart';
import 'analytics.dart';
import 'appointment.dart';
import 'attachment.dart';
import 'availability.dart';
import 'compliance_record.dart';
import 'contract.dart';
import 'currency.dart';
import 'deal.dart';
import 'discount.dart';
import 'document.dart';
import 'event.dart';
import 'expense.dart';
import 'extra_charge.dart';
import 'facility.dart';
import 'favorite.dart';
import 'financial_record.dart';
import 'floor_plan.dart';
import 'guest.dart';
import 'guest_review.dart';
import 'hashtag.dart';
import 'home_information_pack.dart';
import 'included_service.dart';
import 'increase.dart';
import 'investor_property.dart';
import 'key_management.dart';
import 'lead.dart';
import 'ledger_entry.dart';
import 'listing.dart';
import 'location.dart';
import 'maintenance_block.dart';
import 'maintenance_work_order.dart';
import 'mention.dart';
import 'mortgage.dart';
import 'mortgage_offer.dart';
import 'neighborhood.dart';
import 'organization.dart';
import 'offer.dart';
import 'payment.dart';
import 'photo.dart';
import 'pricing_rule.dart';
import 'project.dart';
import 'property_amenity.dart';
import 'property_compliance.dart';
import 'property_disclosure.dart';
import 'property_document.dart';
import 'property_inventory.dart';
import 'property_offer.dart';
import 'property_photo.dart';
import 'property_promotion.dart';
import 'property_valuation.dart';
import 'property_viewing.dart';
import 'quote.dart';
import 'task.dart';
import 'tax_depreciation.dart';
import 'tenant.dart';
import 'tenant_application.dart';
import 'vacation_rental.dart';
import 'video_content.dart';
import 'virtual_tour.dart';

class Property {
  final String id;
  final String orgId;
  final PropertyType type;
  final String name;
  final Region region;
  final String currency;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state;
  final String? zip;
  final String country;
  final double? lat;
  final double? lng;
  final String? neighborhoodId;
  final int? bedrooms;
  final double? bathrooms;
  final double? areaSqm;
  final int? yearBuilt;
  final String? notes;
  final String? locationId;
  final UsState? stateCode;
  final PropertyCategory propertyCategory;
  final ListingType listingType;
  final ListingStatus listingStatus;
  final double? listingPrice;
  final double? originalPrice;
  final String? schoolDistrict;
  final double? hoaFee;
  final String? hoaFeeFrequency;
  final double? propertyTaxRate;
  final double? lastAssessmentValue;
  final int? lastAssessmentYear;
  final String? floodZone;
  final String? zoningCode;
  final double? lotSizeAcres;
  final double? frontageFeet;
  final double? depthFeet;
  final String? basementType;
  final double? basementFinishedSqFt;
  final String? garageType;
  final int? garageCapacity;
  final int? parkingSpaces;
  final String? parkingType;
  final String? poolType;
  final String? heatingType;
  final String? coolingType;
  final String? fireplaceType;
  final int? fireplaceCount;
  final String? viewType;
  final String? waterfrontType;
  final double? waterfrontFeet;
  final String? constructionType;
  final String? roofType;
  final int? roofYear;
  final String? sidingType;
  final String? zipPlus4;
  final String? countyFIPS;
  final String? censusTract;
  final String? mlsArea;
  final String? propertyClas;
  final String? buildingClas;
  final int? totalRooms;
  final double? livingAreaSqFt;
  final double? lotSizeSqFt;
  final int? stories;
  final int? unitsPerBuilding;
  final double? assessedValue;
  final double? marketValue;
  final double? propertyTax;
  final double? insuranceAmount;
  final double? mortgageBalance;
  final double? lienAmount;
  final String? electricityProvider;
  final String? gasProvider;
  final String? waterProvider;
  final String? internetProvider;
  final String? trashService;
  final String? mlsNumber;
  final String? mlsStatus;
  final int? daysOnMarket;
  final double? pricePerSqFt;
  final double? rentalYield;
  final int? yearRenovated;
  final String? energyRating;
  final List<String> accessibilityFeatures;
  final List<String> smartHomeFeatures;
  final List<String> securityFeatures;
  final List<String> outdoorFeatures;
  final String? zoningDescription;
  final String? landUse;
  final String? buildingRestrictions;
  final String? futureDevelopment;
  final bool leadPaintCompliance;
  final DateTime? moldInspectionDate;
  final DateTime? asbestosInspectionDate;
  final DateTime? radonTestDate;
  final DateTime? pestControlDate;
  final DateTime? fireInspectionDate;
  final DateTime? elevatorInspectionDate;
  final DateTime? poolInspectionDate;
  final DateTime? lastCodeComplianceDate;
  final bool accessibilityCompliance;
  final List<String> environmentalHazards;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<AiImageAnalysis> aiImageAnalyses;
  final List<AiInvestmentAnalysis> aiInvestments;
  final List<AiPredictiveMaintenance> aiMaintenance;
  final List<AiPropertyDescription> aiDescriptions;
  final List<AiPropertyValuation> aiValuations;
  final List<Appointment> appointments;
  final List<Attachment> attachments;
  final List<Contract> contracts;
  final List<Deal> deals;
  final List<Document> generalDocuments;
  final List<Event> events;
  final List<Facility> facilities;
  final List<FinancialRecord> financialRecords;
  final List<FloorPlan> floorPlans;
  final List<GuestReview> guestReviews;
  final HomeInformationPack? homeInformationPack;
  final List<InvestorProperty> investorProperties;
  final List<KeyManagement> keys;
  final List<Lead> leads;
  final List<LedgerEntry> ledger;
  final List<Listing> listings;
  final List<MaintenanceBlock> maintenanceBlocks;
  final List<MaintenanceWorkOrder> workOrders;
  final List<MortgageOffer> mortgageOffers;
  final List<Project> projects;
  final Location? location;
  final Neighborhood? neighborhood;
  final Organization? org;
  final List<PropertyAmenity> amenities;
  final List<PropertyCompliance> compliance;
  final PropertyDisclosure? propertyDisclosure;
  final List<PropertyDocument> documents;
  final List<PropertyInventory> inventories;
  final List<PropertyOffer> propertyOffers;
  final List<PropertyValuation> valuations;
  final List<PropertyViewing> viewings;
  final List<Quote> quotes;
  final List<Task> tasks;
  final List<TaxDepreciation> taxDepreciations;
  final List<TenantApplication> tenantApplications;
  final VacationRental? vacationRental;
  final List<VirtualTour> virtualTours;
  final List<VideoContent> videoContents;
  final List<Agent> agents;
  final List<ExtraCharge> extraCharges;
  final List<Currency> currencies;
  final List<Hashtag> hashtags;
  final List<Guest> guests;
  final List<Agency> agencies;
  final List<IncludedService> includedServices;
  final List<PricingRule> pricingRules;
  final List<Discount> discounts;
  final List<PropertyPhoto> propertyPhotos;
  final List<Analytics> analytics;
  final List<Availability> availabilities;
  final List<ComplianceRecord> complianceRecords;
  final List<Expense> expenses;
  final List<Favorite> favorites;
  final List<Increase> increases;
  final List<Mention> mentions;
  final List<Mortgage> mortgages;
  final List<Offer> offers;
  final List<Payment> payments;
  final List<Photo> photos;
  final List<PropertyPromotion> propertyPromotions;
  final List<Tenant> tenants;
  final List<IncludedService> includedServiceRelations;

  const Property({
    required this.id,
    required this.orgId,
    required this.type,
    required this.name,
    required this.region,
    required this.currency,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    this.state,
    this.zip,
    required this.country,
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
    required this.propertyCategory,
    required this.listingType,
    required this.listingStatus,
    this.listingPrice,
    this.originalPrice,
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
    this.propertyClas,
    this.buildingClas,
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
    this.accessibilityFeatures = const [],
    this.smartHomeFeatures = const [],
    this.securityFeatures = const [],
    this.outdoorFeatures = const [],
    this.zoningDescription,
    this.landUse,
    this.buildingRestrictions,
    this.futureDevelopment,
    required this.leadPaintCompliance,
    this.moldInspectionDate,
    this.asbestosInspectionDate,
    this.radonTestDate,
    this.pestControlDate,
    this.fireInspectionDate,
    this.elevatorInspectionDate,
    this.poolInspectionDate,
    this.lastCodeComplianceDate,
    required this.accessibilityCompliance,
    this.environmentalHazards = const [],
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.aiImageAnalyses = const [],
    this.aiInvestments = const [],
    this.aiMaintenance = const [],
    this.aiDescriptions = const [],
    this.aiValuations = const [],
    this.appointments = const [],
    this.attachments = const [],
    this.contracts = const [],
    this.deals = const [],
    this.generalDocuments = const [],
    this.events = const [],
    this.facilities = const [],
    this.financialRecords = const [],
    this.floorPlans = const [],
    this.guestReviews = const [],
    this.homeInformationPack,
    this.investorProperties = const [],
    this.keys = const [],
    this.leads = const [],
    this.ledger = const [],
    this.listings = const [],
    this.maintenanceBlocks = const [],
    this.workOrders = const [],
    this.mortgageOffers = const [],
    this.projects = const [],
    this.location,
    this.neighborhood,
    this.org,
    this.amenities = const [],
    this.compliance = const [],
    this.propertyDisclosure,
    this.documents = const [],
    this.inventories = const [],
    this.propertyOffers = const [],
    this.valuations = const [],
    this.viewings = const [],
    this.quotes = const [],
    this.tasks = const [],
    this.taxDepreciations = const [],
    this.tenantApplications = const [],
    this.vacationRental,
    this.virtualTours = const [],
    this.videoContents = const [],
    this.agents = const [],
    this.extraCharges = const [],
    this.currencies = const [],
    this.hashtags = const [],
    this.guests = const [],
    this.agencies = const [],
    this.includedServices = const [],
    this.pricingRules = const [],
    this.discounts = const [],
    this.propertyPhotos = const [],
    this.analytics = const [],
    this.availabilities = const [],
    this.complianceRecords = const [],
    this.expenses = const [],
    this.favorites = const [],
    this.increases = const [],
    this.mentions = const [],
    this.mortgages = const [],
    this.offers = const [],
    this.payments = const [],
    this.photos = const [],
    this.propertyPromotions = const [],
    this.tenants = const [],
    this.includedServiceRelations = const [],
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return Property(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      type: PropertyType.values.firstWhere((v) => v.name == json['type'], orElse: () => PropertyType.APARTMENT),
      name: json['name'] as String,
      region: Region.values.firstWhere((v) => v.name == json['region'], orElse: () => Region.USA_NORTHEAST),
      currency: json['currency'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      country: json['country'] as String,
      lat: parseDouble(json['lat']),
      lng: parseDouble(json['lng']),
      neighborhoodId: json['neighborhoodId'] as String?,
      bedrooms: json['bedrooms'] as int?,
      bathrooms: parseDouble(json['bathrooms']),
      areaSqm: parseDouble(json['areaSqm']),
      yearBuilt: json['yearBuilt'] as int?,
      notes: json['notes'] as String?,
      locationId: json['locationId'] as String?,
      stateCode: json['stateCode'] != null ? UsState.values.firstWhere((v) => v.name == json['stateCode'], orElse: () => UsState.NEW_YORK) : null,
      propertyCategory: PropertyCategory.values.firstWhere((v) => v.name == json['propertyCategory'], orElse: () => PropertyCategory.RESIDENTIAL),
      listingType: ListingType.values.firstWhere((v) => v.name == json['listingType'], orElse: () => ListingType.SALE),
      listingStatus: ListingStatus.values.firstWhere((v) => v.name == json['listingStatus'], orElse: () => ListingStatus.AVAILABLE),
      listingPrice: parseDouble(json['listingPrice']),
      originalPrice: parseDouble(json['originalPrice']),
      schoolDistrict: json['schoolDistrict'] as String?,
      hoaFee: parseDouble(json['hoaFee']),
      hoaFeeFrequency: json['hoaFeeFrequency'] as String?,
      propertyTaxRate: parseDouble(json['propertyTaxRate']),
      lastAssessmentValue: parseDouble(json['lastAssessmentValue']),
      lastAssessmentYear: json['lastAssessmentYear'] as int?,
      floodZone: json['floodZone'] as String?,
      zoningCode: json['zoningCode'] as String?,
      lotSizeAcres: parseDouble(json['lotSizeAcres']),
      frontageFeet: parseDouble(json['frontageFeet']),
      depthFeet: parseDouble(json['depthFeet']),
      basementType: json['basementType'] as String?,
      basementFinishedSqFt: parseDouble(json['basementFinishedSqFt']),
      garageType: json['garageType'] as String?,
      garageCapacity: json['garageCapacity'] as int?,
      parkingSpaces: json['parkingSpaces'] as int?,
      parkingType: json['parkingType'] as String?,
      poolType: json['poolType'] as String?,
      heatingType: json['heatingType'] as String?,
      coolingType: json['coolingType'] as String?,
      fireplaceType: json['fireplaceType'] as String?,
      fireplaceCount: json['fireplaceCount'] as int?,
      viewType: json['viewType'] as String?,
      waterfrontType: json['waterfrontType'] as String?,
      waterfrontFeet: parseDouble(json['waterfrontFeet']),
      constructionType: json['constructionType'] as String?,
      roofType: json['roofType'] as String?,
      roofYear: json['roofYear'] as int?,
      sidingType: json['sidingType'] as String?,
      zipPlus4: json['zipPlus4'] as String?,
      countyFIPS: json['countyFIPS'] as String?,
      censusTract: json['censusTract'] as String?,
      mlsArea: json['mlsArea'] as String?,
      propertyClas: json['propertyClas'] as String?,
      buildingClas: json['buildingClas'] as String?,
      totalRooms: json['totalRooms'] as int?,
      livingAreaSqFt: parseDouble(json['livingAreaSqFt']),
      lotSizeSqFt: parseDouble(json['lotSizeSqFt']),
      stories: json['stories'] as int?,
      unitsPerBuilding: json['unitsPerBuilding'] as int?,
      assessedValue: parseDouble(json['assessedValue']),
      marketValue: parseDouble(json['marketValue']),
      propertyTax: parseDouble(json['propertyTax']),
      insuranceAmount: parseDouble(json['insuranceAmount']),
      mortgageBalance: parseDouble(json['mortgageBalance']),
      lienAmount: parseDouble(json['lienAmount']),
      electricityProvider: json['electricityProvider'] as String?,
      gasProvider: json['gasProvider'] as String?,
      waterProvider: json['waterProvider'] as String?,
      internetProvider: json['internetProvider'] as String?,
      trashService: json['trashService'] as String?,
      mlsNumber: json['mlsNumber'] as String?,
      mlsStatus: json['mlsStatus'] as String?,
      daysOnMarket: json['daysOnMarket'] as int?,
      pricePerSqFt: parseDouble(json['pricePerSqFt']),
      rentalYield: parseDouble(json['rentalYield']),
      yearRenovated: json['yearRenovated'] as int?,
      energyRating: json['energyRating'] as String?,
      accessibilityFeatures: (json['accessibilityFeatures'] as List<dynamic>?)?.cast<String>() ?? [],
      smartHomeFeatures: (json['smartHomeFeatures'] as List<dynamic>?)?.cast<String>() ?? [],
      securityFeatures: (json['securityFeatures'] as List<dynamic>?)?.cast<String>() ?? [],
      outdoorFeatures: (json['outdoorFeatures'] as List<dynamic>?)?.cast<String>() ?? [],
      zoningDescription: json['zoningDescription'] as String?,
      landUse: json['landUse'] as String?,
      buildingRestrictions: json['buildingRestrictions'] as String?,
      futureDevelopment: json['futureDevelopment'] as String?,
      leadPaintCompliance: json['leadPaintCompliance'] as bool,
      moldInspectionDate: json['moldInspectionDate'] != null ? DateTime.parse(json['moldInspectionDate'] as String) : null,
      asbestosInspectionDate: json['asbestosInspectionDate'] != null ? DateTime.parse(json['asbestosInspectionDate'] as String) : null,
      radonTestDate: json['radonTestDate'] != null ? DateTime.parse(json['radonTestDate'] as String) : null,
      pestControlDate: json['pestControlDate'] != null ? DateTime.parse(json['pestControlDate'] as String) : null,
      fireInspectionDate: json['fireInspectionDate'] != null ? DateTime.parse(json['fireInspectionDate'] as String) : null,
      elevatorInspectionDate: json['elevatorInspectionDate'] != null ? DateTime.parse(json['elevatorInspectionDate'] as String) : null,
      poolInspectionDate: json['poolInspectionDate'] != null ? DateTime.parse(json['poolInspectionDate'] as String) : null,
      lastCodeComplianceDate: json['lastCodeComplianceDate'] != null ? DateTime.parse(json['lastCodeComplianceDate'] as String) : null,
      accessibilityCompliance: json['accessibilityCompliance'] as bool,
      environmentalHazards: (json['environmentalHazards'] as List<dynamic>?)?.cast<String>() ?? [],
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      aiImageAnalyses: (json['aiImageAnalyses'] as List<dynamic>?)?.map((e) => AiImageAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiInvestments: (json['aiInvestments'] as List<dynamic>?)?.map((e) => AiInvestmentAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiMaintenance: (json['aiMaintenance'] as List<dynamic>?)?.map((e) => AiPredictiveMaintenance.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiDescriptions: (json['aiDescriptions'] as List<dynamic>?)?.map((e) => AiPropertyDescription.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiValuations: (json['aiValuations'] as List<dynamic>?)?.map((e) => AiPropertyValuation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      appointments: (json['appointments'] as List<dynamic>?)?.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Attachment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      contracts: (json['contracts'] as List<dynamic>?)?.map((e) => Contract.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      deals: (json['deals'] as List<dynamic>?)?.map((e) => Deal.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      generalDocuments: (json['generalDocuments'] as List<dynamic>?)?.map((e) => Document.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      events: (json['events'] as List<dynamic>?)?.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      facilities: (json['facilities'] as List<dynamic>?)?.map((e) => Facility.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      financialRecords: (json['financialRecords'] as List<dynamic>?)?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      floorPlans: (json['floorPlans'] as List<dynamic>?)?.map((e) => FloorPlan.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      guestReviews: (json['guestReviews'] as List<dynamic>?)?.map((e) => GuestReview.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      homeInformationPack: json['homeInformationPack'] != null ? HomeInformationPack.fromJson(json['homeInformationPack'] as Map<String, dynamic>) : null,
      investorProperties: (json['investorProperties'] as List<dynamic>?)?.map((e) => InvestorProperty.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      keys: (json['keys'] as List<dynamic>?)?.map((e) => KeyManagement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leads: (json['leads'] as List<dynamic>?)?.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      ledger: (json['ledger'] as List<dynamic>?)?.map((e) => LedgerEntry.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      listings: (json['listings'] as List<dynamic>?)?.map((e) => Listing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      maintenanceBlocks: (json['maintenanceBlocks'] as List<dynamic>?)?.map((e) => MaintenanceBlock.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      workOrders: (json['workOrders'] as List<dynamic>?)?.map((e) => MaintenanceWorkOrder.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mortgageOffers: (json['mortgageOffers'] as List<dynamic>?)?.map((e) => MortgageOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      projects: (json['projects'] as List<dynamic>?)?.map((e) => Project.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      location: json['location'] != null ? Location.fromJson(json['location'] as Map<String, dynamic>) : null,
      neighborhood: json['neighborhood'] != null ? Neighborhood.fromJson(json['neighborhood'] as Map<String, dynamic>) : null,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : 
      Organization(
        id: json['orgId'], 
        name: 'mobile.leftovers.unknown_org'.tr(), 
        type: OrgType.AGENCY,
        region: Region.USA_NORTHEAST,
        defaultCurrency: 'USD',
        defaultLocale: 'en',
        taxReportingEnabled: false,
        complianceTracking: false,
        createdAt: DateTime.now(), 
        updatedAt: DateTime.now()
      ),
      amenities: (json['amenities'] as List<dynamic>?)?.map((e) => PropertyAmenity.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      compliance: (json['compliance'] as List<dynamic>?)?.map((e) => PropertyCompliance.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyDisclosure: json['propertyDisclosure'] != null ? PropertyDisclosure.fromJson(json['propertyDisclosure'] as Map<String, dynamic>) : null,
      documents: (json['documents'] as List<dynamic>?)?.map((e) => PropertyDocument.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      inventories: (json['inventories'] as List<dynamic>?)?.map((e) => PropertyInventory.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyOffers: (json['propertyOffers'] as List<dynamic>?)?.map((e) => PropertyOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      valuations: (json['valuations'] as List<dynamic>?)?.map((e) => PropertyValuation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      viewings: (json['viewings'] as List<dynamic>?)?.map((e) => PropertyViewing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      quotes: (json['quotes'] as List<dynamic>?)?.map((e) => Quote.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      taxDepreciations: (json['taxDepreciations'] as List<dynamic>?)?.map((e) => TaxDepreciation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenantApplications: (json['tenantApplications'] as List<dynamic>?)?.map((e) => TenantApplication.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      vacationRental: json['vacationRental'] != null ? VacationRental.fromJson(json['vacationRental'] as Map<String, dynamic>) : null,
      virtualTours: (json['virtualTours'] as List<dynamic>?)?.map((e) => VirtualTour.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      videoContents: (json['videoContents'] as List<dynamic>?)?.map((e) => VideoContent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agents: (json['agents'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      extraCharges: (json['extraCharges'] as List<dynamic>?)?.map((e) => ExtraCharge.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      currencies: (json['currencies'] as List<dynamic>?)?.map((e) => Currency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      hashtags: (json['hashtags'] as List<dynamic>?)?.map((e) => Hashtag.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      guests: (json['guests'] as List<dynamic>?)?.map((e) => Guest.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      includedServices: (json['includedServices'] as List<dynamic>?)?.map((e) => IncludedService.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      pricingRules: (json['pricingRules'] as List<dynamic>?)?.map((e) => PricingRule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      discounts: (json['discounts'] as List<dynamic>?)?.map((e) => Discount.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyPhotos: (json['propertyPhotos'] as List<dynamic>?)?.map((e) => PropertyPhoto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      analytics: (json['analytics'] as List<dynamic>?)?.map((e) => Analytics.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      availabilities: (json['availabilities'] as List<dynamic>?)?.map((e) => Availability.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      complianceRecords: (json['complianceRecords'] as List<dynamic>?)?.map((e) => ComplianceRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      expenses: (json['expenses'] as List<dynamic>?)?.map((e) => Expense.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      favorites: (json['favorites'] as List<dynamic>?)?.map((e) => Favorite.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      increases: (json['increases'] as List<dynamic>?)?.map((e) => Increase.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mentions: (json['mentions'] as List<dynamic>?)?.map((e) => Mention.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mortgages: (json['mortgages'] as List<dynamic>?)?.map((e) => Mortgage.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      offers: (json['offers'] as List<dynamic>?)?.map((e) => Offer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      payments: (json['payments'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      photos: (json['photos'] as List<dynamic>?)?.map((e) => Photo.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyPromotions: (json['propertyPromotions'] as List<dynamic>?)?.map((e) => PropertyPromotion.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenants: (json['tenants'] as List<dynamic>?)?.map((e) => Tenant.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      includedServiceRelations: (json['includedServiceRelations'] as List<dynamic>?)?.map((e) => IncludedService.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'type': type.name,
      'name': name,
      'region': region.name,
      'currency': currency,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
      'lat': lat,
      'lng': lng,
      'neighborhoodId': neighborhoodId,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'areaSqm': areaSqm,
      'yearBuilt': yearBuilt,
      'notes': notes,
      'locationId': locationId,
      'stateCode': stateCode?.name,
      'propertyCategory': propertyCategory.name,
      'listingType': listingType.name,
      'listingStatus': listingStatus.name,
      'listingPrice': listingPrice,
      'originalPrice': originalPrice,
      'schoolDistrict': schoolDistrict,
      'hoaFee': hoaFee,
      'hoaFeeFrequency': hoaFeeFrequency,
      'propertyTaxRate': propertyTaxRate,
      'lastAssessmentValue': lastAssessmentValue,
      'lastAssessmentYear': lastAssessmentYear,
      'floodZone': floodZone,
      'zoningCode': zoningCode,
      'lotSizeAcres': lotSizeAcres,
      'frontageFeet': frontageFeet,
      'depthFeet': depthFeet,
      'basementType': basementType,
      'basementFinishedSqFt': basementFinishedSqFt,
      'garageType': garageType,
      'garageCapacity': garageCapacity,
      'parkingSpaces': parkingSpaces,
      'parkingType': parkingType,
      'poolType': poolType,
      'heatingType': heatingType,
      'coolingType': coolingType,
      'fireplaceType': fireplaceType,
      'fireplaceCount': fireplaceCount,
      'viewType': viewType,
      'waterfrontType': waterfrontType,
      'waterfrontFeet': waterfrontFeet,
      'constructionType': constructionType,
      'roofType': roofType,
      'roofYear': roofYear,
      'sidingType': sidingType,
      'zipPlus4': zipPlus4,
      'countyFIPS': countyFIPS,
      'censusTract': censusTract,
      'mlsArea': mlsArea,
      'propertyClas': propertyClas,
      'buildingClas': buildingClas,
      'totalRooms': totalRooms,
      'livingAreaSqFt': livingAreaSqFt,
      'lotSizeSqFt': lotSizeSqFt,
      'stories': stories,
      'unitsPerBuilding': unitsPerBuilding,
      'assessedValue': assessedValue,
      'marketValue': marketValue,
      'propertyTax': propertyTax,
      'insuranceAmount': insuranceAmount,
      'mortgageBalance': mortgageBalance,
      'lienAmount': lienAmount,
      'electricityProvider': electricityProvider,
      'gasProvider': gasProvider,
      'waterProvider': waterProvider,
      'internetProvider': internetProvider,
      'trashService': trashService,
      'mlsNumber': mlsNumber,
      'mlsStatus': mlsStatus,
      'daysOnMarket': daysOnMarket,
      'pricePerSqFt': pricePerSqFt,
      'rentalYield': rentalYield,
      'yearRenovated': yearRenovated,
      'energyRating': energyRating,
      'accessibilityFeatures': accessibilityFeatures,
      'smartHomeFeatures': smartHomeFeatures,
      'securityFeatures': securityFeatures,
      'outdoorFeatures': outdoorFeatures,
      'zoningDescription': zoningDescription,
      'landUse': landUse,
      'buildingRestrictions': buildingRestrictions,
      'futureDevelopment': futureDevelopment,
      'leadPaintCompliance': leadPaintCompliance,
      'moldInspectionDate': moldInspectionDate?.toIso8601String(),
      'asbestosInspectionDate': asbestosInspectionDate?.toIso8601String(),
      'radonTestDate': radonTestDate?.toIso8601String(),
      'pestControlDate': pestControlDate?.toIso8601String(),
      'fireInspectionDate': fireInspectionDate?.toIso8601String(),
      'elevatorInspectionDate': elevatorInspectionDate?.toIso8601String(),
      'poolInspectionDate': poolInspectionDate?.toIso8601String(),
      'lastCodeComplianceDate': lastCodeComplianceDate?.toIso8601String(),
      'accessibilityCompliance': accessibilityCompliance,
      'environmentalHazards': environmentalHazards,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'aiImageAnalyses': aiImageAnalyses.map((e) => e.toJson()).toList(),
      'aiInvestments': aiInvestments.map((e) => e.toJson()).toList(),
      'aiMaintenance': aiMaintenance.map((e) => e.toJson()).toList(),
      'aiDescriptions': aiDescriptions.map((e) => e.toJson()).toList(),
      'aiValuations': aiValuations.map((e) => e.toJson()).toList(),
      'appointments': appointments.map((e) => e.toJson()).toList(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'contracts': contracts.map((e) => e.toJson()).toList(),
      'deals': deals.map((e) => e.toJson()).toList(),
      'generalDocuments': generalDocuments.map((e) => e.toJson()).toList(),
      'events': events.map((e) => e.toJson()).toList(),
      'facilities': facilities.map((e) => e.toJson()).toList(),
      'financialRecords': financialRecords.map((e) => e.toJson()).toList(),
      'floorPlans': floorPlans.map((e) => e.toJson()).toList(),
      'guestReviews': guestReviews.map((e) => e.toJson()).toList(),
      'homeInformationPack': homeInformationPack?.toJson(),
      'investorProperties': investorProperties.map((e) => e.toJson()).toList(),
      'keys': keys.map((e) => e.toJson()).toList(),
      'leads': leads.map((e) => e.toJson()).toList(),
      'ledger': ledger.map((e) => e.toJson()).toList(),
      'listings': listings.map((e) => e.toJson()).toList(),
      'maintenanceBlocks': maintenanceBlocks.map((e) => e.toJson()).toList(),
      'workOrders': workOrders.map((e) => e.toJson()).toList(),
      'mortgageOffers': mortgageOffers.map((e) => e.toJson()).toList(),
      'projects': projects.map((e) => e.toJson()).toList(),
      'location': location?.toJson(),
      'neighborhood': neighborhood?.toJson(),
      'org': org?.toJson(),
      'amenities': amenities.map((e) => e.toJson()).toList(),
      'compliance': compliance.map((e) => e.toJson()).toList(),
      'propertyDisclosure': propertyDisclosure?.toJson(),
      'documents': documents.map((e) => e.toJson()).toList(),
      'inventories': inventories.map((e) => e.toJson()).toList(),
      'propertyOffers': propertyOffers.map((e) => e.toJson()).toList(),
      'valuations': valuations.map((e) => e.toJson()).toList(),
      'viewings': viewings.map((e) => e.toJson()).toList(),
      'quotes': quotes.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'taxDepreciations': taxDepreciations.map((e) => e.toJson()).toList(),
      'tenantApplications': tenantApplications.map((e) => e.toJson()).toList(),
      'vacationRental': vacationRental?.toJson(),
      'virtualTours': virtualTours.map((e) => e.toJson()).toList(),
      'videoContents': videoContents.map((e) => e.toJson()).toList(),
      'agents': agents.map((e) => e.toJson()).toList(),
      'extraCharges': extraCharges.map((e) => e.toJson()).toList(),
      'currencies': currencies.map((e) => e.toJson()).toList(),
      'hashtags': hashtags.map((e) => e.toJson()).toList(),
      'guests': guests.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'includedServices': includedServices.map((e) => e.toJson()).toList(),
      'pricingRules': pricingRules.map((e) => e.toJson()).toList(),
      'discounts': discounts.map((e) => e.toJson()).toList(),
      'propertyPhotos': propertyPhotos.map((e) => e.toJson()).toList(),
      'analytics': analytics.map((e) => e.toJson()).toList(),
      'availabilities': availabilities.map((e) => e.toJson()).toList(),
      'complianceRecords': complianceRecords.map((e) => e.toJson()).toList(),
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'favorites': favorites.map((e) => e.toJson()).toList(),
      'increases': increases.map((e) => e.toJson()).toList(),
      'mentions': mentions.map((e) => e.toJson()).toList(),
      'mortgages': mortgages.map((e) => e.toJson()).toList(),
      'offers': offers.map((e) => e.toJson()).toList(),
      'payments': payments.map((e) => e.toJson()).toList(),
      'photos': photos.map((e) => e.toJson()).toList(),
      'propertyPromotions': propertyPromotions.map((e) => e.toJson()).toList(),
      'tenants': tenants.map((e) => e.toJson()).toList(),
      'includedServiceRelations': includedServiceRelations.map((e) => e.toJson()).toList(),
    };
  }

  Property copyWith({
    String? id,
    String? orgId,
    PropertyType? type,
    String? name,
    Region? region,
    String? currency,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? zip,
    String? country,
    double? lat,
    double? lng,
    String? neighborhoodId,
    int? bedrooms,
    double? bathrooms,
    double? areaSqm,
    int? yearBuilt,
    String? notes,
    String? locationId,
    UsState? stateCode,
    PropertyCategory? propertyCategory,
    ListingType? listingType,
    ListingStatus? listingStatus,
    double? listingPrice,
    double? originalPrice,
    String? schoolDistrict,
    double? hoaFee,
    String? hoaFeeFrequency,
    double? propertyTaxRate,
    double? lastAssessmentValue,
    int? lastAssessmentYear,
    String? floodZone,
    String? zoningCode,
    double? lotSizeAcres,
    double? frontageFeet,
    double? depthFeet,
    String? basementType,
    double? basementFinishedSqFt,
    String? garageType,
    int? garageCapacity,
    int? parkingSpaces,
    String? parkingType,
    String? poolType,
    String? heatingType,
    String? coolingType,
    String? fireplaceType,
    int? fireplaceCount,
    String? viewType,
    String? waterfrontType,
    double? waterfrontFeet,
    String? constructionType,
    String? roofType,
    int? roofYear,
    String? sidingType,
    String? zipPlus4,
    String? countyFIPS,
    String? censusTract,
    String? mlsArea,
    String? propertyClas,
    String? buildingClas,
    int? totalRooms,
    double? livingAreaSqFt,
    double? lotSizeSqFt,
    int? stories,
    int? unitsPerBuilding,
    double? assessedValue,
    double? marketValue,
    double? propertyTax,
    double? insuranceAmount,
    double? mortgageBalance,
    double? lienAmount,
    String? electricityProvider,
    String? gasProvider,
    String? waterProvider,
    String? internetProvider,
    String? trashService,
    String? mlsNumber,
    String? mlsStatus,
    int? daysOnMarket,
    double? pricePerSqFt,
    double? rentalYield,
    int? yearRenovated,
    String? energyRating,
    List<String>? accessibilityFeatures,
    List<String>? smartHomeFeatures,
    List<String>? securityFeatures,
    List<String>? outdoorFeatures,
    String? zoningDescription,
    String? landUse,
    String? buildingRestrictions,
    String? futureDevelopment,
    bool? leadPaintCompliance,
    DateTime? moldInspectionDate,
    DateTime? asbestosInspectionDate,
    DateTime? radonTestDate,
    DateTime? pestControlDate,
    DateTime? fireInspectionDate,
    DateTime? elevatorInspectionDate,
    DateTime? poolInspectionDate,
    DateTime? lastCodeComplianceDate,
    bool? accessibilityCompliance,
    List<String>? environmentalHazards,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<AiImageAnalysis>? aiImageAnalyses,
    List<AiInvestmentAnalysis>? aiInvestments,
    List<AiPredictiveMaintenance>? aiMaintenance,
    List<AiPropertyDescription>? aiDescriptions,
    List<AiPropertyValuation>? aiValuations,
    List<Appointment>? appointments,
    List<Attachment>? attachments,
    List<Contract>? contracts,
    List<Deal>? deals,
    List<Document>? generalDocuments,
    List<Event>? events,
    List<Facility>? facilities,
    List<FinancialRecord>? financialRecords,
    List<FloorPlan>? floorPlans,
    List<GuestReview>? guestReviews,
    HomeInformationPack? homeInformationPack,
    List<InvestorProperty>? investorProperties,
    List<KeyManagement>? keys,
    List<Lead>? leads,
    List<LedgerEntry>? ledger,
    List<Listing>? listings,
    List<MaintenanceBlock>? maintenanceBlocks,
    List<MaintenanceWorkOrder>? workOrders,
    List<MortgageOffer>? mortgageOffers,
    List<Project>? projects,
    Location? location,
    Neighborhood? neighborhood,
    Organization? org,
    List<PropertyAmenity>? amenities,
    List<PropertyCompliance>? compliance,
    PropertyDisclosure? propertyDisclosure,
    List<PropertyDocument>? documents,
    List<PropertyInventory>? inventories,
    List<PropertyOffer>? propertyOffers,
    List<PropertyValuation>? valuations,
    List<PropertyViewing>? viewings,
    List<Quote>? quotes,
    List<Task>? tasks,
    List<TaxDepreciation>? taxDepreciations,
    List<TenantApplication>? tenantApplications,
    VacationRental? vacationRental,
    List<VirtualTour>? virtualTours,
    List<VideoContent>? videoContents,
    List<Agent>? agents,
    List<ExtraCharge>? extraCharges,
    List<Currency>? currencies,
    List<Hashtag>? hashtags,
    List<Guest>? guests,
    List<Agency>? agencies,
    List<IncludedService>? includedServices,
    List<PricingRule>? pricingRules,
    List<Discount>? discounts,
    List<PropertyPhoto>? propertyPhotos,
    List<Analytics>? analytics,
    List<Availability>? availabilities,
    List<ComplianceRecord>? complianceRecords,
    List<Expense>? expenses,
    List<Favorite>? favorites,
    List<Increase>? increases,
    List<Mention>? mentions,
    List<Mortgage>? mortgages,
    List<Offer>? offers,
    List<Payment>? payments,
    List<Photo>? photos,
    List<PropertyPromotion>? propertyPromotions,
    List<Tenant>? tenants,
    List<IncludedService>? includedServiceRelations,
  }) {
    return Property(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      type: type ?? this.type,
      name: name ?? this.name,
      region: region ?? this.region,
      currency: currency ?? this.currency,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      neighborhoodId: neighborhoodId ?? this.neighborhoodId,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      areaSqm: areaSqm ?? this.areaSqm,
      yearBuilt: yearBuilt ?? this.yearBuilt,
      notes: notes ?? this.notes,
      locationId: locationId ?? this.locationId,
      stateCode: stateCode ?? this.stateCode,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      listingType: listingType ?? this.listingType,
      listingStatus: listingStatus ?? this.listingStatus,
      listingPrice: listingPrice ?? this.listingPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      schoolDistrict: schoolDistrict ?? this.schoolDistrict,
      hoaFee: hoaFee ?? this.hoaFee,
      hoaFeeFrequency: hoaFeeFrequency ?? this.hoaFeeFrequency,
      propertyTaxRate: propertyTaxRate ?? this.propertyTaxRate,
      lastAssessmentValue: lastAssessmentValue ?? this.lastAssessmentValue,
      lastAssessmentYear: lastAssessmentYear ?? this.lastAssessmentYear,
      floodZone: floodZone ?? this.floodZone,
      zoningCode: zoningCode ?? this.zoningCode,
      lotSizeAcres: lotSizeAcres ?? this.lotSizeAcres,
      frontageFeet: frontageFeet ?? this.frontageFeet,
      depthFeet: depthFeet ?? this.depthFeet,
      basementType: basementType ?? this.basementType,
      basementFinishedSqFt: basementFinishedSqFt ?? this.basementFinishedSqFt,
      garageType: garageType ?? this.garageType,
      garageCapacity: garageCapacity ?? this.garageCapacity,
      parkingSpaces: parkingSpaces ?? this.parkingSpaces,
      parkingType: parkingType ?? this.parkingType,
      poolType: poolType ?? this.poolType,
      heatingType: heatingType ?? this.heatingType,
      coolingType: coolingType ?? this.coolingType,
      fireplaceType: fireplaceType ?? this.fireplaceType,
      fireplaceCount: fireplaceCount ?? this.fireplaceCount,
      viewType: viewType ?? this.viewType,
      waterfrontType: waterfrontType ?? this.waterfrontType,
      waterfrontFeet: waterfrontFeet ?? this.waterfrontFeet,
      constructionType: constructionType ?? this.constructionType,
      roofType: roofType ?? this.roofType,
      roofYear: roofYear ?? this.roofYear,
      sidingType: sidingType ?? this.sidingType,
      zipPlus4: zipPlus4 ?? this.zipPlus4,
      countyFIPS: countyFIPS ?? this.countyFIPS,
      censusTract: censusTract ?? this.censusTract,
      mlsArea: mlsArea ?? this.mlsArea,
      propertyClas: propertyClas ?? this.propertyClas,
      buildingClas: buildingClas ?? this.buildingClas,
      totalRooms: totalRooms ?? this.totalRooms,
      livingAreaSqFt: livingAreaSqFt ?? this.livingAreaSqFt,
      lotSizeSqFt: lotSizeSqFt ?? this.lotSizeSqFt,
      stories: stories ?? this.stories,
      unitsPerBuilding: unitsPerBuilding ?? this.unitsPerBuilding,
      assessedValue: assessedValue ?? this.assessedValue,
      marketValue: marketValue ?? this.marketValue,
      propertyTax: propertyTax ?? this.propertyTax,
      insuranceAmount: insuranceAmount ?? this.insuranceAmount,
      mortgageBalance: mortgageBalance ?? this.mortgageBalance,
      lienAmount: lienAmount ?? this.lienAmount,
      electricityProvider: electricityProvider ?? this.electricityProvider,
      gasProvider: gasProvider ?? this.gasProvider,
      waterProvider: waterProvider ?? this.waterProvider,
      internetProvider: internetProvider ?? this.internetProvider,
      trashService: trashService ?? this.trashService,
      mlsNumber: mlsNumber ?? this.mlsNumber,
      mlsStatus: mlsStatus ?? this.mlsStatus,
      daysOnMarket: daysOnMarket ?? this.daysOnMarket,
      pricePerSqFt: pricePerSqFt ?? this.pricePerSqFt,
      rentalYield: rentalYield ?? this.rentalYield,
      yearRenovated: yearRenovated ?? this.yearRenovated,
      energyRating: energyRating ?? this.energyRating,
      accessibilityFeatures: accessibilityFeatures ?? this.accessibilityFeatures,
      smartHomeFeatures: smartHomeFeatures ?? this.smartHomeFeatures,
      securityFeatures: securityFeatures ?? this.securityFeatures,
      outdoorFeatures: outdoorFeatures ?? this.outdoorFeatures,
      zoningDescription: zoningDescription ?? this.zoningDescription,
      landUse: landUse ?? this.landUse,
      buildingRestrictions: buildingRestrictions ?? this.buildingRestrictions,
      futureDevelopment: futureDevelopment ?? this.futureDevelopment,
      leadPaintCompliance: leadPaintCompliance ?? this.leadPaintCompliance,
      moldInspectionDate: moldInspectionDate ?? this.moldInspectionDate,
      asbestosInspectionDate: asbestosInspectionDate ?? this.asbestosInspectionDate,
      radonTestDate: radonTestDate ?? this.radonTestDate,
      pestControlDate: pestControlDate ?? this.pestControlDate,
      fireInspectionDate: fireInspectionDate ?? this.fireInspectionDate,
      elevatorInspectionDate: elevatorInspectionDate ?? this.elevatorInspectionDate,
      poolInspectionDate: poolInspectionDate ?? this.poolInspectionDate,
      lastCodeComplianceDate: lastCodeComplianceDate ?? this.lastCodeComplianceDate,
      accessibilityCompliance: accessibilityCompliance ?? this.accessibilityCompliance,
      environmentalHazards: environmentalHazards ?? this.environmentalHazards,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      aiImageAnalyses: aiImageAnalyses ?? this.aiImageAnalyses,
      aiInvestments: aiInvestments ?? this.aiInvestments,
      aiMaintenance: aiMaintenance ?? this.aiMaintenance,
      aiDescriptions: aiDescriptions ?? this.aiDescriptions,
      aiValuations: aiValuations ?? this.aiValuations,
      appointments: appointments ?? this.appointments,
      attachments: attachments ?? this.attachments,
      contracts: contracts ?? this.contracts,
      deals: deals ?? this.deals,
      generalDocuments: generalDocuments ?? this.generalDocuments,
      events: events ?? this.events,
      facilities: facilities ?? this.facilities,
      financialRecords: financialRecords ?? this.financialRecords,
      floorPlans: floorPlans ?? this.floorPlans,
      guestReviews: guestReviews ?? this.guestReviews,
      homeInformationPack: homeInformationPack ?? this.homeInformationPack,
      investorProperties: investorProperties ?? this.investorProperties,
      keys: keys ?? this.keys,
      leads: leads ?? this.leads,
      ledger: ledger ?? this.ledger,
      listings: listings ?? this.listings,
      maintenanceBlocks: maintenanceBlocks ?? this.maintenanceBlocks,
      workOrders: workOrders ?? this.workOrders,
      mortgageOffers: mortgageOffers ?? this.mortgageOffers,
      projects: projects ?? this.projects,
      location: location ?? this.location,
      neighborhood: neighborhood ?? this.neighborhood,
      org: org ?? this.org,
      amenities: amenities ?? this.amenities,
      compliance: compliance ?? this.compliance,
      propertyDisclosure: propertyDisclosure ?? this.propertyDisclosure,
      documents: documents ?? this.documents,
      inventories: inventories ?? this.inventories,
      propertyOffers: propertyOffers ?? this.propertyOffers,
      valuations: valuations ?? this.valuations,
      viewings: viewings ?? this.viewings,
      quotes: quotes ?? this.quotes,
      tasks: tasks ?? this.tasks,
      taxDepreciations: taxDepreciations ?? this.taxDepreciations,
      tenantApplications: tenantApplications ?? this.tenantApplications,
      vacationRental: vacationRental ?? this.vacationRental,
      virtualTours: virtualTours ?? this.virtualTours,
      videoContents: videoContents ?? this.videoContents,
      agents: agents ?? this.agents,
      extraCharges: extraCharges ?? this.extraCharges,
      currencies: currencies ?? this.currencies,
      hashtags: hashtags ?? this.hashtags,
      guests: guests ?? this.guests,
      agencies: agencies ?? this.agencies,
      includedServices: includedServices ?? this.includedServices,
      pricingRules: pricingRules ?? this.pricingRules,
      discounts: discounts ?? this.discounts,
      propertyPhotos: propertyPhotos ?? this.propertyPhotos,
      analytics: analytics ?? this.analytics,
      availabilities: availabilities ?? this.availabilities,
      complianceRecords: complianceRecords ?? this.complianceRecords,
      expenses: expenses ?? this.expenses,
      favorites: favorites ?? this.favorites,
      increases: increases ?? this.increases,
      mentions: mentions ?? this.mentions,
      mortgages: mortgages ?? this.mortgages,
      offers: offers ?? this.offers,
      payments: payments ?? this.payments,
      photos: photos ?? this.photos,
      propertyPromotions: propertyPromotions ?? this.propertyPromotions,
      tenants: tenants ?? this.tenants,
      includedServiceRelations: includedServiceRelations ?? this.includedServiceRelations,
    );
  }
}
