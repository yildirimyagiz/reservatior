
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class GuestReviewStore extends ModelStreamStore<String, GuestReview> {

  static GuestReviewStore? _instance;

  static GuestReviewStore get instance {
    _instance ??= GuestReviewStore();
    return _instance!;
  }

  GuestReviewStore() : super(GuestReview.fromJson) {
    if (_instance != null) {
        throw Exception(
            'GuestReviewStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending GuestReviewStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use GuestReviewStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getGuestReviewId(GuestReview guestReview) => guestReview.id;

	String? getGuestReviewBookingId(GuestReview guestReview) => guestReview.bookingId;

	String? getGuestReviewGuestId(GuestReview guestReview) => guestReview.guestId;

	String? getGuestReviewPropertyId(GuestReview guestReview) => guestReview.propertyId;

	int? getGuestReviewRating(GuestReview guestReview) => guestReview.rating;

	int? getGuestReviewCleanliness(GuestReview guestReview) => guestReview.cleanliness;

	int? getGuestReviewCommunication(GuestReview guestReview) => guestReview.communication;

	int? getGuestReviewCheckIn(GuestReview guestReview) => guestReview.checkIn;

	int? getGuestReviewAccuracy(GuestReview guestReview) => guestReview.accuracy;

	int? getGuestReviewLocation(GuestReview guestReview) => guestReview.location;

	int? getGuestReviewValue(GuestReview guestReview) => guestReview.value;

	String? getGuestReviewComment(GuestReview guestReview) => guestReview.comment;

	String? getGuestReviewResponse(GuestReview guestReview) => guestReview.response;

	bool? getGuestReviewIsPublic(GuestReview guestReview) => guestReview.isPublic;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<GuestReview> getByBookingId(
    String bookingId,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewBookingId, bookingId, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByGuestId(
    String guestId,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewGuestId, guestId, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByPropertyId(
    String propertyId,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByRating(
    int rating,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewRating, rating, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByCleanliness(
    int cleanliness,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewCleanliness, cleanliness, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByCommunication(
    int communication,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewCommunication, communication, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByCheckIn(
    int checkIn,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewCheckIn, checkIn, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByAccuracy(
    int accuracy,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewAccuracy, accuracy, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByLocation(
    int location,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewLocation, location, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByValue(
    int value,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewValue, value, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByComment(
    String comment,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewComment, comment, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByResponse(
    String response,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewResponse, response, modelFilter: modelFilter, includes: includes);

	
List<GuestReview> getByIsPublic(
    bool isPublic,
    {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}
    ) =>
    getManyIncluding(getGuestReviewIsPublic, isPublic, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Booking? getBooking(
    GuestReview guestReview, {ModelFilter? modelFilter, List<BookingInclude>? includes}) {
    if (guestReview.bookingId == null) {
        return null;
    } else {
        final booking = BookingStore.instance.getById(guestReview.bookingId!, includes: includes);
        guestReview.booking = booking;
        // setIncludedReferences(booking, includes: includes);
        return booking;
    }
}

	Contact? getGuest(
    GuestReview guestReview, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (guestReview.guestId == null) {
        return null;
    } else {
        final guest = ContactStore.instance.getById(guestReview.guestId!, includes: includes);
        guestReview.guest = guest;
        // setIncludedReferences(guest, includes: includes);
        return guest;
    }
}

	Property? getProperty(
    GuestReview guestReview, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (guestReview.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(guestReview.propertyId!, includes: includes);
        guestReview.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<GuestReview>> getAll$({bool useCache = true, ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: GuestReviewEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<GuestReview?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getGuestReviewId,
        value: id,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<GuestReview>> getByBookingId$(
        String bookingId,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestReviewBookingId,
        value: bookingId,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByBookingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByGuestId$(
        String guestId,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestReviewGuestId,
        value: guestId,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByGuestId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestReviewPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByRating$(
        int rating,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestReviewRating,
        value: rating,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByRating,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByCleanliness$(
        int cleanliness,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestReviewCleanliness,
        value: cleanliness,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByCleanliness,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByCommunication$(
        int communication,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestReviewCommunication,
        value: communication,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByCommunication,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByCheckIn$(
        int checkIn,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestReviewCheckIn,
        value: checkIn,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByCheckIn,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByAccuracy$(
        int accuracy,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestReviewAccuracy,
        value: accuracy,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByAccuracy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByLocation$(
        int location,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestReviewLocation,
        value: location,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByLocation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByValue$(
        int value,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getGuestReviewValue,
        value: value,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByComment$(
        String comment,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestReviewComment,
        value: comment,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByComment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByResponse$(
        String response,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestReviewResponse,
        value: response,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByResponse,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GuestReview>> getByIsPublic$(
        bool isPublic,
        {bool useCache = true,
        ModelFilter<GuestReview>? modelFilter,
        List<GuestReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getGuestReviewIsPublic,
        value: isPublic,
        modelFilter: modelFilter,
        endpoint: GuestReviewEndpoints.getManyByIsPublic,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Booking?> getBooking$(
    GuestReview guestReview, {bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    if (guestReview.bookingId == null) {
        return Stream.value(null);
    } else {
        return BookingStore.instance.getById$(
            guestReview.bookingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((booking) {
            guestReview.booking = booking;
        });
    }
}

	Stream<Contact?> getGuest$(
    GuestReview guestReview, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (guestReview.guestId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            guestReview.guestId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((guest) {
            guestReview.guest = guest;
        });
    }
}

	Stream<Property?> getProperty$(
    GuestReview guestReview, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (guestReview.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            guestReview.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            guestReview.property = property;
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
GuestReview recursiveUpsert(GuestReview guestReview, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'GuestReview'} 
        : const {};
    if (guestReview.booking != null && (!preventCircularSerialization || !upsertedTypes.contains('Booking'))) {
        guestReview.booking = BookingStore.instance.recursiveUpsert(guestReview.booking!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (guestReview.guest != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        guestReview.guest = ContactStore.instance.recursiveUpsert(guestReview.guest!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (guestReview.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        guestReview.property = PropertyStore.instance.recursiveUpsert(guestReview.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(guestReview);
}

  List<GuestReview> recursiveListUpsert(List<GuestReview> guestReviews, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedGuestReviews = <GuestReview>[];
    for (var guestReview in guestReviews) {
        updatedGuestReviews.add(recursiveUpsert(guestReview, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedGuestReviews;
}

//   @override
//   GuestReview upsert(GuestReview item) {
//     return recursiveUpsert(item);
//   }

}


class GuestReviewInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      GuestReviewInclude.booking({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Booking>? modelFilter,
    List<BookingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (guestReview) => GuestReviewStore.instance
            .getBooking$(guestReview, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (guestReview) => GuestReviewStore.instance
            .getBooking(guestReview, modelFilter: modelFilter, includes: includes);
      }
}

	GuestReviewInclude.guest({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (guestReview) => GuestReviewStore.instance
            .getGuest$(guestReview, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (guestReview) => GuestReviewStore.instance
            .getGuest(guestReview, modelFilter: modelFilter, includes: includes);
      }
}

	GuestReviewInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (guestReview) => GuestReviewStore.instance
            .getProperty$(guestReview, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (guestReview) => GuestReviewStore.instance
            .getProperty(guestReview, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum GuestReviewEndpoints implements Endpoint {

    getAll('/guestReview', HttpMethod.post, List<GuestReview>),
	getById('/guestReview/byId/:id', HttpMethod.post, GuestReview),
	getManyByBookingId('/guestReview/byBookingId/:bookingId', HttpMethod.post, List<GuestReview>),
	getManyByGuestId('/guestReview/byGuestId/:guestId', HttpMethod.post, List<GuestReview>),
	getManyByPropertyId('/guestReview/byPropertyId/:propertyId', HttpMethod.post, List<GuestReview>),
	getManyByRating('/guestReview/byRating/:rating', HttpMethod.post, List<GuestReview>),
	getManyByCleanliness('/guestReview/byCleanliness/:cleanliness', HttpMethod.post, List<GuestReview>),
	getManyByCommunication('/guestReview/byCommunication/:communication', HttpMethod.post, List<GuestReview>),
	getManyByCheckIn('/guestReview/byCheckIn/:checkIn', HttpMethod.post, List<GuestReview>),
	getManyByAccuracy('/guestReview/byAccuracy/:accuracy', HttpMethod.post, List<GuestReview>),
	getManyByLocation('/guestReview/byLocation/:location', HttpMethod.post, List<GuestReview>),
	getManyByValue('/guestReview/byValue/:value', HttpMethod.post, List<GuestReview>),
	getManyByComment('/guestReview/byComment/:comment', HttpMethod.post, List<GuestReview>),
	getManyByResponse('/guestReview/byResponse/:response', HttpMethod.post, List<GuestReview>),
	getManyByIsPublic('/guestReview/byIsPublic/:isPublic', HttpMethod.post, List<GuestReview>);

    const GuestReviewEndpoints(this.path, this.method, this.responseType);

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
