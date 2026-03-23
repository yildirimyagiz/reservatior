
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class TenantStore extends ModelStreamStore<String, Tenant> {

  static TenantStore? _instance;

  static TenantStore get instance {
    _instance ??= TenantStore();
    return _instance!;
  }

  TenantStore() : super(Tenant.fromJson) {
    if (_instance != null) {
        throw Exception(
            'TenantStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending TenantStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use TenantStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getTenantId(Tenant tenant) => tenant.id;

	String? getTenantUserId(Tenant tenant) => tenant.userId;

	String? getTenantFirstName(Tenant tenant) => tenant.firstName;

	String? getTenantLastName(Tenant tenant) => tenant.lastName;

	String? getTenantEmail(Tenant tenant) => tenant.email;

	String? getTenantPhoneNumber(Tenant tenant) => tenant.phoneNumber;

	DateTime? getTenantLeaseStartDate(Tenant tenant) => tenant.leaseStartDate;

	DateTime? getTenantLeaseEndDate(Tenant tenant) => tenant.leaseEndDate;

	PaymentStatus? getTenantPaymentStatus(Tenant tenant) => tenant.paymentStatus;

	DateTime? getTenantCreatedAt(Tenant tenant) => tenant.createdAt;

	DateTime? getTenantUpdatedAt(Tenant tenant) => tenant.updatedAt;

	DateTime? getTenantDeletedAt(Tenant tenant) => tenant.deletedAt;

	String? getTenantPropertyId(Tenant tenant) => tenant.propertyId;

	bool? getTenantIsActive(Tenant tenant) => tenant.isActive;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Tenant? getByUserId(
    String userId,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getIncluding(getTenantUserId, userId, modelFilter: modelFilter, includes: includes);

	
Tenant? getByEmail(
    String email,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getIncluding(getTenantEmail, email, modelFilter: modelFilter, includes: includes);

  
List<Tenant> getByFirstName(
    String firstName,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantFirstName, firstName, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByLastName(
    String lastName,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantLastName, lastName, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByPhoneNumber(
    String phoneNumber,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantPhoneNumber, phoneNumber, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByLeaseStartDate(
    DateTime leaseStartDate,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantLeaseStartDate, leaseStartDate, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByLeaseEndDate(
    DateTime leaseEndDate,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantLeaseEndDate, leaseEndDate, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByPaymentStatus(
    PaymentStatus paymentStatus,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantPaymentStatus, paymentStatus, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByPropertyId(
    String propertyId,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Tenant> getByIsActive(
    bool isActive,
    {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}
    ) =>
    getManyIncluding(getTenantIsActive, isActive, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Property? getProperty(
    Tenant tenant, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (tenant.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(tenant.propertyId!, includes: includes);
        tenant.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	User? getUser(
    Tenant tenant, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (tenant.userId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(tenant.userId!, includes: includes);
        tenant.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  List<Contract> getContract(
    Tenant tenant, {ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    final Contract = ContractStore.instance.getBy(tenant.$uid!, modelFilter: modelFilter, includes: includes);
    tenant.Contract = Contract;
    // setIncludedReferencesForList(Contract, includes: includes);
    return Contract;
}

	List<Expense> getExpense(
    Tenant tenant, {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    final Expense = ExpenseStore.instance.getByTenantId(tenant.$uid!, modelFilter: modelFilter, includes: includes);
    tenant.Expense = Expense;
    // setIncludedReferencesForList(Expense, includes: includes);
    return Expense;
}

	List<Increase> getIncrease(
    Tenant tenant, {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}) {
    final Increase = IncreaseStore.instance.getByTenantId(tenant.$uid!, modelFilter: modelFilter, includes: includes);
    tenant.Increase = Increase;
    // setIncludedReferencesForList(Increase, includes: includes);
    return Increase;
}

	List<Notification> getNotification(
    Tenant tenant, {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    final Notification = NotificationStore.instance.getBy(tenant.$uid!, modelFilter: modelFilter, includes: includes);
    tenant.Notification = Notification;
    // setIncludedReferencesForList(Notification, includes: includes);
    return Notification;
}

	List<Payment> getPayment(
    Tenant tenant, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final Payment = PaymentStore.instance.getByTenantId(tenant.$uid!, modelFilter: modelFilter, includes: includes);
    tenant.Payment = Payment;
    // setIncludedReferencesForList(Payment, includes: includes);
    return Payment;
}

	List<Report> getReport(
    Tenant tenant, {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final Report = ReportStore.instance.getBy(tenant.$uid!, modelFilter: modelFilter, includes: includes);
    tenant.Report = Report;
    // setIncludedReferencesForList(Report, includes: includes);
    return Report;
}

	List<Lease> getLease(
    Tenant tenant, {ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    final Lease = LeaseStore.instance.getByTenantId(tenant.$uid!, modelFilter: modelFilter, includes: includes);
    tenant.Lease = Lease;
    // setIncludedReferencesForList(Lease, includes: includes);
    return Lease;
}

	List<MaintenanceWorkOrder> getMaintenanceWorkOrder(
    Tenant tenant, {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    final MaintenanceWorkOrder = MaintenanceWorkOrderStore.instance.getByTenantId(tenant.$uid!, modelFilter: modelFilter, includes: includes);
    tenant.MaintenanceWorkOrder = MaintenanceWorkOrder;
    // setIncludedReferencesForList(MaintenanceWorkOrder, includes: includes);
    return MaintenanceWorkOrder;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Tenant>> getAll$({bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: TenantEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Tenant?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTenantId,
        value: id,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Tenant?> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTenantUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Tenant?> getByEmail$(
        String email,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTenantEmail,
        value: email,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getByEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Tenant>> getByFirstName$(
        String firstName,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantFirstName,
        value: firstName,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByFirstName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByLastName$(
        String lastName,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantLastName,
        value: lastName,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByLastName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByPhoneNumber$(
        String phoneNumber,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantPhoneNumber,
        value: phoneNumber,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByPhoneNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByLeaseStartDate$(
        DateTime leaseStartDate,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTenantLeaseStartDate,
        value: leaseStartDate,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByLeaseStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByLeaseEndDate$(
        DateTime leaseEndDate,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTenantLeaseEndDate,
        value: leaseEndDate,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByLeaseEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByPaymentStatus$(
        PaymentStatus paymentStatus,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentStatus>(
        getPropVal: getTenantPaymentStatus,
        value: paymentStatus,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByPaymentStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTenantCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTenantUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTenantDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tenant>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Tenant>? modelFilter,
        List<TenantInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getTenantIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: TenantEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Property?> getProperty$(
    Tenant tenant, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (tenant.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            tenant.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            tenant.Property = Property;
        });
    }
}

	Stream<User?> getUser$(
    Tenant tenant, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (tenant.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            tenant.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            tenant.User = User;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Contract>> getContract$(
    Tenant tenant, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    return ContractStore.instance.getBy$(
        tenant.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Contract) {
        tenant.Contract = Contract;
    });

}

	Stream<List<Expense>> getExpense$(
    Tenant tenant, {bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    return ExpenseStore.instance.getByTenantId$(
        tenant.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Expense) {
        tenant.Expense = Expense;
    });

}

	Stream<List<Increase>> getIncrease$(
    Tenant tenant, {bool useCache = true, ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}) {
    return IncreaseStore.instance.getByTenantId$(
        tenant.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Increase) {
        tenant.Increase = Increase;
    });

}

	Stream<List<Notification>> getNotification$(
    Tenant tenant, {bool useCache = true, ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    return NotificationStore.instance.getBy$(
        tenant.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Notification) {
        tenant.Notification = Notification;
    });

}

	Stream<List<Payment>> getPayment$(
    Tenant tenant, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByTenantId$(
        tenant.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Payment) {
        tenant.Payment = Payment;
    });

}

	Stream<List<Report>> getReport$(
    Tenant tenant, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    return ReportStore.instance.getBy$(
        tenant.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Report) {
        tenant.Report = Report;
    });

}

	Stream<List<Lease>> getLease$(
    Tenant tenant, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    return LeaseStore.instance.getByTenantId$(
        tenant.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Lease) {
        tenant.Lease = Lease;
    });

}

	Stream<List<MaintenanceWorkOrder>> getMaintenanceWorkOrder$(
    Tenant tenant, {bool useCache = true, ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    return MaintenanceWorkOrderStore.instance.getByTenantId$(
        tenant.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((MaintenanceWorkOrder) {
        tenant.MaintenanceWorkOrder = MaintenanceWorkOrder;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Tenant recursiveUpsert(Tenant tenant, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Tenant'} 
        : const {};
    if (tenant.Contract != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        tenant.Contract = ContractStore.instance.recursiveListUpsert(tenant.Contract!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.Expense != null && (!preventCircularSerialization || !upsertedTypes.contains('Expense'))) {
        tenant.Expense = ExpenseStore.instance.recursiveListUpsert(tenant.Expense!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.Increase != null && (!preventCircularSerialization || !upsertedTypes.contains('Increase'))) {
        tenant.Increase = IncreaseStore.instance.recursiveListUpsert(tenant.Increase!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.Notification != null && (!preventCircularSerialization || !upsertedTypes.contains('Notification'))) {
        tenant.Notification = NotificationStore.instance.recursiveListUpsert(tenant.Notification!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.Payment != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        tenant.Payment = PaymentStore.instance.recursiveListUpsert(tenant.Payment!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.Report != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        tenant.Report = ReportStore.instance.recursiveListUpsert(tenant.Report!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.Lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        tenant.Lease = LeaseStore.instance.recursiveListUpsert(tenant.Lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.MaintenanceWorkOrder != null && (!preventCircularSerialization || !upsertedTypes.contains('MaintenanceWorkOrder'))) {
        tenant.MaintenanceWorkOrder = MaintenanceWorkOrderStore.instance.recursiveListUpsert(tenant.MaintenanceWorkOrder!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        tenant.Property = PropertyStore.instance.recursiveUpsert(tenant.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenant.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        tenant.User = UserStore.instance.recursiveUpsert(tenant.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(tenant);
}

  List<Tenant> recursiveListUpsert(List<Tenant> tenants, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedTenants = <Tenant>[];
    for (var tenant in tenants) {
        updatedTenants.add(recursiveUpsert(tenant, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedTenants;
}

//   @override
//   Tenant upsert(Tenant item) {
//     return recursiveUpsert(item);
//   }

}


class TenantInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      TenantInclude.Contract({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getContract$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getContract(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.Expense({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Expense>? modelFilter,
    List<ExpenseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getExpense$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getExpense(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.Increase({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Increase>? modelFilter,
    List<IncreaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getIncrease$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getIncrease(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.Notification({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Notification>? modelFilter,
    List<NotificationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getNotification$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getNotification(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.Payment({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getPayment$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getPayment(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.Report({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getReport$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getReport(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.Lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getLease$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getLease(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.MaintenanceWorkOrder({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MaintenanceWorkOrder>? modelFilter,
    List<MaintenanceWorkOrderInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getMaintenanceWorkOrder$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getMaintenanceWorkOrder(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getProperty$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getProperty(tenant, modelFilter: modelFilter, includes: includes);
      }
}

	TenantInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenant) => TenantStore.instance
            .getUser$(tenant, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenant) => TenantStore.instance
            .getUser(tenant, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum TenantEndpoints implements Endpoint {

    getAll('/tenant', HttpMethod.post, List<Tenant>),
	getById('/tenant/byId/:id', HttpMethod.post, Tenant),
	getByUserId('/tenant/byUserId/:userId', HttpMethod.post, Tenant),
	getManyByFirstName('/tenant/byFirstName/:firstName', HttpMethod.post, List<Tenant>),
	getManyByLastName('/tenant/byLastName/:lastName', HttpMethod.post, List<Tenant>),
	getByEmail('/tenant/byEmail/:email', HttpMethod.post, Tenant),
	getManyByPhoneNumber('/tenant/byPhoneNumber/:phoneNumber', HttpMethod.post, List<Tenant>),
	getManyByLeaseStartDate('/tenant/byLeaseStartDate/:leaseStartDate', HttpMethod.post, List<Tenant>),
	getManyByLeaseEndDate('/tenant/byLeaseEndDate/:leaseEndDate', HttpMethod.post, List<Tenant>),
	getManyByPaymentStatus('/tenant/byPaymentStatus/:paymentStatus', HttpMethod.post, List<Tenant>),
	getManyByCreatedAt('/tenant/byCreatedAt/:createdAt', HttpMethod.post, List<Tenant>),
	getManyByUpdatedAt('/tenant/byUpdatedAt/:updatedAt', HttpMethod.post, List<Tenant>),
	getManyByDeletedAt('/tenant/byDeletedAt/:deletedAt', HttpMethod.post, List<Tenant>),
	getManyByPropertyId('/tenant/byPropertyId/:propertyId', HttpMethod.post, List<Tenant>),
	getManyByIsActive('/tenant/byIsActive/:isActive', HttpMethod.post, List<Tenant>);

    const TenantEndpoints(this.path, this.method, this.responseType);

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
