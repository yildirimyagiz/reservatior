import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for RentArrears operations
/// Provides CRUD operations with proper error handling and type safety
class RentArrearsRepository {
  final DioClient _dioClient;

  RentArrearsRepository(this._dioClient);

  /// Get RentArrears by ID
  /// Returns [RentArrears] if found, throws [RepositoryException] otherwise
  Future<RentArrears> getRentArrearsById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/rent_arrears/$id');
      if (response.statusCode == 200) {
        return RentArrears.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch rent_arrears',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all rent_arrearses with pagination and filtering
  /// Returns list of [RentArrears] objects
  Future<List<RentArrears>> getrent_arrearses({
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
      
      final response = await _dioClient.get('/api/v1/rent_arrears', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => RentArrears.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch rent_arrearses',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new RentArrears
  /// Returns created [RentArrears] object
  Future<RentArrears> createRentArrears(RentArrears rentArrears) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/rent_arrears',
        data: rentArrears.toJson(),
      );
      return RentArrears.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RentArrears
  Future<RentArrears> updateRentArrears(String id, RentArrears rentArrears) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/rent_arrears/$id',
        data: rentArrears.toJson(),
      );
      return RentArrears.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RentArrears
  Future<void> deleteRentArrears(String id) async {
    try {
      await _dioClient.delete('/api/v1/rent_arrears/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
