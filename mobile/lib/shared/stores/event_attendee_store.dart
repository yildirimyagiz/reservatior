
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class EventAttendeeStore extends ModelStreamStore<String, EventAttendee> {

  static EventAttendeeStore? _instance;

  static EventAttendeeStore get instance {
    _instance ??= EventAttendeeStore();
    return _instance!;
  }

  EventAttendeeStore() : super(EventAttendee.fromJson) {
    if (_instance != null) {
        throw Exception(
            'EventAttendeeStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending EventAttendeeStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use EventAttendeeStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getEventAttendeeId(EventAttendee eventAttendee) => eventAttendee.id;

	String? getEventAttendeeOrgId(EventAttendee eventAttendee) => eventAttendee.orgId;

	String? getEventAttendeeEventId(EventAttendee eventAttendee) => eventAttendee.eventId;

	String? getEventAttendeeContactId(EventAttendee eventAttendee) => eventAttendee.contactId;

	String? getEventAttendeeUserId(EventAttendee eventAttendee) => eventAttendee.userId;

	String? getEventAttendeeRsvpStatus(EventAttendee eventAttendee) => eventAttendee.rsvpStatus;

	String? getEventAttendeeNotes(EventAttendee eventAttendee) => eventAttendee.notes;

	DateTime? getEventAttendeeCreatedAt(EventAttendee eventAttendee) => eventAttendee.createdAt;

	DateTime? getEventAttendeeUpdatedAt(EventAttendee eventAttendee) => eventAttendee.updatedAt;

	DateTime? getEventAttendeeDeletedAt(EventAttendee eventAttendee) => eventAttendee.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<EventAttendee> getByOrgId(
    String orgId,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<EventAttendee> getByEventId(
    String eventId,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeEventId, eventId, modelFilter: modelFilter, includes: includes);

	
List<EventAttendee> getByContactId(
    String contactId,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<EventAttendee> getByUserId(
    String userId,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<EventAttendee> getByRsvpStatus(
    String rsvpStatus,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeRsvpStatus, rsvpStatus, modelFilter: modelFilter, includes: includes);

	
List<EventAttendee> getByNotes(
    String notes,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<EventAttendee> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<EventAttendee> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<EventAttendee> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}
    ) =>
    getManyIncluding(getEventAttendeeDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    EventAttendee eventAttendee, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (eventAttendee.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(eventAttendee.contactId!, includes: includes);
        eventAttendee.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Event? getEvent(
    EventAttendee eventAttendee, {ModelFilter? modelFilter, List<EventInclude>? includes}) {
    if (eventAttendee.eventId == null) {
        return null;
    } else {
        final event = EventStore.instance.getById(eventAttendee.eventId!, includes: includes);
        eventAttendee.event = event;
        // setIncludedReferences(event, includes: includes);
        return event;
    }
}

	Organization? getOrg(
    EventAttendee eventAttendee, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (eventAttendee.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(eventAttendee.orgId!, includes: includes);
        eventAttendee.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    EventAttendee eventAttendee, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (eventAttendee.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(eventAttendee.userId!, includes: includes);
        eventAttendee.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<EventAttendee>> getAll$({bool useCache = true, ModelFilter<EventAttendee>? modelFilter, List<EventAttendeeInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: EventAttendeeEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<EventAttendee?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getEventAttendeeId,
        value: id,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<EventAttendee>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventAttendeeOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EventAttendee>> getByEventId$(
        String eventId,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventAttendeeEventId,
        value: eventId,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByEventId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EventAttendee>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventAttendeeContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EventAttendee>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventAttendeeUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EventAttendee>> getByRsvpStatus$(
        String rsvpStatus,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventAttendeeRsvpStatus,
        value: rsvpStatus,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByRsvpStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EventAttendee>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEventAttendeeNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EventAttendee>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEventAttendeeCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EventAttendee>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEventAttendeeUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<EventAttendee>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<EventAttendee>? modelFilter,
        List<EventAttendeeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEventAttendeeDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: EventAttendeeEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    EventAttendee eventAttendee, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (eventAttendee.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            eventAttendee.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            eventAttendee.contact = contact;
        });
    }
}

	Stream<Event?> getEvent$(
    EventAttendee eventAttendee, {bool useCache = true, ModelFilter<Event>? modelFilter, List<EventInclude>? includes}) {
    if (eventAttendee.eventId == null) {
        return Stream.value(null);
    } else {
        return EventStore.instance.getById$(
            eventAttendee.eventId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((event) {
            eventAttendee.event = event;
        });
    }
}

	Stream<Organization?> getOrg$(
    EventAttendee eventAttendee, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (eventAttendee.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            eventAttendee.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            eventAttendee.org = org;
        });
    }
}

	Stream<User?> getUser$(
    EventAttendee eventAttendee, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (eventAttendee.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            eventAttendee.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            eventAttendee.user = user;
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
EventAttendee recursiveUpsert(EventAttendee eventAttendee, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'EventAttendee'} 
        : const {};
    if (eventAttendee.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        eventAttendee.contact = ContactStore.instance.recursiveUpsert(eventAttendee.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (eventAttendee.event != null && (!preventCircularSerialization || !upsertedTypes.contains('Event'))) {
        eventAttendee.event = EventStore.instance.recursiveUpsert(eventAttendee.event!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (eventAttendee.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        eventAttendee.org = OrganizationStore.instance.recursiveUpsert(eventAttendee.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (eventAttendee.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        eventAttendee.user = UserStore.instance.recursiveUpsert(eventAttendee.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(eventAttendee);
}

  List<EventAttendee> recursiveListUpsert(List<EventAttendee> eventAttendees, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedEventAttendees = <EventAttendee>[];
    for (var eventAttendee in eventAttendees) {
        updatedEventAttendees.add(recursiveUpsert(eventAttendee, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedEventAttendees;
}

//   @override
//   EventAttendee upsert(EventAttendee item) {
//     return recursiveUpsert(item);
//   }

}


class EventAttendeeInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      EventAttendeeInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (eventAttendee) => EventAttendeeStore.instance
            .getContact$(eventAttendee, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (eventAttendee) => EventAttendeeStore.instance
            .getContact(eventAttendee, modelFilter: modelFilter, includes: includes);
      }
}

	EventAttendeeInclude.event({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Event>? modelFilter,
    List<EventInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (eventAttendee) => EventAttendeeStore.instance
            .getEvent$(eventAttendee, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (eventAttendee) => EventAttendeeStore.instance
            .getEvent(eventAttendee, modelFilter: modelFilter, includes: includes);
      }
}

	EventAttendeeInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (eventAttendee) => EventAttendeeStore.instance
            .getOrg$(eventAttendee, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (eventAttendee) => EventAttendeeStore.instance
            .getOrg(eventAttendee, modelFilter: modelFilter, includes: includes);
      }
}

	EventAttendeeInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (eventAttendee) => EventAttendeeStore.instance
            .getUser$(eventAttendee, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (eventAttendee) => EventAttendeeStore.instance
            .getUser(eventAttendee, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum EventAttendeeEndpoints implements Endpoint {

    getAll('/eventAttendee', HttpMethod.post, List<EventAttendee>),
	getById('/eventAttendee/byId/:id', HttpMethod.post, EventAttendee),
	getManyByOrgId('/eventAttendee/byOrgId/:orgId', HttpMethod.post, List<EventAttendee>),
	getManyByEventId('/eventAttendee/byEventId/:eventId', HttpMethod.post, List<EventAttendee>),
	getManyByContactId('/eventAttendee/byContactId/:contactId', HttpMethod.post, List<EventAttendee>),
	getManyByUserId('/eventAttendee/byUserId/:userId', HttpMethod.post, List<EventAttendee>),
	getManyByRsvpStatus('/eventAttendee/byRsvpStatus/:rsvpStatus', HttpMethod.post, List<EventAttendee>),
	getManyByNotes('/eventAttendee/byNotes/:notes', HttpMethod.post, List<EventAttendee>),
	getManyByCreatedAt('/eventAttendee/byCreatedAt/:createdAt', HttpMethod.post, List<EventAttendee>),
	getManyByUpdatedAt('/eventAttendee/byUpdatedAt/:updatedAt', HttpMethod.post, List<EventAttendee>),
	getManyByDeletedAt('/eventAttendee/byDeletedAt/:deletedAt', HttpMethod.post, List<EventAttendee>);

    const EventAttendeeEndpoints(this.path, this.method, this.responseType);

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
