
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class EarningStore extends ModelStreamStore<String, Earning> {

  static EarningStore? _instance;

  static EarningStore get instance {
    _instance ??= EarningStore();
    return _instance!;
  }

  EarningStore() : super(Earning.fromJson) {
    if (_instance != null) {
        throw Exception(
            'EarningStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending EarningStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use EarningStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getEarningId(Earning earning) => earning.id;

	String? getEarningOrgId(Earning earning) => earning.orgId;

	String? getEarningUserId(Earning earning) => earning.userId;

	String? getEarningName(Earning earning) => earning.name;

	EarningType? getEarningType(Earning earning) => earning.type;

	double? getEarningPercentage(Earning earning) => earning.percentage;

	double? getEarningFixedAmount(Earning earning) => earning.fixedAmount;

	dynamic? getEarningConditions(Earning earning) => earning.conditions;

	bool? getEarningAppliesToUsers(Earning earning) => earning.appliesToUsers;

	bool? getEarningAppliesToAgents(Earning earning) => earning.appliesToAgents;

	bool? getEarningAppliesToVendors(Earning earning) => earning.appliesToVendors;

	bool? getEarningIsActive(Earning earning) => earning.isActive;

	dynamic? getEarningEarningsRecords(Earning earning) => earning.earningsRecords;

	String? getEarningCreatedBy(Earning earning) => earning.createdBy;

	DateTime? getEarningCreatedAt(Earning earning) => earning.createdAt;

	DateTime? getEarningUpdatedAt(Earning earning) => earning.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Earning> getByOrgId(
    String orgId,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByUserId(
    String userId,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByName(
    String name,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningName, name, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByType(
    EarningType type,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningType, type, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByPercentage(
    double percentage,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningPercentage, percentage, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByFixedAmount(
    double fixedAmount,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningFixedAmount, fixedAmount, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByConditions(
    dynamic conditions,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningConditions, conditions, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByAppliesToUsers(
    bool appliesToUsers,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningAppliesToUsers, appliesToUsers, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByAppliesToAgents(
    bool appliesToAgents,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningAppliesToAgents, appliesToAgents, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByAppliesToVendors(
    bool appliesToVendors,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningAppliesToVendors, appliesToVendors, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByIsActive(
    bool isActive,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByEarningsRecords(
    dynamic earningsRecords,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningEarningsRecords, earningsRecords, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByCreatedBy(
    String createdBy,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Earning> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}
    ) =>
    getManyIncluding(getEarningUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Earning earning, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (earning.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(earning.orgId!, includes: includes);
        earning.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    Earning earning, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (earning.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(earning.userId!, includes: includes);
        earning.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Earning>> getAll$({bool useCache = true, ModelFilter<Earning>? modelFilter, List<EarningInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: EarningEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Earning?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getEarningId,
        value: id,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Earning>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEarningOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEarningUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEarningName,
        value: name,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByType$(
        EarningType type,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<EarningType>(
        getPropVal: getEarningType,
        value: type,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByPercentage$(
        double percentage,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getEarningPercentage,
        value: percentage,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByPercentage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByFixedAmount$(
        double fixedAmount,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getEarningFixedAmount,
        value: fixedAmount,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByFixedAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByConditions$(
        dynamic conditions,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getEarningConditions,
        value: conditions,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByConditions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByAppliesToUsers$(
        bool appliesToUsers,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getEarningAppliesToUsers,
        value: appliesToUsers,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByAppliesToUsers,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByAppliesToAgents$(
        bool appliesToAgents,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getEarningAppliesToAgents,
        value: appliesToAgents,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByAppliesToAgents,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByAppliesToVendors$(
        bool appliesToVendors,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getEarningAppliesToVendors,
        value: appliesToVendors,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByAppliesToVendors,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getEarningIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByEarningsRecords$(
        dynamic earningsRecords,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getEarningEarningsRecords,
        value: earningsRecords,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByEarningsRecords,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getEarningCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEarningCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Earning>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Earning>? modelFilter,
        List<EarningInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getEarningUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: EarningEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Earning earning, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (earning.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            earning.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            earning.org = org;
        });
    }
}

	Stream<User?> getUser$(
    Earning earning, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (earning.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            earning.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            earning.user = user;
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
Earning recursiveUpsert(Earning earning, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Earning'} 
        : const {};
    if (earning.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        earning.org = OrganizationStore.instance.recursiveUpsert(earning.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (earning.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        earning.user = UserStore.instance.recursiveUpsert(earning.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(earning);
}

  List<Earning> recursiveListUpsert(List<Earning> earnings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedEarnings = <Earning>[];
    for (var earning in earnings) {
        updatedEarnings.add(recursiveUpsert(earning, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedEarnings;
}

//   @override
//   Earning upsert(Earning item) {
//     return recursiveUpsert(item);
//   }

}


class EarningInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      EarningInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (earning) => EarningStore.instance
            .getOrg$(earning, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (earning) => EarningStore.instance
            .getOrg(earning, modelFilter: modelFilter, includes: includes);
      }
}

	EarningInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (earning) => EarningStore.instance
            .getUser$(earning, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (earning) => EarningStore.instance
            .getUser(earning, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum EarningEndpoints implements Endpoint {

    getAll('/earning', HttpMethod.post, List<Earning>),
	getById('/earning/byId/:id', HttpMethod.post, Earning),
	getManyByOrgId('/earning/byOrgId/:orgId', HttpMethod.post, List<Earning>),
	getManyByUserId('/earning/byUserId/:userId', HttpMethod.post, List<Earning>),
	getManyByName('/earning/byName/:name', HttpMethod.post, List<Earning>),
	getManyByType('/earning/byType/:type', HttpMethod.post, List<Earning>),
	getManyByPercentage('/earning/byPercentage/:percentage', HttpMethod.post, List<Earning>),
	getManyByFixedAmount('/earning/byFixedAmount/:fixedAmount', HttpMethod.post, List<Earning>),
	getManyByConditions('/earning/byConditions/:conditions', HttpMethod.post, List<Earning>),
	getManyByAppliesToUsers('/earning/byAppliesToUsers/:appliesToUsers', HttpMethod.post, List<Earning>),
	getManyByAppliesToAgents('/earning/byAppliesToAgents/:appliesToAgents', HttpMethod.post, List<Earning>),
	getManyByAppliesToVendors('/earning/byAppliesToVendors/:appliesToVendors', HttpMethod.post, List<Earning>),
	getManyByIsActive('/earning/byIsActive/:isActive', HttpMethod.post, List<Earning>),
	getManyByEarningsRecords('/earning/byEarningsRecords/:earningsRecords', HttpMethod.post, List<Earning>),
	getManyByCreatedBy('/earning/byCreatedBy/:createdBy', HttpMethod.post, List<Earning>),
	getManyByCreatedAt('/earning/byCreatedAt/:createdAt', HttpMethod.post, List<Earning>),
	getManyByUpdatedAt('/earning/byUpdatedAt/:updatedAt', HttpMethod.post, List<Earning>);

    const EarningEndpoints(this.path, this.method, this.responseType);

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
