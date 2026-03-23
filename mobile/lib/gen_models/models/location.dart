
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'location_accuracy.dart';
import 'geocoding_status.dart';
import 'map_provider.dart';
import 'marker_type.dart';
import 'marker_icon.dart';
import 'deal.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'route.dart';
import 'agency.dart';
import 'agent.dart';


class Location implements PrismaModel<String, Location> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? dealId;
	String? addressLine1;
	String? addressLine2;
	String? addressLine3;
	String? city;
	String? state;
	String? zip;
	String? zipPlus4;
	String? country;
	String? stateName;
	String? stateFIPS;
	String? censusTract;
	String? blockGroup;
	String? precinct;
	String? schoolDistrict;
	String? congressionalDistrict;
	double? latitude;
	double? longitude;
	LocationAccuracy? accuracy;
	double? altitude;
	double? elevation;
	GeocodingStatus? geocodingStatus;
	DateTime? geocodedAt;
	MapProvider? geocodingProvider;
	double? confidenceScore;
	bool? isVerified;
	DateTime? verifiedAt;
	String? verifiedBy;
	bool? uspsVerified;
	DateTime? uspsVerifiedAt;
	String? dpvConfirmation;
	String? footnotes;
	bool? isStandardized;
	bool? isResidential;
	bool? isCommercial;
	bool? isValid;
	MarkerType? markerType;
	MarkerIcon? markerIcon;
	String? markerColor;
	int? markerSize;
	bool? isVisible;
	int? zIndex;
	double? opacity;
	String? title;
	String? description;
	String? imageUrl;
	String? linkUrl;
	String? category;
	List<String>? tags;
	String? mondayOpen;
	String? mondayClose;
	String? tuesdayOpen;
	String? tuesdayClose;
	String? wednesdayOpen;
	String? wednesdayClose;
	String? thursdayOpen;
	String? thursdayClose;
	String? fridayOpen;
	String? fridayClose;
	String? saturdayOpen;
	String? saturdayClose;
	String? sundayOpen;
	String? sundayClose;
	dynamic metadata;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Deal? deal;
	Listing? listing;
	Organization? org;
	Property? property;
	List<Route>? endRoutes;
	List<Route>? startRoutes;
	List<Agency>? agencies;
	List<Agent>? agents;
	int? $tagsCount;
	int? $endRoutesCount;
	int? $startRoutesCount;
	int? $agenciesCount;
	int? $agentsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Location({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.dealId,
	 this.addressLine1,
	 this.addressLine2,
	 this.addressLine3,
	 this.city,
	 this.state,
	 this.zip,
	 this.zipPlus4,
	 this.country = "US",
	 this.stateName,
	 this.stateFIPS,
	 this.censusTract,
	 this.blockGroup,
	 this.precinct,
	 this.schoolDistrict,
	 this.congressionalDistrict,
	 this.latitude,
	 this.longitude,
	 this.accuracy = LocationAccuracy.EXACT,
	 this.altitude,
	 this.elevation,
	 this.geocodingStatus = GeocodingStatus.PENDING,
	 this.geocodedAt,
	 this.geocodingProvider,
	 this.confidenceScore,
	 this.isVerified = false,
	 this.verifiedAt,
	 this.verifiedBy,
	 this.uspsVerified = false,
	 this.uspsVerifiedAt,
	 this.dpvConfirmation,
	 this.footnotes,
	 this.isStandardized = false,
	 this.isResidential = true,
	 this.isCommercial = false,
	 this.isValid = true,
	 this.markerType,
	 this.markerIcon,
	 this.markerColor,
	 this.markerSize = 32,
	 this.isVisible = true,
	 this.zIndex = 0,
	 this.opacity = 1,
	 this.title,
	 this.description,
	 this.imageUrl,
	 this.linkUrl,
	 this.category,
	 this.tags,
	 this.mondayOpen,
	 this.mondayClose,
	 this.tuesdayOpen,
	 this.tuesdayClose,
	 this.wednesdayOpen,
	 this.wednesdayClose,
	 this.thursdayOpen,
	 this.thursdayClose,
	 this.fridayOpen,
	 this.fridayClose,
	 this.saturdayOpen,
	 this.saturdayClose,
	 this.sundayOpen,
	 this.sundayClose,
	required this.metadata,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.deal,
	 this.listing,
	 this.org,
	 this.property,
	 this.endRoutes,
	 this.startRoutes,
	 this.agencies,
	 this.agents,
	this.$tagsCount,
	this.$endRoutesCount,
	this.$startRoutesCount,
	this.$agenciesCount,
	this.$agentsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Location, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"dealId": (m) => m.dealId,

	"addressLine1": (m) => m.addressLine1,

	"addressLine2": (m) => m.addressLine2,

	"addressLine3": (m) => m.addressLine3,

	"city": (m) => m.city,

	"state": (m) => m.state,

	"zip": (m) => m.zip,

	"zipPlus4": (m) => m.zipPlus4,

	"country": (m) => m.country,

	"stateName": (m) => m.stateName,

	"stateFIPS": (m) => m.stateFIPS,

	"censusTract": (m) => m.censusTract,

	"blockGroup": (m) => m.blockGroup,

	"precinct": (m) => m.precinct,

	"schoolDistrict": (m) => m.schoolDistrict,

	"congressionalDistrict": (m) => m.congressionalDistrict,

	"latitude": (m) => m.latitude,

	"longitude": (m) => m.longitude,

	"accuracy": (m) => m.accuracy,

	"altitude": (m) => m.altitude,

	"elevation": (m) => m.elevation,

	"geocodingStatus": (m) => m.geocodingStatus,

	"geocodedAt": (m) => m.geocodedAt,

	"geocodingProvider": (m) => m.geocodingProvider,

	"confidenceScore": (m) => m.confidenceScore,

	"isVerified": (m) => m.isVerified,

	"verifiedAt": (m) => m.verifiedAt,

	"verifiedBy": (m) => m.verifiedBy,

	"uspsVerified": (m) => m.uspsVerified,

	"uspsVerifiedAt": (m) => m.uspsVerifiedAt,

	"dpvConfirmation": (m) => m.dpvConfirmation,

	"footnotes": (m) => m.footnotes,

	"isStandardized": (m) => m.isStandardized,

	"isResidential": (m) => m.isResidential,

	"isCommercial": (m) => m.isCommercial,

	"isValid": (m) => m.isValid,

	"markerType": (m) => m.markerType,

	"markerIcon": (m) => m.markerIcon,

	"markerColor": (m) => m.markerColor,

	"markerSize": (m) => m.markerSize,

	"isVisible": (m) => m.isVisible,

	"zIndex": (m) => m.zIndex,

	"opacity": (m) => m.opacity,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"imageUrl": (m) => m.imageUrl,

	"linkUrl": (m) => m.linkUrl,

	"category": (m) => m.category,

	"tags": (m) => m.tags,

	"mondayOpen": (m) => m.mondayOpen,

	"mondayClose": (m) => m.mondayClose,

	"tuesdayOpen": (m) => m.tuesdayOpen,

	"tuesdayClose": (m) => m.tuesdayClose,

	"wednesdayOpen": (m) => m.wednesdayOpen,

	"wednesdayClose": (m) => m.wednesdayClose,

	"thursdayOpen": (m) => m.thursdayOpen,

	"thursdayClose": (m) => m.thursdayClose,

	"fridayOpen": (m) => m.fridayOpen,

	"fridayClose": (m) => m.fridayClose,

	"saturdayOpen": (m) => m.saturdayOpen,

	"saturdayClose": (m) => m.saturdayClose,

	"sundayOpen": (m) => m.sundayOpen,

	"sundayClose": (m) => m.sundayClose,

	"metadata": (m) => m.metadata,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"deal": (m) => m.deal,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"endRoutes": (m) => m.endRoutes,

	"startRoutes": (m) => m.startRoutes,

	"agencies": (m) => m.agencies,

	"agents": (m) => m.agents,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Location) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Location');
    }
    return propFunction as V? Function(Location);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Location.fromJson(JsonMap json) =>
      Location(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	dealId: json['dealId'] as String?,
	addressLine1: json['addressLine1'] as String?,
	addressLine2: json['addressLine2'] as String?,
	addressLine3: json['addressLine3'] as String?,
	city: json['city'] as String?,
	state: json['state'] as String?,
	zip: json['zip'] as String?,
	zipPlus4: json['zipPlus4'] as String?,
	country: json['country'] as String?,
	stateName: json['stateName'] as String?,
	stateFIPS: json['stateFIPS'] as String?,
	censusTract: json['censusTract'] as String?,
	blockGroup: json['blockGroup'] as String?,
	precinct: json['precinct'] as String?,
	schoolDistrict: json['schoolDistrict'] as String?,
	congressionalDistrict: json['congressionalDistrict'] as String?,
	latitude: json['latitude']?.toDouble(),
	longitude: json['longitude']?.toDouble(),
	accuracy: json['accuracy'] != null ? LocationAccuracy.fromJson(json['accuracy']) : null,
	altitude: json['altitude']?.toDouble(),
	elevation: json['elevation']?.toDouble(),
	geocodingStatus: json['geocodingStatus'] != null ? GeocodingStatus.fromJson(json['geocodingStatus']) : null,
	geocodedAt: json['geocodedAt'] != null ? DateTime.parse(json['geocodedAt']) : null,
	geocodingProvider: json['geocodingProvider'] != null ? MapProvider.fromJson(json['geocodingProvider']) : null,
	confidenceScore: json['confidenceScore']?.toDouble(),
	isVerified: json['isVerified'] as bool?,
	verifiedAt: json['verifiedAt'] != null ? DateTime.parse(json['verifiedAt']) : null,
	verifiedBy: json['verifiedBy'] as String?,
	uspsVerified: json['uspsVerified'] as bool?,
	uspsVerifiedAt: json['uspsVerifiedAt'] != null ? DateTime.parse(json['uspsVerifiedAt']) : null,
	dpvConfirmation: json['dpvConfirmation'] as String?,
	footnotes: json['footnotes'] as String?,
	isStandardized: json['isStandardized'] as bool?,
	isResidential: json['isResidential'] as bool?,
	isCommercial: json['isCommercial'] as bool?,
	isValid: json['isValid'] as bool?,
	markerType: json['markerType'] != null ? MarkerType.fromJson(json['markerType']) : null,
	markerIcon: json['markerIcon'] != null ? MarkerIcon.fromJson(json['markerIcon']) : null,
	markerColor: json['markerColor'] as String?,
	markerSize: int.tryParse(json['markerSize'].toString()),
	isVisible: json['isVisible'] as bool?,
	zIndex: int.tryParse(json['zIndex'].toString()),
	opacity: json['opacity']?.toDouble(),
	title: json['title'] as String?,
	description: json['description'] as String?,
	imageUrl: json['imageUrl'] as String?,
	linkUrl: json['linkUrl'] as String?,
	category: json['category'] as String?,
	tags: json['tags'] != null ? (json['tags'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	mondayOpen: json['mondayOpen'] as String?,
	mondayClose: json['mondayClose'] as String?,
	tuesdayOpen: json['tuesdayOpen'] as String?,
	tuesdayClose: json['tuesdayClose'] as String?,
	wednesdayOpen: json['wednesdayOpen'] as String?,
	wednesdayClose: json['wednesdayClose'] as String?,
	thursdayOpen: json['thursdayOpen'] as String?,
	thursdayClose: json['thursdayClose'] as String?,
	fridayOpen: json['fridayOpen'] as String?,
	fridayClose: json['fridayClose'] as String?,
	saturdayOpen: json['saturdayOpen'] as String?,
	saturdayClose: json['saturdayClose'] as String?,
	sundayOpen: json['sundayOpen'] as String?,
	sundayClose: json['sundayClose'] as String?,
	metadata: json['metadata'] as dynamic,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	deal: json['deal'] != null ? Deal.fromJson(json['deal'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	endRoutes: json['endRoutes'] != null ? createModels<Route>((json['endRoutes'] as List).cast<JsonMap>(), Route.fromJson) : null,
	startRoutes: json['startRoutes'] != null ? createModels<Route>((json['startRoutes'] as List).cast<JsonMap>(), Route.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	agents: json['agents'] != null ? createModels<Agent>((json['agents'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	$tagsCount: json['_count']?['tags'] as int?,
	$endRoutesCount: json['_count']?['endRoutes'] as int?,
	$startRoutesCount: json['_count']?['startRoutes'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$agentsCount: json['_count']?['agents'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Location copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? dealId,
		Value<String?>? addressLine1,
		Value<String?>? addressLine2,
		Value<String?>? addressLine3,
		Value<String?>? city,
		Value<String?>? state,
		Value<String?>? zip,
		Value<String?>? zipPlus4,
		Value<String?>? country,
		Value<String?>? stateName,
		Value<String?>? stateFIPS,
		Value<String?>? censusTract,
		Value<String?>? blockGroup,
		Value<String?>? precinct,
		Value<String?>? schoolDistrict,
		Value<String?>? congressionalDistrict,
		Value<double?>? latitude,
		Value<double?>? longitude,
		Value<LocationAccuracy?>? accuracy,
		Value<double?>? altitude,
		Value<double?>? elevation,
		Value<GeocodingStatus?>? geocodingStatus,
		Value<DateTime?>? geocodedAt,
		Value<MapProvider?>? geocodingProvider,
		Value<double?>? confidenceScore,
		Value<bool?>? isVerified,
		Value<DateTime?>? verifiedAt,
		Value<String?>? verifiedBy,
		Value<bool?>? uspsVerified,
		Value<DateTime?>? uspsVerifiedAt,
		Value<String?>? dpvConfirmation,
		Value<String?>? footnotes,
		Value<bool?>? isStandardized,
		Value<bool?>? isResidential,
		Value<bool?>? isCommercial,
		Value<bool?>? isValid,
		Value<MarkerType?>? markerType,
		Value<MarkerIcon?>? markerIcon,
		Value<String?>? markerColor,
		Value<int?>? markerSize,
		Value<bool?>? isVisible,
		Value<int?>? zIndex,
		Value<double?>? opacity,
		Value<String?>? title,
		Value<String?>? description,
		Value<String?>? imageUrl,
		Value<String?>? linkUrl,
		Value<String?>? category,
		Value<List<String>?>? tags,
		Value<String?>? mondayOpen,
		Value<String?>? mondayClose,
		Value<String?>? tuesdayOpen,
		Value<String?>? tuesdayClose,
		Value<String?>? wednesdayOpen,
		Value<String?>? wednesdayClose,
		Value<String?>? thursdayOpen,
		Value<String?>? thursdayClose,
		Value<String?>? fridayOpen,
		Value<String?>? fridayClose,
		Value<String?>? saturdayOpen,
		Value<String?>? saturdayClose,
		Value<String?>? sundayOpen,
		Value<String?>? sundayClose,
		Value<dynamic>? metadata,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Deal?>? deal,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<List<Route>?>? endRoutes,
		Value<List<Route>?>? startRoutes,
		Value<List<Agency>?>? agencies,
		Value<List<Agent>?>? agents,
		int? $tagsCount,
		int? $endRoutesCount,
		int? $startRoutesCount,
		int? $agenciesCount,
		int? $agentsCount,
        }) {
        return Location(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		dealId: dealId != null ? dealId.value : this.dealId,
		addressLine1: addressLine1 != null ? addressLine1.value : this.addressLine1,
		addressLine2: addressLine2 != null ? addressLine2.value : this.addressLine2,
		addressLine3: addressLine3 != null ? addressLine3.value : this.addressLine3,
		city: city != null ? city.value : this.city,
		state: state != null ? state.value : this.state,
		zip: zip != null ? zip.value : this.zip,
		zipPlus4: zipPlus4 != null ? zipPlus4.value : this.zipPlus4,
		country: country != null ? country.value : this.country,
		stateName: stateName != null ? stateName.value : this.stateName,
		stateFIPS: stateFIPS != null ? stateFIPS.value : this.stateFIPS,
		censusTract: censusTract != null ? censusTract.value : this.censusTract,
		blockGroup: blockGroup != null ? blockGroup.value : this.blockGroup,
		precinct: precinct != null ? precinct.value : this.precinct,
		schoolDistrict: schoolDistrict != null ? schoolDistrict.value : this.schoolDistrict,
		congressionalDistrict: congressionalDistrict != null ? congressionalDistrict.value : this.congressionalDistrict,
		latitude: latitude != null ? latitude.value : this.latitude,
		longitude: longitude != null ? longitude.value : this.longitude,
		accuracy: accuracy != null ? accuracy.value : this.accuracy,
		altitude: altitude != null ? altitude.value : this.altitude,
		elevation: elevation != null ? elevation.value : this.elevation,
		geocodingStatus: geocodingStatus != null ? geocodingStatus.value : this.geocodingStatus,
		geocodedAt: geocodedAt != null ? geocodedAt.value : this.geocodedAt,
		geocodingProvider: geocodingProvider != null ? geocodingProvider.value : this.geocodingProvider,
		confidenceScore: confidenceScore != null ? confidenceScore.value : this.confidenceScore,
		isVerified: isVerified != null ? isVerified.value : this.isVerified,
		verifiedAt: verifiedAt != null ? verifiedAt.value : this.verifiedAt,
		verifiedBy: verifiedBy != null ? verifiedBy.value : this.verifiedBy,
		uspsVerified: uspsVerified != null ? uspsVerified.value : this.uspsVerified,
		uspsVerifiedAt: uspsVerifiedAt != null ? uspsVerifiedAt.value : this.uspsVerifiedAt,
		dpvConfirmation: dpvConfirmation != null ? dpvConfirmation.value : this.dpvConfirmation,
		footnotes: footnotes != null ? footnotes.value : this.footnotes,
		isStandardized: isStandardized != null ? isStandardized.value : this.isStandardized,
		isResidential: isResidential != null ? isResidential.value : this.isResidential,
		isCommercial: isCommercial != null ? isCommercial.value : this.isCommercial,
		isValid: isValid != null ? isValid.value : this.isValid,
		markerType: markerType != null ? markerType.value : this.markerType,
		markerIcon: markerIcon != null ? markerIcon.value : this.markerIcon,
		markerColor: markerColor != null ? markerColor.value : this.markerColor,
		markerSize: markerSize != null ? markerSize.value : this.markerSize,
		isVisible: isVisible != null ? isVisible.value : this.isVisible,
		zIndex: zIndex != null ? zIndex.value : this.zIndex,
		opacity: opacity != null ? opacity.value : this.opacity,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		imageUrl: imageUrl != null ? imageUrl.value : this.imageUrl,
		linkUrl: linkUrl != null ? linkUrl.value : this.linkUrl,
		category: category != null ? category.value : this.category,
		tags: tags != null ? tags.value : this.tags,
		mondayOpen: mondayOpen != null ? mondayOpen.value : this.mondayOpen,
		mondayClose: mondayClose != null ? mondayClose.value : this.mondayClose,
		tuesdayOpen: tuesdayOpen != null ? tuesdayOpen.value : this.tuesdayOpen,
		tuesdayClose: tuesdayClose != null ? tuesdayClose.value : this.tuesdayClose,
		wednesdayOpen: wednesdayOpen != null ? wednesdayOpen.value : this.wednesdayOpen,
		wednesdayClose: wednesdayClose != null ? wednesdayClose.value : this.wednesdayClose,
		thursdayOpen: thursdayOpen != null ? thursdayOpen.value : this.thursdayOpen,
		thursdayClose: thursdayClose != null ? thursdayClose.value : this.thursdayClose,
		fridayOpen: fridayOpen != null ? fridayOpen.value : this.fridayOpen,
		fridayClose: fridayClose != null ? fridayClose.value : this.fridayClose,
		saturdayOpen: saturdayOpen != null ? saturdayOpen.value : this.saturdayOpen,
		saturdayClose: saturdayClose != null ? saturdayClose.value : this.saturdayClose,
		sundayOpen: sundayOpen != null ? sundayOpen.value : this.sundayOpen,
		sundayClose: sundayClose != null ? sundayClose.value : this.sundayClose,
		metadata: metadata != null ? metadata.value : this.metadata,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		deal: deal != null ? deal.value : this.deal,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		endRoutes: endRoutes != null ? endRoutes.value : this.endRoutes,
		startRoutes: startRoutes != null ? startRoutes.value : this.startRoutes,
		agencies: agencies != null ? agencies.value : this.agencies,
		agents: agents != null ? agents.value : this.agents,
		$tagsCount: $tagsCount ?? this.$tagsCount,
		$endRoutesCount: $endRoutesCount ?? this.$endRoutesCount,
		$startRoutesCount: $startRoutesCount ?? this.$startRoutesCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$agentsCount: $agentsCount ?? this.$agentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Location copyWithInstanceValues(Location location) {
        return Location(
            id: location.id ?? id,
		orgId: location.orgId ?? orgId,
		propertyId: location.propertyId ?? propertyId,
		listingId: location.listingId ?? listingId,
		dealId: location.dealId ?? dealId,
		addressLine1: location.addressLine1 ?? addressLine1,
		addressLine2: location.addressLine2 ?? addressLine2,
		addressLine3: location.addressLine3 ?? addressLine3,
		city: location.city ?? city,
		state: location.state ?? state,
		zip: location.zip ?? zip,
		zipPlus4: location.zipPlus4 ?? zipPlus4,
		country: location.country ?? country,
		stateName: location.stateName ?? stateName,
		stateFIPS: location.stateFIPS ?? stateFIPS,
		censusTract: location.censusTract ?? censusTract,
		blockGroup: location.blockGroup ?? blockGroup,
		precinct: location.precinct ?? precinct,
		schoolDistrict: location.schoolDistrict ?? schoolDistrict,
		congressionalDistrict: location.congressionalDistrict ?? congressionalDistrict,
		latitude: location.latitude ?? latitude,
		longitude: location.longitude ?? longitude,
		accuracy: location.accuracy ?? accuracy,
		altitude: location.altitude ?? altitude,
		elevation: location.elevation ?? elevation,
		geocodingStatus: location.geocodingStatus ?? geocodingStatus,
		geocodedAt: location.geocodedAt ?? geocodedAt,
		geocodingProvider: location.geocodingProvider ?? geocodingProvider,
		confidenceScore: location.confidenceScore ?? confidenceScore,
		isVerified: location.isVerified ?? isVerified,
		verifiedAt: location.verifiedAt ?? verifiedAt,
		verifiedBy: location.verifiedBy ?? verifiedBy,
		uspsVerified: location.uspsVerified ?? uspsVerified,
		uspsVerifiedAt: location.uspsVerifiedAt ?? uspsVerifiedAt,
		dpvConfirmation: location.dpvConfirmation ?? dpvConfirmation,
		footnotes: location.footnotes ?? footnotes,
		isStandardized: location.isStandardized ?? isStandardized,
		isResidential: location.isResidential ?? isResidential,
		isCommercial: location.isCommercial ?? isCommercial,
		isValid: location.isValid ?? isValid,
		markerType: location.markerType ?? markerType,
		markerIcon: location.markerIcon ?? markerIcon,
		markerColor: location.markerColor ?? markerColor,
		markerSize: location.markerSize ?? markerSize,
		isVisible: location.isVisible ?? isVisible,
		zIndex: location.zIndex ?? zIndex,
		opacity: location.opacity ?? opacity,
		title: location.title ?? title,
		description: location.description ?? description,
		imageUrl: location.imageUrl ?? imageUrl,
		linkUrl: location.linkUrl ?? linkUrl,
		category: location.category ?? category,
		tags: location.tags ?? tags,
		mondayOpen: location.mondayOpen ?? mondayOpen,
		mondayClose: location.mondayClose ?? mondayClose,
		tuesdayOpen: location.tuesdayOpen ?? tuesdayOpen,
		tuesdayClose: location.tuesdayClose ?? tuesdayClose,
		wednesdayOpen: location.wednesdayOpen ?? wednesdayOpen,
		wednesdayClose: location.wednesdayClose ?? wednesdayClose,
		thursdayOpen: location.thursdayOpen ?? thursdayOpen,
		thursdayClose: location.thursdayClose ?? thursdayClose,
		fridayOpen: location.fridayOpen ?? fridayOpen,
		fridayClose: location.fridayClose ?? fridayClose,
		saturdayOpen: location.saturdayOpen ?? saturdayOpen,
		saturdayClose: location.saturdayClose ?? saturdayClose,
		sundayOpen: location.sundayOpen ?? sundayOpen,
		sundayClose: location.sundayClose ?? sundayClose,
		metadata: location.metadata ?? metadata,
		createdBy: location.createdBy ?? createdBy,
		createdAt: location.createdAt ?? createdAt,
		updatedAt: location.updatedAt ?? updatedAt,
		deletedAt: location.deletedAt ?? deletedAt,
		deal: location.deal ?? deal,
		listing: location.listing ?? listing,
		org: location.org ?? org,
		property: location.property ?? property,
		endRoutes: location.endRoutes ?? endRoutes,
		startRoutes: location.startRoutes ?? startRoutes,
		agencies: location.agencies ?? agencies,
		agents: location.agents ?? agents,
		$tagsCount: location.$tagsCount ?? $tagsCount,
		$endRoutesCount: location.$endRoutesCount ?? $endRoutesCount,
		$startRoutesCount: location.$startRoutesCount ?? $startRoutesCount,
		$agenciesCount: location.$agenciesCount ?? $agenciesCount,
		$agentsCount: location.$agentsCount ?? $agentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Location mergeWithInstanceValues(Location location) {
        return Location(
            id: location.$assignedFields.contains('id') ? location.id : id,
		orgId: location.$assignedFields.contains('orgId') ? location.orgId : orgId,
		propertyId: location.$assignedFields.contains('propertyId') ? location.propertyId : propertyId,
		listingId: location.$assignedFields.contains('listingId') ? location.listingId : listingId,
		dealId: location.$assignedFields.contains('dealId') ? location.dealId : dealId,
		addressLine1: location.$assignedFields.contains('addressLine1') ? location.addressLine1 : addressLine1,
		addressLine2: location.$assignedFields.contains('addressLine2') ? location.addressLine2 : addressLine2,
		addressLine3: location.$assignedFields.contains('addressLine3') ? location.addressLine3 : addressLine3,
		city: location.$assignedFields.contains('city') ? location.city : city,
		state: location.$assignedFields.contains('state') ? location.state : state,
		zip: location.$assignedFields.contains('zip') ? location.zip : zip,
		zipPlus4: location.$assignedFields.contains('zipPlus4') ? location.zipPlus4 : zipPlus4,
		country: location.$assignedFields.contains('country') ? location.country : country,
		stateName: location.$assignedFields.contains('stateName') ? location.stateName : stateName,
		stateFIPS: location.$assignedFields.contains('stateFIPS') ? location.stateFIPS : stateFIPS,
		censusTract: location.$assignedFields.contains('censusTract') ? location.censusTract : censusTract,
		blockGroup: location.$assignedFields.contains('blockGroup') ? location.blockGroup : blockGroup,
		precinct: location.$assignedFields.contains('precinct') ? location.precinct : precinct,
		schoolDistrict: location.$assignedFields.contains('schoolDistrict') ? location.schoolDistrict : schoolDistrict,
		congressionalDistrict: location.$assignedFields.contains('congressionalDistrict') ? location.congressionalDistrict : congressionalDistrict,
		latitude: location.$assignedFields.contains('latitude') ? location.latitude : latitude,
		longitude: location.$assignedFields.contains('longitude') ? location.longitude : longitude,
		accuracy: location.$assignedFields.contains('accuracy') ? location.accuracy : accuracy,
		altitude: location.$assignedFields.contains('altitude') ? location.altitude : altitude,
		elevation: location.$assignedFields.contains('elevation') ? location.elevation : elevation,
		geocodingStatus: location.$assignedFields.contains('geocodingStatus') ? location.geocodingStatus : geocodingStatus,
		geocodedAt: location.$assignedFields.contains('geocodedAt') ? location.geocodedAt : geocodedAt,
		geocodingProvider: location.$assignedFields.contains('geocodingProvider') ? location.geocodingProvider : geocodingProvider,
		confidenceScore: location.$assignedFields.contains('confidenceScore') ? location.confidenceScore : confidenceScore,
		isVerified: location.$assignedFields.contains('isVerified') ? location.isVerified : isVerified,
		verifiedAt: location.$assignedFields.contains('verifiedAt') ? location.verifiedAt : verifiedAt,
		verifiedBy: location.$assignedFields.contains('verifiedBy') ? location.verifiedBy : verifiedBy,
		uspsVerified: location.$assignedFields.contains('uspsVerified') ? location.uspsVerified : uspsVerified,
		uspsVerifiedAt: location.$assignedFields.contains('uspsVerifiedAt') ? location.uspsVerifiedAt : uspsVerifiedAt,
		dpvConfirmation: location.$assignedFields.contains('dpvConfirmation') ? location.dpvConfirmation : dpvConfirmation,
		footnotes: location.$assignedFields.contains('footnotes') ? location.footnotes : footnotes,
		isStandardized: location.$assignedFields.contains('isStandardized') ? location.isStandardized : isStandardized,
		isResidential: location.$assignedFields.contains('isResidential') ? location.isResidential : isResidential,
		isCommercial: location.$assignedFields.contains('isCommercial') ? location.isCommercial : isCommercial,
		isValid: location.$assignedFields.contains('isValid') ? location.isValid : isValid,
		markerType: location.$assignedFields.contains('markerType') ? location.markerType : markerType,
		markerIcon: location.$assignedFields.contains('markerIcon') ? location.markerIcon : markerIcon,
		markerColor: location.$assignedFields.contains('markerColor') ? location.markerColor : markerColor,
		markerSize: location.$assignedFields.contains('markerSize') ? location.markerSize : markerSize,
		isVisible: location.$assignedFields.contains('isVisible') ? location.isVisible : isVisible,
		zIndex: location.$assignedFields.contains('zIndex') ? location.zIndex : zIndex,
		opacity: location.$assignedFields.contains('opacity') ? location.opacity : opacity,
		title: location.$assignedFields.contains('title') ? location.title : title,
		description: location.$assignedFields.contains('description') ? location.description : description,
		imageUrl: location.$assignedFields.contains('imageUrl') ? location.imageUrl : imageUrl,
		linkUrl: location.$assignedFields.contains('linkUrl') ? location.linkUrl : linkUrl,
		category: location.$assignedFields.contains('category') ? location.category : category,
		tags: location.$assignedFields.contains('tags') ? location.tags : tags,
		mondayOpen: location.$assignedFields.contains('mondayOpen') ? location.mondayOpen : mondayOpen,
		mondayClose: location.$assignedFields.contains('mondayClose') ? location.mondayClose : mondayClose,
		tuesdayOpen: location.$assignedFields.contains('tuesdayOpen') ? location.tuesdayOpen : tuesdayOpen,
		tuesdayClose: location.$assignedFields.contains('tuesdayClose') ? location.tuesdayClose : tuesdayClose,
		wednesdayOpen: location.$assignedFields.contains('wednesdayOpen') ? location.wednesdayOpen : wednesdayOpen,
		wednesdayClose: location.$assignedFields.contains('wednesdayClose') ? location.wednesdayClose : wednesdayClose,
		thursdayOpen: location.$assignedFields.contains('thursdayOpen') ? location.thursdayOpen : thursdayOpen,
		thursdayClose: location.$assignedFields.contains('thursdayClose') ? location.thursdayClose : thursdayClose,
		fridayOpen: location.$assignedFields.contains('fridayOpen') ? location.fridayOpen : fridayOpen,
		fridayClose: location.$assignedFields.contains('fridayClose') ? location.fridayClose : fridayClose,
		saturdayOpen: location.$assignedFields.contains('saturdayOpen') ? location.saturdayOpen : saturdayOpen,
		saturdayClose: location.$assignedFields.contains('saturdayClose') ? location.saturdayClose : saturdayClose,
		sundayOpen: location.$assignedFields.contains('sundayOpen') ? location.sundayOpen : sundayOpen,
		sundayClose: location.$assignedFields.contains('sundayClose') ? location.sundayClose : sundayClose,
		metadata: location.$assignedFields.contains('metadata') ? location.metadata : metadata,
		createdBy: location.$assignedFields.contains('createdBy') ? location.createdBy : createdBy,
		createdAt: location.$assignedFields.contains('createdAt') ? location.createdAt : createdAt,
		updatedAt: location.$assignedFields.contains('updatedAt') ? location.updatedAt : updatedAt,
		deletedAt: location.$assignedFields.contains('deletedAt') ? location.deletedAt : deletedAt,
		deal: location.$assignedFields.contains('deal') ? location.deal : deal,
		listing: location.$assignedFields.contains('listing') ? location.listing : listing,
		org: location.$assignedFields.contains('org') ? location.org : org,
		property: location.$assignedFields.contains('property') ? location.property : property,
		endRoutes: (location.$assignedFields.contains('endRoutes') && location.endRoutes != null) ? mergeModelLists(endRoutes, location.endRoutes) : endRoutes,
		startRoutes: (location.$assignedFields.contains('startRoutes') && location.startRoutes != null) ? mergeModelLists(startRoutes, location.startRoutes) : startRoutes,
		agencies: (location.$assignedFields.contains('agencies') && location.agencies != null) ? mergeModelLists(agencies, location.agencies) : agencies,
		agents: (location.$assignedFields.contains('agents') && location.agents != null) ? mergeModelLists(agents, location.agents) : agents,
		$tagsCount: location.$tagsCount ?? $tagsCount,
		$endRoutesCount: location.$endRoutesCount ?? $endRoutesCount,
		$startRoutesCount: location.$startRoutesCount ?? $startRoutesCount,
		$agenciesCount: location.$agenciesCount ?? $agenciesCount,
		$agentsCount: location.$agentsCount ?? $agentsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Location updateWithInstanceValues(Location location) {
        if (location.$assignedFields.contains('id')) { id = location.id; }
		if (location.$assignedFields.contains('orgId')) { orgId = location.orgId; }
		if (location.$assignedFields.contains('propertyId')) { propertyId = location.propertyId; }
		if (location.$assignedFields.contains('listingId')) { listingId = location.listingId; }
		if (location.$assignedFields.contains('dealId')) { dealId = location.dealId; }
		if (location.$assignedFields.contains('addressLine1')) { addressLine1 = location.addressLine1; }
		if (location.$assignedFields.contains('addressLine2')) { addressLine2 = location.addressLine2; }
		if (location.$assignedFields.contains('addressLine3')) { addressLine3 = location.addressLine3; }
		if (location.$assignedFields.contains('city')) { city = location.city; }
		if (location.$assignedFields.contains('state')) { state = location.state; }
		if (location.$assignedFields.contains('zip')) { zip = location.zip; }
		if (location.$assignedFields.contains('zipPlus4')) { zipPlus4 = location.zipPlus4; }
		if (location.$assignedFields.contains('country')) { country = location.country; }
		if (location.$assignedFields.contains('stateName')) { stateName = location.stateName; }
		if (location.$assignedFields.contains('stateFIPS')) { stateFIPS = location.stateFIPS; }
		if (location.$assignedFields.contains('censusTract')) { censusTract = location.censusTract; }
		if (location.$assignedFields.contains('blockGroup')) { blockGroup = location.blockGroup; }
		if (location.$assignedFields.contains('precinct')) { precinct = location.precinct; }
		if (location.$assignedFields.contains('schoolDistrict')) { schoolDistrict = location.schoolDistrict; }
		if (location.$assignedFields.contains('congressionalDistrict')) { congressionalDistrict = location.congressionalDistrict; }
		if (location.$assignedFields.contains('latitude')) { latitude = location.latitude; }
		if (location.$assignedFields.contains('longitude')) { longitude = location.longitude; }
		if (location.$assignedFields.contains('accuracy')) { accuracy = location.accuracy; }
		if (location.$assignedFields.contains('altitude')) { altitude = location.altitude; }
		if (location.$assignedFields.contains('elevation')) { elevation = location.elevation; }
		if (location.$assignedFields.contains('geocodingStatus')) { geocodingStatus = location.geocodingStatus; }
		if (location.$assignedFields.contains('geocodedAt')) { geocodedAt = location.geocodedAt; }
		if (location.$assignedFields.contains('geocodingProvider')) { geocodingProvider = location.geocodingProvider; }
		if (location.$assignedFields.contains('confidenceScore')) { confidenceScore = location.confidenceScore; }
		if (location.$assignedFields.contains('isVerified')) { isVerified = location.isVerified; }
		if (location.$assignedFields.contains('verifiedAt')) { verifiedAt = location.verifiedAt; }
		if (location.$assignedFields.contains('verifiedBy')) { verifiedBy = location.verifiedBy; }
		if (location.$assignedFields.contains('uspsVerified')) { uspsVerified = location.uspsVerified; }
		if (location.$assignedFields.contains('uspsVerifiedAt')) { uspsVerifiedAt = location.uspsVerifiedAt; }
		if (location.$assignedFields.contains('dpvConfirmation')) { dpvConfirmation = location.dpvConfirmation; }
		if (location.$assignedFields.contains('footnotes')) { footnotes = location.footnotes; }
		if (location.$assignedFields.contains('isStandardized')) { isStandardized = location.isStandardized; }
		if (location.$assignedFields.contains('isResidential')) { isResidential = location.isResidential; }
		if (location.$assignedFields.contains('isCommercial')) { isCommercial = location.isCommercial; }
		if (location.$assignedFields.contains('isValid')) { isValid = location.isValid; }
		if (location.$assignedFields.contains('markerType')) { markerType = location.markerType; }
		if (location.$assignedFields.contains('markerIcon')) { markerIcon = location.markerIcon; }
		if (location.$assignedFields.contains('markerColor')) { markerColor = location.markerColor; }
		if (location.$assignedFields.contains('markerSize')) { markerSize = location.markerSize; }
		if (location.$assignedFields.contains('isVisible')) { isVisible = location.isVisible; }
		if (location.$assignedFields.contains('zIndex')) { zIndex = location.zIndex; }
		if (location.$assignedFields.contains('opacity')) { opacity = location.opacity; }
		if (location.$assignedFields.contains('title')) { title = location.title; }
		if (location.$assignedFields.contains('description')) { description = location.description; }
		if (location.$assignedFields.contains('imageUrl')) { imageUrl = location.imageUrl; }
		if (location.$assignedFields.contains('linkUrl')) { linkUrl = location.linkUrl; }
		if (location.$assignedFields.contains('category')) { category = location.category; }
		if (location.$assignedFields.contains('tags')) { tags = location.tags; }
		if (location.$assignedFields.contains('mondayOpen')) { mondayOpen = location.mondayOpen; }
		if (location.$assignedFields.contains('mondayClose')) { mondayClose = location.mondayClose; }
		if (location.$assignedFields.contains('tuesdayOpen')) { tuesdayOpen = location.tuesdayOpen; }
		if (location.$assignedFields.contains('tuesdayClose')) { tuesdayClose = location.tuesdayClose; }
		if (location.$assignedFields.contains('wednesdayOpen')) { wednesdayOpen = location.wednesdayOpen; }
		if (location.$assignedFields.contains('wednesdayClose')) { wednesdayClose = location.wednesdayClose; }
		if (location.$assignedFields.contains('thursdayOpen')) { thursdayOpen = location.thursdayOpen; }
		if (location.$assignedFields.contains('thursdayClose')) { thursdayClose = location.thursdayClose; }
		if (location.$assignedFields.contains('fridayOpen')) { fridayOpen = location.fridayOpen; }
		if (location.$assignedFields.contains('fridayClose')) { fridayClose = location.fridayClose; }
		if (location.$assignedFields.contains('saturdayOpen')) { saturdayOpen = location.saturdayOpen; }
		if (location.$assignedFields.contains('saturdayClose')) { saturdayClose = location.saturdayClose; }
		if (location.$assignedFields.contains('sundayOpen')) { sundayOpen = location.sundayOpen; }
		if (location.$assignedFields.contains('sundayClose')) { sundayClose = location.sundayClose; }
		if (location.$assignedFields.contains('metadata')) { metadata = location.metadata; }
		if (location.$assignedFields.contains('createdBy')) { createdBy = location.createdBy; }
		if (location.$assignedFields.contains('createdAt')) { createdAt = location.createdAt; }
		if (location.$assignedFields.contains('updatedAt')) { updatedAt = location.updatedAt; }
		if (location.$assignedFields.contains('deletedAt')) { deletedAt = location.deletedAt; }
		if (location.$assignedFields.contains('deal')) { deal = location.deal; }
		if (location.$assignedFields.contains('listing')) { listing = location.listing; }
		if (location.$assignedFields.contains('org')) { org = location.org; }
		if (location.$assignedFields.contains('property')) { property = location.property; }
		if (location.$assignedFields.contains('endRoutes') && location.endRoutes != null) { endRoutes = mergeModelLists(endRoutes, location.endRoutes); }
		if (location.$assignedFields.contains('startRoutes') && location.startRoutes != null) { startRoutes = mergeModelLists(startRoutes, location.startRoutes); }
		if (location.$assignedFields.contains('agencies') && location.agencies != null) { agencies = mergeModelLists(agencies, location.agencies); }
		if (location.$assignedFields.contains('agents') && location.agents != null) { agents = mergeModelLists(agents, location.agents); }
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
          ? {...?serializedTypes, 'Location'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(dealId != null) 'dealId': dealId,
	if(addressLine1 != null) 'addressLine1': addressLine1,
	if(addressLine2 != null) 'addressLine2': addressLine2,
	if(addressLine3 != null) 'addressLine3': addressLine3,
	if(city != null) 'city': city,
	if(state != null) 'state': state,
	if(zip != null) 'zip': zip,
	if(zipPlus4 != null) 'zipPlus4': zipPlus4,
	if(country != null) 'country': country,
	if(stateName != null) 'stateName': stateName,
	if(stateFIPS != null) 'stateFIPS': stateFIPS,
	if(censusTract != null) 'censusTract': censusTract,
	if(blockGroup != null) 'blockGroup': blockGroup,
	if(precinct != null) 'precinct': precinct,
	if(schoolDistrict != null) 'schoolDistrict': schoolDistrict,
	if(congressionalDistrict != null) 'congressionalDistrict': congressionalDistrict,
	if(latitude != null) 'latitude': latitude,
	if(longitude != null) 'longitude': longitude,
	if(accuracy != null) 'accuracy': accuracy?.toJson(),
	if(altitude != null) 'altitude': altitude,
	if(elevation != null) 'elevation': elevation,
	if(geocodingStatus != null) 'geocodingStatus': geocodingStatus?.toJson(),
	if(geocodedAt != null) 'geocodedAt': geocodedAt?.toIso8601String(),
	if(geocodingProvider != null) 'geocodingProvider': geocodingProvider?.toJson(),
	if(confidenceScore != null) 'confidenceScore': confidenceScore,
	if(isVerified != null) 'isVerified': isVerified,
	if(verifiedAt != null) 'verifiedAt': verifiedAt?.toIso8601String(),
	if(verifiedBy != null) 'verifiedBy': verifiedBy,
	if(uspsVerified != null) 'uspsVerified': uspsVerified,
	if(uspsVerifiedAt != null) 'uspsVerifiedAt': uspsVerifiedAt?.toIso8601String(),
	if(dpvConfirmation != null) 'dpvConfirmation': dpvConfirmation,
	if(footnotes != null) 'footnotes': footnotes,
	if(isStandardized != null) 'isStandardized': isStandardized,
	if(isResidential != null) 'isResidential': isResidential,
	if(isCommercial != null) 'isCommercial': isCommercial,
	if(isValid != null) 'isValid': isValid,
	if(markerType != null) 'markerType': markerType?.toJson(),
	if(markerIcon != null) 'markerIcon': markerIcon?.toJson(),
	if(markerColor != null) 'markerColor': markerColor,
	if(markerSize != null) 'markerSize': markerSize,
	if(isVisible != null) 'isVisible': isVisible,
	if(zIndex != null) 'zIndex': zIndex,
	if(opacity != null) 'opacity': opacity,
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(imageUrl != null) 'imageUrl': imageUrl,
	if(linkUrl != null) 'linkUrl': linkUrl,
	if(category != null) 'category': category,
	if(tags != null) 'tags': tags,
	if(mondayOpen != null) 'mondayOpen': mondayOpen,
	if(mondayClose != null) 'mondayClose': mondayClose,
	if(tuesdayOpen != null) 'tuesdayOpen': tuesdayOpen,
	if(tuesdayClose != null) 'tuesdayClose': tuesdayClose,
	if(wednesdayOpen != null) 'wednesdayOpen': wednesdayOpen,
	if(wednesdayClose != null) 'wednesdayClose': wednesdayClose,
	if(thursdayOpen != null) 'thursdayOpen': thursdayOpen,
	if(thursdayClose != null) 'thursdayClose': thursdayClose,
	if(fridayOpen != null) 'fridayOpen': fridayOpen,
	if(fridayClose != null) 'fridayClose': fridayClose,
	if(saturdayOpen != null) 'saturdayOpen': saturdayOpen,
	if(saturdayClose != null) 'saturdayClose': saturdayClose,
	if(sundayOpen != null) 'sundayOpen': sundayOpen,
	if(sundayClose != null) 'sundayClose': sundayClose,
	if(metadata != null) 'metadata': metadata,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(deal != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'deal': deal?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(endRoutes != null && (!preventCircularSerialization || !serializedModels.contains('Route'))) 'endRoutes': endRoutes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(startRoutes != null && (!preventCircularSerialization || !serializedModels.contains('Route'))) 'startRoutes': startRoutes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agents != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agents': agents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($tagsCount != null || $endRoutesCount != null || $startRoutesCount != null || $agenciesCount != null || $agentsCount != null) '_count': { 
		if ($tagsCount != null) 'tags': $tagsCount, 
		if ($endRoutesCount != null) 'endRoutes': $endRoutesCount, 
		if ($startRoutesCount != null) 'startRoutes': $startRoutesCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($agentsCount != null) 'agents': $agentsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Location &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    