
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'booking.dart';
import 'contact.dart';
import 'property.dart';


class GuestReview implements PrismaModel<String, GuestReview> , Id<String> {
    @override
String? id;
	String? bookingId;
	String? guestId;
	String? propertyId;
	int? rating;
	int? cleanliness;
	int? communication;
	int? checkIn;
	int? accuracy;
	int? location;
	int? value;
	String? comment;
	String? response;
	bool? isPublic;
	Booking? booking;
	Contact? guest;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    GuestReview({ this.id,
	 this.bookingId,
	 this.guestId,
	 this.propertyId,
	 this.rating,
	 this.cleanliness,
	 this.communication,
	 this.checkIn,
	 this.accuracy,
	 this.location,
	 this.value,
	 this.comment,
	 this.response,
	 this.isPublic = true,
	 this.booking,
	 this.guest,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<GuestReview, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"bookingId": (m) => m.bookingId,

	"guestId": (m) => m.guestId,

	"propertyId": (m) => m.propertyId,

	"rating": (m) => m.rating,

	"cleanliness": (m) => m.cleanliness,

	"communication": (m) => m.communication,

	"checkIn": (m) => m.checkIn,

	"accuracy": (m) => m.accuracy,

	"location": (m) => m.location,

	"value": (m) => m.value,

	"comment": (m) => m.comment,

	"response": (m) => m.response,

	"isPublic": (m) => m.isPublic,

	"booking": (m) => m.booking,

	"guest": (m) => m.guest,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(GuestReview) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in GuestReview');
    }
    return propFunction as V? Function(GuestReview);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory GuestReview.fromJson(JsonMap json) =>
      GuestReview(
        id: json['id'] as String?,
	bookingId: json['bookingId'] as String?,
	guestId: json['guestId'] as String?,
	propertyId: json['propertyId'] as String?,
	rating: int.tryParse(json['rating'].toString()),
	cleanliness: int.tryParse(json['cleanliness'].toString()),
	communication: int.tryParse(json['communication'].toString()),
	checkIn: int.tryParse(json['checkIn'].toString()),
	accuracy: int.tryParse(json['accuracy'].toString()),
	location: int.tryParse(json['location'].toString()),
	value: int.tryParse(json['value'].toString()),
	comment: json['comment'] as String?,
	response: json['response'] as String?,
	isPublic: json['isPublic'] as bool?,
	booking: json['booking'] != null ? Booking.fromJson(json['booking'] as JsonMap) : null,
	guest: json['guest'] != null ? Contact.fromJson(json['guest'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    GuestReview copyWith({
        Value<String?>? id,
		Value<String?>? bookingId,
		Value<String?>? guestId,
		Value<String?>? propertyId,
		Value<int?>? rating,
		Value<int?>? cleanliness,
		Value<int?>? communication,
		Value<int?>? checkIn,
		Value<int?>? accuracy,
		Value<int?>? location,
		Value<int?>? value,
		Value<String?>? comment,
		Value<String?>? response,
		Value<bool?>? isPublic,
		Value<Booking?>? booking,
		Value<Contact?>? guest,
		Value<Property?>? property,
        }) {
        return GuestReview(
            id: id != null ? id.value : this.id,
		bookingId: bookingId != null ? bookingId.value : this.bookingId,
		guestId: guestId != null ? guestId.value : this.guestId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		rating: rating != null ? rating.value : this.rating,
		cleanliness: cleanliness != null ? cleanliness.value : this.cleanliness,
		communication: communication != null ? communication.value : this.communication,
		checkIn: checkIn != null ? checkIn.value : this.checkIn,
		accuracy: accuracy != null ? accuracy.value : this.accuracy,
		location: location != null ? location.value : this.location,
		value: value != null ? value.value : this.value,
		comment: comment != null ? comment.value : this.comment,
		response: response != null ? response.value : this.response,
		isPublic: isPublic != null ? isPublic.value : this.isPublic,
		booking: booking != null ? booking.value : this.booking,
		guest: guest != null ? guest.value : this.guest,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    GuestReview copyWithInstanceValues(GuestReview guestReview) {
        return GuestReview(
            id: guestReview.id ?? id,
		bookingId: guestReview.bookingId ?? bookingId,
		guestId: guestReview.guestId ?? guestId,
		propertyId: guestReview.propertyId ?? propertyId,
		rating: guestReview.rating ?? rating,
		cleanliness: guestReview.cleanliness ?? cleanliness,
		communication: guestReview.communication ?? communication,
		checkIn: guestReview.checkIn ?? checkIn,
		accuracy: guestReview.accuracy ?? accuracy,
		location: guestReview.location ?? location,
		value: guestReview.value ?? value,
		comment: guestReview.comment ?? comment,
		response: guestReview.response ?? response,
		isPublic: guestReview.isPublic ?? isPublic,
		booking: guestReview.booking ?? booking,
		guest: guestReview.guest ?? guest,
		property: guestReview.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    GuestReview mergeWithInstanceValues(GuestReview guestReview) {
        return GuestReview(
            id: guestReview.$assignedFields.contains('id') ? guestReview.id : id,
		bookingId: guestReview.$assignedFields.contains('bookingId') ? guestReview.bookingId : bookingId,
		guestId: guestReview.$assignedFields.contains('guestId') ? guestReview.guestId : guestId,
		propertyId: guestReview.$assignedFields.contains('propertyId') ? guestReview.propertyId : propertyId,
		rating: guestReview.$assignedFields.contains('rating') ? guestReview.rating : rating,
		cleanliness: guestReview.$assignedFields.contains('cleanliness') ? guestReview.cleanliness : cleanliness,
		communication: guestReview.$assignedFields.contains('communication') ? guestReview.communication : communication,
		checkIn: guestReview.$assignedFields.contains('checkIn') ? guestReview.checkIn : checkIn,
		accuracy: guestReview.$assignedFields.contains('accuracy') ? guestReview.accuracy : accuracy,
		location: guestReview.$assignedFields.contains('location') ? guestReview.location : location,
		value: guestReview.$assignedFields.contains('value') ? guestReview.value : value,
		comment: guestReview.$assignedFields.contains('comment') ? guestReview.comment : comment,
		response: guestReview.$assignedFields.contains('response') ? guestReview.response : response,
		isPublic: guestReview.$assignedFields.contains('isPublic') ? guestReview.isPublic : isPublic,
		booking: guestReview.$assignedFields.contains('booking') ? guestReview.booking : booking,
		guest: guestReview.$assignedFields.contains('guest') ? guestReview.guest : guest,
		property: guestReview.$assignedFields.contains('property') ? guestReview.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    GuestReview updateWithInstanceValues(GuestReview guestReview) {
        if (guestReview.$assignedFields.contains('id')) { id = guestReview.id; }
		if (guestReview.$assignedFields.contains('bookingId')) { bookingId = guestReview.bookingId; }
		if (guestReview.$assignedFields.contains('guestId')) { guestId = guestReview.guestId; }
		if (guestReview.$assignedFields.contains('propertyId')) { propertyId = guestReview.propertyId; }
		if (guestReview.$assignedFields.contains('rating')) { rating = guestReview.rating; }
		if (guestReview.$assignedFields.contains('cleanliness')) { cleanliness = guestReview.cleanliness; }
		if (guestReview.$assignedFields.contains('communication')) { communication = guestReview.communication; }
		if (guestReview.$assignedFields.contains('checkIn')) { checkIn = guestReview.checkIn; }
		if (guestReview.$assignedFields.contains('accuracy')) { accuracy = guestReview.accuracy; }
		if (guestReview.$assignedFields.contains('location')) { location = guestReview.location; }
		if (guestReview.$assignedFields.contains('value')) { value = guestReview.value; }
		if (guestReview.$assignedFields.contains('comment')) { comment = guestReview.comment; }
		if (guestReview.$assignedFields.contains('response')) { response = guestReview.response; }
		if (guestReview.$assignedFields.contains('isPublic')) { isPublic = guestReview.isPublic; }
		if (guestReview.$assignedFields.contains('booking')) { booking = guestReview.booking; }
		if (guestReview.$assignedFields.contains('guest')) { guest = guestReview.guest; }
		if (guestReview.$assignedFields.contains('property')) { property = guestReview.property; }
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
          ? {...?serializedTypes, 'GuestReview'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(bookingId != null) 'bookingId': bookingId,
	if(guestId != null) 'guestId': guestId,
	if(propertyId != null) 'propertyId': propertyId,
	if(rating != null) 'rating': rating,
	if(cleanliness != null) 'cleanliness': cleanliness,
	if(communication != null) 'communication': communication,
	if(checkIn != null) 'checkIn': checkIn,
	if(accuracy != null) 'accuracy': accuracy,
	if(location != null) 'location': location,
	if(value != null) 'value': value,
	if(comment != null) 'comment': comment,
	if(response != null) 'response': response,
	if(isPublic != null) 'isPublic': isPublic,
	if(booking != null && (!preventCircularSerialization || !serializedModels.contains('Booking'))) 'booking': booking?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(guest != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'guest': guest?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is GuestReview &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    