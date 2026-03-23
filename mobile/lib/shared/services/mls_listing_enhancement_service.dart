import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MlsListingEnhancementService {
  final DioClient _dioClient;

  MlsListingEnhancementService(this._dioClient);

  // Get MlsListingEnhancement by ID
  Future<MlsListingEnhancement> getMlsListingEnhancementById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mls_listing_enhancement/$id');
      return MlsListingEnhancement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all mls_listing_enhancements
  Future<List<MlsListingEnhancement>> getMlsListingEnhancements({
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

      final response = await _dioClient.get('/api/v1/mls_listing_enhancement', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MlsListingEnhancement.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MlsListingEnhancement
  Future<MlsListingEnhancement> createMlsListingEnhancement(MlsListingEnhancement mlsListingEnhancement) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mls_listing_enhancement',
        data: mlsListingEnhancement.toJson(),
      );
      return MlsListingEnhancement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MlsListingEnhancement
  Future<MlsListingEnhancement> updateMlsListingEnhancement(String id, MlsListingEnhancement mlsListingEnhancement) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mls_listing_enhancement/$id',
        data: mlsListingEnhancement.toJson(),
      );
      return MlsListingEnhancement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MlsListingEnhancement
  Future<void> deleteMlsListingEnhancement(String id) async {
    try {
      await _dioClient.delete('/api/v1/mls_listing_enhancement/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
