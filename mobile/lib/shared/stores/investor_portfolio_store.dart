
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class InvestorPortfolioStore extends ModelStreamStore<String, InvestorPortfolio> {

  static InvestorPortfolioStore? _instance;

  static InvestorPortfolioStore get instance {
    _instance ??= InvestorPortfolioStore();
    return _instance!;
  }

  InvestorPortfolioStore() : super(InvestorPortfolio.fromJson) {
    if (_instance != null) {
        throw Exception(
            'InvestorPortfolioStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending InvestorPortfolioStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use InvestorPortfolioStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getInvestorPortfolioId(InvestorPortfolio investorPortfolio) => investorPortfolio.id;

	String? getInvestorPortfolioUserId(InvestorPortfolio investorPortfolio) => investorPortfolio.userId;

	String? getInvestorPortfolioName(InvestorPortfolio investorPortfolio) => investorPortfolio.name;

	double? getInvestorPortfolioTargetIrr(InvestorPortfolio investorPortfolio) => investorPortfolio.targetIrr;

	RiskTolerance? getInvestorPortfolioRiskTolerance(InvestorPortfolio investorPortfolio) => investorPortfolio.riskTolerance;

	String? getInvestorPortfolioInvestmentHorizon(InvestorPortfolio investorPortfolio) => investorPortfolio.investmentHorizon;

	double? getInvestorPortfolioTotalInvested(InvestorPortfolio investorPortfolio) => investorPortfolio.totalInvested;

	double? getInvestorPortfolioCurrentValue(InvestorPortfolio investorPortfolio) => investorPortfolio.currentValue;

	double? getInvestorPortfolioTotalReturns(InvestorPortfolio investorPortfolio) => investorPortfolio.totalReturns;

	String? getInvestorPortfolioOrganizationId(InvestorPortfolio investorPortfolio) => investorPortfolio.organizationId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
InvestorPortfolio? getByUserId(
    String userId,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getIncluding(getInvestorPortfolioUserId, userId, modelFilter: modelFilter, includes: includes);

  
List<InvestorPortfolio> getByName(
    String name,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPortfolioName, name, modelFilter: modelFilter, includes: includes);

	
List<InvestorPortfolio> getByTargetIrr(
    double targetIrr,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPortfolioTargetIrr, targetIrr, modelFilter: modelFilter, includes: includes);

	
List<InvestorPortfolio> getByRiskTolerance(
    RiskTolerance riskTolerance,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPortfolioRiskTolerance, riskTolerance, modelFilter: modelFilter, includes: includes);

	
List<InvestorPortfolio> getByInvestmentHorizon(
    String investmentHorizon,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPortfolioInvestmentHorizon, investmentHorizon, modelFilter: modelFilter, includes: includes);

	
List<InvestorPortfolio> getByTotalInvested(
    double totalInvested,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPortfolioTotalInvested, totalInvested, modelFilter: modelFilter, includes: includes);

	
List<InvestorPortfolio> getByCurrentValue(
    double currentValue,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPortfolioCurrentValue, currentValue, modelFilter: modelFilter, includes: includes);

	
List<InvestorPortfolio> getByTotalReturns(
    double totalReturns,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPortfolioTotalReturns, totalReturns, modelFilter: modelFilter, includes: includes);

	
List<InvestorPortfolio> getByOrganizationId(
    String organizationId,
    {ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}
    ) =>
    getManyIncluding(getInvestorPortfolioOrganizationId, organizationId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrganization(
    InvestorPortfolio investorPortfolio, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (investorPortfolio.organizationId == null) {
        return null;
    } else {
        final organization = OrganizationStore.instance.getById(investorPortfolio.organizationId!, includes: includes);
        investorPortfolio.organization = organization;
        // setIncludedReferences(organization, includes: includes);
        return organization;
    }
}

	User? getUser(
    InvestorPortfolio investorPortfolio, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (investorPortfolio.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(investorPortfolio.userId!, includes: includes);
        investorPortfolio.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  List<InvestorProperty> getProperties(
    InvestorPortfolio investorPortfolio, {ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}) {
    final properties = InvestorPropertyStore.instance.getByPortfolioId(investorPortfolio.$uid!, modelFilter: modelFilter, includes: includes);
    investorPortfolio.properties = properties;
    // setIncludedReferencesForList(properties, includes: includes);
    return properties;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<InvestorPortfolio>> getAll$({bool useCache = true, ModelFilter<InvestorPortfolio>? modelFilter, List<InvestorPortfolioInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: InvestorPortfolioEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<InvestorPortfolio?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getInvestorPortfolioId,
        value: id,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<InvestorPortfolio?> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getInvestorPortfolioUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<InvestorPortfolio>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getInvestorPortfolioName,
        value: name,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorPortfolio>> getByTargetIrr$(
        double targetIrr,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getInvestorPortfolioTargetIrr,
        value: targetIrr,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getManyByTargetIrr,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorPortfolio>> getByRiskTolerance$(
        RiskTolerance riskTolerance,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final items$ = getManyByFieldValue$<RiskTolerance>(
        getPropVal: getInvestorPortfolioRiskTolerance,
        value: riskTolerance,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getManyByRiskTolerance,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorPortfolio>> getByInvestmentHorizon$(
        String investmentHorizon,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getInvestorPortfolioInvestmentHorizon,
        value: investmentHorizon,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getManyByInvestmentHorizon,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorPortfolio>> getByTotalInvested$(
        double totalInvested,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getInvestorPortfolioTotalInvested,
        value: totalInvested,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getManyByTotalInvested,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorPortfolio>> getByCurrentValue$(
        double currentValue,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getInvestorPortfolioCurrentValue,
        value: currentValue,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getManyByCurrentValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorPortfolio>> getByTotalReturns$(
        double totalReturns,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getInvestorPortfolioTotalReturns,
        value: totalReturns,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getManyByTotalReturns,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<InvestorPortfolio>> getByOrganizationId$(
        String organizationId,
        {bool useCache = true,
        ModelFilter<InvestorPortfolio>? modelFilter,
        List<InvestorPortfolioInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getInvestorPortfolioOrganizationId,
        value: organizationId,
        modelFilter: modelFilter,
        endpoint: InvestorPortfolioEndpoints.getManyByOrganizationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrganization$(
    InvestorPortfolio investorPortfolio, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (investorPortfolio.organizationId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            investorPortfolio.organizationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((organization) {
            investorPortfolio.organization = organization;
        });
    }
}

	Stream<User?> getUser$(
    InvestorPortfolio investorPortfolio, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (investorPortfolio.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            investorPortfolio.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            investorPortfolio.user = user;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<InvestorProperty>> getProperties$(
    InvestorPortfolio investorPortfolio, {bool useCache = true, ModelFilter<InvestorProperty>? modelFilter, List<InvestorPropertyInclude>? includes}) {
    return InvestorPropertyStore.instance.getByPortfolioId$(
        investorPortfolio.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((properties) {
        investorPortfolio.properties = properties;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
InvestorPortfolio recursiveUpsert(InvestorPortfolio investorPortfolio, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'InvestorPortfolio'} 
        : const {};
    if (investorPortfolio.organization != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        investorPortfolio.organization = OrganizationStore.instance.recursiveUpsert(investorPortfolio.organization!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (investorPortfolio.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        investorPortfolio.user = UserStore.instance.recursiveUpsert(investorPortfolio.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (investorPortfolio.properties != null && (!preventCircularSerialization || !upsertedTypes.contains('InvestorProperty'))) {
        investorPortfolio.properties = InvestorPropertyStore.instance.recursiveListUpsert(investorPortfolio.properties!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(investorPortfolio);
}

  List<InvestorPortfolio> recursiveListUpsert(List<InvestorPortfolio> investorPortfolios, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedInvestorPortfolios = <InvestorPortfolio>[];
    for (var investorPortfolio in investorPortfolios) {
        updatedInvestorPortfolios.add(recursiveUpsert(investorPortfolio, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedInvestorPortfolios;
}

//   @override
//   InvestorPortfolio upsert(InvestorPortfolio item) {
//     return recursiveUpsert(item);
//   }

}


class InvestorPortfolioInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      InvestorPortfolioInclude.organization({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (investorPortfolio) => InvestorPortfolioStore.instance
            .getOrganization$(investorPortfolio, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (investorPortfolio) => InvestorPortfolioStore.instance
            .getOrganization(investorPortfolio, modelFilter: modelFilter, includes: includes);
      }
}

	InvestorPortfolioInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (investorPortfolio) => InvestorPortfolioStore.instance
            .getUser$(investorPortfolio, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (investorPortfolio) => InvestorPortfolioStore.instance
            .getUser(investorPortfolio, modelFilter: modelFilter, includes: includes);
      }
}

	InvestorPortfolioInclude.properties({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<InvestorProperty>? modelFilter,
    List<InvestorPropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (investorPortfolio) => InvestorPortfolioStore.instance
            .getProperties$(investorPortfolio, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (investorPortfolio) => InvestorPortfolioStore.instance
            .getProperties(investorPortfolio, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum InvestorPortfolioEndpoints implements Endpoint {

    getAll('/investorPortfolio', HttpMethod.post, List<InvestorPortfolio>),
	getById('/investorPortfolio/byId/:id', HttpMethod.post, InvestorPortfolio),
	getByUserId('/investorPortfolio/byUserId/:userId', HttpMethod.post, InvestorPortfolio),
	getManyByName('/investorPortfolio/byName/:name', HttpMethod.post, List<InvestorPortfolio>),
	getManyByTargetIrr('/investorPortfolio/byTargetIrr/:targetIrr', HttpMethod.post, List<InvestorPortfolio>),
	getManyByRiskTolerance('/investorPortfolio/byRiskTolerance/:riskTolerance', HttpMethod.post, List<InvestorPortfolio>),
	getManyByInvestmentHorizon('/investorPortfolio/byInvestmentHorizon/:investmentHorizon', HttpMethod.post, List<InvestorPortfolio>),
	getManyByTotalInvested('/investorPortfolio/byTotalInvested/:totalInvested', HttpMethod.post, List<InvestorPortfolio>),
	getManyByCurrentValue('/investorPortfolio/byCurrentValue/:currentValue', HttpMethod.post, List<InvestorPortfolio>),
	getManyByTotalReturns('/investorPortfolio/byTotalReturns/:totalReturns', HttpMethod.post, List<InvestorPortfolio>),
	getManyByOrganizationId('/investorPortfolio/byOrganizationId/:organizationId', HttpMethod.post, List<InvestorPortfolio>);

    const InvestorPortfolioEndpoints(this.path, this.method, this.responseType);

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
