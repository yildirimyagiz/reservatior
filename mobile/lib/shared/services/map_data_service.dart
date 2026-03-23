import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MapDataService {
  final DioClient _dioClient;

  MapDataService(this._dioClient);

  // Get MapData by ID
  Future<MapData> getMapDataById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/map_data/$id');
      return MapData.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all map_datas
  Future<List<MapData>> getMapDatas({
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

      final response = await _dioClient.get('/api/v1/map_data', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MapData.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MapData
  Future<MapData> createMapData(MapData mapData) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/map_data',
        data: mapData.toJson(),
      );
      return MapData.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MapData
  Future<MapData> updateMapData(String id, MapData mapData) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/map_data/$id',
        data: mapData.toJson(),
      );
      return MapData.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MapData
  Future<void> deleteMapData(String id) async {
    try {
      await _dioClient.delete('/api/v1/map_data/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
