import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MapData operations
/// Provides CRUD operations with proper error handling and type safety
class MapDataRepository {
  final DioClient _dioClient;

  MapDataRepository(this._dioClient);

  /// Get MapData by ID
  /// Returns [MapData] if found, throws [RepositoryException] otherwise
  Future<MapData> getMapDataById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/map_data/$id');
      if (response.statusCode == 200) {
        return MapData.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch map_data',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all map_datas with pagination and filtering
  /// Returns list of [MapData] objects
  Future<List<MapData>> getmap_datas({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/map_data', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MapData.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch map_datas',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MapData
  /// Returns created [MapData] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
