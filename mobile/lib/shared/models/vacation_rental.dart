import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'vacation_rental_platform.dart';

class VacationRental {
  final String id;
  final String orgId;
  final String propertyId;
  final String? listingId;
  final bool isActive;
  final String rentalType;
  final bool instantBooking;
  final double baseNightlyRate;
  final String currency;
  final double? cleaningFee;
  final double? securityDeposit;
  final double? weeklyDiscount;
  final double? monthlyDiscount;
  final String checkInTime;
  final String checkOutTime;
  final int minStayNights;
  final int maxStayNights;
  final int advanceBookingDays;
  final int maxGuests;
  final bool childrenAllowed;
  final bool petsAllowed;
  final bool smokingAllowed;
  final bool eventsAllowed;
  final String? houseRules;
  final String cancellationPolicy;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Listing? listing;
  final Organization org;
  final Property property;
  final List<VacationRentalPlatform> platformListings;

  const VacationRental({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.listingId,
    required this.isActive,
    required this.rentalType,
    required this.instantBooking,
    required this.baseNightlyRate,
    required this.currency,
    this.cleaningFee,
    this.securityDeposit,
    this.weeklyDiscount,
    this.monthlyDiscount,
    required this.checkInTime,
    required this.checkOutTime,
    required this.minStayNights,
    required this.maxStayNights,
    required this.advanceBookingDays,
    required this.maxGuests,
    required this.childrenAllowed,
    required this.petsAllowed,
    required this.smokingAllowed,
    required this.eventsAllowed,
    this.houseRules,
    required this.cancellationPolicy,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.listing,
    required this.org,
    required this.property,
    this.platformListings = const [],
  });

  factory VacationRental.fromJson(Map<String, dynamic> json) {
    return VacationRental(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      isActive: json['isActive'] as bool,
      rentalType: json['rentalType'] as String,
      instantBooking: json['instantBooking'] as bool,
      baseNightlyRate: (json['baseNightlyRate'] as num).toDouble(),
      currency: json['currency'] as String,
      cleaningFee: (json['cleaningFee'] as num?)?.toDouble(),
      securityDeposit: (json['securityDeposit'] as num?)?.toDouble(),
      weeklyDiscount: (json['weeklyDiscount'] as num?)?.toDouble(),
      monthlyDiscount: (json['monthlyDiscount'] as num?)?.toDouble(),
      checkInTime: json['checkInTime'] as String,
      checkOutTime: json['checkOutTime'] as String,
      minStayNights: json['minStayNights'] as int,
      maxStayNights: json['maxStayNights'] as int,
      advanceBookingDays: json['advanceBookingDays'] as int,
      maxGuests: json['maxGuests'] as int,
      childrenAllowed: json['childrenAllowed'] as bool,
      petsAllowed: json['petsAllowed'] as bool,
      smokingAllowed: json['smokingAllowed'] as bool,
      eventsAllowed: json['eventsAllowed'] as bool,
      houseRules: json['houseRules'] as String?,
      cancellationPolicy: json['cancellationPolicy'] as String,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      platformListings: (json['platformListings'] as List<dynamic>?)?.map((e) => VacationRentalPlatform.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'isActive': isActive,
      'rentalType': rentalType,
      'instantBooking': instantBooking,
      'baseNightlyRate': baseNightlyRate,
      'currency': currency,
      'cleaningFee': cleaningFee,
      'securityDeposit': securityDeposit,
      'weeklyDiscount': weeklyDiscount,
      'monthlyDiscount': monthlyDiscount,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'minStayNights': minStayNights,
      'maxStayNights': maxStayNights,
      'advanceBookingDays': advanceBookingDays,
      'maxGuests': maxGuests,
      'childrenAllowed': childrenAllowed,
      'petsAllowed': petsAllowed,
      'smokingAllowed': smokingAllowed,
      'eventsAllowed': eventsAllowed,
      'houseRules': houseRules,
      'cancellationPolicy': cancellationPolicy,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property.toJson(),
      'platformListings': platformListings.map((e) => e.toJson()).toList(),
    };
  }

  VacationRental copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    bool? isActive,
    String? rentalType,
    bool? instantBooking,
    double? baseNightlyRate,
    String? currency,
    double? cleaningFee,
    double? securityDeposit,
    double? weeklyDiscount,
    double? monthlyDiscount,
    String? checkInTime,
    String? checkOutTime,
    int? minStayNights,
    int? maxStayNights,
    int? advanceBookingDays,
    int? maxGuests,
    bool? childrenAllowed,
    bool? petsAllowed,
    bool? smokingAllowed,
    bool? eventsAllowed,
    String? houseRules,
    String? cancellationPolicy,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Listing? listing,
    Organization? org,
    Property? property,
    List<VacationRentalPlatform>? platformListings,
  }) {
    return VacationRental(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      isActive: isActive ?? this.isActive,
      rentalType: rentalType ?? this.rentalType,
      instantBooking: instantBooking ?? this.instantBooking,
      baseNightlyRate: baseNightlyRate ?? this.baseNightlyRate,
      currency: currency ?? this.currency,
      cleaningFee: cleaningFee ?? this.cleaningFee,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      weeklyDiscount: weeklyDiscount ?? this.weeklyDiscount,
      monthlyDiscount: monthlyDiscount ?? this.monthlyDiscount,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      minStayNights: minStayNights ?? this.minStayNights,
      maxStayNights: maxStayNights ?? this.maxStayNights,
      advanceBookingDays: advanceBookingDays ?? this.advanceBookingDays,
      maxGuests: maxGuests ?? this.maxGuests,
      childrenAllowed: childrenAllowed ?? this.childrenAllowed,
      petsAllowed: petsAllowed ?? this.petsAllowed,
      smokingAllowed: smokingAllowed ?? this.smokingAllowed,
      eventsAllowed: eventsAllowed ?? this.eventsAllowed,
      houseRules: houseRules ?? this.houseRules,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
      platformListings: platformListings ?? this.platformListings,
    );
  }
}
