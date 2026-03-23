import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for SocialImpactRecord operations
/// Provides CRUD operations with proper error handling and type safety
class SocialImpactRecordRepository {
  final DioClient _dioClient;

  SocialImpactRecordRepository(this._dioClient);

  /// Get SocialImpactRecord by ID
  /// Returns [SocialImpactRecord] if found, throws [RepositoryException] otherwise
  Future<SocialImpactRecord> getSocialImpactRecordById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/social_impact_record/$id');
      if (response.statusCode == 200) {
        return SocialImpactRecord.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch social_impact_record',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all social_impact_records with pagination and filtering
  /// Returns list of [SocialImpactRecord] objects
  Future<List<SocialImpactRecord>> getsocial_impact_records({
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
      
      final response = await _dioClient.get('/api/v1/social_impact_record', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => SocialImpactRecord.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch social_impact_records',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new SocialImpactRecord
  /// Returns created [SocialImpactRecord] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
