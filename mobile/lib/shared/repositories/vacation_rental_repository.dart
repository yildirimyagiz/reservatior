import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for VacationRental operations
/// Provides CRUD operations with proper error handling and type safety
class VacationRentalRepository {
  final DioClient _dioClient;

  VacationRentalRepository(this._dioClient);

  /// Get VacationRental by ID
  /// Returns [VacationRental] if found, throws [RepositoryException] otherwise
  Future<VacationRental> getVacationRentalById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/vacation_rental/$id');
      if (response.statusCode == 200) {
        return VacationRental.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch vacation_rental',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all vacation_rentals with pagination and filtering
  /// Returns list of [VacationRental] objects
  Future<List<VacationRental>> getvacation_rentals({
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
      
      final response = await _dioClient.get('/api/v1/vacation_rental', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => VacationRental.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch vacation_rentals',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new VacationRental
  /// Returns created [VacationRental] object
  Future<VacationRental> createVacationRental(VacationRental vacationRental) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/vacation_rental',
        data: vacationRental.toJson(),
      );
      return VacationRental.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update VacationRental
  Future<VacationRental> updateVacationRental(String id, VacationRental vacationRental) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/vacation_rental/$id',
        data: vacationRental.toJson(),
      );
      return VacationRental.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete VacationRental
  Future<void> deleteVacationRental(String id) async {
    try {
      await _dioClient.delete('/api/v1/vacation_rental/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
