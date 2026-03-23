import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class VacationRentalService {
  final DioClient _dioClient;

  VacationRentalService(this._dioClient);

  // Get VacationRental by ID
  Future<VacationRental> getVacationRentalById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/vacation_rental/$id');
      return VacationRental.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all vacation_rentals
  Future<List<VacationRental>> getVacationRentals({
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

      final response = await _dioClient.get('/api/v1/vacation_rental', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => VacationRental.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create VacationRental
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
    return Exception('API Error: ${e.message}');
  }
}
