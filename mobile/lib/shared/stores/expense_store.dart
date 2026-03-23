
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ExpenseStore extends ModelStreamStore<String, Expense> {

  static ExpenseStore? _instance;

  static ExpenseStore get instance {
    _instance ??= ExpenseStore();
    return _instance!;
  }

  ExpenseStore() : super(Expense.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ExpenseStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ExpenseStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ExpenseStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getExpenseId(Expense expense) => expense.id;

	String? getExpensePropertyId(Expense expense) => expense.propertyId;

	String? getExpenseTenantId(Expense expense) => expense.tenantId;

	String? getExpenseAgencyId(Expense expense) => expense.agencyId;

	ExpenseType? getExpenseType(Expense expense) => expense.type;

	double? getExpenseAmount(Expense expense) => expense.amount;

	String? getExpenseCurrencyId(Expense expense) => expense.currencyId;

	DateTime? getExpenseDueDate(Expense expense) => expense.dueDate;

	DateTime? getExpensePaidDate(Expense expense) => expense.paidDate;

	ExpenseStatus? getExpenseStatus(Expense expense) => expense.status;

	String? getExpenseNotes(Expense expense) => expense.notes;

	DateTime? getExpenseCreatedAt(Expense expense) => expense.createdAt;

	DateTime? getExpenseUpdatedAt(Expense expense) => expense.updatedAt;

	DateTime? getExpenseDeletedAt(Expense expense) => expense.deletedAt;

	String? getExpenseFacilityId(Expense expense) => expense.facilityId;

	String? getExpenseIncludedServiceId(Expense expense) => expense.includedServiceId;

	String? getExpenseExtraChargeId(Expense expense) => expense.extraChargeId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Expense> getByPropertyId(
    String propertyId,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpensePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByTenantId(
    String tenantId,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseTenantId, tenantId, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByAgencyId(
    String agencyId,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByType(
    ExpenseType type,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseType, type, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByAmount(
    double amount,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByCurrencyId(
    String currencyId,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseCurrencyId, currencyId, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByDueDate(
    DateTime dueDate,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseDueDate, dueDate, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByPaidDate(
    DateTime paidDate,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpensePaidDate, paidDate, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByStatus(
    ExpenseStatus status,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByNotes(
    String notes,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByFacilityId(
    String facilityId,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseFacilityId, facilityId, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByIncludedServiceId(
    String includedServiceId,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseIncludedServiceId, includedServiceId, modelFilter: modelFilter, includes: includes);

	
List<Expense> getByExtraChargeId(
    String extraChargeId,
    {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}
    ) =>
    getManyIncluding(getExpenseExtraChargeId, extraChargeId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Expense expense, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (expense.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(expense.agencyId!, includes: includes);
        expense.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Currency? getCurrency(
    Expense expense, {ModelFilter? modelFilter, List<CurrencyInclude>? includes}) {
    if (expense.currencyId == null) {
        return null;
    } else {
        final Currency = CurrencyStore.instance.getById(expense.currencyId!, includes: includes);
        expense.Currency = Currency;
        // setIncludedReferences(Currency, includes: includes);
        return Currency;
    }
}

	ExtraCharge? getExtraCharge(
    Expense expense, {ModelFilter? modelFilter, List<ExtraChargeInclude>? includes}) {
    if (expense.extraChargeId == null) {
        return null;
    } else {
        final ExtraCharge = ExtraChargeStore.instance.getById(expense.extraChargeId!, includes: includes);
        expense.ExtraCharge = ExtraCharge;
        // setIncludedReferences(ExtraCharge, includes: includes);
        return ExtraCharge;
    }
}

	Facility? getFacility(
    Expense expense, {ModelFilter? modelFilter, List<FacilityInclude>? includes}) {
    if (expense.facilityId == null) {
        return null;
    } else {
        final Facility = FacilityStore.instance.getById(expense.facilityId!, includes: includes);
        expense.Facility = Facility;
        // setIncludedReferences(Facility, includes: includes);
        return Facility;
    }
}

	IncludedService? getIncludedService(
    Expense expense, {ModelFilter? modelFilter, List<IncludedServiceInclude>? includes}) {
    if (expense.includedServiceId == null) {
        return null;
    } else {
        final IncludedService = IncludedServiceStore.instance.getById(expense.includedServiceId!, includes: includes);
        expense.IncludedService = IncludedService;
        // setIncludedReferences(IncludedService, includes: includes);
        return IncludedService;
    }
}

	Property? getProperty(
    Expense expense, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (expense.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(expense.propertyId!, includes: includes);
        expense.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Tenant? getTenant(
    Expense expense, {ModelFilter? modelFilter, List<TenantInclude>? includes}) {
    if (expense.tenantId == null) {
        return null;
    } else {
        final Tenant = TenantStore.instance.getById(expense.tenantId!, includes: includes);
        expense.Tenant = Tenant;
        // setIncludedReferences(Tenant, includes: includes);
        return Tenant;
    }
}

  /// GET RELATED MODELS 

  List<Payment> getPayment(
    Expense expense, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final Payment = PaymentStore.instance.getByExpenseId(expense.$uid!, modelFilter: modelFilter, includes: includes);
    expense.Payment = Payment;
    // setIncludedReferencesForList(Payment, includes: includes);
    return Payment;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Expense>> getAll$({bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ExpenseEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Expense?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getExpenseId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Expense>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExpensePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByTenantId$(
        String tenantId,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExpenseTenantId,
        value: tenantId,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByTenantId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExpenseAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByType$(
        ExpenseType type,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<ExpenseType>(
        getPropVal: getExpenseType,
        value: type,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExpenseAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByCurrencyId$(
        String currencyId,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExpenseCurrencyId,
        value: currencyId,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByCurrencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByDueDate$(
        DateTime dueDate,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExpenseDueDate,
        value: dueDate,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByDueDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByPaidDate$(
        DateTime paidDate,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExpensePaidDate,
        value: paidDate,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByPaidDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByStatus$(
        ExpenseStatus status,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<ExpenseStatus>(
        getPropVal: getExpenseStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExpenseNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExpenseCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExpenseUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExpenseDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByFacilityId$(
        String facilityId,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExpenseFacilityId,
        value: facilityId,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByFacilityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByIncludedServiceId$(
        String includedServiceId,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExpenseIncludedServiceId,
        value: includedServiceId,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByIncludedServiceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Expense>> getByExtraChargeId$(
        String extraChargeId,
        {bool useCache = true,
        ModelFilter<Expense>? modelFilter,
        List<ExpenseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExpenseExtraChargeId,
        value: extraChargeId,
        modelFilter: modelFilter,
        endpoint: ExpenseEndpoints.getManyByExtraChargeId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Expense expense, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (expense.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            expense.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            expense.Agency = Agency;
        });
    }
}

	Stream<Currency?> getCurrency$(
    Expense expense, {bool useCache = true, ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    if (expense.currencyId == null) {
        return Stream.value(null);
    } else {
        return CurrencyStore.instance.getById$(
            expense.currencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Currency) {
            expense.Currency = Currency;
        });
    }
}

	Stream<ExtraCharge?> getExtraCharge$(
    Expense expense, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    if (expense.extraChargeId == null) {
        return Stream.value(null);
    } else {
        return ExtraChargeStore.instance.getById$(
            expense.extraChargeId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((ExtraCharge) {
            expense.ExtraCharge = ExtraCharge;
        });
    }
}

	Stream<Facility?> getFacility$(
    Expense expense, {bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    if (expense.facilityId == null) {
        return Stream.value(null);
    } else {
        return FacilityStore.instance.getById$(
            expense.facilityId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Facility) {
            expense.Facility = Facility;
        });
    }
}

	Stream<IncludedService?> getIncludedService$(
    Expense expense, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    if (expense.includedServiceId == null) {
        return Stream.value(null);
    } else {
        return IncludedServiceStore.instance.getById$(
            expense.includedServiceId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((IncludedService) {
            expense.IncludedService = IncludedService;
        });
    }
}

	Stream<Property?> getProperty$(
    Expense expense, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (expense.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            expense.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            expense.Property = Property;
        });
    }
}

	Stream<Tenant?> getTenant$(
    Expense expense, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    if (expense.tenantId == null) {
        return Stream.value(null);
    } else {
        return TenantStore.instance.getById$(
            expense.tenantId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Tenant) {
            expense.Tenant = Tenant;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Payment>> getPayment$(
    Expense expense, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByExpenseId$(
        expense.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Payment) {
        expense.Payment = Payment;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Expense recursiveUpsert(Expense expense, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Expense'} 
        : const {};
    if (expense.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        expense.Agency = AgencyStore.instance.recursiveUpsert(expense.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (expense.Currency != null && (!preventCircularSerialization || !upsertedTypes.contains('Currency'))) {
        expense.Currency = CurrencyStore.instance.recursiveUpsert(expense.Currency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (expense.ExtraCharge != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        expense.ExtraCharge = ExtraChargeStore.instance.recursiveUpsert(expense.ExtraCharge!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (expense.Facility != null && (!preventCircularSerialization || !upsertedTypes.contains('Facility'))) {
        expense.Facility = FacilityStore.instance.recursiveUpsert(expense.Facility!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (expense.IncludedService != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        expense.IncludedService = IncludedServiceStore.instance.recursiveUpsert(expense.IncludedService!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (expense.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        expense.Property = PropertyStore.instance.recursiveUpsert(expense.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (expense.Tenant != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        expense.Tenant = TenantStore.instance.recursiveUpsert(expense.Tenant!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (expense.Payment != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        expense.Payment = PaymentStore.instance.recursiveListUpsert(expense.Payment!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(expense);
}

  List<Expense> recursiveListUpsert(List<Expense> expenses, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedExpenses = <Expense>[];
    for (var expense in expenses) {
        updatedExpenses.add(recursiveUpsert(expense, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedExpenses;
}

//   @override
//   Expense upsert(Expense item) {
//     return recursiveUpsert(item);
//   }

}


class ExpenseInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ExpenseInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (expense) => ExpenseStore.instance
            .getAgency$(expense, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (expense) => ExpenseStore.instance
            .getAgency(expense, modelFilter: modelFilter, includes: includes);
      }
}

	ExpenseInclude.Currency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Currency>? modelFilter,
    List<CurrencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (expense) => ExpenseStore.instance
            .getCurrency$(expense, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (expense) => ExpenseStore.instance
            .getCurrency(expense, modelFilter: modelFilter, includes: includes);
      }
}

	ExpenseInclude.ExtraCharge({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (expense) => ExpenseStore.instance
            .getExtraCharge$(expense, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (expense) => ExpenseStore.instance
            .getExtraCharge(expense, modelFilter: modelFilter, includes: includes);
      }
}

	ExpenseInclude.Facility({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Facility>? modelFilter,
    List<FacilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (expense) => ExpenseStore.instance
            .getFacility$(expense, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (expense) => ExpenseStore.instance
            .getFacility(expense, modelFilter: modelFilter, includes: includes);
      }
}

	ExpenseInclude.IncludedService({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (expense) => ExpenseStore.instance
            .getIncludedService$(expense, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (expense) => ExpenseStore.instance
            .getIncludedService(expense, modelFilter: modelFilter, includes: includes);
      }
}

	ExpenseInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (expense) => ExpenseStore.instance
            .getProperty$(expense, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (expense) => ExpenseStore.instance
            .getProperty(expense, modelFilter: modelFilter, includes: includes);
      }
}

	ExpenseInclude.Tenant({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (expense) => ExpenseStore.instance
            .getTenant$(expense, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (expense) => ExpenseStore.instance
            .getTenant(expense, modelFilter: modelFilter, includes: includes);
      }
}

	ExpenseInclude.Payment({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (expense) => ExpenseStore.instance
            .getPayment$(expense, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (expense) => ExpenseStore.instance
            .getPayment(expense, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ExpenseEndpoints implements Endpoint {

    getAll('/expense', HttpMethod.post, List<Expense>),
	getById('/expense/byId/:id', HttpMethod.post, Expense),
	getManyByPropertyId('/expense/byPropertyId/:propertyId', HttpMethod.post, List<Expense>),
	getManyByTenantId('/expense/byTenantId/:tenantId', HttpMethod.post, List<Expense>),
	getManyByAgencyId('/expense/byAgencyId/:agencyId', HttpMethod.post, List<Expense>),
	getManyByType('/expense/byType/:type', HttpMethod.post, List<Expense>),
	getManyByAmount('/expense/byAmount/:amount', HttpMethod.post, List<Expense>),
	getManyByCurrencyId('/expense/byCurrencyId/:currencyId', HttpMethod.post, List<Expense>),
	getManyByDueDate('/expense/byDueDate/:dueDate', HttpMethod.post, List<Expense>),
	getManyByPaidDate('/expense/byPaidDate/:paidDate', HttpMethod.post, List<Expense>),
	getManyByStatus('/expense/byStatus/:status', HttpMethod.post, List<Expense>),
	getManyByNotes('/expense/byNotes/:notes', HttpMethod.post, List<Expense>),
	getManyByCreatedAt('/expense/byCreatedAt/:createdAt', HttpMethod.post, List<Expense>),
	getManyByUpdatedAt('/expense/byUpdatedAt/:updatedAt', HttpMethod.post, List<Expense>),
	getManyByDeletedAt('/expense/byDeletedAt/:deletedAt', HttpMethod.post, List<Expense>),
	getManyByFacilityId('/expense/byFacilityId/:facilityId', HttpMethod.post, List<Expense>),
	getManyByIncludedServiceId('/expense/byIncludedServiceId/:includedServiceId', HttpMethod.post, List<Expense>),
	getManyByExtraChargeId('/expense/byExtraChargeId/:extraChargeId', HttpMethod.post, List<Expense>);

    const ExpenseEndpoints(this.path, this.method, this.responseType);

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
