
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MapDataStore extends ModelStreamStore<String, MapData> {

  static MapDataStore? _instance;

  static MapDataStore get instance {
    _instance ??= MapDataStore();
    return _instance!;
  }

  MapDataStore() : super(MapData.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MapDataStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MapDataStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MapDataStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMapDataId(MapData mapData) => mapData.id;

	String? getMapDataProjectId(MapData mapData) => mapData.projectId;

	dynamic? getMapDataCoordinates(MapData mapData) => mapData.coordinates;

	String? getMapDataAddress(MapData mapData) => mapData.address;

	String? getMapDataPlaceId(MapData mapData) => mapData.placeId;

	dynamic? getMapDataAmenities(MapData mapData) => mapData.amenities;

	dynamic? getMapDataGeocodingData(MapData mapData) => mapData.geocodingData;

	DateTime? getMapDataCreatedAt(MapData mapData) => mapData.createdAt;

	DateTime? getMapDataUpdatedAt(MapData mapData) => mapData.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MapData> getByProjectId(
    String projectId,
    {ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}
    ) =>
    getManyIncluding(getMapDataProjectId, projectId, modelFilter: modelFilter, includes: includes);

	
List<MapData> getByCoordinates(
    dynamic coordinates,
    {ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}
    ) =>
    getManyIncluding(getMapDataCoordinates, coordinates, modelFilter: modelFilter, includes: includes);

	
List<MapData> getByAddress(
    String address,
    {ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}
    ) =>
    getManyIncluding(getMapDataAddress, address, modelFilter: modelFilter, includes: includes);

	
List<MapData> getByPlaceId(
    String placeId,
    {ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}
    ) =>
    getManyIncluding(getMapDataPlaceId, placeId, modelFilter: modelFilter, includes: includes);

	
List<MapData> getByAmenities(
    dynamic amenities,
    {ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}
    ) =>
    getManyIncluding(getMapDataAmenities, amenities, modelFilter: modelFilter, includes: includes);

	
List<MapData> getByGeocodingData(
    dynamic geocodingData,
    {ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}
    ) =>
    getManyIncluding(getMapDataGeocodingData, geocodingData, modelFilter: modelFilter, includes: includes);

	
List<MapData> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}
    ) =>
    getManyIncluding(getMapDataCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MapData> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}
    ) =>
    getManyIncluding(getMapDataUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MapData>> getAll$({bool useCache = true, ModelFilter<MapData>? modelFilter, List<MapDataInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MapDataEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MapData?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMapDataId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MapData>> getByProjectId$(
        String projectId,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapDataProjectId,
        value: projectId,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getManyByProjectId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapData>> getByCoordinates$(
        dynamic coordinates,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMapDataCoordinates,
        value: coordinates,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getManyByCoordinates,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapData>> getByAddress$(
        String address,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapDataAddress,
        value: address,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getManyByAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapData>> getByPlaceId$(
        String placeId,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMapDataPlaceId,
        value: placeId,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getManyByPlaceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapData>> getByAmenities$(
        dynamic amenities,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMapDataAmenities,
        value: amenities,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getManyByAmenities,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapData>> getByGeocodingData$(
        dynamic geocodingData,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMapDataGeocodingData,
        value: geocodingData,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getManyByGeocodingData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapData>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMapDataCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MapData>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MapData>? modelFilter,
        List<MapDataInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMapDataUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MapDataEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
MapData recursiveUpsert(MapData mapData, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MapData'} 
        : const {};
    
    return super.upsert(mapData);
}

  List<MapData> recursiveListUpsert(List<MapData> mapDatas, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMapDatas = <MapData>[];
    for (var mapData in mapDatas) {
        updatedMapDatas.add(recursiveUpsert(mapData, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMapDatas;
}

//   @override
//   MapData upsert(MapData item) {
//     return recursiveUpsert(item);
//   }

}


class MapDataInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MapDataInclude.empty({this.useCache = true, this.useAsync = true});
  }


enum MapDataEndpoints implements Endpoint {

    getAll('/mapData', HttpMethod.post, List<MapData>),
	getById('/mapData/byId/:id', HttpMethod.post, MapData),
	getManyByProjectId('/mapData/byProjectId/:projectId', HttpMethod.post, List<MapData>),
	getManyByCoordinates('/mapData/byCoordinates/:coordinates', HttpMethod.post, List<MapData>),
	getManyByAddress('/mapData/byAddress/:address', HttpMethod.post, List<MapData>),
	getManyByPlaceId('/mapData/byPlaceId/:placeId', HttpMethod.post, List<MapData>),
	getManyByAmenities('/mapData/byAmenities/:amenities', HttpMethod.post, List<MapData>),
	getManyByGeocodingData('/mapData/byGeocodingData/:geocodingData', HttpMethod.post, List<MapData>),
	getManyByCreatedAt('/mapData/byCreatedAt/:createdAt', HttpMethod.post, List<MapData>),
	getManyByUpdatedAt('/mapData/byUpdatedAt/:updatedAt', HttpMethod.post, List<MapData>);

    const MapDataEndpoints(this.path, this.method, this.responseType);

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
