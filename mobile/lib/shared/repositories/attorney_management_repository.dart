import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AttorneyManagement operations
/// Provides CRUD operations with proper error handling and type safety
class AttorneyManagementRepository {
  final DioClient _dioClient;

  AttorneyManagementRepository(this._dioClient);

  /// Get AttorneyManagement by ID
  /// Returns [AttorneyManagement] if found, throws [RepositoryException] otherwise
  Future<AttorneyManagement> getAttorneyManagementById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/attorney_management/$id');
      if (response.statusCode == 200) {
        return AttorneyManagement.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch attorney_management',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all attorney_managements with pagination and filtering
  /// Returns list of [AttorneyManagement] objects
  Future<List<AttorneyManagement>> getattorney_managements({
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
      
      final response = await _dioClient.get('/api/v1/attorney_management', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AttorneyManagement.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch attorney_managements',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AttorneyManagement
  /// Returns created [AttorneyManagement] object
  Future<AttorneyManagement> createAttorneyManagement(AttorneyManagement attorneyManagement) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/attorney_management',
        data: attorneyManagement.toJson(),
      );
      return AttorneyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AttorneyManagement
  Future<AttorneyManagement> updateAttorneyManagement(String id, AttorneyManagement attorneyManagement) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/attorney_management/$id',
        data: attorneyManagement.toJson(),
      );
      return AttorneyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AttorneyManagement
  Future<void> deleteAttorneyManagement(String id) async {
    try {
      await _dioClient.delete('/api/v1/attorney_management/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
