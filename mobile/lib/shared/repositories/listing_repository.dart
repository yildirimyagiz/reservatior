import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Listing operations
/// Provides CRUD operations with proper error handling and type safety
class ListingRepository {
  final DioClient _dioClient;

  ListingRepository(this._dioClient);

  /// Get Listing by ID
  /// Returns [Listing] if found, throws [RepositoryException] otherwise
  Future<Listing> getListingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/listing/$id');
      if (response.statusCode == 200) {
        return Listing.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch listing',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all listings with pagination and filtering
  /// Returns list of [Listing] objects
  Future<List<Listing>> getlistings({
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
      
      final response = await _dioClient.get('/api/v1/listing', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Listing.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch listings',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Listing
  /// Returns created [Listing] object
  Future<Listing> createListing(Listing listing) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/listing',
        data: listing.toJson(),
      );
      return Listing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Listing
  Future<Listing> updateListing(String id, Listing listing) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/listing/$id',
        data: listing.toJson(),
      );
      return Listing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Listing
  Future<void> deleteListing(String id) async {
    try {
      await _dioClient.delete('/api/v1/listing/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
