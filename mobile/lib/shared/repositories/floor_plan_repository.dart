import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for FloorPlan operations
/// Provides CRUD operations with proper error handling and type safety
class FloorPlanRepository {
  final DioClient _dioClient;

  FloorPlanRepository(this._dioClient);

  /// Get FloorPlan by ID
  /// Returns [FloorPlan] if found, throws [RepositoryException] otherwise
  Future<FloorPlan> getFloorPlanById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/floor_plan/$id');
      if (response.statusCode == 200) {
        return FloorPlan.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch floor_plan',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all floor_plans with pagination and filtering
  /// Returns list of [FloorPlan] objects
  Future<List<FloorPlan>> getfloor_plans({
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
      
      final response = await _dioClient.get('/api/v1/floor_plan', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => FloorPlan.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch floor_plans',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new FloorPlan
  /// Returns created [FloorPlan] object
  Future<FloorPlan> createFloorPlan(FloorPlan floorPlan) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/floor_plan',
        data: floorPlan.toJson(),
      );
      return FloorPlan.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update FloorPlan
  Future<FloorPlan> updateFloorPlan(String id, FloorPlan floorPlan) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/floor_plan/$id',
        data: floorPlan.toJson(),
      );
      return FloorPlan.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete FloorPlan
  Future<void> deleteFloorPlan(String id) async {
    try {
      await _dioClient.delete('/api/v1/floor_plan/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
