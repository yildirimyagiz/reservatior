
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyViewingStore extends ModelStreamStore<String, PropertyViewing> {

  static PropertyViewingStore? _instance;

  static PropertyViewingStore get instance {
    _instance ??= PropertyViewingStore();
    return _instance!;
  }

  PropertyViewingStore() : super(PropertyViewing.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyViewingStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyViewingStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyViewingStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyViewingId(PropertyViewing propertyViewing) => propertyViewing.id;

	String? getPropertyViewingOrgId(PropertyViewing propertyViewing) => propertyViewing.orgId;

	String? getPropertyViewingPropertyId(PropertyViewing propertyViewing) => propertyViewing.propertyId;

	String? getPropertyViewingListingId(PropertyViewing propertyViewing) => propertyViewing.listingId;

	String? getPropertyViewingViewingType(PropertyViewing propertyViewing) => propertyViewing.viewingType;

	DateTime? getPropertyViewingScheduledDate(PropertyViewing propertyViewing) => propertyViewing.scheduledDate;

	int? getPropertyViewingDuration(PropertyViewing propertyViewing) => propertyViewing.duration;

	String? getPropertyViewingAttendeeName(PropertyViewing propertyViewing) => propertyViewing.attendeeName;

	String? getPropertyViewingAttendeeEmail(PropertyViewing propertyViewing) => propertyViewing.attendeeEmail;

	String? getPropertyViewingAttendeePhone(PropertyViewing propertyViewing) => propertyViewing.attendeePhone;

	String? getPropertyViewingAttendeeType(PropertyViewing propertyViewing) => propertyViewing.attendeeType;

	String? getPropertyViewingStatus(PropertyViewing propertyViewing) => propertyViewing.status;

	String? getPropertyViewingAssignedAgentId(PropertyViewing propertyViewing) => propertyViewing.assignedAgentId;

	String? getPropertyViewingFeedback(PropertyViewing propertyViewing) => propertyViewing.feedback;

	String? getPropertyViewingInterestedLevel(PropertyViewing propertyViewing) => propertyViewing.interestedLevel;

	bool? getPropertyViewingFollowUpRequired(PropertyViewing propertyViewing) => propertyViewing.followUpRequired;

	String? getPropertyViewingFollowUpNotes(PropertyViewing propertyViewing) => propertyViewing.followUpNotes;

	DateTime? getPropertyViewingCreatedAt(PropertyViewing propertyViewing) => propertyViewing.createdAt;

	DateTime? getPropertyViewingUpdatedAt(PropertyViewing propertyViewing) => propertyViewing.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyViewing> getByOrgId(
    String orgId,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByListingId(
    String listingId,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByViewingType(
    String viewingType,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingViewingType, viewingType, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByScheduledDate(
    DateTime scheduledDate,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingScheduledDate, scheduledDate, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByDuration(
    int duration,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingDuration, duration, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByAttendeeName(
    String attendeeName,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingAttendeeName, attendeeName, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByAttendeeEmail(
    String attendeeEmail,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingAttendeeEmail, attendeeEmail, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByAttendeePhone(
    String attendeePhone,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingAttendeePhone, attendeePhone, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByAttendeeType(
    String attendeeType,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingAttendeeType, attendeeType, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByStatus(
    String status,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingStatus, status, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByAssignedAgentId(
    String assignedAgentId,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingAssignedAgentId, assignedAgentId, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByFeedback(
    String feedback,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingFeedback, feedback, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByInterestedLevel(
    String interestedLevel,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingInterestedLevel, interestedLevel, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByFollowUpRequired(
    bool followUpRequired,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingFollowUpRequired, followUpRequired, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByFollowUpNotes(
    String followUpNotes,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingFollowUpNotes, followUpNotes, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyViewing> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}
    ) =>
    getManyIncluding(getPropertyViewingUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getAssignedAgent(
    PropertyViewing propertyViewing, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (propertyViewing.assignedAgentId == null) {
        return null;
    } else {
        final assignedAgent = UserStore.instance.getById(propertyViewing.assignedAgentId!, includes: includes);
        propertyViewing.assignedAgent = assignedAgent;
        // setIncludedReferences(assignedAgent, includes: includes);
        return assignedAgent;
    }
}

	Listing? getListing(
    PropertyViewing propertyViewing, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (propertyViewing.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(propertyViewing.listingId!, includes: includes);
        propertyViewing.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    PropertyViewing propertyViewing, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyViewing.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(propertyViewing.orgId!, includes: includes);
        propertyViewing.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    PropertyViewing propertyViewing, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyViewing.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyViewing.propertyId!, includes: includes);
        propertyViewing.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyViewing>> getAll$({bool useCache = true, ModelFilter<PropertyViewing>? modelFilter, List<PropertyViewingInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyViewingEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyViewing?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyViewingId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyViewing>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByViewingType$(
        String viewingType,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingViewingType,
        value: viewingType,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByViewingType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByScheduledDate$(
        DateTime scheduledDate,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyViewingScheduledDate,
        value: scheduledDate,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByScheduledDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByDuration$(
        int duration,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyViewingDuration,
        value: duration,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByDuration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByAttendeeName$(
        String attendeeName,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingAttendeeName,
        value: attendeeName,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByAttendeeName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByAttendeeEmail$(
        String attendeeEmail,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingAttendeeEmail,
        value: attendeeEmail,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByAttendeeEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByAttendeePhone$(
        String attendeePhone,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingAttendeePhone,
        value: attendeePhone,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByAttendeePhone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByAttendeeType$(
        String attendeeType,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingAttendeeType,
        value: attendeeType,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByAttendeeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByAssignedAgentId$(
        String assignedAgentId,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingAssignedAgentId,
        value: assignedAgentId,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByAssignedAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByFeedback$(
        String feedback,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingFeedback,
        value: feedback,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByFeedback,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByInterestedLevel$(
        String interestedLevel,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingInterestedLevel,
        value: interestedLevel,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByInterestedLevel,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByFollowUpRequired$(
        bool followUpRequired,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPropertyViewingFollowUpRequired,
        value: followUpRequired,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByFollowUpRequired,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByFollowUpNotes$(
        String followUpNotes,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyViewingFollowUpNotes,
        value: followUpNotes,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByFollowUpNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyViewingCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyViewing>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyViewing>? modelFilter,
        List<PropertyViewingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyViewingUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyViewingEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getAssignedAgent$(
    PropertyViewing propertyViewing, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (propertyViewing.assignedAgentId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            propertyViewing.assignedAgentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((assignedAgent) {
            propertyViewing.assignedAgent = assignedAgent;
        });
    }
}

	Stream<Listing?> getListing$(
    PropertyViewing propertyViewing, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (propertyViewing.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            propertyViewing.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            propertyViewing.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    PropertyViewing propertyViewing, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyViewing.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            propertyViewing.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            propertyViewing.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    PropertyViewing propertyViewing, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyViewing.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyViewing.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyViewing.property = property;
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
PropertyViewing recursiveUpsert(PropertyViewing propertyViewing, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyViewing'} 
        : const {};
    if (propertyViewing.assignedAgent != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        propertyViewing.assignedAgent = UserStore.instance.recursiveUpsert(propertyViewing.assignedAgent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyViewing.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        propertyViewing.listing = ListingStore.instance.recursiveUpsert(propertyViewing.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyViewing.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        propertyViewing.org = OrganizationStore.instance.recursiveUpsert(propertyViewing.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyViewing.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyViewing.property = PropertyStore.instance.recursiveUpsert(propertyViewing.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyViewing);
}

  List<PropertyViewing> recursiveListUpsert(List<PropertyViewing> propertyViewings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyViewings = <PropertyViewing>[];
    for (var propertyViewing in propertyViewings) {
        updatedPropertyViewings.add(recursiveUpsert(propertyViewing, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyViewings;
}

//   @override
//   PropertyViewing upsert(PropertyViewing item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyViewingInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyViewingInclude.assignedAgent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyViewing) => PropertyViewingStore.instance
            .getAssignedAgent$(propertyViewing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyViewing) => PropertyViewingStore.instance
            .getAssignedAgent(propertyViewing, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyViewingInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyViewing) => PropertyViewingStore.instance
            .getListing$(propertyViewing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyViewing) => PropertyViewingStore.instance
            .getListing(propertyViewing, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyViewingInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyViewing) => PropertyViewingStore.instance
            .getOrg$(propertyViewing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyViewing) => PropertyViewingStore.instance
            .getOrg(propertyViewing, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyViewingInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyViewing) => PropertyViewingStore.instance
            .getProperty$(propertyViewing, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyViewing) => PropertyViewingStore.instance
            .getProperty(propertyViewing, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyViewingEndpoints implements Endpoint {

    getAll('/propertyViewing', HttpMethod.post, List<PropertyViewing>),
	getById('/propertyViewing/byId/:id', HttpMethod.post, PropertyViewing),
	getManyByOrgId('/propertyViewing/byOrgId/:orgId', HttpMethod.post, List<PropertyViewing>),
	getManyByPropertyId('/propertyViewing/byPropertyId/:propertyId', HttpMethod.post, List<PropertyViewing>),
	getManyByListingId('/propertyViewing/byListingId/:listingId', HttpMethod.post, List<PropertyViewing>),
	getManyByViewingType('/propertyViewing/byViewingType/:viewingType', HttpMethod.post, List<PropertyViewing>),
	getManyByScheduledDate('/propertyViewing/byScheduledDate/:scheduledDate', HttpMethod.post, List<PropertyViewing>),
	getManyByDuration('/propertyViewing/byDuration/:duration', HttpMethod.post, List<PropertyViewing>),
	getManyByAttendeeName('/propertyViewing/byAttendeeName/:attendeeName', HttpMethod.post, List<PropertyViewing>),
	getManyByAttendeeEmail('/propertyViewing/byAttendeeEmail/:attendeeEmail', HttpMethod.post, List<PropertyViewing>),
	getManyByAttendeePhone('/propertyViewing/byAttendeePhone/:attendeePhone', HttpMethod.post, List<PropertyViewing>),
	getManyByAttendeeType('/propertyViewing/byAttendeeType/:attendeeType', HttpMethod.post, List<PropertyViewing>),
	getManyByStatus('/propertyViewing/byStatus/:status', HttpMethod.post, List<PropertyViewing>),
	getManyByAssignedAgentId('/propertyViewing/byAssignedAgentId/:assignedAgentId', HttpMethod.post, List<PropertyViewing>),
	getManyByFeedback('/propertyViewing/byFeedback/:feedback', HttpMethod.post, List<PropertyViewing>),
	getManyByInterestedLevel('/propertyViewing/byInterestedLevel/:interestedLevel', HttpMethod.post, List<PropertyViewing>),
	getManyByFollowUpRequired('/propertyViewing/byFollowUpRequired/:followUpRequired', HttpMethod.post, List<PropertyViewing>),
	getManyByFollowUpNotes('/propertyViewing/byFollowUpNotes/:followUpNotes', HttpMethod.post, List<PropertyViewing>),
	getManyByCreatedAt('/propertyViewing/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyViewing>),
	getManyByUpdatedAt('/propertyViewing/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyViewing>);

    const PropertyViewingEndpoints(this.path, this.method, this.responseType);

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
