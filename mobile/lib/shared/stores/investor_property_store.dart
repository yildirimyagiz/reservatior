
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class InvestorPropertyStore extends ModelStreamStore<String, InvestorProperty> {

  static InvestorPropertyStore? _instance;

  static InvestorPropertyStore get instance {
    _instance ??= InvestorPropertyStore();
    return _instance!;
  }

  InvestorPropertyStore() : super(InvestorProperty.fromJson) {
    if (_instance != null) {
        throw Exception(
            'InvestorPropertyStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending InvestorPropertyStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use InvestorPropertyStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getInvestorPropertyId(InvestorProperty investorProperty) => investorProperty.id;

	String? getInvestorPropertyPortfolioId(InvestorProperty investorProperty) => investorProperty.portfolioId;

	String? getInvestorPropertyPropertyId(InvestorProperty investorProperty) => investorProperty.propertyId;

	DateTime? getInvestorPropertyAcquiredAt(InvestorProperty investorProperty) => investorProperty.acquiredAt;

	double? getInvestorPropertyAcquiredCost(InvestorProperty investorProperty) => investorProperty.acquiredCost;

	double? getInvestorPropertyMortgageBalance(InvestorProperty investorProperty) => investorProperty.mortgageBalance;

	double? getInvestorPropertyMortgageRate(InvestorProperty investorProperty) => investorProperty.mortgageRate;

	int? getInvestorPropertyMortgageTerm(InvestorProperty investorProperty) => investorProperty.mortgageTerm;

	String? getInvestorPropertyInsuranceProvider(InvestorProperty investorProperty) => investorProperty.insuranceProvider;

	double? getInvestorPropertyInsuranceAmount(InvestorProperty investorProperty) => investorProperty.insuranceAmount;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<InvestorProperty> getByPortfolioId(
    String portfolioId,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyPortfolioId, portfolioId, modelFilter: modelFilter, includes: includes);

	
List<InvestorProperty> getByPropertyId(
    String propertyId,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<InvestorProperty> getByAcquiredAt(
    DateTime acquiredAt,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyAcquiredAt, acquiredAt, modelFilter: modelFilter, includes: includes);

	
List<InvestorProperty> getByAcquiredCost(
    double acquiredCost,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyAcquiredCost, acquiredCost, modelFilter: modelFilter, includes: includes);

	
List<InvestorProperty> getByMortgageBalance(
    double mortgageBalance,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyMortgageBalance, mortgageBalance, modelFilter: modelFilter, includes: includes);

	
List<InvestorProperty> getByMortgageRate(
    double mortgageRate,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyMortgageRate, mortgageRate, modelFilter: modelFilter, includes: includes);

	
List<InvestorProperty> getByMortgageTerm(
    int mortgageTerm,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyMortgageTerm, mortgageTerm, modelFilter: modelFilter, includes: includes);

	
List<InvestorProperty> getByInsuranceProvider(
    String insuranceProvider,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyInsuranceProvider, insuranceProvider, modelFilter: modelFilter, includes: includes);

	
List<InvestorProperty> getByInsuranceAmount(
    double insuranceAmount,
    {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPropertyInsuranceAmount, insuranceAmount, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  InvestorPortfolio? getPortfolio(
    InvestorProperty investorProperty, {ModelFilter? modelFilter, List<InvestorPortfolioInclude>? includes}) {
    if (investorProperty.portfolioId == null) {
        return null;
    } else {
        final portfolio = InvestorPortfolioStore.instance.getById(investorProperty.portfolioId!, includes: includes);
        investorProperty.portfolio = portfolio;
        // setIncludedReferences(portfolio, includes: includes);
        return portfolio;
    }
}

	Property? getProperty(
    InvestorProperty investorProperty, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (investorProperty.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(investorProperty.propertyId!, includes: includes);
        investorProperty.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<InvestorProperty>> getAll$({bool useCache = true, ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: InvestorPropertyEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<InvestorProperty?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getInvestorPropertyId,
        value: id,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<InvestorProperty>> getByPortfolioId$(
        String portfolioId,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getInvestorPropertyPortfolioId,
        value: portfolioId,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByPortfolioId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorProperty>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getInvestorPropertyPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorProperty>> getByAcquiredAt$(
        DateTime acquiredAt,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getInvestorPropertyAcquiredAt,
        value: acquiredAt,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByAcquiredAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorProperty>> getByAcquiredCost$(
        double acquiredCost,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getInvestorPropertyAcquiredCost,
        value: acquiredCost,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByAcquiredCost,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorProperty>> getByMortgageBalance$(
        double mortgageBalance,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getInvestorPropertyMortgageBalance,
        value: mortgageBalance,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByMortgageBalance,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorProperty>> getByMortgageRate$(
        double mortgageRate,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getInvestorPropertyMortgageRate,
        value: mortgageRate,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByMortgageRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorProperty>> getByMortgageTerm$(
        int mortgageTerm,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getInvestorPropertyMortgageTerm,
        value: mortgageTerm,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByMortgageTerm,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorProperty>> getByInsuranceProvider$(
        String insuranceProvider,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getInvestorPropertyInsuranceProvider,
        value: insuranceProvider,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByInsuranceProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorProperty>> getByInsuranceAmount$(
        double insuranceAmount,
        {bool useCache = true,
        ModelFilter<InvestorProperty>? modelFilter,
        List<InvestorPropertyInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getInvestorPropertyInsuranceAmount,
        value: insuranceAmount,
        modelFilter: modelFilter,
        endpoint: InvestorPropertyEndpoints.getManyByInsuranceAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<InvestorPortfolio?> getPortfolio$(
    InvestorProperty investorProperty, {bool useCache = true, ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}) {
    if (investorProperty.portfolioId == null) {
        return Stream.value(null);
    } else {
        return InvestorPortfolioStore.instance.getById$(
            investorProperty.portfolioId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((portfolio) {
            investorProperty.portfolio = portfolio;
        });
    }
}

	Stream<Property?> getProperty$(
    InvestorProperty investorProperty, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (investorProperty.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            investorProperty.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            investorProperty.property = property;
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
InvestorProperty recursiveUpsert(InvestorProperty investorProperty, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'InvestorProperty'} 
        : const {};
    if (investorProperty.portfolio != null && (!preventCircularSerialization || !upsertedTypes.contains('InvestorPortfolio'))) {
        investorProperty.portfolio = InvestorPortfolioStore.instance.recursiveUpsert(investorProperty.portfolio!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (investorProperty.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        investorProperty.property = PropertyStore.instance.recursiveUpsert(investorProperty.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(investorProperty);
}

  List<InvestorProperty> recursiveListUpsert(List<InvestorProperty> investorPropertys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedInvestorPropertys = <InvestorProperty>[];
    for (var investorProperty in investorPropertys) {
        updatedInvestorPropertys.add(recursiveUpsert(investorProperty, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedInvestorPropertys;
}

//   @override
//   InvestorProperty upsert(InvestorProperty item) {
//     return recursiveUpsert(item);
//   }

}


class InvestorPropertyInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      InvestorPropertyInclude.portfolio({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<InvestorPortfolio>? modelFilter,
    List<InvestorPortfolioInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (investorProperty) => InvestorPropertyStore.instance
            .getPortfolio$(investorProperty, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (investorProperty) => InvestorPropertyStore.instance
            .getPortfolio(investorProperty, modelFilter: modelFilter, includes: includes);
      }
}

	InvestorPropertyInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (investorProperty) => InvestorPropertyStore.instance
            .getProperty$(investorProperty, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (investorProperty) => InvestorPropertyStore.instance
            .getProperty(investorProperty, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum InvestorPropertyEndpoints implements Endpoint {

    getAll('/investorProperty', HttpMethod.post, List<InvestorProperty>),
	getById('/investorProperty/byId/:id', HttpMethod.post, InvestorProperty),
	getManyByPortfolioId('/investorProperty/byPortfolioId/:portfolioId', HttpMethod.post, List<InvestorProperty>),
	getManyByPropertyId('/investorProperty/byPropertyId/:propertyId', HttpMethod.post, List<InvestorProperty>),
	getManyByAcquiredAt('/investorProperty/byAcquiredAt/:acquiredAt', HttpMethod.post, List<InvestorProperty>),
	getManyByAcquiredCost('/investorProperty/byAcquiredCost/:acquiredCost', HttpMethod.post, List<InvestorProperty>),
	getManyByMortgageBalance('/investorProperty/byMortgageBalance/:mortgageBalance', HttpMethod.post, List<InvestorProperty>),
	getManyByMortgageRate('/investorProperty/byMortgageRate/:mortgageRate', HttpMethod.post, List<InvestorProperty>),
	getManyByMortgageTerm('/investorProperty/byMortgageTerm/:mortgageTerm', HttpMethod.post, List<InvestorProperty>),
	getManyByInsuranceProvider('/investorProperty/byInsuranceProvider/:insuranceProvider', HttpMethod.post, List<InvestorProperty>),
	getManyByInsuranceAmount('/investorProperty/byInsuranceAmount/:insuranceAmount', HttpMethod.post, List<InvestorProperty>);

    const InvestorPropertyEndpoints(this.path, this.method, this.responseType);

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
