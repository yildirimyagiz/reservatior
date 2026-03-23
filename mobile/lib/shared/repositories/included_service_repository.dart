import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for IncludedService operations
/// Provides CRUD operations with proper error handling and type safety
class IncludedServiceRepository {
  final DioClient _dioClient;

  IncludedServiceRepository(this._dioClient);

  /// Get IncludedService by ID
  /// Returns [IncludedService] if found, throws [RepositoryException] otherwise
  Future<IncludedService> getIncludedServiceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/included_service/$id');
      if (response.statusCode == 200) {
        return IncludedService.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch included_service',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all included_services with pagination and filtering
  /// Returns list of [IncludedService] objects
  Future<List<IncludedService>> getincluded_services({
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
      
      final response = await _dioClient.get('/api/v1/included_service', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => IncludedService.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch included_services',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new IncludedService
  /// Returns created [IncludedService] object
  Future<IncludedService> createIncludedService(IncludedService includedService) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/included_service',
        data: includedService.toJson(),
      );
      return IncludedService.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update IncludedService
  Future<IncludedService> updateIncludedService(String id, IncludedService includedService) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/included_service/$id',
        data: includedService.toJson(),
      );
      return IncludedService.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete IncludedService
  Future<void> deleteIncludedService(String id) async {
    try {
      await _dioClient.delete('/api/v1/included_service/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
