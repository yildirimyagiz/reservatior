import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Mortgage operations
/// Provides CRUD operations with proper error handling and type safety
class MortgageRepository {
  final DioClient _dioClient;

  MortgageRepository(this._dioClient);

  /// Get Mortgage by ID
  /// Returns [Mortgage] if found, throws [RepositoryException] otherwise
  Future<Mortgage> getMortgageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mortgage/$id');
      if (response.statusCode == 200) {
        return Mortgage.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch mortgage',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all mortgages with pagination and filtering
  /// Returns list of [Mortgage] objects
  Future<List<Mortgage>> getmortgages({
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
      
      final response = await _dioClient.get('/api/v1/mortgage', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Mortgage.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch mortgages',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Mortgage
  /// Returns created [Mortgage] object
  Future<Mortgage> createMortgage(Mortgage mortgage) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mortgage',
        data: mortgage.toJson(),
      );
      return Mortgage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Mortgage
  Future<Mortgage> updateMortgage(String id, Mortgage mortgage) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mortgage/$id',
        data: mortgage.toJson(),
      );
      return Mortgage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Mortgage
  Future<void> deleteMortgage(String id) async {
    try {
      await _dioClient.delete('/api/v1/mortgage/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
