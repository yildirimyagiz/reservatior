import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ListingTag operations
/// Provides CRUD operations with proper error handling and type safety
class ListingTagRepository {
  final DioClient _dioClient;

  ListingTagRepository(this._dioClient);

  /// Get ListingTag by ID
  /// Returns [ListingTag] if found, throws [RepositoryException] otherwise
  Future<ListingTag> getListingTagById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/listing_tag/$id');
      if (response.statusCode == 200) {
        return ListingTag.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch listing_tag',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all listing_tags with pagination and filtering
  /// Returns list of [ListingTag] objects
  Future<List<ListingTag>> getlisting_tags({
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
      
      final response = await _dioClient.get('/api/v1/listing_tag', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ListingTag.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch listing_tags',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ListingTag
  /// Returns created [ListingTag] object
  Future<ListingTag> createListingTag(ListingTag listingTag) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/listing_tag',
        data: listingTag.toJson(),
      );
      return ListingTag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ListingTag
  Future<ListingTag> updateListingTag(String id, ListingTag listingTag) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/listing_tag/$id',
        data: listingTag.toJson(),
      );
      return ListingTag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ListingTag
  Future<void> deleteListingTag(String id) async {
    try {
      await _dioClient.delete('/api/v1/listing_tag/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
