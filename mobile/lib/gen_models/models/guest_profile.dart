
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';


class GuestProfile implements PrismaModel<String, GuestProfile> , Id<String> {
    @override
String? id;
	String? contactId;
	String? preferredCheckInTime;
	List<String>? preferredAmenities;
	String? dietaryRestrictions;
	String? accessibilityNeeds;
	int? loyaltyPoints;
	double? lifetimeSpent;
	int? bookingCount;
	Contact? contact;
	int? $preferredAmenitiesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    GuestProfile({ this.id,
	 this.contactId,
	 this.preferredCheckInTime,
	 this.preferredAmenities,
	 this.dietaryRestrictions,
	 this.accessibilityNeeds,
	 this.loyaltyPoints = 0,
	 this.lifetimeSpent = 0,
	 this.bookingCount = 0,
	 this.contact,
	this.$preferredAmenitiesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<GuestProfile, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"contactId": (m) => m.contactId,

	"preferredCheckInTime": (m) => m.preferredCheckInTime,

	"preferredAmenities": (m) => m.preferredAmenities,

	"dietaryRestrictions": (m) => m.dietaryRestrictions,

	"accessibilityNeeds": (m) => m.accessibilityNeeds,

	"loyaltyPoints": (m) => m.loyaltyPoints,

	"lifetimeSpent": (m) => m.lifetimeSpent,

	"bookingCount": (m) => m.bookingCount,

	"contact": (m) => m.contact,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(GuestProfile) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in GuestProfile');
    }
    return propFunction as V? Function(GuestProfile);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory GuestProfile.fromJson(JsonMap json) =>
      GuestProfile(
        id: json['id'] as String?,
	contactId: json['contactId'] as String?,
	preferredCheckInTime: json['preferredCheckInTime'] as String?,
	preferredAmenities: json['preferredAmenities'] != null ? (json['preferredAmenities'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	dietaryRestrictions: json['dietaryRestrictions'] as String?,
	accessibilityNeeds: json['accessibilityNeeds'] as String?,
	loyaltyPoints: int.tryParse(json['loyaltyPoints'].toString()),
	lifetimeSpent: json['lifetimeSpent'] as double?,
	bookingCount: int.tryParse(json['bookingCount'].toString()),
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	$preferredAmenitiesCount: json['_count']?['preferredAmenities'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    GuestProfile copyWith({
        Value<String?>? id,
		Value<String?>? contactId,
		Value<String?>? preferredCheckInTime,
		Value<List<String>?>? preferredAmenities,
		Value<String?>? dietaryRestrictions,
		Value<String?>? accessibilityNeeds,
		Value<int?>? loyaltyPoints,
		Value<double?>? lifetimeSpent,
		Value<int?>? bookingCount,
		Value<Contact?>? contact,
		int? $preferredAmenitiesCount,
        }) {
        return GuestProfile(
            id: id != null ? id.value : this.id,
		contactId: contactId != null ? contactId.value : this.contactId,
		preferredCheckInTime: preferredCheckInTime != null ? preferredCheckInTime.value : this.preferredCheckInTime,
		preferredAmenities: preferredAmenities != null ? preferredAmenities.value : this.preferredAmenities,
		dietaryRestrictions: dietaryRestrictions != null ? dietaryRestrictions.value : this.dietaryRestrictions,
		accessibilityNeeds: accessibilityNeeds != null ? accessibilityNeeds.value : this.accessibilityNeeds,
		loyaltyPoints: loyaltyPoints != null ? loyaltyPoints.value : this.loyaltyPoints,
		lifetimeSpent: lifetimeSpent != null ? lifetimeSpent.value : this.lifetimeSpent,
		bookingCount: bookingCount != null ? bookingCount.value : this.bookingCount,
		contact: contact != null ? contact.value : this.contact,
		$preferredAmenitiesCount: $preferredAmenitiesCount ?? this.$preferredAmenitiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    GuestProfile copyWithInstanceValues(GuestProfile guestProfile) {
        return GuestProfile(
            id: guestProfile.id ?? id,
		contactId: guestProfile.contactId ?? contactId,
		preferredCheckInTime: guestProfile.preferredCheckInTime ?? preferredCheckInTime,
		preferredAmenities: guestProfile.preferredAmenities ?? preferredAmenities,
		dietaryRestrictions: guestProfile.dietaryRestrictions ?? dietaryRestrictions,
		accessibilityNeeds: guestProfile.accessibilityNeeds ?? accessibilityNeeds,
		loyaltyPoints: guestProfile.loyaltyPoints ?? loyaltyPoints,
		lifetimeSpent: guestProfile.lifetimeSpent ?? lifetimeSpent,
		bookingCount: guestProfile.bookingCount ?? bookingCount,
		contact: guestProfile.contact ?? contact,
		$preferredAmenitiesCount: guestProfile.$preferredAmenitiesCount ?? $preferredAmenitiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    GuestProfile mergeWithInstanceValues(GuestProfile guestProfile) {
        return GuestProfile(
            id: guestProfile.$assignedFields.contains('id') ? guestProfile.id : id,
		contactId: guestProfile.$assignedFields.contains('contactId') ? guestProfile.contactId : contactId,
		preferredCheckInTime: guestProfile.$assignedFields.contains('preferredCheckInTime') ? guestProfile.preferredCheckInTime : preferredCheckInTime,
		preferredAmenities: guestProfile.$assignedFields.contains('preferredAmenities') ? guestProfile.preferredAmenities : preferredAmenities,
		dietaryRestrictions: guestProfile.$assignedFields.contains('dietaryRestrictions') ? guestProfile.dietaryRestrictions : dietaryRestrictions,
		accessibilityNeeds: guestProfile.$assignedFields.contains('accessibilityNeeds') ? guestProfile.accessibilityNeeds : accessibilityNeeds,
		loyaltyPoints: guestProfile.$assignedFields.contains('loyaltyPoints') ? guestProfile.loyaltyPoints : loyaltyPoints,
		lifetimeSpent: guestProfile.$assignedFields.contains('lifetimeSpent') ? guestProfile.lifetimeSpent : lifetimeSpent,
		bookingCount: guestProfile.$assignedFields.contains('bookingCount') ? guestProfile.bookingCount : bookingCount,
		contact: guestProfile.$assignedFields.contains('contact') ? guestProfile.contact : contact,
		$preferredAmenitiesCount: guestProfile.$preferredAmenitiesCount ?? $preferredAmenitiesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    GuestProfile updateWithInstanceValues(GuestProfile guestProfile) {
        if (guestProfile.$assignedFields.contains('id')) { id = guestProfile.id; }
		if (guestProfile.$assignedFields.contains('contactId')) { contactId = guestProfile.contactId; }
		if (guestProfile.$assignedFields.contains('preferredCheckInTime')) { preferredCheckInTime = guestProfile.preferredCheckInTime; }
		if (guestProfile.$assignedFields.contains('preferredAmenities')) { preferredAmenities = guestProfile.preferredAmenities; }
		if (guestProfile.$assignedFields.contains('dietaryRestrictions')) { dietaryRestrictions = guestProfile.dietaryRestrictions; }
		if (guestProfile.$assignedFields.contains('accessibilityNeeds')) { accessibilityNeeds = guestProfile.accessibilityNeeds; }
		if (guestProfile.$assignedFields.contains('loyaltyPoints')) { loyaltyPoints = guestProfile.loyaltyPoints; }
		if (guestProfile.$assignedFields.contains('lifetimeSpent')) { lifetimeSpent = guestProfile.lifetimeSpent; }
		if (guestProfile.$assignedFields.contains('bookingCount')) { bookingCount = guestProfile.bookingCount; }
		if (guestProfile.$assignedFields.contains('contact')) { contact = guestProfile.contact; }
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
          ? {...?serializedTypes, 'GuestProfile'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(contactId != null) 'contactId': contactId,
	if(preferredCheckInTime != null) 'preferredCheckInTime': preferredCheckInTime,
	if(preferredAmenities != null) 'preferredAmenities': preferredAmenities,
	if(dietaryRestrictions != null) 'dietaryRestrictions': dietaryRestrictions,
	if(accessibilityNeeds != null) 'accessibilityNeeds': accessibilityNeeds,
	if(loyaltyPoints != null) 'loyaltyPoints': loyaltyPoints,
	if(lifetimeSpent != null) 'lifetimeSpent': lifetimeSpent,
	if(bookingCount != null) 'bookingCount': bookingCount,
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($preferredAmenitiesCount != null) '_count': { 
		if ($preferredAmenitiesCount != null) 'preferredAmenities': $preferredAmenitiesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is GuestProfile &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    