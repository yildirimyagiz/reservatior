import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ExternalRentalListing operations
/// Provides CRUD operations with proper error handling and type safety
class ExternalRentalListingRepository {
  final DioClient _dioClient;

  ExternalRentalListingRepository(this._dioClient);

  /// Get ExternalRentalListing by ID
  /// Returns [ExternalRentalListing] if found, throws [RepositoryException] otherwise
  Future<ExternalRentalListing> getExternalRentalListingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/external_rental_listing/$id');
      if (response.statusCode == 200) {
        return ExternalRentalListing.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch external_rental_listing',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all external_rental_listings with pagination and filtering
  /// Returns list of [ExternalRentalListing] objects
  Future<List<ExternalRentalListing>> getexternal_rental_listings({
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
      
      final response = await _dioClient.get('/api/v1/external_rental_listing', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ExternalRentalListing.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch external_rental_listings',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ExternalRentalListing
  /// Returns created [ExternalRentalListing] object
  Future<ExternalRentalListing> createExternalRentalListing(ExternalRentalListing externalRentalListing) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/external_rental_listing',
        data: externalRentalListing.toJson(),
      );
      return ExternalRentalListing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ExternalRentalListing
  Future<ExternalRentalListing> updateExternalRentalListing(String id, ExternalRentalListing externalRentalListing) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/external_rental_listing/$id',
        data: externalRentalListing.toJson(),
      );
      return ExternalRentalListing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ExternalRentalListing
  Future<void> deleteExternalRentalListing(String id) async {
    try {
      await _dioClient.delete('/api/v1/external_rental_listing/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
