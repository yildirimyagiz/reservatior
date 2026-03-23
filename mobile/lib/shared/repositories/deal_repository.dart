import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Deal operations
/// Provides CRUD operations with proper error handling and type safety
class DealRepository {
  final DioClient _dioClient;

  DealRepository(this._dioClient);

  /// Get Deal by ID
  /// Returns [Deal] if found, throws [RepositoryException] otherwise
  Future<Deal> getDealById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/deal/$id');
      if (response.statusCode == 200) {
        return Deal.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch deal',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all deals with pagination and filtering
  /// Returns list of [Deal] objects
  Future<List<Deal>> getdeals({
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
      
      final response = await _dioClient.get('/api/v1/deal', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Deal.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch deals',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Deal
  /// Returns created [Deal] object
  Future<Deal> createDeal(Deal deal) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/deal',
        data: deal.toJson(),
      );
      return Deal.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Deal
  Future<Deal> updateDeal(String id, Deal deal) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/deal/$id',
        data: deal.toJson(),
      );
      return Deal.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Deal
  Future<void> deleteDeal(String id) async {
    try {
      await _dioClient.delete('/api/v1/deal/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
