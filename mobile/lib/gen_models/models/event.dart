
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';
import 'event_attendee.dart';


class Event implements PrismaModel<String, Event> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? name;
	String? description;
	String? eventType;
	DateTime? startDate;
	DateTime? endDate;
	int? maxAttendees;
	bool? isPublic;
	String? status;
	bool? isActive;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Property? property;
	List<EventAttendee>? attendees;
	int? $attendeesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Event({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.name,
	 this.description,
	 this.eventType,
	 this.startDate,
	 this.endDate,
	 this.maxAttendees,
	 this.isPublic = true,
	 this.status = "SCHEDULED",
	 this.isActive = true,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.property,
	 this.attendees,
	this.$attendeesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Event, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"eventType": (m) => m.eventType,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"maxAttendees": (m) => m.maxAttendees,

	"isPublic": (m) => m.isPublic,

	"status": (m) => m.status,

	"isActive": (m) => m.isActive,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"attendees": (m) => m.attendees,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Event) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Event');
    }
    return propFunction as V? Function(Event);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Event.fromJson(JsonMap json) =>
      Event(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	eventType: json['eventType'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	maxAttendees: int.tryParse(json['maxAttendees'].toString()),
	isPublic: json['isPublic'] as bool?,
	status: json['status'] as String?,
	isActive: json['isActive'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	attendees: json['attendees'] != null ? createModels<EventAttendee>((json['attendees'] as List).cast<JsonMap>(), EventAttendee.fromJson) : null,
	$attendeesCount: json['_count']?['attendees'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Event copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? name,
		Value<String?>? description,
		Value<String?>? eventType,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<int?>? maxAttendees,
		Value<bool?>? isPublic,
		Value<String?>? status,
		Value<bool?>? isActive,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<List<EventAttendee>?>? attendees,
		int? $attendeesCount,
        }) {
        return Event(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		eventType: eventType != null ? eventType.value : this.eventType,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		maxAttendees: maxAttendees != null ? maxAttendees.value : this.maxAttendees,
		isPublic: isPublic != null ? isPublic.value : this.isPublic,
		status: status != null ? status.value : this.status,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		attendees: attendees != null ? attendees.value : this.attendees,
		$attendeesCount: $attendeesCount ?? this.$attendeesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Event copyWithInstanceValues(Event event) {
        return Event(
            id: event.id ?? id,
		orgId: event.orgId ?? orgId,
		propertyId: event.propertyId ?? propertyId,
		name: event.name ?? name,
		description: event.description ?? description,
		eventType: event.eventType ?? eventType,
		startDate: event.startDate ?? startDate,
		endDate: event.endDate ?? endDate,
		maxAttendees: event.maxAttendees ?? maxAttendees,
		isPublic: event.isPublic ?? isPublic,
		status: event.status ?? status,
		isActive: event.isActive ?? isActive,
		createdAt: event.createdAt ?? createdAt,
		updatedAt: event.updatedAt ?? updatedAt,
		deletedAt: event.deletedAt ?? deletedAt,
		org: event.org ?? org,
		property: event.property ?? property,
		attendees: event.attendees ?? attendees,
		$attendeesCount: event.$attendeesCount ?? $attendeesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Event mergeWithInstanceValues(Event event) {
        return Event(
            id: event.$assignedFields.contains('id') ? event.id : id,
		orgId: event.$assignedFields.contains('orgId') ? event.orgId : orgId,
		propertyId: event.$assignedFields.contains('propertyId') ? event.propertyId : propertyId,
		name: event.$assignedFields.contains('name') ? event.name : name,
		description: event.$assignedFields.contains('description') ? event.description : description,
		eventType: event.$assignedFields.contains('eventType') ? event.eventType : eventType,
		startDate: event.$assignedFields.contains('startDate') ? event.startDate : startDate,
		endDate: event.$assignedFields.contains('endDate') ? event.endDate : endDate,
		maxAttendees: event.$assignedFields.contains('maxAttendees') ? event.maxAttendees : maxAttendees,
		isPublic: event.$assignedFields.contains('isPublic') ? event.isPublic : isPublic,
		status: event.$assignedFields.contains('status') ? event.status : status,
		isActive: event.$assignedFields.contains('isActive') ? event.isActive : isActive,
		createdAt: event.$assignedFields.contains('createdAt') ? event.createdAt : createdAt,
		updatedAt: event.$assignedFields.contains('updatedAt') ? event.updatedAt : updatedAt,
		deletedAt: event.$assignedFields.contains('deletedAt') ? event.deletedAt : deletedAt,
		org: event.$assignedFields.contains('org') ? event.org : org,
		property: event.$assignedFields.contains('property') ? event.property : property,
		attendees: (event.$assignedFields.contains('attendees') && event.attendees != null) ? mergeModelLists(attendees, event.attendees) : attendees,
		$attendeesCount: event.$attendeesCount ?? $attendeesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Event updateWithInstanceValues(Event event) {
        if (event.$assignedFields.contains('id')) { id = event.id; }
		if (event.$assignedFields.contains('orgId')) { orgId = event.orgId; }
		if (event.$assignedFields.contains('propertyId')) { propertyId = event.propertyId; }
		if (event.$assignedFields.contains('name')) { name = event.name; }
		if (event.$assignedFields.contains('description')) { description = event.description; }
		if (event.$assignedFields.contains('eventType')) { eventType = event.eventType; }
		if (event.$assignedFields.contains('startDate')) { startDate = event.startDate; }
		if (event.$assignedFields.contains('endDate')) { endDate = event.endDate; }
		if (event.$assignedFields.contains('maxAttendees')) { maxAttendees = event.maxAttendees; }
		if (event.$assignedFields.contains('isPublic')) { isPublic = event.isPublic; }
		if (event.$assignedFields.contains('status')) { status = event.status; }
		if (event.$assignedFields.contains('isActive')) { isActive = event.isActive; }
		if (event.$assignedFields.contains('createdAt')) { createdAt = event.createdAt; }
		if (event.$assignedFields.contains('updatedAt')) { updatedAt = event.updatedAt; }
		if (event.$assignedFields.contains('deletedAt')) { deletedAt = event.deletedAt; }
		if (event.$assignedFields.contains('org')) { org = event.org; }
		if (event.$assignedFields.contains('property')) { property = event.property; }
		if (event.$assignedFields.contains('attendees') && event.attendees != null) { attendees = mergeModelLists(attendees, event.attendees); }
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
          ? {...?serializedTypes, 'Event'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(eventType != null) 'eventType': eventType,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(maxAttendees != null) 'maxAttendees': maxAttendees,
	if(isPublic != null) 'isPublic': isPublic,
	if(status != null) 'status': status,
	if(isActive != null) 'isActive': isActive,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(attendees != null && (!preventCircularSerialization || !serializedModels.contains('EventAttendee'))) 'attendees': attendees?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($attendeesCount != null) '_count': { 
		if ($attendeesCount != null) 'attendees': $attendeesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Event &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    