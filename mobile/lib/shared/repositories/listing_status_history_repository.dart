import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ListingStatusHistory operations
/// Provides CRUD operations with proper error handling and type safety
class ListingStatusHistoryRepository {
  final DioClient _dioClient;

  ListingStatusHistoryRepository(this._dioClient);

  /// Get ListingStatusHistory by ID
  /// Returns [ListingStatusHistory] if found, throws [RepositoryException] otherwise
  Future<ListingStatusHistory> getListingStatusHistoryById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/listing_status_history/$id');
      if (response.statusCode == 200) {
        return ListingStatusHistory.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch listing_status_history',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all listing_status_histories with pagination and filtering
  /// Returns list of [ListingStatusHistory] objects
  Future<List<ListingStatusHistory>> getlisting_status_histories({
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
      
      final response = await _dioClient.get('/api/v1/listing_status_history', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ListingStatusHistory.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch listing_status_histories',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ListingStatusHistory
  /// Returns created [ListingStatusHistory] object
  Future<ListingStatusHistory> createListingStatusHistory(ListingStatusHistory listingStatusHistory) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/listing_status_history',
        data: listingStatusHistory.toJson(),
      );
      return ListingStatusHistory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ListingStatusHistory
  Future<ListingStatusHistory> updateListingStatusHistory(String id, ListingStatusHistory listingStatusHistory) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/listing_status_history/$id',
        data: listingStatusHistory.toJson(),
      );
      return ListingStatusHistory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ListingStatusHistory
  Future<void> deleteListingStatusHistory(String id) async {
    try {
      await _dioClient.delete('/api/v1/listing_status_history/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
