
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'user.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';


class Appointment implements PrismaModel<String, Appointment> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? contactId;
	String? title;
	String? description;
	String? appointmentType;
	DateTime? startDate;
	DateTime? endDate;
	String? timezone;
	String? status;
	String? location;
	String? assignedToUserId;
	String? assignedToContactId;
	dynamic reminders;
	String? notes;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? assignedContact;
	User? assignedUser;
	Contact? contact;
	Listing? listing;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Appointment({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.contactId,
	 this.title,
	 this.description,
	 this.appointmentType,
	 this.startDate,
	 this.endDate,
	 this.timezone = "Europe/London",
	 this.status = "SCHEDULED",
	 this.location,
	 this.assignedToUserId,
	 this.assignedToContactId,
	required this.reminders,
	 this.notes,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.assignedContact,
	 this.assignedUser,
	 this.contact,
	 this.listing,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Appointment, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"contactId": (m) => m.contactId,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"appointmentType": (m) => m.appointmentType,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"timezone": (m) => m.timezone,

	"status": (m) => m.status,

	"location": (m) => m.location,

	"assignedToUserId": (m) => m.assignedToUserId,

	"assignedToContactId": (m) => m.assignedToContactId,

	"reminders": (m) => m.reminders,

	"notes": (m) => m.notes,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"assignedContact": (m) => m.assignedContact,

	"assignedUser": (m) => m.assignedUser,

	"contact": (m) => m.contact,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Appointment) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Appointment');
    }
    return propFunction as V? Function(Appointment);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Appointment.fromJson(JsonMap json) =>
      Appointment(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	contactId: json['contactId'] as String?,
	title: json['title'] as String?,
	description: json['description'] as String?,
	appointmentType: json['appointmentType'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	timezone: json['timezone'] as String?,
	status: json['status'] as String?,
	location: json['location'] as String?,
	assignedToUserId: json['assignedToUserId'] as String?,
	assignedToContactId: json['assignedToContactId'] as String?,
	reminders: json['reminders'] as dynamic,
	notes: json['notes'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	assignedContact: json['assignedContact'] != null ? Contact.fromJson(json['assignedContact'] as JsonMap) : null,
	assignedUser: json['assignedUser'] != null ? User.fromJson(json['assignedUser'] as JsonMap) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Appointment copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? contactId,
		Value<String?>? title,
		Value<String?>? description,
		Value<String?>? appointmentType,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<String?>? timezone,
		Value<String?>? status,
		Value<String?>? location,
		Value<String?>? assignedToUserId,
		Value<String?>? assignedToContactId,
		Value<dynamic>? reminders,
		Value<String?>? notes,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? assignedContact,
		Value<User?>? assignedUser,
		Value<Contact?>? contact,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return Appointment(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		contactId: contactId != null ? contactId.value : this.contactId,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		appointmentType: appointmentType != null ? appointmentType.value : this.appointmentType,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		timezone: timezone != null ? timezone.value : this.timezone,
		status: status != null ? status.value : this.status,
		location: location != null ? location.value : this.location,
		assignedToUserId: assignedToUserId != null ? assignedToUserId.value : this.assignedToUserId,
		assignedToContactId: assignedToContactId != null ? assignedToContactId.value : this.assignedToContactId,
		reminders: reminders != null ? reminders.value : this.reminders,
		notes: notes != null ? notes.value : this.notes,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		assignedContact: assignedContact != null ? assignedContact.value : this.assignedContact,
		assignedUser: assignedUser != null ? assignedUser.value : this.assignedUser,
		contact: contact != null ? contact.value : this.contact,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Appointment copyWithInstanceValues(Appointment appointment) {
        return Appointment(
            id: appointment.id ?? id,
		orgId: appointment.orgId ?? orgId,
		propertyId: appointment.propertyId ?? propertyId,
		listingId: appointment.listingId ?? listingId,
		contactId: appointment.contactId ?? contactId,
		title: appointment.title ?? title,
		description: appointment.description ?? description,
		appointmentType: appointment.appointmentType ?? appointmentType,
		startDate: appointment.startDate ?? startDate,
		endDate: appointment.endDate ?? endDate,
		timezone: appointment.timezone ?? timezone,
		status: appointment.status ?? status,
		location: appointment.location ?? location,
		assignedToUserId: appointment.assignedToUserId ?? assignedToUserId,
		assignedToContactId: appointment.assignedToContactId ?? assignedToContactId,
		reminders: appointment.reminders ?? reminders,
		notes: appointment.notes ?? notes,
		createdBy: appointment.createdBy ?? createdBy,
		createdAt: appointment.createdAt ?? createdAt,
		updatedAt: appointment.updatedAt ?? updatedAt,
		deletedAt: appointment.deletedAt ?? deletedAt,
		assignedContact: appointment.assignedContact ?? assignedContact,
		assignedUser: appointment.assignedUser ?? assignedUser,
		contact: appointment.contact ?? contact,
		listing: appointment.listing ?? listing,
		org: appointment.org ?? org,
		property: appointment.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Appointment mergeWithInstanceValues(Appointment appointment) {
        return Appointment(
            id: appointment.$assignedFields.contains('id') ? appointment.id : id,
		orgId: appointment.$assignedFields.contains('orgId') ? appointment.orgId : orgId,
		propertyId: appointment.$assignedFields.contains('propertyId') ? appointment.propertyId : propertyId,
		listingId: appointment.$assignedFields.contains('listingId') ? appointment.listingId : listingId,
		contactId: appointment.$assignedFields.contains('contactId') ? appointment.contactId : contactId,
		title: appointment.$assignedFields.contains('title') ? appointment.title : title,
		description: appointment.$assignedFields.contains('description') ? appointment.description : description,
		appointmentType: appointment.$assignedFields.contains('appointmentType') ? appointment.appointmentType : appointmentType,
		startDate: appointment.$assignedFields.contains('startDate') ? appointment.startDate : startDate,
		endDate: appointment.$assignedFields.contains('endDate') ? appointment.endDate : endDate,
		timezone: appointment.$assignedFields.contains('timezone') ? appointment.timezone : timezone,
		status: appointment.$assignedFields.contains('status') ? appointment.status : status,
		location: appointment.$assignedFields.contains('location') ? appointment.location : location,
		assignedToUserId: appointment.$assignedFields.contains('assignedToUserId') ? appointment.assignedToUserId : assignedToUserId,
		assignedToContactId: appointment.$assignedFields.contains('assignedToContactId') ? appointment.assignedToContactId : assignedToContactId,
		reminders: appointment.$assignedFields.contains('reminders') ? appointment.reminders : reminders,
		notes: appointment.$assignedFields.contains('notes') ? appointment.notes : notes,
		createdBy: appointment.$assignedFields.contains('createdBy') ? appointment.createdBy : createdBy,
		createdAt: appointment.$assignedFields.contains('createdAt') ? appointment.createdAt : createdAt,
		updatedAt: appointment.$assignedFields.contains('updatedAt') ? appointment.updatedAt : updatedAt,
		deletedAt: appointment.$assignedFields.contains('deletedAt') ? appointment.deletedAt : deletedAt,
		assignedContact: appointment.$assignedFields.contains('assignedContact') ? appointment.assignedContact : assignedContact,
		assignedUser: appointment.$assignedFields.contains('assignedUser') ? appointment.assignedUser : assignedUser,
		contact: appointment.$assignedFields.contains('contact') ? appointment.contact : contact,
		listing: appointment.$assignedFields.contains('listing') ? appointment.listing : listing,
		org: appointment.$assignedFields.contains('org') ? appointment.org : org,
		property: appointment.$assignedFields.contains('property') ? appointment.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Appointment updateWithInstanceValues(Appointment appointment) {
        if (appointment.$assignedFields.contains('id')) { id = appointment.id; }
		if (appointment.$assignedFields.contains('orgId')) { orgId = appointment.orgId; }
		if (appointment.$assignedFields.contains('propertyId')) { propertyId = appointment.propertyId; }
		if (appointment.$assignedFields.contains('listingId')) { listingId = appointment.listingId; }
		if (appointment.$assignedFields.contains('contactId')) { contactId = appointment.contactId; }
		if (appointment.$assignedFields.contains('title')) { title = appointment.title; }
		if (appointment.$assignedFields.contains('description')) { description = appointment.description; }
		if (appointment.$assignedFields.contains('appointmentType')) { appointmentType = appointment.appointmentType; }
		if (appointment.$assignedFields.contains('startDate')) { startDate = appointment.startDate; }
		if (appointment.$assignedFields.contains('endDate')) { endDate = appointment.endDate; }
		if (appointment.$assignedFields.contains('timezone')) { timezone = appointment.timezone; }
		if (appointment.$assignedFields.contains('status')) { status = appointment.status; }
		if (appointment.$assignedFields.contains('location')) { location = appointment.location; }
		if (appointment.$assignedFields.contains('assignedToUserId')) { assignedToUserId = appointment.assignedToUserId; }
		if (appointment.$assignedFields.contains('assignedToContactId')) { assignedToContactId = appointment.assignedToContactId; }
		if (appointment.$assignedFields.contains('reminders')) { reminders = appointment.reminders; }
		if (appointment.$assignedFields.contains('notes')) { notes = appointment.notes; }
		if (appointment.$assignedFields.contains('createdBy')) { createdBy = appointment.createdBy; }
		if (appointment.$assignedFields.contains('createdAt')) { createdAt = appointment.createdAt; }
		if (appointment.$assignedFields.contains('updatedAt')) { updatedAt = appointment.updatedAt; }
		if (appointment.$assignedFields.contains('deletedAt')) { deletedAt = appointment.deletedAt; }
		if (appointment.$assignedFields.contains('assignedContact')) { assignedContact = appointment.assignedContact; }
		if (appointment.$assignedFields.contains('assignedUser')) { assignedUser = appointment.assignedUser; }
		if (appointment.$assignedFields.contains('contact')) { contact = appointment.contact; }
		if (appointment.$assignedFields.contains('listing')) { listing = appointment.listing; }
		if (appointment.$assignedFields.contains('org')) { org = appointment.org; }
		if (appointment.$assignedFields.contains('property')) { property = appointment.property; }
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
          ? {...?serializedTypes, 'Appointment'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(contactId != null) 'contactId': contactId,
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(appointmentType != null) 'appointmentType': appointmentType,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(timezone != null) 'timezone': timezone,
	if(status != null) 'status': status,
	if(location != null) 'location': location,
	if(assignedToUserId != null) 'assignedToUserId': assignedToUserId,
	if(assignedToContactId != null) 'assignedToContactId': assignedToContactId,
	if(reminders != null) 'reminders': reminders,
	if(notes != null) 'notes': notes,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(assignedContact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'assignedContact': assignedContact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(assignedUser != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'assignedUser': assignedUser?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Appointment &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    