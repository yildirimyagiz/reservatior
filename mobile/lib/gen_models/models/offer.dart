
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'offer_type.dart';
import 'offer_status.dart';
import 'user.dart';
import 'increase.dart';
import 'property.dart';
import 'reservation.dart';


class Offer implements PrismaModel<String, Offer> , Id<String> {
    String? increaseId;
	@override
String? id;
	OfferType? offerType;
	OfferStatus? status;
	double? basePrice;
	double? discountRate;
	double? finalPrice;
	String? guestId;
	DateTime? startDate;
	DateTime? endDate;
	String? specialRequirements;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? reservationId;
	String? propertyId;
	User? User;
	Increase? Increase;
	Property? Property;
	Reservation? Reservation;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Offer({ this.increaseId,
	 this.id,
	 this.offerType = OfferType.STANDARD,
	 this.status = OfferStatus.PENDING,
	 this.basePrice,
	 this.discountRate,
	 this.finalPrice,
	 this.guestId,
	 this.startDate,
	 this.endDate,
	 this.specialRequirements,
	 this.notes,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.reservationId,
	 this.propertyId,
	 this.User,
	 this.Increase,
	 this.Property,
	 this.Reservation,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Offer, dynamic>> propertyValueFunctionMap = {
      "increaseId": (m) => m.increaseId,

	"id": (m) => m.id,

	"offerType": (m) => m.offerType,

	"status": (m) => m.status,

	"basePrice": (m) => m.basePrice,

	"discountRate": (m) => m.discountRate,

	"finalPrice": (m) => m.finalPrice,

	"guestId": (m) => m.guestId,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"specialRequirements": (m) => m.specialRequirements,

	"notes": (m) => m.notes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"reservationId": (m) => m.reservationId,

	"propertyId": (m) => m.propertyId,

	"User": (m) => m.User,

	"Increase": (m) => m.Increase,

	"Property": (m) => m.Property,

	"Reservation": (m) => m.Reservation,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Offer) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Offer');
    }
    return propFunction as V? Function(Offer);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Offer.fromJson(JsonMap json) =>
      Offer(
        increaseId: json['increaseId'] as String?,
	id: json['id'] as String?,
	offerType: json['offerType'] != null ? OfferType.fromJson(json['offerType']) : null,
	status: json['status'] != null ? OfferStatus.fromJson(json['status']) : null,
	basePrice: json['basePrice']?.toDouble(),
	discountRate: json['discountRate']?.toDouble(),
	finalPrice: json['finalPrice']?.toDouble(),
	guestId: json['guestId'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	specialRequirements: json['specialRequirements'] as String?,
	notes: json['notes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	reservationId: json['reservationId'] as String?,
	propertyId: json['propertyId'] as String?,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
	Increase: json['Increase'] != null ? Increase.fromJson(json['Increase'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Reservation: json['Reservation'] != null ? Reservation.fromJson(json['Reservation'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Offer copyWith({
        Value<String?>? increaseId,
		Value<String?>? id,
		Value<OfferType?>? offerType,
		Value<OfferStatus?>? status,
		Value<double?>? basePrice,
		Value<double?>? discountRate,
		Value<double?>? finalPrice,
		Value<String?>? guestId,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<String?>? specialRequirements,
		Value<String?>? notes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? reservationId,
		Value<String?>? propertyId,
		Value<User?>? User,
		Value<Increase?>? Increase,
		Value<Property?>? Property,
		Value<Reservation?>? Reservation,
        }) {
        return Offer(
            increaseId: increaseId != null ? increaseId.value : this.increaseId,
		id: id != null ? id.value : this.id,
		offerType: offerType != null ? offerType.value : this.offerType,
		status: status != null ? status.value : this.status,
		basePrice: basePrice != null ? basePrice.value : this.basePrice,
		discountRate: discountRate != null ? discountRate.value : this.discountRate,
		finalPrice: finalPrice != null ? finalPrice.value : this.finalPrice,
		guestId: guestId != null ? guestId.value : this.guestId,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		specialRequirements: specialRequirements != null ? specialRequirements.value : this.specialRequirements,
		notes: notes != null ? notes.value : this.notes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		User: User != null ? User.value : this.User,
		Increase: Increase != null ? Increase.value : this.Increase,
		Property: Property != null ? Property.value : this.Property,
		Reservation: Reservation != null ? Reservation.value : this.Reservation
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Offer copyWithInstanceValues(Offer offer) {
        return Offer(
            increaseId: offer.increaseId ?? increaseId,
		id: offer.id ?? id,
		offerType: offer.offerType ?? offerType,
		status: offer.status ?? status,
		basePrice: offer.basePrice ?? basePrice,
		discountRate: offer.discountRate ?? discountRate,
		finalPrice: offer.finalPrice ?? finalPrice,
		guestId: offer.guestId ?? guestId,
		startDate: offer.startDate ?? startDate,
		endDate: offer.endDate ?? endDate,
		specialRequirements: offer.specialRequirements ?? specialRequirements,
		notes: offer.notes ?? notes,
		createdAt: offer.createdAt ?? createdAt,
		updatedAt: offer.updatedAt ?? updatedAt,
		deletedAt: offer.deletedAt ?? deletedAt,
		reservationId: offer.reservationId ?? reservationId,
		propertyId: offer.propertyId ?? propertyId,
		User: offer.User ?? User,
		Increase: offer.Increase ?? Increase,
		Property: offer.Property ?? Property,
		Reservation: offer.Reservation ?? Reservation
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Offer mergeWithInstanceValues(Offer offer) {
        return Offer(
            increaseId: offer.$assignedFields.contains('increaseId') ? offer.increaseId : increaseId,
		id: offer.$assignedFields.contains('id') ? offer.id : id,
		offerType: offer.$assignedFields.contains('offerType') ? offer.offerType : offerType,
		status: offer.$assignedFields.contains('status') ? offer.status : status,
		basePrice: offer.$assignedFields.contains('basePrice') ? offer.basePrice : basePrice,
		discountRate: offer.$assignedFields.contains('discountRate') ? offer.discountRate : discountRate,
		finalPrice: offer.$assignedFields.contains('finalPrice') ? offer.finalPrice : finalPrice,
		guestId: offer.$assignedFields.contains('guestId') ? offer.guestId : guestId,
		startDate: offer.$assignedFields.contains('startDate') ? offer.startDate : startDate,
		endDate: offer.$assignedFields.contains('endDate') ? offer.endDate : endDate,
		specialRequirements: offer.$assignedFields.contains('specialRequirements') ? offer.specialRequirements : specialRequirements,
		notes: offer.$assignedFields.contains('notes') ? offer.notes : notes,
		createdAt: offer.$assignedFields.contains('createdAt') ? offer.createdAt : createdAt,
		updatedAt: offer.$assignedFields.contains('updatedAt') ? offer.updatedAt : updatedAt,
		deletedAt: offer.$assignedFields.contains('deletedAt') ? offer.deletedAt : deletedAt,
		reservationId: offer.$assignedFields.contains('reservationId') ? offer.reservationId : reservationId,
		propertyId: offer.$assignedFields.contains('propertyId') ? offer.propertyId : propertyId,
		User: offer.$assignedFields.contains('User') ? offer.User : User,
		Increase: offer.$assignedFields.contains('Increase') ? offer.Increase : Increase,
		Property: offer.$assignedFields.contains('Property') ? offer.Property : Property,
		Reservation: offer.$assignedFields.contains('Reservation') ? offer.Reservation : Reservation
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Offer updateWithInstanceValues(Offer offer) {
        if (offer.$assignedFields.contains('increaseId')) { increaseId = offer.increaseId; }
		if (offer.$assignedFields.contains('id')) { id = offer.id; }
		if (offer.$assignedFields.contains('offerType')) { offerType = offer.offerType; }
		if (offer.$assignedFields.contains('status')) { status = offer.status; }
		if (offer.$assignedFields.contains('basePrice')) { basePrice = offer.basePrice; }
		if (offer.$assignedFields.contains('discountRate')) { discountRate = offer.discountRate; }
		if (offer.$assignedFields.contains('finalPrice')) { finalPrice = offer.finalPrice; }
		if (offer.$assignedFields.contains('guestId')) { guestId = offer.guestId; }
		if (offer.$assignedFields.contains('startDate')) { startDate = offer.startDate; }
		if (offer.$assignedFields.contains('endDate')) { endDate = offer.endDate; }
		if (offer.$assignedFields.contains('specialRequirements')) { specialRequirements = offer.specialRequirements; }
		if (offer.$assignedFields.contains('notes')) { notes = offer.notes; }
		if (offer.$assignedFields.contains('createdAt')) { createdAt = offer.createdAt; }
		if (offer.$assignedFields.contains('updatedAt')) { updatedAt = offer.updatedAt; }
		if (offer.$assignedFields.contains('deletedAt')) { deletedAt = offer.deletedAt; }
		if (offer.$assignedFields.contains('reservationId')) { reservationId = offer.reservationId; }
		if (offer.$assignedFields.contains('propertyId')) { propertyId = offer.propertyId; }
		if (offer.$assignedFields.contains('User')) { User = offer.User; }
		if (offer.$assignedFields.contains('Increase')) { Increase = offer.Increase; }
		if (offer.$assignedFields.contains('Property')) { Property = offer.Property; }
		if (offer.$assignedFields.contains('Reservation')) { Reservation = offer.Reservation; }
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
          ? {...?serializedTypes, 'Offer'} 
          : const {};
      return {
        if(increaseId != null) 'increaseId': increaseId,
	if(id != null) 'id': id,
	if(offerType != null) 'offerType': offerType?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(basePrice != null) 'basePrice': basePrice,
	if(discountRate != null) 'discountRate': discountRate,
	if(finalPrice != null) 'finalPrice': finalPrice,
	if(guestId != null) 'guestId': guestId,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(specialRequirements != null) 'specialRequirements': specialRequirements,
	if(notes != null) 'notes': notes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(reservationId != null) 'reservationId': reservationId,
	if(propertyId != null) 'propertyId': propertyId,
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Increase != null && (!preventCircularSerialization || !serializedModels.contains('Increase'))) 'Increase': Increase?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Offer &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    