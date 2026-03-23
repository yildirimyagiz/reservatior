
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class BudgetStore extends ModelStreamStore<String, Budget> {

  static BudgetStore? _instance;

  static BudgetStore get instance {
    _instance ??= BudgetStore();
    return _instance!;
  }

  BudgetStore() : super(Budget.fromJson) {
    if (_instance != null) {
        throw Exception(
            'BudgetStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending BudgetStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use BudgetStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getBudgetId(Budget budget) => budget.id;

	String? getBudgetOrgId(Budget budget) => budget.orgId;

	String? getBudgetUserId(Budget budget) => budget.userId;

	String? getBudgetName(Budget budget) => budget.name;

	String? getBudgetDescription(Budget budget) => budget.description;

	String? getBudgetBudgetType(Budget budget) => budget.budgetType;

	String? getBudgetPeriod(Budget budget) => budget.period;

	DateTime? getBudgetStartDate(Budget budget) => budget.startDate;

	DateTime? getBudgetEndDate(Budget budget) => budget.endDate;

	double? getBudgetTotalAmount(Budget budget) => budget.totalAmount;

	String? getBudgetCurrency(Budget budget) => budget.currency;

	dynamic? getBudgetLineItems(Budget budget) => budget.lineItems;

	dynamic? getBudgetCategories(Budget budget) => budget.categories;

	dynamic? getBudgetAlerts(Budget budget) => budget.alerts;

	double? getBudgetActualSpent(Budget budget) => budget.actualSpent;

	bool? getBudgetIsActive(Budget budget) => budget.isActive;

	String? getBudgetCreatedBy(Budget budget) => budget.createdBy;

	DateTime? getBudgetCreatedAt(Budget budget) => budget.createdAt;

	DateTime? getBudgetUpdatedAt(Budget budget) => budget.updatedAt;

	DateTime? getBudgetDeletedAt(Budget budget) => budget.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Budget> getByOrgId(
    String orgId,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByUserId(
    String userId,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByName(
    String name,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetName, name, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByDescription(
    String description,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByBudgetType(
    String budgetType,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetBudgetType, budgetType, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByPeriod(
    String period,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetPeriod, period, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByStartDate(
    DateTime startDate,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByEndDate(
    DateTime endDate,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByTotalAmount(
    double totalAmount,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetTotalAmount, totalAmount, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByCurrency(
    String currency,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByLineItems(
    dynamic lineItems,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetLineItems, lineItems, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByCategories(
    dynamic categories,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetCategories, categories, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByAlerts(
    dynamic alerts,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetAlerts, alerts, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByActualSpent(
    double actualSpent,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetActualSpent, actualSpent, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByIsActive(
    bool isActive,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByCreatedBy(
    String createdBy,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Budget> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}
    ) =>
    getManyIncluding(getBudgetDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Budget budget, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (budget.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(budget.orgId!, includes: includes);
        budget.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    Budget budget, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (budget.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(budget.userId!, includes: includes);
        budget.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Budget>> getAll$({bool useCache = true, ModelFilter<Budget>? modelFilter, List<BudgetInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: BudgetEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Budget?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getBudgetId,
        value: id,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Budget>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBudgetOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBudgetUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBudgetName,
        value: name,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBudgetDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByBudgetType$(
        String budgetType,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBudgetBudgetType,
        value: budgetType,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByBudgetType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByPeriod$(
        String period,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBudgetPeriod,
        value: period,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByPeriod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBudgetStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBudgetEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByTotalAmount$(
        double totalAmount,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getBudgetTotalAmount,
        value: totalAmount,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByTotalAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBudgetCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByLineItems$(
        dynamic lineItems,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getBudgetLineItems,
        value: lineItems,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByLineItems,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByCategories$(
        dynamic categories,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getBudgetCategories,
        value: categories,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByCategories,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByAlerts$(
        dynamic alerts,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getBudgetAlerts,
        value: alerts,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByAlerts,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByActualSpent$(
        double actualSpent,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getBudgetActualSpent,
        value: actualSpent,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByActualSpent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getBudgetIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBudgetCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBudgetCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBudgetUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Budget>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Budget>? modelFilter,
        List<BudgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBudgetDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: BudgetEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Budget budget, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (budget.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            budget.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            budget.org = org;
        });
    }
}

	Stream<User?> getUser$(
    Budget budget, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (budget.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            budget.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            budget.user = user;
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
Budget recursiveUpsert(Budget budget, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Budget'} 
        : const {};
    if (budget.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        budget.org = OrganizationStore.instance.recursiveUpsert(budget.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (budget.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        budget.user = UserStore.instance.recursiveUpsert(budget.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(budget);
}

  List<Budget> recursiveListUpsert(List<Budget> budgets, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedBudgets = <Budget>[];
    for (var budget in budgets) {
        updatedBudgets.add(recursiveUpsert(budget, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedBudgets;
}

//   @override
//   Budget upsert(Budget item) {
//     return recursiveUpsert(item);
//   }

}


class BudgetInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      BudgetInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (budget) => BudgetStore.instance
            .getOrg$(budget, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (budget) => BudgetStore.instance
            .getOrg(budget, modelFilter: modelFilter, includes: includes);
      }
}

	BudgetInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (budget) => BudgetStore.instance
            .getUser$(budget, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (budget) => BudgetStore.instance
            .getUser(budget, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum BudgetEndpoints implements Endpoint {

    getAll('/budget', HttpMethod.post, List<Budget>),
	getById('/budget/byId/:id', HttpMethod.post, Budget),
	getManyByOrgId('/budget/byOrgId/:orgId', HttpMethod.post, List<Budget>),
	getManyByUserId('/budget/byUserId/:userId', HttpMethod.post, List<Budget>),
	getManyByName('/budget/byName/:name', HttpMethod.post, List<Budget>),
	getManyByDescription('/budget/byDescription/:description', HttpMethod.post, List<Budget>),
	getManyByBudgetType('/budget/byBudgetType/:budgetType', HttpMethod.post, List<Budget>),
	getManyByPeriod('/budget/byPeriod/:period', HttpMethod.post, List<Budget>),
	getManyByStartDate('/budget/byStartDate/:startDate', HttpMethod.post, List<Budget>),
	getManyByEndDate('/budget/byEndDate/:endDate', HttpMethod.post, List<Budget>),
	getManyByTotalAmount('/budget/byTotalAmount/:totalAmount', HttpMethod.post, List<Budget>),
	getManyByCurrency('/budget/byCurrency/:currency', HttpMethod.post, List<Budget>),
	getManyByLineItems('/budget/byLineItems/:lineItems', HttpMethod.post, List<Budget>),
	getManyByCategories('/budget/byCategories/:categories', HttpMethod.post, List<Budget>),
	getManyByAlerts('/budget/byAlerts/:alerts', HttpMethod.post, List<Budget>),
	getManyByActualSpent('/budget/byActualSpent/:actualSpent', HttpMethod.post, List<Budget>),
	getManyByIsActive('/budget/byIsActive/:isActive', HttpMethod.post, List<Budget>),
	getManyByCreatedBy('/budget/byCreatedBy/:createdBy', HttpMethod.post, List<Budget>),
	getManyByCreatedAt('/budget/byCreatedAt/:createdAt', HttpMethod.post, List<Budget>),
	getManyByUpdatedAt('/budget/byUpdatedAt/:updatedAt', HttpMethod.post, List<Budget>),
	getManyByDeletedAt('/budget/byDeletedAt/:deletedAt', HttpMethod.post, List<Budget>);

    const BudgetEndpoints(this.path, this.method, this.responseType);

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
