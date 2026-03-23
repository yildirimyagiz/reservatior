import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Increase operations
/// Provides CRUD operations with proper error handling and type safety
class IncreaseRepository {
  final DioClient _dioClient;

  IncreaseRepository(this._dioClient);

  /// Get Increase by ID
  /// Returns [Increase] if found, throws [RepositoryException] otherwise
  Future<Increase> getIncreaseById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/increase/$id');
      if (response.statusCode == 200) {
        return Increase.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch increase',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all increases with pagination and filtering
  /// Returns list of [Increase] objects
  Future<List<Increase>> getincreases({
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
      
      final response = await _dioClient.get('/api/v1/increase', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Increase.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch increases',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Increase
  /// Returns created [Increase] object
  Future<Increase> createIncrease(Increase increase) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/increase',
        data: increase.toJson(),
      );
      return Increase.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Increase
  Future<Increase> updateIncrease(String id, Increase increase) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/increase/$id',
        data: increase.toJson(),
      );
      return Increase.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Increase
  Future<void> deleteIncrease(String id) async {
    try {
      await _dioClient.delete('/api/v1/increase/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
