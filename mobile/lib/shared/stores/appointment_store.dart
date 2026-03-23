
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AppointmentStore extends ModelStreamStore<String, Appointment> {

  static AppointmentStore? _instance;

  static AppointmentStore get instance {
    _instance ??= AppointmentStore();
    return _instance!;
  }

  AppointmentStore() : super(Appointment.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AppointmentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AppointmentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AppointmentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAppointmentId(Appointment appointment) => appointment.id;

	String? getAppointmentOrgId(Appointment appointment) => appointment.orgId;

	String? getAppointmentPropertyId(Appointment appointment) => appointment.propertyId;

	String? getAppointmentListingId(Appointment appointment) => appointment.listingId;

	String? getAppointmentContactId(Appointment appointment) => appointment.contactId;

	String? getAppointmentTitle(Appointment appointment) => appointment.title;

	String? getAppointmentDescription(Appointment appointment) => appointment.description;

	String? getAppointmentAppointmentType(Appointment appointment) => appointment.appointmentType;

	DateTime? getAppointmentStartDate(Appointment appointment) => appointment.startDate;

	DateTime? getAppointmentEndDate(Appointment appointment) => appointment.endDate;

	String? getAppointmentTimezone(Appointment appointment) => appointment.timezone;

	String? getAppointmentStatus(Appointment appointment) => appointment.status;

	String? getAppointmentLocation(Appointment appointment) => appointment.location;

	String? getAppointmentAssignedToUserId(Appointment appointment) => appointment.assignedToUserId;

	String? getAppointmentAssignedToContactId(Appointment appointment) => appointment.assignedToContactId;

	dynamic? getAppointmentReminders(Appointment appointment) => appointment.reminders;

	String? getAppointmentNotes(Appointment appointment) => appointment.notes;

	String? getAppointmentCreatedBy(Appointment appointment) => appointment.createdBy;

	DateTime? getAppointmentCreatedAt(Appointment appointment) => appointment.createdAt;

	DateTime? getAppointmentUpdatedAt(Appointment appointment) => appointment.updatedAt;

	DateTime? getAppointmentDeletedAt(Appointment appointment) => appointment.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Appointment> getByOrgId(
    String orgId,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByPropertyId(
    String propertyId,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByListingId(
    String listingId,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByContactId(
    String contactId,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByTitle(
    String title,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByDescription(
    String description,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByAppointmentType(
    String appointmentType,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentAppointmentType, appointmentType, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByStartDate(
    DateTime startDate,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByEndDate(
    DateTime endDate,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByTimezone(
    String timezone,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentTimezone, timezone, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByStatus(
    String status,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByLocation(
    String location,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentLocation, location, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByAssignedToUserId(
    String assignedToUserId,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentAssignedToUserId, assignedToUserId, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByAssignedToContactId(
    String assignedToContactId,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentAssignedToContactId, assignedToContactId, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByReminders(
    dynamic reminders,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentReminders, reminders, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByNotes(
    String notes,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByCreatedBy(
    String createdBy,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Appointment> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}
    ) =>
    getManyIncluding(getAppointmentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getAssignedContact(
    Appointment appointment, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (appointment.assignedToContactId == null) {
        return null;
    } else {
        final assignedContact = ContactStore.instance.getById(appointment.assignedToContactId!, includes: includes);
        appointment.assignedContact = assignedContact;
        // setIncludedReferences(assignedContact, includes: includes);
        return assignedContact;
    }
}

	User? getAssignedUser(
    Appointment appointment, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (appointment.assignedToUserId == null) {
        return null;
    } else {
        final assignedUser = UserStore.instance.getById(appointment.assignedToUserId!, includes: includes);
        appointment.assignedUser = assignedUser;
        // setIncludedReferences(assignedUser, includes: includes);
        return assignedUser;
    }
}

	Contact? getContact(
    Appointment appointment, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (appointment.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(appointment.contactId!, includes: includes);
        appointment.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Listing? getListing(
    Appointment appointment, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (appointment.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(appointment.listingId!, includes: includes);
        appointment.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    Appointment appointment, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (appointment.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(appointment.orgId!, includes: includes);
        appointment.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Appointment appointment, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (appointment.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(appointment.propertyId!, includes: includes);
        appointment.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Appointment>> getAll$({bool useCache = true, ModelFilter<Appointment>? modelFilter, List<AppointmentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AppointmentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Appointment?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAppointmentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Appointment>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByAppointmentType$(
        String appointmentType,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentAppointmentType,
        value: appointmentType,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByAppointmentType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAppointmentStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAppointmentEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByTimezone$(
        String timezone,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentTimezone,
        value: timezone,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByTimezone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByLocation$(
        String location,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentLocation,
        value: location,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByLocation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByAssignedToUserId$(
        String assignedToUserId,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentAssignedToUserId,
        value: assignedToUserId,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByAssignedToUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByAssignedToContactId$(
        String assignedToContactId,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentAssignedToContactId,
        value: assignedToContactId,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByAssignedToContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByReminders$(
        dynamic reminders,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAppointmentReminders,
        value: reminders,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByReminders,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAppointmentCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAppointmentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAppointmentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Appointment>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Appointment>? modelFilter,
        List<AppointmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAppointmentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AppointmentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getAssignedContact$(
    Appointment appointment, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (appointment.assignedToContactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            appointment.assignedToContactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((assignedContact) {
            appointment.assignedContact = assignedContact;
        });
    }
}

	Stream<User?> getAssignedUser$(
    Appointment appointment, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (appointment.assignedToUserId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            appointment.assignedToUserId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((assignedUser) {
            appointment.assignedUser = assignedUser;
        });
    }
}

	Stream<Contact?> getContact$(
    Appointment appointment, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (appointment.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            appointment.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            appointment.contact = contact;
        });
    }
}

	Stream<Listing?> getListing$(
    Appointment appointment, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (appointment.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            appointment.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            appointment.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    Appointment appointment, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (appointment.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            appointment.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            appointment.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Appointment appointment, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (appointment.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            appointment.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            appointment.property = property;
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
Appointment recursiveUpsert(Appointment appointment, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Appointment'} 
        : const {};
    if (appointment.assignedContact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        appointment.assignedContact = ContactStore.instance.recursiveUpsert(appointment.assignedContact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (appointment.assignedUser != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        appointment.assignedUser = UserStore.instance.recursiveUpsert(appointment.assignedUser!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (appointment.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        appointment.contact = ContactStore.instance.recursiveUpsert(appointment.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (appointment.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        appointment.listing = ListingStore.instance.recursiveUpsert(appointment.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (appointment.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        appointment.org = OrganizationStore.instance.recursiveUpsert(appointment.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (appointment.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        appointment.property = PropertyStore.instance.recursiveUpsert(appointment.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(appointment);
}

  List<Appointment> recursiveListUpsert(List<Appointment> appointments, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAppointments = <Appointment>[];
    for (var appointment in appointments) {
        updatedAppointments.add(recursiveUpsert(appointment, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAppointments;
}

//   @override
//   Appointment upsert(Appointment item) {
//     return recursiveUpsert(item);
//   }

}


class AppointmentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AppointmentInclude.assignedContact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (appointment) => AppointmentStore.instance
            .getAssignedContact$(appointment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (appointment) => AppointmentStore.instance
            .getAssignedContact(appointment, modelFilter: modelFilter, includes: includes);
      }
}

	AppointmentInclude.assignedUser({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (appointment) => AppointmentStore.instance
            .getAssignedUser$(appointment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (appointment) => AppointmentStore.instance
            .getAssignedUser(appointment, modelFilter: modelFilter, includes: includes);
      }
}

	AppointmentInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (appointment) => AppointmentStore.instance
            .getContact$(appointment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (appointment) => AppointmentStore.instance
            .getContact(appointment, modelFilter: modelFilter, includes: includes);
      }
}

	AppointmentInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (appointment) => AppointmentStore.instance
            .getListing$(appointment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (appointment) => AppointmentStore.instance
            .getListing(appointment, modelFilter: modelFilter, includes: includes);
      }
}

	AppointmentInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (appointment) => AppointmentStore.instance
            .getOrg$(appointment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (appointment) => AppointmentStore.instance
            .getOrg(appointment, modelFilter: modelFilter, includes: includes);
      }
}

	AppointmentInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (appointment) => AppointmentStore.instance
            .getProperty$(appointment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (appointment) => AppointmentStore.instance
            .getProperty(appointment, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AppointmentEndpoints implements Endpoint {

    getAll('/appointment', HttpMethod.post, List<Appointment>),
	getById('/appointment/byId/:id', HttpMethod.post, Appointment),
	getManyByOrgId('/appointment/byOrgId/:orgId', HttpMethod.post, List<Appointment>),
	getManyByPropertyId('/appointment/byPropertyId/:propertyId', HttpMethod.post, List<Appointment>),
	getManyByListingId('/appointment/byListingId/:listingId', HttpMethod.post, List<Appointment>),
	getManyByContactId('/appointment/byContactId/:contactId', HttpMethod.post, List<Appointment>),
	getManyByTitle('/appointment/byTitle/:title', HttpMethod.post, List<Appointment>),
	getManyByDescription('/appointment/byDescription/:description', HttpMethod.post, List<Appointment>),
	getManyByAppointmentType('/appointment/byAppointmentType/:appointmentType', HttpMethod.post, List<Appointment>),
	getManyByStartDate('/appointment/byStartDate/:startDate', HttpMethod.post, List<Appointment>),
	getManyByEndDate('/appointment/byEndDate/:endDate', HttpMethod.post, List<Appointment>),
	getManyByTimezone('/appointment/byTimezone/:timezone', HttpMethod.post, List<Appointment>),
	getManyByStatus('/appointment/byStatus/:status', HttpMethod.post, List<Appointment>),
	getManyByLocation('/appointment/byLocation/:location', HttpMethod.post, List<Appointment>),
	getManyByAssignedToUserId('/appointment/byAssignedToUserId/:assignedToUserId', HttpMethod.post, List<Appointment>),
	getManyByAssignedToContactId('/appointment/byAssignedToContactId/:assignedToContactId', HttpMethod.post, List<Appointment>),
	getManyByReminders('/appointment/byReminders/:reminders', HttpMethod.post, List<Appointment>),
	getManyByNotes('/appointment/byNotes/:notes', HttpMethod.post, List<Appointment>),
	getManyByCreatedBy('/appointment/byCreatedBy/:createdBy', HttpMethod.post, List<Appointment>),
	getManyByCreatedAt('/appointment/byCreatedAt/:createdAt', HttpMethod.post, List<Appointment>),
	getManyByUpdatedAt('/appointment/byUpdatedAt/:updatedAt', HttpMethod.post, List<Appointment>),
	getManyByDeletedAt('/appointment/byDeletedAt/:deletedAt', HttpMethod.post, List<Appointment>);

    const AppointmentEndpoints(this.path, this.method, this.responseType);

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
