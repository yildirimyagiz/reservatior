import 'package:reservatior/shared/enums/geocoding_status.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/enums/location_accuracy.dart';
import 'package:reservatior/shared/enums/map_provider.dart';
import 'package:reservatior/shared/enums/marker_icon.dart';
import 'package:reservatior/shared/enums/marker_type.dart';
import 'package:reservatior/shared/enums/org_type.dart';
import 'package:reservatior/shared/enums/region.dart';
import 'agency.dart';
import 'agent.dart';
import 'deal.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'route.dart';

class Location {
  final String id;
  final String orgId;
  final String? propertyId;
  final String? listingId;
  final String? dealId;
  final String addressLine1;
  final String? addressLine2;
  final String? addressLine3;
  final String city;
  final String? state;
  final String? zip;
  final String? zipPlus4;
  final String country;
  final String? stateName;
  final String? stateFIPS;
  final String? censusTract;
  final String? blockGroup;
  final String? precinct;
  final String? schoolDistrict;
  final String? congressionalDistrict;
  final double latitude;
  final double longitude;
  final LocationAccuracy accuracy;
  final double? altitude;
  final double? elevation;
  final GeocodingStatus geocodingStatus;
  final DateTime? geocodedAt;
  final MapProvider? geocodingProvider;
  final double? confidenceScore;
  final bool isVerified;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final bool uspsVerified;
  final DateTime? uspsVerifiedAt;
  final String? dpvConfirmation;
  final String? footnotes;
  final bool isStandardized;
  final bool isResidential;
  final bool isCommercial;
  final bool isValid;
  final MarkerType? markerType;
  final MarkerIcon? markerIcon;
  final String? markerColor;
  final int markerSize;
  final bool isVisible;
  final int zIndex;
  final double opacity;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? linkUrl;
  final String? category;
  final List<String> tags;
  final String? mondayOpen;
  final String? mondayClose;
  final String? tuesdayOpen;
  final String? tuesdayClose;
  final String? wednesdayOpen;
  final String? wednesdayClose;
  final String? thursdayOpen;
  final String? thursdayClose;
  final String? fridayOpen;
  final String? fridayClose;
  final String? saturdayOpen;
  final String? saturdayClose;
  final String? sundayOpen;
  final String? sundayClose;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Deal? deal;
  final Listing? listing;
  final Organization org;
  final Property? property;
  final List<Route> endRoutes;
  final List<Route> startRoutes;
  final List<Agency> agencies;
  final List<Agent> agents;

