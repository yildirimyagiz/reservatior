
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ExtraChargeStore extends ModelStreamStore<String, ExtraCharge> {

  static ExtraChargeStore? _instance;

  static ExtraChargeStore get instance {
    _instance ??= ExtraChargeStore();
    return _instance!;
  }

  ExtraChargeStore() : super(ExtraCharge.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ExtraChargeStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ExtraChargeStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ExtraChargeStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getExtraChargeId(ExtraCharge extraCharge) => extraCharge.id;

	String? getExtraChargeReservationId(ExtraCharge extraCharge) => extraCharge.reservationId;

	String? getExtraChargeName(ExtraCharge extraCharge) => extraCharge.name;

	String? getExtraChargeDescription(ExtraCharge extraCharge) => extraCharge.description;

	double? getExtraChargeAmount(ExtraCharge extraCharge) => extraCharge.amount;

	String? getExtraChargeChargeType(ExtraCharge extraCharge) => extraCharge.chargeType;

	bool? getExtraChargeIsPaid(ExtraCharge extraCharge) => extraCharge.isPaid;

	String? getExtraChargeIcon(ExtraCharge extraCharge) => extraCharge.icon;

	String? getExtraChargeLogo(ExtraCharge extraCharge) => extraCharge.logo;

	DateTime? getExtraChargeCreatedAt(ExtraCharge extraCharge) => extraCharge.createdAt;

	DateTime? getExtraChargeUpdatedAt(ExtraCharge extraCharge) => extraCharge.updatedAt;

	DateTime? getExtraChargeDeletedAt(ExtraCharge extraCharge) => extraCharge.deletedAt;

	List<FacilityAmenities>? getExtraChargeFacilityAmenities(ExtraCharge extraCharge) => extraCharge.facilityAmenities;

	List<LocationAmenities>? getExtraChargeLocationAmenities(ExtraCharge extraCharge) => extraCharge.locationAmenities;

	String? getExtraChargeFacilityId(ExtraCharge extraCharge) => extraCharge.facilityId;

	String? getExtraChargeIncludedServiceId(ExtraCharge extraCharge) => extraCharge.includedServiceId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ExtraCharge> getByReservationId(
    String reservationId,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByName(
    String name,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeName, name, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByDescription(
    String description,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeDescription, description, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByAmount(
    double amount,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByChargeType(
    String chargeType,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeChargeType, chargeType, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByIsPaid(
    bool isPaid,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeIsPaid, isPaid, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByIcon(
    String icon,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeIcon, icon, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByLogo(
    String logo,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeLogo, logo, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByFacilityAmenities(
    FacilityAmenities facilityAmenities,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeFacilityAmenities, facilityAmenities, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByLocationAmenities(
    LocationAmenities locationAmenities,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeLocationAmenities, locationAmenities, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByFacilityId(
    String facilityId,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeFacilityId, facilityId, modelFilter: modelFilter, includes: includes);

	
List<ExtraCharge> getByIncludedServiceId(
    String includedServiceId,
    {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}
    ) =>
    getManyIncluding(getExtraChargeIncludedServiceId, includedServiceId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Facility? getFacility(
    ExtraCharge extraCharge, {ModelFilter? modelFilter, List<FacilityInclude>? includes}) {
    if (extraCharge.facilityId == null) {
        return null;
    } else {
        final Facility = FacilityStore.instance.getById(extraCharge.facilityId!, includes: includes);
        extraCharge.Facility = Facility;
        // setIncludedReferences(Facility, includes: includes);
        return Facility;
    }
}

	IncludedService? getIncludedService(
    ExtraCharge extraCharge, {ModelFilter? modelFilter, List<IncludedServiceInclude>? includes}) {
    if (extraCharge.includedServiceId == null) {
        return null;
    } else {
        final IncludedService = IncludedServiceStore.instance.getById(extraCharge.includedServiceId!, includes: includes);
        extraCharge.IncludedService = IncludedService;
        // setIncludedReferences(IncludedService, includes: includes);
        return IncludedService;
    }
}

	Reservation? getReservation(
    ExtraCharge extraCharge, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (extraCharge.reservationId == null) {
        return null;
    } else {
        final Reservation = ReservationStore.instance.getById(extraCharge.reservationId!, includes: includes);
        extraCharge.Reservation = Reservation;
        // setIncludedReferences(Reservation, includes: includes);
        return Reservation;
    }
}

  /// GET RELATED MODELS 

  List<Agency> getAgencies(
    ExtraCharge extraCharge, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getByExtraChargeId(extraCharge.$uid!, modelFilter: modelFilter, includes: includes);
    extraCharge.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Expense> getExpenses(
    ExtraCharge extraCharge, {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    final expenses = ExpenseStore.instance.getByExtraChargeId(extraCharge.$uid!, modelFilter: modelFilter, includes: includes);
    extraCharge.expenses = expenses;
    // setIncludedReferencesForList(expenses, includes: includes);
    return expenses;
}

	List<Payment> getPayment(
    ExtraCharge extraCharge, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final Payment = PaymentStore.instance.getByExtraChargeId(extraCharge.$uid!, modelFilter: modelFilter, includes: includes);
    extraCharge.Payment = Payment;
    // setIncludedReferencesForList(Payment, includes: includes);
    return Payment;
}

	List<Property> getProperties(
    ExtraCharge extraCharge, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final properties = PropertyStore.instance.getBy(extraCharge.$uid!, modelFilter: modelFilter, includes: includes);
    extraCharge.properties = properties;
    // setIncludedReferencesForList(properties, includes: includes);
    return properties;
}

	List<Report> getReports(
    ExtraCharge extraCharge, {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final reports = ReportStore.instance.getBy(extraCharge.$uid!, modelFilter: modelFilter, includes: includes);
    extraCharge.reports = reports;
    // setIncludedReferencesForList(reports, includes: includes);
    return reports;
}

	List<Task> getTasks(
    ExtraCharge extraCharge, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getBy(extraCharge.$uid!, modelFilter: modelFilter, includes: includes);
    extraCharge.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<User> getUsers(
    ExtraCharge extraCharge, {ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    final users = UserStore.instance.getBy(extraCharge.$uid!, modelFilter: modelFilter, includes: includes);
    extraCharge.users = users;
    // setIncludedReferencesForList(users, includes: includes);
    return users;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ExtraCharge>> getAll$({bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ExtraChargeEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ExtraCharge?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getExtraChargeId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ExtraCharge>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExtraChargeReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExtraChargeName,
        value: name,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExtraChargeDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExtraChargeAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByChargeType$(
        String chargeType,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExtraChargeChargeType,
        value: chargeType,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByChargeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByIsPaid$(
        bool isPaid,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getExtraChargeIsPaid,
        value: isPaid,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByIsPaid,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByIcon$(
        String icon,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExtraChargeIcon,
        value: icon,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByIcon,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByLogo$(
        String logo,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExtraChargeLogo,
        value: logo,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByLogo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExtraChargeCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExtraChargeUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExtraChargeDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByFacilityAmenities$(
        FacilityAmenities facilityAmenities,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<FacilityAmenities>(
        getPropVal: getExtraChargeFacilityAmenities,
        value: facilityAmenities,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByFacilityAmenities,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByLocationAmenities$(
        LocationAmenities locationAmenities,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<LocationAmenities>(
        getPropVal: getExtraChargeLocationAmenities,
        value: locationAmenities,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByLocationAmenities,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByFacilityId$(
        String facilityId,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExtraChargeFacilityId,
        value: facilityId,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByFacilityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExtraCharge>> getByIncludedServiceId$(
        String includedServiceId,
        {bool useCache = true,
        ModelFilter<ExtraCharge>? modelFilter,
        List<ExtraChargeInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExtraChargeIncludedServiceId,
        value: includedServiceId,
        modelFilter: modelFilter,
        endpoint: ExtraChargeEndpoints.getManyByIncludedServiceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Facility?> getFacility$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    if (extraCharge.facilityId == null) {
        return Stream.value(null);
    } else {
        return FacilityStore.instance.getById$(
            extraCharge.facilityId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Facility) {
            extraCharge.Facility = Facility;
        });
    }
}

	Stream<IncludedService?> getIncludedService$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    if (extraCharge.includedServiceId == null) {
        return Stream.value(null);
    } else {
        return IncludedServiceStore.instance.getById$(
            extraCharge.includedServiceId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((IncludedService) {
            extraCharge.IncludedService = IncludedService;
        });
    }
}

	Stream<Reservation?> getReservation$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (extraCharge.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            extraCharge.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Reservation) {
            extraCharge.Reservation = Reservation;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Agency>> getAgencies$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getByExtraChargeId$(
        extraCharge.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        extraCharge.agencies = agencies;
    });

}

	Stream<List<Expense>> getExpenses$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    return ExpenseStore.instance.getByExtraChargeId$(
        extraCharge.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((expenses) {
        extraCharge.expenses = expenses;
    });

}

	Stream<List<Payment>> getPayment$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByExtraChargeId$(
        extraCharge.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Payment) {
        extraCharge.Payment = Payment;
    });

}

	Stream<List<Property>> getProperties$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getBy$(
        extraCharge.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((properties) {
        extraCharge.properties = properties;
    });

}

	Stream<List<Report>> getReports$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    return ReportStore.instance.getBy$(
        extraCharge.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reports) {
        extraCharge.reports = reports;
    });

}

	Stream<List<Task>> getTasks$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getBy$(
        extraCharge.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        extraCharge.tasks = tasks;
    });

}

	Stream<List<User>> getUsers$(
    ExtraCharge extraCharge, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    return UserStore.instance.getBy$(
        extraCharge.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((users) {
        extraCharge.users = users;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
ExtraCharge recursiveUpsert(ExtraCharge extraCharge, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ExtraCharge'} 
        : const {};
    if (extraCharge.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        extraCharge.agencies = AgencyStore.instance.recursiveListUpsert(extraCharge.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.expenses != null && (!preventCircularSerialization || !upsertedTypes.contains('Expense'))) {
        extraCharge.expenses = ExpenseStore.instance.recursiveListUpsert(extraCharge.expenses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.Facility != null && (!preventCircularSerialization || !upsertedTypes.contains('Facility'))) {
        extraCharge.Facility = FacilityStore.instance.recursiveUpsert(extraCharge.Facility!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.IncludedService != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        extraCharge.IncludedService = IncludedServiceStore.instance.recursiveUpsert(extraCharge.IncludedService!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.Payment != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        extraCharge.Payment = PaymentStore.instance.recursiveListUpsert(extraCharge.Payment!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.properties != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        extraCharge.properties = PropertyStore.instance.recursiveListUpsert(extraCharge.properties!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.reports != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        extraCharge.reports = ReportStore.instance.recursiveListUpsert(extraCharge.reports!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        extraCharge.tasks = TaskStore.instance.recursiveListUpsert(extraCharge.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.users != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        extraCharge.users = UserStore.instance.recursiveListUpsert(extraCharge.users!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (extraCharge.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        extraCharge.Reservation = ReservationStore.instance.recursiveUpsert(extraCharge.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(extraCharge);
}

  List<ExtraCharge> recursiveListUpsert(List<ExtraCharge> extraCharges, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedExtraCharges = <ExtraCharge>[];
    for (var extraCharge in extraCharges) {
        updatedExtraCharges.add(recursiveUpsert(extraCharge, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedExtraCharges;
}

//   @override
//   ExtraCharge upsert(ExtraCharge item) {
//     return recursiveUpsert(item);
//   }

}


class ExtraChargeInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ExtraChargeInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getAgencies$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getAgencies(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.expenses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Expense>? modelFilter,
    List<ExpenseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getExpenses$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getExpenses(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.Facility({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Facility>? modelFilter,
    List<FacilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getFacility$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getFacility(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.IncludedService({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getIncludedService$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getIncludedService(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.Payment({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getPayment$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getPayment(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.properties({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getProperties$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getProperties(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.reports({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getReports$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getReports(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getTasks$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getTasks(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.users({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getUsers$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getUsers(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}

	ExtraChargeInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (extraCharge) => ExtraChargeStore.instance
            .getReservation$(extraCharge, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (extraCharge) => ExtraChargeStore.instance
            .getReservation(extraCharge, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ExtraChargeEndpoints implements Endpoint {

    getAll('/extraCharge', HttpMethod.post, List<ExtraCharge>),
	getById('/extraCharge/byId/:id', HttpMethod.post, ExtraCharge),
	getManyByReservationId('/extraCharge/byReservationId/:reservationId', HttpMethod.post, List<ExtraCharge>),
	getManyByName('/extraCharge/byName/:name', HttpMethod.post, List<ExtraCharge>),
	getManyByDescription('/extraCharge/byDescription/:description', HttpMethod.post, List<ExtraCharge>),
	getManyByAmount('/extraCharge/byAmount/:amount', HttpMethod.post, List<ExtraCharge>),
	getManyByChargeType('/extraCharge/byChargeType/:chargeType', HttpMethod.post, List<ExtraCharge>),
	getManyByIsPaid('/extraCharge/byIsPaid/:isPaid', HttpMethod.post, List<ExtraCharge>),
	getManyByIcon('/extraCharge/byIcon/:icon', HttpMethod.post, List<ExtraCharge>),
	getManyByLogo('/extraCharge/byLogo/:logo', HttpMethod.post, List<ExtraCharge>),
	getManyByCreatedAt('/extraCharge/byCreatedAt/:createdAt', HttpMethod.post, List<ExtraCharge>),
	getManyByUpdatedAt('/extraCharge/byUpdatedAt/:updatedAt', HttpMethod.post, List<ExtraCharge>),
	getManyByDeletedAt('/extraCharge/byDeletedAt/:deletedAt', HttpMethod.post, List<ExtraCharge>),
	getManyByFacilityAmenities('/extraCharge/byFacilityAmenities/:facilityAmenities', HttpMethod.post, List<ExtraCharge>),
	getManyByLocationAmenities('/extraCharge/byLocationAmenities/:locationAmenities', HttpMethod.post, List<ExtraCharge>),
	getManyByFacilityId('/extraCharge/byFacilityId/:facilityId', HttpMethod.post, List<ExtraCharge>),
	getManyByIncludedServiceId('/extraCharge/byIncludedServiceId/:includedServiceId', HttpMethod.post, List<ExtraCharge>);

    const ExtraChargeEndpoints(this.path, this.method, this.responseType);

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
