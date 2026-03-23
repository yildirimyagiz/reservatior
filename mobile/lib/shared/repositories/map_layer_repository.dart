import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MapLayer operations
/// Provides CRUD operations with proper error handling and type safety
class MapLayerRepository {
  final DioClient _dioClient;

  MapLayerRepository(this._dioClient);

  /// Get MapLayer by ID
  /// Returns [MapLayer] if found, throws [RepositoryException] otherwise
  Future<MapLayer> getMapLayerById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/map_layer/$id');
      if (response.statusCode == 200) {
        return MapLayer.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch map_layer',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all map_layers with pagination and filtering
  /// Returns list of [MapLayer] objects
  Future<List<MapLayer>> getmap_layers({
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
      
      final response = await _dioClient.get('/api/v1/map_layer', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MapLayer.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch map_layers',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MapLayer
  /// Returns created [MapLayer] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
