
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class DashboardWidgetStore extends ModelStreamStore<String, DashboardWidget> {

  static DashboardWidgetStore? _instance;

  static DashboardWidgetStore get instance {
    _instance ??= DashboardWidgetStore();
    return _instance!;
  }

  DashboardWidgetStore() : super(DashboardWidget.fromJson) {
    if (_instance != null) {
        throw Exception(
            'DashboardWidgetStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending DashboardWidgetStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use DashboardWidgetStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getDashboardWidgetId(DashboardWidget dashboardWidget) => dashboardWidget.id;

	String? getDashboardWidgetUserId(DashboardWidget dashboardWidget) => dashboardWidget.userId;

	String? getDashboardWidgetOrgId(DashboardWidget dashboardWidget) => dashboardWidget.orgId;

	WidgetType? getDashboardWidgetWidgetType(DashboardWidget dashboardWidget) => dashboardWidget.widgetType;

	String? getDashboardWidgetTitle(DashboardWidget dashboardWidget) => dashboardWidget.title;

	dynamic? getDashboardWidgetConfig(DashboardWidget dashboardWidget) => dashboardWidget.config;

	dynamic? getDashboardWidgetPosition(DashboardWidget dashboardWidget) => dashboardWidget.position;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<DashboardWidget> getByUserId(
    String userId,
    {ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}
    ) =>
    getManyIncluding(getDashboardWidgetUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<DashboardWidget> getByOrgId(
    String orgId,
    {ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}
    ) =>
    getManyIncluding(getDashboardWidgetOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<DashboardWidget> getByWidgetType(
    WidgetType widgetType,
    {ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}
    ) =>
    getManyIncluding(getDashboardWidgetWidgetType, widgetType, modelFilter: modelFilter, includes: includes);

	
List<DashboardWidget> getByTitle(
    String title,
    {ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}
    ) =>
    getManyIncluding(getDashboardWidgetTitle, title, modelFilter: modelFilter, includes: includes);

	
List<DashboardWidget> getByConfig(
    dynamic config,
    {ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}
    ) =>
    getManyIncluding(getDashboardWidgetConfig, config, modelFilter: modelFilter, includes: includes);

	
List<DashboardWidget> getByPosition(
    dynamic position,
    {ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}
    ) =>
    getManyIncluding(getDashboardWidgetPosition, position, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    DashboardWidget dashboardWidget, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (dashboardWidget.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(dashboardWidget.orgId!, includes: includes);
        dashboardWidget.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    DashboardWidget dashboardWidget, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (dashboardWidget.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(dashboardWidget.userId!, includes: includes);
        dashboardWidget.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<DashboardWidget>> getAll$({bool useCache = true, ModelFilter<DashboardWidget>? modelFilter, List<DashboardWidgetInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: DashboardWidgetEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<DashboardWidget?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<DashboardWidget>? modelFilter,
        List<DashboardWidgetInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDashboardWidgetId,
        value: id,
        modelFilter: modelFilter,
        endpoint: DashboardWidgetEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<DashboardWidget>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<DashboardWidget>? modelFilter,
        List<DashboardWidgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDashboardWidgetUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: DashboardWidgetEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardWidget>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<DashboardWidget>? modelFilter,
        List<DashboardWidgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDashboardWidgetOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: DashboardWidgetEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardWidget>> getByWidgetType$(
        WidgetType widgetType,
        {bool useCache = true,
        ModelFilter<DashboardWidget>? modelFilter,
        List<DashboardWidgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<WidgetType>(
        getPropVal: getDashboardWidgetWidgetType,
        value: widgetType,
        modelFilter: modelFilter,
        endpoint: DashboardWidgetEndpoints.getManyByWidgetType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardWidget>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<DashboardWidget>? modelFilter,
        List<DashboardWidgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDashboardWidgetTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: DashboardWidgetEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardWidget>> getByConfig$(
        dynamic config,
        {bool useCache = true,
        ModelFilter<DashboardWidget>? modelFilter,
        List<DashboardWidgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDashboardWidgetConfig,
        value: config,
        modelFilter: modelFilter,
        endpoint: DashboardWidgetEndpoints.getManyByConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DashboardWidget>> getByPosition$(
        dynamic position,
        {bool useCache = true,
        ModelFilter<DashboardWidget>? modelFilter,
        List<DashboardWidgetInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDashboardWidgetPosition,
        value: position,
        modelFilter: modelFilter,
        endpoint: DashboardWidgetEndpoints.getManyByPosition,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    DashboardWidget dashboardWidget, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (dashboardWidget.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            dashboardWidget.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            dashboardWidget.org = org;
        });
    }
}

	Stream<User?> getUser$(
    DashboardWidget dashboardWidget, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (dashboardWidget.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            dashboardWidget.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            dashboardWidget.user = user;
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
DashboardWidget recursiveUpsert(DashboardWidget dashboardWidget, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'DashboardWidget'} 
        : const {};
    if (dashboardWidget.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        dashboardWidget.org = OrganizationStore.instance.recursiveUpsert(dashboardWidget.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (dashboardWidget.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        dashboardWidget.user = UserStore.instance.recursiveUpsert(dashboardWidget.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(dashboardWidget);
}

  List<DashboardWidget> recursiveListUpsert(List<DashboardWidget> dashboardWidgets, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedDashboardWidgets = <DashboardWidget>[];
    for (var dashboardWidget in dashboardWidgets) {
        updatedDashboardWidgets.add(recursiveUpsert(dashboardWidget, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedDashboardWidgets;
}

//   @override
//   DashboardWidget upsert(DashboardWidget item) {
//     return recursiveUpsert(item);
//   }

}


class DashboardWidgetInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      DashboardWidgetInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (dashboardWidget) => DashboardWidgetStore.instance
            .getOrg$(dashboardWidget, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (dashboardWidget) => DashboardWidgetStore.instance
            .getOrg(dashboardWidget, modelFilter: modelFilter, includes: includes);
      }
}

	DashboardWidgetInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (dashboardWidget) => DashboardWidgetStore.instance
            .getUser$(dashboardWidget, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (dashboardWidget) => DashboardWidgetStore.instance
            .getUser(dashboardWidget, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum DashboardWidgetEndpoints implements Endpoint {

    getAll('/dashboardWidget', HttpMethod.post, List<DashboardWidget>),
	getById('/dashboardWidget/byId/:id', HttpMethod.post, DashboardWidget),
	getManyByUserId('/dashboardWidget/byUserId/:userId', HttpMethod.post, List<DashboardWidget>),
	getManyByOrgId('/dashboardWidget/byOrgId/:orgId', HttpMethod.post, List<DashboardWidget>),
	getManyByWidgetType('/dashboardWidget/byWidgetType/:widgetType', HttpMethod.post, List<DashboardWidget>),
	getManyByTitle('/dashboardWidget/byTitle/:title', HttpMethod.post, List<DashboardWidget>),
	getManyByConfig('/dashboardWidget/byConfig/:config', HttpMethod.post, List<DashboardWidget>),
	getManyByPosition('/dashboardWidget/byPosition/:position', HttpMethod.post, List<DashboardWidget>);

    const DashboardWidgetEndpoints(this.path, this.method, this.responseType);

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
