
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'vacation_rental_platform.dart';


class VacationRental implements PrismaModel<String, VacationRental> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	bool? isActive;
	String? rentalType;
	bool? instantBooking;
	double? baseNightlyRate;
	String? currency;
	double? cleaningFee;
	double? securityDeposit;
	double? weeklyDiscount;
	double? monthlyDiscount;
	String? checkInTime;
	String? checkOutTime;
	int? minStayNights;
	int? maxStayNights;
	int? advanceBookingDays;
	int? maxGuests;
	bool? childrenAllowed;
	bool? petsAllowed;
	bool? smokingAllowed;
	bool? eventsAllowed;
	String? houseRules;
	String? cancellationPolicy;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Listing? listing;
	Organization? org;
	Property? property;
	List<VacationRentalPlatform>? platformListings;
	int? $platformListingsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    VacationRental({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.isActive = false,
	 this.rentalType = "ENTIRE_HOME",
	 this.instantBooking = false,
	 this.baseNightlyRate,
	 this.currency = "USD",
	 this.cleaningFee,
	 this.securityDeposit,
	 this.weeklyDiscount,
	 this.monthlyDiscount,
	 this.checkInTime = "15:00",
	 this.checkOutTime = "11:00",
	 this.minStayNights = 1,
	 this.maxStayNights = 365,
	 this.advanceBookingDays = 365,
	 this.maxGuests,
	 this.childrenAllowed = true,
	 this.petsAllowed = false,
	 this.smokingAllowed = false,
	 this.eventsAllowed = false,
	 this.houseRules,
	 this.cancellationPolicy = "MODERATE",
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.listing,
	 this.org,
	 this.property,
	 this.platformListings,
	this.$platformListingsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<VacationRental, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"isActive": (m) => m.isActive,

	"rentalType": (m) => m.rentalType,

	"instantBooking": (m) => m.instantBooking,

	"baseNightlyRate": (m) => m.baseNightlyRate,

	"currency": (m) => m.currency,

	"cleaningFee": (m) => m.cleaningFee,

	"securityDeposit": (m) => m.securityDeposit,

	"weeklyDiscount": (m) => m.weeklyDiscount,

	"monthlyDiscount": (m) => m.monthlyDiscount,

	"checkInTime": (m) => m.checkInTime,

	"checkOutTime": (m) => m.checkOutTime,

	"minStayNights": (m) => m.minStayNights,

	"maxStayNights": (m) => m.maxStayNights,

	"advanceBookingDays": (m) => m.advanceBookingDays,

	"maxGuests": (m) => m.maxGuests,

	"childrenAllowed": (m) => m.childrenAllowed,

	"petsAllowed": (m) => m.petsAllowed,

	"smokingAllowed": (m) => m.smokingAllowed,

	"eventsAllowed": (m) => m.eventsAllowed,

	"houseRules": (m) => m.houseRules,

	"cancellationPolicy": (m) => m.cancellationPolicy,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"platformListings": (m) => m.platformListings,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(VacationRental) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in VacationRental');
    }
    return propFunction as V? Function(VacationRental);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory VacationRental.fromJson(JsonMap json) =>
      VacationRental(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	isActive: json['isActive'] as bool?,
	rentalType: json['rentalType'] as String?,
	instantBooking: json['instantBooking'] as bool?,
	baseNightlyRate: json['baseNightlyRate'] as double?,
	currency: json['currency'] as String?,
	cleaningFee: json['cleaningFee'] as double?,
	securityDeposit: json['securityDeposit'] as double?,
	weeklyDiscount: json['weeklyDiscount']?.toDouble(),
	monthlyDiscount: json['monthlyDiscount']?.toDouble(),
	checkInTime: json['checkInTime'] as String?,
	checkOutTime: json['checkOutTime'] as String?,
	minStayNights: int.tryParse(json['minStayNights'].toString()),
	maxStayNights: int.tryParse(json['maxStayNights'].toString()),
	advanceBookingDays: int.tryParse(json['advanceBookingDays'].toString()),
	maxGuests: int.tryParse(json['maxGuests'].toString()),
	childrenAllowed: json['childrenAllowed'] as bool?,
	petsAllowed: json['petsAllowed'] as bool?,
	smokingAllowed: json['smokingAllowed'] as bool?,
	eventsAllowed: json['eventsAllowed'] as bool?,
	houseRules: json['houseRules'] as String?,
	cancellationPolicy: json['cancellationPolicy'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	platformListings: json['platformListings'] != null ? createModels<VacationRentalPlatform>((json['platformListings'] as List).cast<JsonMap>(), VacationRentalPlatform.fromJson) : null,
	$platformListingsCount: json['_count']?['platformListings'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    VacationRental copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<bool?>? isActive,
		Value<String?>? rentalType,
		Value<bool?>? instantBooking,
		Value<double?>? baseNightlyRate,
		Value<String?>? currency,
		Value<double?>? cleaningFee,
		Value<double?>? securityDeposit,
		Value<double?>? weeklyDiscount,
		Value<double?>? monthlyDiscount,
		Value<String?>? checkInTime,
		Value<String?>? checkOutTime,
		Value<int?>? minStayNights,
		Value<int?>? maxStayNights,
		Value<int?>? advanceBookingDays,
		Value<int?>? maxGuests,
		Value<bool?>? childrenAllowed,
		Value<bool?>? petsAllowed,
		Value<bool?>? smokingAllowed,
		Value<bool?>? eventsAllowed,
		Value<String?>? houseRules,
		Value<String?>? cancellationPolicy,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<List<VacationRentalPlatform>?>? platformListings,
		int? $platformListingsCount,
        }) {
        return VacationRental(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		isActive: isActive != null ? isActive.value : this.isActive,
		rentalType: rentalType != null ? rentalType.value : this.rentalType,
		instantBooking: instantBooking != null ? instantBooking.value : this.instantBooking,
		baseNightlyRate: baseNightlyRate != null ? baseNightlyRate.value : this.baseNightlyRate,
		currency: currency != null ? currency.value : this.currency,
		cleaningFee: cleaningFee != null ? cleaningFee.value : this.cleaningFee,
		securityDeposit: securityDeposit != null ? securityDeposit.value : this.securityDeposit,
		weeklyDiscount: weeklyDiscount != null ? weeklyDiscount.value : this.weeklyDiscount,
		monthlyDiscount: monthlyDiscount != null ? monthlyDiscount.value : this.monthlyDiscount,
		checkInTime: checkInTime != null ? checkInTime.value : this.checkInTime,
		checkOutTime: checkOutTime != null ? checkOutTime.value : this.checkOutTime,
		minStayNights: minStayNights != null ? minStayNights.value : this.minStayNights,
		maxStayNights: maxStayNights != null ? maxStayNights.value : this.maxStayNights,
		advanceBookingDays: advanceBookingDays != null ? advanceBookingDays.value : this.advanceBookingDays,
		maxGuests: maxGuests != null ? maxGuests.value : this.maxGuests,
		childrenAllowed: childrenAllowed != null ? childrenAllowed.value : this.childrenAllowed,
		petsAllowed: petsAllowed != null ? petsAllowed.value : this.petsAllowed,
		smokingAllowed: smokingAllowed != null ? smokingAllowed.value : this.smokingAllowed,
		eventsAllowed: eventsAllowed != null ? eventsAllowed.value : this.eventsAllowed,
		houseRules: houseRules != null ? houseRules.value : this.houseRules,
		cancellationPolicy: cancellationPolicy != null ? cancellationPolicy.value : this.cancellationPolicy,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		platformListings: platformListings != null ? platformListings.value : this.platformListings,
		$platformListingsCount: $platformListingsCount ?? this.$platformListingsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    VacationRental copyWithInstanceValues(VacationRental vacationRental) {
        return VacationRental(
            id: vacationRental.id ?? id,
		orgId: vacationRental.orgId ?? orgId,
		propertyId: vacationRental.propertyId ?? propertyId,
		listingId: vacationRental.listingId ?? listingId,
		isActive: vacationRental.isActive ?? isActive,
		rentalType: vacationRental.rentalType ?? rentalType,
		instantBooking: vacationRental.instantBooking ?? instantBooking,
		baseNightlyRate: vacationRental.baseNightlyRate ?? baseNightlyRate,
		currency: vacationRental.currency ?? currency,
		cleaningFee: vacationRental.cleaningFee ?? cleaningFee,
		securityDeposit: vacationRental.securityDeposit ?? securityDeposit,
		weeklyDiscount: vacationRental.weeklyDiscount ?? weeklyDiscount,
		monthlyDiscount: vacationRental.monthlyDiscount ?? monthlyDiscount,
		checkInTime: vacationRental.checkInTime ?? checkInTime,
		checkOutTime: vacationRental.checkOutTime ?? checkOutTime,
		minStayNights: vacationRental.minStayNights ?? minStayNights,
		maxStayNights: vacationRental.maxStayNights ?? maxStayNights,
		advanceBookingDays: vacationRental.advanceBookingDays ?? advanceBookingDays,
		maxGuests: vacationRental.maxGuests ?? maxGuests,
		childrenAllowed: vacationRental.childrenAllowed ?? childrenAllowed,
		petsAllowed: vacationRental.petsAllowed ?? petsAllowed,
		smokingAllowed: vacationRental.smokingAllowed ?? smokingAllowed,
		eventsAllowed: vacationRental.eventsAllowed ?? eventsAllowed,
		houseRules: vacationRental.houseRules ?? houseRules,
		cancellationPolicy: vacationRental.cancellationPolicy ?? cancellationPolicy,
		createdBy: vacationRental.createdBy ?? createdBy,
		createdAt: vacationRental.createdAt ?? createdAt,
		updatedAt: vacationRental.updatedAt ?? updatedAt,
		deletedAt: vacationRental.deletedAt ?? deletedAt,
		listing: vacationRental.listing ?? listing,
		org: vacationRental.org ?? org,
		property: vacationRental.property ?? property,
		platformListings: vacationRental.platformListings ?? platformListings,
		$platformListingsCount: vacationRental.$platformListingsCount ?? $platformListingsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    VacationRental mergeWithInstanceValues(VacationRental vacationRental) {
        return VacationRental(
            id: vacationRental.$assignedFields.contains('id') ? vacationRental.id : id,
		orgId: vacationRental.$assignedFields.contains('orgId') ? vacationRental.orgId : orgId,
		propertyId: vacationRental.$assignedFields.contains('propertyId') ? vacationRental.propertyId : propertyId,
		listingId: vacationRental.$assignedFields.contains('listingId') ? vacationRental.listingId : listingId,
		isActive: vacationRental.$assignedFields.contains('isActive') ? vacationRental.isActive : isActive,
		rentalType: vacationRental.$assignedFields.contains('rentalType') ? vacationRental.rentalType : rentalType,
		instantBooking: vacationRental.$assignedFields.contains('instantBooking') ? vacationRental.instantBooking : instantBooking,
		baseNightlyRate: vacationRental.$assignedFields.contains('baseNightlyRate') ? vacationRental.baseNightlyRate : baseNightlyRate,
		currency: vacationRental.$assignedFields.contains('currency') ? vacationRental.currency : currency,
		cleaningFee: vacationRental.$assignedFields.contains('cleaningFee') ? vacationRental.cleaningFee : cleaningFee,
		securityDeposit: vacationRental.$assignedFields.contains('securityDeposit') ? vacationRental.securityDeposit : securityDeposit,
		weeklyDiscount: vacationRental.$assignedFields.contains('weeklyDiscount') ? vacationRental.weeklyDiscount : weeklyDiscount,
		monthlyDiscount: vacationRental.$assignedFields.contains('monthlyDiscount') ? vacationRental.monthlyDiscount : monthlyDiscount,
		checkInTime: vacationRental.$assignedFields.contains('checkInTime') ? vacationRental.checkInTime : checkInTime,
		checkOutTime: vacationRental.$assignedFields.contains('checkOutTime') ? vacationRental.checkOutTime : checkOutTime,
		minStayNights: vacationRental.$assignedFields.contains('minStayNights') ? vacationRental.minStayNights : minStayNights,
		maxStayNights: vacationRental.$assignedFields.contains('maxStayNights') ? vacationRental.maxStayNights : maxStayNights,
		advanceBookingDays: vacationRental.$assignedFields.contains('advanceBookingDays') ? vacationRental.advanceBookingDays : advanceBookingDays,
		maxGuests: vacationRental.$assignedFields.contains('maxGuests') ? vacationRental.maxGuests : maxGuests,
		childrenAllowed: vacationRental.$assignedFields.contains('childrenAllowed') ? vacationRental.childrenAllowed : childrenAllowed,
		petsAllowed: vacationRental.$assignedFields.contains('petsAllowed') ? vacationRental.petsAllowed : petsAllowed,
		smokingAllowed: vacationRental.$assignedFields.contains('smokingAllowed') ? vacationRental.smokingAllowed : smokingAllowed,
		eventsAllowed: vacationRental.$assignedFields.contains('eventsAllowed') ? vacationRental.eventsAllowed : eventsAllowed,
		houseRules: vacationRental.$assignedFields.contains('houseRules') ? vacationRental.houseRules : houseRules,
		cancellationPolicy: vacationRental.$assignedFields.contains('cancellationPolicy') ? vacationRental.cancellationPolicy : cancellationPolicy,
		createdBy: vacationRental.$assignedFields.contains('createdBy') ? vacationRental.createdBy : createdBy,
		createdAt: vacationRental.$assignedFields.contains('createdAt') ? vacationRental.createdAt : createdAt,
		updatedAt: vacationRental.$assignedFields.contains('updatedAt') ? vacationRental.updatedAt : updatedAt,
		deletedAt: vacationRental.$assignedFields.contains('deletedAt') ? vacationRental.deletedAt : deletedAt,
		listing: vacationRental.$assignedFields.contains('listing') ? vacationRental.listing : listing,
		org: vacationRental.$assignedFields.contains('org') ? vacationRental.org : org,
		property: vacationRental.$assignedFields.contains('property') ? vacationRental.property : property,
		platformListings: (vacationRental.$assignedFields.contains('platformListings') && vacationRental.platformListings != null) ? mergeModelLists(platformListings, vacationRental.platformListings) : platformListings,
		$platformListingsCount: vacationRental.$platformListingsCount ?? $platformListingsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    VacationRental updateWithInstanceValues(VacationRental vacationRental) {
        if (vacationRental.$assignedFields.contains('id')) { id = vacationRental.id; }
		if (vacationRental.$assignedFields.contains('orgId')) { orgId = vacationRental.orgId; }
		if (vacationRental.$assignedFields.contains('propertyId')) { propertyId = vacationRental.propertyId; }
		if (vacationRental.$assignedFields.contains('listingId')) { listingId = vacationRental.listingId; }
		if (vacationRental.$assignedFields.contains('isActive')) { isActive = vacationRental.isActive; }
		if (vacationRental.$assignedFields.contains('rentalType')) { rentalType = vacationRental.rentalType; }
		if (vacationRental.$assignedFields.contains('instantBooking')) { instantBooking = vacationRental.instantBooking; }
		if (vacationRental.$assignedFields.contains('baseNightlyRate')) { baseNightlyRate = vacationRental.baseNightlyRate; }
		if (vacationRental.$assignedFields.contains('currency')) { currency = vacationRental.currency; }
		if (vacationRental.$assignedFields.contains('cleaningFee')) { cleaningFee = vacationRental.cleaningFee; }
		if (vacationRental.$assignedFields.contains('securityDeposit')) { securityDeposit = vacationRental.securityDeposit; }
		if (vacationRental.$assignedFields.contains('weeklyDiscount')) { weeklyDiscount = vacationRental.weeklyDiscount; }
		if (vacationRental.$assignedFields.contains('monthlyDiscount')) { monthlyDiscount = vacationRental.monthlyDiscount; }
		if (vacationRental.$assignedFields.contains('checkInTime')) { checkInTime = vacationRental.checkInTime; }
		if (vacationRental.$assignedFields.contains('checkOutTime')) { checkOutTime = vacationRental.checkOutTime; }
		if (vacationRental.$assignedFields.contains('minStayNights')) { minStayNights = vacationRental.minStayNights; }
		if (vacationRental.$assignedFields.contains('maxStayNights')) { maxStayNights = vacationRental.maxStayNights; }
		if (vacationRental.$assignedFields.contains('advanceBookingDays')) { advanceBookingDays = vacationRental.advanceBookingDays; }
		if (vacationRental.$assignedFields.contains('maxGuests')) { maxGuests = vacationRental.maxGuests; }
		if (vacationRental.$assignedFields.contains('childrenAllowed')) { childrenAllowed = vacationRental.childrenAllowed; }
		if (vacationRental.$assignedFields.contains('petsAllowed')) { petsAllowed = vacationRental.petsAllowed; }
		if (vacationRental.$assignedFields.contains('smokingAllowed')) { smokingAllowed = vacationRental.smokingAllowed; }
		if (vacationRental.$assignedFields.contains('eventsAllowed')) { eventsAllowed = vacationRental.eventsAllowed; }
		if (vacationRental.$assignedFields.contains('houseRules')) { houseRules = vacationRental.houseRules; }
		if (vacationRental.$assignedFields.contains('cancellationPolicy')) { cancellationPolicy = vacationRental.cancellationPolicy; }
		if (vacationRental.$assignedFields.contains('createdBy')) { createdBy = vacationRental.createdBy; }
		if (vacationRental.$assignedFields.contains('createdAt')) { createdAt = vacationRental.createdAt; }
		if (vacationRental.$assignedFields.contains('updatedAt')) { updatedAt = vacationRental.updatedAt; }
		if (vacationRental.$assignedFields.contains('deletedAt')) { deletedAt = vacationRental.deletedAt; }
		if (vacationRental.$assignedFields.contains('listing')) { listing = vacationRental.listing; }
		if (vacationRental.$assignedFields.contains('org')) { org = vacationRental.org; }
		if (vacationRental.$assignedFields.contains('property')) { property = vacationRental.property; }
		if (vacationRental.$assignedFields.contains('platformListings') && vacationRental.platformListings != null) { platformListings = mergeModelLists(platformListings, vacationRental.platformListings); }
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
          ? {...?serializedTypes, 'VacationRental'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(isActive != null) 'isActive': isActive,
	if(rentalType != null) 'rentalType': rentalType,
	if(instantBooking != null) 'instantBooking': instantBooking,
	if(baseNightlyRate != null) 'baseNightlyRate': baseNightlyRate,
	if(currency != null) 'currency': currency,
	if(cleaningFee != null) 'cleaningFee': cleaningFee,
	if(securityDeposit != null) 'securityDeposit': securityDeposit,
	if(weeklyDiscount != null) 'weeklyDiscount': weeklyDiscount,
	if(monthlyDiscount != null) 'monthlyDiscount': monthlyDiscount,
	if(checkInTime != null) 'checkInTime': checkInTime,
	if(checkOutTime != null) 'checkOutTime': checkOutTime,
	if(minStayNights != null) 'minStayNights': minStayNights,
	if(maxStayNights != null) 'maxStayNights': maxStayNights,
	if(advanceBookingDays != null) 'advanceBookingDays': advanceBookingDays,
	if(maxGuests != null) 'maxGuests': maxGuests,
	if(childrenAllowed != null) 'childrenAllowed': childrenAllowed,
	if(petsAllowed != null) 'petsAllowed': petsAllowed,
	if(smokingAllowed != null) 'smokingAllowed': smokingAllowed,
	if(eventsAllowed != null) 'eventsAllowed': eventsAllowed,
	if(houseRules != null) 'houseRules': houseRules,
	if(cancellationPolicy != null) 'cancellationPolicy': cancellationPolicy,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(platformListings != null && (!preventCircularSerialization || !serializedModels.contains('VacationRentalPlatform'))) 'platformListings': platformListings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($platformListingsCount != null) '_count': { 
		if ($platformListingsCount != null) 'platformListings': $platformListingsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is VacationRental &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    