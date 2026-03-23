
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class CalendarEventStore extends ModelStreamStore<String, CalendarEvent> {

  static CalendarEventStore? _instance;

  static CalendarEventStore get instance {
    _instance ??= CalendarEventStore();
    return _instance!;
  }

  CalendarEventStore() : super(CalendarEvent.fromJson) {
    if (_instance != null) {
        throw Exception(
            'CalendarEventStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending CalendarEventStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use CalendarEventStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getCalendarEventId(CalendarEvent calendarEvent) => calendarEvent.id;

	String? getCalendarEventOrgId(CalendarEvent calendarEvent) => calendarEvent.orgId;

	String? getCalendarEventUserId(CalendarEvent calendarEvent) => calendarEvent.userId;

	String? getCalendarEventExternalId(CalendarEvent calendarEvent) => calendarEvent.externalId;

	String? getCalendarEventExternalSource(CalendarEvent calendarEvent) => calendarEvent.externalSource;

	String? getCalendarEventTitle(CalendarEvent calendarEvent) => calendarEvent.title;

	String? getCalendarEventDescription(CalendarEvent calendarEvent) => calendarEvent.description;

	DateTime? getCalendarEventStartDate(CalendarEvent calendarEvent) => calendarEvent.startDate;

	DateTime? getCalendarEventEndDate(CalendarEvent calendarEvent) => calendarEvent.endDate;

	String? getCalendarEventTimezone(CalendarEvent calendarEvent) => calendarEvent.timezone;

	String? getCalendarEventLocation(CalendarEvent calendarEvent) => calendarEvent.location;

	dynamic? getCalendarEventAttendees(CalendarEvent calendarEvent) => calendarEvent.attendees;

	bool? getCalendarEventIsAllDay(CalendarEvent calendarEvent) => calendarEvent.isAllDay;

	dynamic? getCalendarEventRecurrence(CalendarEvent calendarEvent) => calendarEvent.recurrence;

	dynamic? getCalendarEventReminders(CalendarEvent calendarEvent) => calendarEvent.reminders;

	DateTime? getCalendarEventLastSyncedAt(CalendarEvent calendarEvent) => calendarEvent.lastSyncedAt;

	String? getCalendarEventSyncStatus(CalendarEvent calendarEvent) => calendarEvent.syncStatus;

	DateTime? getCalendarEventCreatedAt(CalendarEvent calendarEvent) => calendarEvent.createdAt;

	DateTime? getCalendarEventUpdatedAt(CalendarEvent calendarEvent) => calendarEvent.updatedAt;

	DateTime? getCalendarEventDeletedAt(CalendarEvent calendarEvent) => calendarEvent.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<CalendarEvent> getByOrgId(
    String orgId,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByUserId(
    String userId,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByExternalId(
    String externalId,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventExternalId, externalId, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByExternalSource(
    String externalSource,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventExternalSource, externalSource, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByTitle(
    String title,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventTitle, title, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByDescription(
    String description,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventDescription, description, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByStartDate(
    DateTime startDate,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByEndDate(
    DateTime endDate,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByTimezone(
    String timezone,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventTimezone, timezone, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByLocation(
    String location,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventLocation, location, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByAttendees(
    dynamic attendees,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventAttendees, attendees, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByIsAllDay(
    bool isAllDay,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventIsAllDay, isAllDay, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByRecurrence(
    dynamic recurrence,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventRecurrence, recurrence, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByReminders(
    dynamic reminders,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventReminders, reminders, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByLastSyncedAt(
    DateTime lastSyncedAt,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventLastSyncedAt, lastSyncedAt, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getBySyncStatus(
    String syncStatus,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventSyncStatus, syncStatus, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<CalendarEvent> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}
    ) =>
    getManyIncluding(getCalendarEventDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    CalendarEvent calendarEvent, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (calendarEvent.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(calendarEvent.orgId!, includes: includes);
        calendarEvent.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    CalendarEvent calendarEvent, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (calendarEvent.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(calendarEvent.userId!, includes: includes);
        calendarEvent.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<CalendarEvent>> getAll$({bool useCache = true, ModelFilter<CalendarEvent>? modelFilter, List<CalendarEventInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: CalendarEventEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<CalendarEvent?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getCalendarEventId,
        value: id,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<CalendarEvent>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByExternalId$(
        String externalId,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventExternalId,
        value: externalId,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByExternalId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByExternalSource$(
        String externalSource,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventExternalSource,
        value: externalSource,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByExternalSource,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCalendarEventStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCalendarEventEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByTimezone$(
        String timezone,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventTimezone,
        value: timezone,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByTimezone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByLocation$(
        String location,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventLocation,
        value: location,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByLocation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByAttendees$(
        dynamic attendees,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCalendarEventAttendees,
        value: attendees,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByAttendees,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByIsAllDay$(
        bool isAllDay,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getCalendarEventIsAllDay,
        value: isAllDay,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByIsAllDay,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByRecurrence$(
        dynamic recurrence,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCalendarEventRecurrence,
        value: recurrence,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByRecurrence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByReminders$(
        dynamic reminders,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCalendarEventReminders,
        value: reminders,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByReminders,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByLastSyncedAt$(
        DateTime lastSyncedAt,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCalendarEventLastSyncedAt,
        value: lastSyncedAt,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByLastSyncedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getBySyncStatus$(
        String syncStatus,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCalendarEventSyncStatus,
        value: syncStatus,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyBySyncStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCalendarEventCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCalendarEventUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CalendarEvent>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<CalendarEvent>? modelFilter,
        List<CalendarEventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCalendarEventDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: CalendarEventEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    CalendarEvent calendarEvent, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (calendarEvent.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            calendarEvent.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            calendarEvent.org = org;
        });
    }
}

	Stream<User?> getUser$(
    CalendarEvent calendarEvent, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (calendarEvent.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            calendarEvent.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            calendarEvent.user = user;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
CalendarEvent recursiveUpsert(CalendarEvent calendarEvent, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'CalendarEvent'} 
        : const {};
    if (calendarEvent.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        calendarEvent.org = OrganizationStore.instance.recursiveUpsert(calendarEvent.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (calendarEvent.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        calendarEvent.user = UserStore.instance.recursiveUpsert(calendarEvent.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(calendarEvent);
}

  List<CalendarEvent> recursiveListUpsert(List<CalendarEvent> calendarEvents, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedCalendarEvents = <CalendarEvent>[];
    for (var calendarEvent in calendarEvents) {
        updatedCalendarEvents.add(recursiveUpsert(calendarEvent, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedCalendarEvents;
}

//   @override
//   CalendarEvent upsert(CalendarEvent item) {
//     return recursiveUpsert(item);
//   }

}


class CalendarEventInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      CalendarEventInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (calendarEvent) => CalendarEventStore.instance
            .getOrg$(calendarEvent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (calendarEvent) => CalendarEventStore.instance
            .getOrg(calendarEvent, modelFilter: modelFilter, includes: includes);
      }
}

	CalendarEventInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (calendarEvent) => CalendarEventStore.instance
            .getUser$(calendarEvent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (calendarEvent) => CalendarEventStore.instance
            .getUser(calendarEvent, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum CalendarEventEndpoints implements Endpoint {

    getAll('/calendarEvent', HttpMethod.post, List<CalendarEvent>),
	getById('/calendarEvent/byId/:id', HttpMethod.post, CalendarEvent),
	getManyByOrgId('/calendarEvent/byOrgId/:orgId', HttpMethod.post, List<CalendarEvent>),
	getManyByUserId('/calendarEvent/byUserId/:userId', HttpMethod.post, List<CalendarEvent>),
	getManyByExternalId('/calendarEvent/byExternalId/:externalId', HttpMethod.post, List<CalendarEvent>),
	getManyByExternalSource('/calendarEvent/byExternalSource/:externalSource', HttpMethod.post, List<CalendarEvent>),
	getManyByTitle('/calendarEvent/byTitle/:title', HttpMethod.post, List<CalendarEvent>),
	getManyByDescription('/calendarEvent/byDescription/:description', HttpMethod.post, List<CalendarEvent>),
	getManyByStartDate('/calendarEvent/byStartDate/:startDate', HttpMethod.post, List<CalendarEvent>),
	getManyByEndDate('/calendarEvent/byEndDate/:endDate', HttpMethod.post, List<CalendarEvent>),
	getManyByTimezone('/calendarEvent/byTimezone/:timezone', HttpMethod.post, List<CalendarEvent>),
	getManyByLocation('/calendarEvent/byLocation/:location', HttpMethod.post, List<CalendarEvent>),
	getManyByAttendees('/calendarEvent/byAttendees/:attendees', HttpMethod.post, List<CalendarEvent>),
	getManyByIsAllDay('/calendarEvent/byIsAllDay/:isAllDay', HttpMethod.post, List<CalendarEvent>),
	getManyByRecurrence('/calendarEvent/byRecurrence/:recurrence', HttpMethod.post, List<CalendarEvent>),
	getManyByReminders('/calendarEvent/byReminders/:reminders', HttpMethod.post, List<CalendarEvent>),
	getManyByLastSyncedAt('/calendarEvent/byLastSyncedAt/:lastSyncedAt', HttpMethod.post, List<CalendarEvent>),
	getManyBySyncStatus('/calendarEvent/bySyncStatus/:syncStatus', HttpMethod.post, List<CalendarEvent>),
	getManyByCreatedAt('/calendarEvent/byCreatedAt/:createdAt', HttpMethod.post, List<CalendarEvent>),
	getManyByUpdatedAt('/calendarEvent/byUpdatedAt/:updatedAt', HttpMethod.post, List<CalendarEvent>),
	getManyByDeletedAt('/calendarEvent/byDeletedAt/:deletedAt', HttpMethod.post, List<CalendarEvent>);

    const CalendarEventEndpoints(this.path, this.method, this.responseType);

    @override
  final String path;

  @override
  final HttpMethod method;

  final Type responseType;

  static String withPathParameter(String path, dynamic param) {
    final regex = RegExp(r':([a-zA-Z]+)');
    return path.replaceFirst(regex, param.toString());
  }
}
