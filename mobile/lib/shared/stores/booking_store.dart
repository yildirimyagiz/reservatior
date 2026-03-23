
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class BookingStore extends ModelStreamStore<String, Booking> {

  static BookingStore? _instance;

  static BookingStore get instance {
    _instance ??= BookingStore();
    return _instance!;
  }

  BookingStore() : super(Booking.fromJson) {
    if (_instance != null) {
        throw Exception(
            'BookingStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending BookingStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use BookingStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getBookingId(Booking booking) => booking.id;

	String? getBookingOrgId(Booking booking) => booking.orgId;

	String? getBookingListingId(Booking booking) => booking.listingId;

	String? getBookingContactId(Booking booking) => booking.contactId;

	String? getBookingReservationId(Booking booking) => booking.reservationId;

	BookingStatus? getBookingStatus(Booking booking) => booking.status;

	DateTime? getBookingStartDate(Booking booking) => booking.startDate;

	DateTime? getBookingEndDate(Booking booking) => booking.endDate;

	int? getBookingAdults(Booking booking) => booking.adults;

	int? getBookingChildren(Booking booking) => booking.children;

	double? getBookingPriceTotal(Booking booking) => booking.priceTotal;

	String? getBookingCurrency(Booking booking) => booking.currency;

	PaymentStatus? getBookingPaymentStatus(Booking booking) => booking.paymentStatus;

	String? getBookingNotes(Booking booking) => booking.notes;

	String? getBookingCreatedBy(Booking booking) => booking.createdBy;

	DateTime? getBookingCreatedAt(Booking booking) => booking.createdAt;

	DateTime? getBookingUpdatedAt(Booking booking) => booking.updatedAt;

	DateTime? getBookingDeletedAt(Booking booking) => booking.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Booking> getByOrgId(
    String orgId,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByListingId(
    String listingId,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByContactId(
    String contactId,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByReservationId(
    String reservationId,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByStatus(
    BookingStatus status,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByStartDate(
    DateTime startDate,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByEndDate(
    DateTime endDate,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByAdults(
    int adults,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingAdults, adults, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByChildren(
    int children,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingChildren, children, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByPriceTotal(
    double priceTotal,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingPriceTotal, priceTotal, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByCurrency(
    String currency,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByPaymentStatus(
    PaymentStatus paymentStatus,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingPaymentStatus, paymentStatus, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByNotes(
    String notes,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByCreatedBy(
    String createdBy,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Booking> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}
    ) =>
    getManyIncluding(getBookingDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    Booking booking, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (booking.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(booking.contactId!, includes: includes);
        booking.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Listing? getListing(
    Booking booking, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (booking.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(booking.listingId!, includes: includes);
        booking.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    Booking booking, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (booking.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(booking.orgId!, includes: includes);
        booking.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Reservation? getReservation(
    Booking booking, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (booking.reservationId == null) {
        return null;
    } else {
        final reservation = ReservationStore.instance.getById(booking.reservationId!, includes: includes);
        booking.reservation = reservation;
        // setIncludedReferences(reservation, includes: includes);
        return reservation;
    }
}

  /// GET RELATED MODELS 

  List<Contract> getContracts(
    Booking booking, {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    final contracts = ContractStore.instance.getByBookingId(booking.$uid!, modelFilter: modelFilter, includes: includes);
    booking.contracts = contracts;
    // setIncludedReferencesForList(contracts, includes: includes);
    return contracts;
}

	List<FinancialRecord> getFinancialRecords(
    Booking booking, {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    final financialRecords = FinancialRecordStore.instance.getByBookingId(booking.$uid!, modelFilter: modelFilter, includes: includes);
    booking.financialRecords = financialRecords;
    // setIncludedReferencesForList(financialRecords, includes: includes);
    return financialRecords;
}

	List<GuestReview> getGuestReviews(
    Booking booking, {ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}) {
    final guestReviews = GuestReviewStore.instance.getByBookingId(booking.$uid!, modelFilter: modelFilter, includes: includes);
    booking.guestReviews = guestReviews;
    // setIncludedReferencesForList(guestReviews, includes: includes);
    return guestReviews;
}

	List<Task> getTasks(
    Booking booking, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByBookingId(booking.$uid!, modelFilter: modelFilter, includes: includes);
    booking.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Booking>> getAll$({bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: BookingEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Booking?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getBookingId,
        value: id,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Booking>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBookingOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBookingListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBookingContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBookingReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByStatus$(
        BookingStatus status,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<BookingStatus>(
        getPropVal: getBookingStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBookingStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBookingEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByAdults$(
        int adults,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getBookingAdults,
        value: adults,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByAdults,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByChildren$(
        int children,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getBookingChildren,
        value: children,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByChildren,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByPriceTotal$(
        double priceTotal,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getBookingPriceTotal,
        value: priceTotal,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByPriceTotal,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBookingCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByPaymentStatus$(
        PaymentStatus paymentStatus,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentStatus>(
        getPropVal: getBookingPaymentStatus,
        value: paymentStatus,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByPaymentStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBookingNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBookingCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBookingCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBookingUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Booking>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Booking>? modelFilter,
        List<BookingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBookingDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: BookingEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    Booking booking, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (booking.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            booking.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            booking.contact = contact;
        });
    }
}

	Stream<Listing?> getListing$(
    Booking booking, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (booking.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            booking.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            booking.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    Booking booking, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (booking.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            booking.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            booking.org = org;
        });
    }
}

	Stream<Reservation?> getReservation$(
    Booking booking, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (booking.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            booking.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((reservation) {
            booking.reservation = reservation;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Contract>> getContracts$(
    Booking booking, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    return ContractStore.instance.getByBookingId$(
        booking.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((contracts) {
        booking.contracts = contracts;
    });

}

	Stream<List<FinancialRecord>> getFinancialRecords$(
    Booking booking, {bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    return FinancialRecordStore.instance.getByBookingId$(
        booking.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((financialRecords) {
        booking.financialRecords = financialRecords;
    });

}

	Stream<List<GuestReview>> getGuestReviews$(
    Booking booking, {bool useCache = true, ModelFilter<GuestReview>? modelFilter, List<GuestReviewInclude>? includes}) {
    return GuestReviewStore.instance.getByBookingId$(
        booking.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((guestReviews) {
        booking.guestReviews = guestReviews;
    });

}

	Stream<List<Task>> getTasks$(
    Booking booking, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByBookingId$(
        booking.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        booking.tasks = tasks;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Booking recursiveUpsert(Booking booking, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Booking'} 
        : const {};
    if (booking.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        booking.contact = ContactStore.instance.recursiveUpsert(booking.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (booking.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        booking.listing = ListingStore.instance.recursiveUpsert(booking.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (booking.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        booking.org = OrganizationStore.instance.recursiveUpsert(booking.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (booking.reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        booking.reservation = ReservationStore.instance.recursiveUpsert(booking.reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (booking.contracts != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        booking.contracts = ContractStore.instance.recursiveListUpsert(booking.contracts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (booking.financialRecords != null && (!preventCircularSerialization || !upsertedTypes.contains('FinancialRecord'))) {
        booking.financialRecords = FinancialRecordStore.instance.recursiveListUpsert(booking.financialRecords!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (booking.guestReviews != null && (!preventCircularSerialization || !upsertedTypes.contains('GuestReview'))) {
        booking.guestReviews = GuestReviewStore.instance.recursiveListUpsert(booking.guestReviews!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (booking.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        booking.tasks = TaskStore.instance.recursiveListUpsert(booking.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(booking);
}

  List<Booking> recursiveListUpsert(List<Booking> bookings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedBookings = <Booking>[];
    for (var booking in bookings) {
        updatedBookings.add(recursiveUpsert(booking, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedBookings;
}

//   @override
//   Booking upsert(Booking item) {
//     return recursiveUpsert(item);
//   }

}


class BookingInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      BookingInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (booking) => BookingStore.instance
            .getContact$(booking, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (booking) => BookingStore.instance
            .getContact(booking, modelFilter: modelFilter, includes: includes);
      }
}

	BookingInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (booking) => BookingStore.instance
            .getListing$(booking, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (booking) => BookingStore.instance
            .getListing(booking, modelFilter: modelFilter, includes: includes);
      }
}

	BookingInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (booking) => BookingStore.instance
            .getOrg$(booking, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (booking) => BookingStore.instance
            .getOrg(booking, modelFilter: modelFilter, includes: includes);
      }
}

	BookingInclude.reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (booking) => BookingStore.instance
            .getReservation$(booking, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (booking) => BookingStore.instance
            .getReservation(booking, modelFilter: modelFilter, includes: includes);
      }
}

	BookingInclude.contracts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (booking) => BookingStore.instance
            .getContracts$(booking, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (booking) => BookingStore.instance
            .getContracts(booking, modelFilter: modelFilter, includes: includes);
      }
}

	BookingInclude.financialRecords({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FinancialRecord>? modelFilter,
    List<FinancialRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (booking) => BookingStore.instance
            .getFinancialRecords$(booking, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (booking) => BookingStore.instance
            .getFinancialRecords(booking, modelFilter: modelFilter, includes: includes);
      }
}

	BookingInclude.guestReviews({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<GuestReview>? modelFilter,
    List<GuestReviewInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (booking) => BookingStore.instance
            .getGuestReviews$(booking, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (booking) => BookingStore.instance
            .getGuestReviews(booking, modelFilter: modelFilter, includes: includes);
      }
}

	BookingInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (booking) => BookingStore.instance
            .getTasks$(booking, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (booking) => BookingStore.instance
            .getTasks(booking, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum BookingEndpoints implements Endpoint {

    getAll('/booking', HttpMethod.post, List<Booking>),
	getById('/booking/byId/:id', HttpMethod.post, Booking),
	getManyByOrgId('/booking/byOrgId/:orgId', HttpMethod.post, List<Booking>),
	getManyByListingId('/booking/byListingId/:listingId', HttpMethod.post, List<Booking>),
	getManyByContactId('/booking/byContactId/:contactId', HttpMethod.post, List<Booking>),
	getManyByReservationId('/booking/byReservationId/:reservationId', HttpMethod.post, List<Booking>),
	getManyByStatus('/booking/byStatus/:status', HttpMethod.post, List<Booking>),
	getManyByStartDate('/booking/byStartDate/:startDate', HttpMethod.post, List<Booking>),
	getManyByEndDate('/booking/byEndDate/:endDate', HttpMethod.post, List<Booking>),
	getManyByAdults('/booking/byAdults/:adults', HttpMethod.post, List<Booking>),
	getManyByChildren('/booking/byChildren/:children', HttpMethod.post, List<Booking>),
	getManyByPriceTotal('/booking/byPriceTotal/:priceTotal', HttpMethod.post, List<Booking>),
	getManyByCurrency('/booking/byCurrency/:currency', HttpMethod.post, List<Booking>),
	getManyByPaymentStatus('/booking/byPaymentStatus/:paymentStatus', HttpMethod.post, List<Booking>),
	getManyByNotes('/booking/byNotes/:notes', HttpMethod.post, List<Booking>),
	getManyByCreatedBy('/booking/byCreatedBy/:createdBy', HttpMethod.post, List<Booking>),
	getManyByCreatedAt('/booking/byCreatedAt/:createdAt', HttpMethod.post, List<Booking>),
	getManyByUpdatedAt('/booking/byUpdatedAt/:updatedAt', HttpMethod.post, List<Booking>),
	getManyByDeletedAt('/booking/byDeletedAt/:deletedAt', HttpMethod.post, List<Booking>);

    const BookingEndpoints(this.path, this.method, this.responseType);

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
