
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'event.dart';
import 'organization.dart';
import 'user.dart';


class EventAttendee implements PrismaModel<String, EventAttendee> , Id<String> {
    @override
String? id;
	String? orgId;
	String? eventId;
	String? contactId;
	String? userId;
	String? rsvpStatus;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contact;
	Event? event;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    EventAttendee({ this.id,
	 this.orgId,
	 this.eventId,
	 this.contactId,
	 this.userId,
	 this.rsvpStatus = "PENDING",
	 this.notes,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contact,
	 this.event,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<EventAttendee, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"eventId": (m) => m.eventId,

	"contactId": (m) => m.contactId,

	"userId": (m) => m.userId,

	"rsvpStatus": (m) => m.rsvpStatus,

	"notes": (m) => m.notes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contact": (m) => m.contact,

	"event": (m) => m.event,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(EventAttendee) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in EventAttendee');
    }
    return propFunction as V? Function(EventAttendee);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory EventAttendee.fromJson(JsonMap json) =>
      EventAttendee(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	eventId: json['eventId'] as String?,
	contactId: json['contactId'] as String?,
	userId: json['userId'] as String?,
	rsvpStatus: json['rsvpStatus'] as String?,
	notes: json['notes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	event: json['event'] != null ? Event.fromJson(json['event'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    EventAttendee copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? eventId,
		Value<String?>? contactId,
		Value<String?>? userId,
		Value<String?>? rsvpStatus,
		Value<String?>? notes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contact,
		Value<Event?>? event,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return EventAttendee(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		eventId: eventId != null ? eventId.value : this.eventId,
		contactId: contactId != null ? contactId.value : this.contactId,
		userId: userId != null ? userId.value : this.userId,
		rsvpStatus: rsvpStatus != null ? rsvpStatus.value : this.rsvpStatus,
		notes: notes != null ? notes.value : this.notes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contact: contact != null ? contact.value : this.contact,
		event: event != null ? event.value : this.event,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    EventAttendee copyWithInstanceValues(EventAttendee eventAttendee) {
        return EventAttendee(
            id: eventAttendee.id ?? id,
		orgId: eventAttendee.orgId ?? orgId,
		eventId: eventAttendee.eventId ?? eventId,
		contactId: eventAttendee.contactId ?? contactId,
		userId: eventAttendee.userId ?? userId,
		rsvpStatus: eventAttendee.rsvpStatus ?? rsvpStatus,
		notes: eventAttendee.notes ?? notes,
		createdAt: eventAttendee.createdAt ?? createdAt,
		updatedAt: eventAttendee.updatedAt ?? updatedAt,
		deletedAt: eventAttendee.deletedAt ?? deletedAt,
		contact: eventAttendee.contact ?? contact,
		event: eventAttendee.event ?? event,
		org: eventAttendee.org ?? org,
		user: eventAttendee.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    EventAttendee mergeWithInstanceValues(EventAttendee eventAttendee) {
        return EventAttendee(
            id: eventAttendee.$assignedFields.contains('id') ? eventAttendee.id : id,
		orgId: eventAttendee.$assignedFields.contains('orgId') ? eventAttendee.orgId : orgId,
		eventId: eventAttendee.$assignedFields.contains('eventId') ? eventAttendee.eventId : eventId,
		contactId: eventAttendee.$assignedFields.contains('contactId') ? eventAttendee.contactId : contactId,
		userId: eventAttendee.$assignedFields.contains('userId') ? eventAttendee.userId : userId,
		rsvpStatus: eventAttendee.$assignedFields.contains('rsvpStatus') ? eventAttendee.rsvpStatus : rsvpStatus,
		notes: eventAttendee.$assignedFields.contains('notes') ? eventAttendee.notes : notes,
		createdAt: eventAttendee.$assignedFields.contains('createdAt') ? eventAttendee.createdAt : createdAt,
		updatedAt: eventAttendee.$assignedFields.contains('updatedAt') ? eventAttendee.updatedAt : updatedAt,
		deletedAt: eventAttendee.$assignedFields.contains('deletedAt') ? eventAttendee.deletedAt : deletedAt,
		contact: eventAttendee.$assignedFields.contains('contact') ? eventAttendee.contact : contact,
		event: eventAttendee.$assignedFields.contains('event') ? eventAttendee.event : event,
		org: eventAttendee.$assignedFields.contains('org') ? eventAttendee.org : org,
		user: eventAttendee.$assignedFields.contains('user') ? eventAttendee.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    EventAttendee updateWithInstanceValues(EventAttendee eventAttendee) {
        if (eventAttendee.$assignedFields.contains('id')) { id = eventAttendee.id; }
		if (eventAttendee.$assignedFields.contains('orgId')) { orgId = eventAttendee.orgId; }
		if (eventAttendee.$assignedFields.contains('eventId')) { eventId = eventAttendee.eventId; }
		if (eventAttendee.$assignedFields.contains('contactId')) { contactId = eventAttendee.contactId; }
		if (eventAttendee.$assignedFields.contains('userId')) { userId = eventAttendee.userId; }
		if (eventAttendee.$assignedFields.contains('rsvpStatus')) { rsvpStatus = eventAttendee.rsvpStatus; }
		if (eventAttendee.$assignedFields.contains('notes')) { notes = eventAttendee.notes; }
		if (eventAttendee.$assignedFields.contains('createdAt')) { createdAt = eventAttendee.createdAt; }
		if (eventAttendee.$assignedFields.contains('updatedAt')) { updatedAt = eventAttendee.updatedAt; }
		if (eventAttendee.$assignedFields.contains('deletedAt')) { deletedAt = eventAttendee.deletedAt; }
		if (eventAttendee.$assignedFields.contains('contact')) { contact = eventAttendee.contact; }
		if (eventAttendee.$assignedFields.contains('event')) { event = eventAttendee.event; }
		if (eventAttendee.$assignedFields.contains('org')) { org = eventAttendee.org; }
		if (eventAttendee.$assignedFields.contains('user')) { user = eventAttendee.user; }
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
          ? {...?serializedTypes, 'EventAttendee'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(eventId != null) 'eventId': eventId,
	if(contactId != null) 'contactId': contactId,
	if(userId != null) 'userId': userId,
	if(rsvpStatus != null) 'rsvpStatus': rsvpStatus,
	if(notes != null) 'notes': notes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(event != null && (!preventCircularSerialization || !serializedModels.contains('Event'))) 'event': event?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is EventAttendee &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    