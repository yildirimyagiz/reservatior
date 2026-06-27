import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MapDataService {
  final DioClient _dioClient;
  MapDataService(this._dioClient);

  Future<MapData> getMapDataById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mapDatas}/$id');
    return MapData.fromJson(response.data['data']);
  }

  Future<List<MapData>> getMapDatas({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.mapDatas, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MapData.fromJson(json)).toList();
  }

  Future<MapData> createMapData(MapData item) async {
    final response = await _dioClient.post(ApiEndpoints.mapDatas, data: item.toJson());
    return MapData.fromJson(response.data['data']);
  }

  Future<MapData> updateMapData(String id, MapData item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mapDatas}/$id', data: item.toJson());
    return MapData.fromJson(response.data['data']);
  }

  Future<void> deleteMapData(String id) async {
    await _dioClient.delete('${ApiEndpoints.mapDatas}/$id');
  }
}
