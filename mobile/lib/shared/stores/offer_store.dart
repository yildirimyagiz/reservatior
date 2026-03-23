
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class OfferStore extends ModelStreamStore<String, Offer> {

  static OfferStore? _instance;

  static OfferStore get instance {
    _instance ??= OfferStore();
    return _instance!;
  }

  OfferStore() : super(Offer.fromJson) {
    if (_instance != null) {
        throw Exception(
            'OfferStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending OfferStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use OfferStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getOfferIncreaseId(Offer offer) => offer.increaseId;

	String? getOfferId(Offer offer) => offer.id;

	OfferType? getOfferOfferType(Offer offer) => offer.offerType;

	OfferStatus? getOfferStatus(Offer offer) => offer.status;

	double? getOfferBasePrice(Offer offer) => offer.basePrice;

	double? getOfferDiscountRate(Offer offer) => offer.discountRate;

	double? getOfferFinalPrice(Offer offer) => offer.finalPrice;

	String? getOfferGuestId(Offer offer) => offer.guestId;

	DateTime? getOfferStartDate(Offer offer) => offer.startDate;

	DateTime? getOfferEndDate(Offer offer) => offer.endDate;

	String? getOfferSpecialRequirements(Offer offer) => offer.specialRequirements;

	String? getOfferNotes(Offer offer) => offer.notes;

	DateTime? getOfferCreatedAt(Offer offer) => offer.createdAt;

	DateTime? getOfferUpdatedAt(Offer offer) => offer.updatedAt;

	DateTime? getOfferDeletedAt(Offer offer) => offer.deletedAt;

	String? getOfferReservationId(Offer offer) => offer.reservationId;

	String? getOfferPropertyId(Offer offer) => offer.propertyId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Offer? getByIncreaseId(
    String increaseId,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getIncluding(getOfferIncreaseId, increaseId, modelFilter: modelFilter, includes: includes);

	
Offer? getByReservationId(
    String reservationId,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getIncluding(getOfferReservationId, reservationId, modelFilter: modelFilter, includes: includes);

  
List<Offer> getByOfferType(
    OfferType offerType,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferOfferType, offerType, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByStatus(
    OfferStatus status,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByBasePrice(
    double basePrice,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferBasePrice, basePrice, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByDiscountRate(
    double discountRate,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferDiscountRate, discountRate, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByFinalPrice(
    double finalPrice,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferFinalPrice, finalPrice, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByGuestId(
    String guestId,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferGuestId, guestId, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByStartDate(
    DateTime startDate,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByEndDate(
    DateTime endDate,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<Offer> getBySpecialRequirements(
    String specialRequirements,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferSpecialRequirements, specialRequirements, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByNotes(
    String notes,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Offer> getByPropertyId(
    String propertyId,
    {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}
    ) =>
    getManyIncluding(getOfferPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getUser(
    Offer offer, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (offer.guestId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(offer.guestId!, includes: includes);
        offer.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

	Increase? getIncrease(
    Offer offer, {ModelFilter? modelFilter, List<IncreaseInclude>? includes}) {
    if (offer.increaseId == null) {
        return null;
    } else {
        final Increase = IncreaseStore.instance.getById(offer.increaseId!, includes: includes);
        offer.Increase = Increase;
        // setIncludedReferences(Increase, includes: includes);
        return Increase;
    }
}

	Property? getProperty(
    Offer offer, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (offer.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(offer.propertyId!, includes: includes);
        offer.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Reservation? getReservation(
    Offer offer, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (offer.reservationId == null) {
        return null;
    } else {
        final Reservation = ReservationStore.instance.getById(offer.reservationId!, includes: includes);
        offer.Reservation = Reservation;
        // setIncludedReferences(Reservation, includes: includes);
        return Reservation;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Offer>> getAll$({bool useCache = true, ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: OfferEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Offer?> getByIncreaseId$(
        String increaseId,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getOfferIncreaseId,
        value: increaseId,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getByIncreaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Offer?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getOfferId,
        value: id,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Offer?> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getOfferReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Offer>> getByOfferType$(
        OfferType offerType,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<OfferType>(
        getPropVal: getOfferOfferType,
        value: offerType,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByOfferType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByStatus$(
        OfferStatus status,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<OfferStatus>(
        getPropVal: getOfferStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByBasePrice$(
        double basePrice,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getOfferBasePrice,
        value: basePrice,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByBasePrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByDiscountRate$(
        double discountRate,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getOfferDiscountRate,
        value: discountRate,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByDiscountRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByFinalPrice$(
        double finalPrice,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getOfferFinalPrice,
        value: finalPrice,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByFinalPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByGuestId$(
        String guestId,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfferGuestId,
        value: guestId,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByGuestId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOfferStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOfferEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getBySpecialRequirements$(
        String specialRequirements,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfferSpecialRequirements,
        value: specialRequirements,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyBySpecialRequirements,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfferNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOfferCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOfferUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOfferDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Offer>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Offer>? modelFilter,
        List<OfferInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfferPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: OfferEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getUser$(
    Offer offer, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (offer.guestId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            offer.guestId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            offer.User = User;
        });
    }
}

	Stream<Increase?> getIncrease$(
    Offer offer, {bool useCache = true, ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}) {
    if (offer.increaseId == null) {
        return Stream.value(null);
    } else {
        return IncreaseStore.instance.getById$(
            offer.increaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Increase) {
            offer.Increase = Increase;
        });
    }
}

	Stream<Property?> getProperty$(
    Offer offer, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (offer.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            offer.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            offer.Property = Property;
        });
    }
}

	Stream<Reservation?> getReservation$(
    Offer offer, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (offer.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            offer.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Reservation) {
            offer.Reservation = Reservation;
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
Offer recursiveUpsert(Offer offer, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Offer'} 
        : const {};
    if (offer.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        offer.User = UserStore.instance.recursiveUpsert(offer.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (offer.Increase != null && (!preventCircularSerialization || !upsertedTypes.contains('Increase'))) {
        offer.Increase = IncreaseStore.instance.recursiveUpsert(offer.Increase!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (offer.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        offer.Property = PropertyStore.instance.recursiveUpsert(offer.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (offer.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        offer.Reservation = ReservationStore.instance.recursiveUpsert(offer.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(offer);
}

  List<Offer> recursiveListUpsert(List<Offer> offers, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedOffers = <Offer>[];
    for (var offer in offers) {
        updatedOffers.add(recursiveUpsert(offer, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedOffers;
}

//   @override
//   Offer upsert(Offer item) {
//     return recursiveUpsert(item);
//   }

}


class OfferInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      OfferInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (offer) => OfferStore.instance
            .getUser$(offer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (offer) => OfferStore.instance
            .getUser(offer, modelFilter: modelFilter, includes: includes);
      }
}

	OfferInclude.Increase({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Increase>? modelFilter,
    List<IncreaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (offer) => OfferStore.instance
            .getIncrease$(offer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (offer) => OfferStore.instance
            .getIncrease(offer, modelFilter: modelFilter, includes: includes);
      }
}

	OfferInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (offer) => OfferStore.instance
            .getProperty$(offer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (offer) => OfferStore.instance
            .getProperty(offer, modelFilter: modelFilter, includes: includes);
      }
}

	OfferInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (offer) => OfferStore.instance
            .getReservation$(offer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (offer) => OfferStore.instance
            .getReservation(offer, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum OfferEndpoints implements Endpoint {

    getAll('/offer', HttpMethod.post, List<Offer>),
	getByIncreaseId('/offer/byIncreaseId/:increaseId', HttpMethod.post, Offer),
	getById('/offer/byId/:id', HttpMethod.post, Offer),
	getManyByOfferType('/offer/byOfferType/:offerType', HttpMethod.post, List<Offer>),
	getManyByStatus('/offer/byStatus/:status', HttpMethod.post, List<Offer>),
	getManyByBasePrice('/offer/byBasePrice/:basePrice', HttpMethod.post, List<Offer>),
	getManyByDiscountRate('/offer/byDiscountRate/:discountRate', HttpMethod.post, List<Offer>),
	getManyByFinalPrice('/offer/byFinalPrice/:finalPrice', HttpMethod.post, List<Offer>),
	getManyByGuestId('/offer/byGuestId/:guestId', HttpMethod.post, List<Offer>),
	getManyByStartDate('/offer/byStartDate/:startDate', HttpMethod.post, List<Offer>),
	getManyByEndDate('/offer/byEndDate/:endDate', HttpMethod.post, List<Offer>),
	getManyBySpecialRequirements('/offer/bySpecialRequirements/:specialRequirements', HttpMethod.post, List<Offer>),
	getManyByNotes('/offer/byNotes/:notes', HttpMethod.post, List<Offer>),
	getManyByCreatedAt('/offer/byCreatedAt/:createdAt', HttpMethod.post, List<Offer>),
	getManyByUpdatedAt('/offer/byUpdatedAt/:updatedAt', HttpMethod.post, List<Offer>),
	getManyByDeletedAt('/offer/byDeletedAt/:deletedAt', HttpMethod.post, List<Offer>),
	getByReservationId('/offer/byReservationId/:reservationId', HttpMethod.post, Offer),
	getManyByPropertyId('/offer/byPropertyId/:propertyId', HttpMethod.post, List<Offer>);

    const OfferEndpoints(this.path, this.method, this.responseType);

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
