
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';


class CalendarEvent implements PrismaModel<String, CalendarEvent> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? externalId;
	String? externalSource;
	String? title;
	String? description;
	DateTime? startDate;
	DateTime? endDate;
	String? timezone;
	String? location;
	dynamic attendees;
	bool? isAllDay;
	dynamic recurrence;
	dynamic reminders;
	DateTime? lastSyncedAt;
	String? syncStatus;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    CalendarEvent({ this.id,
	 this.orgId,
	 this.userId,
	 this.externalId,
	 this.externalSource,
	 this.title,
	 this.description,
	 this.startDate,
	 this.endDate,
	 this.timezone = "Europe/London",
	 this.location,
	required this.attendees,
	 this.isAllDay = false,
	required this.recurrence,
	required this.reminders,
	 this.lastSyncedAt,
	 this.syncStatus = "SYNCED",
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<CalendarEvent, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"externalId": (m) => m.externalId,

	"externalSource": (m) => m.externalSource,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"timezone": (m) => m.timezone,

	"location": (m) => m.location,

	"attendees": (m) => m.attendees,

	"isAllDay": (m) => m.isAllDay,

	"recurrence": (m) => m.recurrence,

	"reminders": (m) => m.reminders,

	"lastSyncedAt": (m) => m.lastSyncedAt,

	"syncStatus": (m) => m.syncStatus,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(CalendarEvent) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in CalendarEvent');
    }
    return propFunction as V? Function(CalendarEvent);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory CalendarEvent.fromJson(JsonMap json) =>
      CalendarEvent(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	externalId: json['externalId'] as String?,
	externalSource: json['externalSource'] as String?,
	title: json['title'] as String?,
	description: json['description'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	timezone: json['timezone'] as String?,
	location: json['location'] as String?,
	attendees: json['attendees'] as dynamic,
	isAllDay: json['isAllDay'] as bool?,
	recurrence: json['recurrence'] as dynamic,
	reminders: json['reminders'] as dynamic,
	lastSyncedAt: json['lastSyncedAt'] != null ? DateTime.parse(json['lastSyncedAt']) : null,
	syncStatus: json['syncStatus'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    CalendarEvent copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? externalId,
		Value<String?>? externalSource,
		Value<String?>? title,
		Value<String?>? description,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<String?>? timezone,
		Value<String?>? location,
		Value<dynamic>? attendees,
		Value<bool?>? isAllDay,
		Value<dynamic>? recurrence,
		Value<dynamic>? reminders,
		Value<DateTime?>? lastSyncedAt,
		Value<String?>? syncStatus,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return CalendarEvent(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		externalId: externalId != null ? externalId.value : this.externalId,
		externalSource: externalSource != null ? externalSource.value : this.externalSource,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		timezone: timezone != null ? timezone.value : this.timezone,
		location: location != null ? location.value : this.location,
		attendees: attendees != null ? attendees.value : this.attendees,
		isAllDay: isAllDay != null ? isAllDay.value : this.isAllDay,
		recurrence: recurrence != null ? recurrence.value : this.recurrence,
		reminders: reminders != null ? reminders.value : this.reminders,
		lastSyncedAt: lastSyncedAt != null ? lastSyncedAt.value : this.lastSyncedAt,
		syncStatus: syncStatus != null ? syncStatus.value : this.syncStatus,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    CalendarEvent copyWithInstanceValues(CalendarEvent calendarEvent) {
        return CalendarEvent(
            id: calendarEvent.id ?? id,
		orgId: calendarEvent.orgId ?? orgId,
		userId: calendarEvent.userId ?? userId,
		externalId: calendarEvent.externalId ?? externalId,
		externalSource: calendarEvent.externalSource ?? externalSource,
		title: calendarEvent.title ?? title,
		description: calendarEvent.description ?? description,
		startDate: calendarEvent.startDate ?? startDate,
		endDate: calendarEvent.endDate ?? endDate,
		timezone: calendarEvent.timezone ?? timezone,
		location: calendarEvent.location ?? location,
		attendees: calendarEvent.attendees ?? attendees,
		isAllDay: calendarEvent.isAllDay ?? isAllDay,
		recurrence: calendarEvent.recurrence ?? recurrence,
		reminders: calendarEvent.reminders ?? reminders,
		lastSyncedAt: calendarEvent.lastSyncedAt ?? lastSyncedAt,
		syncStatus: calendarEvent.syncStatus ?? syncStatus,
		createdAt: calendarEvent.createdAt ?? createdAt,
		updatedAt: calendarEvent.updatedAt ?? updatedAt,
		deletedAt: calendarEvent.deletedAt ?? deletedAt,
		org: calendarEvent.org ?? org,
		user: calendarEvent.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    CalendarEvent mergeWithInstanceValues(CalendarEvent calendarEvent) {
        return CalendarEvent(
            id: calendarEvent.$assignedFields.contains('id') ? calendarEvent.id : id,
		orgId: calendarEvent.$assignedFields.contains('orgId') ? calendarEvent.orgId : orgId,
		userId: calendarEvent.$assignedFields.contains('userId') ? calendarEvent.userId : userId,
		externalId: calendarEvent.$assignedFields.contains('externalId') ? calendarEvent.externalId : externalId,
		externalSource: calendarEvent.$assignedFields.contains('externalSource') ? calendarEvent.externalSource : externalSource,
		title: calendarEvent.$assignedFields.contains('title') ? calendarEvent.title : title,
		description: calendarEvent.$assignedFields.contains('description') ? calendarEvent.description : description,
		startDate: calendarEvent.$assignedFields.contains('startDate') ? calendarEvent.startDate : startDate,
		endDate: calendarEvent.$assignedFields.contains('endDate') ? calendarEvent.endDate : endDate,
		timezone: calendarEvent.$assignedFields.contains('timezone') ? calendarEvent.timezone : timezone,
		location: calendarEvent.$assignedFields.contains('location') ? calendarEvent.location : location,
		attendees: calendarEvent.$assignedFields.contains('attendees') ? calendarEvent.attendees : attendees,
		isAllDay: calendarEvent.$assignedFields.contains('isAllDay') ? calendarEvent.isAllDay : isAllDay,
		recurrence: calendarEvent.$assignedFields.contains('recurrence') ? calendarEvent.recurrence : recurrence,
		reminders: calendarEvent.$assignedFields.contains('reminders') ? calendarEvent.reminders : reminders,
		lastSyncedAt: calendarEvent.$assignedFields.contains('lastSyncedAt') ? calendarEvent.lastSyncedAt : lastSyncedAt,
		syncStatus: calendarEvent.$assignedFields.contains('syncStatus') ? calendarEvent.syncStatus : syncStatus,
		createdAt: calendarEvent.$assignedFields.contains('createdAt') ? calendarEvent.createdAt : createdAt,
		updatedAt: calendarEvent.$assignedFields.contains('updatedAt') ? calendarEvent.updatedAt : updatedAt,
		deletedAt: calendarEvent.$assignedFields.contains('deletedAt') ? calendarEvent.deletedAt : deletedAt,
		org: calendarEvent.$assignedFields.contains('org') ? calendarEvent.org : org,
		user: calendarEvent.$assignedFields.contains('user') ? calendarEvent.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    CalendarEvent updateWithInstanceValues(CalendarEvent calendarEvent) {
        if (calendarEvent.$assignedFields.contains('id')) { id = calendarEvent.id; }
		if (calendarEvent.$assignedFields.contains('orgId')) { orgId = calendarEvent.orgId; }
		if (calendarEvent.$assignedFields.contains('userId')) { userId = calendarEvent.userId; }
		if (calendarEvent.$assignedFields.contains('externalId')) { externalId = calendarEvent.externalId; }
		if (calendarEvent.$assignedFields.contains('externalSource')) { externalSource = calendarEvent.externalSource; }
		if (calendarEvent.$assignedFields.contains('title')) { title = calendarEvent.title; }
		if (calendarEvent.$assignedFields.contains('description')) { description = calendarEvent.description; }
		if (calendarEvent.$assignedFields.contains('startDate')) { startDate = calendarEvent.startDate; }
		if (calendarEvent.$assignedFields.contains('endDate')) { endDate = calendarEvent.endDate; }
		if (calendarEvent.$assignedFields.contains('timezone')) { timezone = calendarEvent.timezone; }
		if (calendarEvent.$assignedFields.contains('location')) { location = calendarEvent.location; }
		if (calendarEvent.$assignedFields.contains('attendees')) { attendees = calendarEvent.attendees; }
		if (calendarEvent.$assignedFields.contains('isAllDay')) { isAllDay = calendarEvent.isAllDay; }
		if (calendarEvent.$assignedFields.contains('recurrence')) { recurrence = calendarEvent.recurrence; }
		if (calendarEvent.$assignedFields.contains('reminders')) { reminders = calendarEvent.reminders; }
		if (calendarEvent.$assignedFields.contains('lastSyncedAt')) { lastSyncedAt = calendarEvent.lastSyncedAt; }
		if (calendarEvent.$assignedFields.contains('syncStatus')) { syncStatus = calendarEvent.syncStatus; }
		if (calendarEvent.$assignedFields.contains('createdAt')) { createdAt = calendarEvent.createdAt; }
		if (calendarEvent.$assignedFields.contains('updatedAt')) { updatedAt = calendarEvent.updatedAt; }
		if (calendarEvent.$assignedFields.contains('deletedAt')) { deletedAt = calendarEvent.deletedAt; }
		if (calendarEvent.$assignedFields.contains('org')) { org = calendarEvent.org; }
		if (calendarEvent.$assignedFields.contains('user')) { user = calendarEvent.user; }
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
          ? {...?serializedTypes, 'CalendarEvent'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(externalId != null) 'externalId': externalId,
	if(externalSource != null) 'externalSource': externalSource,
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(timezone != null) 'timezone': timezone,
	if(location != null) 'location': location,
	if(attendees != null) 'attendees': attendees,
	if(isAllDay != null) 'isAllDay': isAllDay,
	if(recurrence != null) 'recurrence': recurrence,
	if(reminders != null) 'reminders': reminders,
	if(lastSyncedAt != null) 'lastSyncedAt': lastSyncedAt?.toIso8601String(),
	if(syncStatus != null) 'syncStatus': syncStatus,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is CalendarEvent &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    