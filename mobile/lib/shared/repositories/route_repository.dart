import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Route operations
/// Provides CRUD operations with proper error handling and type safety
class RouteRepository {
  final DioClient _dioClient;

  RouteRepository(this._dioClient);

  /// Get Route by ID
  /// Returns [Route] if found, throws [RepositoryException] otherwise
  Future<Route> getRouteById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/route/$id');
      if (response.statusCode == 200) {
        return Route.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch route',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all routes with pagination and filtering
  /// Returns list of [Route] objects
  Future<List<Route>> getroutes({
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
      
      final response = await _dioClient.get('/api/v1/route', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Route.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch routes',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Route
  /// Returns created [Route] object
  Future<Route> createRoute(Route route) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/route',
        data: route.toJson(),
      );
      return Route.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Route
  Future<Route> updateRoute(String id, Route route) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/route/$id',
        data: route.toJson(),
      );
      return Route.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Route
  Future<void> deleteRoute(String id) async {
    try {
      await _dioClient.delete('/api/v1/route/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
