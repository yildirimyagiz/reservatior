import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for VacationRentalPlatform operations
/// Provides CRUD operations with proper error handling and type safety
class VacationRentalPlatformRepository {
  final DioClient _dioClient;

  VacationRentalPlatformRepository(this._dioClient);

  /// Get VacationRentalPlatform by ID
  /// Returns [VacationRentalPlatform] if found, throws [RepositoryException] otherwise
  Future<VacationRentalPlatform> getVacationRentalPlatformById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/vacation_rental_platform/$id');
      if (response.statusCode == 200) {
        return VacationRentalPlatform.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch vacation_rental_platform',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all vacation_rental_platforms with pagination and filtering
  /// Returns list of [VacationRentalPlatform] objects
  Future<List<VacationRentalPlatform>> getvacation_rental_platforms({
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
      
      final response = await _dioClient.get('/api/v1/vacation_rental_platform', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => VacationRentalPlatform.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch vacation_rental_platforms',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new VacationRentalPlatform
  /// Returns created [VacationRentalPlatform] object
  Future<VacationRentalPlatform> createVacationRentalPlatform(VacationRentalPlatform vacationRentalPlatform) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/vacation_rental_platform',
        data: vacationRentalPlatform.toJson(),
      );
      return VacationRentalPlatform.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update VacationRentalPlatform
  Future<VacationRentalPlatform> updateVacationRentalPlatform(String id, VacationRentalPlatform vacationRentalPlatform) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/vacation_rental_platform/$id',
        data: vacationRentalPlatform.toJson(),
      );
      return VacationRentalPlatform.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete VacationRentalPlatform
  Future<void> deleteVacationRentalPlatform(String id) async {
    try {
      await _dioClient.delete('/api/v1/vacation_rental_platform/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
