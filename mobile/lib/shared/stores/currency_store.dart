
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class CurrencyStore extends ModelStreamStore<String, Currency> {

  static CurrencyStore? _instance;

  static CurrencyStore get instance {
    _instance ??= CurrencyStore();
    return _instance!;
  }

  CurrencyStore() : super(Currency.fromJson) {
    if (_instance != null) {
        throw Exception(
            'CurrencyStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending CurrencyStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use CurrencyStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getCurrencyId(Currency currency) => currency.id;

	String? getCurrencyCode(Currency currency) => currency.code;

	String? getCurrencyName(Currency currency) => currency.name;

	String? getCurrencySymbol(Currency currency) => currency.symbol;

	double? getCurrencyExchangeRate(Currency currency) => currency.exchangeRate;

	bool? getCurrencyIsActive(Currency currency) => currency.isActive;

	DateTime? getCurrencyCreatedAt(Currency currency) => currency.createdAt;

	DateTime? getCurrencyUpdatedAt(Currency currency) => currency.updatedAt;

	DateTime? getCurrencyDeletedAt(Currency currency) => currency.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Currency? getByCode(
    String code,
    {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}
    ) =>
    getIncluding(getCurrencyCode, code, modelFilter: modelFilter, includes: includes);

  
List<Currency> getByName(
    String name,
    {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}
    ) =>
    getManyIncluding(getCurrencyName, name, modelFilter: modelFilter, includes: includes);

	
List<Currency> getBySymbol(
    String symbol,
    {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}
    ) =>
    getManyIncluding(getCurrencySymbol, symbol, modelFilter: modelFilter, includes: includes);

	
List<Currency> getByExchangeRate(
    double exchangeRate,
    {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}
    ) =>
    getManyIncluding(getCurrencyExchangeRate, exchangeRate, modelFilter: modelFilter, includes: includes);

	
List<Currency> getByIsActive(
    bool isActive,
    {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}
    ) =>
    getManyIncluding(getCurrencyIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Currency> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}
    ) =>
    getManyIncluding(getCurrencyCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Currency> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}
    ) =>
    getManyIncluding(getCurrencyUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Currency> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}
    ) =>
    getManyIncluding(getCurrencyDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  List<Expense> getExpense(
    Currency currency, {ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    final Expense = ExpenseStore.instance.getByCurrencyId(currency.$uid!, modelFilter: modelFilter, includes: includes);
    currency.Expense = Expense;
    // setIncludedReferencesForList(Expense, includes: includes);
    return Expense;
}

	List<Payment> getPayment(
    Currency currency, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final Payment = PaymentStore.instance.getByCurrencyId(currency.$uid!, modelFilter: modelFilter, includes: includes);
    currency.Payment = Payment;
    // setIncludedReferencesForList(Payment, includes: includes);
    return Payment;
}

	List<PricingRule> getPricingRule(
    Currency currency, {ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    final PricingRule = PricingRuleStore.instance.getByCurrencyId(currency.$uid!, modelFilter: modelFilter, includes: includes);
    currency.PricingRule = PricingRule;
    // setIncludedReferencesForList(PricingRule, includes: includes);
    return PricingRule;
}

	List<Property> getProperty(
    Currency currency, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final Property = PropertyStore.instance.getBy(currency.$uid!, modelFilter: modelFilter, includes: includes);
    currency.Property = Property;
    // setIncludedReferencesForList(Property, includes: includes);
    return Property;
}

	List<Reservation> getReservation(
    Currency currency, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final Reservation = ReservationStore.instance.getBy(currency.$uid!, modelFilter: modelFilter, includes: includes);
    currency.Reservation = Reservation;
    // setIncludedReferencesForList(Reservation, includes: includes);
    return Reservation;
}

	List<TaxRecord> getTaxRecord(
    Currency currency, {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    final TaxRecord = TaxRecordStore.instance.getBy(currency.$uid!, modelFilter: modelFilter, includes: includes);
    currency.TaxRecord = TaxRecord;
    // setIncludedReferencesForList(TaxRecord, includes: includes);
    return TaxRecord;
}

	List<User> getUsers(
    Currency currency, {ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    final users = UserStore.instance.getBy(currency.$uid!, modelFilter: modelFilter, includes: includes);
    currency.users = users;
    // setIncludedReferencesForList(users, includes: includes);
    return users;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Currency>> getAll$({bool useCache = true, ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: CurrencyEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Currency?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getCurrencyId,
        value: id,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Currency?> getByCode$(
        String code,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getCurrencyCode,
        value: code,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getByCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Currency>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCurrencyName,
        value: name,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Currency>> getBySymbol$(
        String symbol,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCurrencySymbol,
        value: symbol,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getManyBySymbol,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Currency>> getByExchangeRate$(
        double exchangeRate,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getCurrencyExchangeRate,
        value: exchangeRate,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getManyByExchangeRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Currency>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getCurrencyIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Currency>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCurrencyCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Currency>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCurrencyUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Currency>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Currency>? modelFilter,
        List<CurrencyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCurrencyDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: CurrencyEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  Stream<List<Expense>> getExpense$(
    Currency currency, {bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    return ExpenseStore.instance.getByCurrencyId$(
        currency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Expense) {
        currency.Expense = Expense;
    });

}

	Stream<List<Payment>> getPayment$(
    Currency currency, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByCurrencyId$(
        currency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Payment) {
        currency.Payment = Payment;
    });

}

	Stream<List<PricingRule>> getPricingRule$(
    Currency currency, {bool useCache = true, ModelFilter<PricingRule>? modelFilter, List<PricingRuleInclude>? includes}) {
    return PricingRuleStore.instance.getByCurrencyId$(
        currency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((PricingRule) {
        currency.PricingRule = PricingRule;
    });

}

	Stream<List<Property>> getProperty$(
    Currency currency, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getBy$(
        currency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Property) {
        currency.Property = Property;
    });

}

	Stream<List<Reservation>> getReservation$(
    Currency currency, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getBy$(
        currency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Reservation) {
        currency.Reservation = Reservation;
    });

}

	Stream<List<TaxRecord>> getTaxRecord$(
    Currency currency, {bool useCache = true, ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    return TaxRecordStore.instance.getBy$(
        currency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((TaxRecord) {
        currency.TaxRecord = TaxRecord;
    });

}

	Stream<List<User>> getUsers$(
    Currency currency, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    return UserStore.instance.getBy$(
        currency.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((users) {
        currency.users = users;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Currency recursiveUpsert(Currency currency, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Currency'} 
        : const {};
    if (currency.Expense != null && (!preventCircularSerialization || !upsertedTypes.contains('Expense'))) {
        currency.Expense = ExpenseStore.instance.recursiveListUpsert(currency.Expense!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (currency.Payment != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        currency.Payment = PaymentStore.instance.recursiveListUpsert(currency.Payment!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (currency.PricingRule != null && (!preventCircularSerialization || !upsertedTypes.contains('PricingRule'))) {
        currency.PricingRule = PricingRuleStore.instance.recursiveListUpsert(currency.PricingRule!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (currency.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        currency.Property = PropertyStore.instance.recursiveListUpsert(currency.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (currency.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        currency.Reservation = ReservationStore.instance.recursiveListUpsert(currency.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (currency.TaxRecord != null && (!preventCircularSerialization || !upsertedTypes.contains('TaxRecord'))) {
        currency.TaxRecord = TaxRecordStore.instance.recursiveListUpsert(currency.TaxRecord!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (currency.users != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        currency.users = UserStore.instance.recursiveListUpsert(currency.users!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(currency);
}

  List<Currency> recursiveListUpsert(List<Currency> currencys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedCurrencys = <Currency>[];
    for (var currency in currencys) {
        updatedCurrencys.add(recursiveUpsert(currency, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedCurrencys;
}

//   @override
//   Currency upsert(Currency item) {
//     return recursiveUpsert(item);
//   }

}


class CurrencyInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      CurrencyInclude.Expense({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Expense>? modelFilter,
    List<ExpenseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (currency) => CurrencyStore.instance
            .getExpense$(currency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (currency) => CurrencyStore.instance
            .getExpense(currency, modelFilter: modelFilter, includes: includes);
      }
}

	CurrencyInclude.Payment({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (currency) => CurrencyStore.instance
            .getPayment$(currency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (currency) => CurrencyStore.instance
            .getPayment(currency, modelFilter: modelFilter, includes: includes);
      }
}

	CurrencyInclude.PricingRule({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PricingRule>? modelFilter,
    List<PricingRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (currency) => CurrencyStore.instance
            .getPricingRule$(currency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (currency) => CurrencyStore.instance
            .getPricingRule(currency, modelFilter: modelFilter, includes: includes);
      }
}

	CurrencyInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (currency) => CurrencyStore.instance
            .getProperty$(currency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (currency) => CurrencyStore.instance
            .getProperty(currency, modelFilter: modelFilter, includes: includes);
      }
}

	CurrencyInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (currency) => CurrencyStore.instance
            .getReservation$(currency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (currency) => CurrencyStore.instance
            .getReservation(currency, modelFilter: modelFilter, includes: includes);
      }
}

	CurrencyInclude.TaxRecord({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TaxRecord>? modelFilter,
    List<TaxRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (currency) => CurrencyStore.instance
            .getTaxRecord$(currency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (currency) => CurrencyStore.instance
            .getTaxRecord(currency, modelFilter: modelFilter, includes: includes);
      }
}

	CurrencyInclude.users({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (currency) => CurrencyStore.instance
            .getUsers$(currency, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (currency) => CurrencyStore.instance
            .getUsers(currency, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum CurrencyEndpoints implements Endpoint {

    getAll('/currency', HttpMethod.post, List<Currency>),
	getById('/currency/byId/:id', HttpMethod.post, Currency),
	getByCode('/currency/byCode/:code', HttpMethod.post, Currency),
	getManyByName('/currency/byName/:name', HttpMethod.post, List<Currency>),
	getManyBySymbol('/currency/bySymbol/:symbol', HttpMethod.post, List<Currency>),
	getManyByExchangeRate('/currency/byExchangeRate/:exchangeRate', HttpMethod.post, List<Currency>),
	getManyByIsActive('/currency/byIsActive/:isActive', HttpMethod.post, List<Currency>),
	getManyByCreatedAt('/currency/byCreatedAt/:createdAt', HttpMethod.post, List<Currency>),
	getManyByUpdatedAt('/currency/byUpdatedAt/:updatedAt', HttpMethod.post, List<Currency>),
	getManyByDeletedAt('/currency/byDeletedAt/:deletedAt', HttpMethod.post, List<Currency>);

    const CurrencyEndpoints(this.path, this.method, this.responseType);

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
