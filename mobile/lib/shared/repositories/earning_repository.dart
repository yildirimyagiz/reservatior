import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Earning operations
/// Provides CRUD operations with proper error handling and type safety
class EarningRepository {
  final DioClient _dioClient;

  EarningRepository(this._dioClient);

  /// Get Earning by ID
  /// Returns [Earning] if found, throws [RepositoryException] otherwise
  Future<Earning> getEarningById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/earning/$id');
      if (response.statusCode == 200) {
        return Earning.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch earning',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all earnings with pagination and filtering
  /// Returns list of [Earning] objects
  Future<List<Earning>> getearnings({
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
      
      final response = await _dioClient.get('/api/v1/earning', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Earning.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch earnings',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Earning
  /// Returns created [Earning] object
  Future<Earning> createEarning(Earning earning) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/earning',
        data: earning.toJson(),
      );
      return Earning.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Earning
  Future<Earning> updateEarning(String id, Earning earning) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/earning/$id',
        data: earning.toJson(),
      );
      return Earning.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Earning
  Future<void> deleteEarning(String id) async {
    try {
      await _dioClient.delete('/api/v1/earning/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
