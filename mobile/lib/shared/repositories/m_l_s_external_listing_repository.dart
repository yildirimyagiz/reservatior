import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MLSExternalListing operations
/// Provides CRUD operations with proper error handling and type safety
class MLSExternalListingRepository {
  final DioClient _dioClient;

  MLSExternalListingRepository(this._dioClient);

  /// Get MLSExternalListing by ID
  /// Returns [MLSExternalListing] if found, throws [RepositoryException] otherwise
  Future<MLSExternalListing> getMLSExternalListingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_s_external_listing/$id');
      if (response.statusCode == 200) {
        return MLSExternalListing.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_s_external_listing',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all m_l_s_external_listings with pagination and filtering
  /// Returns list of [MLSExternalListing] objects
  Future<List<MLSExternalListing>> getm_l_s_external_listings({
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
      
      final response = await _dioClient.get('/api/v1/m_l_s_external_listing', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MLSExternalListing.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_s_external_listings',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MLSExternalListing
  /// Returns created [MLSExternalListing] object
  Future<MLSExternalListing> createMLSExternalListing(MLSExternalListing mLSExternalListing) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/m_l_s_external_listing',
        data: mLSExternalListing.toJson(),
      );
      return MLSExternalListing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MLSExternalListing
  Future<MLSExternalListing> updateMLSExternalListing(String id, MLSExternalListing mLSExternalListing) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/m_l_s_external_listing/$id',
        data: mLSExternalListing.toJson(),
      );
      return MLSExternalListing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MLSExternalListing
  Future<void> deleteMLSExternalListing(String id) async {
    try {
      await _dioClient.delete('/api/v1/m_l_s_external_listing/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
