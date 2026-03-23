import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SocialImpactCounterService {
  final DioClient _dioClient;

  SocialImpactCounterService(this._dioClient);

  // Get SocialImpactCounter by ID
  Future<SocialImpactCounter> getSocialImpactCounterById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/social_impact_counter/$id');
      return SocialImpactCounter.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all social_impact_counters
  Future<List<SocialImpactCounter>> getSocialImpactCounters({
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

      final response = await _dioClient.get('/api/v1/social_impact_counter', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => SocialImpactCounter.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create SocialImpactCounter
  Future<SocialImpactCounter> createSocialImpactCounter(SocialImpactCounter socialImpactCounter) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/social_impact_counter',
        data: socialImpactCounter.toJson(),
      );
      return SocialImpactCounter.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SocialImpactCounter
  Future<SocialImpactCounter> updateSocialImpactCounter(String id, SocialImpactCounter socialImpactCounter) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/social_impact_counter/$id',
        data: socialImpactCounter.toJson(),
      );
      return SocialImpactCounter.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SocialImpactCounter
  Future<void> deleteSocialImpactCounter(String id) async {
    try {
      await _dioClient.delete('/api/v1/social_impact_counter/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
