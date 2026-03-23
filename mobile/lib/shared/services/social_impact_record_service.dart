import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SocialImpactRecordService {
  final DioClient _dioClient;

  SocialImpactRecordService(this._dioClient);

  // Get SocialImpactRecord by ID
  Future<SocialImpactRecord> getSocialImpactRecordById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/social_impact_record/$id');
      return SocialImpactRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all social_impact_records
  Future<List<SocialImpactRecord>> getSocialImpactRecords({
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

      final response = await _dioClient.get('/api/v1/social_impact_record', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => SocialImpactRecord.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create SocialImpactRecord
  Future<SocialImpactRecord> createSocialImpactRecord(SocialImpactRecord socialImpactRecord) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/social_impact_record',
        data: socialImpactRecord.toJson(),
      );
      return SocialImpactRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SocialImpactRecord
  Future<SocialImpactRecord> updateSocialImpactRecord(String id, SocialImpactRecord socialImpactRecord) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/social_impact_record/$id',
        data: socialImpactRecord.toJson(),
      );
      return SocialImpactRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SocialImpactRecord
  Future<void> deleteSocialImpactRecord(String id) async {
    try {
      await _dioClient.delete('/api/v1/social_impact_record/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
