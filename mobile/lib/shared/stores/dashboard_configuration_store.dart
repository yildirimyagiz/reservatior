
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class DashboardConfigurationStore extends ModelStreamStore<String, DashboardConfiguration> {

  static DashboardConfigurationStore? _instance;

  static DashboardConfigurationStore get instance {
    _instance ??= DashboardConfigurationStore();
    return _instance!;
  }

  DashboardConfigurationStore() : super(DashboardConfiguration.fromJson) {
    if (_instance != null) {
        throw Exception(
            'DashboardConfigurationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending DashboardConfigurationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use DashboardConfigurationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getDashboardConfigurationId(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.id;

	String? getDashboardConfigurationUserId(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.userId;

	String? getDashboardConfigurationOrgId(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.orgId;

	String? getDashboardConfigurationDashboardName(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.dashboardName;

	bool? getDashboardConfigurationIsDefault(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.isDefault;

	dynamic? getDashboardConfigurationLayout(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.layout;

	dynamic? getDashboardConfigurationWidgets(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.widgets;

	dynamic? getDashboardConfigurationFilters(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.filters;

	String? getDashboardConfigurationTimeRange(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.timeRange;

	bool? getDashboardConfigurationIsPublic(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.isPublic;

	List<String>? getDashboardConfigurationSharedWith(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.sharedWith;

	DateTime? getDashboardConfigurationCreatedAt(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.createdAt;

	DateTime? getDashboardConfigurationUpdatedAt(DashboardConfiguration dashboardConfiguration) => dashboardConfiguration.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<DashboardConfiguration> getByUserId(
    String userId,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByOrgId(
    String orgId,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByDashboardName(
    String dashboardName,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationDashboardName, dashboardName, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByIsDefault(
    bool isDefault,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationIsDefault, isDefault, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByLayout(
    dynamic layout,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationLayout, layout, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByWidgets(
    dynamic widgets,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationWidgets, widgets, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByFilters(
    dynamic filters,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationFilters, filters, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByTimeRange(
    String timeRange,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationTimeRange, timeRange, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByIsPublic(
    bool isPublic,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationIsPublic, isPublic, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getBySharedWith(
    String sharedWith,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationSharedWith, sharedWith, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<DashboardConfiguration> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}
    ) =>
    getManyIncluding(getDashboardConfigurationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    DashboardConfiguration dashboardConfiguration, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (dashboardConfiguration.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(dashboardConfiguration.orgId!, includes: includes);
        dashboardConfiguration.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    DashboardConfiguration dashboardConfiguration, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (dashboardConfiguration.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(dashboardConfiguration.userId!, includes: includes);
        dashboardConfiguration.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<DashboardConfiguration>> getAll$({bool useCache = true, ModelFilter<DashboardConfiguration>? modelFilter, List<DashboardConfigurationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: DashboardConfigurationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<DashboardConfiguration?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDashboardConfigurationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<DashboardConfiguration>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDashboardConfigurationUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDashboardConfigurationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByDashboardName$(
        String dashboardName,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDashboardConfigurationDashboardName,
        value: dashboardName,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByDashboardName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByIsDefault$(
        bool isDefault,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDashboardConfigurationIsDefault,
        value: isDefault,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByIsDefault,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByLayout$(
        dynamic layout,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDashboardConfigurationLayout,
        value: layout,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByLayout,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByWidgets$(
        dynamic widgets,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDashboardConfigurationWidgets,
        value: widgets,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByWidgets,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByFilters$(
        dynamic filters,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDashboardConfigurationFilters,
        value: filters,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByFilters,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByTimeRange$(
        String timeRange,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDashboardConfigurationTimeRange,
        value: timeRange,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByTimeRange,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByIsPublic$(
        bool isPublic,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDashboardConfigurationIsPublic,
        value: isPublic,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByIsPublic,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getBySharedWith$(
        String sharedWith,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDashboardConfigurationSharedWith,
        value: sharedWith,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyBySharedWith,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDashboardConfigurationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardConfiguration>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<DashboardConfiguration>? modelFilter,
        List<DashboardConfigurationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDashboardConfigurationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: DashboardConfigurationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    DashboardConfiguration dashboardConfiguration, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (dashboardConfiguration.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            dashboardConfiguration.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            dashboardConfiguration.org = org;
        });
    }
}

	Stream<User?> getUser$(
    DashboardConfiguration dashboardConfiguration, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (dashboardConfiguration.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            dashboardConfiguration.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            dashboardConfiguration.user = user;
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
DashboardConfiguration recursiveUpsert(DashboardConfiguration dashboardConfiguration, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'DashboardConfiguration'} 
        : const {};
    if (dashboardConfiguration.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        dashboardConfiguration.org = OrganizationStore.instance.recursiveUpsert(dashboardConfiguration.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (dashboardConfiguration.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        dashboardConfiguration.user = UserStore.instance.recursiveUpsert(dashboardConfiguration.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(dashboardConfiguration);
}

  List<DashboardConfiguration> recursiveListUpsert(List<DashboardConfiguration> dashboardConfigurations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedDashboardConfigurations = <DashboardConfiguration>[];
    for (var dashboardConfiguration in dashboardConfigurations) {
        updatedDashboardConfigurations.add(recursiveUpsert(dashboardConfiguration, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedDashboardConfigurations;
}

//   @override
//   DashboardConfiguration upsert(DashboardConfiguration item) {
//     return recursiveUpsert(item);
//   }

}


class DashboardConfigurationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      DashboardConfigurationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (dashboardConfiguration) => DashboardConfigurationStore.instance
            .getOrg$(dashboardConfiguration, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (dashboardConfiguration) => DashboardConfigurationStore.instance
            .getOrg(dashboardConfiguration, modelFilter: modelFilter, includes: includes);
      }
}

	DashboardConfigurationInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (dashboardConfiguration) => DashboardConfigurationStore.instance
            .getUser$(dashboardConfiguration, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (dashboardConfiguration) => DashboardConfigurationStore.instance
            .getUser(dashboardConfiguration, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum DashboardConfigurationEndpoints implements Endpoint {

    getAll('/dashboardConfiguration', HttpMethod.post, List<DashboardConfiguration>),
	getById('/dashboardConfiguration/byId/:id', HttpMethod.post, DashboardConfiguration),
	getManyByUserId('/dashboardConfiguration/byUserId/:userId', HttpMethod.post, List<DashboardConfiguration>),
	getManyByOrgId('/dashboardConfiguration/byOrgId/:orgId', HttpMethod.post, List<DashboardConfiguration>),
	getManyByDashboardName('/dashboardConfiguration/byDashboardName/:dashboardName', HttpMethod.post, List<DashboardConfiguration>),
	getManyByIsDefault('/dashboardConfiguration/byIsDefault/:isDefault', HttpMethod.post, List<DashboardConfiguration>),
	getManyByLayout('/dashboardConfiguration/byLayout/:layout', HttpMethod.post, List<DashboardConfiguration>),
	getManyByWidgets('/dashboardConfiguration/byWidgets/:widgets', HttpMethod.post, List<DashboardConfiguration>),
	getManyByFilters('/dashboardConfiguration/byFilters/:filters', HttpMethod.post, List<DashboardConfiguration>),
	getManyByTimeRange('/dashboardConfiguration/byTimeRange/:timeRange', HttpMethod.post, List<DashboardConfiguration>),
	getManyByIsPublic('/dashboardConfiguration/byIsPublic/:isPublic', HttpMethod.post, List<DashboardConfiguration>),
	getManyBySharedWith('/dashboardConfiguration/bySharedWith/:sharedWith', HttpMethod.post, List<DashboardConfiguration>),
	getManyByCreatedAt('/dashboardConfiguration/byCreatedAt/:createdAt', HttpMethod.post, List<DashboardConfiguration>),
	getManyByUpdatedAt('/dashboardConfiguration/byUpdatedAt/:updatedAt', HttpMethod.post, List<DashboardConfiguration>);

    const DashboardConfigurationEndpoints(this.path, this.method, this.responseType);

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
