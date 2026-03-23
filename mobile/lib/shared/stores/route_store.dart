
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class RouteStore extends ModelStreamStore<String, Route> {

  static RouteStore? _instance;

  static RouteStore get instance {
    _instance ??= RouteStore();
    return _instance!;
  }

  RouteStore() : super(Route.fromJson) {
    if (_instance != null) {
        throw Exception(
            'RouteStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending RouteStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use RouteStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getRouteId(Route route) => route.id;

	String? getRouteOrgId(Route route) => route.orgId;

	String? getRouteName(Route route) => route.name;

	String? getRouteType(Route route) => route.type;

	String? getRouteStartLocationId(Route route) => route.startLocationId;

	String? getRouteEndLocationId(Route route) => route.endLocationId;

	dynamic? getRouteWaypoints(Route route) => route.waypoints;

	double? getRouteDistance(Route route) => route.distance;

	int? getRouteDuration(Route route) => route.duration;

	String? getRoutePolyline(Route route) => route.polyline;

	MapProvider? getRouteProvider(Route route) => route.provider;

	dynamic? getRouteInstructions(Route route) => route.instructions;

	dynamic? getRouteTrafficData(Route route) => route.trafficData;

	double? getRouteTolls(Route route) => route.tolls;

	bool? getRouteIsVisible(Route route) => route.isVisible;

	String? getRouteColor(Route route) => route.color;

	int? getRouteStrokeWidth(Route route) => route.strokeWidth;

	double? getRouteOpacity(Route route) => route.opacity;

	String? getRouteCreatedBy(Route route) => route.createdBy;

	DateTime? getRouteCreatedAt(Route route) => route.createdAt;

	DateTime? getRouteUpdatedAt(Route route) => route.updatedAt;

	DateTime? getRouteDeletedAt(Route route) => route.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Route> getByOrgId(
    String orgId,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Route> getByName(
    String name,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteName, name, modelFilter: modelFilter, includes: includes);

	
List<Route> getByType(
    String type,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteType, type, modelFilter: modelFilter, includes: includes);

	
List<Route> getByStartLocationId(
    String startLocationId,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteStartLocationId, startLocationId, modelFilter: modelFilter, includes: includes);

	
List<Route> getByEndLocationId(
    String endLocationId,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteEndLocationId, endLocationId, modelFilter: modelFilter, includes: includes);

	
List<Route> getByWaypoints(
    dynamic waypoints,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteWaypoints, waypoints, modelFilter: modelFilter, includes: includes);

	
List<Route> getByDistance(
    double distance,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteDistance, distance, modelFilter: modelFilter, includes: includes);

	
List<Route> getByDuration(
    int duration,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteDuration, duration, modelFilter: modelFilter, includes: includes);

	
List<Route> getByPolyline(
    String polyline,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRoutePolyline, polyline, modelFilter: modelFilter, includes: includes);

	
List<Route> getByProvider(
    MapProvider provider,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteProvider, provider, modelFilter: modelFilter, includes: includes);

	
List<Route> getByInstructions(
    dynamic instructions,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteInstructions, instructions, modelFilter: modelFilter, includes: includes);

	
List<Route> getByTrafficData(
    dynamic trafficData,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteTrafficData, trafficData, modelFilter: modelFilter, includes: includes);

	
List<Route> getByTolls(
    double tolls,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteTolls, tolls, modelFilter: modelFilter, includes: includes);

	
List<Route> getByIsVisible(
    bool isVisible,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteIsVisible, isVisible, modelFilter: modelFilter, includes: includes);

	
List<Route> getByColor(
    String color,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteColor, color, modelFilter: modelFilter, includes: includes);

	
List<Route> getByStrokeWidth(
    int strokeWidth,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteStrokeWidth, strokeWidth, modelFilter: modelFilter, includes: includes);

	
List<Route> getByOpacity(
    double opacity,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteOpacity, opacity, modelFilter: modelFilter, includes: includes);

	
List<Route> getByCreatedBy(
    String createdBy,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Route> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Route> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Route> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}
    ) =>
    getManyIncluding(getRouteDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Location? getEndLocation(
    Route route, {ModelFilter? modelFilter, List<LocationInclude>? includes}) {
    if (route.endLocationId == null) {
        return null;
    } else {
        final endLocation = LocationStore.instance.getById(route.endLocationId!, includes: includes);
        route.endLocation = endLocation;
        // setIncludedReferences(endLocation, includes: includes);
        return endLocation;
    }
}

	Organization? getOrg(
    Route route, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (route.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(route.orgId!, includes: includes);
        route.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Location? getStartLocation(
    Route route, {ModelFilter? modelFilter, List<LocationInclude>? includes}) {
    if (route.startLocationId == null) {
        return null;
    } else {
        final startLocation = LocationStore.instance.getById(route.startLocationId!, includes: includes);
        route.startLocation = startLocation;
        // setIncludedReferences(startLocation, includes: includes);
        return startLocation;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Route>> getAll$({bool useCache = true, ModelFilter<Route>? modelFilter, List<RouteInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: RouteEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Route?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getRouteId,
        value: id,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Route>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRouteOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRouteName,
        value: name,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRouteType,
        value: type,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByStartLocationId$(
        String startLocationId,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRouteStartLocationId,
        value: startLocationId,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByStartLocationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByEndLocationId$(
        String endLocationId,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRouteEndLocationId,
        value: endLocationId,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByEndLocationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByWaypoints$(
        dynamic waypoints,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getRouteWaypoints,
        value: waypoints,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByWaypoints,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByDistance$(
        double distance,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRouteDistance,
        value: distance,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByDistance,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByDuration$(
        int duration,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getRouteDuration,
        value: duration,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByDuration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByPolyline$(
        String polyline,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRoutePolyline,
        value: polyline,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByPolyline,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByProvider$(
        MapProvider provider,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<MapProvider>(
        getPropVal: getRouteProvider,
        value: provider,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByInstructions$(
        dynamic instructions,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getRouteInstructions,
        value: instructions,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByInstructions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByTrafficData$(
        dynamic trafficData,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getRouteTrafficData,
        value: trafficData,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByTrafficData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByTolls$(
        double tolls,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRouteTolls,
        value: tolls,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByTolls,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByIsVisible$(
        bool isVisible,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getRouteIsVisible,
        value: isVisible,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByIsVisible,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByColor$(
        String color,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRouteColor,
        value: color,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByColor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByStrokeWidth$(
        int strokeWidth,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getRouteStrokeWidth,
        value: strokeWidth,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByStrokeWidth,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByOpacity$(
        double opacity,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getRouteOpacity,
        value: opacity,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByOpacity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRouteCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRouteCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRouteUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Route>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Route>? modelFilter,
        List<RouteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRouteDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: RouteEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Location?> getEndLocation$(
    Route route, {bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    if (route.endLocationId == null) {
        return Stream.value(null);
    } else {
        return LocationStore.instance.getById$(
            route.endLocationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((endLocation) {
            route.endLocation = endLocation;
        });
    }
}

	Stream<Organization?> getOrg$(
    Route route, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (route.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            route.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            route.org = org;
        });
    }
}

	Stream<Location?> getStartLocation$(
    Route route, {bool useCache = true, ModelFilter<Location>? modelFilter, List<LocationInclude>? includes}) {
    if (route.startLocationId == null) {
        return Stream.value(null);
    } else {
        return LocationStore.instance.getById$(
            route.startLocationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((startLocation) {
            route.startLocation = startLocation;
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
Route recursiveUpsert(Route route, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Route'} 
        : const {};
    if (route.endLocation != null && (!preventCircularSerialization || !upsertedTypes.contains('Location'))) {
        route.endLocation = LocationStore.instance.recursiveUpsert(route.endLocation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (route.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        route.org = OrganizationStore.instance.recursiveUpsert(route.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (route.startLocation != null && (!preventCircularSerialization || !upsertedTypes.contains('Location'))) {
        route.startLocation = LocationStore.instance.recursiveUpsert(route.startLocation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(route);
}

  List<Route> recursiveListUpsert(List<Route> routes, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedRoutes = <Route>[];
    for (var route in routes) {
        updatedRoutes.add(recursiveUpsert(route, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedRoutes;
}

//   @override
//   Route upsert(Route item) {
//     return recursiveUpsert(item);
//   }

}


class RouteInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      RouteInclude.endLocation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Location>? modelFilter,
    List<LocationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (route) => RouteStore.instance
            .getEndLocation$(route, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (route) => RouteStore.instance
            .getEndLocation(route, modelFilter: modelFilter, includes: includes);
      }
}

	RouteInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (route) => RouteStore.instance
            .getOrg$(route, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (route) => RouteStore.instance
            .getOrg(route, modelFilter: modelFilter, includes: includes);
      }
}

	RouteInclude.startLocation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Location>? modelFilter,
    List<LocationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (route) => RouteStore.instance
            .getStartLocation$(route, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (route) => RouteStore.instance
            .getStartLocation(route, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum RouteEndpoints implements Endpoint {

    getAll('/route', HttpMethod.post, List<Route>),
	getById('/route/byId/:id', HttpMethod.post, Route),
	getManyByOrgId('/route/byOrgId/:orgId', HttpMethod.post, List<Route>),
	getManyByName('/route/byName/:name', HttpMethod.post, List<Route>),
	getManyByType('/route/byType/:type', HttpMethod.post, List<Route>),
	getManyByStartLocationId('/route/byStartLocationId/:startLocationId', HttpMethod.post, List<Route>),
	getManyByEndLocationId('/route/byEndLocationId/:endLocationId', HttpMethod.post, List<Route>),
	getManyByWaypoints('/route/byWaypoints/:waypoints', HttpMethod.post, List<Route>),
	getManyByDistance('/route/byDistance/:distance', HttpMethod.post, List<Route>),
	getManyByDuration('/route/byDuration/:duration', HttpMethod.post, List<Route>),
	getManyByPolyline('/route/byPolyline/:polyline', HttpMethod.post, List<Route>),
	getManyByProvider('/route/byProvider/:provider', HttpMethod.post, List<Route>),
	getManyByInstructions('/route/byInstructions/:instructions', HttpMethod.post, List<Route>),
	getManyByTrafficData('/route/byTrafficData/:trafficData', HttpMethod.post, List<Route>),
	getManyByTolls('/route/byTolls/:tolls', HttpMethod.post, List<Route>),
	getManyByIsVisible('/route/byIsVisible/:isVisible', HttpMethod.post, List<Route>),
	getManyByColor('/route/byColor/:color', HttpMethod.post, List<Route>),
	getManyByStrokeWidth('/route/byStrokeWidth/:strokeWidth', HttpMethod.post, List<Route>),
	getManyByOpacity('/route/byOpacity/:opacity', HttpMethod.post, List<Route>),
	getManyByCreatedBy('/route/byCreatedBy/:createdBy', HttpMethod.post, List<Route>),
	getManyByCreatedAt('/route/byCreatedAt/:createdAt', HttpMethod.post, List<Route>),
	getManyByUpdatedAt('/route/byUpdatedAt/:updatedAt', HttpMethod.post, List<Route>),
	getManyByDeletedAt('/route/byDeletedAt/:deletedAt', HttpMethod.post, List<Route>);

    const RouteEndpoints(this.path, this.method, this.responseType);

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
