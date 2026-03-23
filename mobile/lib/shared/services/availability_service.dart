import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AvailabilityService {
  final DioClient _dioClient;

  AvailabilityService(this._dioClient);

  // Get Availability by ID
  Future<Availability> getAvailabilityById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/availability/$id');
      return Availability.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all availabilitys
  Future<List<Availability>> getAvailabilitys({
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

      final response = await _dioClient.get('/api/v1/availability', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Availability.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Availability
  Future<Availability> createAvailability(Availability availability) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/availability',
        data: availability.toJson(),
      );
      return Availability.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Availability
  Future<Availability> updateAvailability(String id, Availability availability) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/availability/$id',
        data: availability.toJson(),
      );
      return Availability.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Availability
  Future<void> deleteAvailability(String id) async {
    try {
      await _dioClient.delete('/api/v1/availability/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
