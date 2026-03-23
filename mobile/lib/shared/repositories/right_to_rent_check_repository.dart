import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for RightToRentCheck operations
/// Provides CRUD operations with proper error handling and type safety
class RightToRentCheckRepository {
  final DioClient _dioClient;

  RightToRentCheckRepository(this._dioClient);

  /// Get RightToRentCheck by ID
  /// Returns [RightToRentCheck] if found, throws [RepositoryException] otherwise
  Future<RightToRentCheck> getRightToRentCheckById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/right_to_rent_check/$id');
      if (response.statusCode == 200) {
        return RightToRentCheck.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch right_to_rent_check',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all right_to_rent_checks with pagination and filtering
  /// Returns list of [RightToRentCheck] objects
  Future<List<RightToRentCheck>> getright_to_rent_checks({
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
      
      final response = await _dioClient.get('/api/v1/right_to_rent_check', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => RightToRentCheck.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch right_to_rent_checks',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new RightToRentCheck
  /// Returns created [RightToRentCheck] object
  Future<RightToRentCheck> createRightToRentCheck(RightToRentCheck rightToRentCheck) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/right_to_rent_check',
        data: rightToRentCheck.toJson(),
      );
      return RightToRentCheck.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RightToRentCheck
  Future<RightToRentCheck> updateRightToRentCheck(String id, RightToRentCheck rightToRentCheck) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/right_to_rent_check/$id',
        data: rightToRentCheck.toJson(),
      );
      return RightToRentCheck.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RightToRentCheck
  Future<void> deleteRightToRentCheck(String id) async {
    try {
      await _dioClient.delete('/api/v1/right_to_rent_check/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
