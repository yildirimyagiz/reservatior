import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MLSExternalListingService {
  final DioClient _dioClient;

  MLSExternalListingService(this._dioClient);

  // Get MLSExternalListing by ID
  Future<MLSExternalListing> getMLSExternalListingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_s_external_listing/$id');
      return MLSExternalListing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all m_l_s_external_listings
  Future<List<MLSExternalListing>> getMLSExternalListings({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/m_l_s_external_listing', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MLSExternalListing.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MLSExternalListing
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
    return Exception('API Error: ${e.message}');
  }
}
