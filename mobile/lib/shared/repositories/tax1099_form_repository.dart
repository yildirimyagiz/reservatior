import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Tax1099Form operations
/// Provides CRUD operations with proper error handling and type safety
class Tax1099FormRepository {
  final DioClient _dioClient;

  Tax1099FormRepository(this._dioClient);

  /// Get Tax1099Form by ID
  /// Returns [Tax1099Form] if found, throws [RepositoryException] otherwise
  Future<Tax1099Form> getTax1099FormById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tax1099_form/$id');
      if (response.statusCode == 200) {
        return Tax1099Form.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tax1099_form',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all tax1099_forms with pagination and filtering
  /// Returns list of [Tax1099Form] objects
  Future<List<Tax1099Form>> gettax1099_forms({
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
      
      final response = await _dioClient.get('/api/v1/tax1099_form', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Tax1099Form.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tax1099_forms',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Tax1099Form
  /// Returns created [Tax1099Form] object
  Future<Tax1099Form> createTax1099Form(Tax1099Form tax1099Form) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/tax1099_form',
        data: tax1099Form.toJson(),
      );
      return Tax1099Form.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Tax1099Form
  Future<Tax1099Form> updateTax1099Form(String id, Tax1099Form tax1099Form) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/tax1099_form/$id',
        data: tax1099Form.toJson(),
      );
      return Tax1099Form.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Tax1099Form
  Future<void> deleteTax1099Form(String id) async {
    try {
      await _dioClient.delete('/api/v1/tax1099_form/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
