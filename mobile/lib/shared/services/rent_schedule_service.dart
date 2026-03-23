import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class RentScheduleService {
  final DioClient _dioClient;

  RentScheduleService(this._dioClient);

  // Get RentSchedule by ID
  Future<RentSchedule> getRentScheduleById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/rent_schedule/$id');
      return RentSchedule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all rent_schedules
  Future<List<RentSchedule>> getRentSchedules({
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

      final response = await _dioClient.get('/api/v1/rent_schedule', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => RentSchedule.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create RentSchedule
  Future<RentSchedule> createRentSchedule(RentSchedule rentSchedule) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/rent_schedule',
        data: rentSchedule.toJson(),
      );
      return RentSchedule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RentSchedule
  Future<RentSchedule> updateRentSchedule(String id, RentSchedule rentSchedule) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/rent_schedule/$id',
        data: rentSchedule.toJson(),
      );
      return RentSchedule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RentSchedule
  Future<void> deleteRentSchedule(String id) async {
    try {
      await _dioClient.delete('/api/v1/rent_schedule/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
