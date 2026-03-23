
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'pricing_rule.dart';
import 'property.dart';
import 'reservation.dart';


class Availability implements PrismaModel<String, Availability> , Id<String> {
    @override
String? id;
	DateTime? date;
	bool? isBlocked;
	bool? isBooked;
	String? propertyId;
	String? reservationId;
	String? pricingRuleId;
	int? totalUnits;
	int? availableUnits;
	int? bookedUnits;
	int? blockedUnits;
	dynamic specialPricing;
	double? basePrice;
	double? currentPrice;
	dynamic priceSettings;
	int? minNights;
	int? maxNights;
	int? maxGuests;
	dynamic discountSettings;
	double? weekendRate;
	double? weekdayRate;
	double? weekendMultiplier;
	double? weekdayMultiplier;
	double? seasonalMultiplier;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	PricingRule? pricingRule;
	Property? property;
	Reservation? reservation;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Availability({ this.id,
	 this.date,
	 this.isBlocked = false,
	 this.isBooked = false,
	 this.propertyId,
	 this.reservationId,
	 this.pricingRuleId,
	 this.totalUnits = 1,
	 this.availableUnits = 1,
	 this.bookedUnits = 0,
	 this.blockedUnits = 0,
	required this.specialPricing,
	 this.basePrice = 0,
	 this.currentPrice = 0,
	required this.priceSettings,
	 this.minNights = 1,
	 this.maxNights = 365,
	 this.maxGuests = 2,
	required this.discountSettings,
	 this.weekendRate,
	 this.weekdayRate,
	 this.weekendMultiplier = 1,
	 this.weekdayMultiplier = 1,
	 this.seasonalMultiplier = 1,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.pricingRule,
	 this.property,
	 this.reservation,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Availability, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"date": (m) => m.date,

	"isBlocked": (m) => m.isBlocked,

	"isBooked": (m) => m.isBooked,

	"propertyId": (m) => m.propertyId,

	"reservationId": (m) => m.reservationId,

	"pricingRuleId": (m) => m.pricingRuleId,

	"totalUnits": (m) => m.totalUnits,

	"availableUnits": (m) => m.availableUnits,

	"bookedUnits": (m) => m.bookedUnits,

	"blockedUnits": (m) => m.blockedUnits,

	"specialPricing": (m) => m.specialPricing,

	"basePrice": (m) => m.basePrice,

	"currentPrice": (m) => m.currentPrice,

	"priceSettings": (m) => m.priceSettings,

	"minNights": (m) => m.minNights,

	"maxNights": (m) => m.maxNights,

	"maxGuests": (m) => m.maxGuests,

	"discountSettings": (m) => m.discountSettings,

	"weekendRate": (m) => m.weekendRate,

	"weekdayRate": (m) => m.weekdayRate,

	"weekendMultiplier": (m) => m.weekendMultiplier,

	"weekdayMultiplier": (m) => m.weekdayMultiplier,

	"seasonalMultiplier": (m) => m.seasonalMultiplier,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"pricingRule": (m) => m.pricingRule,

	"property": (m) => m.property,

	"reservation": (m) => m.reservation,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Availability) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Availability');
    }
    return propFunction as V? Function(Availability);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Availability.fromJson(JsonMap json) =>
      Availability(
        id: json['id'] as String?,
	date: json['date'] != null ? DateTime.parse(json['date']) : null,
	isBlocked: json['isBlocked'] as bool?,
	isBooked: json['isBooked'] as bool?,
	propertyId: json['propertyId'] as String?,
	reservationId: json['reservationId'] as String?,
	pricingRuleId: json['pricingRuleId'] as String?,
	totalUnits: int.tryParse(json['totalUnits'].toString()),
	availableUnits: int.tryParse(json['availableUnits'].toString()),
	bookedUnits: int.tryParse(json['bookedUnits'].toString()),
	blockedUnits: int.tryParse(json['blockedUnits'].toString()),
	specialPricing: json['specialPricing'] as dynamic,
	basePrice: json['basePrice']?.toDouble(),
	currentPrice: json['currentPrice']?.toDouble(),
	priceSettings: json['priceSettings'] as dynamic,
	minNights: int.tryParse(json['minNights'].toString()),
	maxNights: int.tryParse(json['maxNights'].toString()),
	maxGuests: int.tryParse(json['maxGuests'].toString()),
	discountSettings: json['discountSettings'] as dynamic,
	weekendRate: json['weekendRate']?.toDouble(),
	weekdayRate: json['weekdayRate']?.toDouble(),
	weekendMultiplier: json['weekendMultiplier']?.toDouble(),
	weekdayMultiplier: json['weekdayMultiplier']?.toDouble(),
	seasonalMultiplier: json['seasonalMultiplier']?.toDouble(),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	pricingRule: json['pricingRule'] != null ? PricingRule.fromJson(json['pricingRule'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Availability copyWith({
        Value<String?>? id,
		Value<DateTime?>? date,
		Value<bool?>? isBlocked,
		Value<bool?>? isBooked,
		Value<String?>? propertyId,
		Value<String?>? reservationId,
		Value<String?>? pricingRuleId,
		Value<int?>? totalUnits,
		Value<int?>? availableUnits,
		Value<int?>? bookedUnits,
		Value<int?>? blockedUnits,
		Value<dynamic>? specialPricing,
		Value<double?>? basePrice,
		Value<double?>? currentPrice,
		Value<dynamic>? priceSettings,
		Value<int?>? minNights,
		Value<int?>? maxNights,
		Value<int?>? maxGuests,
		Value<dynamic>? discountSettings,
		Value<double?>? weekendRate,
		Value<double?>? weekdayRate,
		Value<double?>? weekendMultiplier,
		Value<double?>? weekdayMultiplier,
		Value<double?>? seasonalMultiplier,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<PricingRule?>? pricingRule,
		Value<Property?>? property,
		Value<Reservation?>? reservation,
        }) {
        return Availability(
            id: id != null ? id.value : this.id,
		date: date != null ? date.value : this.date,
		isBlocked: isBlocked != null ? isBlocked.value : this.isBlocked,
		isBooked: isBooked != null ? isBooked.value : this.isBooked,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		pricingRuleId: pricingRuleId != null ? pricingRuleId.value : this.pricingRuleId,
		totalUnits: totalUnits != null ? totalUnits.value : this.totalUnits,
		availableUnits: availableUnits != null ? availableUnits.value : this.availableUnits,
		bookedUnits: bookedUnits != null ? bookedUnits.value : this.bookedUnits,
		blockedUnits: blockedUnits != null ? blockedUnits.value : this.blockedUnits,
		specialPricing: specialPricing != null ? specialPricing.value : this.specialPricing,
		basePrice: basePrice != null ? basePrice.value : this.basePrice,
		currentPrice: currentPrice != null ? currentPrice.value : this.currentPrice,
		priceSettings: priceSettings != null ? priceSettings.value : this.priceSettings,
		minNights: minNights != null ? minNights.value : this.minNights,
		maxNights: maxNights != null ? maxNights.value : this.maxNights,
		maxGuests: maxGuests != null ? maxGuests.value : this.maxGuests,
		discountSettings: discountSettings != null ? discountSettings.value : this.discountSettings,
		weekendRate: weekendRate != null ? weekendRate.value : this.weekendRate,
		weekdayRate: weekdayRate != null ? weekdayRate.value : this.weekdayRate,
		weekendMultiplier: weekendMultiplier != null ? weekendMultiplier.value : this.weekendMultiplier,
		weekdayMultiplier: weekdayMultiplier != null ? weekdayMultiplier.value : this.weekdayMultiplier,
		seasonalMultiplier: seasonalMultiplier != null ? seasonalMultiplier.value : this.seasonalMultiplier,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		pricingRule: pricingRule != null ? pricingRule.value : this.pricingRule,
		property: property != null ? property.value : this.property,
		reservation: reservation != null ? reservation.value : this.reservation
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Availability copyWithInstanceValues(Availability availability) {
        return Availability(
            id: availability.id ?? id,
		date: availability.date ?? date,
		isBlocked: availability.isBlocked ?? isBlocked,
		isBooked: availability.isBooked ?? isBooked,
		propertyId: availability.propertyId ?? propertyId,
		reservationId: availability.reservationId ?? reservationId,
		pricingRuleId: availability.pricingRuleId ?? pricingRuleId,
		totalUnits: availability.totalUnits ?? totalUnits,
		availableUnits: availability.availableUnits ?? availableUnits,
		bookedUnits: availability.bookedUnits ?? bookedUnits,
		blockedUnits: availability.blockedUnits ?? blockedUnits,
		specialPricing: availability.specialPricing ?? specialPricing,
		basePrice: availability.basePrice ?? basePrice,
		currentPrice: availability.currentPrice ?? currentPrice,
		priceSettings: availability.priceSettings ?? priceSettings,
		minNights: availability.minNights ?? minNights,
		maxNights: availability.maxNights ?? maxNights,
		maxGuests: availability.maxGuests ?? maxGuests,
		discountSettings: availability.discountSettings ?? discountSettings,
		weekendRate: availability.weekendRate ?? weekendRate,
		weekdayRate: availability.weekdayRate ?? weekdayRate,
		weekendMultiplier: availability.weekendMultiplier ?? weekendMultiplier,
		weekdayMultiplier: availability.weekdayMultiplier ?? weekdayMultiplier,
		seasonalMultiplier: availability.seasonalMultiplier ?? seasonalMultiplier,
		createdAt: availability.createdAt ?? createdAt,
		updatedAt: availability.updatedAt ?? updatedAt,
		deletedAt: availability.deletedAt ?? deletedAt,
		pricingRule: availability.pricingRule ?? pricingRule,
		property: availability.property ?? property,
		reservation: availability.reservation ?? reservation
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Availability mergeWithInstanceValues(Availability availability) {
        return Availability(
            id: availability.$assignedFields.contains('id') ? availability.id : id,
		date: availability.$assignedFields.contains('date') ? availability.date : date,
		isBlocked: availability.$assignedFields.contains('isBlocked') ? availability.isBlocked : isBlocked,
		isBooked: availability.$assignedFields.contains('isBooked') ? availability.isBooked : isBooked,
		propertyId: availability.$assignedFields.contains('propertyId') ? availability.propertyId : propertyId,
		reservationId: availability.$assignedFields.contains('reservationId') ? availability.reservationId : reservationId,
		pricingRuleId: availability.$assignedFields.contains('pricingRuleId') ? availability.pricingRuleId : pricingRuleId,
		totalUnits: availability.$assignedFields.contains('totalUnits') ? availability.totalUnits : totalUnits,
		availableUnits: availability.$assignedFields.contains('availableUnits') ? availability.availableUnits : availableUnits,
		bookedUnits: availability.$assignedFields.contains('bookedUnits') ? availability.bookedUnits : bookedUnits,
		blockedUnits: availability.$assignedFields.contains('blockedUnits') ? availability.blockedUnits : blockedUnits,
		specialPricing: availability.$assignedFields.contains('specialPricing') ? availability.specialPricing : specialPricing,
		basePrice: availability.$assignedFields.contains('basePrice') ? availability.basePrice : basePrice,
		currentPrice: availability.$assignedFields.contains('currentPrice') ? availability.currentPrice : currentPrice,
		priceSettings: availability.$assignedFields.contains('priceSettings') ? availability.priceSettings : priceSettings,
		minNights: availability.$assignedFields.contains('minNights') ? availability.minNights : minNights,
		maxNights: availability.$assignedFields.contains('maxNights') ? availability.maxNights : maxNights,
		maxGuests: availability.$assignedFields.contains('maxGuests') ? availability.maxGuests : maxGuests,
		discountSettings: availability.$assignedFields.contains('discountSettings') ? availability.discountSettings : discountSettings,
		weekendRate: availability.$assignedFields.contains('weekendRate') ? availability.weekendRate : weekendRate,
		weekdayRate: availability.$assignedFields.contains('weekdayRate') ? availability.weekdayRate : weekdayRate,
		weekendMultiplier: availability.$assignedFields.contains('weekendMultiplier') ? availability.weekendMultiplier : weekendMultiplier,
		weekdayMultiplier: availability.$assignedFields.contains('weekdayMultiplier') ? availability.weekdayMultiplier : weekdayMultiplier,
		seasonalMultiplier: availability.$assignedFields.contains('seasonalMultiplier') ? availability.seasonalMultiplier : seasonalMultiplier,
		createdAt: availability.$assignedFields.contains('createdAt') ? availability.createdAt : createdAt,
		updatedAt: availability.$assignedFields.contains('updatedAt') ? availability.updatedAt : updatedAt,
		deletedAt: availability.$assignedFields.contains('deletedAt') ? availability.deletedAt : deletedAt,
		pricingRule: availability.$assignedFields.contains('pricingRule') ? availability.pricingRule : pricingRule,
		property: availability.$assignedFields.contains('property') ? availability.property : property,
		reservation: availability.$assignedFields.contains('reservation') ? availability.reservation : reservation
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Availability updateWithInstanceValues(Availability availability) {
        if (availability.$assignedFields.contains('id')) { id = availability.id; }
		if (availability.$assignedFields.contains('date')) { date = availability.date; }
		if (availability.$assignedFields.contains('isBlocked')) { isBlocked = availability.isBlocked; }
		if (availability.$assignedFields.contains('isBooked')) { isBooked = availability.isBooked; }
		if (availability.$assignedFields.contains('propertyId')) { propertyId = availability.propertyId; }
		if (availability.$assignedFields.contains('reservationId')) { reservationId = availability.reservationId; }
		if (availability.$assignedFields.contains('pricingRuleId')) { pricingRuleId = availability.pricingRuleId; }
		if (availability.$assignedFields.contains('totalUnits')) { totalUnits = availability.totalUnits; }
		if (availability.$assignedFields.contains('availableUnits')) { availableUnits = availability.availableUnits; }
		if (availability.$assignedFields.contains('bookedUnits')) { bookedUnits = availability.bookedUnits; }
		if (availability.$assignedFields.contains('blockedUnits')) { blockedUnits = availability.blockedUnits; }
		if (availability.$assignedFields.contains('specialPricing')) { specialPricing = availability.specialPricing; }
		if (availability.$assignedFields.contains('basePrice')) { basePrice = availability.basePrice; }
		if (availability.$assignedFields.contains('currentPrice')) { currentPrice = availability.currentPrice; }
		if (availability.$assignedFields.contains('priceSettings')) { priceSettings = availability.priceSettings; }
		if (availability.$assignedFields.contains('minNights')) { minNights = availability.minNights; }
		if (availability.$assignedFields.contains('maxNights')) { maxNights = availability.maxNights; }
		if (availability.$assignedFields.contains('maxGuests')) { maxGuests = availability.maxGuests; }
		if (availability.$assignedFields.contains('discountSettings')) { discountSettings = availability.discountSettings; }
		if (availability.$assignedFields.contains('weekendRate')) { weekendRate = availability.weekendRate; }
		if (availability.$assignedFields.contains('weekdayRate')) { weekdayRate = availability.weekdayRate; }
		if (availability.$assignedFields.contains('weekendMultiplier')) { weekendMultiplier = availability.weekendMultiplier; }
		if (availability.$assignedFields.contains('weekdayMultiplier')) { weekdayMultiplier = availability.weekdayMultiplier; }
		if (availability.$assignedFields.contains('seasonalMultiplier')) { seasonalMultiplier = availability.seasonalMultiplier; }
		if (availability.$assignedFields.contains('createdAt')) { createdAt = availability.createdAt; }
		if (availability.$assignedFields.contains('updatedAt')) { updatedAt = availability.updatedAt; }
		if (availability.$assignedFields.contains('deletedAt')) { deletedAt = availability.deletedAt; }
		if (availability.$assignedFields.contains('pricingRule')) { pricingRule = availability.pricingRule; }
		if (availability.$assignedFields.contains('property')) { property = availability.property; }
		if (availability.$assignedFields.contains('reservation')) { reservation = availability.reservation; }
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
          ? {...?serializedTypes, 'Availability'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(date != null) 'date': date?.toIso8601String(),
	if(isBlocked != null) 'isBlocked': isBlocked,
	if(isBooked != null) 'isBooked': isBooked,
	if(propertyId != null) 'propertyId': propertyId,
	if(reservationId != null) 'reservationId': reservationId,
	if(pricingRuleId != null) 'pricingRuleId': pricingRuleId,
	if(totalUnits != null) 'totalUnits': totalUnits,
	if(availableUnits != null) 'availableUnits': availableUnits,
	if(bookedUnits != null) 'bookedUnits': bookedUnits,
	if(blockedUnits != null) 'blockedUnits': blockedUnits,
	if(specialPricing != null) 'specialPricing': specialPricing,
	if(basePrice != null) 'basePrice': basePrice,
	if(currentPrice != null) 'currentPrice': currentPrice,
	if(priceSettings != null) 'priceSettings': priceSettings,
	if(minNights != null) 'minNights': minNights,
	if(maxNights != null) 'maxNights': maxNights,
	if(maxGuests != null) 'maxGuests': maxGuests,
	if(discountSettings != null) 'discountSettings': discountSettings,
	if(weekendRate != null) 'weekendRate': weekendRate,
	if(weekdayRate != null) 'weekdayRate': weekdayRate,
	if(weekendMultiplier != null) 'weekendMultiplier': weekendMultiplier,
	if(weekdayMultiplier != null) 'weekdayMultiplier': weekdayMultiplier,
	if(seasonalMultiplier != null) 'seasonalMultiplier': seasonalMultiplier,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(pricingRule != null && (!preventCircularSerialization || !serializedModels.contains('PricingRule'))) 'pricingRule': pricingRule?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservation': reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Availability &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    