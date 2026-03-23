import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MapLayerService {
  final DioClient _dioClient;

  MapLayerService(this._dioClient);

  // Get MapLayer by ID
  Future<MapLayer> getMapLayerById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/map_layer/$id');
      return MapLayer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all map_layers
  Future<List<MapLayer>> getMapLayers({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/map_layer', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MapLayer.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MapLayer
  Future<MapLayer> createMapLayer(MapLayer mapLayer) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/map_layer',
        data: mapLayer.toJson(),
      );
      return MapLayer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MapLayer
  Future<MapLayer> updateMapLayer(String id, MapLayer mapLayer) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/map_layer/$id',
        data: mapLayer.toJson(),
      );
      return MapLayer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MapLayer
  Future<void> deleteMapLayer(String id) async {
    try {
      await _dioClient.delete('/api/v1/map_layer/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
