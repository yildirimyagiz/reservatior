
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class IncludedServiceStore extends ModelStreamStore<String, IncludedService> {

  static IncludedServiceStore? _instance;

  static IncludedServiceStore get instance {
    _instance ??= IncludedServiceStore();
    return _instance!;
  }

  IncludedServiceStore() : super(IncludedService.fromJson) {
    if (_instance != null) {
        throw Exception(
            'IncludedServiceStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending IncludedServiceStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use IncludedServiceStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getIncludedServiceId(IncludedService includedService) => includedService.id;

	String? getIncludedServicePropertyId(IncludedService includedService) => includedService.propertyId;

	String? getIncludedServiceName(IncludedService includedService) => includedService.name;

	String? getIncludedServiceDescription(IncludedService includedService) => includedService.description;

	double? getIncludedServiceValue(IncludedService includedService) => includedService.value;

	bool? getIncludedServiceIsRecurring(IncludedService includedService) => includedService.isRecurring;

	String? getIncludedServiceFrequency(IncludedService includedService) => includedService.frequency;

	String? getIncludedServiceIcon(IncludedService includedService) => includedService.icon;

	String? getIncludedServiceLogo(IncludedService includedService) => includedService.logo;

	DateTime? getIncludedServiceCreatedAt(IncludedService includedService) => includedService.createdAt;

	DateTime? getIncludedServiceUpdatedAt(IncludedService includedService) => includedService.updatedAt;

	DateTime? getIncludedServiceDeletedAt(IncludedService includedService) => includedService.deletedAt;

	List<FacilityAmenities>? getIncludedServiceFacilityAmenities(IncludedService includedService) => includedService.facilityAmenities;

	List<LocationAmenities>? getIncludedServiceLocationAmenities(IncludedService includedService) => includedService.locationAmenities;

	String? getIncludedServiceFacilityId(IncludedService includedService) => includedService.facilityId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<IncludedService> getByPropertyId(
    String propertyId,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServicePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByName(
    String name,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceName, name, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByDescription(
    String description,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceDescription, description, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByValue(
    double value,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceValue, value, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByIsRecurring(
    bool isRecurring,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceIsRecurring, isRecurring, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByFrequency(
    String frequency,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceFrequency, frequency, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByIcon(
    String icon,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceIcon, icon, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByLogo(
    String logo,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceLogo, logo, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByFacilityAmenities(
    FacilityAmenities facilityAmenities,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceFacilityAmenities, facilityAmenities, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByLocationAmenities(
    LocationAmenities locationAmenities,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceLocationAmenities, locationAmenities, modelFilter: modelFilter, includes: includes);

	
List<IncludedService> getByFacilityId(
    String facilityId,
    {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}
    ) =>
    getManyIncluding(getIncludedServiceFacilityId, facilityId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Facility? getFacility(
    IncludedService includedService, {ModelFilter? modelFilter, List<FacilityInclude>? includes}) {
    if (includedService.facilityId == null) {
        return null;
    } else {
        final Facility = FacilityStore.instance.getById(includedService.facilityId!, includes: includes);
        includedService.Facility = Facility;
        // setIncludedReferences(Facility, includes: includes);
        return Facility;
    }
}

	Property? getProperty(
    IncludedService includedService, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (includedService.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(includedService.propertyId!, includes: includes);
        includedService.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

  /// GET RELATED MODELS 

  List<Agency> getAgencies(
    IncludedService includedService, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getByIncludedServiceId(includedService.$uid!, modelFilter: modelFilter, includes: includes);
    includedService.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Expense> getExpenses(
    IncludedService includedService, {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    final expenses = ExpenseStore.instance.getByIncludedServiceId(includedService.$uid!, modelFilter: modelFilter, includes: includes);
    includedService.expenses = expenses;
    // setIncludedReferencesForList(expenses, includes: includes);
    return expenses;
}

	List<ExtraCharge> getExtraCharges(
    IncludedService includedService, {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    final extraCharges = ExtraChargeStore.instance.getByIncludedServiceId(includedService.$uid!, modelFilter: modelFilter, includes: includes);
    includedService.extraCharges = extraCharges;
    // setIncludedReferencesForList(extraCharges, includes: includes);
    return extraCharges;
}

	List<Payment> getPayment(
    IncludedService includedService, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final Payment = PaymentStore.instance.getByIncludedServiceId(includedService.$uid!, modelFilter: modelFilter, includes: includes);
    includedService.Payment = Payment;
    // setIncludedReferencesForList(Payment, includes: includes);
    return Payment;
}

	List<Property> getProperties(
    IncludedService includedService, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final properties = PropertyStore.instance.getBy(includedService.$uid!, modelFilter: modelFilter, includes: includes);
    includedService.properties = properties;
    // setIncludedReferencesForList(properties, includes: includes);
    return properties;
}

	List<Report> getReports(
    IncludedService includedService, {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final reports = ReportStore.instance.getBy(includedService.$uid!, modelFilter: modelFilter, includes: includes);
    includedService.reports = reports;
    // setIncludedReferencesForList(reports, includes: includes);
    return reports;
}

	List<Task> getTasks(
    IncludedService includedService, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getBy(includedService.$uid!, modelFilter: modelFilter, includes: includes);
    includedService.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<User> getUsers(
    IncludedService includedService, {ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    final users = UserStore.instance.getBy(includedService.$uid!, modelFilter: modelFilter, includes: includes);
    includedService.users = users;
    // setIncludedReferencesForList(users, includes: includes);
    return users;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<IncludedService>> getAll$({bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: IncludedServiceEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<IncludedService?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getIncludedServiceId,
        value: id,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<IncludedService>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncludedServicePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncludedServiceName,
        value: name,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncludedServiceDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByValue$(
        double value,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getIncludedServiceValue,
        value: value,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByIsRecurring$(
        bool isRecurring,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getIncludedServiceIsRecurring,
        value: isRecurring,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByIsRecurring,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByFrequency$(
        String frequency,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncludedServiceFrequency,
        value: frequency,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByFrequency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByIcon$(
        String icon,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncludedServiceIcon,
        value: icon,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByIcon,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByLogo$(
        String logo,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncludedServiceLogo,
        value: logo,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByLogo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getIncludedServiceCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getIncludedServiceUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getIncludedServiceDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByFacilityAmenities$(
        FacilityAmenities facilityAmenities,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<FacilityAmenities>(
        getPropVal: getIncludedServiceFacilityAmenities,
        value: facilityAmenities,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByFacilityAmenities,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByLocationAmenities$(
        LocationAmenities locationAmenities,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<LocationAmenities>(
        getPropVal: getIncludedServiceLocationAmenities,
        value: locationAmenities,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByLocationAmenities,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IncludedService>> getByFacilityId$(
        String facilityId,
        {bool useCache = true,
        ModelFilter<IncludedService>? modelFilter,
        List<IncludedServiceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncludedServiceFacilityId,
        value: facilityId,
        modelFilter: modelFilter,
        endpoint: IncludedServiceEndpoints.getManyByFacilityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Facility?> getFacility$(
    IncludedService includedService, {bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    if (includedService.facilityId == null) {
        return Stream.value(null);
    } else {
        return FacilityStore.instance.getById$(
            includedService.facilityId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Facility) {
            includedService.Facility = Facility;
        });
    }
}

	Stream<Property?> getProperty$(
    IncludedService includedService, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (includedService.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            includedService.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            includedService.Property = Property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Agency>> getAgencies$(
    IncludedService includedService, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getByIncludedServiceId$(
        includedService.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        includedService.agencies = agencies;
    });

}

	Stream<List<Expense>> getExpenses$(
    IncludedService includedService, {bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    return ExpenseStore.instance.getByIncludedServiceId$(
        includedService.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((expenses) {
        includedService.expenses = expenses;
    });

}

	Stream<List<ExtraCharge>> getExtraCharges$(
    IncludedService includedService, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    return ExtraChargeStore.instance.getByIncludedServiceId$(
        includedService.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((extraCharges) {
        includedService.extraCharges = extraCharges;
    });

}

	Stream<List<Payment>> getPayment$(
    IncludedService includedService, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByIncludedServiceId$(
        includedService.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Payment) {
        includedService.Payment = Payment;
    });

}

	Stream<List<Property>> getProperties$(
    IncludedService includedService, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getBy$(
        includedService.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((properties) {
        includedService.properties = properties;
    });

}

	Stream<List<Report>> getReports$(
    IncludedService includedService, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    return ReportStore.instance.getBy$(
        includedService.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reports) {
        includedService.reports = reports;
    });

}

	Stream<List<Task>> getTasks$(
    IncludedService includedService, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getBy$(
        includedService.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        includedService.tasks = tasks;
    });

}

	Stream<List<User>> getUsers$(
    IncludedService includedService, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    return UserStore.instance.getBy$(
        includedService.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((users) {
        includedService.users = users;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
IncludedService recursiveUpsert(IncludedService includedService, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'IncludedService'} 
        : const {};
    if (includedService.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        includedService.agencies = AgencyStore.instance.recursiveListUpsert(includedService.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.expenses != null && (!preventCircularSerialization || !upsertedTypes.contains('Expense'))) {
        includedService.expenses = ExpenseStore.instance.recursiveListUpsert(includedService.expenses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.extraCharges != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        includedService.extraCharges = ExtraChargeStore.instance.recursiveListUpsert(includedService.extraCharges!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.Facility != null && (!preventCircularSerialization || !upsertedTypes.contains('Facility'))) {
        includedService.Facility = FacilityStore.instance.recursiveUpsert(includedService.Facility!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.Payment != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        includedService.Payment = PaymentStore.instance.recursiveListUpsert(includedService.Payment!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.properties != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        includedService.properties = PropertyStore.instance.recursiveListUpsert(includedService.properties!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.reports != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        includedService.reports = ReportStore.instance.recursiveListUpsert(includedService.reports!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        includedService.tasks = TaskStore.instance.recursiveListUpsert(includedService.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.users != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        includedService.users = UserStore.instance.recursiveListUpsert(includedService.users!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (includedService.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        includedService.Property = PropertyStore.instance.recursiveUpsert(includedService.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(includedService);
}

  List<IncludedService> recursiveListUpsert(List<IncludedService> includedServices, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedIncludedServices = <IncludedService>[];
    for (var includedService in includedServices) {
        updatedIncludedServices.add(recursiveUpsert(includedService, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedIncludedServices;
}

//   @override
//   IncludedService upsert(IncludedService item) {
//     return recursiveUpsert(item);
//   }

}


class IncludedServiceInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      IncludedServiceInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getAgencies$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getAgencies(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.expenses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Expense>? modelFilter,
    List<ExpenseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getExpenses$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getExpenses(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.extraCharges({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getExtraCharges$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getExtraCharges(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.Facility({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Facility>? modelFilter,
    List<FacilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getFacility$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getFacility(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.Payment({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getPayment$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getPayment(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.properties({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getProperties$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getProperties(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.reports({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getReports$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getReports(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getTasks$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getTasks(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.users({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getUsers$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getUsers(includedService, modelFilter: modelFilter, includes: includes);
      }
}

	IncludedServiceInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (includedService) => IncludedServiceStore.instance
            .getProperty$(includedService, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (includedService) => IncludedServiceStore.instance
            .getProperty(includedService, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum IncludedServiceEndpoints implements Endpoint {

    getAll('/includedService', HttpMethod.post, List<IncludedService>),
	getById('/includedService/byId/:id', HttpMethod.post, IncludedService),
	getManyByPropertyId('/includedService/byPropertyId/:propertyId', HttpMethod.post, List<IncludedService>),
	getManyByName('/includedService/byName/:name', HttpMethod.post, List<IncludedService>),
	getManyByDescription('/includedService/byDescription/:description', HttpMethod.post, List<IncludedService>),
	getManyByValue('/includedService/byValue/:value', HttpMethod.post, List<IncludedService>),
	getManyByIsRecurring('/includedService/byIsRecurring/:isRecurring', HttpMethod.post, List<IncludedService>),
	getManyByFrequency('/includedService/byFrequency/:frequency', HttpMethod.post, List<IncludedService>),
	getManyByIcon('/includedService/byIcon/:icon', HttpMethod.post, List<IncludedService>),
	getManyByLogo('/includedService/byLogo/:logo', HttpMethod.post, List<IncludedService>),
	getManyByCreatedAt('/includedService/byCreatedAt/:createdAt', HttpMethod.post, List<IncludedService>),
	getManyByUpdatedAt('/includedService/byUpdatedAt/:updatedAt', HttpMethod.post, List<IncludedService>),
	getManyByDeletedAt('/includedService/byDeletedAt/:deletedAt', HttpMethod.post, List<IncludedService>),
	getManyByFacilityAmenities('/includedService/byFacilityAmenities/:facilityAmenities', HttpMethod.post, List<IncludedService>),
	getManyByLocationAmenities('/includedService/byLocationAmenities/:locationAmenities', HttpMethod.post, List<IncludedService>),
	getManyByFacilityId('/includedService/byFacilityId/:facilityId', HttpMethod.post, List<IncludedService>);

    const IncludedServiceEndpoints(this.path, this.method, this.responseType);

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
