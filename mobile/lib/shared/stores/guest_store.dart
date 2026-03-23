
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class GuestStore extends ModelStreamStore<String, Guest> {

  static GuestStore? _instance;

  static GuestStore get instance {
    _instance ??= GuestStore();
    return _instance!;
  }

  GuestStore() : super(Guest.fromJson) {
    if (_instance != null) {
        throw Exception(
            'GuestStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending GuestStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use GuestStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getGuestId(Guest guest) => guest.id;

	String? getGuestName(Guest guest) => guest.name;

	String? getGuestPhone(Guest guest) => guest.phone;

	String? getGuestImage(Guest guest) => guest.image;

	String? getGuestNationality(Guest guest) => guest.nationality;

	String? getGuestPassportNumber(Guest guest) => guest.passportNumber;

	Gender? getGuestGender(Guest guest) => guest.gender;

	DateTime? getGuestBirthDate(Guest guest) => guest.birthDate;

	String? getGuestAddress(Guest guest) => guest.address;

	String? getGuestCity(Guest guest) => guest.city;

	String? getGuestCountry(Guest guest) => guest.country;

	String? getGuestZipCode(Guest guest) => guest.zipCode;

	String? getGuestEmail(Guest guest) => guest.email;

	String? getGuestAgencyId(Guest guest) => guest.agencyId;

	DateTime? getGuestCreatedAt(Guest guest) => guest.createdAt;

	DateTime? getGuestUpdatedAt(Guest guest) => guest.updatedAt;

	DateTime? getGuestDeletedAt(Guest guest) => guest.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Guest> getByName(
    String name,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestName, name, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByPhone(
    String phone,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestPhone, phone, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByImage(
    String image,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestImage, image, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByNationality(
    String nationality,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestNationality, nationality, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByPassportNumber(
    String passportNumber,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestPassportNumber, passportNumber, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByGender(
    Gender gender,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestGender, gender, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByBirthDate(
    DateTime birthDate,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestBirthDate, birthDate, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByAddress(
    String address,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestAddress, address, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByCity(
    String city,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestCity, city, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByCountry(
    String country,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestCountry, country, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByZipCode(
    String zipCode,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestZipCode, zipCode, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByEmail(
    String email,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestEmail, email, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByAgencyId(
    String agencyId,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Guest> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}
    ) =>
    getManyIncluding(getGuestDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Guest guest, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (guest.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(guest.agencyId!, includes: includes);
        guest.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

  /// GET RELATED MODELS 

  List<Property> getProperty(
    Guest guest, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final Property = PropertyStore.instance.getBy(guest.$uid!, modelFilter: modelFilter, includes: includes);
    guest.Property = Property;
    // setIncludedReferencesForList(Property, includes: includes);
    return Property;
}

	List<Reservation> getReservation(
    Guest guest, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final Reservation = ReservationStore.instance.getBy(guest.$uid!, modelFilter: modelFilter, includes: includes);
    guest.Reservation = Reservation;
    // setIncludedReferencesForList(Reservation, includes: includes);
    return Reservation;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Guest>> getAll$({bool useCache = true, ModelFilter<Guest>? modelFilter, List<GuestInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: GuestEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Guest?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getGuestId,
        value: id,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Guest>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestName,
        value: name,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByPhone$(
        String phone,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestPhone,
        value: phone,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByPhone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByImage$(
        String image,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestImage,
        value: image,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByImage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByNationality$(
        String nationality,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestNationality,
        value: nationality,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByNationality,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByPassportNumber$(
        String passportNumber,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestPassportNumber,
        value: passportNumber,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByPassportNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByGender$(
        Gender gender,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<Gender>(
        getPropVal: getGuestGender,
        value: gender,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByGender,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByBirthDate$(
        DateTime birthDate,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGuestBirthDate,
        value: birthDate,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByBirthDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByAddress$(
        String address,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestAddress,
        value: address,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByCity$(
        String city,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestCity,
        value: city,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByCity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByCountry$(
        String country,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestCountry,
        value: country,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByCountry,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByZipCode$(
        String zipCode,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestZipCode,
        value: zipCode,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByZipCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByEmail$(
        String email,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestEmail,
        value: email,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGuestAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGuestCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGuestUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Guest>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Guest>? modelFilter,
        List<GuestInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGuestDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: GuestEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Guest guest, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (guest.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            guest.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            guest.Agency = Agency;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Property>> getProperty$(
    Guest guest, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getBy$(
        guest.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Property) {
        guest.Property = Property;
    });

}

	Stream<List<Reservation>> getReservation$(
    Guest guest, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getBy$(
        guest.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Reservation) {
        guest.Reservation = Reservation;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Guest recursiveUpsert(Guest guest, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Guest'} 
        : const {};
    if (guest.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        guest.Agency = AgencyStore.instance.recursiveUpsert(guest.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (guest.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        guest.Property = PropertyStore.instance.recursiveListUpsert(guest.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (guest.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        guest.Reservation = ReservationStore.instance.recursiveListUpsert(guest.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(guest);
}

  List<Guest> recursiveListUpsert(List<Guest> guests, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedGuests = <Guest>[];
    for (var guest in guests) {
        updatedGuests.add(recursiveUpsert(guest, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedGuests;
}

//   @override
//   Guest upsert(Guest item) {
//     return recursiveUpsert(item);
//   }

}


class GuestInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      GuestInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (guest) => GuestStore.instance
            .getAgency$(guest, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (guest) => GuestStore.instance
            .getAgency(guest, modelFilter: modelFilter, includes: includes);
      }
}

	GuestInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (guest) => GuestStore.instance
            .getProperty$(guest, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (guest) => GuestStore.instance
            .getProperty(guest, modelFilter: modelFilter, includes: includes);
      }
}

	GuestInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (guest) => GuestStore.instance
            .getReservation$(guest, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (guest) => GuestStore.instance
            .getReservation(guest, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum GuestEndpoints implements Endpoint {

    getAll('/guest', HttpMethod.post, List<Guest>),
	getById('/guest/byId/:id', HttpMethod.post, Guest),
	getManyByName('/guest/byName/:name', HttpMethod.post, List<Guest>),
	getManyByPhone('/guest/byPhone/:phone', HttpMethod.post, List<Guest>),
	getManyByImage('/guest/byImage/:image', HttpMethod.post, List<Guest>),
	getManyByNationality('/guest/byNationality/:nationality', HttpMethod.post, List<Guest>),
	getManyByPassportNumber('/guest/byPassportNumber/:passportNumber', HttpMethod.post, List<Guest>),
	getManyByGender('/guest/byGender/:gender', HttpMethod.post, List<Guest>),
	getManyByBirthDate('/guest/byBirthDate/:birthDate', HttpMethod.post, List<Guest>),
	getManyByAddress('/guest/byAddress/:address', HttpMethod.post, List<Guest>),
	getManyByCity('/guest/byCity/:city', HttpMethod.post, List<Guest>),
	getManyByCountry('/guest/byCountry/:country', HttpMethod.post, List<Guest>),
	getManyByZipCode('/guest/byZipCode/:zipCode', HttpMethod.post, List<Guest>),
	getManyByEmail('/guest/byEmail/:email', HttpMethod.post, List<Guest>),
	getManyByAgencyId('/guest/byAgencyId/:agencyId', HttpMethod.post, List<Guest>),
	getManyByCreatedAt('/guest/byCreatedAt/:createdAt', HttpMethod.post, List<Guest>),
	getManyByUpdatedAt('/guest/byUpdatedAt/:updatedAt', HttpMethod.post, List<Guest>),
	getManyByDeletedAt('/guest/byDeletedAt/:deletedAt', HttpMethod.post, List<Guest>);

    const GuestEndpoints(this.path, this.method, this.responseType);

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
