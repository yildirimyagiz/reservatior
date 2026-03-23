
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'gender.dart';
import 'agency.dart';
import 'property.dart';
import 'reservation.dart';


class Guest implements PrismaModel<String, Guest> , Id<String> {
    @override
String? id;
	String? name;
	String? phone;
	String? image;
	String? nationality;
	String? passportNumber;
	Gender? gender;
	DateTime? birthDate;
	String? address;
	String? city;
	String? country;
	String? zipCode;
	String? email;
	String? agencyId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Agency? Agency;
	List<Property>? Property;
	List<Reservation>? Reservation;
	int? $PropertyCount;
	int? $ReservationCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Guest({ this.id,
	 this.name,
	 this.phone,
	 this.image,
	 this.nationality,
	 this.passportNumber,
	 this.gender,
	 this.birthDate,
	 this.address,
	 this.city,
	 this.country,
	 this.zipCode,
	 this.email,
	 this.agencyId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.Agency,
	 this.Property,
	 this.Reservation,
	this.$PropertyCount,
	this.$ReservationCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Guest, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"name": (m) => m.name,

	"phone": (m) => m.phone,

	"image": (m) => m.image,

	"nationality": (m) => m.nationality,

	"passportNumber": (m) => m.passportNumber,

	"gender": (m) => m.gender,

	"birthDate": (m) => m.birthDate,

	"address": (m) => m.address,

	"city": (m) => m.city,

	"country": (m) => m.country,

	"zipCode": (m) => m.zipCode,

	"email": (m) => m.email,

	"agencyId": (m) => m.agencyId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"Agency": (m) => m.Agency,

	"Property": (m) => m.Property,

	"Reservation": (m) => m.Reservation,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Guest) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Guest');
    }
    return propFunction as V? Function(Guest);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Guest.fromJson(JsonMap json) =>
      Guest(
        id: json['id'] as String?,
	name: json['name'] as String?,
	phone: json['phone'] as String?,
	image: json['image'] as String?,
	nationality: json['nationality'] as String?,
	passportNumber: json['passportNumber'] as String?,
	gender: json['gender'] != null ? Gender.fromJson(json['gender']) : null,
	birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
	address: json['address'] as String?,
	city: json['city'] as String?,
	country: json['country'] as String?,
	zipCode: json['zipCode'] as String?,
	email: json['email'] as String?,
	agencyId: json['agencyId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Property: json['Property'] != null ? createModels<Property>((json['Property'] as List).cast<JsonMap>(), Property.fromJson) : null,
	Reservation: json['Reservation'] != null ? createModels<Reservation>((json['Reservation'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	$PropertyCount: json['_count']?['Property'] as int?,
	$ReservationCount: json['_count']?['Reservation'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Guest copyWith({
        Value<String?>? id,
		Value<String?>? name,
		Value<String?>? phone,
		Value<String?>? image,
		Value<String?>? nationality,
		Value<String?>? passportNumber,
		Value<Gender?>? gender,
		Value<DateTime?>? birthDate,
		Value<String?>? address,
		Value<String?>? city,
		Value<String?>? country,
		Value<String?>? zipCode,
		Value<String?>? email,
		Value<String?>? agencyId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Agency?>? Agency,
		Value<List<Property>?>? Property,
		Value<List<Reservation>?>? Reservation,
		int? $PropertyCount,
		int? $ReservationCount,
        }) {
        return Guest(
            id: id != null ? id.value : this.id,
		name: name != null ? name.value : this.name,
		phone: phone != null ? phone.value : this.phone,
		image: image != null ? image.value : this.image,
		nationality: nationality != null ? nationality.value : this.nationality,
		passportNumber: passportNumber != null ? passportNumber.value : this.passportNumber,
		gender: gender != null ? gender.value : this.gender,
		birthDate: birthDate != null ? birthDate.value : this.birthDate,
		address: address != null ? address.value : this.address,
		city: city != null ? city.value : this.city,
		country: country != null ? country.value : this.country,
		zipCode: zipCode != null ? zipCode.value : this.zipCode,
		email: email != null ? email.value : this.email,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		Agency: Agency != null ? Agency.value : this.Agency,
		Property: Property != null ? Property.value : this.Property,
		Reservation: Reservation != null ? Reservation.value : this.Reservation,
		$PropertyCount: $PropertyCount ?? this.$PropertyCount,
		$ReservationCount: $ReservationCount ?? this.$ReservationCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Guest copyWithInstanceValues(Guest guest) {
        return Guest(
            id: guest.id ?? id,
		name: guest.name ?? name,
		phone: guest.phone ?? phone,
		image: guest.image ?? image,
		nationality: guest.nationality ?? nationality,
		passportNumber: guest.passportNumber ?? passportNumber,
		gender: guest.gender ?? gender,
		birthDate: guest.birthDate ?? birthDate,
		address: guest.address ?? address,
		city: guest.city ?? city,
		country: guest.country ?? country,
		zipCode: guest.zipCode ?? zipCode,
		email: guest.email ?? email,
		agencyId: guest.agencyId ?? agencyId,
		createdAt: guest.createdAt ?? createdAt,
		updatedAt: guest.updatedAt ?? updatedAt,
		deletedAt: guest.deletedAt ?? deletedAt,
		Agency: guest.Agency ?? Agency,
		Property: guest.Property ?? Property,
		Reservation: guest.Reservation ?? Reservation,
		$PropertyCount: guest.$PropertyCount ?? $PropertyCount,
		$ReservationCount: guest.$ReservationCount ?? $ReservationCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Guest mergeWithInstanceValues(Guest guest) {
        return Guest(
            id: guest.$assignedFields.contains('id') ? guest.id : id,
		name: guest.$assignedFields.contains('name') ? guest.name : name,
		phone: guest.$assignedFields.contains('phone') ? guest.phone : phone,
		image: guest.$assignedFields.contains('image') ? guest.image : image,
		nationality: guest.$assignedFields.contains('nationality') ? guest.nationality : nationality,
		passportNumber: guest.$assignedFields.contains('passportNumber') ? guest.passportNumber : passportNumber,
		gender: guest.$assignedFields.contains('gender') ? guest.gender : gender,
		birthDate: guest.$assignedFields.contains('birthDate') ? guest.birthDate : birthDate,
		address: guest.$assignedFields.contains('address') ? guest.address : address,
		city: guest.$assignedFields.contains('city') ? guest.city : city,
		country: guest.$assignedFields.contains('country') ? guest.country : country,
		zipCode: guest.$assignedFields.contains('zipCode') ? guest.zipCode : zipCode,
		email: guest.$assignedFields.contains('email') ? guest.email : email,
		agencyId: guest.$assignedFields.contains('agencyId') ? guest.agencyId : agencyId,
		createdAt: guest.$assignedFields.contains('createdAt') ? guest.createdAt : createdAt,
		updatedAt: guest.$assignedFields.contains('updatedAt') ? guest.updatedAt : updatedAt,
		deletedAt: guest.$assignedFields.contains('deletedAt') ? guest.deletedAt : deletedAt,
		Agency: guest.$assignedFields.contains('Agency') ? guest.Agency : Agency,
		Property: (guest.$assignedFields.contains('Property') && guest.Property != null) ? mergeModelLists(Property, guest.Property) : Property,
		Reservation: (guest.$assignedFields.contains('Reservation') && guest.Reservation != null) ? mergeModelLists(Reservation, guest.Reservation) : Reservation,
		$PropertyCount: guest.$PropertyCount ?? $PropertyCount,
		$ReservationCount: guest.$ReservationCount ?? $ReservationCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Guest updateWithInstanceValues(Guest guest) {
        if (guest.$assignedFields.contains('id')) { id = guest.id; }
		if (guest.$assignedFields.contains('name')) { name = guest.name; }
		if (guest.$assignedFields.contains('phone')) { phone = guest.phone; }
		if (guest.$assignedFields.contains('image')) { image = guest.image; }
		if (guest.$assignedFields.contains('nationality')) { nationality = guest.nationality; }
		if (guest.$assignedFields.contains('passportNumber')) { passportNumber = guest.passportNumber; }
		if (guest.$assignedFields.contains('gender')) { gender = guest.gender; }
		if (guest.$assignedFields.contains('birthDate')) { birthDate = guest.birthDate; }
		if (guest.$assignedFields.contains('address')) { address = guest.address; }
		if (guest.$assignedFields.contains('city')) { city = guest.city; }
		if (guest.$assignedFields.contains('country')) { country = guest.country; }
		if (guest.$assignedFields.contains('zipCode')) { zipCode = guest.zipCode; }
		if (guest.$assignedFields.contains('email')) { email = guest.email; }
		if (guest.$assignedFields.contains('agencyId')) { agencyId = guest.agencyId; }
		if (guest.$assignedFields.contains('createdAt')) { createdAt = guest.createdAt; }
		if (guest.$assignedFields.contains('updatedAt')) { updatedAt = guest.updatedAt; }
		if (guest.$assignedFields.contains('deletedAt')) { deletedAt = guest.deletedAt; }
		if (guest.$assignedFields.contains('Agency')) { Agency = guest.Agency; }
		if (guest.$assignedFields.contains('Property') && guest.Property != null) { Property = mergeModelLists(Property, guest.Property); }
		if (guest.$assignedFields.contains('Reservation') && guest.Reservation != null) { Reservation = mergeModelLists(Reservation, guest.Reservation); }
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
          ? {...?serializedTypes, 'Guest'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(name != null) 'name': name,
	if(phone != null) 'phone': phone,
	if(image != null) 'image': image,
	if(nationality != null) 'nationality': nationality,
	if(passportNumber != null) 'passportNumber': passportNumber,
	if(gender != null) 'gender': gender?.toJson(),
	if(birthDate != null) 'birthDate': birthDate?.toIso8601String(),
	if(address != null) 'address': address,
	if(city != null) 'city': city,
	if(country != null) 'country': country,
	if(zipCode != null) 'zipCode': zipCode,
	if(email != null) 'email': email,
	if(agencyId != null) 'agencyId': agencyId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($PropertyCount != null || $ReservationCount != null) '_count': { 
		if ($PropertyCount != null) 'Property': $PropertyCount, 
		if ($ReservationCount != null) 'Reservation': $ReservationCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Guest &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    