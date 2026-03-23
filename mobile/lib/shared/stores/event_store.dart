
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class EventStore extends ModelStreamStore<String, Event> {

  static EventStore? _instance;

  static EventStore get instance {
    _instance ??= EventStore();
    return _instance!;
  }

  EventStore() : super(Event.fromJson) {
    if (_instance != null) {
        throw Exception(
            'EventStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending EventStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use EventStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getEventId(Event event) => event.id;

	String? getEventOrgId(Event event) => event.orgId;

	String? getEventPropertyId(Event event) => event.propertyId;

	String? getEventName(Event event) => event.name;

	String? getEventDescription(Event event) => event.description;

	String? getEventEventType(Event event) => event.eventType;

	DateTime? getEventStartDate(Event event) => event.startDate;

	DateTime? getEventEndDate(Event event) => event.endDate;

	int? getEventMaxAttendees(Event event) => event.maxAttendees;

	bool? getEventIsPublic(Event event) => event.isPublic;

	String? getEventStatus(Event event) => event.status;

	bool? getEventIsActive(Event event) => event.isActive;

	DateTime? getEventCreatedAt(Event event) => event.createdAt;

	DateTime? getEventUpdatedAt(Event event) => event.updatedAt;

	DateTime? getEventDeletedAt(Event event) => event.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Event> getByOrgId(
    String orgId,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Event> getByPropertyId(
    String propertyId,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Event> getByName(
    String name,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventName, name, modelFilter: modelFilter, includes: includes);

	
List<Event> getByDescription(
    String description,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Event> getByEventType(
    String eventType,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventEventType, eventType, modelFilter: modelFilter, includes: includes);

	
List<Event> getByStartDate(
    DateTime startDate,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Event> getByEndDate(
    DateTime endDate,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<Event> getByMaxAttendees(
    int maxAttendees,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventMaxAttendees, maxAttendees, modelFilter: modelFilter, includes: includes);

	
List<Event> getByIsPublic(
    bool isPublic,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventIsPublic, isPublic, modelFilter: modelFilter, includes: includes);

	
List<Event> getByStatus(
    String status,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Event> getByIsActive(
    bool isActive,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Event> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Event> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Event> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Event>? modelFilter, List<EventInclude>? includes}
    ) =>
    getManyIncluding(getEventDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Event event, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (event.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(event.orgId!, includes: includes);
        event.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Event event, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (event.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(event.propertyId!, includes: includes);
        event.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<EventAttendee> getAttendees(
    Event event, {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    final attendees = EventAttendeeStore.instance.getByEventId(event.$uid!, modelFilter: modelFilter, includes: includes);
    event.attendees = attendees;
    // setIncludedReferencesForList(attendees, includes: includes);
    return attendees;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Event>> getAll$({bool useCache = true, ModelFilter<Event>? modelFilter, List<EventInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: EventEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Event?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getEventId,
        value: id,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Event>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventName,
        value: name,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByEventType$(
        String eventType,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventEventType,
        value: eventType,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByEventType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEventStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEventEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByMaxAttendees$(
        int maxAttendees,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getEventMaxAttendees,
        value: maxAttendees,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByMaxAttendees,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByIsPublic$(
        bool isPublic,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getEventIsPublic,
        value: isPublic,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByIsPublic,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getEventIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEventCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEventUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Event>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Event>? modelFilter,
        List<EventInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEventDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: EventEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Event event, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (event.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            event.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            event.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Event event, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (event.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            event.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            event.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<EventAttendee>> getAttendees$(
    Event event, {bool useCache = true, ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    return EventAttendeeStore.instance.getByEventId$(
        event.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attendees) {
        event.attendees = attendees;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Event recursiveUpsert(Event event, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Event'} 
        : const {};
    if (event.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        event.org = OrganizationStore.instance.recursiveUpsert(event.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (event.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        event.property = PropertyStore.instance.recursiveUpsert(event.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (event.attendees != null && (!preventCircularSerialization || !upsertedTypes.contains('EventAttendee'))) {
        event.attendees = EventAttendeeStore.instance.recursiveListUpsert(event.attendees!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(event);
}

  List<Event> recursiveListUpsert(List<Event> events, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedEvents = <Event>[];
    for (var event in events) {
        updatedEvents.add(recursiveUpsert(event, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedEvents;
}

//   @override
//   Event upsert(Event item) {
//     return recursiveUpsert(item);
//   }

}


class EventInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      EventInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (event) => EventStore.instance
            .getOrg$(event, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (event) => EventStore.instance
            .getOrg(event, modelFilter: modelFilter, includes: includes);
      }
}

	EventInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (event) => EventStore.instance
            .getProperty$(event, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (event) => EventStore.instance
            .getProperty(event, modelFilter: modelFilter, includes: includes);
      }
}

	EventInclude.attendees({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<EventAttendee>? modelFilter,
    List<EventAttendeeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (event) => EventStore.instance
            .getAttendees$(event, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (event) => EventStore.instance
            .getAttendees(event, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum EventEndpoints implements Endpoint {

    getAll('/event', HttpMethod.post, List<Event>),
	getById('/event/byId/:id', HttpMethod.post, Event),
	getManyByOrgId('/event/byOrgId/:orgId', HttpMethod.post, List<Event>),
	getManyByPropertyId('/event/byPropertyId/:propertyId', HttpMethod.post, List<Event>),
	getManyByName('/event/byName/:name', HttpMethod.post, List<Event>),
	getManyByDescription('/event/byDescription/:description', HttpMethod.post, List<Event>),
	getManyByEventType('/event/byEventType/:eventType', HttpMethod.post, List<Event>),
	getManyByStartDate('/event/byStartDate/:startDate', HttpMethod.post, List<Event>),
	getManyByEndDate('/event/byEndDate/:endDate', HttpMethod.post, List<Event>),
	getManyByMaxAttendees('/event/byMaxAttendees/:maxAttendees', HttpMethod.post, List<Event>),
	getManyByIsPublic('/event/byIsPublic/:isPublic', HttpMethod.post, List<Event>),
	getManyByStatus('/event/byStatus/:status', HttpMethod.post, List<Event>),
	getManyByIsActive('/event/byIsActive/:isActive', HttpMethod.post, List<Event>),
	getManyByCreatedAt('/event/byCreatedAt/:createdAt', HttpMethod.post, List<Event>),
	getManyByUpdatedAt('/event/byUpdatedAt/:updatedAt', HttpMethod.post, List<Event>),
	getManyByDeletedAt('/event/byDeletedAt/:deletedAt', HttpMethod.post, List<Event>);

    const EventEndpoints(this.path, this.method, this.responseType);

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