  const Location({
    required this.id,
    required this.orgId,
    this.propertyId,
    this.listingId,
    this.dealId,
    required this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    required this.city,
    this.state,
    this.zip,
    this.zipPlus4,
    required this.country,
    this.stateName,
    this.stateFIPS,
    this.censusTract,
    this.blockGroup,
    this.precinct,
    this.schoolDistrict,
    this.congressionalDistrict,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    this.altitude,
    this.elevation,
    required this.geocodingStatus,
    this.geocodedAt,
    this.geocodingProvider,
    this.confidenceScore,
    required this.isVerified,
    this.verifiedAt,
    this.verifiedBy,
    required this.uspsVerified,
    this.uspsVerifiedAt,
    this.dpvConfirmation,
    this.footnotes,
    required this.isStandardized,
    required this.isResidential,
    required this.isCommercial,
    required this.isValid,
    this.markerType,
    this.markerIcon,
    this.markerColor,
    required this.markerSize,
    required this.isVisible,
    required this.zIndex,
    required this.opacity,
    this.title,
    this.description,
    this.imageUrl,
    this.linkUrl,
    this.category,
    this.tags = const [],
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
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.deal,
    this.listing,
    required this.org,
    this.property,
    this.endRoutes = const [],
    this.startRoutes = const [],
    this.agencies = const [],
    this.agents = const [],
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String?,
      listingId: json['listingId'] as String?,
      dealId: json['dealId'] as String?,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      addressLine3: json['addressLine3'] as String?,
      city: json['city'] as String,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      zipPlus4: json['zipPlus4'] as String?,
      country: json['country'] as String,
      stateName: json['stateName'] as String?,
      stateFIPS: json['stateFIPS'] as String?,
      censusTract: json['censusTract'] as String?,
      blockGroup: json['blockGroup'] as String?,
      precinct: json['precinct'] as String?,
      schoolDistrict: json['schoolDistrict'] as String?,
      congressionalDistrict: json['congressionalDistrict'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: LocationAccuracy.values.firstWhere((v) => v.name == json['accuracy']),
      altitude: (json['altitude'] as num?)?.toDouble(),
      elevation: (json['elevation'] as num?)?.toDouble(),
      geocodingStatus: GeocodingStatus.values.firstWhere((v) => v.name == json['geocodingStatus']),
      geocodedAt: json['geocodedAt'] != null ? DateTime.parse(json['geocodedAt'] as String) : null,
      geocodingProvider: json['geocodingProvider'] != null ? MapProvider.values.firstWhere((v) => v.name == json['geocodingProvider']) : null,
      confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
      isVerified: json['isVerified'] as bool,
      verifiedAt: json['verifiedAt'] != null ? DateTime.parse(json['verifiedAt'] as String) : null,
      verifiedBy: json['verifiedBy'] as String?,
      uspsVerified: json['uspsVerified'] as bool,
      uspsVerifiedAt: json['uspsVerifiedAt'] != null ? DateTime.parse(json['uspsVerifiedAt'] as String) : null,
      dpvConfirmation: json['dpvConfirmation'] as String?,
      footnotes: json['footnotes'] as String?,
      isStandardized: json['isStandardized'] as bool,
      isResidential: json['isResidential'] as bool,
      isCommercial: json['isCommercial'] as bool,
      isValid: json['isValid'] as bool,
      markerType: json['markerType'] != null ? MarkerType.values.firstWhere((v) => v.name == json['markerType']) : null,
      markerIcon: json['markerIcon'] != null ? MarkerIcon.values.firstWhere((v) => v.name == json['markerIcon']) : null,
      markerColor: json['markerColor'] as String?,
      markerSize: json['markerSize'] as int,
      isVisible: json['isVisible'] as bool,
      zIndex: json['zIndex'] as int,
      opacity: (json['opacity'] as num).toDouble(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      linkUrl: json['linkUrl'] as String?,
      category: json['category'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
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
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      deal: json['deal'] != null ? Deal.fromJson(json['deal'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : 
      Organization(
        id: json['orgId'] ?? '', 
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
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
      endRoutes: (json['endRoutes'] as List<dynamic>?)?.map((e) => Route.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      startRoutes: (json['startRoutes'] as List<dynamic>?)?.map((e) => Route.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agents: (json['agents'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'dealId': dealId,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'addressLine3': addressLine3,
      'city': city,
      'state': state,
      'zip': zip,
      'zipPlus4': zipPlus4,
      'country': country,
      'stateName': stateName,
      'stateFIPS': stateFIPS,
      'censusTract': censusTract,
      'blockGroup': blockGroup,
      'precinct': precinct,
      'schoolDistrict': schoolDistrict,
      'congressionalDistrict': congressionalDistrict,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy.name,
      'altitude': altitude,
      'elevation': elevation,
      'geocodingStatus': geocodingStatus.name,
      'geocodedAt': geocodedAt?.toIso8601String(),
      'geocodingProvider': geocodingProvider?.name,
      'confidenceScore': confidenceScore,
      'isVerified': isVerified,
      'verifiedAt': verifiedAt?.toIso8601String(),
      'verifiedBy': verifiedBy,
      'uspsVerified': uspsVerified,
      'uspsVerifiedAt': uspsVerifiedAt?.toIso8601String(),
      'dpvConfirmation': dpvConfirmation,
      'footnotes': footnotes,
      'isStandardized': isStandardized,
      'isResidential': isResidential,
      'isCommercial': isCommercial,
      'isValid': isValid,
      'markerType': markerType?.name,
      'markerIcon': markerIcon?.name,
      'markerColor': markerColor,
      'markerSize': markerSize,
      'isVisible': isVisible,
      'zIndex': zIndex,
      'opacity': opacity,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'linkUrl': linkUrl,
      'category': category,
      'tags': tags,
      'mondayOpen': mondayOpen,
      'mondayClose': mondayClose,
      'tuesdayOpen': tuesdayOpen,
      'tuesdayClose': tuesdayClose,
      'wednesdayOpen': wednesdayOpen,
      'wednesdayClose': wednesdayClose,
      'thursdayOpen': thursdayOpen,
      'thursdayClose': thursdayClose,
      'fridayOpen': fridayOpen,
      'fridayClose': fridayClose,
      'saturdayOpen': saturdayOpen,
      'saturdayClose': saturdayClose,
      'sundayOpen': sundayOpen,
      'sundayClose': sundayClose,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'deal': deal?.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property?.toJson(),
      'endRoutes': endRoutes.map((e) => e.toJson()).toList(),
      'startRoutes': startRoutes.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'agents': agents.map((e) => e.toJson()).toList(),
    };
  }

  Location copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? dealId,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? state,
    String? zip,
    String? zipPlus4,
    String? country,
    String? stateName,
    String? stateFIPS,
    String? censusTract,
    String? blockGroup,
    String? precinct,
    String? schoolDistrict,
    String? congressionalDistrict,
    double? latitude,
    double? longitude,
    LocationAccuracy? accuracy,
    double? altitude,
    double? elevation,
    GeocodingStatus? geocodingStatus,
    DateTime? geocodedAt,
    MapProvider? geocodingProvider,
    double? confidenceScore,
    bool? isVerified,
    DateTime? verifiedAt,
    String? verifiedBy,
    bool? uspsVerified,
    DateTime? uspsVerifiedAt,
    String? dpvConfirmation,
    String? footnotes,
    bool? isStandardized,
    bool? isResidential,
    bool? isCommercial,
    bool? isValid,
    MarkerType? markerType,
    MarkerIcon? markerIcon,
    String? markerColor,
    int? markerSize,
    bool? isVisible,
    int? zIndex,
    double? opacity,
    String? title,
    String? description,
    String? imageUrl,
    String? linkUrl,
    String? category,
    List<String>? tags,
    String? mondayOpen,
    String? mondayClose,
    String? tuesdayOpen,
    String? tuesdayClose,
    String? wednesdayOpen,
    String? wednesdayClose,
    String? thursdayOpen,
    String? thursdayClose,
    String? fridayOpen,
    String? fridayClose,
    String? saturdayOpen,
    String? saturdayClose,
    String? sundayOpen,
    String? sundayClose,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Deal? deal,
    Listing? listing,
    Organization? org,
    Property? property,
    List<Route>? endRoutes,
    List<Route>? startRoutes,
    List<Agency>? agencies,
    List<Agent>? agents,
  }) {
    return Location(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      dealId: dealId ?? this.dealId,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      addressLine3: addressLine3 ?? this.addressLine3,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      zipPlus4: zipPlus4 ?? this.zipPlus4,
      country: country ?? this.country,
      stateName: stateName ?? this.stateName,
      stateFIPS: stateFIPS ?? this.stateFIPS,
      censusTract: censusTract ?? this.censusTract,
      blockGroup: blockGroup ?? this.blockGroup,
      precinct: precinct ?? this.precinct,
      schoolDistrict: schoolDistrict ?? this.schoolDistrict,
      congressionalDistrict: congressionalDistrict ?? this.congressionalDistrict,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      elevation: elevation ?? this.elevation,
      geocodingStatus: geocodingStatus ?? this.geocodingStatus,
      geocodedAt: geocodedAt ?? this.geocodedAt,
      geocodingProvider: geocodingProvider ?? this.geocodingProvider,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      isVerified: isVerified ?? this.isVerified,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      uspsVerified: uspsVerified ?? this.uspsVerified,
      uspsVerifiedAt: uspsVerifiedAt ?? this.uspsVerifiedAt,
      dpvConfirmation: dpvConfirmation ?? this.dpvConfirmation,
      footnotes: footnotes ?? this.footnotes,
      isStandardized: isStandardized ?? this.isStandardized,
      isResidential: isResidential ?? this.isResidential,
      isCommercial: isCommercial ?? this.isCommercial,
      isValid: isValid ?? this.isValid,
      markerType: markerType ?? this.markerType,
      markerIcon: markerIcon ?? this.markerIcon,
      markerColor: markerColor ?? this.markerColor,
      markerSize: markerSize ?? this.markerSize,
      isVisible: isVisible ?? this.isVisible,
      zIndex: zIndex ?? this.zIndex,
      opacity: opacity ?? this.opacity,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      linkUrl: linkUrl ?? this.linkUrl,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      mondayOpen: mondayOpen ?? this.mondayOpen,
      mondayClose: mondayClose ?? this.mondayClose,
      tuesdayOpen: tuesdayOpen ?? this.tuesdayOpen,
      tuesdayClose: tuesdayClose ?? this.tuesdayClose,
      wednesdayOpen: wednesdayOpen ?? this.wednesdayOpen,
      wednesdayClose: wednesdayClose ?? this.wednesdayClose,
      thursdayOpen: thursdayOpen ?? this.thursdayOpen,
      thursdayClose: thursdayClose ?? this.thursdayClose,
      fridayOpen: fridayOpen ?? this.fridayOpen,
      fridayClose: fridayClose ?? this.fridayClose,
      saturdayOpen: saturdayOpen ?? this.saturdayOpen,
      saturdayClose: saturdayClose ?? this.saturdayClose,
      sundayOpen: sundayOpen ?? this.sundayOpen,
      sundayClose: sundayClose ?? this.sundayClose,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deal: deal ?? this.deal,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
      endRoutes: endRoutes ?? this.endRoutes,
      startRoutes: startRoutes ?? this.startRoutes,
      agencies: agencies ?? this.agencies,
      agents: agents ?? this.agents,
    );
  }
}
