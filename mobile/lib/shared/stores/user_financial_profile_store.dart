
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class UserFinancialProfileStore extends ModelStreamStore<String, UserFinancialProfile> {

  static UserFinancialProfileStore? _instance;

  static UserFinancialProfileStore get instance {
    _instance ??= UserFinancialProfileStore();
    return _instance!;
  }

  UserFinancialProfileStore() : super(UserFinancialProfile.fromJson) {
    if (_instance != null) {
        throw Exception(
            'UserFinancialProfileStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending UserFinancialProfileStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use UserFinancialProfileStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getUserFinancialProfileId(UserFinancialProfile userFinancialProfile) => userFinancialProfile.id;

	String? getUserFinancialProfileUserId(UserFinancialProfile userFinancialProfile) => userFinancialProfile.userId;

	Region? getUserFinancialProfileRegion(UserFinancialProfile userFinancialProfile) => userFinancialProfile.region;

	String? getUserFinancialProfileCurrency(UserFinancialProfile userFinancialProfile) => userFinancialProfile.currency;

	double? getUserFinancialProfileMonthlyIncome(UserFinancialProfile userFinancialProfile) => userFinancialProfile.monthlyIncome;

	double? getUserFinancialProfileMonthlyObligations(UserFinancialProfile userFinancialProfile) => userFinancialProfile.monthlyObligations;

	RiskTolerance? getUserFinancialProfileRiskTolerance(UserFinancialProfile userFinancialProfile) => userFinancialProfile.riskTolerance;

	dynamic? getUserFinancialProfileAssumptions(UserFinancialProfile userFinancialProfile) => userFinancialProfile.assumptions;

	DateTime? getUserFinancialProfileCreatedAt(UserFinancialProfile userFinancialProfile) => userFinancialProfile.createdAt;

	DateTime? getUserFinancialProfileUpdatedAt(UserFinancialProfile userFinancialProfile) => userFinancialProfile.updatedAt;

	DateTime? getUserFinancialProfileDeletedAt(UserFinancialProfile userFinancialProfile) => userFinancialProfile.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
UserFinancialProfile? getByUserId(
    String userId,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getIncluding(getUserFinancialProfileUserId, userId, modelFilter: modelFilter, includes: includes);

  
List<UserFinancialProfile> getByRegion(
    Region region,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileRegion, region, modelFilter: modelFilter, includes: includes);

	
List<UserFinancialProfile> getByCurrency(
    String currency,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<UserFinancialProfile> getByMonthlyIncome(
    double monthlyIncome,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileMonthlyIncome, monthlyIncome, modelFilter: modelFilter, includes: includes);

	
List<UserFinancialProfile> getByMonthlyObligations(
    double monthlyObligations,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileMonthlyObligations, monthlyObligations, modelFilter: modelFilter, includes: includes);

	
List<UserFinancialProfile> getByRiskTolerance(
    RiskTolerance riskTolerance,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileRiskTolerance, riskTolerance, modelFilter: modelFilter, includes: includes);

	
List<UserFinancialProfile> getByAssumptions(
    dynamic assumptions,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileAssumptions, assumptions, modelFilter: modelFilter, includes: includes);

	
List<UserFinancialProfile> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<UserFinancialProfile> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<UserFinancialProfile> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}
    ) =>
    getManyIncluding(getUserFinancialProfileDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getUser(
    UserFinancialProfile userFinancialProfile, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (userFinancialProfile.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(userFinancialProfile.userId!, includes: includes);
        userFinancialProfile.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  List<RecommendationResult> getResults(
    UserFinancialProfile userFinancialProfile, {ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}) {
    final results = RecommendationResultStore.instance.getByProfileId(userFinancialProfile.$uid!, modelFilter: modelFilter, includes: includes);
    userFinancialProfile.results = results;
    // setIncludedReferencesForList(results, includes: includes);
    return results;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<UserFinancialProfile>> getAll$({bool useCache = true, ModelFilter<UserFinancialProfile>? modelFilter, List<UserFinancialProfileInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: UserFinancialProfileEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<UserFinancialProfile?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getUserFinancialProfileId,
        value: id,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<UserFinancialProfile?> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getUserFinancialProfileUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<UserFinancialProfile>> getByRegion$(
        Region region,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<Region>(
        getPropVal: getUserFinancialProfileRegion,
        value: region,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByRegion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserFinancialProfile>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserFinancialProfileCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserFinancialProfile>> getByMonthlyIncome$(
        double monthlyIncome,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getUserFinancialProfileMonthlyIncome,
        value: monthlyIncome,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByMonthlyIncome,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserFinancialProfile>> getByMonthlyObligations$(
        double monthlyObligations,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getUserFinancialProfileMonthlyObligations,
        value: monthlyObligations,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByMonthlyObligations,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserFinancialProfile>> getByRiskTolerance$(
        RiskTolerance riskTolerance,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<RiskTolerance>(
        getPropVal: getUserFinancialProfileRiskTolerance,
        value: riskTolerance,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByRiskTolerance,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserFinancialProfile>> getByAssumptions$(
        dynamic assumptions,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getUserFinancialProfileAssumptions,
        value: assumptions,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByAssumptions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserFinancialProfile>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserFinancialProfileCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserFinancialProfile>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserFinancialProfileUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserFinancialProfile>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<UserFinancialProfile>? modelFilter,
        List<UserFinancialProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserFinancialProfileDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: UserFinancialProfileEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getUser$(
    UserFinancialProfile userFinancialProfile, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (userFinancialProfile.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            userFinancialProfile.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            userFinancialProfile.user = user;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<RecommendationResult>> getResults$(
    UserFinancialProfile userFinancialProfile, {bool useCache = true, ModelFilter<RecommendationResult>? modelFilter, List<RecommendationResultInclude>? includes}) {
    return RecommendationResultStore.instance.getByProfileId$(
        userFinancialProfile.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((results) {
        userFinancialProfile.results = results;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
UserFinancialProfile recursiveUpsert(UserFinancialProfile userFinancialProfile, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'UserFinancialProfile'} 
        : const {};
    if (userFinancialProfile.results != null && (!preventCircularSerialization || !upsertedTypes.contains('RecommendationResult'))) {
        userFinancialProfile.results = RecommendationResultStore.instance.recursiveListUpsert(userFinancialProfile.results!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (userFinancialProfile.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        userFinancialProfile.user = UserStore.instance.recursiveUpsert(userFinancialProfile.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(userFinancialProfile);
}

  List<UserFinancialProfile> recursiveListUpsert(List<UserFinancialProfile> userFinancialProfiles, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedUserFinancialProfiles = <UserFinancialProfile>[];
    for (var userFinancialProfile in userFinancialProfiles) {
        updatedUserFinancialProfiles.add(recursiveUpsert(userFinancialProfile, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedUserFinancialProfiles;
}

//   @override
//   UserFinancialProfile upsert(UserFinancialProfile item) {
//     return recursiveUpsert(item);
//   }

}


class UserFinancialProfileInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      UserFinancialProfileInclude.results({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RecommendationResult>? modelFilter,
    List<RecommendationResultInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (userFinancialProfile) => UserFinancialProfileStore.instance
            .getResults$(userFinancialProfile, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (userFinancialProfile) => UserFinancialProfileStore.instance
            .getResults(userFinancialProfile, modelFilter: modelFilter, includes: includes);
      }
}

	UserFinancialProfileInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (userFinancialProfile) => UserFinancialProfileStore.instance
            .getUser$(userFinancialProfile, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (userFinancialProfile) => UserFinancialProfileStore.instance
            .getUser(userFinancialProfile, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum UserFinancialProfileEndpoints implements Endpoint {

    getAll('/userFinancialProfile', HttpMethod.post, List<UserFinancialProfile>),
	getById('/userFinancialProfile/byId/:id', HttpMethod.post, UserFinancialProfile),
	getByUserId('/userFinancialProfile/byUserId/:userId', HttpMethod.post, UserFinancialProfile),
	getManyByRegion('/userFinancialProfile/byRegion/:region', HttpMethod.post, List<UserFinancialProfile>),
	getManyByCurrency('/userFinancialProfile/byCurrency/:currency', HttpMethod.post, List<UserFinancialProfile>),
	getManyByMonthlyIncome('/userFinancialProfile/byMonthlyIncome/:monthlyIncome', HttpMethod.post, List<UserFinancialProfile>),
	getManyByMonthlyObligations('/userFinancialProfile/byMonthlyObligations/:monthlyObligations', HttpMethod.post, List<UserFinancialProfile>),
	getManyByRiskTolerance('/userFinancialProfile/byRiskTolerance/:riskTolerance', HttpMethod.post, List<UserFinancialProfile>),
	getManyByAssumptions('/userFinancialProfile/byAssumptions/:assumptions', HttpMethod.post, List<UserFinancialProfile>),
	getManyByCreatedAt('/userFinancialProfile/byCreatedAt/:createdAt', HttpMethod.post, List<UserFinancialProfile>),
	getManyByUpdatedAt('/userFinancialProfile/byUpdatedAt/:updatedAt', HttpMethod.post, List<UserFinancialProfile>),
	getManyByDeletedAt('/userFinancialProfile/byDeletedAt/:deletedAt', HttpMethod.post, List<UserFinancialProfile>);

    const UserFinancialProfileEndpoints(this.path, this.method, this.responseType);

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
