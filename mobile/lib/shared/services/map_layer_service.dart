import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MapLayerService {
  final DioClient _dioClient;
  MapLayerService(this._dioClient);

  Future<MapLayer> getMapLayerById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mapLayers}/$id');
    return MapLayer.fromJson(response.data['data']);
  }

  Future<List<MapLayer>> getMapLayers({
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
    final response = await _dioClient.get(ApiEndpoints.mapLayers, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MapLayer.fromJson(json)).toList();
  }

  Future<MapLayer> createMapLayer(MapLayer item) async {
    final response = await _dioClient.post(ApiEndpoints.mapLayers, data: item.toJson());
    return MapLayer.fromJson(response.data['data']);
  }

  Future<MapLayer> updateMapLayer(String id, MapLayer item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mapLayers}/$id', data: item.toJson());
    return MapLayer.fromJson(response.data['data']);
  }

  Future<void> deleteMapLayer(String id) async {
    await _dioClient.delete('${ApiEndpoints.mapLayers}/$id');
  }
}
