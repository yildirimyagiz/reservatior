
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ExchangeRateStore extends ModelStreamStore<String, ExchangeRate> {

  static ExchangeRateStore? _instance;

  static ExchangeRateStore get instance {
    _instance ??= ExchangeRateStore();
    return _instance!;
  }

  ExchangeRateStore() : super(ExchangeRate.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ExchangeRateStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ExchangeRateStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ExchangeRateStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getExchangeRateId(ExchangeRate exchangeRate) => exchangeRate.id;

	String? getExchangeRateOrgId(ExchangeRate exchangeRate) => exchangeRate.orgId;

	String? getExchangeRateBaseCurrency(ExchangeRate exchangeRate) => exchangeRate.baseCurrency;

	String? getExchangeRateQuoteCurrency(ExchangeRate exchangeRate) => exchangeRate.quoteCurrency;

	double? getExchangeRateRate(ExchangeRate exchangeRate) => exchangeRate.rate;

	DateTime? getExchangeRateAsOfDate(ExchangeRate exchangeRate) => exchangeRate.asOfDate;

	String? getExchangeRateSource(ExchangeRate exchangeRate) => exchangeRate.source;

	DateTime? getExchangeRateCreatedAt(ExchangeRate exchangeRate) => exchangeRate.createdAt;

	DateTime? getExchangeRateUpdatedAt(ExchangeRate exchangeRate) => exchangeRate.updatedAt;

	DateTime? getExchangeRateDeletedAt(ExchangeRate exchangeRate) => exchangeRate.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ExchangeRate> getByOrgId(
    String orgId,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ExchangeRate> getByBaseCurrency(
    String baseCurrency,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateBaseCurrency, baseCurrency, modelFilter: modelFilter, includes: includes);

	
List<ExchangeRate> getByQuoteCurrency(
    String quoteCurrency,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateQuoteCurrency, quoteCurrency, modelFilter: modelFilter, includes: includes);

	
List<ExchangeRate> getByRate(
    double rate,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateRate, rate, modelFilter: modelFilter, includes: includes);

	
List<ExchangeRate> getByAsOfDate(
    DateTime asOfDate,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateAsOfDate, asOfDate, modelFilter: modelFilter, includes: includes);

	
List<ExchangeRate> getBySource(
    String source,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateSource, source, modelFilter: modelFilter, includes: includes);

	
List<ExchangeRate> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ExchangeRate> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ExchangeRate> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}
    ) =>
    getManyIncluding(getExchangeRateDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    ExchangeRate exchangeRate, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (exchangeRate.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(exchangeRate.orgId!, includes: includes);
        exchangeRate.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ExchangeRate>> getAll$({bool useCache = true, ModelFilter<ExchangeRate>? modelFilter, List<ExchangeRateInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ExchangeRateEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ExchangeRate?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getExchangeRateId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ExchangeRate>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExchangeRateOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExchangeRate>> getByBaseCurrency$(
        String baseCurrency,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExchangeRateBaseCurrency,
        value: baseCurrency,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyByBaseCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExchangeRate>> getByQuoteCurrency$(
        String quoteCurrency,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExchangeRateQuoteCurrency,
        value: quoteCurrency,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyByQuoteCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExchangeRate>> getByRate$(
        double rate,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getExchangeRateRate,
        value: rate,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyByRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExchangeRate>> getByAsOfDate$(
        DateTime asOfDate,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExchangeRateAsOfDate,
        value: asOfDate,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyByAsOfDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExchangeRate>> getBySource$(
        String source,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExchangeRateSource,
        value: source,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyBySource,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExchangeRate>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExchangeRateCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExchangeRate>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExchangeRateUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExchangeRate>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ExchangeRate>? modelFilter,
        List<ExchangeRateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExchangeRateDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ExchangeRateEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    ExchangeRate exchangeRate, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (exchangeRate.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            exchangeRate.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            exchangeRate.org = org;
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
ExchangeRate recursiveUpsert(ExchangeRate exchangeRate, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ExchangeRate'} 
        : const {};
    if (exchangeRate.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        exchangeRate.org = OrganizationStore.instance.recursiveUpsert(exchangeRate.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(exchangeRate);
}

  List<ExchangeRate> recursiveListUpsert(List<ExchangeRate> exchangeRates, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedExchangeRates = <ExchangeRate>[];
    for (var exchangeRate in exchangeRates) {
        updatedExchangeRates.add(recursiveUpsert(exchangeRate, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedExchangeRates;
}

//   @override
//   ExchangeRate upsert(ExchangeRate item) {
//     return recursiveUpsert(item);
//   }

}


class ExchangeRateInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ExchangeRateInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (exchangeRate) => ExchangeRateStore.instance
            .getOrg$(exchangeRate, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (exchangeRate) => ExchangeRateStore.instance
            .getOrg(exchangeRate, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ExchangeRateEndpoints implements Endpoint {

    getAll('/exchangeRate', HttpMethod.post, List<ExchangeRate>),
	getById('/exchangeRate/byId/:id', HttpMethod.post, ExchangeRate),
	getManyByOrgId('/exchangeRate/byOrgId/:orgId', HttpMethod.post, List<ExchangeRate>),
	getManyByBaseCurrency('/exchangeRate/byBaseCurrency/:baseCurrency', HttpMethod.post, List<ExchangeRate>),
	getManyByQuoteCurrency('/exchangeRate/byQuoteCurrency/:quoteCurrency', HttpMethod.post, List<ExchangeRate>),
	getManyByRate('/exchangeRate/byRate/:rate', HttpMethod.post, List<ExchangeRate>),
	getManyByAsOfDate('/exchangeRate/byAsOfDate/:asOfDate', HttpMethod.post, List<ExchangeRate>),
	getManyBySource('/exchangeRate/bySource/:source', HttpMethod.post, List<ExchangeRate>),
	getManyByCreatedAt('/exchangeRate/byCreatedAt/:createdAt', HttpMethod.post, List<ExchangeRate>),
	getManyByUpdatedAt('/exchangeRate/byUpdatedAt/:updatedAt', HttpMethod.post, List<ExchangeRate>),
	getManyByDeletedAt('/exchangeRate/byDeletedAt/:deletedAt', HttpMethod.post, List<ExchangeRate>);

    const ExchangeRateEndpoints(this.path, this.method, this.responseType);

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
