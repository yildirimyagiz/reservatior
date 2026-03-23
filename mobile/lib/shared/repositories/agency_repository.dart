import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Agency operations
/// Provides CRUD operations with proper error handling and type safety
class AgencyRepository {
  final DioClient _dioClient;

  AgencyRepository(this._dioClient);

  /// Get Agency by ID
  /// Returns [Agency] if found, throws [RepositoryException] otherwise
  Future<Agency> getAgencyById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agency/$id');
      if (response.statusCode == 200) {
        return Agency.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch agency',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all agencies with pagination and filtering
  /// Returns list of [Agency] objects
  Future<List<Agency>> getagencies({
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
      
      final response = await _dioClient.get('/api/v1/agency', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Agency.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch agencies',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Agency
  /// Returns created [Agency] object
  Future<Agency> createAgency(Agency agency) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/agency',
        data: agency.toJson(),
      );
      return Agency.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Agency
  Future<Agency> updateAgency(String id, Agency agency) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/agency/$id',
        data: agency.toJson(),
      );
      return Agency.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Agency
  Future<void> deleteAgency(String id) async {
    try {
      await _dioClient.delete('/api/v1/agency/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
