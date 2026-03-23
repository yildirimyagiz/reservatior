
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MapLayerStore extends ModelStreamStore<String, MapLayer> {

  static MapLayerStore? _instance;

  static MapLayerStore get instance {
    _instance ??= MapLayerStore();
    return _instance!;
  }

  MapLayerStore() : super(MapLayer.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MapLayerStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MapLayerStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MapLayerStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMapLayerId(MapLayer mapLayer) => mapLayer.id;

	String? getMapLayerOrgId(MapLayer mapLayer) => mapLayer.orgId;

	String? getMapLayerName(MapLayer mapLayer) => mapLayer.name;

	String? getMapLayerType(MapLayer mapLayer) => mapLayer.type;

	MapProvider? getMapLayerProvider(MapLayer mapLayer) => mapLayer.provider;

	String? getMapLayerUrl(MapLayer mapLayer) => mapLayer.url;

	dynamic? getMapLayerConfig(MapLayer mapLayer) => mapLayer.config;

	bool? getMapLayerIsVisible(MapLayer mapLayer) => mapLayer.isVisible;

	double? getMapLayerOpacity(MapLayer mapLayer) => mapLayer.opacity;

	int? getMapLayerZIndex(MapLayer mapLayer) => mapLayer.zIndex;

	double? getMapLayerNorthEastLat(MapLayer mapLayer) => mapLayer.northEastLat;

	double? getMapLayerNorthEastLng(MapLayer mapLayer) => mapLayer.northEastLng;

	double? getMapLayerSouthWestLat(MapLayer mapLayer) => mapLayer.southWestLat;

	double? getMapLayerSouthWestLng(MapLayer mapLayer) => mapLayer.southWestLng;

	double? getMapLayerCenterLat(MapLayer mapLayer) => mapLayer.centerLat;

	double? getMapLayerCenterLng(MapLayer mapLayer) => mapLayer.centerLng;

	int? getMapLayerZoomLevel(MapLayer mapLayer) => mapLayer.zoomLevel;

	int? getMapLayerMinZoom(MapLayer mapLayer) => mapLayer.minZoom;

	int? getMapLayerMaxZoom(MapLayer mapLayer) => mapLayer.maxZoom;

	String? getMapLayerFillColor(MapLayer mapLayer) => mapLayer.fillColor;

	String? getMapLayerStrokeColor(MapLayer mapLayer) => mapLayer.strokeColor;

	double? getMapLayerStrokeWidth(MapLayer mapLayer) => mapLayer.strokeWidth;

	double? getMapLayerFillOpacity(MapLayer mapLayer) => mapLayer.fillOpacity;

	String? getMapLayerCreatedBy(MapLayer mapLayer) => mapLayer.createdBy;

	DateTime? getMapLayerCreatedAt(MapLayer mapLayer) => mapLayer.createdAt;

	DateTime? getMapLayerUpdatedAt(MapLayer mapLayer) => mapLayer.updatedAt;

	DateTime? getMapLayerDeletedAt(MapLayer mapLayer) => mapLayer.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MapLayer> getByOrgId(
    String orgId,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByName(
    String name,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerName, name, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByType(
    String type,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerType, type, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByProvider(
    MapProvider provider,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerProvider, provider, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByUrl(
    String url,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerUrl, url, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByConfig(
    dynamic config,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerConfig, config, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByIsVisible(
    bool isVisible,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerIsVisible, isVisible, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByOpacity(
    double opacity,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerOpacity, opacity, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByZIndex(
    int zIndex,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerZIndex, zIndex, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByNorthEastLat(
    double northEastLat,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerNorthEastLat, northEastLat, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByNorthEastLng(
    double northEastLng,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerNorthEastLng, northEastLng, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getBySouthWestLat(
    double southWestLat,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerSouthWestLat, southWestLat, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getBySouthWestLng(
    double southWestLng,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerSouthWestLng, southWestLng, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByCenterLat(
    double centerLat,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerCenterLat, centerLat, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByCenterLng(
    double centerLng,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerCenterLng, centerLng, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByZoomLevel(
    int zoomLevel,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerZoomLevel, zoomLevel, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByMinZoom(
    int minZoom,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerMinZoom, minZoom, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByMaxZoom(
    int maxZoom,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerMaxZoom, maxZoom, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByFillColor(
    String fillColor,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerFillColor, fillColor, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByStrokeColor(
    String strokeColor,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerStrokeColor, strokeColor, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByStrokeWidth(
    double strokeWidth,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerStrokeWidth, strokeWidth, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByFillOpacity(
    double fillOpacity,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerFillOpacity, fillOpacity, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByCreatedBy(
    String createdBy,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<MapLayer> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}
    ) =>
    getManyIncluding(getMapLayerDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    MapLayer mapLayer, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mapLayer.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mapLayer.orgId!, includes: includes);
        mapLayer.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MapLayer>> getAll$({bool useCache = true, ModelFilter<MapLayer>? modelFilter, List<MapLayerInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MapLayerEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MapLayer?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMapLayerId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MapLayer>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapLayerOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapLayerName,
        value: name,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapLayerType,
        value: type,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByProvider$(
        MapProvider provider,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<MapProvider>(
        getPropVal: getMapLayerProvider,
        value: provider,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByUrl$(
        String url,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapLayerUrl,
        value: url,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByConfig$(
        dynamic config,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMapLayerConfig,
        value: config,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByIsVisible$(
        bool isVisible,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMapLayerIsVisible,
        value: isVisible,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByIsVisible,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByOpacity$(
        double opacity,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerOpacity,
        value: opacity,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByOpacity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByZIndex$(
        int zIndex,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMapLayerZIndex,
        value: zIndex,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByZIndex,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByNorthEastLat$(
        double northEastLat,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerNorthEastLat,
        value: northEastLat,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByNorthEastLat,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByNorthEastLng$(
        double northEastLng,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerNorthEastLng,
        value: northEastLng,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByNorthEastLng,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getBySouthWestLat$(
        double southWestLat,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerSouthWestLat,
        value: southWestLat,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyBySouthWestLat,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getBySouthWestLng$(
        double southWestLng,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerSouthWestLng,
        value: southWestLng,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyBySouthWestLng,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByCenterLat$(
        double centerLat,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerCenterLat,
        value: centerLat,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByCenterLat,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByCenterLng$(
        double centerLng,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerCenterLng,
        value: centerLng,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByCenterLng,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByZoomLevel$(
        int zoomLevel,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMapLayerZoomLevel,
        value: zoomLevel,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByZoomLevel,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByMinZoom$(
        int minZoom,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMapLayerMinZoom,
        value: minZoom,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByMinZoom,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByMaxZoom$(
        int maxZoom,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMapLayerMaxZoom,
        value: maxZoom,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByMaxZoom,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByFillColor$(
        String fillColor,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapLayerFillColor,
        value: fillColor,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByFillColor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByStrokeColor$(
        String strokeColor,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapLayerStrokeColor,
        value: strokeColor,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByStrokeColor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByStrokeWidth$(
        double strokeWidth,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerStrokeWidth,
        value: strokeWidth,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByStrokeWidth,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByFillOpacity$(
        double fillOpacity,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMapLayerFillOpacity,
        value: fillOpacity,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByFillOpacity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapLayerCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMapLayerCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMapLayerUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapLayer>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<MapLayer>? modelFilter,
        List<MapLayerInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMapLayerDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MapLayerEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    MapLayer mapLayer, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mapLayer.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mapLayer.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mapLayer.org = org;
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
MapLayer recursiveUpsert(MapLayer mapLayer, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MapLayer'} 
        : const {};
    if (mapLayer.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mapLayer.org = OrganizationStore.instance.recursiveUpsert(mapLayer.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mapLayer);
}

  List<MapLayer> recursiveListUpsert(List<MapLayer> mapLayers, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMapLayers = <MapLayer>[];
    for (var mapLayer in mapLayers) {
        updatedMapLayers.add(recursiveUpsert(mapLayer, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMapLayers;
}

//   @override
//   MapLayer upsert(MapLayer item) {
//     return recursiveUpsert(item);
//   }

}


class MapLayerInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MapLayerInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mapLayer) => MapLayerStore.instance
            .getOrg$(mapLayer, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mapLayer) => MapLayerStore.instance
            .getOrg(mapLayer, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MapLayerEndpoints implements Endpoint {

    getAll('/mapLayer', HttpMethod.post, List<MapLayer>),
	getById('/mapLayer/byId/:id', HttpMethod.post, MapLayer),
	getManyByOrgId('/mapLayer/byOrgId/:orgId', HttpMethod.post, List<MapLayer>),
	getManyByName('/mapLayer/byName/:name', HttpMethod.post, List<MapLayer>),
	getManyByType('/mapLayer/byType/:type', HttpMethod.post, List<MapLayer>),
	getManyByProvider('/mapLayer/byProvider/:provider', HttpMethod.post, List<MapLayer>),
	getManyByUrl('/mapLayer/byUrl/:url', HttpMethod.post, List<MapLayer>),
	getManyByConfig('/mapLayer/byConfig/:config', HttpMethod.post, List<MapLayer>),
	getManyByIsVisible('/mapLayer/byIsVisible/:isVisible', HttpMethod.post, List<MapLayer>),
	getManyByOpacity('/mapLayer/byOpacity/:opacity', HttpMethod.post, List<MapLayer>),
	getManyByZIndex('/mapLayer/byZIndex/:zIndex', HttpMethod.post, List<MapLayer>),
	getManyByNorthEastLat('/mapLayer/byNorthEastLat/:northEastLat', HttpMethod.post, List<MapLayer>),
	getManyByNorthEastLng('/mapLayer/byNorthEastLng/:northEastLng', HttpMethod.post, List<MapLayer>),
	getManyBySouthWestLat('/mapLayer/bySouthWestLat/:southWestLat', HttpMethod.post, List<MapLayer>),
	getManyBySouthWestLng('/mapLayer/bySouthWestLng/:southWestLng', HttpMethod.post, List<MapLayer>),
	getManyByCenterLat('/mapLayer/byCenterLat/:centerLat', HttpMethod.post, List<MapLayer>),
	getManyByCenterLng('/mapLayer/byCenterLng/:centerLng', HttpMethod.post, List<MapLayer>),
	getManyByZoomLevel('/mapLayer/byZoomLevel/:zoomLevel', HttpMethod.post, List<MapLayer>),
	getManyByMinZoom('/mapLayer/byMinZoom/:minZoom', HttpMethod.post, List<MapLayer>),
	getManyByMaxZoom('/mapLayer/byMaxZoom/:maxZoom', HttpMethod.post, List<MapLayer>),
	getManyByFillColor('/mapLayer/byFillColor/:fillColor', HttpMethod.post, List<MapLayer>),
	getManyByStrokeColor('/mapLayer/byStrokeColor/:strokeColor', HttpMethod.post, List<MapLayer>),
	getManyByStrokeWidth('/mapLayer/byStrokeWidth/:strokeWidth', HttpMethod.post, List<MapLayer>),
	getManyByFillOpacity('/mapLayer/byFillOpacity/:fillOpacity', HttpMethod.post, List<MapLayer>),
	getManyByCreatedBy('/mapLayer/byCreatedBy/:createdBy', HttpMethod.post, List<MapLayer>),
	getManyByCreatedAt('/mapLayer/byCreatedAt/:createdAt', HttpMethod.post, List<MapLayer>),
	getManyByUpdatedAt('/mapLayer/byUpdatedAt/:updatedAt', HttpMethod.post, List<MapLayer>),
	getManyByDeletedAt('/mapLayer/byDeletedAt/:deletedAt', HttpMethod.post, List<MapLayer>);

    const MapLayerEndpoints(this.path, this.method, this.responseType);

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
