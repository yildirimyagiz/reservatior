
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class GuestProfileStore extends ModelStreamStore<String, GuestProfile> {

  static GuestProfileStore? _instance;

  static GuestProfileStore get instance {
    _instance ??= GuestProfileStore();
    return _instance!;
  }

  GuestProfileStore() : super(GuestProfile.fromJson) {
    if (_instance != null) {
        throw Exception(
            'GuestProfileStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending GuestProfileStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use GuestProfileStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getGuestProfileId(GuestProfile guestProfile) => guestProfile.id;

	String? getGuestProfileContactId(GuestProfile guestProfile) => guestProfile.contactId;

	String? getGuestProfilePreferredCheckInTime(GuestProfile guestProfile) => guestProfile.preferredCheckInTime;

	List<String>? getGuestProfilePreferredAmenities(GuestProfile guestProfile) => guestProfile.preferredAmenities;

	String? getGuestProfileDietaryRestrictions(GuestProfile guestProfile) => guestProfile.dietaryRestrictions;

	String? getGuestProfileAccessibilityNeeds(GuestProfile guestProfile) => guestProfile.accessibilityNeeds;

	int? getGuestProfileLoyaltyPoints(GuestProfile guestProfile) => guestProfile.loyaltyPoints;

	double? getGuestProfileLifetimeSpent(GuestProfile guestProfile) => guestProfile.lifetimeSpent;

	int? getGuestProfileBookingCount(GuestProfile guestProfile) => guestProfile.bookingCount;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
GuestProfile? getByContactId(
    String contactId,
    {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}
    ) =>
    getIncluding(getGuestProfileContactId, contactId, modelFilter: modelFilter, includes: includes);

  
List<GuestProfile> getByPreferredCheckInTime(
    String preferredCheckInTime,
    {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}
    ) =>
    getManyIncluding(getGuestProfilePreferredCheckInTime, preferredCheckInTime, modelFilter: modelFilter, includes: includes);

	
List<GuestProfile> getByPreferredAmenities(
    String preferredAmenities,
    {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}
    ) =>
    getManyIncluding(getGuestProfilePreferredAmenities, preferredAmenities, modelFilter: modelFilter, includes: includes);

	
List<GuestProfile> getByDietaryRestrictions(
    String dietaryRestrictions,
    {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}
    ) =>
    getManyIncluding(getGuestProfileDietaryRestrictions, dietaryRestrictions, modelFilter: modelFilter, includes: includes);

	
List<GuestProfile> getByAccessibilityNeeds(
    String accessibilityNeeds,
    {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}
    ) =>
    getManyIncluding(getGuestProfileAccessibilityNeeds, accessibilityNeeds, modelFilter: modelFilter, includes: includes);

	
List<GuestProfile> getByLoyaltyPoints(
    int loyaltyPoints,
    {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}
    ) =>
    getManyIncluding(getGuestProfileLoyaltyPoints, loyaltyPoints, modelFilter: modelFilter, includes: includes);

	
List<GuestProfile> getByLifetimeSpent(
    double lifetimeSpent,
    {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}
    ) =>
    getManyIncluding(getGuestProfileLifetimeSpent, lifetimeSpent, modelFilter: modelFilter, includes: includes);

	
List<GuestProfile> getByBookingCount(
    int bookingCount,
    {ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}
    ) =>
    getManyIncluding(getGuestProfileBookingCount, bookingCount, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    GuestProfile guestProfile, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (guestProfile.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(guestProfile.contactId!, includes: includes);
        guestProfile.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<GuestProfile>> getAll$({bool useCache = true, ModelFilter<GuestProfile>? modelFilter, List<GuestProfileInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: GuestProfileEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<GuestProfile?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getGuestProfileId,
        value: id,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<GuestProfile?> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getGuestProfileContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<GuestProfile>> getByPreferredCheckInTime$(
        String preferredCheckInTime,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestProfilePreferredCheckInTime,
        value: preferredCheckInTime,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getManyByPreferredCheckInTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestProfile>> getByPreferredAmenities$(
        String preferredAmenities,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestProfilePreferredAmenities,
        value: preferredAmenities,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getManyByPreferredAmenities,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestProfile>> getByDietaryRestrictions$(
        String dietaryRestrictions,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestProfileDietaryRestrictions,
        value: dietaryRestrictions,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getManyByDietaryRestrictions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestProfile>> getByAccessibilityNeeds$(
        String accessibilityNeeds,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestProfileAccessibilityNeeds,
        value: accessibilityNeeds,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getManyByAccessibilityNeeds,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestProfile>> getByLoyaltyPoints$(
        int loyaltyPoints,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestProfileLoyaltyPoints,
        value: loyaltyPoints,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getManyByLoyaltyPoints,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestProfile>> getByLifetimeSpent$(
        double lifetimeSpent,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getGuestProfileLifetimeSpent,
        value: lifetimeSpent,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getManyByLifetimeSpent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestProfile>> getByBookingCount$(
        int bookingCount,
        {bool useCache = true,
        ModelFilter<GuestProfile>? modelFilter,
        List<GuestProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestProfileBookingCount,
        value: bookingCount,
        modelFilter: modelFilter,
        endpoint: GuestProfileEndpoints.getManyByBookingCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    GuestProfile guestProfile, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (guestProfile.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            guestProfile.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            guestProfile.contact = contact;
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
GuestProfile recursiveUpsert(GuestProfile guestProfile, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'GuestProfile'} 
        : const {};
    if (guestProfile.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        guestProfile.contact = ContactStore.instance.recursiveUpsert(guestProfile.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(guestProfile);
}

  List<GuestProfile> recursiveListUpsert(List<GuestProfile> guestProfiles, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedGuestProfiles = <GuestProfile>[];
    for (var guestProfile in guestProfiles) {
        updatedGuestProfiles.add(recursiveUpsert(guestProfile, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedGuestProfiles;
}

//   @override
//   GuestProfile upsert(GuestProfile item) {
//     return recursiveUpsert(item);
//   }

}


class GuestProfileInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      GuestProfileInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (guestProfile) => GuestProfileStore.instance
            .getContact$(guestProfile, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (guestProfile) => GuestProfileStore.instance
            .getContact(guestProfile, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum GuestProfileEndpoints implements Endpoint {

    getAll('/guestProfile', HttpMethod.post, List<GuestProfile>),
	getById('/guestProfile/byId/:id', HttpMethod.post, GuestProfile),
	getByContactId('/guestProfile/byContactId/:contactId', HttpMethod.post, GuestProfile),
	getManyByPreferredCheckInTime('/guestProfile/byPreferredCheckInTime/:preferredCheckInTime', HttpMethod.post, List<GuestProfile>),
	getManyByPreferredAmenities('/guestProfile/byPreferredAmenities/:preferredAmenities', HttpMethod.post, List<GuestProfile>),
	getManyByDietaryRestrictions('/guestProfile/byDietaryRestrictions/:dietaryRestrictions', HttpMethod.post, List<GuestProfile>),
	getManyByAccessibilityNeeds('/guestProfile/byAccessibilityNeeds/:accessibilityNeeds', HttpMethod.post, List<GuestProfile>),
	getManyByLoyaltyPoints('/guestProfile/byLoyaltyPoints/:loyaltyPoints', HttpMethod.post, List<GuestProfile>),
	getManyByLifetimeSpent('/guestProfile/byLifetimeSpent/:lifetimeSpent', HttpMethod.post, List<GuestProfile>),
	getManyByBookingCount('/guestProfile/byBookingCount/:bookingCount', HttpMethod.post, List<GuestProfile>);

    const GuestProfileEndpoints(this.path, this.method, this.responseType);

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
