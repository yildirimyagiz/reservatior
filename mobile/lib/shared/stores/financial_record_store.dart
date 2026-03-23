
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class FinancialRecordStore extends ModelStreamStore<String, FinancialRecord> {

  static FinancialRecordStore? _instance;

  static FinancialRecordStore get instance {
    _instance ??= FinancialRecordStore();
    return _instance!;
  }

  FinancialRecordStore() : super(FinancialRecord.fromJson) {
    if (_instance != null) {
        throw Exception(
            'FinancialRecordStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending FinancialRecordStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use FinancialRecordStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getFinancialRecordId(FinancialRecord financialRecord) => financialRecord.id;

	String? getFinancialRecordOrgId(FinancialRecord financialRecord) => financialRecord.orgId;

	String? getFinancialRecordPropertyId(FinancialRecord financialRecord) => financialRecord.propertyId;

	String? getFinancialRecordListingId(FinancialRecord financialRecord) => financialRecord.listingId;

	String? getFinancialRecordLeaseId(FinancialRecord financialRecord) => financialRecord.leaseId;

	String? getFinancialRecordBookingId(FinancialRecord financialRecord) => financialRecord.bookingId;

	String? getFinancialRecordReservationId(FinancialRecord financialRecord) => financialRecord.reservationId;

	String? getFinancialRecordVendorContactId(FinancialRecord financialRecord) => financialRecord.vendorContactId;

	String? getFinancialRecordType(FinancialRecord financialRecord) => financialRecord.type;

	TransactionType? getFinancialRecordRecordType(FinancialRecord financialRecord) => financialRecord.recordType;

	double? getFinancialRecordAmount(FinancialRecord financialRecord) => financialRecord.amount;

	String? getFinancialRecordCurrency(FinancialRecord financialRecord) => financialRecord.currency;

	DateTime? getFinancialRecordOccurredAt(FinancialRecord financialRecord) => financialRecord.occurredAt;

	DateTime? getFinancialRecordDueDate(FinancialRecord financialRecord) => financialRecord.dueDate;

	dynamic? getFinancialRecordBillData(FinancialRecord financialRecord) => financialRecord.billData;

	String? getFinancialRecordCategory(FinancialRecord financialRecord) => financialRecord.category;

	String? getFinancialRecordDescription(FinancialRecord financialRecord) => financialRecord.description;

	String? getFinancialRecordNotes(FinancialRecord financialRecord) => financialRecord.notes;

	PaymentStatus? getFinancialRecordPaymentStatus(FinancialRecord financialRecord) => financialRecord.paymentStatus;

	DateTime? getFinancialRecordPaidAt(FinancialRecord financialRecord) => financialRecord.paidAt;

	String? getFinancialRecordCreatedBy(FinancialRecord financialRecord) => financialRecord.createdBy;

	DateTime? getFinancialRecordCreatedAt(FinancialRecord financialRecord) => financialRecord.createdAt;

	DateTime? getFinancialRecordUpdatedAt(FinancialRecord financialRecord) => financialRecord.updatedAt;

	DateTime? getFinancialRecordDeletedAt(FinancialRecord financialRecord) => financialRecord.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<FinancialRecord> getByOrgId(
    String orgId,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByPropertyId(
    String propertyId,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByListingId(
    String listingId,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByLeaseId(
    String leaseId,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByBookingId(
    String bookingId,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordBookingId, bookingId, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByReservationId(
    String reservationId,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByVendorContactId(
    String vendorContactId,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordVendorContactId, vendorContactId, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByType(
    String type,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordType, type, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByRecordType(
    TransactionType recordType,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordRecordType, recordType, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByAmount(
    double amount,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByCurrency(
    String currency,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByOccurredAt(
    DateTime occurredAt,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordOccurredAt, occurredAt, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByDueDate(
    DateTime dueDate,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordDueDate, dueDate, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByBillData(
    dynamic billData,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordBillData, billData, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByCategory(
    String category,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordCategory, category, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByDescription(
    String description,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordDescription, description, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByNotes(
    String notes,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByPaymentStatus(
    PaymentStatus paymentStatus,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordPaymentStatus, paymentStatus, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByPaidAt(
    DateTime paidAt,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordPaidAt, paidAt, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByCreatedBy(
    String createdBy,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<FinancialRecord> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}
    ) =>
    getManyIncluding(getFinancialRecordDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Booking? getBooking(
    FinancialRecord financialRecord, {ModelFilter? modelFilter, List<BookingInclude>? includes}) {
    if (financialRecord.bookingId == null) {
        return null;
    } else {
        final booking = BookingStore.instance.getById(financialRecord.bookingId!, includes: includes);
        financialRecord.booking = booking;
        // setIncludedReferences(booking, includes: includes);
        return booking;
    }
}

	Lease? getLease(
    FinancialRecord financialRecord, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (financialRecord.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(financialRecord.leaseId!, includes: includes);
        financialRecord.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Listing? getListing(
    FinancialRecord financialRecord, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (financialRecord.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(financialRecord.listingId!, includes: includes);
        financialRecord.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    FinancialRecord financialRecord, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (financialRecord.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(financialRecord.orgId!, includes: includes);
        financialRecord.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    FinancialRecord financialRecord, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (financialRecord.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(financialRecord.propertyId!, includes: includes);
        financialRecord.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

	Reservation? getReservation(
    FinancialRecord financialRecord, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (financialRecord.reservationId == null) {
        return null;
    } else {
        final reservation = ReservationStore.instance.getById(financialRecord.reservationId!, includes: includes);
        financialRecord.reservation = reservation;
        // setIncludedReferences(reservation, includes: includes);
        return reservation;
    }
}

	Contact? getVendor(
    FinancialRecord financialRecord, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (financialRecord.vendorContactId == null) {
        return null;
    } else {
        final vendor = ContactStore.instance.getById(financialRecord.vendorContactId!, includes: includes);
        financialRecord.vendor = vendor;
        // setIncludedReferences(vendor, includes: includes);
        return vendor;
    }
}

  /// GET RELATED MODELS 

  List<Attachment> getAttachments(
    FinancialRecord financialRecord, {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    final attachments = AttachmentStore.instance.getByTransactionId(financialRecord.$uid!, modelFilter: modelFilter, includes: includes);
    financialRecord.attachments = attachments;
    // setIncludedReferencesForList(attachments, includes: includes);
    return attachments;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<FinancialRecord>> getAll$({bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: FinancialRecordEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<FinancialRecord?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getFinancialRecordId,
        value: id,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<FinancialRecord>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByBookingId$(
        String bookingId,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordBookingId,
        value: bookingId,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByBookingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByVendorContactId$(
        String vendorContactId,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordVendorContactId,
        value: vendorContactId,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByVendorContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordType,
        value: type,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByRecordType$(
        TransactionType recordType,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<TransactionType>(
        getPropVal: getFinancialRecordRecordType,
        value: recordType,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByRecordType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getFinancialRecordAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByOccurredAt$(
        DateTime occurredAt,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFinancialRecordOccurredAt,
        value: occurredAt,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByOccurredAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByDueDate$(
        DateTime dueDate,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFinancialRecordDueDate,
        value: dueDate,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByDueDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByBillData$(
        dynamic billData,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getFinancialRecordBillData,
        value: billData,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByBillData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByCategory$(
        String category,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByPaymentStatus$(
        PaymentStatus paymentStatus,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentStatus>(
        getPropVal: getFinancialRecordPaymentStatus,
        value: paymentStatus,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByPaymentStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByPaidAt$(
        DateTime paidAt,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFinancialRecordPaidAt,
        value: paidAt,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByPaidAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFinancialRecordCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFinancialRecordCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFinancialRecordUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FinancialRecord>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<FinancialRecord>? modelFilter,
        List<FinancialRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFinancialRecordDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: FinancialRecordEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Booking?> getBooking$(
    FinancialRecord financialRecord, {bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    if (financialRecord.bookingId == null) {
        return Stream.value(null);
    } else {
        return BookingStore.instance.getById$(
            financialRecord.bookingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((booking) {
            financialRecord.booking = booking;
        });
    }
}

	Stream<Lease?> getLease$(
    FinancialRecord financialRecord, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (financialRecord.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            financialRecord.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            financialRecord.lease = lease;
        });
    }
}

	Stream<Listing?> getListing$(
    FinancialRecord financialRecord, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (financialRecord.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            financialRecord.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            financialRecord.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    FinancialRecord financialRecord, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (financialRecord.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            financialRecord.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            financialRecord.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    FinancialRecord financialRecord, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (financialRecord.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            financialRecord.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            financialRecord.property = property;
        });
    }
}

	Stream<Reservation?> getReservation$(
    FinancialRecord financialRecord, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (financialRecord.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            financialRecord.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((reservation) {
            financialRecord.reservation = reservation;
        });
    }
}

	Stream<Contact?> getVendor$(
    FinancialRecord financialRecord, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (financialRecord.vendorContactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            financialRecord.vendorContactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((vendor) {
            financialRecord.vendor = vendor;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Attachment>> getAttachments$(
    FinancialRecord financialRecord, {bool useCache = true, ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    return AttachmentStore.instance.getByTransactionId$(
        financialRecord.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attachments) {
        financialRecord.attachments = attachments;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
FinancialRecord recursiveUpsert(FinancialRecord financialRecord, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'FinancialRecord'} 
        : const {};
    if (financialRecord.attachments != null && (!preventCircularSerialization || !upsertedTypes.contains('Attachment'))) {
        financialRecord.attachments = AttachmentStore.instance.recursiveListUpsert(financialRecord.attachments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (financialRecord.booking != null && (!preventCircularSerialization || !upsertedTypes.contains('Booking'))) {
        financialRecord.booking = BookingStore.instance.recursiveUpsert(financialRecord.booking!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (financialRecord.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        financialRecord.lease = LeaseStore.instance.recursiveUpsert(financialRecord.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (financialRecord.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        financialRecord.listing = ListingStore.instance.recursiveUpsert(financialRecord.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (financialRecord.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        financialRecord.org = OrganizationStore.instance.recursiveUpsert(financialRecord.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (financialRecord.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        financialRecord.property = PropertyStore.instance.recursiveUpsert(financialRecord.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (financialRecord.reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        financialRecord.reservation = ReservationStore.instance.recursiveUpsert(financialRecord.reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (financialRecord.vendor != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        financialRecord.vendor = ContactStore.instance.recursiveUpsert(financialRecord.vendor!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(financialRecord);
}

  List<FinancialRecord> recursiveListUpsert(List<FinancialRecord> financialRecords, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedFinancialRecords = <FinancialRecord>[];
    for (var financialRecord in financialRecords) {
        updatedFinancialRecords.add(recursiveUpsert(financialRecord, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedFinancialRecords;
}

//   @override
//   FinancialRecord upsert(FinancialRecord item) {
//     return recursiveUpsert(item);
//   }

}


class FinancialRecordInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      FinancialRecordInclude.attachments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Attachment>? modelFilter,
    List<AttachmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (financialRecord) => FinancialRecordStore.instance
            .getAttachments$(financialRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (financialRecord) => FinancialRecordStore.instance
            .getAttachments(financialRecord, modelFilter: modelFilter, includes: includes);
      }
}

	FinancialRecordInclude.booking({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Booking>? modelFilter,
    List<BookingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (financialRecord) => FinancialRecordStore.instance
            .getBooking$(financialRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (financialRecord) => FinancialRecordStore.instance
            .getBooking(financialRecord, modelFilter: modelFilter, includes: includes);
      }
}

	FinancialRecordInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (financialRecord) => FinancialRecordStore.instance
            .getLease$(financialRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (financialRecord) => FinancialRecordStore.instance
            .getLease(financialRecord, modelFilter: modelFilter, includes: includes);
      }
}

	FinancialRecordInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (financialRecord) => FinancialRecordStore.instance
            .getListing$(financialRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (financialRecord) => FinancialRecordStore.instance
            .getListing(financialRecord, modelFilter: modelFilter, includes: includes);
      }
}

	FinancialRecordInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (financialRecord) => FinancialRecordStore.instance
            .getOrg$(financialRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (financialRecord) => FinancialRecordStore.instance
            .getOrg(financialRecord, modelFilter: modelFilter, includes: includes);
      }
}

	FinancialRecordInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (financialRecord) => FinancialRecordStore.instance
            .getProperty$(financialRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (financialRecord) => FinancialRecordStore.instance
            .getProperty(financialRecord, modelFilter: modelFilter, includes: includes);
      }
}

	FinancialRecordInclude.reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (financialRecord) => FinancialRecordStore.instance
            .getReservation$(financialRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (financialRecord) => FinancialRecordStore.instance
            .getReservation(financialRecord, modelFilter: modelFilter, includes: includes);
      }
}

	FinancialRecordInclude.vendor({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (financialRecord) => FinancialRecordStore.instance
            .getVendor$(financialRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (financialRecord) => FinancialRecordStore.instance
            .getVendor(financialRecord, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum FinancialRecordEndpoints implements Endpoint {

    getAll('/financialRecord', HttpMethod.post, List<FinancialRecord>),
	getById('/financialRecord/byId/:id', HttpMethod.post, FinancialRecord),
	getManyByOrgId('/financialRecord/byOrgId/:orgId', HttpMethod.post, List<FinancialRecord>),
	getManyByPropertyId('/financialRecord/byPropertyId/:propertyId', HttpMethod.post, List<FinancialRecord>),
	getManyByListingId('/financialRecord/byListingId/:listingId', HttpMethod.post, List<FinancialRecord>),
	getManyByLeaseId('/financialRecord/byLeaseId/:leaseId', HttpMethod.post, List<FinancialRecord>),
	getManyByBookingId('/financialRecord/byBookingId/:bookingId', HttpMethod.post, List<FinancialRecord>),
	getManyByReservationId('/financialRecord/byReservationId/:reservationId', HttpMethod.post, List<FinancialRecord>),
	getManyByVendorContactId('/financialRecord/byVendorContactId/:vendorContactId', HttpMethod.post, List<FinancialRecord>),
	getManyByType('/financialRecord/byType/:type', HttpMethod.post, List<FinancialRecord>),
	getManyByRecordType('/financialRecord/byRecordType/:recordType', HttpMethod.post, List<FinancialRecord>),
	getManyByAmount('/financialRecord/byAmount/:amount', HttpMethod.post, List<FinancialRecord>),
	getManyByCurrency('/financialRecord/byCurrency/:currency', HttpMethod.post, List<FinancialRecord>),
	getManyByOccurredAt('/financialRecord/byOccurredAt/:occurredAt', HttpMethod.post, List<FinancialRecord>),
	getManyByDueDate('/financialRecord/byDueDate/:dueDate', HttpMethod.post, List<FinancialRecord>),
	getManyByBillData('/financialRecord/byBillData/:billData', HttpMethod.post, List<FinancialRecord>),
	getManyByCategory('/financialRecord/byCategory/:category', HttpMethod.post, List<FinancialRecord>),
	getManyByDescription('/financialRecord/byDescription/:description', HttpMethod.post, List<FinancialRecord>),
	getManyByNotes('/financialRecord/byNotes/:notes', HttpMethod.post, List<FinancialRecord>),
	getManyByPaymentStatus('/financialRecord/byPaymentStatus/:paymentStatus', HttpMethod.post, List<FinancialRecord>),
	getManyByPaidAt('/financialRecord/byPaidAt/:paidAt', HttpMethod.post, List<FinancialRecord>),
	getManyByCreatedBy('/financialRecord/byCreatedBy/:createdBy', HttpMethod.post, List<FinancialRecord>),
	getManyByCreatedAt('/financialRecord/byCreatedAt/:createdAt', HttpMethod.post, List<FinancialRecord>),
	getManyByUpdatedAt('/financialRecord/byUpdatedAt/:updatedAt', HttpMethod.post, List<FinancialRecord>),
	getManyByDeletedAt('/financialRecord/byDeletedAt/:deletedAt', HttpMethod.post, List<FinancialRecord>);

    const FinancialRecordEndpoints(this.path, this.method, this.responseType);

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
