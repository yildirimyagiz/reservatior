import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Verification operations
/// Provides CRUD operations with proper error handling and type safety
class VerificationRepository {
  final DioClient _dioClient;

  VerificationRepository(this._dioClient);

  /// Get Verification by ID
  /// Returns [Verification] if found, throws [RepositoryException] otherwise
  Future<Verification> getVerificationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/verification/$id');
      if (response.statusCode == 200) {
        return Verification.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch verification',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all verifications with pagination and filtering
  /// Returns list of [Verification] objects
  Future<List<Verification>> getverifications({
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
      
      final response = await _dioClient.get('/api/v1/verification', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Verification.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch verifications',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Verification
  /// Returns created [Verification] object
  Future<Verification> createVerification(Verification verification) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/verification',
        data: verification.toJson(),
      );
      return Verification.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Verification
  Future<Verification> updateVerification(String id, Verification verification) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/verification/$id',
        data: verification.toJson(),
      );
      return Verification.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Verification
  Future<void> deleteVerification(String id) async {
    try {
      await _dioClient.delete('/api/v1/verification/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
