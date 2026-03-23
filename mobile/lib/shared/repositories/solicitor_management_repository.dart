import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for SolicitorManagement operations
/// Provides CRUD operations with proper error handling and type safety
class SolicitorManagementRepository {
  final DioClient _dioClient;

  SolicitorManagementRepository(this._dioClient);

  /// Get SolicitorManagement by ID
  /// Returns [SolicitorManagement] if found, throws [RepositoryException] otherwise
  Future<SolicitorManagement> getSolicitorManagementById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/solicitor_management/$id');
      if (response.statusCode == 200) {
        return SolicitorManagement.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch solicitor_management',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all solicitor_managements with pagination and filtering
  /// Returns list of [SolicitorManagement] objects
  Future<List<SolicitorManagement>> getsolicitor_managements({
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
      
      final response = await _dioClient.get('/api/v1/solicitor_management', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => SolicitorManagement.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch solicitor_managements',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new SolicitorManagement
  /// Returns created [SolicitorManagement] object
  Future<SolicitorManagement> createSolicitorManagement(SolicitorManagement solicitorManagement) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/solicitor_management',
        data: solicitorManagement.toJson(),
      );
      return SolicitorManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SolicitorManagement
  Future<SolicitorManagement> updateSolicitorManagement(String id, SolicitorManagement solicitorManagement) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/solicitor_management/$id',
        data: solicitorManagement.toJson(),
      );
      return SolicitorManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SolicitorManagement
  Future<void> deleteSolicitorManagement(String id) async {
    try {
      await _dioClient.delete('/api/v1/solicitor_management/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
