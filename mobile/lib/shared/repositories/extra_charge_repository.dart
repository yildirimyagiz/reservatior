import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ExtraCharge operations
/// Provides CRUD operations with proper error handling and type safety
class ExtraChargeRepository {
  final DioClient _dioClient;

  ExtraChargeRepository(this._dioClient);

  /// Get ExtraCharge by ID
  /// Returns [ExtraCharge] if found, throws [RepositoryException] otherwise
  Future<ExtraCharge> getExtraChargeById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/extra_charge/$id');
      if (response.statusCode == 200) {
        return ExtraCharge.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch extra_charge',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all extra_charges with pagination and filtering
  /// Returns list of [ExtraCharge] objects
  Future<List<ExtraCharge>> getextra_charges({
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
      
      final response = await _dioClient.get('/api/v1/extra_charge', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ExtraCharge.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch extra_charges',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ExtraCharge
  /// Returns created [ExtraCharge] object
  Future<ExtraCharge> createExtraCharge(ExtraCharge extraCharge) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/extra_charge',
        data: extraCharge.toJson(),
      );
      return ExtraCharge.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ExtraCharge
  Future<ExtraCharge> updateExtraCharge(String id, ExtraCharge extraCharge) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/extra_charge/$id',
        data: extraCharge.toJson(),
      );
      return ExtraCharge.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ExtraCharge
  Future<void> deleteExtraCharge(String id) async {
    try {
      await _dioClient.delete('/api/v1/extra_charge/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
