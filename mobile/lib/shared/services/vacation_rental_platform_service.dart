import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class VacationRentalPlatformService {
  final DioClient _dioClient;

  VacationRentalPlatformService(this._dioClient);

  // Get VacationRentalPlatform by ID
  Future<VacationRentalPlatform> getVacationRentalPlatformById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/vacation_rental_platform/$id');
      return VacationRentalPlatform.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all vacation_rental_platforms
  Future<List<VacationRentalPlatform>> getVacationRentalPlatforms({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/vacation_rental_platform', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => VacationRentalPlatform.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create VacationRentalPlatform
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
    return Exception('API Error: ${e.message}');
  }
}
